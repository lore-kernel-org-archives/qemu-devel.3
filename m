Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3A0C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuPF-0008Vm-6G; Wed, 01 Jul 2026 08:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weuPB-0008VV-TC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:51:06 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weuP8-0007FO-Oa
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:51:05 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7E83D5966FB;
 Wed, 01 Jul 2026 14:50:58 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wn_2YVPF0-LV; Wed,  1 Jul 2026 14:50:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6F9E4596709; Wed, 01 Jul 2026 14:50:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6E165596704;
 Wed, 01 Jul 2026 14:50:56 +0200 (CEST)
Date: Wed, 1 Jul 2026 14:50:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Keith Monahan <keith@techtravels.org>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Helge Deller <deller@gmx.de>, Fam Zheng <fam@euphon.net>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine
In-Reply-To: <338c2683-095d-4eb6-b40d-761b79456528@techtravels.org>
Message-ID: <b4388c70-d4b3-7661-36c0-e275a42c391b@eik.bme.hu>
References: <20260701031803.1817812-1-keith@techtravels.org>
 <20260701031803.1817812-3-keith@techtravels.org>
 <CAFEAcA-nmkUPtJgb9---_6eBFNdU5_-EndQibQOXEBn_ifUSmA@mail.gmail.com>
 <338c2683-095d-4eb6-b40d-761b79456528@techtravels.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 1 Jul 2026, Keith Monahan wrote:
> On 7/1/2026 6:17 AM, Peter Maydell wrote:
>
>> This is way too much change to be reviewable as a single
>> patch, I'm afraid. Can you break it down into meaningful
>> pieces, please?
>
> Thanks for taking a look at this. I'm brand new to this process, so please 
> bear with me, as my questions come from not understanding more than any type 
> of disagreement.
>
> My thoughts are to break it down like this: keep the lasi.c IRR fix patch 1 
> by itself as is, and then further decompose patch 2 into:
>
> * Glue cleanup (lasi_ncr710.c/h): remove dead scaffolding.
> * Base engine rewrite + trace-events
> * HP-UX overlapped tag support
> * ATN-state HP-UX/Netbsd handling
>
> This should help reduce the overall cognitive load in the review process.
>
> However, this still leaves the new 2k lines code in ncr53c710.c, the base 
> engine. Because this is a complete rewrite from scratch (using existing 
> lsi53c895.c as the base), you can't/shouldn't really diff the original to 
> mine. I tried it, fwiw, and the results aren't pretty.

Would it be possible to reorganise the existing lsi53c895.c to split the 
engine you want to reuse in a separate object or module or file so it can 
be shared without duplicating it? Then the changes to ncr53c710.c should 
be less as it would just use the parts that were split off and not copy 
and modify them. If that's possible it would also be better as the shared 
parts would not be duplicated so both device models could benefit from it 
but I understand that needs knowledge about 53c859 and testing that too so 
it's more work but may be the preferred way to go.

Regards,
BALATON Zoltan

> Any further decomposition of the engine you'd end up with non-building 
> intermediate states that don't really work by themselves.
>
> Another point is that I haven't done extensive mid-point testing to know what 
> deploying half the solution might do. For instance, you MIGHT be able to get 
> Linux and NetBSD to boot and/or install without the HP-UX support and 
> disambiguation patches, but I'm not sure.
>
> Does my breakdown make sense?
>
> Thanks,
> Keith M
>
>
>


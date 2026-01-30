Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD908E6BF10
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 21:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlwDu-0007TZ-8d; Fri, 30 Jan 2026 16:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlwDt-0007T5-65; Fri, 30 Jan 2026 16:40:13 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlwDq-0001t5-RE; Fri, 30 Jan 2026 16:40:12 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A7F73596A0A;
 Fri, 30 Jan 2026 22:40:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ycRjXAJzDHHe; Fri, 30 Jan 2026 22:40:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9CC175969F2; Fri, 30 Jan 2026 22:40:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9B51F5969F6;
 Fri, 30 Jan 2026 22:40:05 +0100 (CET)
Date: Fri, 30 Jan 2026 22:40:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v5 11/12] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <DG255L1QLG9F.K2BWVSSGYRHG@jablonski.xyz>
Message-ID: <5c4b7cd5-2467-4c1d-9bc7-23c7d9140f61@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-12-chad@jablonski.xyz>
 <3d1cf407-dd57-edff-25fe-1dd56c1b5052@eik.bme.hu>
 <DG255L1QLG9F.K2BWVSSGYRHG@jablonski.xyz>
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

On Fri, 30 Jan 2026, Chad Jablonski wrote:
>>> +static void ati_host_data_reset(ATIHostDataState *hd)
>>> +{
>>> +    hd->next = 0;
>>> +    hd->row = 0;
>>> +    hd->col = 0;
>>> +}
>>
>> I wonder where the real chip keeps track of these. Isn't this where the
>> dst_x dst_y would be updated? Or it may have some internal state not
>> exposed as registers? Maybe if you can dump registers you could compare
>> their values during blits after each host data reg write and check how
>> they change to reveal if any of them are updated? (But only if you're
>> curious; it would do for emulation using this approach with a separate
>> state as well.)
>
> So far it's looking to me like this is internal state not exposed
> through the registers. I do see one register that increments after every
> host_data* write but it's in the PM4/CCE range (0x07e8) and is completely
> undocumented. It _is_ a bit surprising to see changes in that range given CCE
> is disabled. But nothing really obvious or conclusive yet, unfortunately.

OK thanks for checking. The M6 Register reference says 0x7ec is reserved 
for future debug so it could be the one before is also some kind of debug 
register but it's not documented so no idea just guessing.

So you also verified that not only host data but normal rectangular blits 
don't update dst and src position either? Then don't know why it comes up 
in documentation.

Regards,
BALATON Zoltan


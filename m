Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4688CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viEVb-0006Zz-BG; Tue, 20 Jan 2026 11:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viEVZ-0006Xv-GE; Tue, 20 Jan 2026 11:23:09 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viEVX-0000ws-Ql; Tue, 20 Jan 2026 11:23:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BB21E5969E4;
 Tue, 20 Jan 2026 17:23:02 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uwa3tjWUjY1A; Tue, 20 Jan 2026 17:23:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BAED1596A03; Tue, 20 Jan 2026 17:23:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B97BC596A07;
 Tue, 20 Jan 2026 17:23:00 +0100 (CET)
Date: Tue, 20 Jan 2026 17:23:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v5 08/12] ati-vga: Consolidate set dirty and dst update
In-Reply-To: <DFTJ3349306M.92OK2QAQPN6I@jablonski.xyz>
Message-ID: <b9b0ffc1-ec5f-a4ec-0ef9-73fa36c0b3d8@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-9-chad@jablonski.xyz>
 <DFTJ3349306M.92OK2QAQPN6I@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 20 Jan 2026, Chad Jablonski wrote:
>> I plan to validate the above Radeon behavior in the future but I don't
>> have the best test environment set up for that card at the moment.
>> Zoltan if you've seen the dst_x behavior is required then we can modify
>> this but otherwise it felt safe to me to follow the docs for now.
>
> Just an update on Radeon (R100) behavior. I've confirmed in my testing that it
> also does _not_ update dst_x and dst_y after vram and host data sourced blits.
> This contradicts the m6 register guide.

Interesting. I think I've added the update because I've found that some 
guest needed that but I don't remember which. I mostly tested with MorphOS 
and Linux. But it could be I've seen it in the docs and that's why I 
implemented it, I don't remember. If it does not break MorphOS it could be 
removed to match what hardware seem to do. I think most drivers will set 
these on every blit anyway.

Regards,
BALATON Zoltan


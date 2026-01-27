Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A57D2F003
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhMY-0005Fc-8i; Tue, 27 Jan 2026 06:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkhMW-0005Em-3Z; Tue, 27 Jan 2026 06:36:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkhMU-0003DA-6D; Tue, 27 Jan 2026 06:35:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F8B6596ABE;
 Tue, 27 Jan 2026 12:35:54 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id XbndeIJXoUAN; Tue, 27 Jan 2026 12:35:52 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C39C596A0D; Tue, 27 Jan 2026 12:35:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7ABEA596A38;
 Tue, 27 Jan 2026 12:35:52 +0100 (CET)
Date: Tue, 27 Jan 2026 12:35:52 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v5 10/12] ati-vga: Implement scissor rectangle clipping
 for 2D operations
In-Reply-To: <DFZ0R1EMPYIZ.1323WYF0N6LIZ@jablonski.xyz>
Message-ID: <162a938b-e78a-16e2-3dba-982f37070898@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-11-chad@jablonski.xyz>
 <9fd1e0dd-a8e1-6548-d62b-cac163e621ce@eik.bme.hu>
 <DFZ0R1EMPYIZ.1323WYF0N6LIZ@jablonski.xyz>
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

On Mon, 26 Jan 2026, Chad Jablonski wrote:
>> Is there a bit somewhere that enables clipping that needs to be checked
>> here? Or are the sc regs always expected to have meaningful values and
>> clipping is always done?
>>
>
> There isn't an enable bit for the primary scissor registers. There are however
> enable bits for the aux clipping registers in AUX_SC_CNTL. In fact the xorg
> r128 driver when initialized sets AUX_SC_CNTL to 0x0 (all aux clipping
> disabled) just before also setting DEFAULT_SC_BOTTOM_RIGHT and SC_BOTTOM_RIGHT
> to their max values.
>
> We will need to handle the aux clipping eventually but this patch only
> implements the primary clipping registers.

OK we don't need to care about aux scissors until we find something that 
needs it. I was just wondering if SC_* is always applied. There are some 
bits in DP_GUI_MASTER_CNTL for GMC_SRC_CLIPPING and GMC_DST_CLIPPING but 
those seem to only control using default values instead of normal 
registers (or rather reset from defaults as you've found).

Regards,
BALATON Zoltan

>>> +    if (!vis_dst.height || !vis_dst.width) {
>>> +        /* Nothing to do, completely clipped */
>>
>> It's less clear what vis means so maybe this comment could clarify by
>> saying Nothing is visible, completely clipped.
>>
>
> I'll make this more clear!
>
>


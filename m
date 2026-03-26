Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A586610A88C4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mSt-00082u-4E; Thu, 26 Mar 2026 11:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w5mSr-00082l-Bk
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:17:41 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w5mSp-00042Y-G3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:17:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 31D9B596AC8;
 Thu, 26 Mar 2026 16:17:35 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id nUpnhWZpDFEJ; Thu, 26 Mar 2026 16:17:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2E574596ABD; Thu, 26 Mar 2026 16:17:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C96F596AC6;
 Thu, 26 Mar 2026 16:17:33 +0100 (CET)
Date: Thu, 26 Mar 2026 16:17:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga
 device
In-Reply-To: <CAFEAcA_VoSX2JK-HRpAN0P0LT2dj_WvSRyP2dom3ZQK76mtyfA@mail.gmail.com>
Message-ID: <67ae08fb-adc1-755b-a73b-789cd3e43049@eik.bme.hu>
References: <20260326113457.159065-1-thuth@redhat.com>
 <CAFEAcA-xWtr=Xgst=MOVcm+TxegSvNVXmDP_RDVDOvJJW76Qeg@mail.gmail.com>
 <f6045fed-60fb-47b8-8241-a6fcb0af7292@redhat.com>
 <CAFEAcA_VoSX2JK-HRpAN0P0LT2dj_WvSRyP2dom3ZQK76mtyfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 26 Mar 2026, Peter Maydell wrote:
> On Thu, 26 Mar 2026 at 12:04, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 26/03/2026 12.59, Peter Maydell wrote:
>>> On Thu, 26 Mar 2026 at 11:35, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> QEMU currently crashes when migrating a guest that uses the
>>>> isa-vga device as display. This happens because vga_isa_class_initfn()
>>>> registers a vmsd for vmstate_vga_common that operates on VGACommonState.
>>>> But the isa-vga device is derived from ISADevice, not from VGACommonState,
>>>> so the migration code tries to fill in the data for VGACommonState to
>>>> the memory that is a ISADevice instead, which is of cause causing trouble.
>>>>
>>>> We need an indirection here as it's also e.g. done in vga-pci.c, so
>>>> that the migration data gets filled into the right location.
>>>>
>>>> While we're at it, also drop the "global_vmstate = true" here. Since
>>>> migration was broken for this device during the last 15 years (!) anyway,
>>>> we don't have to worry about maintaining backward compatibility with this
>>>> switch for older versions of QEMU anymore.
>>>
>>> That means the only remaining users of global_vmstate = true are:
>>>   * TYPE_VGA_MMIO : used only by the MIPS Jazz board, which is not
>>>     versioned, so we are OK with migration compat breaks
>>>   * TYPE_ISA_CIRRUS_VGA
>>>
>>> I don't suppose that migration is also currently broken for Cirrus ? :-)
>>
>> No, Cirrus seems to be fine. But I think we should likely do something like
>> commit 1fcfdc435a3e25ab9037f6f7b8ab for the isa-cirrus-vga device, too, so
>> we can at least get rid of this in a couple of years...
>
> If we're going to do that it would be nice to get that in for 11.0.
>
> I do notice that the Cirrus devices have their own vmstate handle
> saving and restoring all the common VGA state, instead of using
> vmstate_vga_common, and they miss out all the vbe entries at
> the bottom...

That might be OK as cirrus-vga does not seem to support Bochs DISPI VBE 
ports so there should be nothing there to save/restore.

Regards,
BALATON Zoltan


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D497CC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 17:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlu0V-00087r-64; Sun, 17 Mar 2024 13:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rlu0T-00087Z-CR; Sun, 17 Mar 2024 13:09:09 -0400
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rlu0R-00012E-G7; Sun, 17 Mar 2024 13:09:09 -0400
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
 by mailout10.t-online.de (Postfix) with SMTP id AFD7C2B06C;
 Sun, 17 Mar 2024 18:09:01 +0100 (CET)
Received: from [192.168.211.200] ([79.208.24.6]) by fwd87.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rlu0J-0Vvb5F0; Sun, 17 Mar 2024 18:08:59 +0100
Message-ID: <72b4ec08-8943-4d47-9cd1-332536ee630f@t-online.de>
Date: Sun, 17 Mar 2024 18:08:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH] usb-audio: Fix invalid values in AudioControl descriptors
To: Joonas Kankaala <joonas.a.kankaala@gmail.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org
References: <20240309172932.288940-1-joonas.a.kankaala@gmail.com>
Content-Language: en-US
In-Reply-To: <20240309172932.288940-1-joonas.a.kankaala@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1710695339-94855968-046F08AE/0/0 CLEAN NORMAL
X-TOI-MSGID: 76f78163-9b7a-4c7c-9203-d1a393d2d1c7
Received-SPF: pass client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 09.03.24 um 18:29 schrieb Joonas Kankaala:
> This fixes the invalid bInterfaceProtocol value 0x04 in the USB audio
> AudioControl descriptors. It should be zero. While Linux and Windows
> forgive this error, macOS 14 Sonoma does not. The usb-audio device does
> not appear in macOS sound settings even though the device is recognized
> and shows up in USB system information. According to the USB audio class
> specs 1.0-4.0, valid values are 0x00, 0x20, 0x30 and 0x40. (Note also
> that Linux prints the warning "unknown interface protocol 0x4, assuming
> v1", but then proceeds as if the value was zero.)
>
> This also fixes the invalid wTotalLength value in the multi-channel
> setup AudioControl interface header descriptor (used when multi=on
> and out.mixing-engine off). The combined length of all the descriptors
> there add up to 0x37, not 0x38. In Linux, "lsusb -D ..." displays
> incomplete descriptor information when this length is incorrect.
>
> Signed-off-by: Joonas Kankaala <joonas.a.kankaala@gmail.com>

lsusb also misinterprets the invalid interface protocol 0x4 and uses
0x30 instead.

Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>

> ---
>  hw/usb/dev-audio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> index d5ac1f8962..1897fff9e6 100644
> --- a/hw/usb/dev-audio.c
> +++ b/hw/usb/dev-audio.c
> @@ -124,7 +124,6 @@ static const USBDescIface desc_iface[] = {
>          .bNumEndpoints                 = 0,
>          .bInterfaceClass               = USB_CLASS_AUDIO,
>          .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_CONTROL,
> -        .bInterfaceProtocol            = 0x04,
>          .iInterface                    = STRING_USBAUDIO_CONTROL,
>          .ndesc                         = 4,
>          .descs = (USBDescOther[]) {
> @@ -282,7 +281,6 @@ static const USBDescIface desc_iface_multi[] = {
>          .bNumEndpoints                 = 0,
>          .bInterfaceClass               = USB_CLASS_AUDIO,
>          .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_CONTROL,
> -        .bInterfaceProtocol            = 0x04,
>          .iInterface                    = STRING_USBAUDIO_CONTROL,
>          .ndesc                         = 4,
>          .descs = (USBDescOther[]) {
> @@ -293,7 +291,7 @@ static const USBDescIface desc_iface_multi[] = {
>                      USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
>                      DST_AC_HEADER,              /*  u8  bDescriptorSubtype */
>                      U16(0x0100),                /* u16  bcdADC */
> -                    U16(0x38),                  /* u16  wTotalLength */
> +                    U16(0x37),                  /* u16  wTotalLength */
>                      0x01,                       /*  u8  bInCollection */
>                      0x01,                       /*  u8  baInterfaceNr */
>                  }



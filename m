Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673D2C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trayS-000108-TQ; Mon, 10 Mar 2025 07:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trayG-0000xu-G0
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:06:57 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trayD-0008QP-JY
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:06:56 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so2970565276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741604810; x=1742209610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6mQmd6Njjt2p1jxk5g9NsE0d0ki07qN+wzTeEd4ugg=;
 b=GzaWwJHMAFBnGug6CZxjD6Hf3kmSiPHdB9myzlNHo/vA0qc5uSLDgM/D/e/8pyRy7F
 Ww/QEqVnoUkhT/bBSUGHJTtP31b37TokzvtZibwqYpBWYjpB/8lv/ILIqYO1V8QuqgJe
 AoK1N1s380Ar6oRSw4FSkLLh1OyIgeE7kir9MmCoP7fUDhhqcrNNnuHI8XbwASMB1GKt
 DbrvUM9v+holpL/Rx2+T0x2ApimJUipnzx7uVsWvLX+AnDS8J7FpGMQXViiCdPagUiHB
 udsr3xERUI7ROjEZFGCH2tFSJ5x0x6wY+UEUtUfABzZi1dMbtvPKVAHtQrBqEBMFUqv4
 pDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741604810; x=1742209610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6mQmd6Njjt2p1jxk5g9NsE0d0ki07qN+wzTeEd4ugg=;
 b=H+6CwY2FN2RO86WxY3LNvifmbFbmlNU/21kWr5hpKZwYYE4kEdpyIbAFRZcQG22nFF
 URdyXMboJlg5wiCvx2lf3HHnFV3VuM/evIrfFuwK5Dl+BL74O6W/LN4vxa3Kcvwja3w3
 wjnK+zeY2b0dCj804FMo1nk5/Q0zleBWRpmH3lnlvkJlbt2hHOevRFj4Uv6vTqvSEb2I
 C0vwa5HT12Vgq2CGa/ce5T2fmCMeNUuzT7RzEcxrRHIPaBLnpzgYbrjxkWlueXHdKEGE
 ksQKk/wercKLmZIApntjRlOuTKaZumkJl6hafVas150nrWeI90RoWRNxVbCjNPb9YBys
 rRhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhxxTtJ7R3ZKpnRiI1+i6RxIuWQUGh0YRGLu3ubx4MRQNI6s2if7yhadRsQKVMWfUyflWK7spyCGSX@nongnu.org
X-Gm-Message-State: AOJu0YyxiOLnAoH9pRecOff2pL6IIFfSoPfAejJD5oCQwdw1ysFrQbJo
 R9DW+LICXNjOIbVufs+f/0SXRQRGwhd84xBKTUwfKAZDS30OUB6bDz0u4RLLkw+pqq5OOZ5Cfty
 XVngAOt7L1DctG8IlYfgLPm0jTAF2zAnuhrjLcQ==
X-Gm-Gg: ASbGnctG2nymllPWaynXTWYP8TnvbWXu4nW8OfHIQ1dC3cEEdnfJ8VrecTi/V8okfm3
 0YpXK0XCkZWcFFOReU2owliR39MmTxqDXWz2Y/zFDZ2h/kecPJEs4STQDHxK4hMy+1946kOmH0c
 ezkqxd+s9NHpuKQ1YCukyzy9YvbBs=
X-Google-Smtp-Source: AGHT+IGnYBIYtRdN0rXZlLlka6GZsJM0T0TkpI4vozVniqsHTf86S/CAYYbwf8hNL3b7NdPAZ3QcYrRD70WWDpSFqhg=
X-Received: by 2002:a05:6902:1886:b0:e5d:b88a:5536 with SMTP id
 3f1490d57ef6-e635c1f9fb3mr16200610276.44.1741604810304; Mon, 10 Mar 2025
 04:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
 <20250228174802.1945417-3-peter.maydell@linaro.org>
 <f4262519-017d-4ed7-8c17-5d4d72a219a6@linaro.org>
In-Reply-To: <f4262519-017d-4ed7-8c17-5d4d72a219a6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 11:06:38 +0000
X-Gm-Features: AQ5f1JowbqcIWeYiHaUbzMJc59rQGzmFNqDmmWjPgHGKu3KiEmwo_SjiT1OlBQw
Message-ID: <CAFEAcA9vw-Qgt4MBd=g-RTC1joHsHYBmtASHpL=SBnBjoW0nWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/net/smc91c111: Sanitize packet length on tx
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 9 Mar 2025 at 19:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
> On 28/2/25 18:48, Peter Maydell wrote:
> > --- a/hw/net/smc91c111.c
> > +++ b/hw/net/smc91c111.c
> > @@ -22,6 +22,13 @@
> >
> >   /* Number of 2k memory pages available.  */
> >   #define NUM_PACKETS 4
> > +/*
> > + * Maximum size of a data frame, including the leading status word
> > + * and byte count fields and the trailing CRC, last data byte
> > + * and control byte (per figure 8-1 in the Microchip Technology
>
> If control byte is included, ...
>
> > + * LAN91C111 datasheet).
> > + */
> > +#define MAX_PACKET_SIZE 2048
> >
> >   #define TYPE_SMC91C111 "smc91c111"
> >   OBJECT_DECLARE_SIMPLE_TYPE(smc91c111_state, SMC91C111)
> > @@ -240,6 +247,16 @@ static void smc91c111_release_packet(smc91c111_sta=
te *s, int packet)
> >       smc91c111_flush_queued_packets(s);
> >   }
> >
> > +static void smc91c111_complete_tx_packet(smc91c111_state *s, int packe=
tnum)
> > +{
> > +    if (s->ctr & CTR_AUTO_RELEASE) {
> > +        /* Race?  */
> > +        smc91c111_release_packet(s, packetnum);
> > +    } else if (s->tx_fifo_done_len < NUM_PACKETS) {
> > +        s->tx_fifo_done[s->tx_fifo_done_len++] =3D packetnum;
> > +    }
> > +}
> > +
> >   /* Flush the TX FIFO.  */
> >   static void smc91c111_do_tx(smc91c111_state *s)
> >   {
> > @@ -263,6 +280,17 @@ static void smc91c111_do_tx(smc91c111_state *s)
> >           *(p++) =3D 0x40;
> >           len =3D *(p++);
> >           len |=3D ((int)*(p++)) << 8;
> > +        if (len >=3D MAX_PACKET_SIZE) {
>
> isn't MAX_PACKET_SIZE valid? I'm not sure at all but I'd expect:
>
>             if (len > MAX_PACKET_SIZE) {

Yes, thanks, good catch. The max value in the byte count
field is 2048. We subtract 6, and then look at p[len + 1],
which will be p[2048 - 6 + 1] =3D p[2043], where the value of
p is data+4 (because we incremented it 4 times as we dealt
with the status and byte count fields).
So p[2043] is data[2047], which is the last in-bounds byte,
and a byte-count field of 2048 is not an overrun.

(Also, I just noticed that the data sheet says that for tx
frames the transmit byte count least significant bit will be
assumed 0 by the controller regardless of the value written
in memory. So we ought to zero out the LSB of 'len' after we
read it from the packet. That's not an overflow, though
(since we already subtracted 6 from len), just a bug...
Plus it looks like we don't handle the case of "odd-length
frame and CRC field present" right, since we don't do anything
about the last-data-byte being behind the CRC field. I think
that given the unimportance of this device model I'll settle
for just fixing the overruns and leave these other nominal
bugs alone.)

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A10EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmb5-0006PE-9f; Mon, 06 Jul 2026 12:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wgmax-0006N5-71
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:59 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wgmau-0002zV-NE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:58 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664d7863920so2510775d50.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783356895; cv=none;
 d=google.com; s=arc-20260327;
 b=MsN4L5DEuWyWSBLb9yAb4P8xPX4/QHOihK5g/VdTVAzovU84Cz+Uvvy09kcicr27dB
 jwqxjK/KIW/1T+3ptiLq7dL+bJPCDswHyXnFK/RkQwxA1Oet9Eo5Ra8UiHen0zwREzCM
 Lmyhfj+8n06H2DXcvPz+Sqg/JKbMcieP53ehTxqcFwOSbfCpRA0/0xRtOtzCCu3J59f3
 r3jQf6aj9QUHl7Xr5MYfz9MaxzytcWV7+ZUaCJhp8jLBSjYVugtKCQ+3NzHnX6L9sJOC
 XEXPhrZYLjMDaW1wWGjnb1vdew4y9Tz74fiN/J9Jk6I6TCyZxwASGuyrN05Jw1NXnHNA
 rDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w7gAOENDBDPo4Yn8gSfzizyDrJ8SqcYZd8BGWxgHac4=;
 fh=Hj6uv8y9pScMIq2JrMfop23xCTfT3pWPuZDoihMpXz4=;
 b=qUG1bCrrrN1nTpkXM6nO7bh2Iwv0cx+GAQ/wffwzF62l2n1I+s0lg1r4Fg/oIq8zgf
 LCKbRbhrFRfpGqwrrpkZ7iZdO8DrlxMDfYcxtlneJQ05YJRp61QnDaiglCgryyXpeQqr
 Wx6LlKT2MVA8DDsyE+A8/kWJnKhwZDisCSvbA3zY5/x62B3PKyEp2hxtQJC4myV25EEp
 9ozYHh/l08g6Z1JAERFLSzWiEqWy/DtaYPD02X+j8bjVHDW9q5F8T4Zu4EBkSKzHTvNT
 LdDBkG9CBvYNGEXq7kAIROVWq6NF43cHPz8/5UrapXwHEyJfIiYklMh8VLUudl7Z0r12
 l9pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783356895; x=1783961695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w7gAOENDBDPo4Yn8gSfzizyDrJ8SqcYZd8BGWxgHac4=;
 b=AqeZ6uMghPeFK+3/qoFTKaf1vIC0FyMM/CWm8Y0rxbYp0nj35F7qFZCmmmYwMJzRE8
 r8uxJu7IkQhZGGI5Yxvzu7Te+OLcHlEjhQn2RTaTziXpMagu9JYDtU3pN5+c4nC71EO7
 lVFuwUHn11hH4JZWXZRgnS2D/t9TwLnOXwwMSlTgAYA+sAl5MVJZJOWpVR0chlaeq6Te
 yXt16lHcTEMmTO0TPnOi7Lisk+XeK2NAv7kUvUnuEn8X5vHI/ZpnrSMsg3/eTMXY7pVK
 AX0uKhxel/Q0YpQhJbfy/QJZ23nT3jore3D1rgmwJKULWmf5828FexnjQjgIOFDFs8/M
 8/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783356895; x=1783961695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w7gAOENDBDPo4Yn8gSfzizyDrJ8SqcYZd8BGWxgHac4=;
 b=mon55Vp7RFuf2AeoZypS/KJ1owpobrkNLjIb5Ci1/BBsh5OnYmG7/PLI/n6J1ejzyG
 57X1wXF3RGeOrz/mVSwY2zjsHeIhK67ixU1TrEryn4bW7lnHO+jmc8fOjZE450oHL9DG
 ApOeFzqKpwT5Lhr8h5PppvqBcl7Y/q6/AlIcWfP3bO96ZruHK1NoyY1zkobr0p9sMEh5
 mkZaxyYE0r4FhCdPyqmLBtN8OD6eh0G7sD/RQEyP4DL+9cvEJIKkHtNs4JiX5abXUZxD
 /k8pPZDZUpcZlcW1xZkpe81Wur6H/WQy2Oea78mSmI1dpu84nYQCrzvJRyKuV23LV47i
 aumQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBbFFFnn832CM4+xPrLKdZa9CO0CH0LWuaZO1ra+xV7IT6j+aXn3/qRLctXMgZm4opE50GwFfaKhrV@nongnu.org
X-Gm-Message-State: AOJu0YwiAx2BN2jYy1H28WIObGjihcnd3DE2TVGj+eLX35YGsMs0Efil
 f1FOP4wy+EDsG3Bb6ohvJPSo0uwUezGVoPCdOgXK/lPLn6KqvHa5EYgGPxHb9KdS379vBpepRmd
 OKzP14xPi7CG/YCmRs1OyG0Kjm/6/NvdroyBfvio=
X-Gm-Gg: AfdE7cl9mYB6qZDtOMUTC8eC7dWOPbjPAqJ37V2iHMh5jQvYip8UMIsS85f9ydkWCB9
 bWXK9bxxxW4MKxNmiRDljXg5NcGlZAPUw5KpV8EiPyeO5UJ3QrqkohQKwNXitOeF1H2c1EHPybG
 lgTYvc7PEBJf0o0L3aeFP/S9++GkUnhOZ8KxW0UITbJ7pOMHFhg5hyAjtvKtmW8d3zMhDz2LkFn
 g5Bp3RkoKyB6t9rVNMbUg75c1zMnuvjDt4uPjRTCQPq0Hzu+YvhJbk8vwfFACTTdr2YzwZIGb8d
 JQ==
X-Received: by 2002:a05:690e:d85:b0:667:7633:2b0e with SMTP id
 956f58d0204a3-6677f7ca2bbmr1226686d50.0.1783356895038; Mon, 06 Jul 2026
 09:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <20260630135729.466264-2-bin.meng@processmission.com>
 <a8ed5d83-0cf5-4bf5-b6af-9cd9f2d1f9f4@oss.qualcomm.com>
In-Reply-To: <a8ed5d83-0cf5-4bf5-b6af-9cd9f2d1f9f4@oss.qualcomm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 7 Jul 2026 00:54:43 +0800
X-Gm-Features: AVVi8CfXPobH0YboXlI1tVG_faDij0mUohbOnFhAZGshVEuEXrnG1nnogx0lJS8
Message-ID: <CAEUhbmWhkMK9mkeOtD2T4sQ30N2fau1Tt3C1yeRf5rzHg63Nmw@mail.gmail.com>
Subject: Re: [PATCH 01/10] hw/block: m25p80: Fix dummy byte handling for
 Winbond flash
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

HI Philippe,

On Mon, Jul 6, 2026 at 3:50=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Bin,
>
> On 30/6/26 15:57, Bin Meng wrote:
> > The m25p80 model uses s->needed_bytes to track how many bytes a
> > controller must send after an opcode before the flash model can enter
> > the data phase. For address-bearing commands this includes the address
> > bytes. For fast-read commands it also includes the dummy phase.
> >
> > The tricky part is that flash datasheets describe the dummy phase in
> > clock cycles, while the QEMU SSI interface advances the flash model one
> > transferred byte at a time. The dummy clock count therefore has to be
> > converted to the number of SSI bytes that the controller will actually
> > emit.
> >
> > Some controllers have drivers that push these dummy bytes into a FIFO.
> > Other controllers are programmed with a dummy-cycle count and generate
> > the clocks themselves. The flash model still has to use the same byte
> > count that a FIFO-style controller or the Linux spi-mem layer would use=
,
> > otherwise the model waits too long and drops the first data bytes.
> >
> > Let's fix the inconsistency from the flash side first. We start from an
> > easy one, the Winbond flashes.
> >
> > Per the Windbond W25Q256JV datasheet [1] instrunction set table
>
> "instruction"
>
> > (chapter 8.1.2, 8.1.3, 8.1.4, 8.1.5), fix the wrong number of
> > dummy bytes needed for fast read commands.
> >
> > [1] https://www.winbond.com/resource-files/w25q256jv%20spi%20revb%20092=
02016.pdf
> >
> > Fixes: fe8477052831 ("m25p80: Fix QIOR/DIOR handling for Winbond")
> > Fixes: 3830c7a460b8 ("m25p80: Fix WINBOND fast read command handling")
> > Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> >   hw/block/m25p80.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> > index 4a4cda6602..59ecb32c0a 100644
> > --- a/hw/block/m25p80.c
> > +++ b/hw/block/m25p80.c
> > @@ -1004,7 +1004,7 @@ static void decode_fast_read_cmd(Flash *s)
> >           s->needed_bytes +=3D 1;
> >           break;
> >       case MAN_WINBOND:
> > -        s->needed_bytes +=3D 8;
> > +        s->needed_bytes +=3D 1;
>
> hw/block/m25p80.c-1224-    case FAST_READ:
> hw/block/m25p80.c-1225-    case FAST_READ4:
> hw/block/m25p80.c:1226:        decode_fast_read_cmd(s);
>
> This method is handling 2 distinct commands. Should we pass the
> address count by argument? (IIUC that alters the dummy clock count)
>

Per the datasheet, the only difference is 3-byte address vs. 4-byte
address. The number of dummy cycles are the same.

> >           break;
> >       case MAN_NUMONYX:
> >           s->needed_bytes +=3D numonyx_extract_cfg_num_dummies(s);
> > @@ -1099,7 +1099,7 @@ static void decode_qio_read_cmd(Flash *s)
> >       switch (get_man(s)) {
> >       case MAN_WINBOND:
> >           s->needed_bytes +=3D WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
> > -        s->needed_bytes +=3D 4;
> > +        s->needed_bytes +=3D 2;
>
> Ditto:
>
> hw/block/m25p80.c-1257-    case QIOR:
> hw/block/m25p80.c-1258-    case QIOR4:
>
> >           break;
> >       case MAN_SPANSION:
> >           s->needed_bytes +=3D SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
>

Regards,
Bin


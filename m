Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A489EE9B342
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0aI-0001Rg-Mu; Mon, 02 Mar 2026 05:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx0a5-0001O4-Dz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:33:00 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx0a3-00012U-Ui
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:32:53 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so3493148d50.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 02:32:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772447570; cv=none;
 d=google.com; s=arc-20240605;
 b=eaYRQplfyKH4TGiv9CLiXi0sR8Qj7vGQ2TJL6W1LHiqefVZT7HfJU8FGICkYfXfG8y
 x5o+3mOeyT/rR14ThegJgT+j0DBYw+/CbJxTOcZ60zSxFAyYy1i9QROtMg4LQfxwrXGk
 EM3/T8Q2YBYz8CH6sB5xCzpBvDGH8lapVhIpbA9hR9jADzvN+0oJG6DB8e1TiQgaImAa
 fsDTxnAkAT/r9owCAd6l+pNJKJr97+O/dOyEfraUEbQuZ5xi2kJuTpZRcfWVBGrGu7XR
 If2Ph7k1YwZNQK4lDpsK/SOWRp1INb2dAOCQ5CKfmh18NzM5Lt5C9kCV5cK2lre0kYOZ
 A5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+KWbMIZb7vgaoVeySsrF8TFJRCienpK7ZIh64IObNMk=;
 fh=lFfRfZMS5l19tUfRBeAH+newWRgxDnjitXMa7qqUehQ=;
 b=fDU0ak7mGrMj36pUopktaWcWVcDLgrGUFvwy1WW2Z9w5rqzMs3W394MivMOrsRW7q4
 iqXB2fipXTkHriNbKAwGCMh9hdffurIBZBAw8cvGwWFRB2wQD5zSkJdO6ai+2HlKrdyW
 HpFx0CEjJ72jFozoSwER6hBjyfk+siTivqaMXM4Xc28Lz//2sIoNQL41U0SgctVbDzcC
 yoThnsFX2u4ZjmjfKWs+WzzIuB0Us6IcYPkj0wIQ/HGEa+QL1XAH/KX+D7hNlkxVKkOb
 6tuvBwRGJZlwGVxHhHkDeF6CztwK9FM6a8qvxNMthCj3zzBM0B8jMfNY6XZqvhJK5yhN
 B8wA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772447570; x=1773052370; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KWbMIZb7vgaoVeySsrF8TFJRCienpK7ZIh64IObNMk=;
 b=pKYDT3FYliBYUBN+ddOhXUL19hGIvdco1Q303coFS22w/XRVMze+g2O6ErJmBn72sO
 l6+9g/u0dXyL9C6BqOYaRnq0YChCa1izxFpL/E+yLvGcn+5+sGU6Y8dKaApAgIlUvf9v
 Uc7fsLx4ebrG2eVsAVCPer90ebd0FoKR865Zsb84Hnoxr7Oi5SB1jaRKLW/LVGtI+uBj
 rE3Qm6ZhIr5Kl7JZnOZsxAqxRgaU1JtnLs6Rc1YQ3EU60wU7BUFV/DYe4D/+apRb7eTK
 kEXM4lCDptev7CUlDqsDJkVL61s7gbjkU7b6d2Yac0aVkpUkLIekrxEIDELyIKQ+C8DI
 OzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772447570; x=1773052370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+KWbMIZb7vgaoVeySsrF8TFJRCienpK7ZIh64IObNMk=;
 b=Kpc2sDqGBdQhgxyZNx68SSyqcqbbmeA9HlYJRM6Tbkq9TLgHm0JTfyKpNqfMYs+ki3
 kWzGeSoT2jArbMpRYDRaRG9zbXOBRXIL3tkFWFiyfeRHsh9e7SRJzL71lRaTsZJDDq+i
 heFmLyhPO7EQqGWt8BZU07CqmFO1rz45EOWIBvrp4xzjRCfdcaKFvFkKc8+XOaVL/fo6
 1dnPRSzDa8GV2b20JxWrmpRpOfssB6cQCGpUhl7dVgY4GvjblzZgBwjXZrkym2XtN/vs
 cNViqsaQeV+muByY19z6aqm0jzjjqS0Gw5mjsm5R4612dPrX8b55/Ibp2LNnjD4J0QQA
 DjCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZBuqwK77RhdOYFn34fgTU94TZPKXzSnD5l8ETB1CquIFgAcwgMeOwreOMA5wKxD5OLb7GgaCspJFn@nongnu.org
X-Gm-Message-State: AOJu0Yw6PDOKaBckGgJszQuzzJKzMDxBVEOO+AS+ILZ+orw0eF0RZ9x0
 qavKAma+aj6hj9jysXdT7KBE+ovKfNGrzjZHXnHy9M2dImPPu9fF9pr6EARY1Yp8R1lwHGwYuUt
 zpIl9E8nNOFWaJ5q9mDj+UtAlFL22cAFIC6mztUUYYg==
X-Gm-Gg: ATEYQzzp0jXKtpGzK5z8arHhLfxr+tPc8N8uTyitrpodkPlHdnBtxN4Pk3vOgkAi+TV
 PqLXhCxxxcbQBG7IlK9/W4n3+zVS5QZg6m4Da/zZOsIpKPUIoP2DXPQRicSPABzRDbsSPjyFNI7
 ryZiHKqVD7QiYmJNUoR/vTFRR+z618qs6aowDJme1rl3fUq5vEnpB9gz4mB2+pGNdqvHOIqKomT
 zK2RIaONy1LlOtpngpmNFJ+0zuSA2QUCk9CU3lOR9BG05gUf9cutV6mL+NAPFOKpbKjsDma6whg
 69VNcP776Elnwegi+gUVfQ/rNPVFUdZOJwDLMv1ABgFuphKIoVnwH1TvPhbKGPBPgfg=
X-Received: by 2002:a05:690e:1656:b0:64c:97be:a890 with SMTP id
 956f58d0204a3-64cc22252e2mr6234224d50.42.1772447570342; Mon, 02 Mar 2026
 02:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20260301121347.797dc9f4@penguin>
 <127d0e97-ca25-4847-a06f-954443bbc886@yodel.dev>
In-Reply-To: <127d0e97-ca25-4847-a06f-954443bbc886@yodel.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2026 10:32:38 +0000
X-Gm-Features: AaiRm52euGo_Fm7BjgfZoW0lNUJ0dFWFCDNicAOVIV6j4rxN0fVAE98-oSvuQ-c
Message-ID: <CAFEAcA_igpniZ=zZAUPTyx9xpyS+TjU5KO+LYc-noJsJ+L-GSw@mail.gmail.com>
Subject: Re: qemu master compile error in hw/net/rtl8139.c with --enable-asan
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: Lukas Straub <lukasstraub2@web.de>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sun, 1 Mar 2026 at 15:15, Yodel Eldar <yodel.eldar@yodel.dev> wrote:
>
> Hi, Lukas
>
> On 01/03/2026 05:13, Lukas Straub wrote:

> > ../hw/net/rtl8139.c: In function =E2=80=98rtl8139_io_writeb=E2=80=99:
> > ../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of si=
ze 0 [-Werror=3Dstringop-overflow=3D]
> >   2264 |                 memcpy(data_to_checksum, saved_ip_header + 12,=
 8);
> >        |                 ^
> > In file included from ../hw/net/rtl8139.c:62:
> > /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into =
destination object =E2=80=98ip_ver_len=E2=80=99 of size 1
> >     50 |     uint8_t  ip_ver_len;     /* version and header length */
> >        |              ^~~~~~~~~~

On the face of it, this looks like a compiler bug (warning false
positive), because we set:

    uint8_t *data_to_checksum     =3D eth_payload_data + hlen - 12;

and earlier

            eth_payload_data =3D saved_buffer + ETH_HLEN;

where
        uint8_t *saved_buffer  =3D s->cplus_txbuffer;

and s->cplus_txbuffer is a uint8_t* which we set up via g_malloc().
None of that is an ip_ver_len byte, or even an ip_header struct.
So it looks like GCC has incorrectly decided that this uint8_t
buffer has a type which it does not.

A workaround for this is to use clang instead -- the Ubuntu 24.04
clang sanitizer has no trouble with this code.

This code is quite confusingly written, though. I'll have a look
to see if there's some simplification which might help both human
readers and the compiler.

thanks
-- PMM


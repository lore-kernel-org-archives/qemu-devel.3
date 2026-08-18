Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D835C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwL16-0006O1-BS; Tue, 18 Aug 2026 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwL14-0006NZ-Th
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:42:14 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwL13-0006IC-GZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:42:14 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso4606705a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787064132; cv=none;
 d=google.com; s=arc-20260327;
 b=YH8y9xHsMHGLUco5mmDGULvE/6UX1OMSvI/Pbiu6AoV7VzrFrhd0YObNs1yGHqkj0D
 F/e+HkxHtJnfpZuY7PpcK1Izp142cegbznyVOFyclOGlnSgtkNxFMZv79VJUlxAhwyyH
 DH2GllzsSVEdYgQun+1wX3ilW7ANOrrqJZINqoFIt/mCPGpoINfAwjOPsvyTdii78EaI
 FcfmHh5dsIz0EVScBBwn8+wA8dcvl2ZCDlq49tADk0JxEGZ7BUkVf7ejsuNpwGqoUuNx
 95pU/YiKugqzt6Hq557gPR2ONtkVEQRQCmNZe9l2W72CGifBx+Y6oyVhtQyMOGaqgLju
 IBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nrRLMMA6hvaGiOSknnVa961i2FUpkhXprV3naFXjZQw=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=qjFyDWRLJjyO5oxKIZ7reC58fXv7x7dPgfY64eAC5qq3Tb/Lwgz+AdAFh8vjGdZFX5
 dUOY5oJRf+2/X7Xuqy8msIkD/+CTwnZSQSu64SXoEjBO9z+6WU5IHaqKjblltPXFn84C
 U15TbHzGGy/EKkWkw2D3dsYnhGvfEW5JWOglYY6tZ82UDvHp8huk7EbH1A9Buzej1/AS
 GijphZorn3+YovzG/2UqvhrjIoxEA22BBDx8EYGbbpSlDa7RhJslG3ePdFHpPdCA/DXi
 TJkFtN6LMPpMnIRVelz9HM0mNQpIz4vZyI4Qqy5UOHDzeV5VhrGboNmi6kmbYm0O/vQG
 pHug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787064132; x=1787668932; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nrRLMMA6hvaGiOSknnVa961i2FUpkhXprV3naFXjZQw=;
 b=IQ8b+H8Mh+pXqcjUgqEZ0Z3SrvDkVetIkxzPu6yFPigAAtXasMxO4fMrTNsWYg30V7
 0nSt6LfMNyWvFAVZCyUlRN/Iq+tAeqEYvJm1jPL1Dh8MQUTqjpV1S4TEabI5g9j8dzR5
 qr3Okj+4PdFH/ooBpo+BMRETkxBtpEhDudr6nESbedtCdFONbk4+IFUxybSfJutxtY1O
 KCG5T9d2URcFXwHeqSDC58zF2byDlpxV+Sd/3Lm6Z0bUuVRkCoprLvxi1Oz/HiGjLb5V
 9uTSnIHV7JcQzO6x53krABfDLkUJSC7u3IDpv852UT8F5p5A6cPvYu4o8+2QPrdapEt5
 uhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787064132; x=1787668932;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nrRLMMA6hvaGiOSknnVa961i2FUpkhXprV3naFXjZQw=;
 b=eJByd4rJnKk+AOA5rEqCLqb2feK4vOYJEK1/lIfO6q1q7CxQSvnBfBwJFNEfWHf1iH
 SbsT7w35OjTU8ASbjygYmm10+RyC+NJfp+ajv6GV9ucx0FfLKp7Ea7oib2AjgXKwikeF
 jtRJ7v1WDVK6R4HCbO0klzkPedSsUoJFOqCCT2a6YUXiwe/0DpKUmF7ogAID2sDr9MgJ
 LdKoVSEKkWuTZspBcBi9Q/YrctpIHTFPgUkSfo6C0vHzeRA0eT33PTEmM9W4l4LppjW8
 lRJoVh/upoWND9feuCSFW7r/4VDn5Th8NqIq6deyG02chns7ZanRBP8qpQWo0nGgd0f6
 FcJg==
X-Gm-Message-State: AOJu0Ywk0FOuxZXJrSCo9BN3I5chCLDh++HLFP0Nf8PoxfT2IIeDj+2M
 LMQM4Tv9ggYim+ZRUwmbABjmHLGbuKFXyw+BNkrVgmCXKt0Av5SDrSv/sw4uLu9uAE+cZcYTYTK
 Sb8qBum7nY4Fb42epEJSBInxyghUKTvI=
X-Gm-Gg: AR+sD12q8hIFerz0TJJV0i7CtZ92aEgNs/4z/itsWhHz92VrT+jLIVns7CpDKJLLk6G
 n2cgevEiMnZajaSVDTwdL2EhkI0nReMwXRQ/lYG8s5OLyRImRWSTf5n8457S1g0s0qTnNL4diTN
 w7OJtwgYOycUQD2+zSeacOFjbSErmwo++FX0asr0NIRxXg9kbQyjxryohGcao51K4xiGG48G2Ym
 /2uJxft1HrcxDrxp4M4ytBUYORLeoGPq3uuchkAjqkwpXDwaNzLXww5irRk/eqgChXIIkC8uLWG
 XVgrhhQNgtbZZSrAlU9siTFUoW59oay/LVNhU4Cevpj7TN9G7+EQLm1IKR5vI7oE+SwsaF/IMKC
 4
X-Received: by 2002:a05:6a20:3d82:b0:3c4:3321:4ffd with SMTP id
 adf61e73a8af0-3cc71c61dbbmr38587073637.20.1787064131786; Tue, 18 Aug 2026
 07:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260818142836.1664990-1-pbonzini@redhat.com>
In-Reply-To: <20260818142836.1664990-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Aug 2026 18:41:59 +0400
X-Gm-Features: AcwNN1WWPWweeJz7LdHjXQndMlRmhT6KL504AsHFTUOgjJTKfNFgcKv4R-49flc
Message-ID: <CAJ+F1CKuBR9TWnCzTjyFC=6Xn8q9ZDiXRXSoD+6if=cJRDkPMw@mail.gmail.com>
Subject: Re: [PATCH] serial: clear transmit retry callback on unrealize
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Aug 18, 2026 at 6:29=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The GSource is removed when resetting but remains active (and can
> cause use-after-free) on hot-unplug.  Remove it before the character
> device is disconnected.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4125
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

it fixes a use-after-free, so
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

But should we care about flushing pending data?

> ---
>  hw/char/serial.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 0729cd2ce9d..4339562ab00 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -936,6 +936,7 @@ static void serial_unrealize(DeviceState *dev)
>  {
>      SerialState *s =3D SERIAL(dev);
>
> +    g_clear_handle_id(&s->watch_tag, g_source_remove);
>      qemu_chr_fe_deinit(&s->chr, false);
>
>      timer_free(s->modem_status_poll);
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


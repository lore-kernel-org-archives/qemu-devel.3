Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C1606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MWsSc69I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVp3d-0005eT-Eh; Tue, 24 Nov 2026 06:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVp3Y-0005bf-AL
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:51:29 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVp3W-0007Ku-ET
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:51:27 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso4472370d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:51:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795521085; cv=none;
 d=google.com; s=arc-20260327;
 b=JaezGmbaeQZPCMdKbT4lUQz5UbDyZi1AR7VJGi4LOt6f2auZHZ32s/IqS+5yLh7DsW
 p8UxfYtZbfdi23D77emTqDqBReo5fmydKjcg+pjOxs9z2fGf3UwOtLWpuhFEIJHL7wVg
 dnRT9E3gKaP2fxCSIi+J4r+kvtCeWxTRAAlRtPhKfn/HZ5WXOLU8ELJ5/g1iK1r58SCh
 4jPyKc7CMHDxTbZUPs+kYVb1dHUJjSzkJTk1DvvsXWHKiqtomH3eytecnNUQEao2vWM8
 ur4tXtpgJ7k9ue8VDKZv4yYZWkLpxNbhheZcDDZuwXqp2pNCztQmNHBl0tyRIJr0uRFj
 uXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vjlb8k64PhCpMx4F2Ik2b1XYTzrg3aJBi0/0Ruaop5g=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=sC8vuqgCvl6hpUjmXOBvQ1cBTiin4Ze97CzFiksasm5tIgABz5UIJv53kd6h+Km8Bo
 qJwt6/RYZLUitKFLJFvE3XgbgzkWxaeo7DRdpMQ9uK4g+YD/UQkU5klR3AF7FDKuKGzX
 hEuo0UCU5e8WFtzG0hW9HOiorpDEq3cxTtpXscbJyOMBWutO3oobe/LF3XaczBZhYZBI
 JknER63cJfbaTc+Tuo1MRDOGi4HSXZpF0aETQToHF5+E/SmanQ3Ft5HSppRr8e6OibtH
 kq/6a0FtRXx9JY1JvBUeKZUtbLav+OBRLr7fMX/94BeamnvAnr1ZgV8oTgJELs+8hupg
 /2TA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795521085; x=1796125885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vjlb8k64PhCpMx4F2Ik2b1XYTzrg3aJBi0/0Ruaop5g=;
 b=MWsSc69IjIQ8KFLJHAGAhD+20ZbUH4CqYgQg8UrklAfv875/9ieImwUGJQP8JsFuHX
 dHnDFkiXMvo4ArFRuHFcoPU/YoyvJ88sPsHYoybhyibYfMHHmR+igAz9ivGgobskxfFt
 hdZ6AO2/UtTWKb20ugEMrW4xMFZc6KmU/1ljZIoJD6wuf1UoZNBtJCNrDixOoF8lA+rh
 x7MJEfNQsG7UHVFbEpf6+A5jJVBtQR66NOxzJNtQSmr/L4fv0XwDmuQfOs+wR471iPGY
 5RxCpHUR0FjDzdbOR0phz3t/itnRGE7PfVfveI0xjeai+tKwNJy5IYdeh5IfafbramXx
 71Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521085; x=1796125885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vjlb8k64PhCpMx4F2Ik2b1XYTzrg3aJBi0/0Ruaop5g=;
 b=pFI5AxFazk/P5PCCg1tztYNzeocqRKFmODbFEsUqLhbwkxPyGy6ntVwyeC3XRrLeVx
 HMb7TW4d4zk899KB7GIvVQkCOV2v2Kr5/7Qx+VlVPkw0E1oXioQ0lWAV0QvJXroaw4TM
 7Nk3xqGB9hHJrvAfD5n9Lwn1UzfDle5MsT+i4m4cURCoTDJ+J5RObJGIolbSJMnAmYif
 fkzx316tGtd6RKqRclDfte9RUsiliMFaYOxzb2yJt7XSYl59Zi2nLxa4igKWG2ll3jF4
 odOqbEQlYULn4WNTi5UqYld1TO+t7zFAZrM66NcKUq2kV1ak742v7MD+TgnzvyKaCdIl
 WmIg==
X-Gm-Message-State: APuU4Z9s2AWsY03tOAGlOuh+AB8SU7nu2aXggF/Twq3jFr8aETNSX2zm
 CD0SM+9LVxHr9qw6tjEOXhA6QqIcX7W90MNyS/cbq4yN14j+nViRhlfJJ1YQNuVEBL8dbnzmzlB
 Iy0g2gYo1j74LFL6EG1mgyQQXUrhlK9heGumFtnbmTQ==
X-Gm-Gg: AZFdTZcdBZKTDdE6jDjHyUDmxDfQ8WLd2HSW/AVSyT5KZ5XNuXuLtKsagvZP0j0mBMI
 XwhxpPkACGIDZpVHwAzUd+ImXvBb8R1W3Y3cAV+3TMg/CX0TmwCBX233bVVgNhJUaHozze/5a99
 kvzBt6nt3v7EaiyAwMrj+guZGaX0dJwP8oQfLMPqhqRI5QvKZD4/Vc2n8ErF3msJ0zegKPiDvBy
 DoKXUaKsPB5K4ORev9SDFQW7MEXYJQSfRF33wrX1E+JwPWrAzGqMxqv5tHOfKn3/W1a8Qd83tma
 uePsppoWjMgAQCpf3MXyhFLFQqiV2pS4xB+L7HmjHRCCQZWdomX0ShsIs9qkusAqXyu/NoqraAR
 joAoeMiR8pNSDCJ0tTLSxpe/4wblvy5c54WlvykDM2b9NX9P1U/CJ0dqH2BFIENKfBYnziWLmTE
 2CtvmWyppYhGIpTaAMnlq3
X-Received: by 2002:a05:690e:144d:b0:67c:f8c:22ff with SMTP id
 956f58d0204a3-67dec47acbfmr6562143d50.29.1795521084889; Tue, 24 Nov 2026
 03:51:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-3-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-3-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 11:51:13 +0000
X-Gm-Features: Aa3M54qI-6nW5UUr0rN3DJ8LrR24Fmp9OT2iRL78zA4gSzdZPBgszGeKefYuDEc
Message-ID: <CAFEAcA9Ypr6tDQzJjU2Tu9=nMxOwh=RYDSMm4DfunpxYgwQMvA@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 2/9] hw/sd/sdcard: Do not write data to
 write-protected areas
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 22:55, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> WRITE_SINGLE_BLOCK (CMD24) and WRITE_MULTIPLE_BLOCK (CMD25) check
> write protection when the command is received, set the WP_VIOLATION
> status bit and enter the receiving-data state, relying on
> sd_write_data() to ignore the data while WP_VIOLATION is set.
>
> However WP_VIOLATION is cleared on read: it is cleared when the R1
> response of the write command is built, before any data is received.
> The data is then committed to the backing image, bypassing:
>
> - the write protect groups (CMD28) for CMD24,
> - the CSD TMP_WRITE_PROTECT / PERM_WRITE_PROTECT bits for CMD24
>   and CMD25 (CMD25 only re-checks the write protect groups).
>
> Introduce sd_wp_violation() and check it again when committing the
> data.
>
> Cc: qemu-stable@nongnu.org
> Fixes: a1bb27b1e98a ("SD card emulation (initial implementation)")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sd.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 6b817f11c5d2..04870c7b3962 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1481,6 +1481,17 @@ static inline bool sd_wp_addr(SDState *sd, uint64_=
t addr)
>      return test_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
>  }
>
> +/* Return true if writing at @addr violates a write protection */
> +static bool sd_wp_violation(SDState *sd, uint64_t addr)
> +{
> +    /* Permanent or temporary write protection of the whole card */
> +    if (sd->csd[14] & 0x30) {
> +        return true;
> +    }
> +    /* Only SDSC cards support write protect groups */
> +    return sd->size <=3D SDSC_MAX_CAPACITY && sd_wp_addr(sd, addr);
> +}

We could also call this from sd_cmd_WRITE_SINGLE_BLOCK(), I think
(it currently has the same checks open-coded).

> +
>  static void sd_lock_command(SDState *sd)
>  {
>      int erase, lock, clr_pwd, set_pwd, pwd_len;
> @@ -2691,6 +2702,10 @@ static size_t sd_write_data(SDState *sd, const voi=
d *buf, size_t length)
>      switch (sd->current_cmd) {
>      case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
>          if (sd_generic_write_data(sd, buf, &length)) {
> +            if (sd_wp_violation(sd, sd->data_start)) {
> +                sd->card_status |=3D WP_VIOLATION;
> +                break;
> +            }

Is it correct to do this error check after calling
sd_generic_write_data() rather than before ?

>              /* TODO: Check CRC before committing */
>              sd->state =3D sd_programming_state;
>              sd_blk_write(sd, sd->data_start, sd->data_offset);
> @@ -2714,11 +2729,9 @@ static size_t sd_write_data(SDState *sd, const voi=
d *buf, size_t length)
>                                    sd->data_start, blk_len)) {
>                  break;
>              }
> -            if (sd->size <=3D SDSC_MAX_CAPACITY) {
> -                if (sd_wp_addr(sd, sd->data_start)) {
> -                    sd->card_status |=3D WP_VIOLATION;
> -                    break;
> -                }
> +            if (sd_wp_violation(sd, sd->data_start)) {
> +                sd->card_status |=3D WP_VIOLATION;
> +                break;

This is inside the "if (sd->data_offset =3D=3D 0)" block, so we
will only check for the first time around. Is that sufficient?
I guess so, as we presumably abort the command on the error
so can't come back in here for more data unless it succeeded
the first time.

>              }
>          }
>          sd->data[sd->data_offset++] =3D value[0];
> --
> 2.55.0

thanks
-- PMM


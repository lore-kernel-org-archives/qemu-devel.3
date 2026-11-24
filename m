Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=und3oeTK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpQP-0003WI-G6; Tue, 24 Nov 2026 07:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpQN-0003Vq-Kf
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:15:03 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpQL-0007Ae-Np
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:15:03 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67db6d4054eso4901155d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:15:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795522500; cv=none;
 d=google.com; s=arc-20260327;
 b=fE/6ksd/7OmdwEToCh2XKoNvEvOZ616LjHD7VsEjoKcWtYtp5MiW0XGO5y9efQSUqZ
 Y5uutLN+bXh/iH+SktFg0L6UvEaEHTzu0eFaum/j6SjaRUcAozTKJbt8JIzVq8Fn1mQr
 93W5toDFrnPYOZqqzeXgUfoWWOH70sKSIlN0Ib7ynd0w/3tRn88ZqBeF8EwgSbzGn5BB
 02WyJUzfnc3w4Fg3SdoXPmeMJ0Azz5bTgXJHZ1tbG3dYqxRTt0X7J6d0Fo7aJ92+FfN6
 wCZTM7FxiO1Y4Bd2HSGYO6FHdN5LTfjFgI44JBk9/hdlB1JB7oFIJg1wg3fvjh0Z8kA4
 VmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oKskTVeT1ZHV0WNutlGzIvfGGJzXg0UIJXRB/pOdmhI=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=RUOm36GTtqZlZ1a71G25D2Egg6AONDaAysqawP9QzByQpNg5fmbvoirMdxTG2HRETw
 YmeP3pi+vt6RteHSuJ/zHitsv0LhWxXplEHyQrb1qZJFkQn8APC4StvPMagOfsOoh3dr
 jTyAIbZgyzf78kYFjRwIScpHkz3+A8CnMwWSWGIXVuamS3UWCH1J2J/Tz6BD1RW9VP/v
 1aX4sjBRGdfcwAXGxr2M92NOyd9wmEstPOej1zjk8x5xEmZEMGtMvtwIxB6ek6IWvlg6
 QxJNQpJHYFpNRxR3EWEhJEBaV8tGqvshHHVLTGhnlkbN+a1G5uuXbgLPbukmVV5cAwGp
 0KQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795522500; x=1796127300; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oKskTVeT1ZHV0WNutlGzIvfGGJzXg0UIJXRB/pOdmhI=;
 b=und3oeTKOK9PqyhUi/AZltQYfp4qDPxxX+kp8CmoW3H+kDw2lJLEh9Hc4PFccX4Hxo
 NIZm+LF4eoASWQK4t9LYqm9lyedXMPKnFSO1G0B7YnSUX6VwDMpMIcocjYwE4JkPUKn5
 ozZprPCutFdedQRpnky8SenxbRqTXbiHau8hdj+pnM0d2qTuUlB/qnE+Lb+GPbBnnqIq
 rTflL/+tdKCW66HYLHcUGGVWiqVfaCnf5Yoz34QTYiMehmsqNIKMet/RZ0miAGc7x5Fh
 eRjiE3n45Ozc4+w2sLKtN6uhgehh6vkHlorswz9cJLy3j6yXAbAazQE2XolQB1BKVKWT
 6r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522500; x=1796127300;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oKskTVeT1ZHV0WNutlGzIvfGGJzXg0UIJXRB/pOdmhI=;
 b=fOD9BoyyBebtvJy+7GUszcb+Rn1Cn8PtnuylXJ3K4y4iOxHFb73NxD6LcVfiIQ0HHS
 BDiTeq8xZocRT/QMCYab+OFLDkhGftXl9cs1sBJjWWUUg+CN1brApgFZdKwDmXoe8B5M
 oGnpdRWVtFDUda1dFlkUYVWKhCO7DTp/SuAHZQGivbqDuVNaCoYpnuj6asQM8vzmilg/
 DuEdb9I5BTwxQ5x/D8o3KX7jn5iDIiurxnUNGS0y+djjt8mmtaPmhzqL0W0RseozOFCX
 LJF/QiwBGVYFgYd4BonzO6KloHtkhk8ROCuN1smalg/ng40eXmOZMVRYyPY2vEcPF3FQ
 fMdQ==
X-Gm-Message-State: APuU4Z+OtWiqr+fOUN1A1rfyY11SuAiVGVlQjeBXAsLxg0uCycxORIH0
 dxs150+dKkNQRy5dRIJ3V1LdgieVkMCbIdQtp7hmcdbgQbWK3o0iMzNTB1aUJY7nBkBu/NQ73hU
 TWmgIJW0zDLTnu65UrRimproaVyxjz10q3AciaFNLEg==
X-Gm-Gg: AZFdTZeZvdkbc9znHdwQSxlGppF438BpMUCLiTw4labDKtkqSW017XueEkb83sbMqkc
 YhvQqTT/l/5GkpXMyls8addJdzi8ynuFmclDEkCUFRqkqgQLkUUlA/l2ndf20va0MP55lPvmJLs
 sd+ORrQ708PBwVBNEC2qLaMZoIWPadHYDrLk48nUhGl7Cs96+Z7YCkAZhxVxWyuloFomInbGOoQ
 wNjIxvjFj9isfPZpPBAQnDstPgFperTMZycXW2vfhvK5+APBJex2qBIRavG5BqGUnXJqf5Awdai
 iI3rrc7OVaaZJhXz+iB/ekkLj15I0mPB8Xe2DrwvqdlKdHlNTU5+Rl46OD3yyC954o7nJXXIP7d
 SFTtbmbTUUUqS/7X5wzt8nuvIoE+3S8ut14WSXKm40R+WACapBteE3o/Ka7ZWx1oTENNxAdZuV1
 WIdplE1+HIjLGbzHEoVF/Pwg==
X-Received: by 2002:a05:690e:4510:10b0:677:cf4d:a932 with SMTP id
 956f58d0204a3-67df4423516mr4554884d50.63.1795522499896; Tue, 24 Nov 2026
 04:14:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-8-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-8-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 12:14:46 +0000
X-Gm-Features: Aa3M54orEfRzRnhplZYM5KrHOZl9mVhTeLP51ITUozxmCguRcX-u-xqRAuAyZ-Q
Message-ID: <CAFEAcA_tCTSw3GrLZ7DmCfdmOSKfmMhwRfC4o1f1ihWtq7kygw@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 7/9] hw/sd/sdcard: Validate the migrated state
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 23 Nov 2026 at 22:56, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Several migrated fields index the card buffers or are used without
> validation:
>
> - data_offset and data_size index the SDState::data[] buffer in
>   sd_generic_read_data() and sd_generic_write_data(),
> - blk_len bounds the CMD18/CMD25 data loops writing to SDState::data[],
>   using the effective length from sd_blk_len() (fixed to 512 on
>   SDHC/SDXC),
> - pwd_len is the length used to access the SDState::pwd[] buffer,
> - an unknown state hits g_assert_not_reached() in sd_mode().
>
> Check these values in a post_load_errp() handler and reject invalid
> ones. In a data state, data_offset must be below the transfer size.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ce1d1ed583bd..862622e217b4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1100,16 +1100,60 @@ static int sd_vmstate_pre_load(void *opaque)
>      return 0;
>  }
>
> -static int sd_vmstate_post_load(void *opaque, int version_id)
> +static bool sd_vmstate_post_load(void *opaque, int version_id, Error **e=
rrp)
>  {
>      SDState *sd =3D opaque;
>
> -    /* Check for blk_len that overflows data[] */
> +    /* Values used to access the data and password buffers */
> +    if (sd->data_offset > sizeof(sd->data)) {

Here our bounds check on data_offset is "greater than"...

> +        error_setg(errp, "sd-card: invalid data_offset %u", sd->data_off=
set);
> +        return false;
> +    }
> +    if (sd->data_size > sizeof(sd->data)) {
> +        error_setg(errp, "sd-card: invalid data_size %u", sd->data_size)=
;
> +        return false;
> +    }
>      if (sd->blk_len > sizeof(sd->data)) {
> -        return -EINVAL;
> +        error_setg(errp, "sd-card: invalid blk_len %u", sd->blk_len);
> +        return false;
> +    }
> +    if (sd->pwd_len > sizeof(sd->pwd)) {
> +        error_setg(errp, "sd-card: invalid pwd_len %u", sd->pwd_len);
> +        return false;
> +    }
> +    /* In a data state, data_offset must be below the active transfer si=
ze */
> +    if (sd->state =3D=3D sd_sendingdata_state
> +        || sd->state =3D=3D sd_receivingdata_state) {
> +        uint32_t limit =3D sd->data_size;
> +
> +        if (sd->current_cmd =3D=3D 18 || sd->current_cmd =3D=3D 25) {
> +            /* CMD18/CMD25 are bounded by the effective block length */
> +            limit =3D sd_blk_len(sd);
> +        }
> +
> +        if (sd->data_offset >=3D limit) {

...but here it is "greater than or equal".

Are they both correct?

> +            error_setg(errp, "sd-card: invalid data_offset %u (limit %u)=
",
> +                       sd->data_offset, limit);
> +            return false;
> +        }
>      }
>
> -    return 0;
> +    switch (sd->state) {
> +    case sd_inactive_state:
> +    case sd_idle_state ... sd_disconnect_state:
> +        return true;
> +    case sd_waitirq_state:
> +    case sd_bus_test_state:
> +    case sd_sleep_state:
> +        if (sd_is_emmc(sd)) {
> +            return true;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +    error_setg(errp, "sd-card: invalid state %d", sd->state);
> +    return false;
>  }

Maybe prefer to structure this as

    switch (sd->state) {
    case sd_inactive_state:
    case sd_idle_state ... sd_disconnect_state:
        break;
    case sd_waitirq_state:
    case sd_bus_test_state:
    case sd_sleep_state:
        if (sd_is_emmc(sd)) {
            break;
        }
        /* fall through */
    default:
        error_setg(errp, "sd-card: invalid state %d", sd->state);
        return false;
    }

    return true;

so it doesn't rely on being the last check in the function?
But if you prefer what you have written I'm happy with that too.

thanks
-- PMM


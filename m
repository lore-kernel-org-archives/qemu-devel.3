Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EFDC61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OXO-0006Yc-UD; Sat, 29 Aug 2026 15:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OXN-0006YF-Qg
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:16:21 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OXL-000763-V2
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:16:21 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b4af4be667so1873189e87.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788030977; cv=none;
 d=google.com; s=arc-20260327;
 b=mAsM1uU3BuNP/CiJ9i352mF3Hwi/ucq0e3PK5svcXmmhPQdHegvOMIxwQSKVsbrmZY
 Q9lfMzmRPwjj816ZCPpzp8wr/+9r0BUb76QEWqCRWmpFEsLybhiMtYj/hz49kmp/97Q1
 6OxGUGhtlmoZd+0KU0yUFbmFIaRXOtFCLzsN4iL3H8KYIiC/jA29waD9gU3hLEQ1A2t1
 tjvNig5anF5IQbUEhKx5gJ7bKTFWoSZzXUFSy4mqcqdNKbNSt04wY1VfD2lH3x60bPJW
 xe4PWHA+5va4t0f3hpuZDc3zY083FFHQuFKjuZQ7pPRYEkt8m0GAzhFLTwK5oNxBPXgM
 2yOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5FteYW4EZwLG0gW3TPl063QoF8D+gZgu+0mHgbmf1s0=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=GgHjdr98ApI1eeDu76a9vc11sC+lCtew3nPrDpSGyxWS9iWH0zW1rowc5QWtp0YpPE
 cOd9YIdG5gkN0PgxozANHLKFASV7LnM3gIsaJZH328pQe5/nM+qhFF9aeEA5py74rnBw
 gF2wqwFulDC1M6weu8LidW6L/d+cTADP/HZFJv4bvpBw5B6RC4Qk50wJCgN04CDHJdIX
 f25pxqEIz2xb3UGJQ6EDfRtzENr5Advme8NBxIhzI4QaTcFB5+spGgtdMsOJRZBfUMhf
 4vEkfQ5ll+32Mhka1inyBYWYgM7r+XAR186u6wVWzF7T+cGPp5Vo3xsOGYHGLhy4MA17
 sNiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788030977; x=1788635777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5FteYW4EZwLG0gW3TPl063QoF8D+gZgu+0mHgbmf1s0=;
 b=FXZ6yW12vYwQo5P6JOAdg04A96w0yQWGbncStugdMD4MfyfV0vyzjY9iqAYMNRozKP
 SyzXXbcc5aWVwloLmvF0U0XZ9f95IZi+LqAMaLjAH3gApmbfQ4Eb8OOe+WCbOTO1CJOC
 5SqMb4ZalVceGuY6AmJXxFlTXDyh2ch/mogITx+rgWYL633d4xqDXLL3rO5ZJ1ujuRMa
 DBNAsgccll2/kM0imSkfgf2W1pJgXXeZINbOPqgJEGwwKRFe+GSCzzBoVsBJWw0swIkO
 Pzh/gEZXs0ACKl5uSFCjE3KWoaH9wp5AEtN0QFOAMm08W6CmArU06XIZeqx5N8kOj898
 t6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788030977; x=1788635777;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5FteYW4EZwLG0gW3TPl063QoF8D+gZgu+0mHgbmf1s0=;
 b=ojWw/4qPcfBcD2ZunpgCoAOkl6eQXbIAgx5dKM5YpGePi0G8NQVHRiUrH8c+IVLjEj
 4FbSZF2SC8ksvqnV+Xw+jPAqzYiKPLPM06Ns1+NeA4FGxEqGHQWfOtq3axWhDP9TJSiC
 BvnuABclchn4DBtJJYGU4//WS/gCN2iRrl1N5jtNNfqVGCdIhXb/SQZ5oPDIl+9KnpZa
 8TLKF5kBTzypT1t9oAhtFHOHcujXzCwnfxQ4f9uu3LlKuZsCQmgckf3UGQnO1RsDEEyl
 7U5nh82BYwcuhZT0GIZBcvQ1ICAGVSt+wvxpPBWZQTX58knuTt/OMk+YchGPwSN0jYVX
 A5eA==
X-Gm-Message-State: AFuF++nt2v5R3iQoxOAsdCUqnpqmbW62Npv0QVyvJMT90IqVXKCITSbW
 OwWS0JtJzxK639ctuGKDHUhdocN2OnghMSraJng4BXdBDe6OliyWtXyqahXLvDhV2J4KSvrSq06
 JGEcwvJU25M1YWC/tKAyAjDjwzA+kaZdSBaUz
X-Gm-Gg: AYBFou3wQF6WeTRGZ+Vw+4pOckhV+EUmiUhA9b17daoxC4tAGrmux0AvHPoVD5tTMBc
 bAUO36R3r5a/JETS7Qf2ejGZhb57+v5g7qQlCkWBfcO8BaOkaHzD6ORW1qj5EFxUrmTcOBbj9Tf
 PwAPuX57WwUbEn/wk8qzGlJyZEvGCIlOGbSfkQ0RM0hdFvozR5GiTDB4PayJD1wwRAQpmqbsdPz
 1fDNn/0sLXa+WlNxNmPY3jCJKgt2ngE6Od/uVjb3CeIaYQCJCmN6r4ITRW/WN028C5pZ9TWMQx+
 vHhaDn3jOnRLo2CejkQAYe0zCPWSAdXBfHbuDc74JIF8gTw=
X-Received: by 2002:a05:6512:3d09:b0:5ae:b260:cf47 with SMTP id
 2adb3069b0e04-5b5e68c2a20mr4220977e87.10.1788030977386; Sat, 29 Aug 2026
 12:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-17-richard.henderson@linaro.org>
In-Reply-To: <20260828224451.1564072-17-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 29 Aug 2026 15:16:03 -0400
X-Gm-Features: AcwNN1VrW6VF_ZyDW8inbdaR6TgQRJwHiIoAeNzygk3ZCm4ufoILcvSpxmWd8xk
Message-ID: <CAEdQ38EaV29yWOAq7vjs-GxXQFpy+eMVnQROJCS_=ticYZnpfQ@mail.gmail.com>
Subject: Re: [PATCH 16/16] tcg/s390x: Implement INDEX_op_lea
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Aug 28, 2026 at 6:45=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/s390x/tcg-target-has.h |  5 +++--
>  tcg/s390x/tcg-target.c.inc | 13 ++++++++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
> index 58e3afe5266..33a3b72318e 100644
> --- a/tcg/s390x/tcg-target-has.h
> +++ b/tcg/s390x/tcg-target-has.h
> @@ -77,7 +77,8 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, u=
nsigned len)
>  }
>  #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
>
> -#define TCG_TARGET_lea_sh_valid(type, sh)          0
> -#define TCG_TARGET_lea_imm_valid(type, imm)        0
> +#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) =3D=3D 0)
> +#define TCG_TARGET_lea_imm_valid(type, imm)        \
> +    ((imm) >=3D -0x80000 && (imm) < 0x80000)
>
>  #endif
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 2fd7012d047..db3b2fc3c92 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -3187,8 +3187,19 @@ static const TCGOutOpStore outop_st =3D {
>      .out_r =3D tcg_out_st,
>  };
>
> +static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                     TCGReg a2, unsigned sh, tcg_target_long imm)
> +{
> +    if (imm >=3D 0 && imm < 0x1000) {
> +        tcg_out_insn(s, RX, LA, a0, a1, a2, imm);
> +    } else {
> +        tcg_out_insn(s, RXY, LAY, a0, a1, a2, imm);
> +    }

Optional: could just be `tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, a2, imm)`


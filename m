Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B114CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsCF-00072g-Cw; Tue, 09 Jun 2026 04:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsCD-00072F-9u
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:52:29 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsCB-0002l8-Sa
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:52:29 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66062a414fcso5807993d50.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780995146; cv=none;
 d=google.com; s=arc-20240605;
 b=LqDKyBKXN02ar7rBEtcx/whoCwpgU7pUfZb5irKfpVznjzPdyuCeak5vLNzS3zdA1n
 VJsDA+DxfNVz7UTqR7+W9KXN/JQEtRmj7agqhkQ0V9Nvk2UXqfkgEBBpQfWUtqIbo/o+
 X23Yjf/6DMc4A9ODGnC2CWKnKS5u2JQjNXAEJysBnuVdIVtjaQuou5CXRZ2RH5JApCab
 CR4duQVvc6KBPjWcYMsOoX8csvslszy27v+l8YLeT66ruCqYsiNUlUDdloxefXrWVZ0Z
 z8LJQZ3V+GN7FCj+c9X1rEfC+AGcAhfNCq0aCFJ6ywEFr2Qm8EYTuac9PfPLDzOZa4EC
 NtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tVYJmPhbNbnvFH5UeAEKScjpOPfQEYgoxl8yaE1+iWg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=G4FMnch6yUqDtSHm10rAdbl8MJv7adZ/SahwreNNAdD9QRCnK8TPNpLcLQHh3jfz+4
 cuBth2a28k35n7jpgy4kavFZoKVuYsnDm55jtYGCu6qAqePZYQmUlEbWFIyy2oHNG42F
 +5/pSpOa66OvR7XnPEPWWiu8VSw26DsyiIE7RxUn7MkOtbS+9TuY/Y9Nmqtig+qzFy5L
 QIETpA3OpFa3KCjBjsMIQF5pfcHsJP2kICq83inaGbSWdhhHb9GxDmuVGl5nXJwR/ecL
 Vc03Y1jYvAi6EemhNXD5eY5k6WmtODmZR+h1Iszh6yG+fEz7j5BRPC2zQIGMROgTrvym
 aNRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780995146; x=1781599946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVYJmPhbNbnvFH5UeAEKScjpOPfQEYgoxl8yaE1+iWg=;
 b=PiInyCbU4OcdHXBQaggYgVUAodw4l9sr4FX/caeLF+K1WnxmpY0t5I/GSd+A1VxGRm
 9+iZgVHiDQGFfv1JbTlz1j5lkMPqDg7BSrWFllJL7otkizSH4wa9otObrNzpFJ6WX4n8
 4+3P4qV2S+/QUmkaC0rcFJcMpdS2QrRwPu699Nkx8XzX2iiKDHX4t7L44a/pAph/vW37
 au0MVphEPkddJr/hkDBiTEp8u0loy34ry0Q+5o5n54whMtmTh2/UEhcLafjXQWmb3+9g
 fk7olt2A6A/iQdp/uYyWrpR9pmvVx35gX0BXZWlqm9dgcuUUlHxkPK20TG6iSWWZ2Eb4
 WOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995146; x=1781599946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tVYJmPhbNbnvFH5UeAEKScjpOPfQEYgoxl8yaE1+iWg=;
 b=qcwBKM2zeF8ceFzZvHvnqgzQXw6RKKN94xX/sQ5/E6Ygg6i/bKI6m6X2m84E4iO2fU
 kGknQiwp9Tc113fYhfffHT46cVDcyhtA7Sor5REQkvLblRllFnqSnVwwHwmaCuyMrkyh
 Jlv/CKJGPhWeCqSiKX5pN/llq5A1BkU3E55bUuBDAhM1aE8y54aTNN11rDH/wKbX4Gqq
 Al+0Xy2hWA/evSI8OqAL3E5tF61b9/ZkW3wy6XpvX2DWhlwLV0GYSiTdVVVEM4vacSCx
 s3qotZaZ9EvXrgm04R2LkIrd9EcgkFDkn4PtT7tfujbGJzizKB5PRqtRG9MHPBTs/uVu
 pdPw==
X-Gm-Message-State: AOJu0YwBIw+84hS1VhqSQu94dKNy83XWhQLnU+O053CVkETt9ZZ8xTe4
 trAELhy3cHKOGhFWYVE5Lwg9gDVRKgqub6X6zAkuDnpGZaX8sjGpef6a+i3LV2S/R6t5bDDwnM6
 /pgXJkdvwe7Yf/563tUDoOb+lFdhhjPzGqqJEyVAxuQ==
X-Gm-Gg: Acq92OErppj4ueyH8EoP6H9Jc6Sasi9WBFmUOywZ2Hg0uuqSu7yR+5Wpk6wPdCQJhNE
 GLkgotwlXJ/d2pvPcjLqvj3TcSDBpvkQ6ZYH3axUoSdtWHmeyJUV0NPQ4+c4WGKSU4EggcnCaKM
 vu8NBfxS8IeDYOlwqT5st+ui9ckz1j2Xlt1gXt4Ex5VtUnK72z4l/bX3lRioRvIV8VSV/G9oS8W
 W1yCrDKxWtm3E8W2bnkwZxBrIwXfGK6SNr7W+aLDbydpfolk8v4AHim4sBo/OPVsJa/OZJgZwFc
 G3Am/Vhwd3BvDeFGKgMFxde3Ev9KpShKU5ozfDc0l38TH45WOwdI9PrtqlRs9yEZqXq5QglxCdO
 Nuw==
X-Received: by 2002:a05:690e:1385:b0:658:fc74:ed79 with SMTP id
 956f58d0204a3-66106de9d00mr18592992d50.11.1780995146018; Tue, 09 Jun 2026
 01:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-15-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 09:52:14 +0100
X-Gm-Features: AVVi8CeruBTVcyquuOPXtcTE0lue0I9M3l_5O4w-logQpmiQkED_x2iP43tfnIA
Message-ID: <CAFEAcA-RzkAX4k2xqN3pwfSUZ3LDmCa0Or9bKo-Rpwbk1aXQNg@mail.gmail.com>
Subject: Re: [PATCH v9 14/45] target/arm: Implement BFCVTN for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 3 Jun 2026 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sv=
e.c
> index c47e79637e..eccb5b191c 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4100,6 +4100,9 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2=
_f8cvt, aa64_sme2,
>  TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
>                          do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
>
> +TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
> +           a, gen_helper_sve2_bfcvtn_bh, false, false)

The pseudocode has

if IsFeatureImplemented(FEAT_SME2) then CheckSVEEnabled()=CD=BE else
CheckNonStreamingSVEEnabled()=CD=BE end=CD=BE

so shouldn't this be TRANS_FEAT_STREAMING_IF(..., aa64_sme2, ...) ?

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


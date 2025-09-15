Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyAQi-0002BM-CG; Mon, 15 Sep 2025 10:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyAQe-0002Az-7d
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:43:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyAQP-0003A5-KV
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:43:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3e8ea11a325so2333795f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757947399; x=1758552199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NcUUXAMd8YK+PjgoqRiVZNTZFmhDpQdf/tI2oCUspHk=;
 b=wYYAcyyDvGuvbH0eK1acVnFzUS6JEhATnnVgt6Ts0Nk179Ijc4IhF1GehNFYPhopiU
 93b1YkoTpKqmz7GR0BuROoqMNYliUA7CV/QtcFtpphSsAf9utHmhVxGjLeU6or95R8KT
 Boc3Q2jCI5MBFFqhWTT0zrqkSf68atii4kRLfn8h57DWcIAjIhaTEKI7wUHaHTW3GwEu
 1ne1th5fRbHrbewbf35mMPxPCNpFuYFuR1eNfqSOVXBhkfh/1KlKHf0IeatyiPKYugT3
 S7OH1ekH+QquLLZs/cs8EU3dmWdEjlrq0OVi12xrPdyXWkbMYT5yQDfRX8XIj9szCcJI
 V1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757947399; x=1758552199;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NcUUXAMd8YK+PjgoqRiVZNTZFmhDpQdf/tI2oCUspHk=;
 b=ayYjX41p4ti19z5vZz7Hnikc6WQg37kBWeHGhHPhZqhbgelcfNHYbu/95bTUSUlzqS
 I8byqp8wmCJC+v4nGBpEGpfcZ62J8s5ua3VqtRRRxNd7BoYt1SzjOikivMyIOkazTauu
 SYyLOCbspyiUqqnLkzVE2f3AVqgo8vUvxWP6/2sJ0Len4lhsq0LTTXUsh32S1PLQQFPk
 o7ez+97FonnWk3p+319i3j3s94nUlQ82XvKRFd9zoXzAO4IAx3sqssPavWBI1mjQvCuM
 3GUl86gQ1xWZrIbmQU3zFYSI/O1ksVNr6dg0Qt9o+YGEd4zQz1MPAC1EQYjsA9zOipTm
 Gfuw==
X-Gm-Message-State: AOJu0YzAxle1AOgPV2gZLU3s6Dmde9QuQHYzBKs4ydD32pCkQ9/xFp6V
 IqBUM+TilmjuPd8f106l1kNjf6AkX6GwEYFKNK2jK7Mvc3HJ2pXcq6eUtV5N2zbU+rQPZGqTxtD
 TX8KlNPk=
X-Gm-Gg: ASbGncsYaA68c5mDzuM6l5wkIZaqzPTsKklBPeRWQvQSNg/bwCsDjbW2Qs/a/G9iGA/
 m/90D5xcWvxrfuVmDWxp1caQETxFBaYE4cMEhA65IrU7UMoUgAUm0NONT9fUkGZiAxngW3gReRW
 tHD51/5cS/x3myTC+awgU6YgbjwWhBYVI6SC5HkTwFLUtmpJPbXN13fFW52h82/JPXNsPvfO1aD
 kIj9M2W2vcHEr6aKW84WtZQTxp3itYb+9zrr/Er9hAQgo5wLhQAF0oMnpA8+TEn2/Xz0iiUAOtV
 wA4aWFq6TQM7AjpVPReMxFVwru2L+zre9m8Zjc9tHXMEmjI2YXbB7tsGFn+IKIhmk7I57xPVbx1
 WiqMY93Xp4nCeR+nDCf8er3I=
X-Google-Smtp-Source: AGHT+IHSZ7jfNLOvT/+bXc4QAp8kLmjb7KMa8YPywDeBejaUYMM+UH3SYQiNLiB5e3E06FqdtwXNpA==
X-Received: by 2002:a05:6000:4028:b0:3ea:ac25:b6b9 with SMTP id
 ffacd0b85a97d-3eaac350106mr3595383f8f.11.1757947399131; 
 Mon, 15 Sep 2025 07:43:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e9a591a41csm7452509f8f.7.2025.09.15.07.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 07:43:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F6B05F867;
 Mon, 15 Sep 2025 15:43:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anton Johansson via <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>,  philmd@linaro.org
Subject: Re: [PATCH] target/mips: Fix msaregnames and mxuregnames off-by-one
In-Reply-To: <20250912142927.20919-1-anjo@rev.ng> (Anton Johansson via's
 message of "Fri, 12 Sep 2025 16:29:27 +0200")
References: <20250912142927.20919-1-anjo@rev.ng>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 15:43:17 +0100
Message-ID: <87h5x3pyii.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Anton Johansson via <qemu-devel@nongnu.org> writes:

> The msaregnames and mxuregnames arrays contains strings of 7 bytes
> ("w10.d0", ...) and 5 bytes ("XR10", ...) in length including the
> NULL byte.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/mips/tcg/msa_translate.c | 2 +-
>  target/mips/tcg/mxu_translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_transl=
ate.c
> index 82b149922f..0e947125a0 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -32,7 +32,7 @@ static inline int plus_2(DisasContext *s, int x)
>  /* Include the auto-generated decoder.  */
>  #include "decode-msa.c.inc"
>=20=20
> -static const char msaregnames[][6] =3D {
> +static const char msaregnames[][7] =3D {
>      "w0.d0",  "w0.d1",  "w1.d0",  "w1.d1",
>      "w2.d0",  "w2.d1",  "w3.d0",  "w3.d1",
>      "w4.d0",  "w4.d1",  "w5.d0",  "w5.d1",
> diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_transl=
ate.c
> index 35ebb0397d..7e8cc8b06f 100644
> --- a/target/mips/tcg/mxu_translate.c
> +++ b/target/mips/tcg/mxu_translate.c
> @@ -609,7 +609,7 @@ enum {
>  static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
>  static TCGv mxu_CR;
>=20=20
> -static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] =3D {
> +static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][5] =3D {
>      "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
>      "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XCR",
>  };

Maybe not quite so silly question. Why are we setting 2D dimensions on
the regnames anyway? Shouldn't we just use static const char * and be
done with it?

AFAICT all the references only care about the number anyway.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


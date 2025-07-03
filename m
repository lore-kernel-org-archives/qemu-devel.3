Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB20C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNZE-0000PE-0A; Thu, 03 Jul 2025 13:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNZB-0000Ov-W2
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:17:46 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXNZA-0002du-8h
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:17:45 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so98725a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563062; x=1752167862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QR16+SGF+rDJwWu0K/tL9EK7IYqpT8DnYQmGaU1+Cc=;
 b=I40QgKpLREGhzLcwRErd2lYwRLR7Mega4Bi6YJKnAzvxehPlntP/tct99WaFrY65+8
 +COJaPoBpPjfa2XP4StXWXLzObj8oN4uteDXTknKXNAjI8ue8+oERvyqGjGcYrZ0hOZO
 u/+uHHofGgh7kOK3PDKM921S4Nc2inIoom52IQNiNzDn6lBnu5aI9YznaG5yzIUS0Duc
 mqPuyjXtSZmYuOnH7JpgQ2Yl4uYHQ1EoNOQjS+v0nV2FgRc1y1+UVYZGyNecXr8hQlOE
 J6M9t6wLVjOoz2x9OxsT6SdD5ayZJ1R87zrIZwl+OXg3PWhty84evWIAQLhxcA+k5TGx
 zu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563062; x=1752167862;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5QR16+SGF+rDJwWu0K/tL9EK7IYqpT8DnYQmGaU1+Cc=;
 b=CUeVyeuAwjVsAlNsGe8ODCIAT/UvQF46GMF0P6NhPD0TxB+xQDGcLStLRfhCPUURLM
 VPJXoI0YSc7U+6XNefJMmjK7IIhOP4aV+4yoAfdV+EJVa2ETCYQQDr99oL3LYm2t48ug
 UBcALSrB7LdZFxc2L/hd6dkv+j1GdzW+owicP84nfTNsrBKOFkRODiwZ3F2HIwryf5dv
 EgaFbpdjIszFIuS3crWLo7cfSvEgMiD93q+GJ201wjW0J58GaAbdOOWxe5s2TKBaGOS4
 4H3wcI5GxI8yFkussd1tSwenoeJ5AkjLcTx89QIpgVzcbbekrUqVXzzSIHHPE6lpxi75
 qjcg==
X-Gm-Message-State: AOJu0Yy7QwXqvxmnnYzfk4Q8d4lA9I1E+F3xxK3Ivb4SH+eVi2+k/U/c
 yJFUN3LqUoS3ZpTDa4ifJtnmJf3ph8NqBAyWigi2uxc2ZCHifu7VbnCbzAsKg0m0uAEUXbpFC6N
 W9R/Ftxw=
X-Gm-Gg: ASbGncsIDqMUwuEDC+J2JTIUhuotrX+6zhe58Fs44MFyzUWTEa1ALtogxTwk0ZgLWnH
 ZfqtnDZbQmVk2xZBjoKYjejCH+uBcA4Egos8WkLuPC2AKYRgHeo4bb8KHqbPaBtBndz90SvzGtZ
 YzMwS3Kfhb+HfSlUGROizV4/qDL0FdQH0ElkGhNwL5UDRVM7eO+RWMDCHb2I8uXPVLyLvcSi+uB
 gQ4eYmeJkkWHus3q8BZenynpOqyZIK5Zz911ZU799mxe0iopLvck+nyqsm6fsW24XQTDIM/kPRb
 a1tV2Pz7A5ooRPAaBIQuNMC6MmvzjE4Yr+FW2/fUy4ASKNY4D4jeKm9CQ3fSJlU=
X-Google-Smtp-Source: AGHT+IFxVpViQBU7RKkhBkX30nO3rlduDeOpG57JIJRIffKr5/mOvBPwx46WXUcCbA51hhHb1tGKzg==
X-Received: by 2002:a17:907:6ea9:b0:ae0:c976:cc84 with SMTP id
 a640c23a62f3a-ae3c2b5f1f1mr759754466b.24.1751563062419; 
 Thu, 03 Jul 2025 10:17:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b02a23sm8484866b.112.2025.07.03.10.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 10:17:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06FAE5F8AE;
 Thu, 03 Jul 2025 18:17:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 95/97] target/arm: Enable FEAT_SME2p1 on -cpu max
In-Reply-To: <20250702123410.761208-96-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 2 Jul 2025 06:34:08 -0600")
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-96-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 03 Jul 2025 18:17:41 +0100
Message-ID: <87plehb3d6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c        | 10 ++++++++--
>  docs/system/arm/emulation.rst |  6 ++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 5d8ed2794d..f73729926b 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1194,7 +1194,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>       */
>      t =3D FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
>      t =3D FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FE=
AT_DoubleFault */
> -    t =3D FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
> +    t =3D FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */

With -cpu max moving to SME2 is there any way to test just plain SME
now?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


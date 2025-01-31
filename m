Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C8DC02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 12:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdpzg-00025l-NR; Fri, 31 Jan 2025 07:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tdpze-00025E-8D
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 07:19:30 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tdpzc-0003hl-7e
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 07:19:29 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab70043cd05so118923166b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 04:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738325964; x=1738930764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue4CKSaxIpbWuDuLGY4HpEtFZBoTtmI8ffUDc2Q1oVk=;
 b=OMPINKoJko/wLHSYjYeb6e/b4Nw4arZwsKZzXnR/H2cI+QM7J5fg7nXGpeWBOGZN/R
 i5ZjjYBsSiTkFcbQ1FuPQ8yCMJmHRRnovEt6aS+JxNwhB73ZHyd0llmgaEEOf9gtyv5B
 YkarB98T0HgzcooQoKIEUNF0DAdNriR2x9ByNzLPAl1T2JGuCqs9UmEdFxTHdwyLJhTq
 g7zHI7ueeHY5Niw3aqbNUuVY9/3gBe05cZrzyEpKr9ymzIiadBHML1FtlCAZFzed0CYh
 Hk5YxdK44tBUCoUdzwKqLpxtAq4MbrMuSECK/XeJt0utg3qg6MZ09tLGLK+nplQpHHRT
 U5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738325964; x=1738930764;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ue4CKSaxIpbWuDuLGY4HpEtFZBoTtmI8ffUDc2Q1oVk=;
 b=twPMW1o3bD9O7KuJHdn0gZtFYmXWQlHb2srGgQ3IwrVjYZkkvkp8Hj148gz3zMjBMV
 clgzVcz/cc1vClktGojCzQ6nPn1mP6RgWYPzdUtXNDgvUSHoLtC8smSO25qnrBz0J7NM
 6ykTJ0Xw3Gvixtw0OIR0LsaAWIcY+9b2zvQkjh+h5g2KCAY0pOk/266LkgjE2LjeuHTy
 kB0kDRy37+cuIy35L2EmIapKKnb1v8v79RlbukltcwhxKDNRIgHWPpEl8Dq+T9uxBTsi
 DBrANZLqNHK3U2LbvTw+LsDJl34UZbKpCL0rmKbRjUOYWXuJRpBIGvLjktKQpb0iSYWp
 ICrA==
X-Gm-Message-State: AOJu0YzkDxXnJidkd4xI4xoFkvW5+bza3oAG9ymPWq/Ye8cQIFnNOBs6
 lItxuO3ZTFev2eXgx6oncmdfLJoLcuXzKA2eCz5pBDKazqzzjiu4RCFBFPFLvic=
X-Gm-Gg: ASbGncsBSo4j8yroLeJ3ZMXTsYJ9YXqw0PZEc67Irk60Pv045VJuk0mLenLom4lcCzy
 Y/DItV4Uz/m2sTkqq9OfP0yZnITILzG7HiVXIKIAYudKfKu27JnVmQE+YBo4DxotuFCskSxQSAX
 2AsPj15g4wy+H5LTzklOBTqDfTacJhpjzpBpQCpzUKFwwTm0XgiY/oNtfKed+EXW+HxfXKoVzoo
 im3/58GSmuztKG2xIPrkDD3WDRFDvLB/8zfXEZtt2PJKN+2OHHW1hJx7DNwbpFcIHdMqWLm8UgT
 1MtQggdLzDnEMSYFlw==
X-Google-Smtp-Source: AGHT+IEmHDcEImIvrclUA/qAU5cmhVTzbUXS1iMJBfJNnav8qnNInKxAVTpiX3i7xRFS8f3+RizPOQ==
X-Received: by 2002:a17:907:968f:b0:ab6:cf9c:584a with SMTP id
 a640c23a62f3a-ab6cfce8973mr1202703766b.15.1738325963889; 
 Fri, 31 Jan 2025 04:19:23 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ffd63sm288208366b.94.2025.01.31.04.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 04:19:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 332B95F93F;
 Fri, 31 Jan 2025 12:19:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  imp@bsdimp.com,  kevans@freebsd.org,
 gaosong@loongson.cn,  laurent@vivier.eu
Subject: Re: [PATCH 4/6] tcg:tlb: use tcg_debug_assert() in
 assert_cpu_is_self()
In-Reply-To: <20250129134436.1240740-5-imammedo@redhat.com> (Igor Mammedov's
 message of "Wed, 29 Jan 2025 14:44:34 +0100")
References: <20250129134436.1240740-1-imammedo@redhat.com>
 <20250129134436.1240740-5-imammedo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 31 Jan 2025 12:19:22 +0000
Message-ID: <8734gz2n1x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Igor Mammedov <imammedo@redhat.com> writes:

> that will enable assert_cpu_is_self when QEMU is configured with
>    --enable-debug
> without need for manual patching DEBUG_TLB_GATE define.
>
> Need to manually path DEBUG_TLB_GATE define to enable assert,
> let regression caused by [1] creep in unnoticed.
>
> 1) 30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flush=
ing")
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b4ccf0cdcb..71207d6dbf 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -61,8 +61,8 @@
>  #  define DEBUG_TLB_LOG_GATE 0
>  # endif
>  #else
> -# define DEBUG_TLB_GATE 0
> -# define DEBUG_TLB_LOG_GATE 0
> +# define DEBUG_TLB_GATE 1
> +# define DEBUG_TLB_LOG_GATE 1
>  #endif

This shouldn't be changed because it still gates the much more expensive
tlb_debug() which hasn't yet been converted to trace points.

>=20=20
>  #define tlb_debug(fmt, ...) do { \
> @@ -74,11 +74,8 @@
>      } \
>  } while (0)
>=20=20
> -#define assert_cpu_is_self(cpu) do {                              \
> -        if (DEBUG_TLB_GATE) {                                     \
> -            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
> -        }                                                         \
> -    } while (0)
> +#define assert_cpu_is_self(cpu)                             \
> +    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu))
>

This is fine.


>  /* run_on_cpu_data.target_ptr should always be big enough for a
>   * vaddr even on 32 bit builds

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


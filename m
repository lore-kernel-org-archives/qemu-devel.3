Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E438BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cgr-0003Ky-LW; Tue, 14 Oct 2025 06:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cgq-0003Kn-Eb
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:55:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cgn-0005Pe-LN
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:55:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso2585939f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760439328; x=1761044128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04Z3mfhq5zI4iOJd+S8SAkRPm06yXMvU8qyFNTA0ZFE=;
 b=AnJkqEYwNp6FT4RxFBiB2jB+kr6wbqy03HKq5Yvop4Df6hvaVUZvL1AvMnSXlSFDaO
 BGAQzWGG2ZYzNXm+3VEGPw6j8t9/rG4QGJiMFAV73Ifiruphb6B02wyzXIKeVICQLZi/
 2G822whaYjPe1Jno3Hdv59TScvgVFUa9GwuVcgy01HR48TZxTE2xqVWx+PX0mI0SgZ4n
 JbFTJE+DsxUKZ/Sr4pYDIORjfhK79V0qaDrKG/88qwV7W7A8S4o3sNpOqdlIpOwSJsBK
 NfHJwdy3esR729hxSjA4iT6l6tRQm1jIPoeXIw61wN+LoPhZQyulJNXEEnHhkEKXAMvO
 YM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760439329; x=1761044129;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=04Z3mfhq5zI4iOJd+S8SAkRPm06yXMvU8qyFNTA0ZFE=;
 b=vvtNCrnCkOrclHSX09UdIp70xbUYw+rXZGl0rC0wn4CksStO2Lxy8KFIuVM1n3YtPQ
 a2R/d5P5a0jHM7MEeY1QCDnkZB0AVNBy31YuGeFJIOYGsMe7PXPwqaQTu45py/xuPtd5
 x6HKWhWXrl0RbB2hyw+1kt54vywHeB2vSqGzsbN+unN/n/yid0+tWXd8VqohiBVmqFnQ
 FIKXIHf/1Md99yEnT7m8ByXIsXXHyYN5CqmULufrQvqzk/I/mxS6AtpE6dfaCjN5vsbW
 ARGqUve+RtiyhM9R+xuRO0GuiL9RXMrgEBox6sae3zI/TB+eru00NJnhb/cmUPxY98HY
 DnTA==
X-Gm-Message-State: AOJu0Yy+mJtxVyquKo27XFqZPEdwYKVJSTZ/yjpXUpoZGOhO6BHz/thW
 goNhTBzxgVQvG7HuMcTYR3CZKbtCc4Kjs/iZLjjk9/NpmVx/JxxUKmQXdhpZK7yZnuk=
X-Gm-Gg: ASbGncs8mPQeyUKcFMjzpwI8VSoGPG24pmjQzAep+NrvuVc8yx+GgGzdYH0Co9nZFnQ
 /doPBmdX6KmEOz/vvOI72eUY2jy6A7YKO03p5GbFtwHv/FU5z4o6EQzX3dFTkeY3zjS4elqsN8f
 VMm7rxRv5wL4qJIokeJ6JcebhISjr678GAT0E3rB8YE2rqmx749jvqibJthlUzlshxWJvhiX9t2
 C4Sk2/vPhqJ9y/Zeg/sjR4NE9CdFvbwRte90T4D34YOpD1/6TDWSiLXNEmvQesJPqhj+y1p0SXD
 eS0oJN3FC054Df8XoAkz1POtqXXupVInnEIcsyBaX+odeTJmqWjd26rAQZprkJO85us/4wPqSeR
 gK303FTEgoVsPVuIEbXtZ39BQcUXaOkbWJCGM55FRiZDaaA==
X-Google-Smtp-Source: AGHT+IF9j8kGvl29bTwBTP2VOHLdTB66eF/QLmVUEzAdg8uJ+dDhJ2zcLoth0B0mYZpxroJgf4Nn+w==
X-Received: by 2002:a05:6000:26c3:b0:3e7:6418:247b with SMTP id
 ffacd0b85a97d-42666ab2959mr14224937f8f.10.1760439328602; 
 Tue, 14 Oct 2025 03:55:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d447sm23627421f8f.9.2025.10.14.03.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:55:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 05FBF5F812;
 Tue, 14 Oct 2025 11:55:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Song Gao <gaosong@loongson.cn>
Subject: Re: [PATCH v7 10/25] target/loongarch: call plugin trap callbacks
In-Reply-To: <21a5bf2e810e2c1a3d278ba3ed98f4d4491763cb.1759744337.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 6 Oct 2025 11:57:05 +0200")
References: <cover.1759744337.git.neither@nut.email>
 <21a5bf2e810e2c1a3d278ba3ed98f4d4491763cb.1759744337.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 14 Oct 2025 11:55:26 +0100
Message-ID: <87347ln469.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Julian Ganz <neither@nut.email> writes:

> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for loongarch targets. This architecture
> has one special "exception" for interrupts and no host calls.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  target/loongarch/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)

This fails to apply now - I think because the TCG functions have moved
to target/loongarch/tcg/tcg_cpu.c

>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 993602fb8c..a8299dfee6 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -32,6 +32,7 @@
>  #include "accel/tcg/cpu-ldst.h"
>  #include "accel/tcg/cpu-ops.h"
>  #include "tcg/tcg.h"
> +#include "qemu/plugin.h"
>  #endif
>  #include "tcg/tcg_loongarch.h"
>=20=20
> @@ -172,6 +173,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>      int cause =3D -1;
>      bool tlbfill =3D FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
>      uint32_t vec_size =3D FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
> +    uint64_t last_pc =3D env->pc;
>=20=20
>      if (cs->exception_index !=3D EXCCODE_INT) {
>          qemu_log_mask(CPU_LOG_INT,
> @@ -282,6 +284,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>                        __func__, env->pc, env->CSR_ERA,
>                        cause, env->CSR_BADV, env->CSR_DERA, vector,
>                        env->CSR_ECFG, env->CSR_ESTAT);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>      } else {
>          if (tlbfill) {
>              set_pc(env, env->CSR_TLBRENTRY);
> @@ -300,6 +303,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>                        tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
>                        env->CSR_BADI, env->gpr[11], cs->cpu_index,
>                        env->CSR_ASID);
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>      }
>      cs->exception_index =3D -1;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


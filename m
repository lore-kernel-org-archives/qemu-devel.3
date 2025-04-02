Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41B4C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 23:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u07Cl-0003b5-CV; Wed, 02 Apr 2025 19:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u07Ci-0003an-GD
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 19:09:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u07Cf-0005KL-4Q
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 19:09:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43948021a45so2403635e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743635339; x=1744240139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nqpdw1BCzuNpleOvMU7KwIa7fQDl8K7+/9/Q4enNusI=;
 b=zUqGgtIJpmq46c4EU2Nt2dzqKSKPugBS24kkpHaLIxA21kqNXnGlMfz2ul+hzKD68p
 MqGJ/v/3SWeJvnMbYm/nQKjtzMawMQ+LMAWvFQ1+W8yyGhdk7uRE4HV91deI3UrHvQ0r
 Y1pfiiTfnwN5o6M6A+wu3mnII02CQJI0tJJ6FipTFGMkVYQtI8TJI+fQ5Ep7WPlFT1fc
 bNPzG/YGEnPzkPKV/9ZHuPGQFrmjXjAAv6riMjiKQBgocsLwhVaJU7t2MrdttHwD4SXf
 s6Y4YDZcn4OzqSr9WvpJTts8T1Me57heh+U57SKxyGbl3L2C0r7HdJhiB5GO/taaQ/YH
 CS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743635339; x=1744240139;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nqpdw1BCzuNpleOvMU7KwIa7fQDl8K7+/9/Q4enNusI=;
 b=HGSfoQJpwNrXXhwM1oQ4MX2C5N2X2kY7T8lWDp57mqoVUzYImHZZ9LlRSI04pEQZmk
 I8wbXykzVBe3KLPx7tfAjiFACXBkc+l11Q0NvGcgJTqdlAhCcNQFdX9qGqn4sp53At0V
 PfQ6/m2vWmIUqEUxROoY4eRAa7J+AvMYuGm7Iqh31ghxy4qln9Zpajo7J5dVe3yWgBT+
 SKy/giC8AftNhriHLKdkYGGn5HtYETD7WHoQ1C+IvZXbDCo3xTXII53vGDf0bDgxP1Re
 MG/w0iTsBvoWD1tnb8+FLVYGQZwTApTZZw9YuxSG7z45+85MBMKmrR1q6Gu4tgfVlvlz
 Z8kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQrrsWF3vKZXymvVOVNN6UHODg6UnZWVTk3beU9RqSxO65QGxyDwuV/GHK41WvAtmuCI7UH2tvf//P@nongnu.org
X-Gm-Message-State: AOJu0Yxam7bYbh9Z4XYA9nd0JDg3FcAk+J1EAyAsIyhRtPezGRZChLTU
 bNiaU8t3DC6wtuPRaAQCcEWd6257pLAyAaAUWhq/GZoIRzG5GiIUvo/fDUMy8ywHtxiK/8m7hzp
 Q
X-Gm-Gg: ASbGncu2h71guiN85/OZM5d6GQc0sQrJeR9wOY3ufSIEn82M2yskOT285q+gxWX5bVJ
 i0pgtCp9+oejoiCeNV+Ad8s5zXuvA0jPguwO0xx1VPZb4ubRB0PvvciskEi4Nh60aC5hgTT0q1q
 XOz873atdG6oOh38RCK0qTFq6Vr04XJcIVKFwCuWIqXqyduXOFQEBpX69p0JTlXsUpCDqFR2WZ8
 xgP+Vj3G8+UAYTJwOK2X7AXZt3+MeQY8SFEMPcWJC334oLWfzNiDkcgJH2dBwwH22axvH/OCEFP
 nZGCawZBrvkHVGSWiaRL1SM2Ypq2dI64SYsJIUYZjpvjuHLY6kAyJqOLfyXkkfgt0MC6RPkRSVt
 7y6ICML0Mfi7H9Fqq0L/LDkU=
X-Google-Smtp-Source: AGHT+IFsVBvVrOBoowgFQM9zr0aFphzh43W6xuFcVW6Kdls4nIPuCNGjluuhemCdg+BAcUR+wxEgDg==
X-Received: by 2002:a05:600c:1e0d:b0:43d:2313:7b54 with SMTP id
 5b1f17b1804b1-43db61d78c9mr178770795e9.3.1743635338975; 
 Wed, 02 Apr 2025 16:08:58 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b7dedsm136824f8f.52.2025.04.02.16.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 16:08:58 -0700 (PDT)
Message-ID: <a7b866ed-20a6-474a-9bec-27f6decff0b8@linaro.org>
Date: Thu, 3 Apr 2025 01:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 17/43] target/ppc: Restrict SoftMMU mmu_index()
 to TCG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250402210328.52897-1-philmd@linaro.org>
 <20250402210328.52897-18-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250402210328.52897-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 2/4/25 23:03, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/cpu_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 3686bbc9380..30238e9a223 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7481,6 +7481,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>     .initialize = ppc_translate_init,
>     .translate_code = ppc_translate_code,
>     .restore_state_to_opc = ppc_restore_state_to_opc,
> +  .mmu_index = ppc_cpu_mmu_index,
>   
>   #ifdef CONFIG_USER_ONLY
>     .record_sigsegv = ppc_cpu_record_sigsegv,
> @@ -7517,7 +7518,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>                                          &pcc->parent_phases);
>   
>       cc->class_by_name = ppc_cpu_class_by_name;
> -    cc->mmu_index = ppc_cpu_mmu_index;
>       cc->dump_state = ppc_cpu_dump_state;
>       cc->set_pc = ppc_cpu_set_pc;
>       cc->get_pc = ppc_cpu_get_pc;

Missing:

-- >8 --
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 4963816e1f..ae5d034bd4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7217,2 +7217,7 @@ static void ppc_restore_state_to_opc(CPUState *cs,
  }
+
+static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return ppc_env_mmu_index(cpu_env(cs), ifetch);
+}
  #endif /* CONFIG_TCG */
@@ -7226,7 +7231,2 @@ static bool ppc_cpu_has_work(CPUState *cs)

-static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return ppc_env_mmu_index(cpu_env(cs), ifetch);
-}
-
  static void ppc_cpu_reset_hold(Object *obj, ResetType type)
---

With following description:

---
Convert CPUClass::mmu_index() to TCGCPUOps::mmu_index(),
restricting ppc_cpu_mmu_index() to TCG #ifdef.
---


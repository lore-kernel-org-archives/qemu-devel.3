Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E279C5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sikRw-000566-Ss; Mon, 26 Aug 2024 20:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sikRs-00055O-KT
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:52:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sikRq-0002th-2p
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:52:40 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-201fbd0d7c2so39961285ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724719956; x=1725324756;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=73tjzoGeT41vUtI8RXb1w4Pqe+gWH+Qjk8sKoKRSDjk=;
 b=SdxjkuMFhvMHormxPE5VnI4i6CPatGQj9L73v/Dbwyp8ZzSI51gJZK6k6BS2rmZVQU
 BYW12VnSS0J41iSynv6D2Bvf0Wtn3CIMpRJn8PmX1lX/CisS2VdeQzOg/+mz/hJgbWRh
 umo9CrbcI3gBgSz1E3YOf6Aia7xLe9JyeTANaz7vpgIzMd0xbGNx/G8sUbmacQEPlyel
 TAoUQr5D4H83TE8Zjqru42vuiijt4KZMBTR3innC+LTPTvWV2JVUJofmyqs34Pv4tnET
 r3G0YpuLFFJj9F3mmHflefQdtnzCizWPhK43X5OuA92ZCK5p8RObGGLfqSpduDI6AXOQ
 iyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724719956; x=1725324756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73tjzoGeT41vUtI8RXb1w4Pqe+gWH+Qjk8sKoKRSDjk=;
 b=O6hJE/xw+54FI6V6aqL38lVNuHSFI6TZnyU2czqIsq0YAXotN6Gpnvq2aoPM9zCNoc
 3fFaI+UeHZAIRq4PTgLPTox0peQxcxnHyIvJmCiSnFL7rtb3FAggcz47Mn85cZudPn9D
 JdqrKAzEdYwmvdVZk8j7HslurzjXQ4FDCsQW6nhDO/qlmBvAhQbo/W7r3TIjVdi43i75
 mzIXxMXnpjUZW2+ZSVh0vgcGki76sk0zARc2BeL7+tRuUMJLnKNR/WYcw2WmSzUyGODc
 +gmJBmqDMX5MA6k/NVVmAP5C5wQdUkGV5XHpJN3VENKczEEMiEtKKvNVC9yVnFaKrh93
 emkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5PTAhsYF1ScackAiQcE9QIOUZxGYYCjEqPAmEJdgkFnCYmGW3fgedp7nCImeu9P8CHRaYALFUfT9u@nongnu.org
X-Gm-Message-State: AOJu0Yxl+c8kIeJvJshIKsyJUqECa5AN1GH7UBm8FGgNfrr5IJl/KXuT
 RGYa/tqJfWPFygRnTZUKScUu2nJetbYbKmwrrfTYQKQyJeGQw1vhW4VWlXMXXHs=
X-Google-Smtp-Source: AGHT+IE2wNPHOkKJT38SYz3ukizmWvOhA8Lm0ssYXiAuvT6CT3R4azyfU8MmUeC6cKfdSY3VkX0UIw==
X-Received: by 2002:a17:902:c411:b0:203:a046:c676 with SMTP id
 d9443c01a7336-204ddfe8059mr12891275ad.0.1724719956013; 
 Mon, 26 Aug 2024 17:52:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c373b5sm43158275ad.189.2024.08.26.17.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 17:52:35 -0700 (PDT)
Date: Mon, 26 Aug 2024 17:52:33 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v9 03/17] target/riscv: save and restore elp state on
 priv transitions
Message-ID: <Zs0jURx7jbgd64jV@debug.ba.rivosinc.com>
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-4-debug@rivosinc.com>
 <da021104-6836-4e5b-a8a4-991f975c553c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <da021104-6836-4e5b-a8a4-991f975c553c@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 10:33:04AM +1000, Richard Henderson wrote:
>On 8/27/24 01:29, Deepak Gupta wrote:
>>diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>index 8e1f05e5b1..083d405516 100644
>>--- a/target/riscv/cpu.c
>>+++ b/target/riscv/cpu.c
>>@@ -1022,6 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>      env->load_res = -1;
>>      set_default_nan_mode(1, &env->fp_status);
>>+#ifdef CONFIG_USER_ONLY
>>+    /* qemu-user for riscv, fcfi is off by default */
>>+    env->ufcfien = false;
>>+#endif
>...
>>@@ -226,6 +226,7 @@ struct CPUArchState {
>>      bool      elp;
>>  #ifdef CONFIG_USER_ONLY
>>      uint32_t elf_flags;
>>+    bool ufcfien;
>>  #endif
>
>Thinking about this more, I think adding separate controls for 
>user-only is a bad precedent to set.  You said you are adding these 
>because senvcfg/menvcfg are ifdefed: well, that should be the thing 
>that we fix.

If a binary is compiled with zicbo, it'll have those instructions in user
binary. I am not sure how those binaries will run on qemu-user (or if it was
tested with qemu-user)

In case of zicfilp + zicfiss we are runnning binaries compiled with zicfilp
and zicfiss with qemu-user and qemu-system both. Use of qemu-user to generate
traces for feeding into CPU modeling is quite useful. Thus mechanism to track
if landing pad and shadow stack is enabled for current user task (in case of
qemu-user) is very useful.

senvcfg and menvcfg belong to S and M state and don't actually mean anything
for qemu-user. However if that's how it is for arm as well (i.e. exposing system
state for qemu-user), then probably there is precedent.
But it looks like a much larger exercise to me.

>
>The only real user of *envcfg that I see so far is check_zicbo_envcfg, 
>which does not use the same switch statement as this:
>
>>+    switch (env->priv) {
>>+    case PRV_U:
>>+        if (riscv_has_ext(env, RVS)) {
>>+            return env->senvcfg & MENVCFG_LPE;
>>+        }
>>+        return env->menvcfg & MENVCFG_LPE;
>>+    case PRV_S:
>>+        if (env->virt_enabled) {
>>+            return env->henvcfg & HENVCFG_LPE;
>>+        }
>>+        return env->menvcfg & MENVCFG_LPE;
>>+    case PRV_M:
>>+        return env->mseccfg & MSECCFG_MLPE;
>>+    default:
>>+        g_assert_not_reached();
>>+    }
>
>I think your function should look more like check_zicbo_envcfg: (1) 
>PRV_U may be either U or VU, and different tests apply; (2) M-mode 
>disable means that no lower level may be enabled.

In case of landing pad, (2) doesn't hold true. Each mode can independently
enable landing pad for next lower mode even if it wasn't enabled for current
mode. Reason being that you can have a firmware which is still not landing pad
enabled and you would want to avoid landing pad related faults in M mode but
still want to make sure S mode and U mode can enable landing pad for themselves.
Same goes with respect to S mode, S mode can have its landing pad disabled while
it can enable landing pad for U mode.

Although logic for shadow stack enable is same as zicbo. Shadow stack enable requires
target software to opt-in by having instructions compiled in and doesn't impact 
behavior of existing instructions.

>
>It would be nice if you could generalize check_zicbo_envcfg to apply 
>to your new use as well.  Perhaps some tri-state function to say 
>"enabled", "disabled", "virtual disabled".

So while shadow stack and zicbo are similar in terms of enabling. Landing pad
enable differs. 

You still want me to generalize *envcfg flow?
>
>
>r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94EEC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPU-0002v3-4k; Mon, 13 May 2024 03:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPE-0002nE-AL
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP4-0001Jm-J7
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:32 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e43c481b53so50102431fa.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586441; x=1716191241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9boudcCOGEVYkNrscgu8HWtkLEddppv4wDb4lWwH3M=;
 b=THxqmqN/EmdmzAsZggy5Yy5EsG3gfyPi4QfcDX+iOWx8fX/+SwXCaU7WlyYh3CsQ15
 B8TCM+Phly6xRjuOUIhWMebqEKdA4UdJ0Syf+ZEEEUCY7KQgWLcfuDm57hDR84kDvtxj
 f7sXmuQ60gyeiTCiPd/nAV8PvW5/zbNB+5tZi2vTnxc/Ms286txvQ2z6xsyAMuteJ4kb
 xP4g2UOLmrm3TowuA/LYQXLsV6M9p3Nr0cEvDHjNSFLnCX3Foty8FhMonB4Hs4ma5FTW
 ItAVM+5qZgsr1ZelRKttrkJweNuk5Zl5TPEKKsmAfBR3gfvVDpEwmhs9TyuWTFupEgjF
 yKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586441; x=1716191241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9boudcCOGEVYkNrscgu8HWtkLEddppv4wDb4lWwH3M=;
 b=wZb2TQSloOOIU/2E22cMbQchtVxdUna7jTW1e0krhLOLZO+toydC0XFRIRNcVE99JY
 QmHXDoxwV3eo71EkCoj1EUZ+i2zudZmkChmUdfMjQ26JkcovEtRrfIq8XoPWsx2v1ML5
 M7hm4klVz5NOdBdisABdnFg7+WP/Mo9rKfL2xTtEhAXUfvLsVHwYxp4MMxzJTCee5/6a
 e3l8tf/3jYvFzMG6lb8nCssL+8oja4dZs5ymXmmhYMAhy+LxippG6iFrS4knSijLezAB
 hQGzDlMIdRn+C9Incarp7M/cswnB8wazeHI1YRIoC8Z7y3zN7zhfYs4otamKWnTqfs7Y
 2Fag==
X-Gm-Message-State: AOJu0Yz4uLX3O/n30j2pFBnj60VJosbcbGlILgCvkt1aT8aa8P+ppvW7
 vqufOPeD/uDrAFWhl15kEfecqQj+9qliEpD38alb4wlYCwo1K877J3u5+sPzDEY0UTGsydJDef2
 UKyY=
X-Google-Smtp-Source: AGHT+IH+Vvm/I2rgO34Jclmma7qPq440dWyEREmjFlB+26uERjUq7JtIyp2GKkk0qzVtJ9Fd0xvdCg==
X-Received: by 2002:a2e:8748:0:b0:2d8:a921:dfc1 with SMTP id
 38308e7fff4ca-2e51fd4b3c2mr56017951fa.20.1715586440666; 
 Mon, 13 May 2024 00:47:20 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 02/45] target/hppa: Use hppa_form_gva_psw in hppa_cpu_get_pc
Date: Mon, 13 May 2024 09:46:34 +0200
Message-Id: <20240513074717.130949-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This function is for log_pc(), which needs to produce a
similar result to cpu_get_tb_cpu_state().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 582036b31e..be8c558014 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -38,9 +38,10 @@ static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 
 static vaddr hppa_cpu_get_pc(CPUState *cs)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = cpu_env(cs);
 
-    return cpu->env.iaoq_f;
+    return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                             env->iaoq_f & -4);
 }
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
@@ -61,8 +62,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
-    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                            env->iaoq_f & -4);
+    *pc = hppa_cpu_get_pc(env_cpu(env));
     *cs_base = env->iasq_f;
 
     /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-- 
2.34.1



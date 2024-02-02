Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC24C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSP-0001Fi-T8; Fri, 02 Feb 2024 00:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSJ-0001De-3a
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:15 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSE-0001j2-TI
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:13 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bda4bd14e2so1399450b6e.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853070; x=1707457870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJNaEL6q2/07U1Rp9ME1A8CbXMNqHRbwoUgEMBnXwIs=;
 b=SrEQ0d9EM9DBbzKXxXh/oLclf0LUmK3iEVBmVEcyWiWYT5Z6HzgKQxTW53SIU3LTBF
 ocGTPQf2wstPvG80/Jgk2eGvpuRFNkMrCD7kzp3D2VbI0aw9KV54DjU0cVZ5TMUA7wvD
 c0Rsazvt5DpdSxQ4rZV5D1i/6BC3QZqyqKOoVGecSwjuTAywwtFK0SWsUKcowqS8sjyI
 FUM5LTbfcXKDKDUkeSTKXJWrYBPY5n1OPPbh+LiHJakXZVXg8y/gS/bMNXKXrIGZdgNa
 4o+wF5YcETnIzCH5RIXef3NznO/bmUbDlJoNIIY718zKlIuMBCQlz/LCkm9KEIwm4MTx
 +V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853070; x=1707457870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJNaEL6q2/07U1Rp9ME1A8CbXMNqHRbwoUgEMBnXwIs=;
 b=bO3JsNHr9FOVPJFqd8Sy23fpqKOJYlYPIGPm4RAJOZRozmhTNWv2tHpAU3+bmJoCdg
 Q2TBtJl3beEHB26kwv1gSaBdV7R5warHaB0bn9WfFzL4kQtAfZmhdp6bpk06UD7oS/Ge
 XboZiStO0vhMwNpEMiURI3CrToSH5CiE1HyK4zfZ6zWNoSX1yjMNYBLC1GbYpHfXRtZY
 sR6fgdsvA0nMfAgNHjCuJBiOYRl8IOzbbRK0jWXnS/NTSPKq1trp0K30dXvOvn8SYkjy
 lSiYfiKDMsPRCO5WamzAPQhChUBVG0puXn2lIlOnOLAQLAKgcmsRGvx5BJblua7Ux1p9
 yzTw==
X-Gm-Message-State: AOJu0YzJoTdxJBxVOIu+UjWbjSdfSAnTTrKyluM5AJSZl0kL7GOarVwZ
 YrVdEouPRFZn3MdFOSgtW1j7IzHUmwMNApGv5szgQgJ8f4QJE9Mwr22CxD6PHAsB+RWa6IA1F0/
 sM1M=
X-Google-Smtp-Source: AGHT+IH2ERz2cD9E7sMTYnoaRCE2+AER0N8Y3lg4+6BawYjNo8UZTIeCy6ZP+7kBDWSSDZdsrCkRsw==
X-Received: by 2002:a05:6808:2089:b0:3be:a295:c54a with SMTP id
 s9-20020a056808208900b003bea295c54amr8355631oiw.0.1706853069909; 
 Thu, 01 Feb 2024 21:51:09 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/57] target/m68k: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:52 +1000
Message-Id: <20240202055036.684176-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 44000f5869..8a8392e694 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -56,6 +56,11 @@ static bool m68k_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
+static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return cpu_env(cs)->sr & SR_S ? MMU_KERNEL_IDX : MMU_USER_IDX;
+}
+
 static void m68k_set_feature(CPUM68KState *env, int feature)
 {
     env->features |= BIT_ULL(feature);
@@ -551,6 +556,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
+    cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
-- 
2.34.1



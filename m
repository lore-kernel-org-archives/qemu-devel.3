Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D2AC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSv-0001w9-AA; Fri, 02 Feb 2024 00:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSt-0001kj-1C
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:51 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSr-00023x-De
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:50 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6de287449f1so1222022b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853108; x=1707457908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PC40RdxCsq43L7ljbEAmMpAkaTqLbVzOzu0xDoUXTU=;
 b=YLODSh54pKB41W2nSWh/1dk/2+Ehqt5d/h/YpDE0kv576QqSftb4hj7QudlK55drfV
 0msek67w6QDVuDEvnNyNmS/L0x+267Qla0nyORXFxSzcY6P9d7Z+ktu/StBQwwE9bqRV
 wemLRFkNImxrtIef/Puaar9I9j+1wko3rT1jxuIia0D1NNxGZZZBxMRkQAtzrj+BuNeO
 amBMisSoOUdqMbi149lHXxeD0F8Wdu6hfoXk9IBret00/RProiNID79ulCL4Amk0RRLe
 Rpkwc5iGhjlj2tgwhBQ14yWK1/GZx2S8P3MYXbkcvWKthnNnnNdXjgEXkCDQZh7m4diD
 xSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853108; x=1707457908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PC40RdxCsq43L7ljbEAmMpAkaTqLbVzOzu0xDoUXTU=;
 b=OOlzeSf+Xm+JOOSqF7b9WlmtrtHnun/tWPJ9auduwcnAbqXRmnGNXdtcdW8a+wmDo8
 DfxH54cMumDScVysNsaryvFvR7cwm9mu2lZo46cJFcfZOLNUQsgBAdSTbNZ6KjYklBro
 Rkg/MWPA4fqvFAOdV/jODdMmvvf1yPBX1cAEUOgCh5YmG/A5G29bZgt2epucB4SwCEC6
 7DBmkVWCtXer6U+mdt6HZFKOOyWUFD0StK09kPO3eYEGQ5tGeOUCDWdAGMRe2STgJ/DE
 ChwOTOBrU2TqZiLCjeHTiIFCc546J+B4AlnezInlLZc73o5fGRB6HuxtliVVSvwMqsJB
 nwhg==
X-Gm-Message-State: AOJu0YzcWhjkyu6jbrsgoWZrl9r1sWIWJrO3ZyIViC2mUSbQeVyOjbT8
 HKp9T3MKekxxdeeywM1Kaa6M471KYcsEJargWAmxH/MTZUTxIbLaQ4nuGdDMep81gRBLB5A0bM6
 If0Q=
X-Google-Smtp-Source: AGHT+IH/DtqpK8uC5w9oWNCpEt/99cZpq97VkJw03JRh5MD6u4Cawxe/nAofKlqcJKnhoVFveWyelA==
X-Received: by 2002:aa7:844d:0:b0:6db:8b3a:ec0d with SMTP id
 r13-20020aa7844d000000b006db8b3aec0dmr7285194pfn.9.1706853108043; 
 Thu, 01 Feb 2024 21:51:48 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/57] target/xtensa: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:10 +1000
Message-Id: <20240202055036.684176-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/xtensa/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 62020b1f33..79f91819df 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -74,6 +74,11 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #endif
 }
 
+static int xtensa_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return xtensa_get_cring(cpu_env(cs));
+}
+
 #ifdef CONFIG_USER_ONLY
 static bool abi_call0;
 
@@ -252,6 +257,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = xtensa_cpu_class_by_name;
     cc->has_work = xtensa_cpu_has_work;
+    cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
-- 
2.34.1



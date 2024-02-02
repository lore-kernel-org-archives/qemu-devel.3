Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A5C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmS1-000196-B4; Fri, 02 Feb 2024 00:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS0-00017w-0u
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:56 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRy-0001dU-IF
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:55 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so1205110b6e.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853053; x=1707457853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAFj9xK8iYl2K7L1Y8DNUJSyua1dAxxrWDyOxstfeWU=;
 b=VJk2m61Vp9CO1VTeGJGFjs0BMu41c1fLQfT7zk0XQX9/OyakPNwH/RN1/IwL32E3VO
 zFQlyVz95J6tdOtfZ+ogF6Wgg9613r/aas+/OVXQJvsvTngTM8M601pEFSQ7LTLzei7w
 Xx7n+Ugvi5BV/AmErY4WvUMbrpLQ6IAx/knW61AheoHz1nPZJfpkDsUxSkL/fQIJnIOF
 YkzgS5kOD20oq4Li2FYXIuhPhjAEzARYv3oFOp8FZj9PymAzmnEjOtdS9mOgLKLvg9Wp
 GCsGS6tDmExJ2W9QiRsXu079kt2Okrfraol685wBXvXTtbw9C+VYGNX321DjsNyZa/mY
 INeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853053; x=1707457853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vAFj9xK8iYl2K7L1Y8DNUJSyua1dAxxrWDyOxstfeWU=;
 b=uXK8tSd8/zZCR8SznAClCATlOID3+C94NBRrScHGvbSaT6cSFG5Saf81Wvy+AKB8qF
 SNpkA50TyUauc5pW+YV9cn0vOeR/0oQ4j9ddgLYCP2Zwkl5JmpZx2uAyibzevva8oBXr
 r20eY6OyyV/PjdykRGVOr90fypFiGG9EoVHv0HyIoERrojonDGTHCV1L+4Keew8hxNbe
 lQH4M/HEh4M3snnwanblkUsjKKw7wz9B+uvSLSauvCCEl22XM8/uJZDgvQP8lcZ2xXCW
 I4tiT/9mkrgYCKDQhuFptdg1k/J2viglxepu3ljZBXKt5Z3qKcSccBo2He+hHIoDW7r8
 2pyA==
X-Gm-Message-State: AOJu0YwCJHFDIuMQBJMSQ1uIkulJZJYz4YYks9VrqiZJ8Js44F+hyCsp
 WEUohOSYI42GkXXXXrDUlw7K4ASIx02arQMUIvQit4m7hPz/SGfzG6LOx/GgvJ/uVsyq3UZqPOX
 WSco=
X-Google-Smtp-Source: AGHT+IHsf3chNcFWm0+gSeZcQCRuT75UVkB4SfmiS52SbMpSobfsimQOJkmmvxB6z2y1hKIJOcJF3Q==
X-Received: by 2002:a05:6808:14d6:b0:3bf:c3bf:ffcb with SMTP id
 f22-20020a05680814d600b003bfc3bfffcbmr50321oiw.46.1706853053172; 
 Thu, 01 Feb 2024 21:50:53 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/57] target/arm: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:44 +1000
Message-Id: <20240202055036.684176-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 target/arm/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6a96b245f2..1f9ea622bd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -133,6 +133,11 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_EXITTB);
 }
 
+static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return arm_env_mmu_index(cpu_env(cs));
+}
+
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -2497,6 +2502,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = arm_cpu_class_by_name;
     cc->has_work = arm_cpu_has_work;
+    cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E8CC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSt-0001jf-0m; Fri, 02 Feb 2024 00:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSq-0001aO-HJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:48 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSl-0001wQ-Hj
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:48 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbc649c275so1029806b6e.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853096; x=1707457896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HOOME8FRq7OakS6NFzHSp/K+z8pT26NgXnqvXCF5X4=;
 b=xGaPjMB0vH3QIjG8gvOb2+w06JM+/JgcPSjh0JEROYAB7c2wAc0xJlV6I9YCuv1k5z
 gGhOq3WOj+ekoaF3RA1bNPC0vV3JI3ldoEpQ+/np7KTpU+huEoEwnKNazAhg0Am70Mmd
 9GPKlhe6uRmWmVYXBn36doE0nm5kEz+D+TkusN+tlhXQQrU3s/RgH1uLRBlBBzstyDFS
 2lEc3EFbYN4rxwym6rAPUd32N5MiGYOjjALfPUfp/G4duL1tiH38KW+yPco5yEcRK7Ux
 Kg+tZQffoKL8yJo0bS92LDOeIJftn69i9JzLW77ZooTyn4NsqKjY73cijkTzCXqvJfxF
 3NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853096; x=1707457896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HOOME8FRq7OakS6NFzHSp/K+z8pT26NgXnqvXCF5X4=;
 b=uyXAcWR8+sqtO63iSfn8BqbXz/JMfZPos2HR/h1EyUi92Fx4UFSGfHbiPyYk7JXJh+
 X9tseg+dMY3R/tJ0gsSYLx2b7IEN2vA11oOF6kd8t8WeSS4jSeLco01IEcHZXuwpAkM3
 xIl2F1Hk+1PoQxZLTGHFNDrf34Q0cfJPurC/tXcChnl7wqKiocHXEhisc5hic5HIOXds
 jAzJSO66wW8Cn/qcImC3u8Lzvk/DhVLSl14W5r2nqAxK+xJha5n9NmpESQbsEylqLL6I
 hIQ6ZvII6mBKUqSRnlXEswzmfKZ/cGfEAmJOaWiS+7JxK3DTe8mzwDNAv08FgbBPnIt+
 Q0/A==
X-Gm-Message-State: AOJu0YzEj8fVMmUiefjwZRYuNKN50P0DpxpR9R0Nk6W9NeKUIMoxRWOj
 rroN7+nBH+UqOTXY/gRyn+o9Nswds7NQPxxgEGLMYyEKKyZSyyHU6Ffqm9YWduqKt1XoEP+4jee
 WmuI=
X-Google-Smtp-Source: AGHT+IEvTEIUi1V9V9a7aDAORczDWCsqXRb0ke6UUx4Mtdbyxvwx0Ol8vWlcjjEU9/HhTd4q7HHw5A==
X-Received: by 2002:a05:6808:3990:b0:3bf:bbda:9db9 with SMTP id
 gq16-20020a056808399000b003bfbbda9db9mr2051606oib.15.1706853095816; 
 Thu, 01 Feb 2024 21:51:35 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/57] target/rx: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:04 +1000
Message-Id: <20240202055036.684176-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/rx/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 353132dac2..5205167da1 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -64,6 +64,11 @@ static bool rx_cpu_has_work(CPUState *cs)
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
+static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
+{
+    return 0;
+}
+
 static void rx_cpu_reset_hold(Object *obj)
 {
     RXCPU *cpu = RX_CPU(obj);
@@ -204,6 +209,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
 
     cc->class_by_name = rx_cpu_class_by_name;
     cc->has_work = rx_cpu_has_work;
+    cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.34.1



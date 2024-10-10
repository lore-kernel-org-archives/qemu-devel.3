Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55033D2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz15C-0003tH-4T; Thu, 10 Oct 2024 17:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz157-0003kR-4P
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:52:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz154-0004ra-8p
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:52:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c544d345cso10281695ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597141; x=1729201941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1XYLT4ov012jPPpOCML5uGiHmLv/YJJIs/8cebw1O4=;
 b=dOrFfYCmjVF0HdBGB6TdT++resymkxkZAFaUnpxQybQJJrghsDdgjtDvyLpRFbtx+5
 6zGpqy3VAHlZhyGCoHXYL5wt2anhm5l0Qe5IMtPbe82x8Gv9zvKrZwwLUKY6fb9Jrr58
 C+viL6+HIuUoUxurJqtEkcBZyYhde8CRSd6WIHaGIbsmX2dEE4UnXVIPR7VEdPCnuA8m
 vw/Ih3dKbifo635kVoIZSXqTqAyn6djrec8CUVw8yPMhZ2QZu27It77txYAO8q8R/nB1
 PkLcysDEdiRKUGtrxbN5aG5hSJWFjRCQL07+L7zsYpgDsDUvqT8zt9y8D2TcAzR8IMpA
 KkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597141; x=1729201941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1XYLT4ov012jPPpOCML5uGiHmLv/YJJIs/8cebw1O4=;
 b=YOdnJ9usZI79m9wyKopEyGHrdGAFKYf28f/3HSDXBISb9iDnZsdd2PdpQid8DacB+u
 KpEZUE04H4fo+yISDNffX7JCsuNu9U/bMbSUv3jMlHOQZ3rqtbJDkOV/Qux7CciwqcHd
 lYrVIEZUZmE69ep6NJG4w2kmQ7BZQym4ml1l92i/jVH8Li83fsIMY52f8BlaF/sW6dyx
 j46+NOIL4mY5qZLHrjRVOYMHdHu9jk5kKKsTv03uchjBhf3iFx9ih4fAOZyNc3amjQwo
 nmMMdLLcGP/bep8h1cq2TxhehLzPP8fzlTezS14UT7RrV6Ba9nluCqh3xBI3XN4eQWDt
 agNQ==
X-Gm-Message-State: AOJu0YxmWgKjwbwgRE4QtDhVuQN5CC5ibuwNIiPjL+4p/2+pP2X/JTdX
 AvNAcAXCnz3wNgtZM8Mkt4m+e+D0p/JRYlr12n/ntnoSNXzo+WhM/tv/7SjlT7cJIaT9ULI1NNm
 J
X-Google-Smtp-Source: AGHT+IHJL8AO1yrkqjlrp6ioxPccliOOd/rwDmeLMcztAv5nZFKdKdf9cEGDdbjXbLjVfiWOVy60YA==
X-Received: by 2002:a17:903:41cc:b0:20b:a409:329 with SMTP id
 d9443c01a7336-20c80442c36mr78825455ad.5.1728597140731; 
 Thu, 10 Oct 2024 14:52:20 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc0d2bcsm13732675ad.81.2024.10.10.14.52.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:52:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 15/16] hw/mips/cps: Set the vCPU 'cpu-big-endian' property
Date: Thu, 10 Oct 2024 18:50:13 -0300
Message-ID: <20241010215015.44326-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Have the CPS expose a 'cpu-big-endian' property so it can
set it to the vCPUs it creates.
Note, since the number of vCPUs created is dynamic, we can
not use QOM aliases.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/hw/mips/cps.h | 1 +
 hw/mips/cps.c         | 4 ++++
 hw/mips/malta.c       | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 04d636246ab..05ef9f76b74 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -38,6 +38,7 @@ struct MIPSCPSState {
     uint32_t num_vp;
     uint32_t num_irq;
     char *cpu_type;
+    bool cpu_is_bigendian;
 
     MemoryRegion container;
     MIPSGCRState gcr;
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 07b73b0a1f4..13046628cd2 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -77,6 +77,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
         CPUMIPSState *env = &cpu->env;
 
+        object_property_set_bool(OBJECT(cpu), "big-endian", s->cpu_is_bigendian,
+                                 &error_abort);
+
         /* All VPs are halted on reset. Leave powering up to CPC. */
         object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
                                  &error_abort);
@@ -167,6 +170,7 @@ static Property mips_cps_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSCPSState, num_vp, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
     DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
+    DEFINE_PROP_BOOL("cpu-big-endian", MIPSCPSState, cpu_is_bigendian, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 1df00c4bf99..964d3592da7 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1054,6 +1054,8 @@ static void create_cps(MachineState *ms, MaltaState *s,
     object_initialize_child(OBJECT(s), "cps", &s->cps, TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), "cpu-type", ms->cpu_type,
                             &error_fatal);
+    object_property_set_bool(OBJECT(&s->cps), "cpu-big-endian",
+                             TARGET_BIG_ENDIAN, &error_abort);
     object_property_set_uint(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
                             &error_fatal);
     qdev_connect_clock_in(DEVICE(&s->cps), "clk-in", s->cpuclk);
-- 
2.45.2



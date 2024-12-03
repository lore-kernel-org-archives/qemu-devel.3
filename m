Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35712E64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8i-0000cM-3q; Tue, 03 Dec 2024 06:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8g-0000YV-UD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8f-0000ai-B1
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:22 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e1f12c82so3576524f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225539; x=1733830339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJvSsd8dR9/3SHrqkOdjWUtSWpDGfzavxvd+Z0C+v1Q=;
 b=RbbrPkYLUgh0OkvoPxNUo44GBV5SVr2sZ7XqwWzVUdG8ZRFnQSHkI8WGlPa9RNyNRk
 A7N7RLjFoE9YAiICO6CKAQ0OF5xp1JoWSeE8rjFDDnWXikJFCPB84EAtmWbqGMErmzdX
 NBFK1+JPOlslIbYwbpo+1lqAlj1tAQzQVPYAWGgZ4wRVrL/fOTp0iYjJMkDxa/oWq8SN
 FjUdnDb3nmrJ/XkmD9LERvh8mKQ80KstZdxa/uJYlM+I2+Ahv29E/ZRwdnI0a7bpq0Yx
 qXEALUN5WUEXp94L6999fL4gelWPHKpSAlxoujaW/h0d91cz2URF4gDp0Nm8Ir9t3ZxW
 /YWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225539; x=1733830339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJvSsd8dR9/3SHrqkOdjWUtSWpDGfzavxvd+Z0C+v1Q=;
 b=aW6lqZFkLhRNZk0z4aL3r4nJpWtSJ3Xi1n96R8vQQAQ5gWSQ4+AdkcnGdzKqNBbflL
 totH9sA+hYyhIrYI8MFhc0/sxUj7DjjXvDzwHhQm8Jby7ksgclvTWimzjp4J8x0Ozdxq
 aOy+kaRlBkCzPykxuP7sHvx14F2HeFf4kzrWW/WAcMt1uwBIgFnekXCkJ+dxK3uw7Yx1
 zXwxYa7lWehOaq9iAF54UbaQfo6ETFoOcOaSf/XnSfnSSE+uZgx5xbwOj2hdgaddDgrB
 hZSH5Vedw/SQwqaWTwpceI/9LZ6+nK7au4KJaQAV9jw6Yu6KY72o8yOD25j5WGpi1c3U
 DRog==
X-Gm-Message-State: AOJu0YwjYMsylXjt6X/Zs1a6l2yiA+m6eGuyBtjnsUrRLU/a3UhFH21M
 1lbCQ8fwKzD4rBEXg88GdUZOt7H/1TpDhFUhll4BHMIhAym9N+5MfgRR//dmAaTVqOY2l/ETonX
 N8n4=
X-Gm-Gg: ASbGncsYoLDtlblISmTAI+al1aJGS58nnSrGVU3rIQXV2yDTXuUScW/Yeol7nbBolqj
 k2L1HB3XjlRfnodtgebALtcrOSuWAgWwhzBNAwY72Tt75RAyAz9hLDupKo04GYfWncGoHCVGe1o
 GnRQ1G/uIMBRfvl0xoqPCW9S25H8gCgIYQ9rh91GDn4dlEtHWoGhPXvGE3zYQ5k1SL4AhhmoBUx
 rmsnYfKoISBs0Yk+hTV7Po1fZLO3V5cnjRcz+AeOPpT2sYSyBELmf0PUslSAOvNnlqA3H4o
X-Google-Smtp-Source: AGHT+IHVCmQ3Fj3EWs9DpLosvp8nJP+x6Sb4lPga8lft0vHcg2tsFP7N/y08QuwTF/55V7jLCwNdwg==
X-Received: by 2002:a05:6000:156c:b0:385:e88a:7037 with SMTP id
 ffacd0b85a97d-385fd3cd72emr1942211f8f.6.1733225538921; 
 Tue, 03 Dec 2024 03:32:18 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385f8448d32sm3687037f8f.96.2024.12.03.03.32.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/13] hw/core/machine: diagnose wrapping of maxmem
Date: Tue,  3 Dec 2024 12:31:34 +0100
Message-ID: <20241203113140.63513-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The 'maxmem' parameter parsed on the command line is held in uint64_t
and then assigned to the MachineState field that is 'ram_addr_t'. This
assignment will wrap on 32-bit hosts, silently changing the user's
config request if it were over-sized.

Improve the existing diagnositics for validating 'size', and add the
same diagnostics for 'maxmem'

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20241127114057.255995-1-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a35c4a8faec..f29fe959647 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -598,11 +598,19 @@ static void machine_set_mem(Object *obj, Visitor *v, const char *name,
         mem->size = mc->fixup_ram_size(mem->size);
     }
     if ((ram_addr_t)mem->size != mem->size) {
-        error_setg(errp, "ram size too large");
+        error_setg(errp, "ram size %llu exceeds permitted maximum %llu",
+                   (unsigned long long)mem->size,
+                   (unsigned long long)RAM_ADDR_MAX);
         goto out_free;
     }
 
     if (mem->has_max_size) {
+        if ((ram_addr_t)mem->max_size != mem->max_size) {
+            error_setg(errp, "ram size %llu exceeds permitted maximum %llu",
+                       (unsigned long long)mem->max_size,
+                       (unsigned long long)RAM_ADDR_MAX);
+            goto out_free;
+        }
         if (mem->max_size < mem->size) {
             error_setg(errp, "invalid value of maxmem: "
                        "maximum memory size (0x%" PRIx64 ") must be at least "
-- 
2.45.2



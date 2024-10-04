Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C392CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl4K-0004Ek-S4; Fri, 04 Oct 2024 12:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl4G-00049L-0Q
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:22:13 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl4D-0004Jv-Im
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:22:11 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2facf00b0c7so30379521fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058927; x=1728663727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ar5l4AIEpN89iIriQ1A0Rg6FdJgoGAMAWx9ArtF1/do=;
 b=Ytp0wzKTkW8NIPEum3ch5BKTIUseSEEti4EBj3Va0PjPyzOXXJoBPmz/aCffQCD0kA
 9AUmpDDjj30sz3pDRGZWur0HZtaSt5J4HRvZZOvR+oog+v/tgvFbvdXKhi7N6/fA3W5B
 B32ke9DsYjLwb1GtCMDtnM08oo1cpf8xGqMRmgGicKna3Y6nWbzEpBGfePAT2wsECryq
 VsEmgIngAoDDO+dbUYA2WWBzT3GrLK8OnlZpctUYcZWmnkNq+eeUSNqUqWvt3J/g98I+
 mXgHCcPOHMPgy114mnh6X/Wy1wBB10iKff14hQEw/46i2FQJZZUkyGeh81kMfIFjrwCb
 CYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058927; x=1728663727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar5l4AIEpN89iIriQ1A0Rg6FdJgoGAMAWx9ArtF1/do=;
 b=ZxGYrk2bQrMr8ZD7nJ4CgKZNxeTvTJ6j58FixD/HH92/evIBRBsTx7S6UHc15CLDbO
 +TSPHMYZa7khAYaYk25g3ynW1LxEYcjA5X9Up6TwaqHgpPBuX9bz7VjMSORFx/mF05XL
 hnS/Mz/SbKiO1stnrXt6gnJdlHFq0GC8z4axKNyN7hTbpGtTWgmudmAL+gCWboTV0B1O
 po0LEB85lVTs4z/FExY8uTJbNTWspvN8Lt6USvObqUtjHsAxgrF5wZ0DdFeofS07w5Vb
 zXZJ/HYDk85Txjvpk9S523Xj3vFM9vREJsvUh6w7Q1vXd8Wl9qpNqCi9WveraFcUyGHv
 JUrA==
X-Gm-Message-State: AOJu0YywSJUg5sxywsJ/JjthjhGf/MrBr2zZOGcRtL3rRbzL+TFzrCWG
 SguuPsPA2a4N3lO9CCZK0IzzIrMoogJdChIKaftKblOSubMy0DN4e+3cO5+hcO0/31A4dRQ8DPY
 R4SlkvOBv
X-Google-Smtp-Source: AGHT+IFsIuCQ7d+7+0RsX/Vd0YwJrvjoi0ry7R5LFTdLE2Ujg5gNPsFFkwQYYRLubJrzHEDme/ZBvA==
X-Received: by 2002:a2e:b8c9:0:b0:2fa:cf2c:479a with SMTP id
 38308e7fff4ca-2faf39f9266mr9732401fa.24.1728058927479; 
 Fri, 04 Oct 2024 09:22:07 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b33027sm161171fa.115.2024.10.04.09.21.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:22:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/8] hw/core/cpu: Introduce CPUClass::is_big_endian() handler
Date: Fri,  4 Oct 2024 13:21:12 -0300
Message-ID: <20241004162118.84570-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce the CPUClass::is_big_endian() handler and its
common default.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 ++-
 hw/core/cpu-common.c  | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04e9ad49968..22ef7a44e86 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -150,6 +150,7 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
+    bool (*is_big_endian)(CPUState *cpu);
     bool (*has_work)(CPUState *cpu);
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
@@ -749,7 +750,7 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
  */
 bool cpu_virtio_is_big_endian(CPUState *cpu);
 
-#endif /* CONFIG_USER_ONLY */
+#endif /* !CONFIG_USER_ONLY */
 
 /**
  * cpu_list_add:
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 7982ecd39a5..aa5ea9761e4 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -26,6 +26,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "exec/gdbstub.h"
+#include "exec/tswap.h"
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
@@ -138,6 +139,11 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu_exec_reset_hold(cpu);
 }
 
+static bool cpu_common_is_big_endian(CPUState *cs)
+{
+    return target_words_bigendian();
+}
+
 static bool cpu_common_has_work(CPUState *cs)
 {
     return false;
@@ -306,6 +312,7 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
 
     k->parse_features = cpu_common_parse_features;
     k->get_arch_id = cpu_common_get_arch_id;
+    k->is_big_endian = cpu_common_is_big_endian;
     k->has_work = cpu_common_has_work;
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
-- 
2.45.2



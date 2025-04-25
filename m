Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC470C369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzZ-0000Ez-Sd; Fri, 25 Apr 2025 11:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzY-0000Eh-PP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzW-0003Yl-VE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so12900805e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594964; x=1746199764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTox0z0LMqXGw8wOkSIddNNYSXpipaqH4gqCQNyP+Io=;
 b=m+/Ct/SmG4R8R6yORsXoT23I0flHlzMovtYipnGlo5QHLyIJMQXQ9soj/cxfcSLtWm
 3XJMUFYR+K3LggN9+c46bS4exqKYT6n90qj1gr5SXqRPWrsbc0BVWbaemGqJlO+UPrOi
 gizTCGzII6UOd35NAwB0CyuS0gzXZVSc+dk1QpiRTHYwFTWhKPBbY5nMLo0sZmpjoFEF
 c4jHCH/JMMESFIql6RFTlJV1ryonp8kK4+ZW06gInjmVmzvuYaK3K7KU/8+2S+bT6U50
 aSGCjBjCCdHFdc1iOq38pkjhqtLirv/o0vVyD4SEks0941+msCuhUoEOLelM//NxoNnI
 IPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594964; x=1746199764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTox0z0LMqXGw8wOkSIddNNYSXpipaqH4gqCQNyP+Io=;
 b=dJyoBUh+4H5NAxozEH6pvhlMVqk2aQ2SfhBBZciMnJpjcE+oYL7xyke3IMsfxDTh3S
 5R1rJBuV+lr4GSr3LChQqWadkDlWWRSWothpDXiVsUiW5g0N22t1x6zgM7PEk85Ti3j4
 ZlhF0wMg+aNnUwoX/y6j6G6X7YKeHUyL0PU+UxHLlXlSKuSDEfNXmCf88FXMQ/Ax8iWQ
 QCA7cJnoW/5uGUuZZzrVMjUXwt7kVDuPzW1LeMdWxyBoMOvl+lPl8GM1YlkntoKvYt01
 I9ox0ys5kiwJfO888RPryvfxQtYeandAlPFncXHEDQnlxAKaYoHD8np4i5Cm0wwLzyLS
 ZnuQ==
X-Gm-Message-State: AOJu0YzGbi3miC3iE1+sskJ10J61xyF2lg6wUsQVAT3HdcRZ1VVF6QZO
 szS+3DdxAsscmSUnHTbkP6q4M0TcRm54Nh7vy/jRC7FA429d0jjxWq6xEIYbS6rL3WCgqBB43Ev
 T
X-Gm-Gg: ASbGncsJv5f+ZT6q2bLaFD3KVkssUqugqXcMHOhlejBR93X3rcURsZn511RjxsLEtgP
 Wlb/PnpCOKrIrfM7PTccT7cLERjVpS0mv8V+1VsMEcNVPmVzd8hs8cbztrFJPU0EcQE1n0uyBMW
 NykugPxOQYlaQ+6PQgG1kpmzkakyDPw+YYKPsvQ6KOm7tikG7TK0zwhUtJWrU7Nxf+2NywvyjGQ
 IYXgIpdbeqjzu/IMcUrgaf+bYJRIt5kzEqD29xlhvILjOZyWHYtI4gQ9EJ9aDR/Fc7EbMUC5R6z
 Y/IMXIoZga9+XioPnK6AxoJko/vsc06W7mul/RdsUQWfbk96di3DjozMM5Nyxw8GCWtlyoMLSHg
 lAwtmhfn0H/Iu7vA=
X-Google-Smtp-Source: AGHT+IFujvPDmwr08wrtDowcpc7KqgjeaEJ/qoWF97NemRQ7tIwArfNx+ETgtjLDHhNcKs8r34MQ3w==
X-Received: by 2002:a05:600c:3d93:b0:43d:fa58:700d with SMTP id
 5b1f17b1804b1-440a66ba122mr18327855e9.32.1745594963712; 
 Fri, 25 Apr 2025 08:29:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46454sm2656161f8f.78.2025.04.25.08.29.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 08/58] target/s390x: Register CPUClass:list_cpus
Date: Fri, 25 Apr 2025 17:27:52 +0200
Message-ID: <20250425152843.69638-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Both s390_cpu_list() and s390_set_qemu_cpu_model() are
defined in cpu_models.c, move their declarations in the
related "cpu_models.h" header. Use full path to header
in s390-virtio-ccw.c file.

Register s390_cpu_list() as CPUClass:list_cpus callback
and remove the cpu_list definition.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250324185837.46506-6-philmd@linaro.org>
---
 target/s390x/cpu.h         | 7 -------
 target/s390x/cpu_models.h  | 3 +++
 hw/s390x/s390-virtio-ccw.c | 2 +-
 target/s390x/cpu.c         | 1 +
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 90f64ee20cc..d9ca2506e27 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -900,13 +900,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
 }
 
 
-/* cpu_models.c */
-void s390_cpu_list(void);
-#define cpu_list s390_cpu_list
-void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
-                             const S390FeatInit feat_init);
-
-
 /* helper.c */
 #define CPU_RESOLVING_TYPE TYPE_S390_CPU
 
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 71d4bc2dd4a..f701bc0b532 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -113,6 +113,9 @@ static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 }
 S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features);
+void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
+                             const S390FeatInit feat_init);
+void s390_cpu_list(void);
 
 bool kvm_s390_cpu_models_supported(void);
 bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 52c273b3dea..cf5b9974c58 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -35,7 +35,7 @@
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/ap-bridge.h"
 #include "migration/register.h"
-#include "cpu_models.h"
+#include "target/s390x/cpu_models.h"
 #include "hw/nmi.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 41cccc1e692..43fc3194bc9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -386,6 +386,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
+    cc->list_cpus = s390_cpu_list;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
     cc->set_pc = s390_cpu_set_pc;
-- 
2.47.1



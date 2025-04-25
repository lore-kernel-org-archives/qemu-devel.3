Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08BFC369D8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1L-0003MU-G0; Fri, 25 Apr 2025 11:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0N-0001Iv-P6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0L-0003rQ-TY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so1759954f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595015; x=1746199815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtK/NsBWePQquSrdWxf+k7uaX8Ev0Xubkq8Di9Q4gSg=;
 b=byjKMjBmx3vpIzmRSs7ykw8GW5uLquPkcbaxQrDX0SsVR/jS3V/urAyZN5eqi8duXw
 wtbyRacyx4ts5/IVfwlwgejCFaNsqXg47g3Ngn3Aad1GHvNlwgBux4hZbrrd9Lhnwk1s
 10XMo/7tc0/yvQZk8TgCyV7ZBWk1JJWn0B1fxkWPhj3D0jtszxOes59/PbthghlBJVwD
 XHRAHpGjIKW2FfpElDz5/vX477n8juh5EcGCtA8MlHE2Ilry0tkCiXlopsnJ6Q0crGeG
 f1Bcz28rhTlyt5OJDC5HnbkUnNoUlAC0lG7VHhiw/0R9Xg0XDgvfBWwR2zsnNAQiYf7U
 0BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595015; x=1746199815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtK/NsBWePQquSrdWxf+k7uaX8Ev0Xubkq8Di9Q4gSg=;
 b=OlYQfdT8z1T7aTe8dSnz7fa7BrZqQF+b7a7tEOWZobnwI+MY/UAQ7Lu5+LmM8mugKM
 Ej0ijLE4RdFNhsgDGJ2t0gbzUU2cBLAkXwBNstajhIj9iy9wXIczNm/CEk7qa0sjsbhA
 PhilWv8Yez/hHwGaDZaPzpKHAkieJeg8OKpMOs2Ka6pqX1R9X957pRhopZoFw0moxMD2
 G4toKJtTd4MzZuYLcBsYwHn3Yc+f4gTT7CX6FF11+4DcFjhpXy6N0vV1SoeA/Oxevw1R
 EXbdLnPbE8Q0CKF97qBbyOq+jO82WwaScRwOLjtdY77vVULuEToSAdG8hnQ8Bl8uNUoU
 NIZA==
X-Gm-Message-State: AOJu0YwKstZzELLAU260gL1Qo8gPBvHYFZ+/V8ku/8th09KGDHwPp6FE
 dOXoycvU+gJck9jI71yl7RguwT9qF0UXcmLNvLLOJdhffluxWfVk41penKzt7jqKAeVgnu4Tk0D
 G
X-Gm-Gg: ASbGncuknmBpoGJ98zgHKntM+FGrx7vFRBvir6X0HIC3K+1sCKzaSugMVbk4/7KO2Mb
 7B1nWjDjrp7Bg4YUxnUe7V946SBDvddsiAJ2KLVn/o67q3iNxLBiZX+KRpCWQCbrTAervmSxjX5
 c+GAii8UtYr6rOcvMWK5IKH/YTUn5Jvp3Hf8jw/ly7jzjj6DCm4/FfHHxhoYcdY1vpLnb44MPbd
 uFwz4mqCGP37MZtg32n1whzUX25kS704qckm0iuS/xqcdHFSEFyfPYtiaLXkU5C2iB3xshF/OTb
 ucsz3VlzfHokhNdu+x1Ec9vMMpFNnHc5TuxZF6v0RyuORziWnWvrPPYoHlsufDvGHKsyJPDWzEs
 YoGPe0iPUHIylqhiTGG1ukdeaww==
X-Google-Smtp-Source: AGHT+IHUciqN1TzWzfhgDcksXXmGE40rl80RB6Wk+ph9Y245SAQ7pKV01eP6ayI6ebWlBRrvWGscew==
X-Received: by 2002:a05:6000:4014:b0:391:3b11:d604 with SMTP id
 ffacd0b85a97d-3a074fa73bbmr1959923f8f.54.1745595014870; 
 Fri, 25 Apr 2025 08:30:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbdb78sm2624362f8f.41.2025.04.25.08.30.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 18/58] hw/core: Get default_cpu_type calling
 machine_class_default_cpu_type()
Date: Fri, 25 Apr 2025 17:28:02 +0200
Message-ID: <20250425152843.69638-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since commit 62b4a227a33 the default cpu type can come from the
valid_cpu_types[] array. Call the machine_class_default_cpu_type()
instead of accessing MachineClass::default_cpu_type field.

Cc: qemu-stable@nongnu.org
Fixes: 62b4a227a33 ("hw/core: Add machine_class_default_cpu_type()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250422084114.39499-1-philmd@linaro.org>
---
 hw/core/machine-qmp-cmds.c | 5 +++--
 target/ppc/cpu_init.c      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index fd8b4e0b44c..9447e345b3c 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -73,6 +73,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+        const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
 
         info = g_malloc0(sizeof(*info));
@@ -91,8 +92,8 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         info->numa_mem_supported = mc->numa_mem_supported;
         info->deprecated = !!mc->deprecation_reason;
         info->acpi = !!object_class_property_find(OBJECT_CLASS(mc), "acpi");
-        if (mc->default_cpu_type) {
-            info->default_cpu_type = g_strdup(mc->default_cpu_type);
+        if (default_cpu_type) {
+            info->default_cpu_type = g_strdup(default_cpu_type);
         }
         if (mc->default_ram_id) {
             info->default_ram_id = g_strdup(mc->default_ram_id);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index aed9e265992..b0973b6df95 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7082,7 +7082,7 @@ ObjectClass *ppc_cpu_class_by_name(const char *name)
     if (strcmp(name, "max") == 0) {
         MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
         if (mc) {
-            return object_class_by_name(mc->default_cpu_type);
+            return object_class_by_name(machine_class_default_cpu_type(mc));
         }
     }
 #endif
-- 
2.47.1



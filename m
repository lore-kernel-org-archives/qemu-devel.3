Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D8FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwvx-0005cY-Bb; Thu, 25 Apr 2024 07:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwte-0000LM-NY
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtb-0000OF-5o
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-347e635b1fcso639962f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043045; x=1714647845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtMNR1ZQjJCcNYkkejZVBvEmwe3F+2PjUE+kGb5DBZI=;
 b=qQ8XGqfKyttfqQ17Re/ThAnwmjlzoPq9rO1qUq/w6yY5A71wbKOdIN8SCHl2A22jjN
 O3Ae6fIwtJcAmvtIPr+PWUTPutzI9jMKQUlnFwIn07K3Opu7hDSqeutdoL3IuvTezjfe
 w7Zaj9ygGl+95fhQp5yK5FccE0OIqDUzyDquhlVEjXl4LUWEisOqxkUHAYZ2UzZQFKOI
 wGUhgGJ4iXsdmXhGQI7OBpqaja9wS8FtgYvrQEX2ozOdl0CEIuy6GWLT4SMAciIytFX8
 4zDk06SRM5R7w9+5w7PtcIkke8e5Opl7BonYK3n+J2J0WfUuIQp5tmX5sPaNoS5kF4CX
 WzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043045; x=1714647845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtMNR1ZQjJCcNYkkejZVBvEmwe3F+2PjUE+kGb5DBZI=;
 b=lmzBaij28V5PGGBJ/U2NwieYF1ew1nIl1rZUK3l2A7E7b5LiShRmROqIsxJQoc5F3b
 IfwbzVarGD5KdQjxYz8uFzcXNliz3HTG8mBPXc0ZjOQx3NX5VziI2Us9YuwQg1xsQx8o
 AuqoyGGj9b2IHbeWNSdGIyBfRJ3noFgYVrRQXaQPP7wmaAjLPODqhLk3ehmq/04/XWb3
 uDBKSIFKqGLIN0oKwIY0aHRzbX072Hklv5a1NLJsCirTcA5k87nRFKLS0p13DfgWClmE
 IoFQHhcKClMQMA3Z7x5f/NWSzVATtAXL0V3lOx2K5O7rxTTmvJP8ibDaUiJkKoY5zNtm
 mq1Q==
X-Gm-Message-State: AOJu0Yyygah4TkJYtf8RhyrVOaVVF7e89IRiZKaLZnDBx3htGOpxdz1x
 Yv9sCgoiS4tzBhlPaL1mgZlr6W9KaSplC+hcosb2fxKpkWwqyALBtETf2cSU3b5RtrCbaPICzk7
 D
X-Google-Smtp-Source: AGHT+IEWNircr86tkVldy1EsXrXAxD/kzzSUIMWxBrCkq+T/LXkDmvFt7vckXR5njOJa/f9q3055aQ==
X-Received: by 2002:a5d:6e5d:0:b0:34b:1f34:9c06 with SMTP id
 j29-20020a5d6e5d000000b0034b1f349c06mr3712985wrz.24.1714043045068; 
 Thu, 25 Apr 2024 04:04:05 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 u17-20020adfeb51000000b00347321735a6sm19543079wrn.66.2024.04.25.04.04.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:04:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Babu Moger <babu.moger@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 22/22] hw/core: Support module-id in numa configuration
Date: Thu, 25 Apr 2024 13:01:55 +0200
Message-ID: <20240425110157.20328-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

Module is a level above the core, thereby supporting numa
configuration on the module level can bring user more numa flexibility.

This is the natural further support for module level.

Add module level support in numa configuration.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-5-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 494b712a76..0dec48e802 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -800,6 +800,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
             return;
         }
 
+        if (props->has_module_id && !slot->props.has_module_id) {
+            error_setg(errp, "module-id is not supported");
+            return;
+        }
+
         if (props->has_cluster_id && !slot->props.has_cluster_id) {
             error_setg(errp, "cluster-id is not supported");
             return;
@@ -824,6 +829,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
                 continue;
         }
 
+        if (props->has_module_id &&
+            props->module_id != slot->props.module_id) {
+                continue;
+        }
+
         if (props->has_cluster_id &&
             props->cluster_id != slot->props.cluster_id) {
                 continue;
@@ -1226,6 +1236,12 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
         }
         g_string_append_printf(s, "cluster-id: %"PRId64, cpu->props.cluster_id);
     }
+    if (cpu->props.has_module_id) {
+        if (s->len) {
+            g_string_append_printf(s, ", ");
+        }
+        g_string_append_printf(s, "module-id: %"PRId64, cpu->props.module_id);
+    }
     if (cpu->props.has_core_id) {
         if (s->len) {
             g_string_append_printf(s, ", ");
-- 
2.41.0



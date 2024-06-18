Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53137C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbH9-0003fz-AS; Tue, 18 Jun 2024 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbGr-0003Zz-Aj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:23 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbGp-0006lR-Cp
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:20 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso884864166b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726477; x=1719331277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhApRstys1OLcNpLtMQ96a66duaItivdCKXVXSN0oVc=;
 b=mdYj28TVGfVEip245juIWpR4Gp1vblW3GuwlagPsP0GfsPXwkzK+J8CkedJoWLgDeZ
 Eg0qEGToMmFEe5OI0dV+nMZji6AuZTduf9DVNTe7NRdWUkyU7c9NsV4mlxryWkKPXK9H
 XjGVBj9ljgoUY4jJmQklAjRTwJs+H+45SmSG2hUI+NCJrWOTv4OBcDPqZgPIEtoOzD1b
 Ko41My3c0NXAcVFUs5urWEvZwnolk02dWu1QOK5H1CC3O27zIvYZdhRX3Zk0NdM+HVoL
 CuD7VKRmfkbmfLr54s5SnITD+VYCYrJohEaTD9SmeS3ULHIYWmB8x06pGGbbXcU5/ES9
 XSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726477; x=1719331277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhApRstys1OLcNpLtMQ96a66duaItivdCKXVXSN0oVc=;
 b=Kf+9stOG/aZlxo8T7/mir39g4KsucAliIKv1fE6BKjXBi/NcsRaJ4zlScVwD9R1IBt
 UulZA4dUg6DYKNJMpWDvQ5MmTRcAtN64RgsFyzG6GIy99f53h2zZvJQ8Mb9LLe0iXtL0
 mDs42Yts358k7INUGjkX+FHKFeS/MZznT1cFE18Qmcmoev27pdTt4/U/dH5Pd1bjJ0rq
 fZ6epqpzVon8vKmnBBUYTPWRjhGmpoapxHGzCBSO3TRLrMU62yxOM2Non5Ylo8Ze5RH6
 okQ39DUm4wy24blNclqDT6DfQVI4S1bX7MGCQ3pKH0mkstuMiw0YRFMDySLJkqRz6i78
 +cgg==
X-Gm-Message-State: AOJu0YzAIqzCszJc1D/JwsdHnA0Tp2BKyrIhNZm2i4tEgToqWrjkRKYr
 pwiVn2vS/D/f6hvpyF/Ay1t/Kihg7mELdaBoz65gjzp0rn1An9yJ6BdO3dmsQkAY95klFa3/Iea
 E
X-Google-Smtp-Source: AGHT+IFfB4uhZjDG3KazTaN9amfZPOXAOWhN7JvMHDdsc9f9UqiawmL2TrAlPwRor5Ige9pKXnYxgA==
X-Received: by 2002:a17:906:4953:b0:a6f:df9:6da4 with SMTP id
 a640c23a62f3a-a6f60d42940mr956115266b.44.1718726477398; 
 Tue, 18 Jun 2024 09:01:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f993da434sm83740666b.221.2024.06.18.09.01.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 06/76] hw/acpi/ich9: Remove 'memory-hotplug-support' property
Date: Tue, 18 Jun 2024 17:59:28 +0200
Message-ID: <20240618160039.36108-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

No external code sets the 'memory-hotplug-support'
property, remove it.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-7-philmd@linaro.org>
---
 hw/acpi/ich9.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 573d032e8e..9b605af21a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -351,21 +351,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_memory_hotplug_support(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.acpi_memory_hotplug.is_enabled;
-}
-
-static void ich9_pm_set_memory_hotplug_support(Object *obj, bool value,
-                                               Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.acpi_memory_hotplug.is_enabled = value;
-}
-
 static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -445,9 +430,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                         NULL, NULL, pm);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
-    object_property_add_bool(obj, "memory-hotplug-support",
-                             ich9_pm_get_memory_hotplug_support,
-                             ich9_pm_set_memory_hotplug_support);
     object_property_add_bool(obj, "cpu-hotplug-legacy",
                              ich9_pm_get_cpu_hotplug_legacy,
                              ich9_pm_set_cpu_hotplug_legacy);
-- 
2.41.0



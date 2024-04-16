Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CD7C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo3N-0001VP-0o; Tue, 16 Apr 2024 15:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo2e-0000yo-7G
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:32 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo2a-0005dG-BJ
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5224dfa9adso14291366b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294022; x=1713898822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cesSegXMr71Lpaal5FJBOqynS/3X0jmvbPzoIKbt5l0=;
 b=DqLoAIsma2JFVv5BRASUhNqanaclwMJ6WPOEf+f2GuKRJOnfJQUbPI6TLm84MSUg0K
 +eBgLa2FDDzeCoR3ne2rN7gmKxKzQDQn2UpHfxCspzJCO1RhpOxrZm3WIaJdGGO+Ir7w
 SJrH4gx6dNmDyn45pRcaWp8K3D5ydvwqbT5E3P6zHQ45/6IKJ3HKi+PaNzPGd0UQ25Mn
 aiTXaiErQ6pXCy/16szjHw9eWOUSmUnjk/TmfDbi5Uvol6CAmENUL0t3QAMB0hz/iEfb
 mxj6OdCuFCMKOTxJVJV+hwaqSqCaOzNq3J2/f3nDtT+lnhtRiwXVOcDKq355D2I9OYNo
 IDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294022; x=1713898822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cesSegXMr71Lpaal5FJBOqynS/3X0jmvbPzoIKbt5l0=;
 b=a2K/eScw+i14HTcgPveG8pNEM9C/X8jAZn5P0iukClU0DI0ZL2HrsZlEvsJ2LrXs1D
 pfgqYTf5VnhRL4NBZNO4Zo+1DFvdgOm19JBErzX6Coq2eXHp3xOvyIsQUIWUL8CTcGKs
 u/FQp3GwIjX+Qmp0l2O0xDFegLfnOvY/A7b5x7OqfFCZwGDolC38zmhrGuPgHfAnfj72
 xRBpkUJ87JOtHs6ORvF1giEOqPBk2TP5KLeoAi6G86/oaj2kcYn41zDbh6WySvQOgfeR
 4kDaqlbD5xZ6RKEY08WDj9DLQgmEC6HG86aZZm3M7XyoRfMPkMzilWMmeEME2K8H8jsm
 l3ng==
X-Gm-Message-State: AOJu0YwF2DD2nkptUKWRdtC/0v0ExfmdPjmptIHOpMBP2oIQUslYFW5v
 CQerQFx/BKNaL9yS0vLmpUrbZrXV2VwZtPGe4phtSl/gzPYF8pjPh8zTf8Kr/ISmCyIN1F1pVNM
 P
X-Google-Smtp-Source: AGHT+IH5BOnyXnn72Ltuk21ppetjbOqt3E7UuzCKXeGkk/xw3+Vi5Lw88kwgqxO3CIw5JIxDda7Syw==
X-Received: by 2002:a17:906:cec8:b0:a51:ee80:bae9 with SMTP id
 si8-20020a170906cec800b00a51ee80bae9mr3007893ejb.17.1713294022679; 
 Tue, 16 Apr 2024 12:00:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a170906640300b00a4e379ac57fsm7099907ejm.30.2024.04.16.12.00.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:00:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 06/22] hw/acpi/ich9: Remove 'memory-hotplug-support'
 property
Date: Tue, 16 Apr 2024 20:59:22 +0200
Message-ID: <20240416185939.37984-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

No external code sets the 'memory-hotplug-support'
property, remove it.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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



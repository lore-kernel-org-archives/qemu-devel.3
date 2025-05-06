Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B83C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJQ0-0000Zk-HE; Tue, 06 May 2025 10:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPV-0000F1-4m
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPT-00019K-AG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso36649095e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542197; x=1747146997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Rt27hrzdu5HLYpMOsJR9F/KsYJa4wyNAyNTcSK09PE=;
 b=uu4cmvG5XMA8FLrPpNETiQKucYodvgFCdwLKFlSqanN1+zAoT0/9kxfSHHpJrPictz
 5objOLs8wJzxi6rC1yNhSW99cKAI85d7k+PqSCw8MOW4us3sMjCKC3DMzS7WJNad+1fI
 hslbPLBwZvangus152Dl+iDFY64KSmr75nHICZL0Sk//7NOaQIC5h/kXYx/ODDc/ab+R
 mfDudjhCNx8oLhKOIuHaztJlOaWsrdo715YKYO3mINSJ6sxaOUR2OYjbdpvFzBydOGB0
 XlAh8DOxfJy5ZkCc3urjOumeqOz5596fcSalJ8vUG7hhRg4WtF76B3yotUMuGlMtk+Xu
 EXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542197; x=1747146997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Rt27hrzdu5HLYpMOsJR9F/KsYJa4wyNAyNTcSK09PE=;
 b=fN/t8u1t6la8MTy2MRiYsw4YeubgzkinO9jUU/TET2J36+yCC7UbcgVN/MGAQaY77p
 MxtVtUI+LVRUfW+Cr73IoLLpeKWv+bHSvR+eEAVmp95ghDoxqRHUbzcuMq8GMPpR2Vj8
 vzBVatUG5A3aXxPGtspV1wl0GTcmUyr5hWCA/x4ZL95dviIqtQ9C993Paw9YnEs0gbZ3
 kqPtWej4rIYX3czbngLmi/ggBpN0EOCyXeW6TnBbPKLXLKg4r9cz6cFI7HmkSrh4SEDT
 KWdiqYXNZ+JdvehDArnjPATIhwUh1vFbrgcLftiz1BadlxFeglOG8uTY9LN90x5HAXa9
 Wong==
X-Gm-Message-State: AOJu0YySdH7XnQXCDZZmijDjtLhk0bq9UreA/3daBVz54xKsqHKtbX6S
 WXNQk4sS2bzsDnhBc1UrVI9XrwdOWVZDGOTo0s1YBgjBParjfAcv7fv9YbkMp2Jum3AfxAcmPKR
 2
X-Gm-Gg: ASbGnct8EnR1Oyohis9L6Pk5ktCgCdMhVtEaVzD/UyJc82tr6EDwhUFSWTjh1oirYMa
 Itm6vRcylVfOt+mOqFHc3M05lTLl1w+VEzgxa6lo0b93vaMuoilwe9neTVSuenyjtaY/zcUU/GA
 6um22+VhR6mNSSz0zyh7xTU2Qee4s/HZQtfjKKsZmJjqMqMWn8gQ5CnO3bSTLiZ+FDAOpzZ34Dh
 KFB9oiu0gBOnvXIOJOe3OEiekow9tkYWP4cn+sCAUVJ40OsrgEkMxd5VoQYAbccwos8RsdH1rU1
 8aRjnNIglesZlzQmNjQZEiv8c8Gxlj/tRamjPexp+qf75IirvqJMqwx0IdngK07jeH0excPQ8Q1
 mqc4Rhvhoap/j/JO3HK8b
X-Google-Smtp-Source: AGHT+IFaH+rU+helBE4STqnqXV+UNYnBFcPysWizk0GLBwSO+Bd6S0pJc1NZXQ0hfysKhbWQM3Tc6A==
X-Received: by 2002:a05:600c:1e02:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-441d053b009mr31372025e9.29.1746542196986; 
 Tue, 06 May 2025 07:36:36 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8992b4csm176042355e9.0.2025.05.06.07.36.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/22] hw/acpi/ged: Fix wrong identation
Date: Tue,  6 May 2025 16:35:06 +0200
Message-ID: <20250506143512.4315-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250428102628.378046-3-eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/generic_event_device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index d8adfea6480..7a62f8d5bca 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -458,11 +458,11 @@ static void acpi_ged_initfn(Object *obj)
      * container for memory hotplug IO and expose it as GED sysbus
      * MMIO so that boards can map it separately.
      */
-     memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
-                        MEMORY_HOTPLUG_IO_LEN);
-     sysbus_init_mmio(sbd, &s->container_memhp);
-     acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
-                              &s->memhp_state, 0);
+    memory_region_init(&s->container_memhp, OBJECT(dev), "memhp container",
+                       MEMORY_HOTPLUG_IO_LEN);
+    sysbus_init_mmio(sbd, &s->container_memhp);
+    acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
+                             &s->memhp_state, 0);
 
     memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
                           TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCB3C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw20-0001Cx-QJ; Fri, 16 Feb 2024 06:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1x-00013D-CC
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1m-0001DP-OA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:20 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33b4e6972f6so912362f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081508; x=1708686308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIiFm5Lc76s4egbopN+QwAc3v81IfNt4gHe1mB8rI9U=;
 b=JKl4ls6s30yDphvgFJqbet/DnKLO6hOugNHjlqBQM4MmoyrzpXxtYqCz9RU9iLq0Bb
 wxxWr8TuJ1s8kz+aRFHPxFmQZxg0Ewv7/J62aaaKGksrO7Bw9nUxL4N/1Yr/UVXRI3QP
 x7ksVuHBMJ0mmXYDvgx8bvDKgmNuCV5Bwk/ZM6bUpVcOIBKW4LFvKa7sDsdwraNHeELm
 6vQysFkGoTrl+vurBUP5AA/THKiAx5FV8H5+qXIjp67ku1fqcXuuAOqwSbIbaNqR0BKO
 gnfb+qp45ne7y6GJLh6sOVYD1u37dTiEK/KJinW9BO3E7eVT+wN/AQG1LgJlET73ckth
 SPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081508; x=1708686308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIiFm5Lc76s4egbopN+QwAc3v81IfNt4gHe1mB8rI9U=;
 b=mpFVVbJ5OpWlHQCTGbaDRg/jiqYARxSTGKzLefcTLs0h/+e2CXEmV5Sj75oKVfwriF
 feajiZQYa9Uju8ZdgG7ez8BTEiASt7WsvyVlFb1F6u/Xe2iT+FgVZRAt0I0uE9BLlpA1
 Nw1OieR6ApcM+fimhW7UCxZhKC7X+Qn7+tWfMWLdRZrKtaJV8qfOdO4Nn39JbQ2IDszQ
 1A1b+ueAjMShlVw//Vbt/lvMvEgdVwPNmna+qud7/uaSNwn8AHmLiawCxn0jO60FvmUo
 bnl1n2MwX9YCeUWULZx9HDL/7qtkqtXNoj73KqeYUvibaIRlt8ZauApi+XIqWP+YJDWO
 5e0w==
X-Gm-Message-State: AOJu0YxE31UApwz0VXytNQvtnedpAy+rUddYU92U4tnDwaXDEfiY5Iox
 eT8GFhCP1EKRCdC6Ym3sPu7TVTiZxD7zSe2upzh+6adIheDzCiyuz6/LUecV+TEg7WRF3Ubpb30
 r
X-Google-Smtp-Source: AGHT+IG6XP4dbGm68hmsfizv3Pfjes9DvZbgcYeGu9WzGNH+dZXsKbuIq1Wy3vt36rJT7bBRfGZByg==
X-Received: by 2002:a5d:664d:0:b0:33d:157d:a7ad with SMTP id
 f13-20020a5d664d000000b0033d157da7admr1642262wrw.40.1708081507912; 
 Fri, 16 Feb 2024 03:05:07 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a5d40ca000000b0033ceca3a3dbsm1898621wrq.2.2024.02.16.03.05.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:05:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 17/21] hw/i386/iommu: Prefer object_initialize_child over
 object_initialize
Date: Fri, 16 Feb 2024 12:03:08 +0100
Message-ID: <20240216110313.17039-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When the QOM parent is available, prefer object_initialize_child()
over object_initialize(), since it create the parent relationship.

Rename the 'klass' variable as 'obj' since the argument holds a
reference to an instance object and not a class one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7329553ad3..c3afbc4130 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1616,11 +1616,11 @@ static const VMStateDescription vmstate_amdvi_sysbus = {
     .unmigratable = 1
 };
 
-static void amdvi_sysbus_instance_init(Object *klass)
+static void amdvi_sysbus_instance_init(Object *obj)
 {
-    AMDVIState *s = AMD_IOMMU_DEVICE(klass);
+    AMDVIState *s = AMD_IOMMU_DEVICE(obj);
 
-    object_initialize(&s->pci, sizeof(s->pci), TYPE_AMD_IOMMU_PCI);
+    object_initialize_child(obj, "iommu", &s->pci, TYPE_AMD_IOMMU_PCI);
 }
 
 static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
-- 
2.41.0



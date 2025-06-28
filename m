Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87517C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbgZ-0003Hc-J7; Sat, 28 Jun 2025 15:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgS-0003G2-SX
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:58 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgR-0000KP-GZ
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:56 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7d41cd4114aso558986685a.2
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140674; x=1751745474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8RNDG58fu6VATaaftZTVcVDja/cJV1L/ku3KjsPqaI=;
 b=LJPw4U0qZNt2wInZ7TZ/vLBYrzQshgE8sMdehw+RkXq/u/EsAIG4GBk+CjZZp8jliq
 Mx0mvSngDavIe/hnsaLb4Clii1281Ixkki2rkMPbKwvbLi1xaSgv5PNpFTpzCvIhJzeq
 7xcEbhWub8ltNb2r39C1UITGshc6BLUFX2HDShLL0rkh28t0V6lrt35PNjkCdTcLoA/9
 T7eQOHCf4w2Vj6aW1sYCYADxPG1OfmeeDthledwWC1tbzgOhrKS0BBrte2WmwaQBqEhQ
 ZIFSbn8FYOXlXBdr3+earcBjieBwJtlspHmnYJ5VPknWuYsSH+dWoWxG/MnsN3EQ5ttQ
 TITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140674; x=1751745474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8RNDG58fu6VATaaftZTVcVDja/cJV1L/ku3KjsPqaI=;
 b=pC+S1bZtyGE4r35WKBmQGIV+zRqGYX/Ucwu9AkXoezcSC00Dc0YNg16Ac+31AOIbjF
 Y6tvapOnUGv5tmmBy0YbBQuodrFE0d6iQJeBVKd3WKDzpwD1oehJeoL/cxVfOIb4RMe1
 HmfP2JDIXEgd2And/f2Cb3DMBRvzIVZD8zA93P8+hFf+erjohjXIczrpmjJjqcpPUae+
 Fssz4m1XXyTbrYyGOoS9Vx3qjRRFZkfkiFbKg2gD1hoW3OYZr7lR8m0B0TwRJonhgmAf
 G7NeCBENfMuJO+MoEzZ93L2wYislviGAQogDYFowh5W99Rwnyannpdu8UpxStNETjmP/
 mqQg==
X-Gm-Message-State: AOJu0YzGcorSiwbJ14229HJ8UVzdiUXqpr8N5Y+MM74TFJ+jZVy5qWCM
 tEFAAoEQORQ4pC7WL2umC97ly3zuv//gyvCwaboM9/3MwBqybZMcANtleHz7YqqhLldC0OsWGPg
 0PhwS
X-Gm-Gg: ASbGnctUA3OnY7mtCwu2GVYTybrhxC+2ohDLx6BqBSQhwOZaS20ukbUZwJ31aa/Yi6Z
 SmONIug1Wr2UgzGMpUy/8XMrUefGKLsEvFAyktMHBX/rL60foqsgo3Y1dHpWKUWsGfkgq1Muoa2
 E/hu0T1Z+kAvCZBqEB1T0ZBn3kll/nj6i0TMXC7qcsbbPSr4Hsi2PF5np+ZqPeiMDrOyrDUxjr7
 UP4KLl3kdmOYmGqQbzafe/MHuth5Ceinqz1PJh0YWsIiRvQTYqJFenO0OKWTCYNv7yOHX1iijzu
 N4RGCPgSJ6UgW2HT3kt/fHh20LR6AjsLqpp1MdlIxNd2cvRQj31rBd/rqTQxx0fwHj4=
X-Google-Smtp-Source: AGHT+IGmfJpIieB66+GPziD/5Xt1TwlHhJgbB0RykGlKeLuCWkL+IVFNwDP6UPT92V+kq9drrhJXXA==
X-Received: by 2002:a05:620a:25cf:b0:7c5:9fd3:a90b with SMTP id
 af79cd13be357-7d4439a6782mr1350631385a.47.1751140674015; 
 Sat, 28 Jun 2025 12:57:54 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:57:53 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 3/9] hw/arm/virt: Simplify create_its()
Date: Sat, 28 Jun 2025 19:57:16 +0000
Message-Id: <20250628195722.977078-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x72b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

No need to strstr() check the class name when we can use
kvm_irqchip_in_kernel() to check if the ITS from the host can be used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6d9256a525..ae419e8671 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -705,21 +705,18 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
 static void create_its(VirtMachineState *vms)
 {
-    const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    if (!strcmp(itsclass, "arm-gicv3-its")) {
-        if (!vms->tcg_its) {
-            itsclass = NULL;
-        }
-    }
-
-    if (!itsclass) {
-        /* Do nothing if not supported */
+    assert(vms->its);
+    if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
+        /*
+         * Do nothing if ITS is neither supported by the host nor emulated by
+         * the machine.
+         */
         return;
     }
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
-- 
2.34.1



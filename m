Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD14E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwY-0001LJ-UU; Sun, 15 Dec 2024 14:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwT-0001J9-6p
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:13 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwQ-00016w-JP
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:12 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5f2e13cb356so1711363eaf.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289569; x=1734894369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Onf0PGU0mdWT869pO9aPdv4Isif7mSe2YqGwVARTFhY=;
 b=fDyEW8sPpHsY8nyANHbmTr3BLByk/TuQQovxfHFwGYej4hID+yH6Y5ENwG8Ed/UTy/
 sZDsCLoZutaIPNmURkPOfYOOUM/G++v/mp71Bn878tVO/JQKQXKphVnmQM6PmIKehYYE
 SzRApyMFphc+cq8AD9NuoAl9EIU0uD9Zsdj1X1b5UU0JhTiASi921iXLLP3+GrkHcFbq
 jzTUQ3cknlc8kyFNRWw/tGp9iaXokVSo4ZgNjEkRBsbV/vpVTq8oqxaTSCDwMi9MOlPa
 qpOKjS5qwdbXxIfXAqoFYA0OdVPPeRAdMKAD33VZNWYdfppvr2TXf5US0q/SSPiKtifQ
 mT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289569; x=1734894369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Onf0PGU0mdWT869pO9aPdv4Isif7mSe2YqGwVARTFhY=;
 b=Bvyj3qcljCuMC56Y21Tt4nJEiM3sLo7ex5XrPUQB1veQiWQciJsmv7vSx0H+SrTNIf
 rThM/hcvu2mJZo9SLOiWZa2K1BZuMGO9TCGXUoHl9nyJyveOS2f4Q85eXurxSkVPG+VA
 rJOXmZkfig393GTfXnfwyflyNrOamRqBq9ZjhTguc2DBdfvbzvR0/l8VdyAK3+CJ4z3b
 MU1sykxmw9W2+9apJQYKbmibsJ2Pg/5WhkjxmBN/qI3tR6P4E3v7l9Casvch9GgjI2R4
 xS2qDM4iv7F1Gw5D2Jq45ZSZp3KIvNbzIwZuzmQNLxu/y+mdIYfN2hTtIC3wrYFUp+XP
 eLoQ==
X-Gm-Message-State: AOJu0Yz0XinqTnsFsR15rjkac+naz0hkI4mF1aPTkHkwyk6rLyex5QcU
 9qkZGp6Rn9nBsP7HqEZB9WpmKbJqpSVCniFMGLgNkLzglFF+M66NeSSDbHEd/aP/ABQVoLjyMR4
 E1CJIJbIr
X-Gm-Gg: ASbGncuwUPAT+K/1HaKLgaZs33v4V4oahjC6qmNx7OveqNEJihxHb+2ZPmq+b5m1GX/
 A6cYvStI05m5p7MXEebJDF2oOFqKpTZKavYg3mUWuvF1I3xQR1Hy4U6V8lqT1F+6/He8h25PX4I
 sw7/yKVvqYVsh6wpxVqp7rzpSzJjY9zTBl6aQKvGNXVmFplGXF1UZKzuHU4kfx9D4M7p9a3JR2W
 sFxGydfdsHjg2hq3gdoo9dJ7bLEXYuedl02Gh0G06NUm9o90t0mrvB4unrczWiuCl3jtZ/om22B
 GqCoP4rOMHbY9t9osxHjnw1UIT08M7BBWmQiK2LufkU=
X-Google-Smtp-Source: AGHT+IHPFE56rw18y2eUFVhclP42EU1J/Vr4dVcT37Bdn+/zB4ePs5UulirhYpINFLvSm45AYJaUSg==
X-Received: by 2002:a05:6870:414c:b0:2a3:c59d:f09d with SMTP id
 586e51a60fabf-2a3c59f6a81mr4816084fac.14.1734289568951; 
 Sun, 15 Dec 2024 11:06:08 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/67] hw/cpu: Constify all Property
Date: Sun, 15 Dec 2024 13:04:47 -0600
Message-ID: <20241215190533.3222854-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/cpu/a15mpcore.c       | 2 +-
 hw/cpu/a9mpcore.c        | 2 +-
 hw/cpu/arm11mpcore.c     | 2 +-
 hw/cpu/cluster.c         | 2 +-
 hw/cpu/realview_mpcore.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 967d8d3dd5..5346b8b6c6 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -144,7 +144,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property a15mp_priv_properties[] = {
+static const Property a15mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A15MPPrivState, num_cpu, 1),
     /* The Cortex-A15MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 128+32, which
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index c30ef72c66..c3fdfb92e1 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -158,7 +158,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property a9mp_priv_properties[] = {
+static const Property a9mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9MPPrivState, num_cpu, 1),
     /* The Cortex-A9MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 64+32, which
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 89c4e35143..193fc182ab 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -131,7 +131,7 @@ static void mpcore_priv_initfn(Object *obj)
     object_initialize_child(obj, "wdtimer", &s->wdtimer, TYPE_ARM_MPTIMER);
 }
 
-static Property mpcore_priv_properties[] = {
+static const Property mpcore_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", ARM11MPCorePriveState, num_cpu, 1),
     /* The ARM11 MPCORE TRM says the on-chip controller may have
      * anything from 0 to 224 external interrupt IRQ lines (with another
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 61289a840d..8e43621b5c 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -25,7 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 
-static Property cpu_cluster_properties[] = {
+static const Property cpu_cluster_properties[] = {
     DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 72c792eef1..9a0ff1df86 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -108,7 +108,7 @@ static void mpcore_rirq_init(Object *obj)
     }
 }
 
-static Property mpcore_rirq_properties[] = {
+static const Property mpcore_rirq_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", mpcore_rirq_state, num_cpu, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0



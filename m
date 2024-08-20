Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C27EC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPuL-00060W-4s; Tue, 20 Aug 2024 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs5-0001vf-Eu; Tue, 20 Aug 2024 10:30:10 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs1-0001YV-5m; Tue, 20 Aug 2024 10:30:03 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-530e2235688so5928731e87.3; 
 Tue, 20 Aug 2024 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164198; x=1724768998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXrv0E3MFlFU+ItFyAOjyjeGygFPyj9i38Ckg44wQ0M=;
 b=RSM7IEJbcP/A+jhS6nwB8Dh3judFJFApvUqWs6LEus5xfjcaa4U4uMcUzXKzNCaZNq
 L6vHVySbpGG26+V4iKLYUaPJ8Zw8MpCYExniMXge3G7EHQNuW/iKVD9fhzoT9ZwIqjIY
 yrcL1ZlUEHOL/EV/Nd4ws8KFxPl0+k94a4HE+HwLofj8I8U2Oud0zueTYSuXQVWnfA//
 nI1Ox55dekivJV4tcNLhjmA6/eng1yV5jjwQw6ZcByuZI2DlpHnw74Aq70ga03glVSRC
 QUhMbgQQWi50i40kJhhOuRe1fkBH4UtyUJszST27Ljave8qMHlKwW16y3tnYpSf0ydft
 m24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164198; x=1724768998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXrv0E3MFlFU+ItFyAOjyjeGygFPyj9i38Ckg44wQ0M=;
 b=DNz6BMfVTotk7VrIhFLo+aU4vfUPDr91COz/E79QorII86+K9hM87BCOMp/SRcFWpn
 Sp+VCeQtbktzf+/S0rtx7E+bIdqajBUxn2M2CQFnLZw6w2pnx2LdhxMcpcpmrA+KV94Z
 t21bHOS4W6A4e3F0vdG/LnD0JFSze66pCNp1Ll86J+DAu3FgIhedtibTTmyOjp59bhzr
 DP8M4IRedDw7afc6VKq3yhY6xLwG3NESFUkUUjry/YHOBJciTg33OBRr9y8tfpa4GRKU
 kcG1HjD2htYfYw4/oHzIgx4KWnFMJuE+eFZcc6R6rAjzltz5AQzlBYc7JRGBMtdSGhhf
 qYVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX64dAr+XMF9JzMmZATOclW+4kFA8WTAA380v/jr61hpFYK+Sq56YprdZiCJyfJWa5RqWUV3NHwzA==@nongnu.org
X-Gm-Message-State: AOJu0Ywdo5NDfZEkxQKr2cp4MoA67gZY1r7VlvtYUnCIkrH0sefZpAjN
 S2kmZFhjQGcdKy2f65moJf6KTYp9LLdSXMMT7TVKbJ/NLGvgaUNnI9Amplof
X-Google-Smtp-Source: AGHT+IEUHrJ/SYDaIj+10HjdHpBx8iCW0Ws8VM3nxx/08/Kowr+gNMxcGQJYD8Ll+OK5SPcAIO861w==
X-Received: by 2002:a05:6512:1085:b0:52f:413:7e8c with SMTP id
 2adb3069b0e04-5331c6a2a5bmr10786717e87.14.1724164196933; 
 Tue, 20 Aug 2024 07:29:56 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5330d3b8f77sm1773996e87.72.2024.08.20.07.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:29:55 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v2 03/12] hw/arm: xenpvh: Tweak machine description
Date: Tue, 20 Aug 2024 16:29:40 +0200
Message-ID: <20240820142949.533381-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Tweak machine description to better express that this is
a Xen PVH machine for ARM.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 766a194fa1..5f75cc3779 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -216,7 +216,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
 {
 
     MachineClass *mc = MACHINE_CLASS(oc);
-    mc->desc = "Xen Para-virtualized PC";
+    mc->desc = "Xen PVH ARM machine";
     mc->init = xen_arm_init;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
-- 
2.43.0



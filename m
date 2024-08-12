Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A85C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUks-0004GS-T5; Mon, 12 Aug 2024 09:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkk-0003sE-KG; Mon, 12 Aug 2024 09:06:26 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUki-00046J-Np; Mon, 12 Aug 2024 09:06:26 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52f01613acbso5890016e87.1; 
 Mon, 12 Aug 2024 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467981; x=1724072781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOLz6jSGUU8Xiq4wmRd5lgikGGH6JiIyvQ0oMaht6JA=;
 b=WX1kArF3QfH+VhbBB9xwWiXRVJCoTWxVJK8LOYG+9v57f1WqKxSFiR7FESGQbqoYC+
 bGy2QtwgW+NJgCD2zlSU4wwHJecWVjtB3VNBPgu9q1JVgwFLJLpNR5szdqbDfx6dgm0P
 obutMNrncGZmoa54zg3o5gw/qZ0NN1wSfl5Zb60xWy1yJ3uoMp69akydCuuSQcuyaYLS
 bHxV6awYILWSk5mmTpw9jiH9ktOSqaK3sxeACG29/08QZmD1lhnp49QXJvK5sENv2T2H
 DYGO1mrOUBYmEXy9dSzmtpD+xmKigudg7CohRs8qgtzHaxHHtOEE0mR4ue+WJFMzSI4Y
 0OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467981; x=1724072781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOLz6jSGUU8Xiq4wmRd5lgikGGH6JiIyvQ0oMaht6JA=;
 b=rDRRMnMy5rFYO/KFoN/Q9knSrSdd8WFiA5Y8Rtt1cyZc8IX3qkbCPRmYxZvDxELWsB
 0GxjQinkEOtujKFXVXj0AB5j6qxQqqZqw2hhp3zgSmkoueURIelRXru6jriGfUXYxNp3
 LsfQjRUFspGUm8YQmQ24Q/W5Stc15Dvg7sMYBE040wf8rmQ2aYaV+PuJlj/ofEacgWSh
 oJEW1r0pyIL8LtLKgskRVMdllbPMEuxySofjn3O6DVa5HGZRLlnjIWrNb4BNP494udO1
 cuXPuWdIM4xHR+hatpN0Hn2dmM4H2EuwPdUgOdYPbJD8GIjLv58ooFTbzVna5hUBULsT
 GyPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYYDWii4OvoKgSs7Zt/DmIAv/hnKEVuhO1SZVjJf1X437V0BssBbLTWjvPt6/v6KLhrMV0ljKNtA==@nongnu.org
X-Gm-Message-State: AOJu0Yx65yjNRXOfvLSIZ5zlybvWky+Y4p4aI2QPhWZME+a8Of2lGCpZ
 gUKYV0mEFRZxZm2bAKS6SdvK0pcEJaY0su3hmRhv8CVkKrZTScQ2fhQ/AXOl
X-Google-Smtp-Source: AGHT+IFVFpgUsSJvoRktx9P5RahE3NL+hK1oSSRb0VxLTivi6mQbcvmAYVxkizJenzqOQTjrR9idAw==
X-Received: by 2002:a05:6512:4020:b0:531:5b03:b1f7 with SMTP id
 2adb3069b0e04-5321367c4ecmr11696e87.10.1723467980688; 
 Mon, 12 Aug 2024 06:06:20 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f4227csm730447e87.279.2024.08.12.06.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:19 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v1 03/10] hw/arm: xenpvh: Tweak machine description
Date: Mon, 12 Aug 2024 15:05:58 +0200
Message-ID: <20240812130606.90410-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
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



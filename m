Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F8ACD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsg5-0002EA-RU; Wed, 04 Sep 2024 12:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfj-0001F6-1g; Wed, 04 Sep 2024 12:16:01 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfc-0002GX-VO; Wed, 04 Sep 2024 12:15:52 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f64cc05564so22260261fa.2; 
 Wed, 04 Sep 2024 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466546; x=1726071346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXrv0E3MFlFU+ItFyAOjyjeGygFPyj9i38Ckg44wQ0M=;
 b=Sp3s8eRynDyKEw57hJq/Ugxj/jJc4H0bfVxcbxzmL7ZEsT3Rdhof/eBRaD2nn2PQKa
 snCvNmvlfM9E38g7QOkd4oqRmLTM5FA1YpYC0gAvv0m4pN9m77cmmSTos+f0gkd86vuT
 dxo4p2+j/sIYc4R6NRYf5FI9htvPX4EcZRPw9R/ZE0gCZEWTNo6iR88nv/U0je8AezcZ
 +Ifr7pEp5xd/GbdDFRQailQk4BVBI3ysUiIuuMpoJf/V+YXnag48SDeyUzTpgFQmGuLD
 NezhaEE/FJQQBHcuHfU6O+GOv8YF/cicxVB007SDMDDUn/7cx0Mrub0zBJsm8GZ9OPTA
 EaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466546; x=1726071346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXrv0E3MFlFU+ItFyAOjyjeGygFPyj9i38Ckg44wQ0M=;
 b=ZnsxpWFOix7kfZdzOKx1VD+oTjxhgdK3+fJ8aCxpeflW1xZM8skuKOULjgkrTOeTY/
 q/RHENyUDQG/htoDPVoCSQPcDrccS0yXyxVBmTe3Z0ax16ETMwJZcLMmFtUztR6oTHCx
 01FsdAHSNwOvsExP8Os5HrB9E8kDPez4gCPPBi8HReM81YW8O9m59swFsdsOqmIHmvR6
 R+Zxkh0Bdlr2sK8vDd6ZypIYn7rEvDIKnZyDWesmUGxOYRr4ANYwBPxzsqU+XjC9vKwk
 tmRdJ23ZlkC805HXuVyFTH98VIxCZDRIWe9OzuksHCwu4ekhQXsQ544aAia/SBKqVM/b
 FGcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRZkxJcNEOQMzWNkC+yDgIml83tGCWQMnOMEkxX8uwsPH4irpI4FWXVEKgrhlwkaljGdYsJQNItA==@nongnu.org
X-Gm-Message-State: AOJu0Yyjk40xFydi+SpZw2xRsTiH5aPehvkI/AnAgelEjNHbgQ1lF3PQ
 c0zwg40bgc2J8bcTNROoj8ea2XWoIcEf9X0uvG53t2KnHSQlIA5Mua+WrR1O
X-Google-Smtp-Source: AGHT+IGAyh4WUxY9AfkVPMwTqyaGKO5sye5d21g+iPTe1bXZL4tYnRRSXSRVmyNk0vZJE9XGQJOMBA==
X-Received: by 2002:a2e:a586:0:b0:2f3:f4e2:869c with SMTP id
 38308e7fff4ca-2f64d570e98mr37440521fa.44.1725466545191; 
 Wed, 04 Sep 2024 09:15:45 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f614f0079fsm25852041fa.37.2024.09.04.09.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:44 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v1 03/12] hw/arm: xenpvh: Tweak machine description
Date: Wed,  4 Sep 2024 18:15:27 +0200
Message-ID: <20240904161537.664189-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x234.google.com
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



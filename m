Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E0EC73C66
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9lW-00023k-9B; Mon, 16 Jun 2025 09:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9l6-0001tU-Jo
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uR9l3-0005Qa-QH
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:20:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-235d6de331fso53064815ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080016; x=1750684816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYXF1EngE0eNzxoehIltsTJwDvypLa/shlFclH9Sekw=;
 b=m9Ob4OrGNIKMDruAP+s3GFoygnh78J77zcC7qsNNRd4sPlhZBX2zkOxOp16wKAivpe
 FnxKLbY1UVWFW/22BwL1LIt/LmMoIhBEt3ift2C03RMBBilhuabNyxFJdkDhWvX4+TC3
 qvCnSRorTadx1EeTk3VSPNdFduUAjMarTRrJCufvSQKgrr0n9jGVDr1Xls54qO/oPUOk
 Iao1Rg1/JTHDer2OSurdWXI1RbA4cUQCt5w0t8Xpe5gTK7C40p7PiTTXwWfsBrQtbz+N
 bKaZj/MZs4dJr2gZly2IgLB5j/9IkgdYUG/IWpDoFq06Pb5izptf4L75Ik/7rqJjbgpX
 jGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080016; x=1750684816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYXF1EngE0eNzxoehIltsTJwDvypLa/shlFclH9Sekw=;
 b=aUB7OvRvqRB8sA0SOqe9CbDCU8I/mth90UyOh+Ncmgmu/j8F7W+zJTzwVe7oP2l51+
 dGIdUf9nhxw1/Wi8G8wYbfuyYqohXo/FfZxEttOCyCnVRK2J2FjhwFxEtskfk1N+gvPG
 UcYAU3/vPhDISOs6vACEgZR6RklzFPhUESlGM1RxzbO2keIw+h1YVfZdY/uzpIhLWauO
 M6DO0gwojFMqc4ua1HLpQZzYAfci+EVcS4WPavCIid9x2t83k3QmaFeVxsmYBF7miYXv
 jYbC9UBOy8SBrdCrA8pu/Gnh3BAVXoxYK0XE990JDleOKuQfxcSof7fx9mRVCswQX+Ow
 86WA==
X-Gm-Message-State: AOJu0YwV9JSLOoFe3hHkNWEBKmkzOHZZTTs3lN6bDM8ZykwkaESg1zdF
 WAbUbOKvxdyL9045yPlJJTisi3GJv/r12m7q5QazvTvu7oiy+e9NCrV9B0tFKVFzsqLF+yHEVXM
 zFEJA
X-Gm-Gg: ASbGnctxiI3EbZ3ouPNPnAzMZZrjg6lUDDbkICC84NtG7fY655waiJZFjB7CGOqG/k8
 +/RKx7+Hxc9i6aO7anz+VpJG2te5F2gFxmirX867gYwnVKB/dUSCiwoG/BaRIS4+zi0vdyJZB2a
 jWZb4DHbDOFqaWsZHeefLt97MoTbS/WmxJASRc7eCExd7tyN6nybUguoOiNKZgbf//pFUuOGI6t
 OzpmNo4bgigDZgcokoAaOV09YZjn7107Bvwg5g0dsNMrDqu6dAZbb7wbiBPv9PoX5eJfU2wbQ+G
 dWlZ8NnjWYlwWKaUT0S6y6H16LhOmsvEVZxaHurT3nWqaqTgxdGDq1LilpJ7Jw+Z0nfFIIZC7w0
 pvA==
X-Google-Smtp-Source: AGHT+IHxKzenoPSwH0Xt0YtaqfffxhcuZ3fOVL2vu5Zs+h8MKNPgLXUU7QtEaOjNgbN1i299iWyNJQ==
X-Received: by 2002:a17:903:320b:b0:234:f580:9ed with SMTP id
 d9443c01a7336-2366affb323mr146617775ad.21.1750080016002; 
 Mon, 16 Jun 2025 06:20:16 -0700 (PDT)
Received: from gromero0.. ([186.215.60.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365de781dfsm60848405ad.131.2025.06.16.06.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 06:20:15 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v4 2/8] hw/arm/virt: Simplify logic for setting instance's
 'tcg_its' variable
Date: Mon, 16 Jun 2025 13:18:18 +0000
Message-Id: <20250616131824.425315-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616131824.425315-1-gustavo.romero@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
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

Because 'tcg_its' in the machine instance is set based on the machine
class’s negated variable 'no_tcg_its', 'tcg_its' is the opposite of
'no_tcg_its' and hence the code in question can be simplified as:
tcg_its = !no_tcg_its.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a3..42a63a523e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3337,12 +3337,8 @@ static void virt_instance_init(Object *obj)
 
     /* Default allows ITS instantiation */
     vms->its = true;
-
-    if (vmc->no_tcg_its) {
-        vms->tcg_its = false;
-    } else {
-        vms->tcg_its = true;
-    }
+    /* Allow ITS emulation if the machine version supports it. */
+    vms->tcg_its = !vmc->no_tcg_its;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
-- 
2.34.1



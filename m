Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E7DE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB9H-0001YW-24; Fri, 13 Dec 2024 14:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7V-0007dV-6R
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:38 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7O-0007cg-Rm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:34 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e63e5c0c50so1018045b6e.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117267; x=1734722067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpq4UUf6dVqmk0jMJhoczKkqUStkLqI71UYDr3fDwHQ=;
 b=qhIA9E41vo+5jnrVNuMubUBYjGSCxvHJfWJPs2kQhS/BEd4Gd3lIKFMwi9OMRNrDxP
 bHUJPksLlQ5ZZjPwZue6ymaSzJsb/JVL713eVgxKwA+ufE9/5V7NQqn6xU5doiDLV0ze
 d+uItq5I1BpMaBWdHKhhr33ZtOw2CfFM7f51ftecjnZ5hHoxdxDKw1aGVxl9Z+Nsa3oG
 pZUSPUFyzb8K+9Kl8SqnRjeBmpOWoGVBCSTZYVSQu+OF7YRtwtxpklqd7s+BFmY4j31c
 rjbhCt6SzIcuyAyl9YehjexjsWcbqDcrpFyn65/UwvYegWRgEyQ6LIb8H1X9f+x1YnrQ
 vwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117267; x=1734722067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpq4UUf6dVqmk0jMJhoczKkqUStkLqI71UYDr3fDwHQ=;
 b=azpVH0yq9mAuY0pdGYOc1a8ABRfpBS+1cDJRLMagwD32CRhLLGutVjVU4Nvy2pd+v4
 UMzkNYtwYJRXIn/yhpV6pB3OIrNJcTsxFWJQHMN0AKeVmL6cr+7Jk27TLleA2cRyweuD
 Qiv/4nWnKdH3UzEH97gnf7oq3OhSwpy/haXcXuSKQ27IDtf0NFF/mDOFbvWV+nxo4Mg5
 3zi7+LXrR0c+ZI7mKFrEFDWQ3EoEo6Tra8WoLKYXcuM97AzFBVuDoTlg0nHZXM0NAG59
 tbTqjdDVkAfz2Hq0tJqkotYrHLQY5np8It9IrouKVL4IXoeScbNQd5SPQfhHp80scmXD
 kuDQ==
X-Gm-Message-State: AOJu0YwvkOCQyFrhoQdnYwX2Oqn7Xd9bd02lvjZmwgVX9N8ORpzPf7cl
 Im0Rhk1hmVztrPC/8N0uGVE/SksX8TUly31JSO8zmBPY2eaWPSRCw+q0+Uk2cMrxlBlS+UO0NAy
 caxIwg1e9
X-Gm-Gg: ASbGncsNkUaZrVY8gc4f64J4kS53OOMbirYdFWos9b2JxWjx6EdgDL6y4W0XeBBo+9b
 SeB/evzLroAS8nZ3cSD9B87mO1S8UGPBVpHkYmqjOj/gC/LK5ry6DdO78i95WHzS/x82ZJ/sHE5
 hz32KtEwKBD65i5ohN8BG3pw1yX9jS7WJ5PTxtL64n/uCmkJh30nlOB1jjboakJim79hbNDO3ux
 CTbAVQoXHv51v05y6ALvA1Hqv0lANowUWPxk2D+Y899+EVOh6RWN4auRM4449qH
X-Google-Smtp-Source: AGHT+IFTiUpK4SMcy0MXtvg3evRUpzInwl8nGjaN1K8ysZSKq7+DZIM9wyIrf6kL1Wep0zWIUpPC2g==
X-Received: by 2002:a05:6808:2008:b0:3e6:d7:9464 with SMTP id
 5614622812f47-3eb94f629cdmr4108402b6e.14.1734117267233; 
 Fri, 13 Dec 2024 11:14:27 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 57/71] hw/sparc: Constify all Property
Date: Fri, 13 Dec 2024 13:07:31 -0600
Message-ID: <20241213190750.2513964-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sparc/sun4m.c       | 2 +-
 hw/sparc/sun4m_iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213..b8cce271a7 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -732,7 +732,7 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
+static const Property prom_properties[] = {
     {/* end of property list */},
 };
 
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 6f765e97e4..3d6fcdf576 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -368,7 +368,7 @@ static void iommu_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
-static Property iommu_properties[] = {
+static const Property iommu_properties[] = {
     DEFINE_PROP_UINT32("version", IOMMUState, version, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A17E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJduz-00046V-OG; Fri, 06 Dec 2024 14:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJduw-00045X-6z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:11 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJduu-0003Ut-D3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:09 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7250c199602so2702284b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512987; x=1734117787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INFqv3r+4Rnq62Eab2ceon0uXvH0WJurlI9tlF0uERo=;
 b=XulUp2k9x36CIaYOhRFzkalSCVmrlsNwfJTtWAJ3qCji+qCcbqOtP7jKl3BZhuFnZa
 cA9A2GA97tR7CJbbItQfZjXj8VnOb9dkvYqQfp84uQ5BnJNjcAw7g6gseIhOsrw5fBLZ
 cckuRSVvXJqsqD9isFgfFiHgbOMmFjh/2Cnh7Q0h69RuMTtX/G9WmFKoSN1fIgmOmPzF
 gwRTibupQagBNfHEw76MJtPQxUZtCXh73ZlO48H5I9JbSGK8vFHkPx1SktUn+vZXIY8M
 tuz96FmL5U1jxp72qN8xA0503QTmZL89UJwbeIapmeRjWdXOVYSS7J80QIxhIxAmhbMZ
 5Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512987; x=1734117787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INFqv3r+4Rnq62Eab2ceon0uXvH0WJurlI9tlF0uERo=;
 b=cnAi/RGtB4jK+h+54szQ0dUF3MNL9BBei88OCHCiKu1auJiDhisAFb9q1ntkzqYozi
 eQGCpulomglP+562+1vCQxTO1T4cpg2kbZXemZTqGbl3JcDEi51wiMcSeDrWqL0bMBJQ
 JlGh8VdndmaKsPbw3vJNy7cBAh9EByQ+PlwpEHXYLSa23WhL2PhZmGDSSBim/Lbbf6kk
 c20IMuIt/sC9GFEEkZAUlQZmChKFDkeZ/GBzqMAsF/Ec0GrV2exT6m1kXm5qeuTNaSTV
 04Ymc7t9wuXm6ivU2Eh/R5Kx71597rHVCSiUgDmyGJO/LOqSYxSbGx+UoiUyuQjz8whc
 3ltg==
X-Gm-Message-State: AOJu0YxT2lmwGQmyHVEqnCPznhNKKsTCseAw56ORqnXw7fKLsfrsMPvy
 eCIZshRVXuoJc8n6X0YWhBmeKroF3Z/Ie+11xDLjgVGRiIYgrwK+Kg/L9UBRGgALcJpPfVr5oRc
 zJ2E=
X-Gm-Gg: ASbGncvTyFKjBu6wzYCKN13vaPDn5YKQHY4tBUeVj8tuFSrF+cnAxaVBO9Wea8pJzGV
 KOiymVuBKgwl2q4WaL8ZeW/hr2YqFIWlbqlqlm5dBpvBpK+yjMlyk1Kcgc0JcUqF4ISTRZ9IcaH
 3LOpzsigZ2s3OVKT1xVLexJ1FOhA1DtS/2dI3uwzBUPQ2m0g925ic//mPQ2MKCx/1t/g7ek/fIi
 QJ+oBymscjjN6NFaJ+WFHpnXCs52o8+CClcBVLfZjB5C6Vt/mBgG6u1dEUx7RcYXqa3EKXxGBIy
 ORlD8miY
X-Google-Smtp-Source: AGHT+IGFNMIA203JcpKeFIxylysn79ylSKbJqspslFJM5eEBt5ZksetIN2OXtt9tYkuYEuZ9DdKz2g==
X-Received: by 2002:a17:902:e74d:b0:215:7153:5697 with SMTP id
 d9443c01a7336-21614db3f60mr54621075ad.28.1733512986288; 
 Fri, 06 Dec 2024 11:23:06 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2161e5a6f23sm11720395ad.266.2024.12.06.11.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:23:05 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 4/4] docs/system/arm/virt: document missing properties
Date: Fri,  6 Dec 2024 11:22:54 -0800
Message-Id: <20241206192254.3889131-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
References: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/virt.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 11ceb898264..d25275c27ce 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -169,10 +169,18 @@ iommu
   ``smmuv3``
     Create an SMMUv3
 
+default-bus-bypass-iommu
+  Set ``on``/``off`` to enable/disable `bypass_iommu
+  <https://gitlab.com/qemu-project/qemu/-/blob/master/docs/bypass-iommu.txt>`_
+  for default root bus.
+
 ras
   Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
   using ACPI and guest external abort exceptions. The default is off.
 
+acpi
+  Set ``on``/``off``/``auto`` to enable/disable ACPI.
+
 dtb-randomness
   Set ``on``/``off`` to pass random seeds via the guest DTB
   rng-seed and kaslr-seed nodes (in both "/chosen" and
@@ -186,6 +194,14 @@ dtb-randomness
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
 
+x-oem-id
+  Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
+  table header.
+
+x-oem-table-id
+  Set string (up to 8 bytes) to override the default value of field OEM Table ID
+  in ACPI table header.
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.39.5



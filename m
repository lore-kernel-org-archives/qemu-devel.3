Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD61C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngkl-0001kC-JV; Thu, 27 Feb 2025 11:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tngkW-0001fA-U3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:28:37 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tngkN-0004Nm-KB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:28:35 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22339936bbfso19326775ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740673704; x=1741278504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/5n3RXyzcPpn1F3v7BYmD9szptZhygbu5j+Mega2qNw=;
 b=m8SNxC6vOR3v+bY7i4L3p09MRbIMEJoZFwdNQDsRjv+X41FhLioRrYw/UiCXbcdSBy
 crXAjvI/CdW8c7C2NbZJWOOk6Yp+0uIFtm7IFdvBSI2IM3vJlNBYBr2Y1YtSvUMdNMce
 yOC4T2IQotzKBjdHCuMOtvChwu8jcNBwSr4sklqc4a0ky6r4gWI9MmNQwE0kb2fVuimj
 KFmxbz7voqnYD0LbxWSZgTFYtU087UFTcKfTAX0iQbBS1Dq/L37pc3BwhAWPLrsrt4aj
 9AanzimL6HvCkPUFKQW0x4znwtMVMGGwNlubRGOZOa8V03bmfSoWGD+jBEyd04/S9SwT
 hBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673704; x=1741278504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/5n3RXyzcPpn1F3v7BYmD9szptZhygbu5j+Mega2qNw=;
 b=HEb5H2NsB9x1nUe4knN7BR5HfcSA66Q9mRCRLfOdg1TFwWhhfGR+UiRX/DbgcnUoo1
 SD6DC7oMW8i3EUKkBw87OxZYF6NBi59rQ4jPiJf1STaxq6HfzB2n3vfHe0wUCnslUDAG
 jpuZzb7zHKJ6lDqKfoEwGwhqMS1UDYT/43gBXb2arrExQCSyCf7mPtOvPsq6oJ0hhtEV
 FHC8UTu9MHQb1eGaC0Z964SLSe/pSrx56s8uwp0pzF4xlZv34cnERysMra6dkRKjixNH
 mS3BMOtrLvADslR9n5Vbzdvohb1cPf49GOTvOU/sAs+X0ApxMZwvXsZkFmZSyGIfDDLK
 PwFA==
X-Gm-Message-State: AOJu0Yzhwe2kvmZPKBFntO/l9BVxrLRxjqYcalZt8wo+zLJ6jHAJVpu+
 vJmNjuGo9OQeN6sPNUeP81a3RP5oFaj8xWS5HrguTNOYJOzwiSw=
X-Gm-Gg: ASbGncvMIthYiIWFDbqwa6enTbKGKRk/xzz90/IAKP3x3i2+Tblcu0gagj4Ut60VYrV
 2LlZBZgor9ghhNxKI9dsZmpv+xiCDR7QCWKbZxLDU8JzppsqCS0k5tfys179IyGkRD3WCfFh/yN
 SpY4nFPdQFiA+IoJqZgF1m8wzoc/Ajgxb8PrMX8CNo/ucOuVeCrZ1BFsWSqPOoha+0HhVTbBUtr
 6CrWhRDWLPxwUGX/QkGYXCOxMbmGlgtUKdECwdRNIRqQFrn1qo7RStSMWFhI3Eah13TW6O/j99r
 5VlyVVY62JeKSzA4OrCBeQkYu0LvDbL6gEu/Hng=
X-Google-Smtp-Source: AGHT+IGIhwPZwuSx99+1bEVZtQbv1/KAU4qw2f8yZLYiP31IAtkwyKe0jyvcWc1uet4i1/Azv4etIg==
X-Received: by 2002:a17:903:2288:b0:221:331:1d46 with SMTP id
 d9443c01a7336-2219ff8278fmr387504015ad.2.1740673703668; 
 Thu, 27 Feb 2025 08:28:23 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052a622sm16847825ad.231.2025.02.27.08.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:28:23 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH] MAINTAINERS: Add myself as vfio-igd maintainer
Date: Fri, 28 Feb 2025 00:27:41 +0800
Message-ID: <20250227162741.9860-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

As suggested by Cédric, I'm glad to be a maintainer of vfio-igd.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1911949526..c6ed2f46f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2176,10 +2176,17 @@ M: Cédric Le Goater <clg@redhat.com>
 S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
-F: docs/igd-assign.txt
 F: docs/devel/migration/vfio.rst
 F: qapi/vfio.json
 
+vfio-igd
+M: Alex Williamson <alex.williamson@redhat.com>
+M: Cédric Le Goater <clg@redhat.com>
+M: Tomita Moeko <tomitamoeko@gmail.com>
+S: Supported
+F: hw/vfio/igd.c
+F: docs/igd-assign.txt
+
 vfio-ccw
 M: Eric Farman <farman@linux.ibm.com>
 M: Matthew Rosato <mjrosato@linux.ibm.com>
-- 
2.47.2



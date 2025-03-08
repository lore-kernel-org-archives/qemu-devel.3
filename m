Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACB9C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Iv-0004fG-U6; Sat, 08 Mar 2025 18:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Ip-0004VY-OB
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3In-0001AH-HC
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so2966833f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475391; x=1742080191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLqJv5GFiMdqC5SzSdRzdt+1VdUICrsHDhSI3tGgwd0=;
 b=gZuMS1cf8zXc0JgaVbr8P2eWobGvs0LK1dQE3uKqLBOYlBNx/NOFwsNTjDWubL+CWg
 PQ/+HQPcrja/ptp8ljbBJhSJvU349Fr6VUdujF8SDn2LLa/G9Qi9DPwscqAZy0xnaVJH
 v/7xw6EPIbU+3Wvbn5pJ4od4AsSP9QIINp420pL7KTClDhfDGyZEkPguLWnnFH95yJr9
 Fuvjx34Q9uahXMPhaFs05NZFBczHGluVb3ZQH9pp7iYllCFLifIEkShHv5hU3CQivs+2
 ygQiVaAWybihJJoXZoD++jJGPisx0/cS8scMh7a8own1uv/LicWz8a3RvJZaCE6fHU5H
 eRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475391; x=1742080191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLqJv5GFiMdqC5SzSdRzdt+1VdUICrsHDhSI3tGgwd0=;
 b=JM+SPgD5gesCzZjnxHnx0Joqg2bzXH+BpxleYf2nHlWFSHMIdk/JgTHn12H61RqlUB
 IXXXx2aJx0ZMrlgSGhtrTNiz0hPK81la40fD6+QtC3I8IO4dnFbJK4vX6ZQVqQWrDHfT
 MuJZHni5FhvfvrJMvMr/taUcGYZ5C8QIB1FF0Ex4MQ2HJN8o/CVRmTwdK2bfLuRg3AUt
 6eKOzqhSye4cymDRPqijLDeo8wQiDNb7cO9u0uAkPcvybDyLwoQrh5rXmXxRfmX4ORBK
 8WeU/UE/13n520/ccOt/ibrfsmZ+O2hiE3H9yCBJjxZWqjRmMgC3kWCvh5r9TjpGIczJ
 jKTA==
X-Gm-Message-State: AOJu0YyNzw/YO7hVpgP5S7hjkrbS8cjgOCu9uV1dyyrt1CU+/N7wnM9S
 pWnMUCYMk09ZFAu67soYXk20fBcBmomU7DgXWHMdbqG+VGjySNfgsM08NZgujS5JpTXiKQDGP+l
 bX1I=
X-Gm-Gg: ASbGncuGWseiBTH89POq11cdmCuc3q/HTrteKITd7Wz8luQBlX1aQQpODIuNtirUFWw
 Lx7z5E2kiVT2NTr4+o15gO5iIw8OcppMgVPYjjFn+RHxJh2vASDkTiavZWaztW0UoT4aGci+Zvo
 c1gvmoatsmKDYiL6ntTx/0ap/oWC3tYb6X6rjLx8BQjkLTVvC+QKUj5ZQAIEOMs5mKk31FgDAzT
 nHvOkw+uJytzNv9cAuv8Q1qljYlhF2T4SUmKE1LBJy9TALL4/UlEyd1RL7dmWbGbfWGfsHslJGk
 Ti5r6wfVQG0SkdNbEKOae/jG+B3zuhkwLQloaMt4Bmwjy2qgtWybgTB6jWItFQk1ZTuhDYIieDC
 3pidYxmoecCzn68d+vgQ=
X-Google-Smtp-Source: AGHT+IFoLK+xqCwbE74i/YFIgsjJ7Nm/q7qXKgEmlP4DidAEt6Fl8aqw1QkG8mrCX5ar2z4veKXWag==
X-Received: by 2002:a5d:648f:0:b0:38c:2745:2df3 with SMTP id
 ffacd0b85a97d-39132da24bfmr7412108f8f.37.1741475391309; 
 Sat, 08 Mar 2025 15:09:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102e01sm10299396f8f.93.2025.03.08.15.09.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:09:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/21] hw/vfio: Compile iommufd.c once
Date: Sun,  9 Mar 2025 00:09:01 +0100
Message-ID: <20250308230917.18907-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Removing unused "exec/ram_addr.h" header allow to compile
iommufd.c once for all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c   | 1 -
 hw/vfio/meson.build | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df61edffc08..42c8412bbf5 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,7 +25,6 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
-#include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 784eae4b559..5c9ec7e8971 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,9 +4,6 @@ vfio_ss.add(files(
   'container.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
-  'iommufd.c',
-))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci-quirks.c',
@@ -28,3 +25,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'migration-multifd.c',
   'cpr.c',
 ))
+system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
+  'iommufd.c',
+))
-- 
2.47.1



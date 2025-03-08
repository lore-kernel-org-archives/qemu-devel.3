Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13A8C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Iu-0004cp-4s; Sat, 08 Mar 2025 18:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Id-0004Od-C2
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Ib-00018K-JD
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:43 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso25244365e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475378; x=1742080178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4sOyyLdHZ94t1nFvB4a0FIi/FlAkRfDFcAkUZmK1lY=;
 b=MX77kb9JO7XHnzNDtbXjTLYay7TnVhI2+NWSCCkCtBPkl059vPVfZrAl7EGmF9p9wj
 VqFFbOKhUiOQXNOzLUYeOFUH/K/cZ5lvJ2X2xIwZ/VZfUx0+j+5Nib/HrMdMvwOwEiSF
 a4BWWmkAIX3zil7l6Goqe028qryJHAYhI05g75GYXVcYG2q90TcwS/Rqm9opzs46jwz4
 iHdumTQ1xGvpx6+xoHity/Psbop9vXQPLVDP+pN1lIQ00lTZgWxeIAh/HIPolCdLRasj
 fGuo3r/3vs6Tks6mCQBNeC6T9bKPsUqNQyKdQ5JpmT1CpNSYMHsYMttM5/nLFZldKhhb
 7Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475378; x=1742080178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4sOyyLdHZ94t1nFvB4a0FIi/FlAkRfDFcAkUZmK1lY=;
 b=hOhA9cD1hR997IqdJ15r9WwJrQG3A3g0TRdfnt9sXSOrVOI4S7VGbU0mKhuHBVNvod
 7M+usKkVa7nDpDBmzZiEAAxZOBrq41lsHyzEryvIju+BwgAi7rb6sVzOWeLPZA7fhCQW
 jyIhfhVdvji2rH/30Xlbi1SUWjrkMJqTEdBYPRyYSfEp0Xjn84EWD9y0lnU4+EKwSAyy
 gcMjOmXncvI8mutjFQkP+TyovFZnTznzGPJPSht+HZAH8jinBv7DGEzRqagWSpVhambM
 tXSczN4DgydBcGgk/iQJMaOolgEZvNqzqeYFyfmUCodUmv9TGE6RyUpo44XDSM63Nn4L
 EhcQ==
X-Gm-Message-State: AOJu0Yxu0x+MfrYAkKsekgCuM2JbdK1M0jX46ntjdt9kn9glSNpBj96U
 pnknGOIxlPcyE+FCE+6pRwrFxYDR3BGy55YYG5rRgxIUWJtnRS9Q2c3s7iCFxB6DWz8mg/Ipkqb
 rjk8=
X-Gm-Gg: ASbGncsseb0OVYk13N720AHQOnHyMNa3xgwfEBqtqwOlbvxkTBVw0bOoRWXWh2+8vXc
 BTa8wLzWbsf83NN/FRaX0YysUfujHGl52g9/gzY9KT1SC7QvLNNUld6qZEAHax0hLrTXFas66yo
 5KIPcQnbU4Xs2/axEk94uHCUK2lvoJaNMJbbToFpaGtFCbcuIi5W1/Y+Sy2c9vjNpYsB3owVfsa
 A1z9CVr35YocSu+fnzziwcZ26sOQDED38HHHGCQJCh9w0LjjTtSZETHUlz3Z/j29grINqeNox0s
 ASFnhSWH7eI14ic3BdPSkIaOLZ0ygn5uIqnK0TiVHAFY1VOVRxltAQETM2I7mKne9WtYEyMkpZv
 9Q3g/I7gXR9aXJZyLQAw=
X-Google-Smtp-Source: AGHT+IEw95hLpQ6L7aoWgp/bxwK/ZuUh6EVLZGte6tf2yrptaAeFh+yTGwJkxhI0K8AnTcsOHslqpg==
X-Received: by 2002:a05:6000:1a86:b0:391:a74:d7e2 with SMTP id
 ffacd0b85a97d-3913af390eemr2446915f8f.26.1741475378455; 
 Sat, 08 Mar 2025 15:09:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf27f8ef3sm2422605e9.11.2025.03.08.15.09.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:09:37 -0800 (PST)
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
Subject: [PATCH v2 03/21] hw/vfio: Compile some common objects once
Date: Sun,  9 Mar 2025 00:08:59 +0100
Message-ID: <20250308230917.18907-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Some files don't rely on any target-specific knowledge
and can be compiled once:

 - helpers.c
 - container-base.c
 - migration.c (removing unnecessary "exec/ram_addr.h")
 - migration-multifd.c
 - cpr.c

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c |  1 -
 hw/vfio/meson.build | 13 ++++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 416643ddd69..fbff46cfc35 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-vfio.h"
 #include "exec/ramlist.h"
-#include "exec/ram_addr.h"
 #include "pci.h"
 #include "trace.h"
 #include "hw/hw.h"
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 260d65febd6..8e376cfcbf8 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,12 +1,7 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
-  'helpers.c',
   'common.c',
-  'container-base.c',
   'container.c',
-  'migration.c',
-  'migration-multifd.c',
-  'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
@@ -25,3 +20,11 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
+
+system_ss.add(when: 'CONFIG_VFIO', if_true: files(
+  'helpers.c',
+  'container-base.c',
+  'migration.c',
+  'migration-multifd.c',
+  'cpr.c',
+))
-- 
2.47.1



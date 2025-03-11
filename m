Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EA6C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvRP-00064W-86; Tue, 11 Mar 2025 04:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRN-000646-4z
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRH-0001KO-Cn
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso55879265e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683493; x=1742288293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2kPh6kRYOMM0IF4sCb63AP8GV3ulvLKBS+FKR63ZmY=;
 b=UnR0vt+rIS4hhNj0YtlF5L0F7PH2HM1hJF9l+5rjXa0x5tSxphZFWOnLNPiLZF0LpD
 Gde9e8JqSGC/VMkYkSB4UiLEJTbtHZJAjQmi9PxncFOU61BCxxnB/panCrIKlDjV6E5U
 7AVhAofeliIqSXnnPeEZS2+5OH/DAx4BrgeyLF4Tyr5zX+WjBz62W/x/+Y3JCDZDQZRf
 IvF6tJg0q/d5DMcq8B8pur6dD1jUkI354SdNn4JEn27Ywjf6BdSBljl8/D8orYSAOxEj
 d/UAjJS0nhksgrgK7J4u1ESlaxTQZRmt3/uywZVaYQ3dyq94/iVLUajfWX7qggBJ2ZGY
 DtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683493; x=1742288293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2kPh6kRYOMM0IF4sCb63AP8GV3ulvLKBS+FKR63ZmY=;
 b=eI0ukZLlKBAnpir3MqkJNCSHBDN/mjiet63/MFTnvkUUELMqsoSqdrLlEcTFVr97Bf
 xVv/Q7b+uv4k4u5EIe7gT97CtFEg4uHVjEkZkIiVfb0UAevLiurO5n3fxtSbC+GTQXav
 xNgRZ++zB9/ePnVRtnjPFNiKQsJ4SDCbnDLS5mtQgn+wEhxqWFCXNa7l+iutu4YEDnkM
 5qdTh65QDyFuuOuowzLmSvfm5N46gLalPBAGij1FBIpHirGRTjFs/jYDeHsPj7g7BKHs
 9eQR0stBYo5I2+vmr13YzswYDpLp8I+qP6kO/70QwASubVZZNuZkCofnFCS+U56zixuv
 osnw==
X-Gm-Message-State: AOJu0YwJJnvKEOEhBJ45djbmOvhULFBEtoXoskzm8jndAN2IrkRRYHEL
 MSS9WYmilV2qm8Zusl+8E8CNqtjis2wA9BDsVB6G5Uj7Js9kW+w3dWdpKGaznPNRHOMjD6ZVKOw
 nQGo=
X-Gm-Gg: ASbGnctKZUgxKuDOzPNtfQJWYpOHvgYCOYsrJXx6V9UYoWk3rQFi0MkRqBRQL/HjL/H
 bLe3O5oyRk6dryBW67YW4Sqj4gcVnKMCOGUl6BOEduX9Xx4smuxoEvu3Lgdj/KqmNOlAoUpGbHI
 7cUeW4kiteV35PNcbqnAlbaX0pnGLjaEVSryEeKKet7ZWrGDOt8aPwE96B9/lERpQ7FaaIsxAK4
 p/uKp0uLf2xLV2BV+5fnrYdA8ZNxAdDXdgGkuDNALNZsGNbakFu45xqy19bGzP1idYIKKF8Ayr+
 PRbS4UdI0BFQDAXx7OA9EP/xNVW0xY/7RWdaVLyhOWLXip0vLf3rhfEdeKOIe8Qw8Mw5+tyYLEf
 nwz+XwcikFGyPcIktdaM=
X-Google-Smtp-Source: AGHT+IGc/RVMvYXiBKViCoX/7zU7bIYN8JsUf+dtEpfbhQlY+2IRsvf2+MB/6cVrndyBfysS6+bztQ==
X-Received: by 2002:a05:600c:548f:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-43cf87c265bmr69469515e9.21.1741683493187; 
 Tue, 11 Mar 2025 01:58:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf7b88494sm65959105e9.0.2025.03.11.01.58.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:58:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH-for-10.0 v3 5/8] hw/vfio: Compile some common objects once
Date: Tue, 11 Mar 2025 09:57:40 +0100
Message-ID: <20250311085743.21724-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250308230917.18907-4-philmd@linaro.org>
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



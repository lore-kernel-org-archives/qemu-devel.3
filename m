Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286DCC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvRL-00063C-1h; Tue, 11 Mar 2025 04:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRJ-00062j-5b
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRD-0001JO-55
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so523775e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683488; x=1742288288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RO6o24MdYTf0l9VfM6m/i5E+H6tG45gEAmSPdGl9VsM=;
 b=DvqPVPgCwTJ13qtCOJZDoGycaWGgV2im3HUbYCfOaeDg4PtsO6q0rKAbPxevrvH10I
 lMQdYDY/zpWLXHxlxCvCkZ+GnkJtDfcuOQAcT2IE4A+mHuaLrNQ5OpUUOTFjP8mO4RMO
 hMxls/Vh5pLu08W8rxZYMOFVOfL7J7PcQ2YZL+fc4MbTElvnaHnt0y8SlgoOAHX63/WO
 row77ykGG+IUMNYjsQeNMvsmYnwah7nmZeI0ZeunaGtM/ic2USBX2WJF+Ao8+zvx8b7r
 AkuuzAJvLkfnDQmUq7jl37PmT0A+2D/bD0zJ1oxMvdVoBn2FCZBAfoVWuxsQTofcpAcx
 juHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683488; x=1742288288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RO6o24MdYTf0l9VfM6m/i5E+H6tG45gEAmSPdGl9VsM=;
 b=hBQ0BXakJ7DGcUOT74DXlWJT8StEKUamGQuNsj16FaUE56WvQEqPUWPz4CxbMD2LSl
 EhZdKx6Uk+stZNTs8cf2aT9ptC6Jz/4lSbQDkjnSJzWnMrSTunu1UC0zYDKqVASxvCi8
 mMKR6ptv9W2yatzW+vqUJyAXEC9vMq0DUekgpB92Y9my+4xd0+0bZs/NReypKmCrIMe4
 XoyYL/JVhuQ5xejUAClhpB6xI1nIapiPWq0BOiGbfd4oFyo/7jxuOjWep+KgWqQUkY62
 2BkAJ1+OGmBgclJYOQHu0GhH8Py/EWXEWh+C27L+msnn0VElLpaQH8PrIptt92yeNBbj
 Goyg==
X-Gm-Message-State: AOJu0YyEJGFOtEEgJXjfgAnp0C4ClOPXXcTC3Y0d+v2oqcGWEMDPddw4
 UbrQ8MauwPGr8yY7kCkkOfYNRZiMUd4KNLhU42Q30zPxCI56ILRFHiNVxpcxbqW6i345EMH1iJ9
 hQ3M=
X-Gm-Gg: ASbGnctL2B00KFEOKIXIxrWTOTofkur7LIHqawMeJW6mCQLx2tbqNEZD81xKUw+gLfJ
 1/SJEfFnBelWAX48T5IkViy6Ok3e1WEJgXfrTc/Zw5E8eHCaKtyQYTaWkQEJ3ZsD4yRJR+r2Otw
 +9c0AsLWJdT+7A4Duql2dBTct5MOrEy2y26aVoiwoCjf/KGD0biwcCbqkiePYIAFWMtDmjSreR+
 IaC1cfBtQV1A01VbzbvnyfZB8um95prvDzmyR20Mi+kapmDDiPkjd9/G4ffDFaL+wp0Sf6tJ4D5
 dKvz+y6069yf1c1CYKwKXzDOCpb7tph6jXd8Z9JTWhPlObTcrXLxKh8Md3DSeJ81fRXiA2FHkun
 WGTrn6UHxUECBVnWHSeg=
X-Google-Smtp-Source: AGHT+IHpZNtoo8t9N/bmVEmZsIKA82WhMWzx7hQxhBpoE0NJV+NOQTRIK11Mq+x/kiLk2lAUozBPuQ==
X-Received: by 2002:a05:6000:144d:b0:391:139f:61af with SMTP id
 ffacd0b85a97d-39132d8c768mr11324550f8f.32.1741683488031; 
 Tue, 11 Mar 2025 01:58:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f44sm17278164f8f.76.2025.03.11.01.58.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:58:07 -0700 (PDT)
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
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-10.0 v3 4/8] hw/vfio/common: Get target page size using
 runtime helpers
Date: Tue, 11 Mar 2025 09:57:39 +0100
Message-ID: <20250311085743.21724-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Prefer runtime helpers to get target page size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250305153929.43687-3-philmd@linaro.org>
---
 hw/vfio/common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b1596b6bf64..1a0d9290f88 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -30,6 +30,7 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
+#include "exec/target_page.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -393,13 +394,14 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
                                                MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
+    int target_page_size = qemu_target_page_size();
     VFIORamDiscardListener *vrdl;
 
     /* Ignore some corner cases not relevant in practice. */
-    g_assert(QEMU_IS_ALIGNED(section->offset_within_region, TARGET_PAGE_SIZE));
+    g_assert(QEMU_IS_ALIGNED(section->offset_within_region, target_page_size));
     g_assert(QEMU_IS_ALIGNED(section->offset_within_address_space,
-                             TARGET_PAGE_SIZE));
-    g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
+                             target_page_size));
+    g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), target_page_size));
 
     vrdl = g_new0(VFIORamDiscardListener, 1);
     vrdl->bcontainer = bcontainer;
-- 
2.47.1



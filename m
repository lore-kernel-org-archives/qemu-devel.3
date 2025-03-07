Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE382C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3g-00042v-2W; Fri, 07 Mar 2025 13:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3Y-0003pE-Jg
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3Q-0002BX-Ga
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1881144f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370647; x=1741975447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEveCyP6FEOPe2OjJI8iFRo9o4gmTgwH3d2sFhPvDtA=;
 b=lcGun/IUTR6VQs6MSI/befSpFGMUccPGOYgfkcp3BdMkkfAZdibD929fPJghSjNpqi
 xXzKjOUBEsCXa4nI8m6Kjz45zCYttEU3KavNhYVGVOhFoqMZj8ffDnzusShkT8YkWcmI
 yRVEpQVgjqB2jR5UlnAfY7Q5UfAFFQqL1FSXB2PB/rKIbrJqQ5r88SKh9ft8DD4LmPNZ
 uuJsOWefHcamkLdzqaMv9/gFdo0Xa7kjibXGRHw268IypX6M8ksDFHzH7WRIpNC8x7Xc
 MxcbaLGVNlMgIiGBR3r9JMrnD/Df4utMoc6Oh3Hpoz7R42sygmWR2Lt1l8lNP/4jjiZJ
 phsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370647; x=1741975447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEveCyP6FEOPe2OjJI8iFRo9o4gmTgwH3d2sFhPvDtA=;
 b=oX1Azg8OZ6W788wcQLMCJU/tSNlz7EJSj/bBPyR1VSD9qGRBEbIcTBZolcL3KE4XBu
 RVKUc8tsRdBr/ZtHPS0AGkm/73Gym9KXEhXFDtEeQO6GWJBlRh0DyYsOktko0O1QKemn
 +3/OKvOzUt+NWDs4ywBWK3ZTbNx5KjNtws5jCbVmIsBuJNMYbcD5nkfIOHYVhwKEsFI7
 LeimJESqKOn45Q7CuJKv/XKWa0C1jyFpMsJQD2jkfa4hZRwRzge2vitn5kiEDrXobdWs
 qnqzfxVEjoSbbIzlPRFiFg4kotIZMvy6i+xnz/ZYgUpV3zJiUupTFtfFtiyV76PZfsTD
 OQcw==
X-Gm-Message-State: AOJu0Yx1dowq6krnk4rP14aDn0ZlFtT+/odMANaKubtYWipvdZNXJ3XV
 nu6RzF04qW7Hs7Lx+FxlcQDPK2zKyv5b418JzFg73tTwiE+5odR0Z+xb3MgWW6zHDHeJvyWl+f6
 SbjM=
X-Gm-Gg: ASbGncsEIK/NWf4Jrv+09OtjM6R8w+IKNz8KJGq1859PEy+7RQ52bdbgucAFoZyZYPh
 wv0BWWS1QGEIcypafryr6297ZBK5b/LVl4wgAMibRGy8yw9lPnxJrKt4kW6SbWRvmaSJnJy+jpZ
 6kvqB+UZ7BbPaZc7oNCs7wd93eJr3e4s0utwqWZ+JoiEhpl23+9OJGxUWnt5fbC12z+6+WaSvKS
 y79qKwCbO0ORVw9P1ezMRcStvAVAd6BhPWtVYfMUk92Abz8HACou7OeDLVTQ7gYxAzVgMn3piyG
 bpZUwsUvLbTdq1VCiBDlfcCIQ6qPJcCZ1IxmPWDe2HzKnnW/iMoIjNew8zbAw3OjVxLvAzCaVDV
 mdMSJNYpiDRByyt1Pia4=
X-Google-Smtp-Source: AGHT+IFP46e+d4zSpLLCoseVXCZJECsAXVPehPMPfpJJ5BpgkkXKnlM7odaYTNUUfr+LJlq6dGhKCQ==
X-Received: by 2002:a5d:64cd:0:b0:391:2995:5ef2 with SMTP id
 ffacd0b85a97d-39132dace0fmr2665116f8f.37.1741370647439; 
 Fri, 07 Mar 2025 10:04:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d81csm6127965f8f.58.2025.03.07.10.04.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 05/14] hw/vfio: Compile iommufd.c once
Date: Fri,  7 Mar 2025 19:03:28 +0100
Message-ID: <20250307180337.14811-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Removing unused "exec/ram_addr.h" header allow to compile
iommufd.c once for all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 2972c6ff8de..fea6dbe88cd 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9A8CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GQP-0000ON-IJ; Mon, 29 Sep 2025 12:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQL-0000O5-Kv
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQH-0004F7-Na
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso3825551f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759162099; x=1759766899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTK51mAJt6thgDZtg+lOa2Lrc6S+rDAyrgkNL3oUMcQ=;
 b=Sz6iMLJt6rZ7fHAjmsvx2sc3fNrD8XfvoWYBvODqSpA33nzon1YzNkxLHel0yZnOiD
 LOCgqvTxmDTVhuuVLfOdfRZ3sGxRIiWsRniXqABmRplqQd8A90Ql47kKOm/r/j+ZuXGY
 BRy4Qo4NPYlIZC1jwD65TUh3epbZUGaGKgdJE/O77YdWJKEhNhc9EAMWL4xNTi/WYgES
 8u+etym0sCA4RNnFCi7dgc9oxTfRXjOTyDiF2ks1ENrtgEGbi4cSai4x2HjFWy1Jhmz4
 D9ONJgmqkRt6G30hWyz+NSF8gss9kIZY8G04vTB81DTaQRUQLxC5uMGxX2nYFyUnW/KG
 jxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162099; x=1759766899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTK51mAJt6thgDZtg+lOa2Lrc6S+rDAyrgkNL3oUMcQ=;
 b=CXGUV+vA1MPINhU6C0DxxqEk0kYBxAQZe2uReBlPETMZ1Z3fUbQT2nQbwA67AZRLs5
 p3AckzRTOKcFaoNcpYU6hWsZVQ+KknS0Ijp1Z1RN/LClUMzS6fHKB6j9cPYnzy1SdCbp
 SaCIIqxfQUHTKCWLpptlHOxj50Z3WRAvG6KeoEsrdUlvLvvifaRUuq0TxUAehMRZ/Akz
 qZsPTeMH1/ryjEl314oyZc8+xSgVL/3w2tBFSv2wEormIfx0eNYM1mRVdec7sanDIzub
 H6EUVLWJIo8fbhbBe0Ya0x1+SFa1BkV4jqbkUkfTHB/Uqeuu8xQRHNm1N8Dj12uHur1A
 DmZw==
X-Gm-Message-State: AOJu0YynOFizp563almXicqM+U1jeAaJZySRd1UIMGC759ihQOuqVqZN
 84QTAAFN6S4Xzvn8Op/HnETJAsRP/M2TTR7fZXAlGHDi61COr9W7eOhZZlyhdjRg7DHBSIyF/Ud
 Warhf0X2dSw==
X-Gm-Gg: ASbGncsnpXz/SpGB5qCdGeWqghvOqMXWucDn+5JQCs/0KTM8Nlh6xWzuYXTWuabTu9N
 6/9z+7w/75VYgdkwVQ/rjfwaqth30Rt9bftf72hSinA+FxKcHRkrb8vXe5xV4ZAiYKpAm5rnakk
 m9dykxv7joztXFrI4x0WU66mkUGjriWY4y/jIAxnL8UQkx/BCj9FUxufMuqlJ7yvh2uuDoPSuXi
 HnOSUv6/Bb2EOvkB9hY0FESUk42ZvmGMSRn74AXmYQ8Qtvlp8gXsVVVFd9x6+MaLcgNt+aSVn8l
 70LSrQNyDKzYGzQNxwLNC3nMIVMR/FTIpBHnxwyZw9WYEAEVknHdg9ROT89WErS7Zhzo1lzxLwL
 KV+YPNQyg2twOf5liw4wmRhTYocuVmh9O9EAV5xFrEuoLxBKndx87SIjgCDwy4NeaYEtbosK3Fw
 IKA/cxwbk=
X-Google-Smtp-Source: AGHT+IEkmStbUrtOfCos80R7siZd+EYFL7YggpsBEc5lDsbAG7ajdiTlyKlnjqh4Bj2WDcWCKwM6wQ==
X-Received: by 2002:a05:6000:3102:b0:3e0:152a:87b2 with SMTP id
 ffacd0b85a97d-40e429c9cdfmr16183196f8f.13.1759162099023; 
 Mon, 29 Sep 2025 09:08:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921bcfsm20048866f8f.43.2025.09.29.09.08.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 09:08:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/vfio: Avoid ram_addr_t in
 vfio_container_query_dirty_bitmap()
Date: Mon, 29 Sep 2025 18:08:06 +0200
Message-ID: <20250929160807.73626-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929160807.73626-1-philmd@linaro.org>
References: <20250929160807.73626-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The 'ram_addr_t' type is described as:

  a QEMU internal address space that maps guest RAM physical
  addresses into an intermediate address space that can map
  to host virtual address spaces.

vfio_container_query_dirty_bitmap() doesn't expect such QEMU
intermediate address, but a guest physical addresses. Use the
appropriate 'hwaddr' type, rename as @translated_addr for
clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/vfio/vfio-container.h |  3 ++-
 hw/vfio/container.c              | 11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index b8fb2b8b5d7..093c360f0ee 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -98,7 +98,8 @@ bool vfio_container_dirty_tracking_is_started(
 bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainer *bcontainer);
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
-    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
+                                      uint64_t iova, uint64_t size,
+                                      hwaddr translated_addr, Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 250b20f4245..9d694393714 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -246,7 +246,7 @@ static int vfio_container_devices_query_dirty_bitmap(
 
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      ram_addr_t ram_addr, Error **errp)
+                                      hwaddr translated_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -255,7 +255,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
     int ret;
 
     if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
-        cpu_physical_memory_set_dirty_range(ram_addr, size,
+        cpu_physical_memory_set_dirty_range(translated_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
         return 0;
@@ -280,11 +280,12 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
         goto out;
     }
 
-    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
+                                                         translated_addr,
                                                          vbmap.pages);
 
-    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
-                                            dirty_pages);
+    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
+                                            translated_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
-- 
2.51.0



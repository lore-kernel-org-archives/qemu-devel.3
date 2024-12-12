Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A417AE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlZH-000054-Fh; Thu, 12 Dec 2024 10:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLlZE-0008WV-Qc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLlZA-0000V6-7h
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734019046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9QvOqxReBwv+PTzlHlKxK05m2nmibyZqeeKJborKCys=;
 b=RKqJtKDJrq/Ce4alpSaFdiPE+oON3LYMzYX6K/v59VbqwntA7tHDMC/+uJJ/w56RAzm5Q4
 JHKR5zcBNYhFK/ba0mtwrzWHgnIUgAHkhOD4vesytlAYP16wQ7BKt6ZB0Hd+Hvz6K84WzQ
 CRYk4h2Ogvc+VCJSkhWpRj7LELqTCo0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-kIMRxdjwP5WfARZ9LuxrAw-1; Thu, 12 Dec 2024 10:57:25 -0500
X-MC-Unique: kIMRxdjwP5WfARZ9LuxrAw-1
X-Mimecast-MFC-AGG-ID: kIMRxdjwP5WfARZ9LuxrAw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so4838375e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734019042; x=1734623842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QvOqxReBwv+PTzlHlKxK05m2nmibyZqeeKJborKCys=;
 b=L4qThPCxh6y4XME+4zCWJpGR8bncR9R1eV5APh8HCvttXdPkfvwr/olWYSELxLZ2q0
 AjVyOtK4M3BT9uYFg4IsTNb7+Rodr+WAY2FkrSLbXeBJPl/wrQma4/2MoudDhTakOaKR
 Ze6mK/rRTWhABjTPYXNKd3ngXm/33tL/AdumCP+/Q9Awsinluxy59S6Ee3ZtaZ0dTUSK
 JrN6t3eTheyOnKYmy2mpfxE8AGEFk62oU1drzMiKniNjWai4J8lHhLjvRyWk1AmHQ+Ux
 aK5+EW/iLsgrykIyeDiqEDFbj7EJIpOsbCUyBiy1WikztdNlTxhkOXouDY1KaWRXIItL
 XpdQ==
X-Gm-Message-State: AOJu0YxGI2KdOqZB9j7grUHUGwYJ44Tc5/LLbQyWCWpSE1+UUTLwB7cq
 KxmivLfhY4o13+8JaJWnUGcpjr8pg67+owc1va02GfBJeDF1Z56wbpKhyY6TjvUMaI81aVad0i4
 3K0BC254lB2kUtfxcSLIiJcoRJXvC2t/A5BvsCTv8moZiNC689uVQ+cc1y4xYYKAsNJZtAR1S6J
 RotWv4UXKj0ht5iOI87CeOnnQVOVYxUUm3cv/C
X-Gm-Gg: ASbGncuZ+6OFUVHLrKbiruynPcUv/CxxyJ/bQKYh5hO011VyHrfb4opW9s7GAbLm4mG
 3Wn2mLCCHfJzapJpi0ZU+PUEfSNZQ2YzEHBgTKw1g+jBqyajB9HGjCVSFtYXJMM3t1DhvIarnJW
 8/zQeo3HcNrMyf0W8f243mwOGbqyy58J21E9NgJ2yIQKEGuDua8w1OLiy73i36sQCwLx17blv4b
 wkdqjVmi0+An1XDvNauRVQeAIrwAsUhb641wzTAQwCk6oXsOXmJmiUOhfrJ
X-Received: by 2002:a05:6000:1f8b:b0:382:4a4e:25bb with SMTP id
 ffacd0b85a97d-3864ce93818mr6062749f8f.46.1734019042114; 
 Thu, 12 Dec 2024 07:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFa7CcDNOqD8m78Hkix4p/fgEdMLSSxDHs05LT5P9Ebbsk367mQ80opnam3nAa+3sizRy8eg==
X-Received: by 2002:a05:6000:1f8b:b0:382:4a4e:25bb with SMTP id
 ffacd0b85a97d-3864ce93818mr6062725f8f.46.1734019041674; 
 Thu, 12 Dec 2024 07:57:21 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f976sm4373543f8f.14.2024.12.12.07.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 07:57:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH] kvm: consistently return 0/-errno from kvm_convert_memory
Date: Thu, 12 Dec 2024 16:57:19 +0100
Message-ID: <20241212155719.524637-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In case of incorrect parameters, kvm_convert_memory() was returning
-1 instead of -EINVAL.  The guest won't notice because it will move
anyway to RUN_STATE_INTERNAL_ERROR, but fix this for consistency and
clarity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4c5cef766ad..81821af7d7a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2998,17 +2998,17 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     ram_addr_t offset;
     MemoryRegion *mr;
     RAMBlock *rb;
-    int ret = -1;
+    int ret = -EINVAL;
 
     trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
 
     if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
         !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
-        return -1;
+        return ret;
     }
 
     if (!size) {
-        return -1;
+        return ret;
     }
 
     section = memory_region_find(get_system_memory(), start, size);
@@ -3026,7 +3026,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         if (!to_private) {
             return 0;
         }
-        return -1;
+        return ret;
     }
 
     if (!memory_region_has_guest_memfd(mr)) {
-- 
2.47.1



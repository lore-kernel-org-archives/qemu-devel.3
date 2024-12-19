Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE397E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByl-0006pi-N2; Thu, 19 Dec 2024 03:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByi-0006Zy-5S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByc-0005FR-9U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YoHuc/NNuJdIOvWlSl/Djx2vhx2e2wqt0iw58ph2W7s=;
 b=E/IGkmaRTBBsRyDTj9LE3MkKXn1fyW+WGA1h70PnLyl6Idf37uQQV1QEzXDdY+yhnIh9LR
 iZh3t3ldD900iJzq/HqK51jgv9HSUzkh+oh2BO1NAHB0D66PAcjX3O5IgB/LU+sEBsnSQ+
 iE2Sq6e3iyCPBQHQZbEVdIE0oXDVgyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-u4b6v_otMjGhFw3IxKOWzw-1; Thu, 19 Dec 2024 03:33:44 -0500
X-MC-Unique: u4b6v_otMjGhFw3IxKOWzw-1
X-Mimecast-MFC-AGG-ID: u4b6v_otMjGhFw3IxKOWzw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so2899015e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597222; x=1735202022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoHuc/NNuJdIOvWlSl/Djx2vhx2e2wqt0iw58ph2W7s=;
 b=SDu8+7vnI5faHV5VDa8qR2ior2oV59PmkaVvjnXIyGayeghk3HzXcT5ehXm6tVpOuT
 sFo0pLZuAga5eccGxzS5DUfRJ1Nu1zyuxScKNp2rFl1J3ffIFcfO4qYNre2lOqmWUGsz
 mzucNHr2q/Da12dA9V+71JL11NU1WDOuBwoq7ibSge5EupS1TO5Nx/6kFj/0ztUp8SLb
 cKYw3KGrNtoSGDe8AgegwAM3tO7dAdeF1cw1J0Bxhz1+OZ5M2wbqjqXEWdxXK2FFkO8w
 bEtqIhOpdG1cWMbGGBGP+rlGOxddBb3+XeXy8b8xz2plczJseG0IdCrzPNJcSOQSxctp
 69eQ==
X-Gm-Message-State: AOJu0YymuL4QolkUYpgIuQyRQbgfheeOwri5gP6j87/7zGPrsfI4HIlX
 2uopFxOMdXeb1Ljf+TPkQoW2RIkYgG9Dh7EkXm9qVKX5hFzk7U29Pp6e6G8YCZPb07DGmcqAdbQ
 whZTRtchKoTWNAVEMCbe3bVcIB5YX+8jHRr3PUBqqvT/HaMwJAl2d9NY1njXk9oROLDP+DIQKTE
 XqxQ/icKw1mvbr7Kgmi/JAsxozPubL92cYIVHs
X-Gm-Gg: ASbGncvs5lrOEzWdMF9jyoo671qoCIk5HE89PxreTsPkjSSnvKVDOJ+GTFXoJv3Vg0o
 hhmRxjWeztCq6v/rQN0DQehb4LWPw+WlsEdUeEHPVpEX922iD6psWzQUZE6i3BBWangSuCwpJ7m
 aBGsl9vgTtA5y+wu0FpwkwBeSRM2sVNmr1IZd0o4VkxFKuqZEYdDd+k+Zs7HHdZhnmjiNVbkXnB
 wGbvhA3KqI5xvbG9FYrwSbVQT20gR+wGstU9c7F/4dbJeSOHpSgUGf/VgcK
X-Received: by 2002:adf:e194:0:b0:385:e1e5:fff3 with SMTP id
 ffacd0b85a97d-388e4d9760bmr5351046f8f.57.1734597222181; 
 Thu, 19 Dec 2024 00:33:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7Ud9Haahs+4ElvTqlfVsQCbil0VZ4GGmHR3RxWETKYN2EYD3XOt3DTAnfNmxhgVN4k3ItRg==
X-Received: by 2002:adf:e194:0:b0:385:e1e5:fff3 with SMTP id
 ffacd0b85a97d-388e4d9760bmr5351012f8f.57.1734597221682; 
 Thu, 19 Dec 2024 00:33:41 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b013a1sm46067165e9.11.2024.12.19.00.33.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] kvm: consistently return 0/-errno from kvm_convert_memory
Date: Thu, 19 Dec 2024 09:32:20 +0100
Message-ID: <20241219083228.363430-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 801cff16a5a..77d811ca70c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2999,17 +2999,17 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     MemoryRegion *mr;
     RAMBlock *rb;
     void *addr;
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
@@ -3027,7 +3027,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         if (!to_private) {
             return 0;
         }
-        return -1;
+        return ret;
     }
 
     if (!memory_region_has_guest_memfd(mr)) {
-- 
2.47.1



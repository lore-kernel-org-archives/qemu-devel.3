Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F326EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzg-0003ri-Db; Tue, 30 Dec 2025 16:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagze-0003g7-KH
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzc-0002pj-Rs
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so8466805e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129059; x=1767733859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/w1WLk/TO8IbZ7uavQKiXzIzSgDDg0efwkjmD+qvdIk=;
 b=mQIoINevI4IiSLhAgw69Q9UeGWuUaa313gxS/4i3oXGMlf1mAADQbRP2/MkOgL2r64
 jDVsAPssxu7q4FC9JHe2j3fqcQWQKhoQxBKbj9SrOZpOs0s8LDq4SP5E81AYwqqEvn6G
 5l7BfIzrPJA4NR0ETO6bS93iMvE/joDAguhcTeji+imYlEbSq7/1CIT9ih+yTAkrSgsh
 FnLoa7JhjKGM5ltO6LNDeQ468TTdIAmEdqOIU62Q3zV2Bsi11xWMDBmpMbp14oF2qmYN
 ZS8MZhcM3fJ8Nuohz1J8jn+AbmszmGXY8M/V0rdGnDZ+1t/P42litpA85mXFwtI/kODj
 Jdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129059; x=1767733859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/w1WLk/TO8IbZ7uavQKiXzIzSgDDg0efwkjmD+qvdIk=;
 b=ukz4Rg117db4luHy+S0q4yw7xXUGt4wOpXGKKKfqPe88e/5QeBoGrirZgIb17N8hy9
 Am2jJvwtLQYDsduISO30dIORU3GRhQfWXzz6j4cbyfXzgfnI/kRBlrK0LaoGSBj+fkt9
 yFEjQ6SFhwvZo1ja2+ZgiDm5HVMtWCYB7ynfbFWsqFYrVxuYeOa5o2xKsVbb34s3AXgG
 zbzMFkCAC3bOv06maL8wxkNHnInm7oofOKjgN6h3j9Rk7H4mIECD9drT4UTv2JBlCFTK
 w7jzG44iFnbPwOtyvwR0nvFWfT+s1F4K99R2NDMjhI/dKNG7bGCoUK6T01EP3QUyIyZY
 eLGQ==
X-Gm-Message-State: AOJu0YzIB36VZRb2Anof5WEnK/INTZK1kFkBjr0Dkqg2SwLQPSf3ofX0
 j+o/QHfhD31PW7HBS3Wp1MIDcqo/DY1Qp0GRBsrbikOIy5e8h/Sc7XQrzdiV1ZfjfJ35T/6ffOW
 Guy3CXF8=
X-Gm-Gg: AY/fxX7DE9jSsSeGCxzB0Q1MfOQe8PwlqP+2SwRSXHDsVloZnXSZuzq3zEq5Rs4PRAe
 advdukEMsTYoVBJgdjXKyntDJp9jqDISWaN7MnjTV/16mrJjjNIOn+u5g+ocqlRmQGpYTFqQJxz
 1VADyO3PwnW2eLtIE+8QQmiyoEzHut4vt/8nHxVqCINLcceODuUFLO+Crj4cYztNz45dF+d9vf1
 vnrL7mEGW1WwGe1h9eVm9SyOgQ1DNGCl2eeYqbemrVvgneVw/a+U6QX/K//wgc99TC3Ta8OVeEs
 cZQ12xo8XRgi9naUDIJZ7WNAAho3OVOA4n1CyuSHhuiTSgHkUWkyNDYEG1KIDl8/5G6c9c2H14F
 QZZqsDDUodwtqzQaEwL6Ylq3y3MXyDV23JY/UAthB2OLbrCIu0pTVmD9QFZcQD+Uc618ZMnISv2
 HXm1kQyI64wZ9ip0syqGewPwv+qnjWcSAMdIM7IsaDRCf//I4pKGd7B48+AnrvayExXu8REsQ=
X-Google-Smtp-Source: AGHT+IGC9wJHFl2W1auGd3zJ2t15xdismIqf33uL5dJkqP6o4aZuZ3GJ2tje3t5oLuisI+L193EwNw==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr502264695e9.17.1767129058691; 
 Tue, 30 Dec 2025 13:10:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193522cdsm586399795e9.4.2025.12.30.13.10.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/34] hw/virtio: Reduce virtio_lduw/stw_phys_cached() scope
Date: Tue, 30 Dec 2025 22:07:49 +0100
Message-ID: <20251230210757.13803-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

virtio_lduw_phys_cached() and virtio_stw_phys_cached() are
only used within hw/virtio/virtio.c: reduce their scope by
moving their definitions there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-9-philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 21 ---------------------
 hw/virtio/virtio.c                | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index c866769cad8..5b5fff5295e 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -102,27 +102,6 @@ static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
 #endif
 }
 
-static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
-                                               MemoryRegionCache *cache,
-                                               hwaddr pa)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        return lduw_be_phys_cached(cache, pa);
-    }
-    return lduw_le_phys_cached(cache, pa);
-}
-
-static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
-                                          MemoryRegionCache *cache,
-                                          hwaddr pa, uint16_t value)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        stw_be_phys_cached(cache, pa, value);
-    } else {
-        stw_le_phys_cached(cache, pa, value);
-    }
-}
-
 static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 {
     *s = virtio_tswap16(vdev, *s);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5b64eb4d67f..3dc9423eae9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -216,6 +216,27 @@ static void virtio_check_indirect_feature(VirtIODevice *vdev)
     }
 }
 
+static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
+                                               MemoryRegionCache *cache,
+                                               hwaddr pa)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        return lduw_be_phys_cached(cache, pa);
+    }
+    return lduw_le_phys_cached(cache, pa);
+}
+
+static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
+                                          MemoryRegionCache *cache,
+                                          hwaddr pa, uint16_t value)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        stw_be_phys_cached(cache, pa, value);
+    } else {
+        stw_le_phys_cached(cache, pa, value);
+    }
+}
+
 /* Called within call_rcu().  */
 static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
 {
-- 
2.52.0



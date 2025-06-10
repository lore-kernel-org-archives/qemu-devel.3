Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B27BC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOybE-00013V-N4; Tue, 10 Jun 2025 09:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYJ-0007b8-6C
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYG-0002hG-L3
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so1971432f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560282; x=1750165082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zK8JfL+K6DY+H6D8BIWrVhPNwjGTBASRCCeC9mTbJFE=;
 b=P1axd9lTd0vsAdExoflX61GxsfOaJ2C6Vp1JFEWrwQxYRkyFnvTaRT5p9fXON2helA
 gYcHuz92l+UFNXQmLLQQSDa2PcoBFQjdwro9acI6GlS2oU/Q2K7kjDO/U2MlCG3Z0BRk
 s2CbAdyKzWGZ5/ucj23gfb8gSTFy74U5vYvFVcbIgKz2DphrLf6OVzkqDa7LyPqBVw3F
 ZX43E0v+jcaHs5CyxQskKvAHAru/h+c2o2vvPvtjeB7km3PH8pE3/5hswSHhS8LYcorb
 VLO4aVLdan4GpPN8PvaBJ9WKrRv+EEUhO4QUyanyzxZDjYfht1VC4KNVT1+dNcex8ixh
 sW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560282; x=1750165082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zK8JfL+K6DY+H6D8BIWrVhPNwjGTBASRCCeC9mTbJFE=;
 b=He250CQr4XgqHPCYpPjxiYlX5scekS7pERMoLKpcWJjwUuhYbS45AccYgyDZi7Gd6m
 duiaL+4G1wPvUFDdujwC+tJWZOxQr0tHcSxI2oKwesP0gWC6EA8A6DJldifzatyzZYM+
 rLORM/vLF91gtI3smRSheFEQq04ISaQB4okdTTUsyj1wKnqfWKiTQxr8f7x0b2jQQDo4
 EC9eMxaqz2aHN3zwjmrvXX2jLBC2ajPP6CzBbo6QUqksS/I97awAr/Blmq9e87xwC66w
 fsGsTztDuz+yJt3onk/2nxsj/d7jlnCVH547ckux6FWdU3aHFjcmAtK/NBNixCT4HN23
 2BTg==
X-Gm-Message-State: AOJu0YzK438RxBkSjEfbuxZBvta5y8xzqFPQj4D3qicHIzF+D94mccJB
 foxCvhqbPQqib2Ph8WmcWp9bG+nC+ks0KvbFbtbrxi4Q1Pc9Ff7EaTCcEHn5zuQXHAOWesld84A
 QwU492p0=
X-Gm-Gg: ASbGncvgYc+R3jy4K/KdPVqum/Rv0PqNeUuxUZJJn3o85KnJTWlCcidEMEDoRg5HHBY
 hM+USI8YmxW6kDw8mciavr3L50A70uOS55E6Zd/ptgk0UG6dKj52HUa1WCqLOP80c9CKRCWJog/
 2flCXUXWTBEQRrg11JM4OuNsM6DejGSoXNSpe4bNvO/LiTkoEZp1Ek5UEAKbprBP3SENQtvSLKF
 WZJN8JFZW0nTrmWC3mELviFcVxbLxEQ1CSxTIvrFQgBBhpI/J3KB5GB178Gd4RKXfq9hEzGzFh1
 cSAxedn4ItAPXUVwVrSVPSJ0A9P6czzTfvI26/vtCQ51TpTQlB38GDY/fXlzaumbWmzRNb7Qo8M
 KLCZirHuCxlsNP1PhZdUQ8Gcvx/Y/YTE+pRnXDJaMlg==
X-Google-Smtp-Source: AGHT+IFSf5rP+bGvwTtachKHxuNTrYtyMkIGmShlefIEdlN+4E4aZs9uSph6KVFFa1FVFLq7dsovtQ==
X-Received: by 2002:a05:6000:1a8d:b0:3a4:f7ae:77ca with SMTP id
 ffacd0b85a97d-3a5319b6a1cmr14665298f8f.3.1749560282240; 
 Tue, 10 Jun 2025 05:58:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532435f95sm7701475f8f.60.2025.06.10.05.58.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:58:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/24] hw/virtio/virtio-pmem: Fix definition of VirtIOPMEMClass
Date: Tue, 10 Jun 2025 14:56:28 +0200
Message-ID: <20250610125633.24411-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

VirtIOPMEMClass's parent is VirtioDeviceClass rather than VirtIODevice.
This isn't catastrophic only because sizeof(VirtIODevice) >
sizeof(VirtioDeviceClass).

Fixes: 5f503cd9f388 ("virtio-pmem: add virtio device")
Closes: https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg00586.html
Reported-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-ID: <20250606092406.229833-3-zhenzhong.duan@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index fc4fd1f7fe8..9cce600d0b2 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -36,7 +36,7 @@ struct VirtIOPMEM {
 
 struct VirtIOPMEMClass {
     /* private */
-    VirtIODevice parent;
+    VirtioDeviceClass parent_class;
 
     /* public */
     void (*fill_device_info)(const VirtIOPMEM *pmem, VirtioPMEMDeviceInfo *vi);
-- 
2.49.0



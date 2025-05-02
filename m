Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C41C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyD1-0000jW-F2; Fri, 02 May 2025 17:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyD0-0000ix-1Q
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyCy-0003WZ-9Z
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso3849033a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746222370; x=1746827170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWWrKwoCLn5b4Gd/jxCzJvCASZPS/cC4XOoTz1WNgkY=;
 b=hHYbzy5/hnO7+9EoFbqbZr/nYxf/P4txTzpr7zwmr3T5u+xLa9Mr/VaDP4TtsTzvLD
 c66zrOfASOG9GrfL4EKX12iZcWn4w/qfdYqxWxB9kI5cfUyc4acgvahZK0vTzuMGK1Gh
 neuhbZyP3r57z92B880u+p3mHBruZongJKlrYOr2ezXvrPp6Umq/JezWl1nm1rBLARI8
 fr/IBYxp8bP4jS6BayhWeWz9Zgj2q89mKqRHNauAhdsWoAiHOo/0XSEtHHnd7ra+PnWM
 NGrfM36VF/ffYOquuWSKJy2eJVaEQ8Y1yYjiTXjSBR8yIJpPWAspSX2ByFPD41oLHhQM
 4AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222370; x=1746827170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWWrKwoCLn5b4Gd/jxCzJvCASZPS/cC4XOoTz1WNgkY=;
 b=d12EDH1KyhXMpN8GGPU8KcJYkajTCHAeAD7tTSYPJnhYMwCKlqLMAhm/FQLxIgW/GH
 Vb2gMGJvVT7E9yxbxa9ZiEUyU1V/UnJJ9EN5Yi8+yn+nMSg2NrnD8dNat2Fx+LsLbtEN
 moTA7B8QE/83QObX7mT0OOJDAvhaYKUg63JBj8Q/f4RTg7fu3cK/6knvZO9eZhNhv/rZ
 26vW0UslLFPaCwMNuPuMcZidh1a8PJe09r/9P2NmSn7nOsTPhDzsWZHsEShBtLNIYv4Q
 myTeiM4ws45DWK/Sz+9B6F/GXZGj+IV+CujWxajlx+/UsrMkyRMn1UMhLXzYfjOJxFX7
 OlQQ==
X-Gm-Message-State: AOJu0Yxgz3SWIajlzp9UBfeJ1WCRqgRdZ+uv422mBIS35exeMqDWuD20
 tVK+/aXBJvreYabV/WzJ/2JUp22tYuVVLGUJCdAwsH1OHb58sRor7IZMjDSyV2JU4HLPpfeT48V
 T
X-Gm-Gg: ASbGnctjs19AULSLy9SlUUF9+5aHEuQRDPdXSs/eQg34Yn9P4Um31XxUmUmi3QoiVS5
 pG/QIOP3kQuXm4e830vG6xjgRdQQ0BxPBpmii2SLodYmSlwt57Ah5XgDVJlF6WJZBEnuJ3LCgXf
 mwxqWHESIpj2D4XlWfQqvbq3vjNzfyI42qQZBKtNtF7xVrFEunujfYNufOSboPfh8/S8H3kMYrj
 XFPcs/O+TKc0zyszoW/aGobZACfDCkY07osmXXO3uB85yLMCax8KXf6VRyzyAQP/+SkcV1GHhUx
 bQ7PuqnPwRLHNBb7wbrjCpPv85E3pxOllN+UT8cRcxJg+PH5dL27GUO76lcl0JRE2Zr5NwQ5QMF
 47yh6d6jJi8m1zuA=
X-Google-Smtp-Source: AGHT+IFUGvg5Z/aAly33hZUUCPjjlF9COtm91m1f5WHLWcGh8DYQaD5NMOCHAvvZRLT3gnurS1qW1A==
X-Received: by 2002:a05:6402:2710:b0:5f8:36b2:dc1a with SMTP id
 4fb4d7f45d1cf-5fa78062dccmr3729539a12.16.1746222370036; 
 Fri, 02 May 2025 14:46:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77c38618sm1730083a12.81.2025.05.02.14.46.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 14:46:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 3/5] hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT
 to runtime
Date: Fri,  2 May 2025 23:45:49 +0200
Message-ID: <20250502214551.80401-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502214551.80401-1-philmd@linaro.org>
References: <20250502214551.80401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

Use target_system_arch() to check at runtime which target
architecture is being run.
Note, since TARGET_ARM is defined for TARGET_AARCH64, we
check for both ARM & AARCH64 enum values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a3d1a676e71..02c47730ae8 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -170,13 +170,20 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  * necessary (as the section size can change). But it's more likely that the
  * section size will rather get smaller and not bigger over time.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
-#elif defined(TARGET_ARM)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
-#else
-#error VIRTIO_MEM_USABLE_EXTENT not defined
-#endif
+static uint64_t virtio_mem_usable_extent_size(void)
+{
+    switch (target_system_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+    case SYS_EMU_TARGET_S390X:
+        return 2 * 128 * MiB;
+    case SYS_EMU_TARGET_AARCH64:
+    case SYS_EMU_TARGET_ARM:
+        return 2 * 512 * MiB;
+    default:
+        g_assert_not_reached();
+    }
+}
 
 static bool virtio_mem_is_busy(void)
 {
@@ -721,7 +728,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
                                             bool can_shrink)
 {
     uint64_t newsize = MIN(memory_region_size(&vmem->memdev->mr),
-                           requested_size + VIRTIO_MEM_USABLE_EXTENT);
+                           requested_size + virtio_mem_usable_extent_size());
 
     /* The usable region size always has to be multiples of the block size. */
     newsize = QEMU_ALIGN_UP(newsize, vmem->block_size);
-- 
2.47.1



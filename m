Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC65E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOffd-0005o3-8U; Fri, 20 Dec 2024 11:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffa-0005nN-K2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffY-0006RN-EQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso15599925e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711362; x=1735316162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4I2sgc4zyVzNmVJJfP05uF241HGHYdnQL3Ka9kt1v/E=;
 b=uW+fNup3Akd8tquDah1QOw8oRzbIiDSKMV8OLMeNjY9EqrtiY82bxcyTtJiJijWV1V
 S7P29WUktypFHZBmpbRl2NBlvYLGfMYZjrIdHU2fLMBgFggFIXNFOiGwUMeRBaQcJFFv
 tO3HRVOFRbL7GyeXfzJJR3o1ns8gMijxxeVwWA41vziTBh5WL5Rh8rqR4PJ3gFV6gs4t
 MxXnm7vKNz4KpId5h6/LCoYt83IgUR4KLVFFGzWAnBMiBQrV2aacK/kCkt+eDxWYBPoU
 OlqXfyqaIRuymV7LpwXXV1vnImX0ueGeOAbfaOrSNYdVOzkgpK1H1E72wPlfoRG17rR+
 njCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711362; x=1735316162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4I2sgc4zyVzNmVJJfP05uF241HGHYdnQL3Ka9kt1v/E=;
 b=xFsuulLE+TAO4R3ZadIIxLTmXLvW+jybi5yqlFNzMkIBPLmoX2GvFyf1Q72sgz9mPu
 fXDrKIaqEEhsh4X5xUEJIjF7krcozzq5wvo+PMHJ3GQJiTtF9wfhA/RYnKSR4WdAXEas
 elEM//pU7aNxvmxHG/q6HIgl2Wd0DNG8G7MRYxjaijbIrxmHUeJrZycEFpi8qzseLwTQ
 VLE3FI2KmBImsPuDQpBE/VO7r0sP3Ko1QhKn0zwVcMhFZmc5Hpt6t1coL6cg6R+zvCMv
 VSSTxmZqJ9eZnpcdROkTAP8ugUzxISFqa+O+gtpo644lx3AXVlj+AimiTyUtGUkghlsy
 qy5w==
X-Gm-Message-State: AOJu0YzLxu2KdNvT0qfR/wbfZVI28FnioDbNf6cMyILnTs3KMKYoLJMu
 MraigvAFwLRYn2dYO4x9AMO1VgGWL20C3erLdNE/LuptMpvl8CHatpc4dCVNHUYpH0DHG06tNUD
 V
X-Gm-Gg: ASbGnctrmCHq4EDO0j41clJLYOgkU4S6rftcR90WM7bZ1zEhaEFBRh2KZluPcTysQ8J
 P2AfbNYQnMCOdJIJ/Da03SWDDP+6l5xRQo201eXF94q0gW8cuuh7XGFCxbT/fcTNepXWu4MW3xw
 IZD3GLNlikzNLlcEKrWDj5ooPKK05twTUxMFvZTSCZAqTL9axcos8ifRbvxw/CO0Md/hQNn3d3j
 OQrV9f4vxy8sAry3J0a0SKPXYzqsBEg14q28e7wj4EJkOPecr7ks/tgmNVp1mH2AjJl1QNAzcs=
X-Google-Smtp-Source: AGHT+IFQSoZp/8oJRS+VDOVhyo8LI6gm1KaHtaXfOq3/U73OCzNCEhgI39el8YdFPVolR/cN/D5mRw==
X-Received: by 2002:a05:6000:1848:b0:386:459e:655d with SMTP id
 ffacd0b85a97d-38a221fa039mr3845269f8f.20.1734711362402; 
 Fri, 20 Dec 2024 08:16:02 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a379d69sm102095765e9.0.2024.12.20.08.16.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/59] log: Add separate debug option for logging invalid
 memory accesses
Date: Fri, 20 Dec 2024 17:14:53 +0100
Message-ID: <20241220161551.89317-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Currently -d guest_errors enables logging of different invalid actions
by the guest such as misusing hardware, accessing missing features or
invalid memory areas. The memory access logging can be quite verbose
which obscures the other messages enabled by this debug switch so
separate it by adding a new -d invalid_mem option to make it possible
to control it independently of other guest error logs.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1bb0d0e91ba14aca13056df3b0a774f89cbf966c.1730549443.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/log.h | 1 +
 system/memory.c    | 6 +++---
 system/physmem.c   | 2 +-
 util/log.c         | 2 ++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index e10e24cd4fc..60da703e670 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -37,6 +37,7 @@ bool qemu_log_separate(void);
 #define LOG_PER_THREAD     (1 << 20)
 #define CPU_LOG_TB_VPU     (1 << 21)
 #define LOG_TB_OP_PLUGIN   (1 << 22)
+#define LOG_INVALID_MEM    (1 << 23)
 
 /* Lock/unlock output. */
 
diff --git a/system/memory.c b/system/memory.c
index 85f6834cb3c..a789064fbfa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1412,7 +1412,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
 {
     if (mr->ops->valid.accepts
         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid %s at addr 0x%" HWADDR_PRIX
+        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: rejected\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
@@ -1420,7 +1420,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
     }
 
     if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid %s at addr 0x%" HWADDR_PRIX
+        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: unaligned\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
@@ -1434,7 +1434,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
 
     if (size > mr->ops->valid.max_access_size
         || size < mr->ops->valid.min_access_size) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid %s at addr 0x%" HWADDR_PRIX
+        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: invalid size "
                       "(min:%u max:%u)\n",
                       is_write ? "write" : "read",
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a3846..4bc0228a504 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2745,7 +2745,7 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
     if (memory_region_is_ram(mr)) {
         return true;
     }
-    qemu_log_mask(LOG_GUEST_ERROR,
+    qemu_log_mask(LOG_INVALID_MEM,
                   "Invalid access to non-RAM device at "
                   "addr 0x%" HWADDR_PRIX ", size %" HWADDR_PRIu ", "
                   "region '%s'\n", addr, len, memory_region_name(mr));
diff --git a/util/log.c b/util/log.c
index 6219819855c..b87d399e4cb 100644
--- a/util/log.c
+++ b/util/log.c
@@ -503,6 +503,8 @@ const QEMULogItem qemu_log_items[] = {
       "open a separate log file per thread; filename must contain '%d'" },
     { CPU_LOG_TB_VPU, "vpu",
       "include VPU registers in the 'cpu' logging" },
+    { LOG_INVALID_MEM, "invalid_mem",
+      "log invalid memory accesses" },
     { 0, NULL, NULL },
 };
 
-- 
2.47.1



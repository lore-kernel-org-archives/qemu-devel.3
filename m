Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B1BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1q-0005DZ-JZ; Fri, 25 Apr 2025 11:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1d-0004n4-9W
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1b-000441-BM
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso22175865e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595093; x=1746199893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL1tyjiMehEL35jBFEUS3hsenMPouYIDfhpqN9W/Knk=;
 b=dHjOaDW+vW/5mZyxV6Z13LArRMMrA/VjyphGSh9oGUdK6YEPz39W98C7PoaAsKD8VB
 AsDIZBWcPSZvGYeXGnWeuw/zyqzQUg8ijDvJ+cCAEZLcgYmvwpU1cKoIv509skyxpNuE
 dRDCfhOPE7+vDoX1N+7o554zC/7T2DXRWZy79rI2NlbxaiAn4BToINDg7CjibrJQiwV4
 0EjQpsi0WIaS4sBNxJc7hJahpkiwpOwXJYx6IMC9teY3hsnGUI6KIiJudOkAC9bgns44
 kfs5faKL/N5Hz9ycQDbxHAkCtifuubrtHsT+zXtomMqgyKg30dqbhejEPqcmA/xwAGll
 xkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595093; x=1746199893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL1tyjiMehEL35jBFEUS3hsenMPouYIDfhpqN9W/Knk=;
 b=Axbeow7W9DT8UOnwPqYnod2JNX0u5gtYDuOuguuYIKOGXailHGsjsWZAWlDfgq4rdu
 l5xr8nUp1ZSos9+4tMt4XSWnVATnuhXsVG41SLZAPDE6xvYOHDTrV/VBcGmZf1ouHgLO
 sdv0LHyhj1MaB77loTfTK5QJQA8I0raI92X0PB1x3cD1zWDhU801zoFTAIXodmpHiJ8N
 cTWQ/OGeHt3bUWLmYyW19fzyWwHB5mb+RyQvhjdoO6dVYwfqj/P02z1+lVExcI8f8zru
 UzT1uxlQ2uFxAeQfb01kJydlgegtSuvT3cfCtnWsYCrR1DjkDo4ABXzPCQzLlZY9tEph
 rLzQ==
X-Gm-Message-State: AOJu0YzPgd4oqTHlT0jrQdiaN+QyFbGTI1li18K1VF3hw3wc19/66XJP
 47iu3ui/k4DGm/YaWh7f7Z3tLB2Rz07LS+CZoMN4xdTLzrN1Un50bv6I7sqgGYekTCCP/HaeDbk
 m
X-Gm-Gg: ASbGncuSIxHlMpLtDIzqv5iSyGClqBP5DyPfPNopCTk418lx8/3ZnJW8FdbYdiAUL3y
 NhdYK0wLzBtRbtKvd9QvbtkDjIccvCeyb9pjt06D0uiFqOEWOwky0FIeaeXeOYRe2WYmLO8yiJ7
 4LKMLf6ydL+FO+WAXLZO0BOT35x+Bhsn3GppH6ovfTFahPHqUCJOjkomvffSPgsIN4dwMq2dQ+y
 0GLVzTZgDQAWSGzVuF/TrNr/ciVy11dANF5L5Cb2an5GjQ/0LyMqehTmsln6p48MRpgUvAzFZQi
 MTHWWVL7TDU4Fw3brVHKiqL1exmDdRaWBebkfUMONd+f1PUjn6xoXsbBdJ8w3AhBJyeVzCdIkg8
 x7i5ji0NnXEBxLW4=
X-Google-Smtp-Source: AGHT+IHbYZf350joq2DKMCq14OYRU3ZxaZ5RLhIrAVs5dLJLCGimrtv0L/oKbHGtXElvAG0KL7G+kw==
X-Received: by 2002:a05:600c:1e18:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-440a66b075cmr23372835e9.33.1745595093123; 
 Fri, 25 Apr 2025 08:31:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4f88sm2619353f8f.29.2025.04.25.08.31.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 34/58] system/memory: Remove DEVICE_HOST_ENDIAN definition
Date: Fri, 25 Apr 2025 17:28:18 +0200
Message-ID: <20250425152843.69638-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Since the previous commit ("exec/memory.h: make devend_memop
"target defines" agnostic") there is a single use of the
DEVICE_HOST_ENDIAN definition in ram_device_mem_ops: inline
it and remove its definition altogether.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250423111625.10424-1-philmd@linaro.org>
---
 include/exec/cpu-common.h | 6 ------
 system/memory-internal.h  | 3 ---
 system/memory.c           | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9b83fd7ac88..dab1e7e5809 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -44,12 +44,6 @@ enum device_endian {
     DEVICE_LITTLE_ENDIAN,
 };
 
-#if HOST_BIG_ENDIAN
-#define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
-#else
-#define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
-#endif
-
 /* address in the RAM (different from a physical address) */
 #if defined(CONFIG_XEN_BACKEND)
 typedef uint64_t ram_addr_t;
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 29717b3c58f..46f758fa7e4 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -41,9 +41,6 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
 {
-    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
-                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
-
     if (end == DEVICE_NATIVE_ENDIAN) {
         return target_big_endian();
     }
diff --git a/system/memory.c b/system/memory.c
index 67e433095b4..71434e7ad02 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1382,7 +1382,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
-    .endianness = DEVICE_HOST_ENDIAN,
+    .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
2.47.1



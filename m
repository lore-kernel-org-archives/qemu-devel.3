Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED320CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ett-0006kM-3l; Thu, 02 Oct 2025 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etm-0006iy-2C
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EtQ-0000sR-Bp
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so3164165e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394539; x=1759999339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rvvp0krdvj9KI0seW+qea5ZtA/ftLNrinoYyViTKgNM=;
 b=IHj+ZyySoK3tflEMc2Qjg5x/JcXi7nd5catKQ2gGqkcYVEakTB6FQe2fWizEbMUGHt
 LiH3krxFxwOk9doAMbEHVRK+qeOO93YOiLc5rUCAry3n1d+TOUWuhsqEvc5OcAmq6NXI
 pxDqCcWShCO7rhdrvVv9notCJaFhh14Iun6bhoRmR20kERpSORGKqD4llLPlZGHcl3Sv
 pXMbSYSrMqD2jj9mmCtDtpSW367brk223tP4hALfBOnuRmAxBNb0g8tqA03loTZilCOS
 6eRqEMlcWd7kdQNwmHSecUQ3Pjh/3NGD1lwlosnptgxJ6XMQG1Aiaz4WYy3KH0SH+45d
 mi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394539; x=1759999339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rvvp0krdvj9KI0seW+qea5ZtA/ftLNrinoYyViTKgNM=;
 b=ZHEC0jrpzhikrA0HNowV5aY2PfcUVRu1+VTyRmxockFULZdw/ozcM5JxUHhuOwNwxu
 7/UHf/NSroA5VvswsK82CDDMqxy15gyFlmttsUzC75iQ7vtQFc3XbV2FKgHXBT8Wy+UU
 z9vjfDYhRfDFOYBBFYSK/16NdNvZMzPeW9r972wZ7Y3vsOZyr5MFR8U9Gbs5ZBrs2Rp5
 SKudlrz+iedVmmadXPkeopoRrTZx37Rb7RLu7bFCA+nHz408E95XJJUSzfbQvWgCIY2c
 wUbkBHJzMC4zEC6D7uBAmSEz/FtxzFB65YNaiPeGbHWGqwjQjJZ9xA4Xs5+5qfwKQK94
 733g==
X-Gm-Message-State: AOJu0Yya6IHIjYsO7CuurqpaHVac3e6LOKZaeh/NG0aF1MgZSb6kdykJ
 oH4Fz2xZFuEoHsBZzA3GIShMIY5oWVqzyYgD8y02Xdwogvr5WetuXQ4s3M4q5Wwd3RoW+xTDvmM
 wfOamAC/vmQ==
X-Gm-Gg: ASbGncuEq+1l+1FfaEZvwhj+eETvSE/sB1osIvJmQotAHIbC2qLT9qkT8qZHscWq0tA
 +yhvz9wO+zmfY+tqpiS3RHUdayoUYgSAFwW9KV3aj6BgP8ZwsamjRHFhl3MXuJV2mU1xi3PvI+c
 wO++himDLieMh4GWP5teNs+sSlk1uLILzl4cq4/MKnYDHs3e0FHKl0j4D55/z9IioQGF3PEkms2
 B6tyLc7O4prjRG4CM2HwKSyotAAx0EvewJoOUHoh/WHA6TQNVGhw9lJ2Ud/kOOpDcRcWNTeSKdw
 xwdtl0MVpZQcE4SdHvvf1eut3WNvKf60fQ+Gzj5UT6gEtedt88G5ORLrec9WCCWRXNblKOByUb4
 GlJkjhxymT8KYD9LfzR3lzy5SsWMZc9ZCJZzLVxPEIAnSAZMkKIi9n1R7z8CF6lW6kiKcvXkUdK
 C+zNi84KDyo0VzMq3HYMDoHz5Qka69Ew==
X-Google-Smtp-Source: AGHT+IG82FlfkoxisOQbRYrohdopoSBAhOILCB0HaVdDr5q4Gy9SbJH0YmtL/0EDlkKLEQXXp8/WZQ==
X-Received: by 2002:a05:600c:4ec6:b0:46c:e3df:529e with SMTP id
 5b1f17b1804b1-46e612ba9ecmr42260135e9.19.1759394539032; 
 Thu, 02 Oct 2025 01:42:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm2636723f8f.17.2025.10.02.01.42.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 03/17] target/i386/arch_memory_mapping: Use
 address_space_memory_is_io()
Date: Thu,  2 Oct 2025 10:41:48 +0200
Message-ID: <20251002084203.63899-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since all functions have an address space argument, it is
trivial to replace cpu_physical_memory_is_io() by
address_space_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/arch_memory_mapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index a2398c21732..560f4689abc 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -35,7 +35,7 @@ static void walk_pte(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = (pte & ~0xfff) & ~(0x1ULL << 63);
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -65,7 +65,7 @@ static void walk_pte2(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = pte & ~0xfff;
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -100,7 +100,7 @@ static void walk_pde(MemoryMappingList *list, AddressSpace *as,
         if (pde & PG_PSE_MASK) {
             /* 2 MB page */
             start_paddr = (pde & ~0x1fffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -142,7 +142,7 @@ static void walk_pde2(MemoryMappingList *list, AddressSpace *as,
              */
             high_paddr = ((hwaddr)(pde & 0x1fe000) << 19);
             start_paddr = (pde & ~0x3fffff) | high_paddr;
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -203,7 +203,7 @@ static void walk_pdpe(MemoryMappingList *list, AddressSpace *as,
         if (pdpe & PG_PSE_MASK) {
             /* 1 GB page */
             start_paddr = (pdpe & ~0x3fffffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4670C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE3Ci-0007SH-NG; Mon, 03 Jun 2024 04:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sE3Cg-0007QX-Mo
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:38:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sE3Ce-0001HX-2Q
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 04:38:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f630e35a01so23014835ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717403878; x=1718008678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gm+0tUE9TGOC7pOyFlrqsIXvfB/fALxsNiDZ0Zoab5A=;
 b=YUqihhctxic98vKd86GKWJSWNzsDdohDDs29Ph3D9rjLavrtOa1we8N3W3frLHMGkm
 aW0Y1+xj213jsOvonNBVh60cy8wXANUFyFqGCSb+1XrzIw3emNTN63ZVZgW35TFO0SP0
 054TxKwExm5sRfc8XxAy9Zdb1AYx4eXveq9P6dsEQqtNTXBFswaNtc8+4KRZIXm6lUa6
 fcUT1T6Wu3NPzEGeJVhpyWo73d5bUjL/F3rBsm4y9QdxnlkF9Y+Xk8RJTfk3WilFbgZy
 TPBKZKwv/qnDQX8m4ZpsQxLy5BPVendmrp8fS0dS12Sx37swmCgdZo2qXGwBMGrjwi5M
 r/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717403878; x=1718008678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gm+0tUE9TGOC7pOyFlrqsIXvfB/fALxsNiDZ0Zoab5A=;
 b=SARyupcOhOoFajR8F0tsMjnhPaKu8N9M7lIBAJZG0OBurLm3XWjoJULXnOzlxRAKcF
 Jkk+uPpLhl9JlRGtsyOSKVMfds1kl8HcEd3DEts1zbUiM/J5RTf9ANnkdSoO+OhUhrM4
 Oq1YoS+cHTVLj2tgPhq/8Beul/fOJL85bpNMEnX9PgH6bo52kaFl1galIuQSgRaCc97f
 SuzhNshtYzuhcA9yTeTzNo8uG2QBeiMkd/oNMVF4jQ+6bG8vRJCkCkqwXsA7oJ8a4p17
 WdB/2gMMqeC6xH5a0SX4BXWsviyOW09IZV86xOZC+nqtXAX8E8ttt1JJOlR76gJoNxWB
 +pjw==
X-Gm-Message-State: AOJu0YyjhamFCAelnCFT99AqgZECN8Trz3MIf9yv/8VU2t9wunr4cKuX
 hqSOTIz3hIlbVAFpAlAVt2FwcG3TlFcJaBpNSgeTKBnTC1i2CGNkXxdQuOAn3+YXiYM5y5uT3CD
 r
X-Google-Smtp-Source: AGHT+IE5pAvHxAyURR5PhJDvLzJm44GdX1kQI+I13GKtju0RORU/rx3jsEOmGa/CK7Kl5YaqKSoCwg==
X-Received: by 2002:a17:902:d512:b0:1f6:782e:da40 with SMTP id
 d9443c01a7336-1f6782ee2f3mr28772495ad.62.1717403878306; 
 Mon, 03 Jun 2024 01:37:58 -0700 (PDT)
Received: from MacBook-Pro-2.local.bytedance.net ([203.208.167.151])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63232dd39sm59406275ad.21.2024.06.03.01.37.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Jun 2024 01:37:58 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xieyongji@bytedance.com, imammedo@redhat.com,
 zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v2] i386/cpu: fixup number of addressable IDs for processor
 cores in the physical package
Date: Mon,  3 Jun 2024 16:36:41 +0800
Message-Id: <20240603083641.97241-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When QEMU is started with:
-cpu host,host-cache-info=on,l3-cache=off \
-smp 2,sockets=1,dies=1,cores=1,threads=2
Guest can't acquire maximum number of addressable IDs for processor cores in
the physical package from CPUID[04H].

When testing Intel TDX, guest attempts to acquire extended topology from CPUID[0bH],
but because the TDX module doesn't provide the emulation of CPUID[0bH],
guest will instead acquire extended topology from CPUID[04H]. However,
due to QEMU's inaccurate emulation of CPUID[04H], one of the vcpus in 2c TDX
guest would be offline.

Fix it by removing the unnecessary condition.

Fixes: d7caf13b5fcf742e5680c1d3448ba070fc811644 ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bc2dceb647..b68f7460db 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6426,10 +6426,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
-                if (cores_per_pkg > 1) {
-                    *eax &= ~0xFC000000;
-                    *eax |= max_core_ids_in_package(&topo_info) << 26;
-                }
+                *eax &= ~0xFC000000;
+                *eax |= max_core_ids_in_package(&topo_info) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
-- 
2.20.1



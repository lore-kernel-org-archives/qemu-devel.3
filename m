Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB26F8DFF9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn2s-0006z2-EH; Fri, 17 Apr 2026 13:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2G-0006jR-AM
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2B-00021a-AQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d73422431so706773f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447073; x=1777051873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQYrrv1L4J6sS80hNKRy6gThlptUiC2z7DTgSRrd8fY=;
 b=byzywD4KxWAbNIVy8+5/lT3XqK8XIviA72NRgtyXQIcL+nQpjFvqAibFDm0I6Wyy4R
 ruS/d+VWqNASfalQNdKA1Kti/sQNM1aXue2xlw+vp0QfyEYTsP8A9lFRAHJe5YQcPOjS
 M45T/Vg8IxiHKuVE+nBG0/W/IDX7bH7MtMe1r1DfGntw4cJD7Y//2egpbeb4ccYgKqOX
 3ea3TFS4TP6VYZYohGIQrvnHSIv38QwjFLkKDrCcqcs+p9ipMluL1Rj0ZXad4SyAkDIv
 xOcMAJ3V7qjc5byUiP+vtYm27WkoZo2OB6e+xOtGk6l3o8UT5Q6P5qkndQ2lp9vYlwCy
 sKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447073; x=1777051873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQYrrv1L4J6sS80hNKRy6gThlptUiC2z7DTgSRrd8fY=;
 b=ms0bQ3yAShRWo3/FbWAufyt8aPhxGoPt4sk5cwAO3dm84lZZ6bWXoUTRYRsyIbRLCW
 5gh1B6y6winmPeAK3l4wjJvPtXPjCt/fQe5ZcdyoZeGIScCmFmogCWJASTSUzg1w8k68
 tWt3afhU7Qk3Q03qvsP2lzAHKeHTlRACMWJvp6+jQFvkmlsuGcRbJL7G8lmkMRRcj7X2
 c5bnUeb4um3/kQTq1Ypb3LxMEiLAWw8G8gBJgfp0RAw/MzwYC7CIKZndNEYm1B5/7/2J
 RdXKvy6f/fqzzc6a/XQuPQgKyu1Y4MdWQC6Kw5bM+lwo1CcaLaK+jhBeyMewEymDG8Aq
 UV8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GPQtBHnzuN8qxVXPFAEQC7TG4rt94BTjW4j3KAUZvbNx1WfbvCKaz1a5sFMCPa1nGQECrTFh4AHs9@nongnu.org
X-Gm-Message-State: AOJu0YwKH6BSwEOL/tqknXc4gpY02tTBaBbLAyur1QnCfaLxKtqaY2/n
 ov3FWYeprZuex4MJ9XjqLBkWvGT4Ym8U4DW9tf2G89p9lxqTt7iOC0kJRgoMMLKK2KM=
X-Gm-Gg: AeBDievLlzlDyeT0ObED3wIi1XNU0vEWIWIvaC1o3b8fBxah+ZmJNIp049zpeMXLAzB
 rj/VXBsge/J4SeB0usw7MK8I+vuEMdWh9xuQJk3/yM0yRfw1891nL1GJhklmVA0/HC8sSS0KXIN
 5RQrNWDCbo8Xy4PL5rAJknYC3bdkBtKQbKZfiUphbiZbDbZTw7eVAXk3qrky3z5mTF7Vy48Mm9/
 p4DQtsdKSMnEVx+9nn+mKUgm0jfLL+Z4T65dBEgXeBw6pn+rwZu5T9+Lc4vXNKbCHQ2WGE4eVwF
 IoSrArPctQgxaMpLDSgH7ons1C6CGEn2cgSImjUcu4JezkuqkEjOstWpSXYKEaF/ngfmlHaS0Rx
 Kq//ya0q+gAmOzROyjAeAKXcZb/hkgyvN91pefvsLVHJkGc1Cw98SrJRSYuy+R44QeuPKiAIAYk
 Zw/P4NN0nKnMl8iKtmXXszI5y2IJuJZlQf+CFHGOYlZeE5lN6ZW/xqy/ZS/OTQMWXb/1vpAVmuX
 HrQgSY9dR6rSWe8OLbG5rafgPCAbZy3zmfKS+wKTg==
X-Received: by 2002:a05:6000:2006:b0:43f:e7fe:421f with SMTP id
 ffacd0b85a97d-43fe7fe4264mr3287354f8f.40.1776447072599; 
 Fri, 17 Apr 2026 10:31:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 03/17] target/microblaze: Make get_phys_page_attrs_debug
 handle non-page-aligned addrs
Date: Fri, 17 Apr 2026 18:30:51 +0100
Message-ID: <20260417173105.1648172-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

For microblaze, we just need to remove the explicit rounding down to
the page boundary that we were doing in
mb_cpu_get_phys_page_attrs_debug() when calculating the output
physaddr from the results of the MMU lookup.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a1857b7217..da8abe063e 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -284,7 +284,6 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    vaddr vaddr;
     hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
@@ -297,12 +296,12 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     if (mmu_idx != MMU_NOMMU_IDX) {
         hit = mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
-            vaddr = addr & TARGET_PAGE_MASK;
-            paddr = lu.paddr + vaddr - lu.vaddr;
+            paddr = lu.paddr + addr - lu.vaddr;
         } else
             paddr = 0; /* ???.  */
-    } else
-        paddr = addr & TARGET_PAGE_MASK;
+    } else {
+        paddr = addr;
+    }
 
     return paddr;
 }
-- 
2.43.0



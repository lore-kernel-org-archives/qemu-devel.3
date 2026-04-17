Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C08F436BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn2v-0007Ao-Jo; Fri, 17 Apr 2026 13:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2G-0006jK-8Y
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2B-000218-9d
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:17 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so559956f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447071; x=1777051871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqdYb2Ac9eVKgwfgrSKBf0XMUR0VWrhwweydT8/TgLI=;
 b=PhV+oxsSB40edeFRP8VQEMre+MZTy4J3iFN6Z8l/RP5J0Y1inZG73JFoQpXFExJK6t
 DFk/7s1ZBHhEWtCdTDZXn9k0hk2YsyefBKfv70QV+eodBYtvpQFX4sOwLS9kzcqCv9Up
 OKOB8PUcn5rQ+DaqRnSfV5gHLLKHBP0Dt4mW88F87Fcs6/+S3lBP4KNIf7MX4U0kSkK3
 RCwG1iKGey2u4jd6xGdNQ+pqPaqw74mW11WKyq7aOGdVpsYj6HCS5/EZn7GHQSSs7lh0
 jKUEUQW4XHqRgrtjA+WLxMEHPCIng8PtkdFU48dOzvEJL20srQkQ12TY4J8nv/HouCX8
 xSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447071; x=1777051871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pqdYb2Ac9eVKgwfgrSKBf0XMUR0VWrhwweydT8/TgLI=;
 b=MFN/n1w1v8+4ZsxtEEmOEt2osK7tu2lEm+caXYwdlm2XdGrKnUH0cbl0uophOJp2kq
 9KHKIiWi7Vg24oWwCWFXdOWWe0Cq/6Y9tWPBxeh3ajoV9kXZTLhriJTQl7QdZtpqGnci
 zi3jAK97CCUhfQ6kiv3RhxlmBRtjHYtJR0igJmlCpuvX98TfgoBFA9bx84k6A5peWAn8
 Kwn8vRqKPSgydLzinONPGvBk18sBIo4vf/glxTviO2LPU0GqtdbpAeFWQtWXN06hAO5A
 PX/9fyoDBN0gVFLu6z4YK8Ue5ahqFpNscuNV1zihV7EcdapSlFswfIvHzWtaYn2NF7tG
 Xe6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ969+I84bko1zzc3eqRZduyWau5gaDXY2Y808o0bzBIggFVPAyzJTMtJG+qAKpdbusPsPI5ih0flNhN@nongnu.org
X-Gm-Message-State: AOJu0YzVOHfF1XTb11zryMPKhd/9SU0NRUt1P2kT4V4BCU+sk/t+zRCp
 cdw5pDYWzpw9RYegPJYwDX5jvqXIUF0eHpf7EL77A2ZlSTuylfUHNX/R9wxu4XqXdOg=
X-Gm-Gg: AeBDieuGsTVueLtTHBJ6+GWS334tGzdLVqRfI4e1VgHI4rVGCldxZYcOPD1NX8QqKWL
 p8gvR7Tq3HerL7jCNI/hiFBrsnFMJhNISaUD8OzNEd1DShzff3U11A+HILbg2P4wyLDfWiLD9x7
 4m36F71ZuZ7lvyV3CnvApg5cDHQpkkU7yxAnRJwHfoQ7ezwvG7238HjHtBnVxTHbyPjN+yXwkDh
 4RB77J+lBkSxMbmbJuPagfYH3btZ8xgJeAlZNnMRYbEYvnX1cobALlm35TRfly0F6on67bERCEQ
 dGove6HkWMskVBVtPDBqHi2oJbgMW8/sEvXL6F0uMW3krFE6HHnByhUtRsjCcmYZC/2CaSFhWYF
 NryP7AWseGVKcbQ5IWjHjnBbVn1gdt1tsQsnpcKYgxzKgXL4/q+xUP5ujrdIjukrbVUuBvcbm3L
 Dv0z18n5YPF/ImHoNblGwRTGmmFRnHEQ5UwcpnmRGdIBq9XmAn3HT6uL1REWBz2GOpCJWf7KBqR
 OKqVKKyBQtd9BfhA/xLRiw4RZhB+TCetaO33u6dYQ==
X-Received: by 2002:a05:6000:2087:b0:43d:7403:4b5d with SMTP id
 ffacd0b85a97d-43fe3dc49ecmr5912425f8f.15.1776447071031; 
 Fri, 17 Apr 2026 10:31:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:10 -0700 (PDT)
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
Subject: [PATCH 02/17] target/alpha: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Fri, 17 Apr 2026 18:30:50 +0100
Message-ID: <20260417173105.1648172-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

For alpha, the get_physical_address() function accepts arbitrary
input addresses but may return an output rounded down to a page
boundary, so in alpha_cpu_get_phys_page_debug() we OR the within-page
offset into it before returning it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/alpha/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 179dc2dc7a..af6d7847d5 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -301,6 +301,7 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot, fail;
 
     fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
+    phys |= addr & ~TARGET_PAGE_MASK;
     return (fail >= 0 ? -1 : phys);
 }
 
-- 
2.43.0



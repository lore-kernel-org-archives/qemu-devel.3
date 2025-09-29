Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E687CCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Igp-00058S-7e; Mon, 29 Sep 2025 14:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igl-000571-Mn
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igi-00038s-Tw
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso27634145e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170804; x=1759775604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjyCCW7HHI1dG8y1m+qgvriOV7CMEgsHNpX6hQdnX2g=;
 b=yy7FalArECwP5LeUYwwwpyrE/3Ur2fHz2oeERvroGMxAtQKyxfKGsWKLub+2IgWC8b
 KOXszlo5a5aoxPqiYtgc3aYKzdl+UMjTl58nAvQ+2Pug/fOOueznZD33a1NEzcvx318q
 KRTvTV8P4HrWvWBkJUilSgeq3oSCCUgCiGdnrULpXZFA2ETBJu/KqM5NSdV8Q9UuSsO7
 4HFlfaBBVy8q5hGhFw7UtjYhBCGBjrZZAYIQhbGSGZW6n5RMGoBtKaSnd1L/w8bwHyEI
 YkP0tIa4W9h7VfbpCFMWZ0iBSZmh/xt0PwzxOHM3p0rrukeiJKE7Pu+0x8SXpXT4Tutx
 ZOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170804; x=1759775604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjyCCW7HHI1dG8y1m+qgvriOV7CMEgsHNpX6hQdnX2g=;
 b=mfH9sSpv+T5zelRbvgdsgDFfzxpfYeU7fqD1zdDFa1X0CIdk6ifhbTXXeFPK7ueGo9
 nPSrzzsV4fa33YFkHDrcMlshqRibMJCnKsT1rhMONMh6+hers10PYFPISqPJfj0yCqmq
 7u20lz222qAuLUl2zCER15yFZBlrjyIMtOGnPXpCK9I0ceYJs/taHeoza6iE7quUaTOL
 yvxW4RXkZgrI725p9DLVtf3keRyQ3NhLoIVWswHlHiykj8UbzUnGhWBf7IzmoNGrB0/D
 uBFeXfbAY1CFd/Dss5jg1pt2amyGBBh+7YRLwbGN6SOkPU/jRezo/NWl9DIyFiWCNHxB
 HKLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBcFIfADjDmSzqmvCS9JJqCwi/xUBP4cDbiHzwVnUPHzg29bYIw0yDKqgU19aoUtP76Lwwf6YZ4E5o@nongnu.org
X-Gm-Message-State: AOJu0YyFpevKS4HmM3SXXhD3OMfTlfvhhExd4afiSmrn02JLElgJ4Qb0
 Hjr5bRBr/fqa3yJUtGZc2FEOg4s/gAjISg0AJuxLAZAvXOduPVtd3VK1mPO6STFCM+g=
X-Gm-Gg: ASbGnctAWZLkw+lHLZLnQoqZrDLOtmHg4dtvykvbv095cDv5lWohkRbrgVpb+b+jzBp
 7GPGjVVr8eR7nqbhtVfb0w/drTsMdNyXuc0KxTqUdPNryEBoxFei1zUEZAAzkPHMTyZkEfAx57n
 RMpPyy+xh8J8esnB2+9gx9ahTSo/+KIjyOToS+ygmSNBt59XUTPZ+Pw8GFN8kkrpNYe9CykHgl/
 tboT593HWkm146fXjJkztvr4ihQ8sV6ZJK3S45b9VIJ/Gz2u/hW47I36A3WEqZeEWaojV7sTmfT
 tDDuo9gdoHcpwelulIJGxeegNdGyPtDE1U48hm4pVuyqchFNdVq6vwz0DN1gGSgUtPjbAyaSkmg
 SA0Z2zWVTKLvFTY6u+ScDryGsVt7zuA7sYQhn2flui0SYM+2DUaBvHhnoLL9Ka6Mk2MIU9Ud9
X-Google-Smtp-Source: AGHT+IHQ2XCQX3HS0p3adUQdcJQXlpyRbo0k/r6XrZhzUXT4d+zZkT16mDlxSIQ19wUJoBTgikwi5g==
X-Received: by 2002:a05:600c:c10b:b0:46e:33ed:bca4 with SMTP id
 5b1f17b1804b1-46e58cea408mr12664365e9.15.1759170804364; 
 Mon, 29 Sep 2025 11:33:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e59ac769asm2811925e9.4.2025.09.29.11.33.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 05/15] system/physmem: Remove cpu_physical_memory_is_io()
Date: Mon, 29 Sep 2025 20:32:44 +0200
Message-ID: <20250929183254.85478-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
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

There are no more uses of the legacy cpu_physical_memory_is_io()
method. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 --
 system/physmem.c          | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e413d8b3079..a73463a7038 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -149,8 +149,6 @@ void *cpu_physical_memory_map(hwaddr addr,
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
                                bool is_write, hwaddr access_len);
 
-bool cpu_physical_memory_is_io(hwaddr phys_addr);
-
 /* Coalesced MMIO regions are areas where write operations can be reordered.
  * This usually implies that write operations are side-effect free.  This allows
  * batching which can make a major impact on performance when using
diff --git a/system/physmem.c b/system/physmem.c
index 18b3d38dc0c..fd2331c8d01 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3763,11 +3763,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
-bool cpu_physical_memory_is_io(hwaddr phys_addr)
-{
-    return address_space_memory_is_io(&address_space_memory, phys_addr, 1);
-}
-
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
 {
     RAMBlock *block;
-- 
2.51.0



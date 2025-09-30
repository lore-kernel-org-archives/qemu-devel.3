Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A0CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rkn-0001ka-A5; Tue, 30 Sep 2025 00:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rkh-0001j4-FY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rke-0000rN-IA
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so52025625e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205643; x=1759810443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJHuzj8i65yKq7/CrLnIUXqdpZj8DIZ6OJzdCMb/6CI=;
 b=kc1TilDrb2lMBkaiZCYIoes1wX/QHPMypNoiY8a5pLECo68NhFVX69WIraL+upBwrK
 nvu47nWut88HdrteiMK+f/15xyPCBNfwDDe2324Nm5pNd64+JvY4yWNDtkMtXWnjW4R8
 b0wHdPwFcNsTSENc5IQ4xWn+YMCiyg37kJNWyQc0Xas7840c7Dov923sdwElps4ZJdoG
 3e4x6IRBJwM33rLV5Cmsmpv1yZyaH6r6BSX1pdRAO/cH9rnRgqgg+IjIFH5RkDPNOP2B
 I5w6+PteApsqfNUQoABVA9CuR8Q9yfMDQUqrgaYsq7+ePCCzLyWvO5AP6qLHD3Q8xy/2
 ek6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205643; x=1759810443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJHuzj8i65yKq7/CrLnIUXqdpZj8DIZ6OJzdCMb/6CI=;
 b=hVeAGHWu/6AJTT5QgxMMTxkcZwGuBu/BK4XjgKN/bVocICckTBuGLYaJZWko3twYEx
 YeWF2szeljh59IbCCwf6bXrajl0R0q3HbtC2eTOTiOiMfWIl+7MwXZkDly2uq2gogtia
 Jm5sRwZxgNZ7E//kEwVpIO6TOqW1Mw2FGMEnmby5SCmA9ZxNOyFSW/f0Oi0H4t0o/3h3
 Se14eHwndEr+41GISZGQPj9OrgHHrXJDa1lYfyW51/KIxNNIBd7q6bYsDh1O6oSlSwNK
 akKIUxkuovmwkGJyf0dS66NKlVgIYvgonjaiG2tadNpzkplxZdvYvYqTJLI+fR1G2omR
 FBOg==
X-Gm-Message-State: AOJu0Yw/oe4p+J5Yb06RE/KWllGV8gdnysZhnLzM1jfz8MvZS2MRXi/Q
 X3BKVpXJLln4sJ59GNPmLuoL4qN+puXfoeTOa5vJ+ICkg1U22s6oYK6yxYrsWDiXo2+8GQZb/3H
 uZJle7pNwmw==
X-Gm-Gg: ASbGncsLVcMg/HR3WLrzsIkfDLJXTrbdq1h9Dr0ArrayJf8gUQMzTyM56oxxClqx9D6
 VJP/YuSFz0aejoukHNxkHm0c5iesJXMvFVwYUWtYdWYBYsDYr9EHCYVLBHvGWN4eVMfjV6FXvRx
 bWAIimA+RDkWnfWaOuBGdV7xIEwxfDVV88VxzkQa3NwcwWy/TjChybKkQWhTOinA4QTz7Q47FZh
 fjn4bKmk1XSoUChW6kvywR//5IJYPl+q6b5896thMSu17Rcy4JSOS8DQ+YzZBieNA8b+hL9siM6
 JzGoy43a6BHxaMHnYn8yYTPptahVZiTe/dDvfPNoL2PeTACDCXGKQQoQPnzXUQB8SdeMRyWhcwO
 jedoxErJNOToWx8zaAjziofRtaoX78+/SHhV8Db3TxMki6DuPJoTiQpzT1fy+HKChuU67kIbjHj
 7UUE6l3bm4Ez+H0JdvW/bG7u4BnKSaYCo=
X-Google-Smtp-Source: AGHT+IFzoydC/PtH1+zccfqdIbgaSIsqjwZE3Y6j7iXWudBl2KZiSFlGWhLtg5m0yJ4ctRkRXODKlQ==
X-Received: by 2002:a5d:588c:0:b0:3f9:fd59:7a5f with SMTP id
 ffacd0b85a97d-40e4a05bf52mr18187688f8f.33.1759205643111; 
 Mon, 29 Sep 2025 21:14:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6cf3835sm20954191f8f.46.2025.09.29.21.14.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 06/17] system/physmem: Remove cpu_physical_memory_is_io()
Date: Tue, 30 Sep 2025 06:13:14 +0200
Message-ID: <20250930041326.6448-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

There are no more uses of the legacy cpu_physical_memory_is_io()
method. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index be8e66dfe02..573e5bb1adc 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3763,11 +3763,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
-bool cpu_physical_memory_is_io(hwaddr phys_addr)
-{
-    return address_space_is_io(&address_space_memory, phys_addr);
-}
-
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
 {
     RAMBlock *block;
-- 
2.51.0



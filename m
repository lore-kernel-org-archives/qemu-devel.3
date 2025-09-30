Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03811CAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeB-0000ac-Rv; Tue, 30 Sep 2025 04:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdK-00005k-LX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vcc-0000tE-4U
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so3302793f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220521; x=1759825321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlQqoXg6at6m3NCWUmLz6YxBYJSCTlYqTL2bdBtbhz0=;
 b=gs/6hE+e6q6beS0FqJNWiFtdzJ6JHooOWdOcBehvC79inJZi6jzbaMqdDTgiLGC7NV
 mVgmEvPqqoFtYgn2eJ45wS/gwT8F2v0NvqGl8PzgzOd3ztVX8xzX3IpbI7J+IbkKm1Md
 MTJgTviIIz2PfVlky1P4sSrPjaZ4DeUjSZmz+k9WdcscEuOjJTRBchcuCFxo9Nudccd7
 gNn+pB7nr+BnBOCJspNxAoodY5MR97kWj00BQSb4c3DzjWGA4GvY4lJMLPRgnN911DkI
 Xm1FeNcxOZiE0gbnPD1DgQqv3DhrnGfphO+zKhoUvGCRqt6m5O8iOJot3kNwNGI5gh4v
 2BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220521; x=1759825321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlQqoXg6at6m3NCWUmLz6YxBYJSCTlYqTL2bdBtbhz0=;
 b=pdaBma7a6rcg/bCRv5zbEsQXjRioYXtt0DUTg9yLdznmrUWrA9XnyQu/vgl3F7lRYH
 WcUxvk9PLtE7gtVRyX3NuY09cs2sahUDUuBSF9zdoEKml2fS5CAn/Ij+QvSQOUdySw0T
 tFXd6Xs/pOly6JI5CxURNA/a7pLZRbgY92VdzEnMaRTd5x8L90meJrwc4G/euAPJ0KlG
 L7itOJReH6b0QcVvsAmycvREdbU6bM89ny/tqwOjFDJymf84FFZLGVNLdYvoJC9Ny8Ep
 jCNg5sy07macGnCS/HpoP3jYN9YjoN6XJFIbVPQm3tWQYISrijHmS6iM3W+4Ug7F7nLx
 PcBA==
X-Gm-Message-State: AOJu0YzJBQppIuU6l+RsmKEBI3l8gGDEMwk8p3UFzXy9972a+wuGBwp/
 2XkCA+T1+22ff6vGxLKUzUlQCt90ZMA7s5Jqp34ndNAwVUnIk7alTLkGwSa2vvx+ZhAVXLc275o
 FreDEbIOapA==
X-Gm-Gg: ASbGncss5vxJcb1JXek5EOY+72zsF+YMdRaJSa/9kzAgioKUNvJRxGA2g8W3V5kxMQU
 B8qqHskxRfpIc6fpgDL1eHXSS2YOQgHcCdx3YiVluBvFGO9OgmgbYn+G+qxKWPOGh2L/VlIyVxN
 gk2o6ChoEzUqoZ5ihmBGeOy49PQGtjfxRSC5PCyMc1awReexdgFaBF5RJXLgrBOlWqUTKnde5vh
 wTZ/tSeCZqP7o65Awq0teEiLDhW1jfra3ctRYG9yrtZ8nKjCfzrCnCfmuVWICENbTSukY3WXIio
 6PeDHptBjveRsn4ndQ87OHyqxkq+GuwWBifAQrmPBKvFskd9U5NIwLLHRkq+/MddlOJocKA9P4+
 Ok6TX7BCQ6aGQNobAEZ8KooTNl13bXaoccPe4xROlsUKCw62a822Gi8/kFkzfId8gDTxB6X7unv
 5av+ol+sDTjfA8zVdENBQJTqs33kS2TCc=
X-Google-Smtp-Source: AGHT+IGxp9mmy7B4YaVXtK8axEEppjEFlOJUhOlUxG1XXBFZ2PBviuJyAi3OzbI29QHLpWomSM6JGg==
X-Received: by 2002:a05:6000:22c2:b0:3e7:ff32:1ab with SMTP id
 ffacd0b85a97d-40e4b294f33mr14571301f8f.50.1759220521460; 
 Tue, 30 Sep 2025 01:22:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fac4a5e41sm22972926f8f.0.2025.09.30.01.22.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 06/18] system/physmem: Remove cpu_physical_memory_is_io()
Date: Tue, 30 Sep 2025 10:21:13 +0200
Message-ID: <20250930082126.28618-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
index 84d7754ccab..dff8bd5bab7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3764,11 +3764,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF47CCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoTy-0005cJ-3z; Tue, 28 Oct 2025 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoTa-00051D-O5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:31:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoTL-0003xt-31
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:31:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so37978645e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676260; x=1762281060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fermtkBdaDZXNajdjB6zA0OKZzLVtlqaDe4tnQa95wQ=;
 b=vCf0zEE5whdPAXxSBMXnQEZaUwkA/TX7GdNiMMRtNpZF4Olxm1uSvP1An4v+xRuN9a
 k8UytmH/tJqe+NHZloTzA1BxiVAEDnqdQ1MA9FodbmleelD+eZ79i8+1E/huUqe4HzVa
 76jWdhbW6gGAoIhTA5CHmCthYeQr7lGGmnSEmTOd/2gAnoZmEB+59tyyWqEXZ+T7oQYC
 CKAqz5qLnm1Zh+IhIkVJ2w1qIkw6fkl7WUtb+E2sQd5zE3/jvMat4CgPuLE8c0W/Gutk
 LZYBzWtHb7bwQREUnIw2uV6xte0atqGkZpqs7bwRby4gvpET3Eng8B6bBbdaQ2Wt+sek
 iKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676260; x=1762281060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fermtkBdaDZXNajdjB6zA0OKZzLVtlqaDe4tnQa95wQ=;
 b=paUMnWw0q2VXs/q2f8Gf3JkE4b9SkBLFNdJexqwFfjBqDtqKGBZDCT4GfHSUGRA6Mo
 q58fQ4t18ZNItEtOiReoxiwr1XjwqVbJKtBXYveDEPJttqKFJAV6HGg8TSH76W539iPc
 4IQ9HbY/JjmRAin1x7IHLV1e6OgV0kk+d+00HFX4yxJIxG7oHCu2oV2ezO3dW2FigV/z
 pph+MEOkmheOd4lrHlOInigIius/cIFUYBYSQ+exZ4hfOdZRlBEFeazhdss2xxkgGHn+
 v7C8Y/9YzrqfPkVqRGHllxsZfl3SB3MiA0kR5q53rfHB0u5MHz9J+BlseV1gpR5/EoOp
 O6ow==
X-Gm-Message-State: AOJu0Yxp6TuFBptK7isdmWWM0Gte2DE4AcCmQpuMLmVW68b5dDYfFjyh
 bEcJcklrmmBKUlcTjh3yp3WrJASh5rB2GCiTNBKCrKo2Y/PBX7g9r3fWUtR+BlMSWnzXHDRMwv5
 m1XDrAwU=
X-Gm-Gg: ASbGnctqPCUk51UnUOrLFEhFJJF4yJw6K5UDpGEpwYG0c82xpNhbouvP5/TejU0bgew
 DL9J7JMurN8VmMVcNjWgq8vLrBvoAAWMyMjCC0JEx2VRcgLIFevXhNp7XunoYUrClagveSaPBZX
 3fSSh2cQuYCnmhRPtCLNJgQCANqQNxWewXVVSbS+anQ0cJme+LKEyeQc7Kza3MRLR35NelKfYS5
 SnnNmWRyWSiseE/hLAZ504Ml4mJe3bjqPyZPY4FszNxzcgmTS8kn8eLqEADG+t8qnOlCbHgsdKF
 5Nawr7f4RiPL1Q8XedxCKMb7RbsR/zno9sqmk/ZDJZbJ71NA/wz4vYDoahZlKhcAACmnEOOVMs8
 J+m0czFCyO42AIhPEQv+ipXgtSS1LvZJFVwAdCn1wBE/DceeTNC5f2b3nEHx+EUNAhGfRHQKBN0
 +pSX+X737eItoE3N955/8SD2boj38tumHXF30X89ApD3+ubpDBRw==
X-Google-Smtp-Source: AGHT+IEZrBqet2EhgHnX4L/FSECsKa8z/HIEet5qdiAHu/FmoGeAFC0bJdCuXELcszN40D53pYxkaA==
X-Received: by 2002:a05:600c:3b1a:b0:477:58:7d04 with SMTP id
 5b1f17b1804b1-4771e1abf88mr4154275e9.9.1761676260305; 
 Tue, 28 Oct 2025 11:31:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e235ae1sm7425275e9.17.2025.10.28.11.30.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:30:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Subject: [PATCH v3 15/25] hw/nvme: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:49 +0100
Message-ID: <20251028181300.41475-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvme/ctrl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9505f291f62..65cc1c8ee52 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -522,7 +522,7 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
     }
 
     mr = &n->cmb.mem;
-    lo = n->params.legacy_cmb ? n->cmb.mem.addr : n->cmb.cba;
+    lo = n->params.legacy_cmb ? memory_region_get_address(mr) : n->cmb.cba;
     hi = lo + memory_region_size(mr);
 
     return addr >= lo && addr < hi;
@@ -530,7 +530,8 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 
 static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
 {
-    hwaddr base = n->params.legacy_cmb ? n->cmb.mem.addr : n->cmb.cba;
+    hwaddr base = n->params.legacy_cmb ? memory_region_get_address(&n->cmb.mem)
+                                       : n->cmb.cba;
     return &n->cmb.buf[addr - base];
 }
 
@@ -564,7 +565,7 @@ static inline bool nvme_addr_is_iomem(NvmeCtrl *n, hwaddr addr)
      * that if the device model is ever changed to allow the CMB to be located
      * in BAR0 as well, then this must be changed.
      */
-    lo = n->bar0.addr;
+    lo = memory_region_get_address(&n->bar0);
     hi = lo + memory_region_size(&n->bar0);
 
     return addr >= lo && addr < hi;
-- 
2.51.0



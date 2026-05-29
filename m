Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7221CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1IW-00037p-9s; Fri, 29 May 2026 13:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IJ-00035r-9F
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IE-0001bH-4f
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4905529b933so58228445e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780076804; x=1780681604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X3Rfvki5PesEhINGZZ1XM7VNTVNvNKE6bftLN8VM48=;
 b=XFMr6yWT1dMaHFtpvflj7bAsJ3DHV0cWkmJEaOHCAVx8e8l+qxq8hWZGZYYXNKpmx1
 bksMn09fUQtYilcdWeALeXLjIAUpBKAss96toLqcu87CX7vekkS7Me1h87gppg+UUZ1W
 /4P1/qGD2uhmtdKqnRwaXse9C5B6iEgVh5oPkFqD/ksSq2tSwyRrA3mFcoR2wp8g03z9
 LTHBlp83dQNC2/yREPydIMGZnb7DknS6YoauhKFcFV3FoAjzrnVyrF8XOOnf3e+7rcKK
 47A/BowWBih2ni4DNK/h7+qAFstHz3HAYWw66tcV3Bjjse6dB360KypUcJxHUFHrFBZI
 6xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780076804; x=1780681604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3X3Rfvki5PesEhINGZZ1XM7VNTVNvNKE6bftLN8VM48=;
 b=LhmZlUFdfGfFOUGlJ0ouoZUvYk7x9ao7BG2HsykU28Pi2J9CwzPEQaSKqniFfM6kI2
 PjgxE9xgP+wbQov9tJJBYjtyvD3s0fcwUnedNiV5QuzB/NAtq6oLtiwG0nwobZIVOOp/
 OOse+85kc14oyztecfci9ql0hOYdcnCGx7k9qiXA/EPzZrXztsTClD1r6my4aEycEYKg
 ddNVESKuNqd8Sl/itrgBEoJEfv9uXm0o/4mmHX/wst3wQen59PvcdJh7TGrQnFjLNiL8
 FHPQ0AUhfkoBlluf9BDPdQNnyms2V13IYy4Wfn/kjY7dTaeWxfp5gEUi1h3hBWaXkhJD
 V5fQ==
X-Gm-Message-State: AOJu0YxF1+js+BO/7HKAYB5hr6ctcDqvOpr9Zq6ZSD8GJFZX/gWXpJhC
 aY3Vwx/dvMGbWt6sLaRBpjD3zBiAm13il34bqdI1aEyeKx6cj+U9vyiFwhLKXwnt1TdAanAjqz8
 isvLj
X-Gm-Gg: Acq92OHlL9eHjGqONbRROZiDKZjPMBAYpT+C5povONXBOISR+/r3s+KAOHhOW8K9FAZ
 2l23d06m9xVA9+l1YsqVrqRvaWDd9XQfs6iX5v1MnbAGP9FUt4hpmSdHP8CyFDTwbrrGzMqYSuU
 DSpf4FAiAbXSytA+DYgrVMZM1g/Ka6nXMXYMZWBtyNcZUw4k6pwwaV9XDz7IuZ+a0KRx0B33I2X
 p/0vPKQAmP1ETd0Qz7axUcMM5RDRzmViFQfGyMWXBiNyu0AA5p0o6NAfR5GW3BX21KKgcFAqcaw
 zk9E74OYErGQq6jUgMeC7uEikhpkbUhI9Juysg0zfRTj1xXmMdXuLcC+55oDmAHpMggS5kgKu4A
 6ynhujr/4S+XLU+Vet46B38P1Id6GRGyRrOxWhwVqVIjiBCZpy33ff6ufDMkOJe/YlJiuIaf25r
 0Bbvs6fVTVOmCKsrhLgoG0Z6zO0mEwXOWtFSYB1EqN6WvzBdSqzqJ0ZBDGyqq15CXtPN8k6epiA
 KLmIlJ4ROjqJd6/kAuNnbmPxANzRCtzH4Riw0yGMbY=
X-Received: by 2002:a7b:c854:0:b0:490:9699:4428 with SMTP id
 5b1f17b1804b1-490a2964057mr6020575e9.26.1780076803783; 
 Fri, 29 May 2026 10:46:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aa24bsm18668895e9.9.2026.05.29.10.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:46:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 1/5] docs/specs/fw_cfg: Document all architecture register
 layouts
Date: Fri, 29 May 2026 18:46:35 +0100
Message-ID: <20260529174639.451353-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529174639.451353-1-peter.maydell@linaro.org>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

We implement the fw_cfg device for more architectures and machines
that we let on about in our documentation.  Luckily most of the new
ones (notably riscv and loongarch) have followed the straightforward
layout that the Arm virt board picked.

Restructure the documentation to present this as the "standard"
layout, followed by the other layouts used by various other boards
for historical reasons.  This adds PA-RISC, SPARC, PPC and MIPS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/fw_cfg.rst | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/docs/specs/fw_cfg.rst b/docs/specs/fw_cfg.rst
index 31ae31576b..7e2fe0851d 100644
--- a/docs/specs/fw_cfg.rst
+++ b/docs/specs/fw_cfg.rst
@@ -84,15 +84,35 @@ increasing address order, similar to memcpy().
 Register Locations
 ------------------
 
+For a memory-mapped fw_cfg device, the standard register layout is:
+
+    * base address : Data Register (64 bit)
+    * base address + 8 : Selector Register (16 bit)
+    * base address + 16 : DMA Address Register (64 bit)
+
+Some architectures or machines have a different layout for historical reasons:
+
 x86, x86_64
     * Selector Register IOport: 0x510
     * Data Register IOport:     0x511
     * DMA Address IOport:       0x514
 
-Arm
-    * Selector Register address: Base + 8 (2 bytes)
-    * Data Register address:     Base + 0 (8 bytes)
-    * DMA Address address:       Base + 16 (8 bytes)
+PA-RISC:
+    * base address : Selector Register (16 bit)
+    * base address + 4 : Data Register (8 bit)
+
+32-bit SPARC, PPC ``g3beige``, ``mac99``, ``prep``:
+   * base address : Selector Register (16 bit)
+   * base address + 2 : Data Register (8 bit)
+
+64-bit SPARC:
+    * base address : Selector Register (16 bit)
+    * base address + 1 : Data Register (8 bit)
+
+MIPS ``loongson3-virt`` machine:
+    * base address : Selector Register (16 bit)
+    * base address + 8 : Data Register (64 bit)
+
 
 ACPI Interface
 --------------
-- 
2.43.0



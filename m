Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A99C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyYE-0007Nn-4g; Tue, 10 Jun 2025 08:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXw-00072T-NB
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXu-0002eu-5d
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so56528375e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560259; x=1750165059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1SDtp+PzmoXDCdOjc+70YYb7XPFBDbAy3avwI/RQMs=;
 b=PaW8DMKvjuHnaErdBdY4YTNo2BbOvjOexHigHLkS8Jd1awdelFPfBLUzp/vjdVyFR+
 MGwLLJ6xr5V2crnG+U9LIg40ltagzuaoRxHxxmRXYptXCxRCbWyp5rh9Rz1VbvRI//fA
 wZ4SU33bcmxuBHIdJorCy9DXYVMXEJ3gTe7ixsaWqvyhDxwfQ2Ps85hH9FOu0BG1500E
 oQ9BiC72DkUlxKtItczjO95SW+gzn02AVXemvYbsqegySZDHiSlqmJfvchYswVY/8gIN
 xdk4Hh8RMOyD7jpaQF7hylGrwLFAQFcfNNFljWRY9UGBIVZ1xFMc5Nt7xiLPPgvxuw53
 xU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560259; x=1750165059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1SDtp+PzmoXDCdOjc+70YYb7XPFBDbAy3avwI/RQMs=;
 b=mGAAJxP3eO8Yvyqb8FNNFrmOSJNaFgvk25Tu4YcspS5A0+5FCMP4kiNHQgmWal7OlK
 K1fuUloEiCjtohwdIMcUk/oLCEgFQRTt/a6KQa+h0EYdWnM5TEkt9dIl1YNBU7ATDBWr
 snJ0jhFhVnHTVzF6lihkA5suRz52j2eKBaPW/8nEOWPY+3G1iy9OJZ9QSBc2bhHW0B9w
 J7MRFEehtDpE6OYDEOWxAoACpVLW7DVetm52YIJJ/nUhB6bNXVFd00nKwck5Wbb3I38D
 AlHc6A/vVSFyIsbdndAeqj+gVH/ziKJ6a0rZ5iVfUQBQbH3wngR8CV4NfoVFB/kgfCbl
 0X0Q==
X-Gm-Message-State: AOJu0Yzma41FFv4Fj5BRIqFfrilDzcgsd0UUSm6/OQzb90zOCzSeVzdB
 qXUjXWTEftZq3mZ0xB/jGbCTCPX//cGwMcmFhAZ7xJqA5uuuF3akwoq09IEHpz6PII7cDXERbED
 FGenpudc=
X-Gm-Gg: ASbGnctX1C53OQbwyYcaXryDCVNDEL5ZMkZeHcGwXI2R1QXaT2ItzatHPltYQwCivHN
 lGldWn2QD5HlBmLf6oGmSKoR+u7Swt2PgoDT6L0PWSVWdPwwlXyIIRZqC6fMGO6xUYGojJ0jiwo
 EMe5Iiv/JinewyBBlYY4JRbi3W8ZcBjvjP3xKdN7oICRBwpapOapLuhBuMoegMy0hsaMd1aRhmr
 yYQmFWaJWVRa0KjOhwz3nXCpaFzQv7z/chEuRAtfjtNwAVOzlVR8Co6XKlbhI/RDPerC9jQhyoH
 YTHm8pGalpU3LXGBWCsLWOJk6BJKNwy7u3v0vexDoCZ6usHseD4ZM89MBrhmStUed05MN6txUDH
 nYOffkiu4rTW1neHxAnOw2zD0eyfmKv9UbTzk1iEUe0v3aZw9NQFS
X-Google-Smtp-Source: AGHT+IEN5klxZr3rdNlkU2fc8MJtjcCFsxh1awHwe89VnWrH+p06NUGRaezwD6tPG7jhc+nGhyeVFQ==
X-Received: by 2002:a05:6000:220d:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a552274ab9mr2414992f8f.16.1749560259447; 
 Tue, 10 Jun 2025 05:57:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532463ed4sm12316003f8f.94.2025.06.10.05.57.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Alireza Sanaee <alireza.sanaee@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/24] hw/core/cpu: Move CacheType to general cpu.h
Date: Tue, 10 Jun 2025 14:56:23 +0200
Message-ID: <20250610125633.24411-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

I386 has already defined cache types in target/i386/cpu.h.

Move CacheType to hw/core/cpu.h, so that ARM and other architectures
could use it.

Cc: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250605132722.3597593-1-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 6 ++++++
 target/i386/cpu.h     | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1e87f7d393e..33296a1c080 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1126,4 +1126,10 @@ extern const VMStateDescription vmstate_cpu_common;
 #define UNASSIGNED_CPU_INDEX -1
 #define UNASSIGNED_CLUSTER_INDEX -1
 
+enum CacheType {
+    DATA_CACHE,
+    INSTRUCTION_CACHE,
+    UNIFIED_CACHE
+};
+
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 545851cbde1..5910dcf74d4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1773,12 +1773,6 @@ typedef enum TPRAccess {
 
 /* Cache information data structures: */
 
-enum CacheType {
-    DATA_CACHE,
-    INSTRUCTION_CACHE,
-    UNIFIED_CACHE
-};
-
 typedef struct CPUCacheInfo {
     enum CacheType type;
     uint8_t level;
-- 
2.49.0



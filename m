Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0FCD59F5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l3H-0000IT-JV; Wed, 06 Nov 2024 13:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l3E-0000GD-T5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:44 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l3D-0000xY-9o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:44 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so60977e87.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730918801; x=1731523601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkGkfKVgrldMieE36JppEsQQQbpaD8YlgbmPxpDRAVA=;
 b=osv6OU1HWBee3MMmvMD60DrfReffFfr36fmC2BoZHr+p+1MRjX/LOR0DQ9MhXNEMnS
 1PW7ON0HuxuQJOiNDMIgx5QLsf6kMh82X3olvoZRkTjLQ2b2sqmfr9FDY5FZuR5H1Mbc
 GPshzs6H0E4Z4NeJLI1L1vBMHwFMHN7D80+Yb0Qgstbu3kKA2MWbOmHCDsJGWcWQZ430
 /x98iiUTjIzLkNMmoF9vGsuSSEf9IArrvwBZWtQaMnc4v2gbRjd1KppDN59AUwv6H8l4
 FKzSZS2GQWZ2AFOqcfTLTT1D503/BOvoYf4MRvAeCedIiFNIyx2i8dVcypZdfN8F8qGt
 JF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918801; x=1731523601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkGkfKVgrldMieE36JppEsQQQbpaD8YlgbmPxpDRAVA=;
 b=VYOZ+p626y8VBHdFaYXtViKt4WZRLn0lyl3T/XclRHvhGNWXQhLH+TONMEUyaJFtHT
 QUrahuf31oMVb6Kyr3dMTvefH5MzyWBz8URGvmObTS72gHLi92Nlrfi26ORWvYqKnyB1
 qDLFLZiMFl8b4PBc8pEpXwT4Sg6tEpb2YzrvNmwUy/AVP7Rg+IPQcXsT+bj/+jRTjupP
 tLz25UdW1htrWxwFNDORJsd5myC2f0TAuKF4zn0fzdiJmO6i7Qp/87Q/zP8mNqc+egDN
 iJD08wYeq8OWp2Wd74fps6Ty+wYM3uMP9p1gTnpPdOiPjKx0xuckfEnd/WZ5yExYWbkv
 xn0A==
X-Gm-Message-State: AOJu0YwvjqnspmI5LXezWfgkVQhkbDvDwIdoa/FksxY7mRjTI0Wnxqnx
 8Vdrdc+6B6dVTSGNJLJ7INYlTLBK9/LYGaT+PrYvCW/qqr6W/y0I8tyYDVhKeZbZNl5wSkKdehK
 A
X-Google-Smtp-Source: AGHT+IGZ7yhvC/Wx3siWVWtSGdKVwGW9oG3YHsndXh771V6dpEgTCitAC2JnhInj+huJT/sEjeTvSw==
X-Received: by 2002:a05:6512:3c96:b0:530:aa09:b6bf with SMTP id
 2adb3069b0e04-53d65df7628mr10283658e87.24.1730918800919; 
 Wed, 06 Nov 2024 10:46:40 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16a7dc6sm314521266b.7.2024.11.06.10.46.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 10:46:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] hw/sparc: Mark devices as big-endian
Date: Wed,  6 Nov 2024 18:46:12 +0000
Message-ID: <20241106184612.71897-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106184612.71897-1-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

These devices are only used by the SPARC targets, which are
only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/sun4m_iommu.c | 2 +-
 hw/sparc64/sun4u.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 6f765e97e4..4486508e3b 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -238,7 +238,7 @@ static void iommu_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps iommu_mem_ops = {
     .read = iommu_mem_read,
     .write = iommu_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 541c7f74fa..9d7aebf632 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -254,7 +254,7 @@ static void power_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps power_mem_ops = {
     .read = power_mem_read,
     .write = power_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.45.2



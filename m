Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F404BCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoh-0005ku-QA; Tue, 02 Sep 2025 09:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoZ-0005Js-53
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoT-0004et-2D
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b82a21e6bso25311605e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818757; x=1757423557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIy84W92EzHeIC7qnOPN1601x114IBfrsYve75Xfez4=;
 b=p5CygpRu7zXIhv+wXJfEYEAI/PfRwPktofg9iaQHvq0Y6Lx1Wb4Iha85s8vhIDlYlh
 Lyz6qdLJPMbyvCnL3/U3kCN76FHnfHJGHuGx8Jly3gku6Buihb8M2hOoHTrYUZa0Enkb
 CI0IxnMGis2vTnszS49sTw+JB72gQT8bCfg/ezQzvIPr4f1zn0KGQ5YU4kbkXHCfypZo
 kWhQP1mtY/ebCDk6wjusZd5bHkaxgeoxlMZNox7GHR+j+5HJTX9n7fRvnS1NNVLlxzxf
 yn8WjTs6gs6rotAZcxtCZBp75inD39iu3hAj3hlS+l7S1VXgHyK+dYKiyh3AEua7XhiC
 ULgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818757; x=1757423557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIy84W92EzHeIC7qnOPN1601x114IBfrsYve75Xfez4=;
 b=oGCjAJQGiE2uU9Xfj7OSo50EnUY2Xepb2vbdIE1aHllsFBm2y08Gfe8ytg9l80UIBg
 Fj8BImlSfVvQ9hH+gGltOD1wWqM+CDvZqC4ka4JRtjr3xy9oLPmW3Jj9U5XfydXsOUpb
 +I1SzWDDxpKpFORmteF3H0Po17d1dKC3Tm38BjQzEkMONQE2U/+4HJTcWvRk2U43E4Hf
 8x32wDg/KtVvqeaFyMMppha/xZoZl9Vx7L4GIlqWB8INL7QRuvdHRmgFYwenHqjqmPkV
 S5O0uyYJYQa52vVPLDpI11UHwbvZP3qJSwBEI5Rg5S0FYaZEjM8Ys5haIeFD7MhkJ0KF
 VCJQ==
X-Gm-Message-State: AOJu0Yz6lzhneI65sQU4wUuR5qCTG20Nj8QxU38uz8cgnHJGi8BfgEEq
 2lbfFmwuY2QqvWqjY4EDyqsMDubbvA2qOtFZk/aV9T1oBZGMzjd/9IUHiHSwNm8ISANx4C/6TRi
 kdxZg
X-Gm-Gg: ASbGncuZpkF4ORekLKRYMZORVtOyhyDYvnL4S1icKsJ91LOqxUV6KDvbQoT7RsjCecL
 XIikNtKd2STdy57NQK8RsnQjYAcoQJ7GJVvfZBH4BPTkJbR4pcplKWJir5S9QwHsG7mIjG9MM5+
 3Asm2WJA8+ElZDbaohGPCkzpmwtg18wCxFD4pE4/WtTQRxJ2xaePLZq4mbzB1NmQ7LFUrFJE9LV
 Xs1Se6cdCpsNkQuQPpKDddDg/L+9R9Op/9NcUbe/9S4SGWwdXrcxjUySX42YN7jM4eQOxBldR6H
 O0Co833NnwSqYcEpsIv7XAj2iQwhTweK7PvI8pwjYbjsUt2/eLSnKdC2E5tVOXZ+7QMzaucqpql
 1CIkOHzt3yKyru2i+956VeRpeta9WOamfTh9RBamtb1ZGJE9QEF/R+TGRVMfGufdDdPF8ypOC
X-Google-Smtp-Source: AGHT+IGVi2sJyRw3VCiBclizvPXsfECsQzWYdK8EyxMLrdpPfcfSZnRRrrJFxw1qnT+6wGnwgitHhw==
X-Received: by 2002:a05:600c:8b23:b0:45b:47e1:ef6c with SMTP id
 5b1f17b1804b1-45b855b2b0emr89122455e9.35.1756818756687; 
 Tue, 02 Sep 2025 06:12:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8879cesm196780405e9.12.2025.09.02.06.12.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/39] hw/sd/sdcard: Add validation for boot-partition-size
Date: Tue,  2 Sep 2025 15:10:07 +0200
Message-ID: <20250902131016.84968-31-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Make sure we are not silently rounding down or even wrapping around,
causing inconsistencies with the provided image.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
[PMD: Use g_autofree, suggested by Alex]
Message-ID: <1fff448da042bdf8cff7733ce67cadff4c540f1d.1756706188.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7038a140a28..94ec58a83e1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2810,6 +2810,15 @@ static void sd_realize(DeviceState *dev, Error **errp)
         }
         blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
     }
+    if (sd->boot_part_size % (128 * KiB) ||
+        sd->boot_part_size > 255 * 128 * KiB) {
+        g_autofree char *size_str = size_to_str(sd->boot_part_size);
+
+        error_setg(errp, "Invalid boot partition size: %s", size_str);
+        error_append_hint(errp,
+                          "The boot partition size must be multiples of 128K"
+                          "and not larger than 32640K.\n");
+    }
 }
 
 static void emmc_realize(DeviceState *dev, Error **errp)
-- 
2.51.0



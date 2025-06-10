Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F486C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5n2-0005rQ-5S; Tue, 10 Jun 2025 16:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5my-0005oA-6d; Tue, 10 Jun 2025 16:41:44 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5mw-0003R7-9e; Tue, 10 Jun 2025 16:41:43 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-606b6dbe316so6887301a12.3; 
 Tue, 10 Jun 2025 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749588100; x=1750192900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shjFIoaQyra9yiwcwIYMAJApqIMBlEvH5T9r287lwOw=;
 b=CRaP3zUcFydxHzqqWcRLmunyxCht6/0C+Rv2CY9+sEPpSNUTvVlVUVi2/jfbksmf3R
 1hoW3s4f1byF5b+xQyVtmfqxnlQe0rDq1HXMWPcvexC5MqDwWR8Tkt6TiDoknXXCyfAy
 omDSjYRAhVku/P1mtH1vJx+OSKczOZLBFLlFLfGyRAHxQDWeJlYt7wVfRvr1Gt3WKjbp
 el3c3iBHdwrUlPHLUN/uqsjwF/+0GRvyiZSUEoUWqH57+7p65tNUlLr0oOaUpAsMwPfH
 WYB85sSh9epHamTqTncszO9WB9r4XgbDXcaBMQ8ePrBwJKZ0WpJtEunJFnqSPdx1Mvi7
 A6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749588100; x=1750192900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shjFIoaQyra9yiwcwIYMAJApqIMBlEvH5T9r287lwOw=;
 b=TJUtOalK7m151lPYFl+7IsWf8jNxL4Vcod9Q/RTdhk02nSn4Gc9zrnHxT1RizcQGWk
 xlzbL1eElHh2xyiBMoiid56blXjB9loQf/bUD9JM8JAVIQRtQ5FPBWtWotHBwXPR7NA7
 xCWXdELdoLW2QxfRsPEDJ7Ofgtiss2VQ0YAycOTmipo3cVg9vZeiBKtItEbHwl36CA+H
 AyfhvN0o5jT31KCR4OJVkESvbHwH8GZh3OUCXdjYO8Tr4ZZCUmyNG3HzAXfePETXsZiN
 jBrOoMTFNpn+r52QuBz7rT/Fksr28OwjGsBT2H1v3a8cSN48wsdugBXQVSzR0Xfq49Kl
 QN0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJbGdIfXKBciMW6f4ze9pQwWYQaC8fGVo2Ul/qFjrtzroQQNax9MKWVFz/1ZFdqAs2+h7Wbr9zZw==@nongnu.org
X-Gm-Message-State: AOJu0YxooM+JN/gjbrAi1zupQfp6OUJgT9VFS8dgVLmHz+thWz3jStRq
 spBTpUE4tM+llWp151lqlmldrm4ehU430/nUx4bAwWrIl520Kf7Fknu5EJTEDQ==
X-Gm-Gg: ASbGncvB2Fe1k4qfcuTJf25P5dK0lXFLQSmcj6OreV3UgRpM+zObaPs0biuQ8qP67jS
 xSX5ete6CnpREyOsg1c+13ArPMiyP9xlYYgILaH4EB48/+57swruwd9TueHtUjjBYF7LLRrPUxo
 9IGjhjFW8B3+pMIJZdMAZmc1rII968ebYV+rRy4dV7GFdMryEk1bRRZcD8Qy1ZnqlI/nMOm8yPk
 5lmjmThaZHzwF20BV6KyR/Gv/ptVJhxcarbS3GfNKWNaxGxf4P0CuQG7G0DdIXeHqlwQpwfI6H7
 BLlPxVMt3PbwGAwNufv6Xczu/xQtSc0/S4eT/v9p3jJ4mPL2NgNycJ8lCHqie44J8XozWmJ2RBi
 /plvQCOoX+d+XhV6e2Dxk1fUSkk87+PhUhn/ln5nhUQisVBPFOr214m/lQsJW4cVSboBM4calgO
 uk8KwcLw==
X-Google-Smtp-Source: AGHT+IFDnUFYsi8/vEvVSQu6X/ITolen/ymxIKDo4hkCOc4Di111PCDkuNVzkf1RucXQnbS3Ow0CUQ==
X-Received: by 2002:a05:6402:5cb:b0:607:5af9:19b6 with SMTP id
 4fb4d7f45d1cf-60846875435mr528462a12.15.1749588099593; 
 Tue, 10 Jun 2025 13:41:39 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2cbf-5d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2cbf:5d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607783de2bcsm6521847a12.68.2025.06.10.13.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 13:41:39 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/5] hw: Fix type constant for DTB files
Date: Tue, 10 Jun 2025 22:41:27 +0200
Message-ID: <20250610204131.2862-2-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610204131.2862-1-shentey@gmail.com>
References: <20250610204131.2862-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit fcb1ad456c58 ("system/datadir: Add new type constant for DTB files")
introduced a new type constant for DTB files and converted the boards with
bundled device trees to use it. Convert the other boards for consistency.

Fixes: fcb1ad456c58 ("system/datadir: Add new type constant for DTB files")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/boot.c | 2 +-
 hw/ppc/e500.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 79afb51b8a..64040504a1 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -527,7 +527,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
 
     if (binfo->dtb_filename) {
         char *filename;
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, binfo->dtb_filename);
+        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
             fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
             goto fail;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 809078a2c3..69fe71ad39 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -411,7 +411,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
 
     if (dtb_file) {
         char *filename;
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_file);
+        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, dtb_file);
         if (!filename) {
             goto out;
         }
-- 
2.49.0



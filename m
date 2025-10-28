Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592CFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeYp-0008Qv-CF; Tue, 28 Oct 2025 03:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeYY-0008M2-OL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:55:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeYT-00085g-Cp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:55:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so4007346f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638138; x=1762242938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgrlwEbBbokECIQjMQOcgQT5HbEwcbI2kgxYyH9CUJg=;
 b=mlQNaLGOHlQV70Y0dElWB6LsU3ImIFd4+iBYH4WsLs4LmgxUWp2mM2vP69xFrvtB6B
 2X8XVp2myOCV+u/8+DKbOJu2gOnpiyk17aDm3e/wzrwd6imwhqXzCpJ1RcyNpXab5eLR
 MxaAWSXxjylLk0CwER3It6JlBtcWjEfbJhVRHq7z+vtgwccGpxQTBNVyJ2oUs0Lti8JR
 jigOMFwVNeKsGovj12zLnEU6HCY5OP5Bd5EIdBc0qzkeU6ZUOSseb0Vv9XgTscO7OwGF
 7TE0hA5qUg9/GpfRndilB9hN5hjiSxsliol2MA/sLn7QFZO1rKktEJd4cvV0Njohrqqd
 Gwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638138; x=1762242938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgrlwEbBbokECIQjMQOcgQT5HbEwcbI2kgxYyH9CUJg=;
 b=MpzR+AzDZYjVh/MoSVZaG/BPbV5Dw3aCL9p8vhgLCpYdu064SkZnkq9ftQWpYfbMtp
 yb3wXCa9pWUub95I8KKH43JyG/DFWEiKoSuS5TGCeC8zN0QS3qoJFSoDRl7O2AGB+wzl
 LkHVrRstsi8ApbfGmKLkNkjRuDfl6x80fDx+lCc5ocRtewrIlBlXbaeuM/WMBx2YbEsq
 LRGmDJaePSx47jRWcaxEDcwd9qSvj/4r0WqeQbKH1gpwBKZkPzxRERQh+JxSFGazMB4t
 UrfAQxz7Parp4B6TdVRACFtSrbJY97KNFam9MH+vlVWUhizg7BJy068MFagKg6VCPBnl
 c94Q==
X-Gm-Message-State: AOJu0Yx5iezEVsArtxLIwNNteiKuwYF9bhb8Sdxzj8Eb91Cex5XTmuO7
 tv+5NTW5wR9nDsXfXrKyN1WGOzVLEbbS3leHyWMQdsYz7a/6gcgeL3RFfgD/839xMmK1kVjOb/K
 1tcHFBss=
X-Gm-Gg: ASbGncviNk02K4IrR+JAKq2FVCUltkLWbChtzvF3nYbjL823MczudkMe7KMHev/KGQ7
 RgIXOUMtc1/rZJcKkrAUcU7Pw1kHgi7HcR1XuSkmBsCfbXib7bsiggEZ+RI+D3mCrj29twbtuYP
 GkCwRjd3wG4HOBE/fwLjBeKQlJdobWm0wHNBiqM3gG9AODnubMRGNJyWFL2iEQxTKRFqhRitIjj
 gCfTF6m+zAbVV4Nhm7KLt6fekcgUM8Ozw8CRjklu3k97DCxu1xMudezdMa6Ws7n+e9ivBNSejeg
 5Vk7dQSzVBnH1412nMzI1MaGkqzkt0jXCmUA0CZoQX2BqICuS/WRwtJd20dEoqxOiXXM9R+Jqvz
 57xtGzmM2ejO9RT3XUO5NC+vBg1lBe0cfsYozeEBdYD//33CHefRn1oD2R1pKDGPO/z5E48ymop
 dbqYTK7R6gBH8gFYNZmIAyz4WIZYutIvgkjNQBAKtyHtjFnLFMZdziICk=
X-Google-Smtp-Source: AGHT+IFbgGzFCmXQ3PmafVjqqWU2YpxDA8CadyM82dzrVzpgLvIeSbYa9R0HbfYVxfRgtPGZLE9AxQ==
X-Received: by 2002:a05:6000:26d0:b0:426:d53a:fbb6 with SMTP id
 ffacd0b85a97d-429a7e75edbmr1958133f8f.31.1761638138265; 
 Tue, 28 Oct 2025 00:55:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca979sm19241887f8f.14.2025.10.28.00.55.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:55:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 18/23] hw/core/loader: Pass errp to load_image_targphys_as()
Date: Tue, 28 Oct 2025 08:48:54 +0100
Message-ID: <20251028074901.22062-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Pass errp to load_image_targphys_as() in generic-loader and
guest-loader to capture detailed error information from the
loader functions.

Use error_prepend() instead of error_setg() to preserve the
underlying error details while adding context about which image
failed to load.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <20251024130556.1942835-12-vishalc@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/generic-loader.c | 4 ++--
 hw/core/guest-loader.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 6689847c33f..433efb73872 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -149,13 +149,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
             size = load_image_targphys_as(s->file, s->addr,
-                    current_machine->ram_size, as, NULL);
+                    current_machine->ram_size, as, errp);
         } else {
             s->addr = entry;
         }
 
         if (size < 0) {
-            error_setg(errp, "Cannot load specified image %s", s->file);
+            error_prepend(errp, "Cannot load specified image %s: ", s->file);
             return;
         }
     }
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 59f325ad9c5..618455e5566 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -101,9 +101,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
 
     /* Default to the maximum size being the machine's ram size */
     size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
-                                  NULL, NULL);
+                                  NULL, errp);
     if (size < 0) {
-        error_setg(errp, "Cannot load specified image %s", file);
+        error_prepend(errp, "Cannot load specified image %s: ", file);
         return;
     }
 
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B8BC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYnb-0001VF-VB; Thu, 01 May 2025 14:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmr-0008BR-Tz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:37 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmo-000874-FJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:31 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso45849139f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124649; x=1746729449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oEZ8pcFL0QpEheuXUBBXfN5IHyToSd/0wmZn4AbYIQ=;
 b=fGaBVytxzxAuWA9JvLK6PXvZVoQdxLdKxrgwDbWtso+ixf8RN85HORsPEdJPZU36ic
 FexaJt6Ij82KkHHis0cCnQVplna9XmcgJ4D9x/X/wH6+HdYA7NCR6GJdk44o2CUGMtdd
 Rbe2QTcr0qb0gTCJqFYapP7Ux2eVB92NVyh3LmmGXpmInRboJPpbkjSzamXrmcMTgI+s
 SVMd4M/sCwLKW6bJATVEhOh48M+1Eaq1rlhOkm98Bx4cdKdEi2GV8N4R8uuhWM3pgs0m
 DXOZZaA5y68zxPxfvnBFx06le9tUWE9NFEov69f60E5cLBk0TfZBraURGZWu+fgwOjvH
 bssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124649; x=1746729449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oEZ8pcFL0QpEheuXUBBXfN5IHyToSd/0wmZn4AbYIQ=;
 b=kjnspykLXqipZCLVzciGMVEN2i5dnCvQDm1WbF8/lyoosXnBZx1mUnwmT2eUzZOc65
 Sr4twLYUVjooVHLDJbXVILI9uYRkGKHhQCXcDl/ir0EaPR7UjbTSI2ROaFK7VzY0Zaro
 TfcCGoV8PVMdyNAblUAqnmX0zc5Djl9k9TRtqGr5D+eDDNzmDM95S01cFU1yxWkL7KGc
 L1FP7IRZsGO8LWtbkX5ImH4Pg1yQKCG0s75mZ9ep89AZVITieZFgvi+W4xOIupMBOF/b
 NSZIKBu6/Sej0RPAKjkP6kEZ/rD4B/7X+3nX+REK6j1d8MdAwhXydnsOgxKpw5G9hXTB
 U12g==
X-Gm-Message-State: AOJu0Yzmaa3asTYSbuBzqJergrRIFczvL+pm/8Wg1yQtwUxLUjcKErQ+
 C9Fr+dAvhGV9OxtN0ljqkx2o1QEwIW27xWcJcEhsPek7xepztTPOrMBPdXr6ofw6jPRW+JPVHVn
 h
X-Gm-Gg: ASbGncvehENs1Jnt4c/f8AVZE6EZwdKdSyuZImpXO82hGSjfFSqfDYzqEUGo0LJE3ag
 aJuOwJ4xdHCw/KnDaGdoPC5RIrvuwYrsgnQmPE4OTz4w2nM9gt4ghkr11TYLicXtz24qp92pWGp
 dgUbdxstgGiDnBQ/XMiYax19H4mex/KJJqmMax4yi5pvnMaUIoYZojfnsOBeAWrCylPMyygt7Kn
 4Z2xNPkK+/IfNkq+XOZtD1LY0zrqx8HfkrjYkTfjbC/cZP0NmSEB/UMBAWI4SsKMTNI350ucBYq
 NRb5qcEKAf1KHEwgUBzuMSTxAmQXDVkBgh+HzM0Mrl4FbJou26rTXtZ9+Or79EY40A/vohTNZSF
 nTmrgJT6eWv2+IUsGTRAJiOL0ZJMwmh8=
X-Google-Smtp-Source: AGHT+IHEoLmcU7pFCRgcEcxBtRCx1q/dYH/LtK4QVox6ESPbw8xzGEhMoWVUR6VP05yqT75tvB++yQ==
X-Received: by 2002:a05:6602:3890:b0:861:7d39:d4d3 with SMTP id
 ca18e2360f4ac-8669f967ce1mr37488939f.3.1746124648901; 
 Thu, 01 May 2025 11:37:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa32f7cbsm21510239f.28.2025.05.01.11.37.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:37:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 06/16] hw/core/machine: Remove hw_compat_2_6[] array
Date: Thu,  1 May 2025 20:36:18 +0200
Message-ID: <20250501183628.87479-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2a.google.com
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

The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
pc-i440fx-2.6 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5f1a0fb7e28..a881db8e7d6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -841,7 +841,4 @@ extern const size_t hw_compat_2_8_len;
 extern GlobalProperty hw_compat_2_7[];
 extern const size_t hw_compat_2_7_len;
 
-extern GlobalProperty hw_compat_2_6[];
-extern const size_t hw_compat_2_6_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e7001bf92cd..ce98820f277 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -275,14 +275,6 @@ GlobalProperty hw_compat_2_7[] = {
 };
 const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
 
-GlobalProperty hw_compat_2_6[] = {
-    { "virtio-mmio", "format_transport_address", "off" },
-    /* Optional because not all virtio-pci devices support legacy mode */
-    { "virtio-pci", "disable-modern", "on",  .optional = true },
-    { "virtio-pci", "disable-legacy", "off", .optional = true },
-};
-const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1



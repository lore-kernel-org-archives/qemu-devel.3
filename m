Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD694E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvzW-0004NE-VH; Wed, 04 Dec 2024 15:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyz-0003BE-Re
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:25 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyx-0003Ur-41
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434ab114753so1474975e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344101; x=1733948901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kCFZSFSFl2GPP7FnxAPq5KUTVvEzSw2EnjHpYSMwwc=;
 b=PTM+th+lByViOglR4dEWHAsKgVxSUueLcvOeIDvXbWY/hBirkZpWJ1wVQq379hpKbo
 4nxiSau9O0FOUN/WW5X14hI/zFEvUlHc77ORhJAdkrxfd0zr3bmlykv2C8JgooYyJnyG
 LWc8DXjyYigwQ7RuXmbk+CDLBiBb2O93pWnPZmpCVFNH0g0gtsu2s+ADdF71Vp3dC7vf
 ZvH1MO5DAlg1Tc3MaGmtrSg74qDEhVDcwWeSzvnXlYX4LC8EXG+LF/Bzd8PD0m1cHLgh
 r2dfqhh+QI0SXOncQGKSk4tcEz2k4Y1y7XRsYDgC9cDm9jRvkEFHijZRx7XNfxN0Gjnh
 85Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344101; x=1733948901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kCFZSFSFl2GPP7FnxAPq5KUTVvEzSw2EnjHpYSMwwc=;
 b=U4iIUF8hy2SjUexU1l/oKShqCirN+tCW0cUShx9HhoIZGpvNshZSn5Ncwg6lg2QpAm
 tamZuVaQP43Xjtg+WtG/sW1CSgkFYpnvc3pS+plzr+4D3ZZM3wU3WiGzVinyvUVZHhKL
 Kqz8sz1pDKy7DOms/PreGmWleZjplOu2Fd2ypT6dKfi0Rb/szTpeXfdyuL1XZ3gV+Nvv
 gZ0XLMXrQY4wwImsxcg4N1/HCaqE3L0zd676UBWKCI16gZDzA86Os1Qg4XBfZxG2mRa5
 JGpvmKhAMYw2MhML1Hf2U3JuUfhC/6SF1QljBxOszC8D7KVQyxnDKjz8hZa6HRd6n3xM
 vFGw==
X-Gm-Message-State: AOJu0YwEY/cLvVXYQ1q6mLKKkSIbhXi9ZukOrTE1hhM5eocW/+bhh4iP
 MeqGe6mXhBisNmlhVSJcyo2TvcXD8TGYk9gN4A9vymav27H+xgG0pQgB9s+PjVz5oYKzFsaB2am
 J
X-Gm-Gg: ASbGncvQtuh7sorJV2fAgHDoczeQNd2mk1Gv97qJ6wISF8YJfjGIfzDKPV9NenPRwIU
 sOC5s7K7GJkV63BVIG38ek7AozgrVMFQwGR+4/MZrrwl9RXrnhDmtAlNhkJYZlvFPAwFaNXMoa5
 IpM3qQ1uCS4PzjsVoV97+AemRHZLADpRUs51BKLWZFnykdPC1pdw7T29Ycr+PcuS7F4+W2K4BPC
 2oFV81g6oRke8eKO8OPW1GlhYzLcX1UiWmx3K+L7ysEI7OjjQaN9PmqQhGxRfcLy03mLgRlDmJ7
 BgPi/E12giJ7uGHZql9AFyud
X-Google-Smtp-Source: AGHT+IEwlcXEYWoNFtl7tKT/Gy5FK8B2HE1HWe0k/S+rt7y9oWPFjlOgO3uZdR7sqNHOrOJdTTGk0w==
X-Received: by 2002:a05:600c:4e8a:b0:426:616e:db8d with SMTP id
 5b1f17b1804b1-434d09c8d82mr70145375e9.15.1733344101212; 
 Wed, 04 Dec 2024 12:28:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b375sm36220955e9.9.2024.12.04.12.28.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:28:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/20] hw/core/generic-loader: Use cpu_datapath_is_big_endian()
Date: Wed,  4 Dec 2024 21:26:00 +0100
Message-ID: <20241204202602.58083-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Rather that using the binary endianness, use the vCPU one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/generic-loader.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index abdd4c08a38..7b3b5f06565 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -31,7 +31,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/tswap.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
 #include "hw/boards.h"
@@ -66,7 +65,6 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
 {
     GenericLoaderState *s = GENERIC_LOADER(dev);
     hwaddr entry;
-    int big_endian;
     ssize_t size = 0;
 
     s->set_pc = false;
@@ -134,14 +132,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         s->cpu = first_cpu;
     }
 
-    big_endian = qemu_binary_is_bigendian();
-
     if (s->file) {
         AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
 
         if (!s->force_raw) {
             size = load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL, NULL,
-                               NULL, big_endian, 0, 0, 0, as);
+                               NULL, cpu_datapath_is_big_endian(s->cpu),
+                               0, 0, 0, as);
 
             if (size < 0) {
                 size = load_uimage_as(s->file, &entry, NULL, NULL, NULL, NULL,
-- 
2.45.2



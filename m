Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoPD-0001Md-SR; Tue, 28 Oct 2025 14:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoOH-0000kY-Me
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:25:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoO2-0003GA-KM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:25:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47112a73785so40617095e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675933; x=1762280733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn83gNQMZpvVjlvYJUMJlHBXZNHdMQkO0M/7A+q+76Y=;
 b=CPEgcorJWuh5w4SU7dv13EhD9PMppxLRyO8RNI3Qt5sOY3iOmnhpQLv6TjtXG6E9Dp
 eMkcUw/TEVmMsZxwKb7lirnboaor1hdLYeu+5W1TPSfsDeG1eQd290GNgiXrDSBgm3cn
 pnQ1kCowibm3a41sY2i3sxRGx+6M2IScZauZhdjD+YthxbRd/y679TfuaasEYZNmMIK6
 Ba0hYYCutEfQEb5OWUrnCKsDD63PaLP1qJD3Ucl38j0LYAagPBR2576A4m6mR08nF04A
 e8y1BYzfHa7OfKKwDtgWAIBmjrlefZeOmNeOH2JWw8DijauR322hayi/hpAkcRr5chNF
 rVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675933; x=1762280733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tn83gNQMZpvVjlvYJUMJlHBXZNHdMQkO0M/7A+q+76Y=;
 b=RUQ2RlWa50LyQxGOFHMu5TSFyd1brQrKI/BLz4RtjF13t1itbEf3P0EUF01rF4SJhF
 uUp53ZPNoMY0F7XBiBLbZmIaKaiSwIQ1AnyMxdw8PHsSSv5WSdKxGhCe0ADqUXNKXj6U
 mbUXTmFWjJH/ZAsmIZHhIqvbyRIMV+Fj4WI2VDgoje0Uy8P/3icQy5lBukz9/9mlAezL
 g5lvyIUfsx+6VOccrPGMFNdjt8XyHIS0veLZYzB33GK/gAm0MUC5Dh02weGUYQtdT+kz
 TS2fRfyJr7SpIyRClAFUBZNBQbluV9lzMF6XieIiA9oJ9SHJeWf+DWYYeKEgjich+J3E
 T6Zg==
X-Gm-Message-State: AOJu0YwRuJmJB+AayMn95aUUv1KyRYyFNdPeMRr/b7AtVsikC8SHO9F9
 8mkAWqj5TRAS5MJgKjcOpllAxaf5SI1XAL5iv9UjY5H04fwaMSURhJZQEk8eTYJFhrLIfKsgMa/
 J0HMuiDQ=
X-Gm-Gg: ASbGncumoi2CrfgR2RqYtrasLdDUWd7TZgbfBSDBCy2SJ6yol+xsmRlfyGnkgY2nlXX
 ElaOt845834TNQlsR8He6PjWrf9c93UXu+dBTKbcjSrvmbpz7IXQEo9rTAjlQUgH3mfvvLCH660
 qzWpsncGPa6KJDHUKhQ09z9f9HhAf8HZh6lwKPtsoCnGzXDq6XUGqglzkPmJcSEBi7zwh358JVG
 KTORDohcdu1gny/t7zvCzl2qaLqyGnHbpxYqBTOx3cEp907rE1ehN/Q/MfdXowTbhIQCZ5Tgf5g
 k5yWkRquIX2WopscPwWAShYdJL+mvrZsSU4R2bnkIotkxMR8Opo5hA1yfNzypyl9tpb6vX8kPSS
 l4uFERnE5l6rAvGruAsD0hoaBT6T7Q5Nv+U5aBxSs4OKTNwVLC52EBAir8NArOCifjSsKP62k7V
 vXUZb/5wjStm5SyKnVBSRWp8gX9fdFeu8ppwlms7JVyjZ6x4go+w==
X-Google-Smtp-Source: AGHT+IH1ugfFe0oxceS0sC4ktUe81XxAtBXaff6IVRGZbXQOpQBQXV+FUBM+u54B1peIOrlXSRWN6w==
X-Received: by 2002:a05:600c:4683:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-4771e3aca51mr3030645e9.30.1761675933009; 
 Tue, 28 Oct 2025 11:25:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3c878fsm4355455e9.17.2025.10.28.11.25.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:25:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 12/25] migration/ram: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:46 +0100
Message-ID: <20251028181300.41475-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5eef2efc781..3330c102977 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3144,7 +3144,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
                 qemu_put_be64(f, block->page_size);
             }
             if (migrate_ignore_shared()) {
-                qemu_put_be64(f, block->mr->addr);
+                qemu_put_be64(f, memory_region_get_address(block->mr));
             }
 
             if (migrate_mapped_ram()) {
@@ -4190,11 +4190,12 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
     }
     if (migrate_ignore_shared()) {
         hwaddr addr = qemu_get_be64(f);
-        if (migrate_ram_is_ignored(block) &&
-            block->mr->addr != addr) {
+        hwaddr block_addr = memory_region_get_address(block->mr);
+
+        if (migrate_ram_is_ignored(block) && block_addr != addr) {
             error_report("Mismatched GPAs for block %s "
-                         "%" PRId64 "!= %" PRId64, block->idstr,
-                         (uint64_t)addr, (uint64_t)block->mr->addr);
+                         "0x" HWADDR_FMT_plx "!= 0x" HWADDR_FMT_plx,
+                         block->idstr, addr, block_addr);
             return -EINVAL;
         }
     }
-- 
2.51.0



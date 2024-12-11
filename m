Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B286FE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVkd-0002sb-T2; Wed, 11 Dec 2024 18:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkc-0002r2-8C
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:14 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkZ-0001uY-GU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso15702875e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958249; x=1734563049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KujEMlgf4sTtMREgvgm8kU4qI7hcBzQ7iBZYjiigW3U=;
 b=ehh76pDGgXM8krjWCraj4aZE3l+G3tJjdHms0Krkpg4Z2AmG2w1Euu3jAIHJfyio7Y
 H6x6XcItkMMWOkE4njc6fWdMXR6APW7YmCDLO1lAPQacUKy0/xqnvm8nEmU1t9xh8X0O
 nPsy6XCqimhDT68/bIpNDKw3kAIXIGITs8SFLdCEp28/Cen/OFQkJfKlhZzjT7iTogkS
 VkAodSjoK87YCo5TVoMgB8X4poR8jlX4Y7ipDTWt1QEZfqjk4fqWy1KaR6gLrcycnvC/
 52BRulV/gpxdDv2TL+9Hfv2uYDf42E7YXVfTe/xHCVe8AkA3uydKMpl5E2FP/QyvXUJv
 9HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958249; x=1734563049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KujEMlgf4sTtMREgvgm8kU4qI7hcBzQ7iBZYjiigW3U=;
 b=j/sbo7Zgn5R8IZl0NOsPpMgIWpdfUpNpv7vIpjMeS75amlCfzLkMe7JfQqHoHXJsFd
 UBAOwzVLEIIQmZSTwGcnVPYHNbIgu7I1BXWElkGOaW5E9y4RzM0pjXYUEz2/NCO9Uqr5
 V0+dTL6GXQGd0Fz9bWcTNz7XWQ+1eS0jyrXDkDFyq7Aa7OByZdZxGfBECliMnxrBB6NZ
 e6fOYhP+Fajyrhc1fvRsJR13OXpvnghzsGuYTeWvzcclRxtWFQuJ11F4AONbylV8CKTC
 iFHFsGA8DPCgzdeWCrdZ2t6A9alBQy75O9gBGzjnf8NZKKMg/GKiR1pnw49XHHfLfeA1
 NuIg==
X-Gm-Message-State: AOJu0Yw8ad8M5YOIoT4szE7uqDAcyPO5bk47JcUkmYEwdRIS43a3iilA
 G9MqtCzjlF1/Q0CXmL7/L3WxqFlFb8cI3ItkFA2278T4sOjJl5dDzds2fpY2eH3ZJyBTsdJU4wj
 J
X-Gm-Gg: ASbGncuFy2VyG+MX1cvEtAMhQ7BLtnmtmezV22B26wgvlQaNp+P/IXbi0v55Hs8rSJ8
 M8r9W/X0TS1y6IyKH3Ivvu1rdPJWS9JtzZdpieEStZ5pIRqQhiro/TrFGZ6FWUShRnkedC80JmY
 DEU7GxyQzLesgEWF59nK3EXSupQUXc0i/q7pT7h226THb5A3oaQrqGjYwOdFtZHjxo9ymaSvgXX
 VizBED/4Wi2EJHUDAO46jwuN9bCS565y8NVHM1gY4FnAvztbP0mzr4PSrM4bhhEZONlXL6eOgq1
 4jzl0LTzW7wygNrzrQRjRXyICbsuw/KXnw==
X-Google-Smtp-Source: AGHT+IGpwgPFHStTPt9kR8GQ8LspXiu9RplHxeBHemwtjTDX9Po+JLjAVa+bSKV6l4RW6UhjLeW7Jg==
X-Received: by 2002:a05:600c:5104:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-4362286383amr10729675e9.23.1733958249569; 
 Wed, 11 Dec 2024 15:04:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361ec75410sm22742245e9.1.2024.12.11.15.04.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/9] target/mips: Remove tswap() calls in semihosting
 uhi_fstat_cb()
Date: Thu, 12 Dec 2024 00:03:50 +0100
Message-ID: <20241211230357.97036-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
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

In preparation of heterogeneous emulation where cores with
different endianness can run concurrently, we need to remove
the tswap() calls -- which use a fixed per-binary endianness.

Get the endianness of the UHI CPU accessed using
mips_env_is_bigendian() and replace the tswap() calls
by bswap() ones when necessary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/mips-semi.c | 43 +++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/sysemu/mips-semi.c b/target/mips/tcg/sysemu/mips-semi.c
index 5ba06e95734..df0c3256d9e 100644
--- a/target/mips/tcg/sysemu/mips-semi.c
+++ b/target/mips/tcg/sysemu/mips-semi.c
@@ -168,6 +168,7 @@ static void uhi_fstat_cb(CPUState *cs, uint64_t ret, int err)
 
     if (!err) {
         CPUMIPSState *env = cpu_env(cs);
+        bool swap_needed = HOST_BIG_ENDIAN != mips_env_is_bigendian(env);
         target_ulong addr = env->active_tc.gpr[5];
         UHIStat *dst = lock_user(VERIFY_WRITE, addr, sizeof(UHIStat), 1);
         struct gdb_stat s;
@@ -179,19 +180,35 @@ static void uhi_fstat_cb(CPUState *cs, uint64_t ret, int err)
         memcpy(&s, dst, sizeof(struct gdb_stat));
         memset(dst, 0, sizeof(UHIStat));
 
-        dst->uhi_st_dev = tswap16(be32_to_cpu(s.gdb_st_dev));
-        dst->uhi_st_ino = tswap16(be32_to_cpu(s.gdb_st_ino));
-        dst->uhi_st_mode = tswap32(be32_to_cpu(s.gdb_st_mode));
-        dst->uhi_st_nlink = tswap16(be32_to_cpu(s.gdb_st_nlink));
-        dst->uhi_st_uid = tswap16(be32_to_cpu(s.gdb_st_uid));
-        dst->uhi_st_gid = tswap16(be32_to_cpu(s.gdb_st_gid));
-        dst->uhi_st_rdev = tswap16(be32_to_cpu(s.gdb_st_rdev));
-        dst->uhi_st_size = tswap64(be64_to_cpu(s.gdb_st_size));
-        dst->uhi_st_atime = tswap64(be32_to_cpu(s.gdb_st_atime));
-        dst->uhi_st_mtime = tswap64(be32_to_cpu(s.gdb_st_mtime));
-        dst->uhi_st_ctime = tswap64(be32_to_cpu(s.gdb_st_ctime));
-        dst->uhi_st_blksize = tswap64(be64_to_cpu(s.gdb_st_blksize));
-        dst->uhi_st_blocks = tswap64(be64_to_cpu(s.gdb_st_blocks));
+        dst->uhi_st_dev = be32_to_cpu(s.gdb_st_dev);
+        dst->uhi_st_ino = be32_to_cpu(s.gdb_st_ino);
+        dst->uhi_st_mode = be32_to_cpu(s.gdb_st_mode);
+        dst->uhi_st_nlink = be32_to_cpu(s.gdb_st_nlink);
+        dst->uhi_st_uid = be32_to_cpu(s.gdb_st_uid);
+        dst->uhi_st_gid = be32_to_cpu(s.gdb_st_gid);
+        dst->uhi_st_rdev = be32_to_cpu(s.gdb_st_rdev);
+        dst->uhi_st_size = be64_to_cpu(s.gdb_st_size);
+        dst->uhi_st_atime = be32_to_cpu(s.gdb_st_atime);
+        dst->uhi_st_mtime = be32_to_cpu(s.gdb_st_mtime);
+        dst->uhi_st_ctime = be32_to_cpu(s.gdb_st_ctime);
+        dst->uhi_st_blksize = be64_to_cpu(s.gdb_st_blksize);
+        dst->uhi_st_blocks = be64_to_cpu(s.gdb_st_blocks);
+
+        if (swap_needed) {
+            dst->uhi_st_dev = bswap16(dst->uhi_st_dev);
+            dst->uhi_st_ino = bswap16(dst->uhi_st_ino);
+            dst->uhi_st_mode = bswap32(dst->uhi_st_mode);
+            dst->uhi_st_nlink = bswap16(dst->uhi_st_nlink);
+            dst->uhi_st_uid = bswap16(dst->uhi_st_uid);
+            dst->uhi_st_gid = bswap16(dst->uhi_st_gid);
+            dst->uhi_st_rdev = bswap16(dst->uhi_st_rdev);
+            dst->uhi_st_size = bswap64(dst->uhi_st_size);
+            dst->uhi_st_atime = bswap64(dst->uhi_st_atime);
+            dst->uhi_st_mtime = bswap64(dst->uhi_st_mtime);
+            dst->uhi_st_ctime = bswap64(dst->uhi_st_ctime);
+            dst->uhi_st_blksize = bswap64(dst->uhi_st_blksize);
+            dst->uhi_st_blocks = bswap64(dst->uhi_st_blocks);
+        }
 
         unlock_user(dst, addr, sizeof(UHIStat));
     }
-- 
2.45.2



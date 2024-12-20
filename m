Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDE9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjZ-00069f-8w; Fri, 20 Dec 2024 11:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjL-0005f2-5G
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:59 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjJ-0008KT-GX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:58 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so1204198f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711596; x=1735316396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1In5cayO/LMZjpWETtQH5XaVeJd9OQ0Fn1IjalaEyKs=;
 b=hJxe8724WGwv/0mQKH75KE4KZqD+wo29A7LtRLbnNtyiN/QRmFg68tNCXPw9QuNbWE
 CTq7DuUrbig9Apxudxk6HVwbfiS3RgYXnjVvwJKXCV2+DomDlzvJtymS8neHIOrfins1
 0q3HHQpjZT26SlUW0sl6UxtxPPE98X8ZzzlHHiF5DWMk7jOVtHj8D7mxXmyyc0tLSkSz
 X5kk7omP4aLBYSaENISpuBW0Ij/+V7CRBEePCtWlAOJDnbkJpXRI/PfR7FVIhyyB1l5Y
 Ykmro5iYCRojwWGd1F86EWTOwVJz6iGSYr9J4xS5HDYPpkYMUZV8Kl+dXDQwMnWKqgTP
 y/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711596; x=1735316396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1In5cayO/LMZjpWETtQH5XaVeJd9OQ0Fn1IjalaEyKs=;
 b=GGveghuEuwWdEH/YyO5QoUgnR7UVk7kQ14Z7aEyYOitHvoLtGWRqP2n/hEzQ/CkTRN
 YATp3y1xQMJt3Y9lsCunzSxHjBucNoTET/qAo5wkogqUuCP8FooxcfHmpuPBqvq/ngEM
 wZSr7LBWLGMUc+ID6XtxWxaHxh/6VXW8EEyWKge3m/qEakIzOiPPk2PetM6koafaaDyl
 8tpewKnSxVlt/USv0teXxwUkkuN56pF0XpNOL7QCUNgAjV3XxNj5xazwD++1zLAZdsOm
 I6212ZUjvDhFmd8jY0L0Shqqrzi7XPaUdVP4MI2afRzB5BiDC2Ru+r43OCCrk7ktrtO5
 Ll1w==
X-Gm-Message-State: AOJu0YxJ85iE7YedqjszRnAu9bZSBoUMrMSsRQfwIynKCwxVMI2ErHYD
 GGmfGMo092m+WZGq1M9GPWgFBczuivrDVhKh4XpU9qsa+GfvcotfcQrZWIA9PJfeCgnFJvlgPr3
 R
X-Gm-Gg: ASbGncsvS9RR+OyHyyGRvWAinN6jkiBmt7W2ZQE0fb2/9Et0QsuWVLI+Tj1d4fn1Hs3
 3VVJIGBaRfdLFcPFf+WTautxLffCbhXqWV+i/FTGPsK4xYg/l+C5AKWzBnqMqrG6mN0dMY3BG6j
 W7jLaF7E9eRgRKV24Pbkgz37DMlRY22FboDkfajMNkz+t6idRRuqVNJ3qO5ELOWYE8PodBF+bSA
 Sbyf37RVaykylbOtshAWkLSmdXp/LBNW8Q+gIJDSdAB4nEd6/ZCODvrsUhv3lWKTIju0jtoG2E=
X-Google-Smtp-Source: AGHT+IGMUNKYM2H0pLwF+nDzEwdT7aItAN6JHqeTk1UwMix6R7mr+k2gghYFzF1b967VkshHJre3iQ==
X-Received: by 2002:a5d:59a7:0:b0:385:ec6e:e899 with SMTP id
 ffacd0b85a97d-38a22404cbbmr3353099f8f.59.1734711595784; 
 Fri, 20 Dec 2024 08:19:55 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4fcsm50358315e9.29.2024.12.20.08.19.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 53/59] target/mips: Remove tswap() calls in semihosting
 uhi_fstat_cb()
Date: Fri, 20 Dec 2024 17:15:44 +0100
Message-ID: <20241220161551.89317-54-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

In preparation of heterogeneous emulation where cores with
different endianness can run concurrently, we need to remove
the tswap() calls -- which use a fixed per-binary endianness.

Get the endianness of the UHI CPU accessed using
mips_env_is_bigendian() and replace the tswap() calls
by bswap() ones when necessary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241211230357.97036-3-philmd@linaro.org>
---
 target/mips/tcg/system/mips-semi.c | 43 +++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/system/mips-semi.c b/target/mips/tcg/system/mips-semi.c
index 5ba06e95734..df0c3256d9e 100644
--- a/target/mips/tcg/system/mips-semi.c
+++ b/target/mips/tcg/system/mips-semi.c
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
2.47.1



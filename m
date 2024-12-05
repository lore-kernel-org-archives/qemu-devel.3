Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675A4E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJL2R-0004Bg-0z; Thu, 05 Dec 2024 18:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJL2O-0004BP-Hp
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:13:36 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJL2M-0007wa-RQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:13:36 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e1f3f2a6so817197f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733440412; x=1734045212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SpWmrA6pYUisS3cjoJ5FeJTUyFujydgI2lRzcjX7Exk=;
 b=EvFwcOKedHfhmSj69bWutxk91Qv832P5DWW1ggRoKOfi67oT4cpw78DsfOHVs6UE4U
 OviLUfxx0L+oniLUU+RW4p4OrbieFBK4s5H3UbxXaHyJePtR2N2O3MuVj4wYRZO2R3+4
 sr9q5qEcNyanMUp5BmwxZJP3oeD2O5oIGbckYHu/MzaahdBwSEyASf4qdJ7SGlkiOXi1
 PTq7fQOn81J82ij/S2KknnH2IOMFmN32fCmj1jP2oNGQy8iIGVyRI6Jb+UAH/Xxg0nbU
 gKnblxbG6L0PiTSh4ENuLtPrvd23tDpFMLVQWyXu6craeoWa9sGGT9MleAd1l7bjBQQH
 xt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733440412; x=1734045212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpWmrA6pYUisS3cjoJ5FeJTUyFujydgI2lRzcjX7Exk=;
 b=I4qmkqZF1SPubCKvyLh7OaviQ1JHnrOrMSruW5MPqdaM3EFvhwV7bcEN7KhkEQc6z3
 SPlpU0d+5wmhRhF2jhHLU4u0EbDGo2Wm37Kvs5EoU7obxXN8PLXw8TQMjByahxwCrSW7
 zVFTU026mdJdwRRQv9xFsnjyfimelYELhUtVQLR9zugf8wkWrk6/yyWkDYNGwJZt8Db0
 luni3w+TLOCB6gbbLVqY9W8/CexxhpDqgh/cLzrXZbvZZTFAs+BfraZqYF0dmk6i7iTt
 WGX/AwZYNiRtDAW4L2nlZeR6rA+f7jU6WQpyMCgTJ2ds8mL2+2UrhFyy6DuoQG0qTQ/g
 DDhQ==
X-Gm-Message-State: AOJu0YzHJ8NG2k/D/v70m+heW8qpfDhXhxijC8opg73YS3uiGmXmF1n+
 REI0KMGO+H7CwhBS3ME+DDmOT2FoLYPu2bOv0MPv80bM3I4O2YA9FMvZaiXrbUM6YfpdrQs5t5/
 D
X-Gm-Gg: ASbGncuJOP/Pm5sWjoSLS5bDnmI0qGoaYoerHQIWl/Gj/3iAvLLVMnIS12j+FNHkEP0
 qFSCfXGwjsXa9tFyuTP0r0e4qif/PZeEBlHHi7vS8rQz3Fp94Rs+bj6zhdHajweLrWX7cVVDiV6
 XWZK+XLUFRfntL7/5QF9OgWUq2WPgKt8beoY5fqKxrodpF1EoFg0XW4TnSzvNaXtUaiIpABqjfZ
 WT26PfK0bvPRYUveueQCUsR3VCMAvCLdkNLZopoguRP14/kSxLxMZ8bXVmdS2+yPfw6stwBuRip
 9rYxA49T6ebRJHmOzxJt3+8S
X-Google-Smtp-Source: AGHT+IGTebN8K4J09B4cKVcmgE2TPGweOW9yXSubGu0bsd2P2YSZ7jAJjU3KhSDKmoFAFumWXLiNEg==
X-Received: by 2002:a05:6000:2a02:b0:385:f6b9:e750 with SMTP id
 ffacd0b85a97d-3862b33bfacmr573292f8f.9.1733440412333; 
 Thu, 05 Dec 2024 15:13:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386221a5eadsm3096629f8f.104.2024.12.05.15.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Dec 2024 15:13:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH] target/mips: Remove tswap() calls in semihosting
 uhi_fstat_cb()
Date: Fri,  6 Dec 2024 00:13:30 +0100
Message-ID: <20241205231330.82355-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/mips-semi.c | 43 +++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/sysemu/mips-semi.c b/target/mips/tcg/sysemu/mips-semi.c
index 5ba06e95734..66a0de6b700 100644
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
+            bswap16s((uint16_t *)&dst->uhi_st_dev);
+            bswap16s(&dst->uhi_st_ino);
+            bswap32s(&dst->uhi_st_mode);
+            bswap16s(&dst->uhi_st_nlink);
+            bswap16s(&dst->uhi_st_uid);
+            bswap16s(&dst->uhi_st_gid);
+            bswap16s((uint16_t *)&dst->uhi_st_rdev);
+            bswap64s(&dst->uhi_st_size);
+            bswap64s(&dst->uhi_st_atime);
+            bswap64s(&dst->uhi_st_mtime);
+            bswap64s(&dst->uhi_st_ctime);
+            bswap64s(&dst->uhi_st_blksize);
+            bswap64s(&dst->uhi_st_blocks);
+        }
 
         unlock_user(dst, addr, sizeof(UHIStat));
     }
-- 
2.45.2



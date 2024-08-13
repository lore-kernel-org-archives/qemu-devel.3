Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36AFC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdo7T-0007Xx-HA; Tue, 13 Aug 2024 05:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdo7O-0007Wj-8W
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:47:07 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdo7M-0001EC-8W
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:47:06 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb5e0b020eso4084066a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723542422; x=1724147222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+O6tEfQz5lUPeGvFYdt3re9qjwA4R55lMLBHq/WO0OE=;
 b=QOH0tPjm6ulWxs0MFSjc2jHZS0HlB80bWRpjzICc3CCay2lhWSEZQDplbLwSR00cHb
 XEOPN/4DvdcDxCHSd4ChAG5CCwqSFsaOFXtw2XeAZIEv0Ih7mkmYsRzKxW6HBted9cPt
 RFZ2kSp8h4qvOTABMilIwXQgbxLZRqbOh98wQ3IJFKV9WGqPhjYvTi/RZUZB0217CTdk
 J6Qea8Iyrf6hrZd4KY5BzpVp+o+iGYp6BssSpThF+szt8PzX1sAFTTCmrSiyy5AgIUWG
 etnDBjEYUpx8syut1dwQcn/xzFERXwx4jP5mgY8EnLNGzVWOwYAQcjNmi9P/WoZ4LU1C
 UZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723542422; x=1724147222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+O6tEfQz5lUPeGvFYdt3re9qjwA4R55lMLBHq/WO0OE=;
 b=ALiNZqacSjqjPdUhaXO+jEKf20aiZ2CnU6MK5KJ7NWDEz//NPIDNnhcoWuj/cDoIAF
 2A99UaQv4ZdXc/LqeYsr8tm3xhL+iCedN40FW5X4OAQ7etyvTqkgO6rmAMtBuAg6mnVL
 5iiUzGVQgs1xtcPoD00EVLLok6DRPEGTBON0PkyOe72WciiSR54BKThwy0sTInJoUPCR
 49BXVUCMZ3xgBnWqyrrlu5yxCHRAdQcgxjLOyA6bsqtVUtj7rPyUrbBHtrPwVejWePlj
 vmv2atHVRTzwBO3qGzfxClvyXRw2atY/gSkJ2+DmyqGmpg7myNNyKFNlad+2rIuSCIas
 olOw==
X-Gm-Message-State: AOJu0Yy0i00USh25nnHhZUEEJgJ0+HvYobGdbuds41VuBsATlSXAHysJ
 QS7n3bneMsZqvp78Dk34OzPkZh523Hyi7M1NTqz3hEZvaMn+KrPqGkE/0cFh5uc1i/ANluxtl2z
 Sv4s=
X-Google-Smtp-Source: AGHT+IHAVj81WnOVBpXmwzETfNPUF1KfNnB+MoOdNVjqNvkNtPaV038Jh4wH7X41VPECybMtLQlWkw==
X-Received: by 2002:a17:90b:b05:b0:2ca:5a46:cbc8 with SMTP id
 98e67ed59e1d1-2d39265245dmr3356282a91.26.1723542422050; 
 Tue, 13 Aug 2024 02:47:02 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9c9d745sm9968126a91.28.2024.08.13.02.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 02:47:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH for-9.1] linux-user: Preserve NULL hit in target_mmap
 subroutines
Date: Tue, 13 Aug 2024 19:46:54 +1000
Message-ID: <20240813094654.306430-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Do not pass guest_base to the host mmap instead of zero hint.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2353
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4d09a72fad..6418e811f6 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -560,9 +560,13 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
                             int host_prot, int flags, int page_flags,
                             int fd, off_t offset)
 {
-    void *p, *want_p = g2h_untagged(start);
+    void *p, *want_p = NULL;
     abi_ulong last;
 
+    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        want_p = g2h_untagged(start);
+    }
+
     p = mmap(want_p, len, host_prot, flags, fd, offset);
     if (p == MAP_FAILED) {
         return -1;
@@ -610,11 +614,15 @@ static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
                             int mmap_flags, int page_flags, int fd,
                             off_t offset, int host_page_size)
 {
-    void *p, *want_p = g2h_untagged(start);
+    void *p, *want_p = NULL;
     off_t fileend_adj = 0;
     int flags = mmap_flags;
     abi_ulong last, pass_last;
 
+    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        want_p = g2h_untagged(start);
+    }
+
     if (!(flags & MAP_ANONYMOUS)) {
         struct stat sb;
 
@@ -740,12 +748,16 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
                             int flags, int page_flags, int fd,
                             off_t offset, int host_page_size)
 {
-    void *p, *want_p = g2h_untagged(start);
+    void *p, *want_p = NULL;
     off_t host_offset = offset & -host_page_size;
     abi_ulong last, real_start, real_last;
     bool misaligned_offset = false;
     size_t host_len;
 
+    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+        want_p = g2h_untagged(start);
+    }
+
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         /*
          * Adjust the offset to something representable on the host.
-- 
2.43.0



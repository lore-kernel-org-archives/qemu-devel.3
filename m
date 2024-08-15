Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E18C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 01:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seOwk-0006AL-Uq; Wed, 14 Aug 2024 21:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOwN-0005yr-Uk
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 21:06:14 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOwI-0003S7-F5
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 21:06:08 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7bb75419123so437717a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 18:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723683965; x=1724288765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+O6tEfQz5lUPeGvFYdt3re9qjwA4R55lMLBHq/WO0OE=;
 b=Cx3vdN45dclVWn0S4nDHLCdGCbb8ADcx4DlHBz53F9ZmDff/WMnsR1XIONmCEEKtXg
 E/0xPCKLuXuaeOuLv8sJ2n/xsvOx0sgKLUKMHXwLYYEf0WfRatp4l5xQnONToezf8+Ia
 +2srvJ9sAZsQPn91WAg9ba+jgBiHzL+H1aMpYW+9o3zG60ik7iDuIFNf4mjmdx9c9NUr
 xb6+Q4ENv5VHuiMqGJ3C0lHxGGN0IHh6LHyWQP94m9FhFmpcOlADLbo7HmQOfWYVH8Ro
 YpRnrIBBtX54PAz3R63H/TpVuQNQad0EIKcY87j0X2aVFzdU2spWf0V6camu4T4/+VFl
 PxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723683965; x=1724288765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+O6tEfQz5lUPeGvFYdt3re9qjwA4R55lMLBHq/WO0OE=;
 b=LtNBt/WHZjpXaMYnd6WviAnoQo+bnJQqZKt9kYd+kqrjy9/7yB5V1VeYZ9ZfaH8q2/
 Gl6wMXftV/TMgZXi6pDLp0WcEAGZrwz56hKU1AJOHbpvYWZ32v9m20haQgtU2FtFn1Gb
 pgbPlaUQP/s8EKFb3+/il982xc2VVVXTTyFJclJU6cIINGWocBhs5kTquUzU1LyjWRxF
 2VTLvZkR6x/usAHhPLB3HqTPiMfBMF0+bnvfti2BNgq/IEQvcdYlL+pK6aV6Z9aDc6ht
 GlE50Hoaow4qByZexgO1+zdg2JfiMf03CmVodATvmBUVTiOFw06fK3neXCYw/HHFhU31
 7TIw==
X-Gm-Message-State: AOJu0YzeM/Fb4mWO7yQhOcRM90MptYvA3dOQGlUAvg+8vz2j5n7ezcUI
 dMF8/PwhemGSnJsklWbXmIOojT8BPatKLe0Sjru96oic8ZIVvVanfaVyBEyChsqw5pWnJTQwuKf
 E
X-Google-Smtp-Source: AGHT+IH5Bz3i3yJtiZTSqgq9q4NUtBuE4T1IXiAcPuoJNzP2KyzLalHSM03laC+l/1dBPv3VKL2ggQ==
X-Received: by 2002:a05:6a20:d493:b0:1c4:9e5f:c645 with SMTP id
 adf61e73a8af0-1c8eaf54179mr5900839637.40.1723683964474; 
 Wed, 14 Aug 2024 18:06:04 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1bd5asm179907b3a.177.2024.08.14.18.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 18:06:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 1/1] linux-user: Preserve NULL hit in target_mmap subroutines
Date: Thu, 15 Aug 2024 11:05:56 +1000
Message-ID: <20240815010556.535100-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815010556.535100-1-richard.henderson@linaro.org>
References: <20240815010556.535100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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



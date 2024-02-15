Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE95AC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV79-0002Pc-Oo; Thu, 15 Feb 2024 01:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV78-0002On-Bl
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:54 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV76-0005XP-OC
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:54 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so492088a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978051; x=1708582851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TGuf+a6g23AtWTGblDkFBLls1ueawrHAWFF+h5sCkhk=;
 b=tpR5nYOgElZM/Euo9/P6G6KR0BvQfyMiAElmNckxbSguAykYGJymFrjl9OazvABNlG
 8OR1HqatIENtX4BsRoEq4Woa8fM4o0M/SCY1lPT+8zJibjn1Ks0zcx9gsFgHV7hKNjDs
 Qyw7M4ieltW5HVdeMPsBhW8gMpxhZ23aZf2wJziVbrWaYp/iSPvAi9rNRo/lzo2YIiZs
 J+0ccheS5+I0S8QiqZidxmLKMz8fWKxXx0LVFtQ+Qd64OycVOtpStlVNgxj+SDwNGGN8
 Sfpy0rpPkTJQzRwZifTC+NDJZ9PTf/7UVkMSlWHNaG4O/ZCXPUG4nFvRCJJkPoImKsPN
 1AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978051; x=1708582851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGuf+a6g23AtWTGblDkFBLls1ueawrHAWFF+h5sCkhk=;
 b=pfkpvqlNNOZiOpCduHq9p9K56QeidXrkdtqqxi6brX0tpxkT8PpBwWJpyUBHZl3hZf
 fLmdROyY4WLkkHOgu0pn6wHe2s/VoIYv/3Wx3YK2wRwV0F+SfC4UONmLZPHUZgq1Xv95
 1RdfWR+YghXJ3UCrJgFoH1BcAWDoGd8evHODwwvK/JdtVWfHPgKS7XO+Ef8EQKm17R8b
 7cXy3i22dFhkTziBxfFVrWcjnpaemR3kCsB1MMkH5en1kEK1uamO0jmmS/QkxkIrZWuh
 h0dDF23Lu2TG8T0p8zG+N5ViRtvyZW0DNFaCC5wncTWpw8SIFmzraIjBbm9lV1pNvMSD
 2KQw==
X-Gm-Message-State: AOJu0Yw4mCclFaxx/OjnkMYaSO8zhRdSWc/nQiAFIdOanXclsFHhmpfL
 0cASvxfFoXDHdqSulAQEmJQxNywi2CpKg1MuAvhnknkigPm44eHsTHqc+04eJW6fN4/1b27IBMp
 T
X-Google-Smtp-Source: AGHT+IEJ1KApzmH9jMaxUJrkPwokrrmDKkKrOYjRiaBxJP8IQyz+nNqTXu7iObSSeUbGRWFwtqiEvQ==
X-Received: by 2002:a05:6a21:3416:b0:1a0:5841:6740 with SMTP id
 yn22-20020a056a21341600b001a058416740mr1061256pzb.14.1707978051409; 
 Wed, 14 Feb 2024 22:20:51 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 21/36] linux-user: Split out do_munmap
Date: Wed, 14 Feb 2024 20:20:03 -1000
Message-Id: <20240215062018.795056-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 1bbfeb25b1..8ebcca4444 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -267,6 +267,21 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     return ret;
 }
 
+/*
+ * Perform munmap on behalf of the target, with host parameters.
+ * If reserved_va, we must replace the memory reservation.
+ */
+static int do_munmap(void *addr, size_t len)
+{
+    if (reserved_va) {
+        void *ptr = mmap(addr, len, PROT_NONE,
+                         MAP_FIXED | MAP_ANONYMOUS
+                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+        return ptr == addr ? 0 : -1;
+    }
+    return munmap(addr, len);
+}
+
 /* map an incomplete host page */
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                       int prot, int flags, int fd, off_t offset)
@@ -854,13 +869,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
 
-    if (reserved_va) {
-        void *ptr = mmap(host_start, real_len, PROT_NONE,
-                         MAP_FIXED | MAP_ANONYMOUS
-                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-        return ptr == host_start ? 0 : -1;
-    }
-    return munmap(host_start, real_len);
+    return do_munmap(host_start, real_len);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
-- 
2.34.1



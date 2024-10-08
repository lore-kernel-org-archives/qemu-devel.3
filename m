Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0DECEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJb-0007Ty-Al; Tue, 08 Oct 2024 14:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJS-0007SS-Ry
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0002Uv-HA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71dfccba177so106955b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413516; x=1729018316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJRQrtWzEa9YTQ2bC834pCenIsD7NAkkm9NzR9qJJwA=;
 b=PLHn94Mm+y4Fxj5Aazz1O6vFvAgslRBtA2ONVvisPMaUt3O4ete3UBI8z+gyF447Dm
 FWQ+sF5gCOLbF56RNN676DrCAdo/lPZewDmNomdQHgIPb5GIVAeSCYNYv/iKmVpa3vJA
 S893x4yXMXgTZK+O5VOB8a2m1BIHlu7w/z2sS9c0q++598EN0Ufz4ne4JZBWmf3aVVhw
 AuAzyYMDYFvw/rBowYyar6nCPA75qqq72n/RW4a4PDEyhDJvLImDwaSGU1tWFgdsc/u1
 UBmGbP7qDM58GSpi3ms8i57LlFfWhdushvnM6kCO2hlTwM0iU2RvV+GZEXaNN1/d2/fG
 Vf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413516; x=1729018316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJRQrtWzEa9YTQ2bC834pCenIsD7NAkkm9NzR9qJJwA=;
 b=Gm0TpNHFVjM6XsFLRY8aZpLJfkMhSXYOZHGR9Ivyy5QyN1gj9+AFaNtD8MwelgAPRe
 grpkkJzbyL7bvYbya0Rlf9PvEYr3JTKLYxK7sWN1GKaDJkelTgEAATd1kw35lMQEWjC+
 DO686ge1lm1ZolEux6Y6+vyNauW2tW8GKIipOukYbw0JlOnRgJQrAUKs2cKlYuq+CEK3
 uw4QTQAQav7M7+up33UZB4VAtT9eJje8iC291vGJcTEHuLWVIwfrVfjANcli124BDJW9
 wGokAmd36yDo3p2FDtVJ9b4XEGgS02zC+F1lEaL39bnGoSK82kxGkQuweHRZ3lTyR35t
 UPDg==
X-Gm-Message-State: AOJu0Yz7+aBgCjUNIs+oHMf4Hs7vVuQGgt8NefcUYTmIZMgqirRWk1C/
 Xm1spuyjqu+GSLHeC89Lv0SMD7bEUZbLkL9omFOmFHgYC1edbJBweJ03EaxhbGu7sbkxLYv27B2
 q
X-Google-Smtp-Source: AGHT+IFSM2JMy4xQV8hjFbWk5BZRcLBltq18RwXan4F7UJwrjaeAh27rU2/U8OYuIKDzVaQ+3IFwPA==
X-Received: by 2002:a05:6a20:258a:b0:1d4:fb97:41b9 with SMTP id
 adf61e73a8af0-1d707459d68mr6414648637.22.1728413516302; 
 Tue, 08 Oct 2024 11:51:56 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/14] accel/tcg: Make page_set_flags() documentation public
Date: Tue,  8 Oct 2024 11:51:41 -0700
Message-ID: <20241008185141.20057-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit e505a063ba ("translate-all: Add assert_(memory|tb)_lock
annotations") states page_set_flags() is "public APIs and [is]
documented as needing them held for linux-user mode".
Document the prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240822095045.72643-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 13 +++++++++++++
 accel/tcg/user-exec.c  |  5 -----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 6f09b86e7f..45e6676938 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -166,7 +166,20 @@ typedef int (*walk_memory_regions_fn)(void *, target_ulong,
 int walk_memory_regions(void *, walk_memory_regions_fn);
 
 int page_get_flags(target_ulong address);
+
+/**
+ * page_set_flags:
+ * @start: first byte of range
+ * @last: last byte of range
+ * @flags: flags to set
+ * Context: holding mmap lock
+ *
+ * Modify the flags of a page and invalidate the code if necessary.
+ * The flag PAGE_WRITE_ORG is positioned automatically depending
+ * on PAGE_WRITE.  The mmap_lock should already be held.
+ */
 void page_set_flags(target_ulong start, target_ulong last, int flags);
+
 void page_reset_target_data(target_ulong start, target_ulong last);
 
 /**
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7ddc47b0ba..11b6d45e90 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -485,11 +485,6 @@ static bool pageflags_set_clear(target_ulong start, target_ulong last,
     return inval_tb;
 }
 
-/*
- * Modify the flags of a page and invalidate the code if necessary.
- * The flag PAGE_WRITE_ORG is positioned automatically depending
- * on PAGE_WRITE.  The mmap_lock should already be held.
- */
 void page_set_flags(target_ulong start, target_ulong last, int flags)
 {
     bool reset = false;
-- 
2.43.0



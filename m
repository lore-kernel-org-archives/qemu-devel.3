Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFBBC5321E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 09:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh4T8-0007Ao-TQ; Thu, 22 Aug 2024 05:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4T4-000787-Vf
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:50:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4T2-0001uE-LB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:50:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso4187365e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724320254; x=1724925054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0epmm+nCBqYd7cRlgUuUReUBppCgZRIHvF/VeKi9rI=;
 b=Zw+lXwTtHz+4x3h419f8WmyVJxIb3CI4dXEBqxVtWLvw+5WghrbqXxLX+wYj3Iw3p2
 JisetiM9cnq9K3bjpsJFeWGOpNstjv35fySZo6yrncQUuS7+WTNNqydVQt1pPSoh6SoT
 9GPsmKgSC9AR6p2uuIMVjZUy234OPf35G6SC6As3F5EvU4lqPTV+PH8t4Q9+9Y5b9iXr
 p9/2q08eAjU353c1NL7LRW2PgDrWB92aNDYUMQPXli8YkjJAkYnj/utVZ+Ct+vaJrKsT
 LsiEu63BnwNq7DTMppirGoRGs3EVDZHubLhIU2wbcHYtThFzOJcPnJEWE9i9xnVGr+B6
 qFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724320254; x=1724925054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0epmm+nCBqYd7cRlgUuUReUBppCgZRIHvF/VeKi9rI=;
 b=MuC0oqL/R5pTCFPFCO4KwjnrgagGW7qR13V+uRHviYK4RlpOae1jMoohM96bJnae4I
 PkXmPxmzniqkjOEL/6JUuFiL659JrSU31bbfeQcYZi/Z7S8uzsFIACaIf8qS+EtrMP4R
 laFGtdlu/ldzR4Qqz5G5jii/k7aXS7g3YJWk671Csh8Gapvx6OrnTpFhXFS3JMw+bQYn
 Fih7junszFoK/dCXtxbbyYC2kSxzHqH67jF2wh/xU7SagUFrP5YP+ennOzdAh1QD54ho
 6iu9SY1mE9XfhQVtVCI2ELdZHCBT2SywPxyQ8Za/8zLHOM4baX6hL77n26S56WRHC2En
 Pg8g==
X-Gm-Message-State: AOJu0Yz3B70YzUCSfyM4j5kfQtm63DB3skHlM9exfTxYp4UMotbkgzf4
 g0zmHj94PUhs6WF5fKzh1RcP74Ey5c3nBonXaun6HD8pFISpe9l1Cc5Sl2CbZHp/y12w9iscW4Y
 M
X-Google-Smtp-Source: AGHT+IEwmJ3lCCJr+zNgxahyMqJWUnAt1uYr5KiJRxXNaMGJYmLZz5nw55V3NlI+Z29FsLbSTKw3tA==
X-Received: by 2002:a05:600c:1911:b0:426:59fc:cdec with SMTP id
 5b1f17b1804b1-42abf065a48mr34862985e9.21.1724320254450; 
 Thu, 22 Aug 2024 02:50:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ff526sm1229242f8f.68.2024.08.22.02.50.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 02:50:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 1/4] accel/tcg: Make page_set_flags() documentation public
Date: Thu, 22 Aug 2024 11:50:42 +0200
Message-ID: <20240822095045.72643-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822095045.72643-1-philmd@linaro.org>
References: <20240822095045.72643-1-philmd@linaro.org>
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

Commit e505a063ba ("translate-all: Add assert_(memory|tb)_lock
annotations") states page_set_flags() is "public APIs and [is]
documented as needing them held for linux-user mode".
Document the prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.45.2



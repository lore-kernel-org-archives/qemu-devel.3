Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616C6C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6T-0007iN-SQ; Sat, 15 Feb 2025 19:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6K-0007eZ-6f
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6G-0006I7-RG
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220f4dd756eso30974835ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664086; x=1740268886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLskJS7NaQB4gx7iCFIleGp2eUUyNj3sDlYnjboU4bU=;
 b=jWBv824fIeNLyTXucb/O1HaH7jFYgwyIbs4ASkkgf9hQz88+IOKCDk9DDKgokd6kw7
 tKnkwYY5gAFjx8/O7GkveqztjnSOrgi4sLe/26h7hYLltuyTwwl+4yBrZ0T49pAlFGsB
 PnXW0pXXzWqE/qU3vja+ZHOrUSzt4wMXYxAA7qsPdaVKiZrwxHCgg0LXJ36FmAlZkP4A
 8gUbrfaxVuCe58S/OdXOD1VZItjj29F1xLv+/jDEJXSxBvfaIwFEe8Zsv8kOwcw/+NSI
 hh/FXmkOY9gDZGcK+pTbmT8dcQL7r63NbirnpRnusDuYRvYF54VV3lIS3JE+OsOitQtz
 KjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664086; x=1740268886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLskJS7NaQB4gx7iCFIleGp2eUUyNj3sDlYnjboU4bU=;
 b=BQxwqU8A/1ex5AyjvOcu7y10ORnwJFGROuHlehmCNpeDwdCkqbmQKq4tUA0S6MIFmK
 sHqPp6bFxVtSx+6AX8GQuY0m/oV6oXJs+OgyeUZWzDFPWewnehi4aKv+BdTXX4eCQdYN
 8gQE4xCmgsax+KnVUTsALosnwJ8FgConlNfcyy+hqxw9uQz/o9+plogLAO+hHiq7EkfN
 hXoeXnNXz/HtedojpxJr3JXyCKdtOyiQ2uOFVGgnml+LZ+2nSofcFnaV+X0lxdzmqjmj
 2GgNY2JEijQ2iSVHqTYLBAyJIVbZSWfubR9KQH2gpXAg/YYuutNc56CR2jyGFT5uAaCF
 8jRQ==
X-Gm-Message-State: AOJu0YykyDyZha4mg31Ke4LhhOwS5bpB6X52D4jdSVfFV7D9CUMzJeVe
 HFofVbPBU08/2sbs+XTxJhxabmGUaurjBkHV7UFNw5HmwYvlPC0eaZLzb9izQgOBrZNfgQa29CV
 h
X-Gm-Gg: ASbGncuR0O+YkhL3luCbi+7JEXofLixVjhcSS40pVuBUeq5Qa9jvVSB6znSPYKpgKFJ
 cJ+ykf1l43JOjyFjBqwmJUsAutOVuB0HAwwrW+wV+4C5dI9eTaAqYubaTfG2IMPIL3musJ34f/U
 OAVLTt02mlH0t81svzV9Uu3h5bf5V+XWHYG+NRfDMG9bdQTuYzSFRzuDV9MyTMMzTAuyVcX6aP+
 YWWRmkt6vvy9ra9IG8bHwo3pr/BhHd68QQn19DFqAKwov5Uj74ZZvuI7WHe+OVL7Q6juooaI3yZ
 1kgPbk6X9ouOnXHKBvhxAv8d7kboUDWMOWdFysQVWvjCjTM=
X-Google-Smtp-Source: AGHT+IHE7R5w2ZmAwwZwqF4WPcVfH2i4DZ9DLzoEsrSbgXWAt1ARAnQRAxOVcAhxLMSfzc9zrIK4iw==
X-Received: by 2002:a17:902:f64a:b0:21f:6c3:aefb with SMTP id
 d9443c01a7336-221040bd763mr83141795ad.35.1739664086205; 
 Sat, 15 Feb 2025 16:01:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Subject: [PULL 20/24] elfload: Fix alignment when unmapping excess reservation
Date: Sat, 15 Feb 2025 16:01:04 -0800
Message-ID: <20250216000109.2606518-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Fabiano Rosas <farosas@suse.de>

When complying with the alignment requested in the ELF and unmapping
the excess reservation, having align_end not aligned to the guest page
causes the unmap to be rejected by the alignment check at
target_munmap and later brk adjustments hit an EEXIST.

Fix by aligning the start of region to be unmapped.

Fixes: c81d1fafa6 ("linux-user: Honor elf alignment when placing images")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1913
Signed-off-by: Fabiano Rosas <farosas@suse.de>
[rth: Align load_end as well.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250213143558.10504-1-farosas@suse.de>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a2c152e5ad..8799e4ea27 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3351,8 +3351,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     if (align_size != reserve_size) {
         abi_ulong align_addr = ROUND_UP(load_addr, align);
-        abi_ulong align_end = align_addr + reserve_size;
-        abi_ulong load_end = load_addr + align_size;
+        abi_ulong align_end = TARGET_PAGE_ALIGN(align_addr + reserve_size);
+        abi_ulong load_end = TARGET_PAGE_ALIGN(load_addr + align_size);
 
         if (align_addr != load_addr) {
             target_munmap(load_addr, align_addr - load_addr);
-- 
2.43.0



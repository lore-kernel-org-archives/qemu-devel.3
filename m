Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AB9CCD183
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSZ-0003Xu-HE; Sat, 04 Oct 2025 03:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSY-0003Xm-Lq
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSV-0004th-Go
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so18352685e9.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562013; x=1760166813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xCQrduo7/+iK4zpfNHJPTgsOKa5mIO1xtZ1NhBqYm1g=;
 b=ncEpo0FZHCZnEDIgsiPWUTduSCr40zdS0LWNtF3LogYxoH8QsjsTnNERpV/Yta9tbN
 rjgz9S2ztBDTq80avrJjJclN8nClhUA00XO58pWKJ4paclURAAkiIHmUSGwva0uEHYxx
 kfbL0SuOjxOBzltdX0TLCDHmK7tu5hGaOyQc60GA/0D3cHczCcuHD5ssRXvfbexbve5B
 29axZEbuiQ5bLn+He21xVBneXo1jKj8mltVhKD34p8dR5eanCjED1mxeMJBM9r6ewcsF
 U8rhfOz50+g9BYECW6yXsE+NUyXATl527uv9WII1CSMZdBwheo7EJ9nx1nAMpYfxvtxv
 a89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562013; x=1760166813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCQrduo7/+iK4zpfNHJPTgsOKa5mIO1xtZ1NhBqYm1g=;
 b=nsAIBDkOAQUVx747Wukd8nCqKl0I1Cs+lxC5y1qtsfB40TIHfq0zKYXtOYSD2hGkpN
 MOvqe4HlXKHiYz2wjssEHFh3Ezv9HnWxD7Jk1r9hTExAN29UubfVmbSZ1I5hG76M4za9
 uZRQm5/ins99ef2hwrhAFGwcd7rmu2KhNysjKE7SjtCMsBxLUycIge1ENJGNt/gnknIC
 SvkQN1n0ugFkE2CA1iET9YrTD+x6aYe3UXJg5blBtACvgYWevAzOSiiQE9Kxg20LkmVd
 kDg9rTgBgpaO54DL7TcXzVPotnq7+zareXh5zxfYL9i1D4GPOkqerAtILjqWacjoIMQt
 pnRw==
X-Gm-Message-State: AOJu0Yx0MZaNbRM506MEvB7OcTpP+SFHQKI+GwUWjKRwMyrnTT5MzMuL
 urg8gi865cXTaEK74OjRkbNWlLh0C/IY6Lb4bnC9SeUucrh6PyJd1KH8rxghoij99PqT/8AP4ZP
 rtjV0MZu9Tw==
X-Gm-Gg: ASbGncueJxFGQAGHvtUCxYIA3YmelUvjDPg1smVifSRMHNljFMUmgzoDNSEj7MxndWN
 68fH58KBOFqKzKL+3GyJhs6MtlBXzbcDQARc7GSxb9tYxPVouvEfZ4emkoHk3/2sMqpcirhmYBG
 TBZi5kbRV9szMnrnY57U/rVDvXERqj1jbBUy0JYNUoRlG/9u2ygyintcAIW9eWd7h5EOSnY7Avf
 MrEFAtzgl6VaeLu2eyDAaAfNfzUToT4fNoQMTjCBnuZd/oOC738sAd0/l8BbPb5IupeOb+yHjUJ
 0jiZA7fmjakTdunAIeeNT/ymtiDWhm0uCamAMogEhLsl03tzlp5kLqheSZytw4sM9nxL4SCjZLA
 i0Ftgubui7Nj4F05vqvr51eUxA3fGdVge9wok4G6lMS9znLvpEHWBXhmSi5yM8+W9i6eYr/Yo4e
 9TxWBchDyoWYbNs4pQwWLZ3S28
X-Google-Smtp-Source: AGHT+IEgSRprfVNuZPy9H0U6WThriOYfmpywBAg40cUEuoFbpHUmEbKV6plVWksFLQwR6L5sXzYfSw==
X-Received: by 2002:a05:600c:8b71:b0:46e:36fa:6b40 with SMTP id
 5b1f17b1804b1-46e7113d33fmr38794235e9.24.1759562013162; 
 Sat, 04 Oct 2025 00:13:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab909sm10880945f8f.19.2025.10.04.00.13.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] system/ramblock: Move RAMBlock helpers out of
 "system/ram_addr.h"
Date: Sat,  4 Oct 2025 09:12:31 +0200
Message-ID: <20251004071307.37521-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20251002032812.26069-6-philmd@linaro.org>
---
 include/system/ram_addr.h | 11 -----------
 include/system/ramblock.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 53c0c8c3856..6b528338efc 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -80,17 +80,6 @@ static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
     return bitmap_test_and_clear(rb->clear_bmap, page >> shift, 1);
 }
 
-static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
-{
-    return (b && b->host && offset < b->used_length) ? true : false;
-}
-
-static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
-{
-    assert(offset_in_ramblock(block, offset));
-    return (char *)block->host + offset;
-}
-
 static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
                                                             RAMBlock *rb)
 {
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 85cceff6bce..76694fe1b5b 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -119,4 +119,15 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
  */
 bool ram_block_is_pmem(RAMBlock *rb);
 
+static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
+{
+    return b && b->host && (offset < b->used_length);
+}
+
+static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
+{
+    assert(offset_in_ramblock(block, offset));
+    return (char *)block->host + offset;
+}
+
 #endif
-- 
2.51.0



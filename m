Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996D3C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzF2r-0006Kg-Cm; Mon, 31 Mar 2025 09:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzF2n-0006Jb-Kr
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:19:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzF2m-00052m-0l
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:19:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227b650504fso89553645ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743427149; x=1744031949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYuLLevDThsIlhYiPwTOv7bRzn5s5UV46Vyannfxfao=;
 b=B+CXsHg6wGGsRfbtFTS/o8Emeasgd9XphpSXX4NJ22RvpJZzq0BLBsOWKM2GN8MEu7
 4r2yB0rVQ2Ce+kqYzSe4Zx0mWrfVf6qEqrVvm+7m7I/zen1ccoSeuLViutGr93kRmDuX
 m5rcdPZpb42omhQ50VIjxnwGiZPXpMwRC47t/o+EXgkaL3aXNBT8R263nLsjeL1lPaxi
 dRMphyxPT2TIaxrhtmt4ARsplyXivqCMu3uhBoZ3N4j2/kj7THyM5eMXzrQI+w4nniSN
 BlVEOBa0BdXGd/pDwbaWVTIlanCyod2qvnNYMpkQ+UXIihZ9Ad8HJX3nb6zYpXznuTly
 GvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743427149; x=1744031949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYuLLevDThsIlhYiPwTOv7bRzn5s5UV46Vyannfxfao=;
 b=PlvnZ18Joc7Zw3wyZqoe1yIHqdsmegPxX/79ZWyfo+A3sAfSmOkgpgVvGAQ6QKjExx
 mVKMrgipw/ztpX+ip0RQh217OJPjefsvfCZbrcO2Hi81y2xBQj3UUiLAIYLVN7M1q/sr
 SOjPVEeuhfOVJnQLDFXnS+by2xIHUJ4hNs0npcJuqpZojkOGWSJomJ7oTpVeUiXkBvgE
 aZe5kle7CjWIdSlaTOIvsymiNJ86MxeLGqeqWuA4ZaI5CxIIAeTo35RmJ7kYgPVNgp+J
 oWhe6+kkVO2WADuC5E69wJ39MAoyFVEc6hu4HxgxeEX06uBMy0nskLZqLjRMg9vN6Zo2
 UAHg==
X-Gm-Message-State: AOJu0Yyzlu82+yi9E80rm4lvEpxSgBNtBsm6IdXEXNr3DCjrzmM860hZ
 X39XUTVgc+OZVeJQmFUWi/lSbtm76IMf3PFjyJd6GuE2DaomYppQJDSntw==
X-Gm-Gg: ASbGncuKpCe6/yuonV7w10XXXxOuMZXuROjx66tR8cTok0pvO6L3LIawdvvLEa9Qx3V
 6HXV25N9JMF+RQWiPH1s2UtNiL28oXRA3zg29K3DyUEZPQWI47kJXAsByqunTj7ValsTRHWJGyC
 8YZvNRCK1DI6rC2eIXnAzKPDztbytN0kCyXqGWhN1YYal5k/hYcu62RDdafecKiEz3Vpbq+29la
 kn4ebHmt1Fok+44/ZwJ4ILS29SqJ+q9dtrGvdxCTJwq6RJEOdIuDy39uRpBDSL58xf0qbKP+ONk
 zXx7iIt0Sk+9ng/TMeDHIPOBsCz3UsLM1UNbhhJhRM7v9npmWg==
X-Google-Smtp-Source: AGHT+IHTsK7MV+NL7jbzeHzsoELLHPnFcqLnfL/fawOkQZxR7CwIYDo30xA75mHXsfLEku19EyNipw==
X-Received: by 2002:a17:903:2446:b0:221:85:f384 with SMTP id
 d9443c01a7336-2292f95d401mr136652195ad.16.1743427149112; 
 Mon, 31 Mar 2025 06:19:09 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7397109c494sm7090671b3a.136.2025.03.31.06.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:19:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 2/2] memory: suppress INVALID_MEM logs caused by debug
 access
Date: Mon, 31 Mar 2025 23:18:51 +1000
Message-ID: <20250331131852.612406-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331131852.612406-1-npiggin@gmail.com>
References: <20250331131852.612406-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Debugger-driven invalid memory accesses are not guest errors, so should
not cause these error logs.

Debuggers can access memory wildly, including access to addresses not
specified by the user (e.g., gdb it might try to walk the stack or load
target addresses to display disassembly). Failure is reported
synchronously by the GDB protcol so the user can be notified via the
debugger client.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 system/memory.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4c829793a0a..4c64a56676d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1412,7 +1412,9 @@ bool memory_region_access_valid(MemoryRegion *mr,
 {
     if (mr->ops->valid.accepts
         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
-        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
+        /* Don't log memory errors due to debugger accesses */
+        int log_mask = attrs.debug ? 0 : LOG_INVALID_MEM;
+        qemu_log_mask(log_mask, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: rejected\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
@@ -1420,7 +1422,8 @@ bool memory_region_access_valid(MemoryRegion *mr,
     }
 
     if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
-        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
+        int log_mask = attrs.debug ? 0 : LOG_INVALID_MEM;
+        qemu_log_mask(log_mask, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: unaligned\n",
                       is_write ? "write" : "read",
                       addr, size, memory_region_name(mr));
@@ -1434,7 +1437,8 @@ bool memory_region_access_valid(MemoryRegion *mr,
 
     if (size > mr->ops->valid.max_access_size
         || size < mr->ops->valid.min_access_size) {
-        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
+        int log_mask = attrs.debug ? 0 : LOG_INVALID_MEM;
+        qemu_log_mask(log_mask, "Invalid %s at addr 0x%" HWADDR_PRIX
                       ", size %u, region '%s', reason: invalid size "
                       "(min:%u max:%u)\n",
                       is_write ? "write" : "read",
-- 
2.47.1



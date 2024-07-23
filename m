Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA75C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJH-0000tM-Eo; Tue, 23 Jul 2024 16:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJ8-0008Op-B3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJ6-0004Iv-HN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso3281156f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767223; x=1722372023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlBR/BeAgLJfmHQZz0VW3T3k1ZaI6aRPlMOhtzIdfss=;
 b=vz3J4jLz71NQbBchq1lHvyHCwrOAUm6OqB2vsCk8PSQjuj7afSttTTjLmvi8FQBHmO
 4aITS38TiIBXSbnzEhreJXIoJgquKxAu5+AWaYBWei//AkIvI8ceT4ziVM7hqeJoxLJN
 X9D9EkpBmx2+x3snc7TjwXJ66L9o0xDvY/P5WBxWh4Z9m708Au+1PNw9qb4GNT+CUy3Q
 iRhfc2098THUHje5zDGN59HRs6AQfV/5oWpW0EWopKTQFLdDK/Su29ZLJnAKaD5hOTAw
 4VupYByd9Qo3fqrPs45ExKLOAhD7vlUqe4ClyAYUoXCa2URGDmyYs3ngPOWk2bwQGchM
 r8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767223; x=1722372023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlBR/BeAgLJfmHQZz0VW3T3k1ZaI6aRPlMOhtzIdfss=;
 b=mWVuCYduALVGAiRFhqAYq1NcVLOc71SJHEFDj6DjWNWPHX8WCrqBapdCiBMISVFO7e
 5s6ffwPnsAKYrHLnFFPxnB/eUWYupLvFF9fMM2xdCT3Tg+Ym0d97SssCBZdb/lAp4iD6
 AEQF74dHBBdrOW67ihyI6FXchcMb2XM2j/I5kqvyHvw1R0h8FXzJIMTEHD4JD0/h0BRM
 A6cXW3BvxzQV1njOx2YZX0hyebOczxbko0k3GCwB08t/ADHDXPUFIxobG2bthxw9LhAf
 iuyix4DTYDj616Pa11LcL87JE2+tvcZnDPBGq3CQghf5qxc+h+WaU4vEYFLIBHJcgJ/y
 woVg==
X-Gm-Message-State: AOJu0YyY4bPCGmOxW6c1OL1qE7cb5AMIaYI3WVYTSw73/ipjM7PZc0Fb
 lHJpb74L1FeER1AA4W+RA2x8/2TNk7pYcCJ2PZQxJLmgwz5RtdJBG/TXQybG572K6oykrNSGGP6
 0auU=
X-Google-Smtp-Source: AGHT+IEnz+rDcxL3ZYWG1WFGKucBEjEh8YbrVtMFT5aABbwvdCRis0lKzfVckOVdvUfnRvM5kPkkvA==
X-Received: by 2002:adf:e605:0:b0:367:96d6:4c2d with SMTP id
 ffacd0b85a97d-369bae35a62mr7181631f8f.25.1721767222666; 
 Tue, 23 Jul 2024 13:40:22 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ac54sm12427512f8f.28.2024.07.23.13.40.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 15/28] system/memory_mapping: make range overlap check more
 readable
Date: Tue, 23 Jul 2024 22:38:42 +0200
Message-ID: <20240723203855.65033-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240722040742.11513-10-yaoxt.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory_mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index 6f884c5b90c..ca2390eb804 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "qapi/error.h"
 
 #include "sysemu/memory_mapping.h"
@@ -353,8 +354,7 @@ void memory_mapping_filter(MemoryMappingList *list, int64_t begin,
     MemoryMapping *cur, *next;
 
     QTAILQ_FOREACH_SAFE(cur, &list->head, next, next) {
-        if (cur->phys_addr >= begin + length ||
-            cur->phys_addr + cur->length <= begin) {
+        if (!ranges_overlap(cur->phys_addr, cur->length, begin, length)) {
             QTAILQ_REMOVE(&list->head, cur, next);
             g_free(cur);
             list->num--;
-- 
2.41.0



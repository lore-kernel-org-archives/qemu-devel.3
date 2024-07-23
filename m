Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1741DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJb-00036i-Gi; Tue, 23 Jul 2024 16:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJK-0001I6-5u
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJI-0004Ne-25
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367963ea053so4295768f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767234; x=1722372034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2N8bD0EiQwQSfnPzHE5ISzd574iE9UTxrUPygv1PgWk=;
 b=X6CifGpN5f7R3sDxPih/4GB9XCUk2rV/FSV675VobXIQ3u+IGjRkO15SFAzgbivmmt
 IStqD4XS/KuuYvPamc60xPK9LXAz9oNHDa691sI1X+jEf/t235JtOK+CGatIJUsMFnQm
 GdaI6k4Fkr/D+UWEObuIBbYAvKry7sPvGBV4zO5pfI750p20MrbKWFs4J82MSGgRghLj
 meE1FVLgrUU0pSEKf4IJhfoiH0mKZDL8f0U9oQ3O4jQN3+5vJr5SXZO9adgdpZiBW3nN
 T9VRy6KgVrT1bHcz9c4CfuaE74tAG09bC/hsVg88I7sUPAjr78KLZ9IZXoCtNWJ60kNc
 ynwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767234; x=1722372034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2N8bD0EiQwQSfnPzHE5ISzd574iE9UTxrUPygv1PgWk=;
 b=sd0eD4pNQBKPrPfzC2XJMr+RR037nX5JTZY2gqTAdJt5D13jMSVVqedgMVBOR9bEwF
 hsGkMNuB626XgYoO3r1skcclbZYK/Ml1/0h6k3cpLf4B1xXP4gJo3e4LQSxSShesGTT8
 rWE2BnFW3L2tg0upDYCDVslt4uEHUDh/s7uNp7LSoertISZp/cO/aZW0SDow7arxC8lf
 77ohg9Q3LoAau+M5TN0fLu2Il9SZ6GC1IPSUhT0ixDYVT0SPK2DUxUHvK4JOFxSG/yrn
 hnibJ3MYgVDiLdNFNE4k2wxDraOCPNR9zlbOpQOX1gg2kvHLyEOowQQTgLnWzZ1zLYwT
 52oA==
X-Gm-Message-State: AOJu0Yxj4J2tX5KIbTAs855uiYII6J/rmPcy2+pk8TDavgBAtkWaUA2P
 sSTzNJdKSQ4XQlDaJY27FgQ7qENtEnDCxgHx1BI4/tiPVhUNQUaL9ygILSJa23JMc5/W+UpnrsX
 clCU=
X-Google-Smtp-Source: AGHT+IFmvp7Mu6eu4KTV8dwUEh3RqzCxejJRvzau7t9u+3Y3aZp10BJ7wrGiVrFgKgctY2kCOoGpZQ==
X-Received: by 2002:a5d:5751:0:b0:367:9d4e:8861 with SMTP id
 ffacd0b85a97d-369f0a994acmr632762f8f.57.1721767234014; 
 Tue, 23 Jul 2024 13:40:34 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cee03sm12462353f8f.76.2024.07.23.13.40.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/28] dump: make range overlap check more readable
Date: Tue, 23 Jul 2024 22:38:44 +0200
Message-ID: <20240723203855.65033-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240722040742.11513-13-yaoxt.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/dump.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 84064d890d2..45e84428aea 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -30,6 +30,7 @@
 #include "migration/blocker.h"
 #include "hw/core/cpu.h"
 #include "win_dump.h"
+#include "qemu/range.h"
 
 #include <zlib.h>
 #ifdef CONFIG_LZO
@@ -574,8 +575,10 @@ static void get_offset_range(hwaddr phys_addr,
 
     QTAILQ_FOREACH(block, &s->guest_phys_blocks.head, next) {
         if (dump_has_filter(s)) {
-            if (block->target_start >= s->filter_area_begin + s->filter_area_length ||
-                block->target_end <= s->filter_area_begin) {
+            if (!ranges_overlap(block->target_start,
+                                block->target_end - block->target_start,
+                                s->filter_area_begin,
+                                s->filter_area_length)) {
                 /* This block is out of the range */
                 continue;
             }
@@ -734,8 +737,9 @@ int64_t dump_filtered_memblock_start(GuestPhysBlock *block,
 {
     if (filter_area_length) {
         /* return -1 if the block is not within filter area */
-        if (block->target_start >= filter_area_start + filter_area_length ||
-            block->target_end <= filter_area_start) {
+        if (!ranges_overlap(block->target_start,
+                            block->target_end - block->target_start,
+                            filter_area_start, filter_area_length)) {
             return -1;
         }
 
-- 
2.41.0



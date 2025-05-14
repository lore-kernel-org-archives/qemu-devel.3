Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B9DC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBbT-0002r5-45; Wed, 14 May 2025 08:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1uFAm7-0000Mg-MS
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:59:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1uFAm2-0000JL-TL
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:59:51 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7410c18bb00so8057745b3a.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1747223984; x=1747828784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsw48AKk8CYEWDlWDcJoP4kYuHx7KlGPMhpRO9e6nME=;
 b=URS1Ay2KV9VQ6ojyOlBvozi+F4p8O6gcs5xbzEfQaLh4MiwIsxVHf/5W7M9lp7MJ6K
 HJtWTxkojsqVNJYTfyeZA9sFkfhl3tnpQ1R3s4gWawxGq3f23pLQHVQVU83gv5XTlDEL
 JQEFGuX6/6TwJTZoEWzXPEPvy7uHo53LbSlHDe8y+PWjdAD8AeqZwyjPlXbo5jUBITNn
 6DJng5RrgLpif9+iDoq3qtL28jIf3y5QHDkUeTRz0dOUfFXs38JtmDGn1Dn/kMyhXSe9
 LcwtnfZKerVt72mh6nw0YHOEh+TvJD9z7QaQhoaU+9zDyGm7r3StBxySYC08w53ZwbnV
 s77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223984; x=1747828784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xsw48AKk8CYEWDlWDcJoP4kYuHx7KlGPMhpRO9e6nME=;
 b=n4b4FU6hM5sCFOwmZ3KRXMP9MqN2KTFTCz6ZVBBZyvoxAwCe80MlAjSiWMKGV4vSJR
 0d5VzNTzyOuG0WKdLQ0NzZlf0sPI+24YszxuNaKDaqAppfkwu4wIxiU8p6a17viDGDIH
 m7ekA/x30j/HR6rmAzABdVp9B+V9FR5W2YbymhlXmGASDgqhFbwh6G8kTQdrmv2SSTSD
 2OeI8sjj5IVfgrxyTY9C3sTiB/lYku0r/QJyK8S/2eek44MpjKLkK/D9aUlhu0iJl5IE
 e/Oobb1UrP/WPT9rYlAzrTWN8vXRcTr33WV9Skj4TGqqlkOQI2joUC9V1af2zlz8d2L3
 K1nQ==
X-Gm-Message-State: AOJu0YxvtxiHgGOK8ciK+pAP17hyhG2VMyHIj9DiOz6Xmc0Nh/Ot9wSg
 eg0zMlS68fNx6ejssWbYFSL9qkcoECtGT/n7Qu/NgowIeFkbEl4lr02lcvGDaHA=
X-Gm-Gg: ASbGnctZf2MmXIopUoHuLVjzcWBMW0R55Zyixi9aPIwFZJzHzhze1dY6BFoA8pU/MAt
 ajlVv6yWo7wyGwY8sP087KdyOhiB7zAD9yorBVVkmmSiQnC2St2PZCl8diPrKSy8RBZsg1zazKZ
 q7XOIGzjeS8EJnFMygRQSs0njV1GVJ5td5GnElPLCRjHDwd7odCbNlQWEswuVbn8Y8RwPplhnLN
 3d6Am/20v41sNpE70Vq1guSw5xpSlfwWAEue2VtvnfGU1rN13ln5Y4vBqvpt4BCgn/WXbLSrBHr
 sPx+6NDeOslVwfJGd26T/8L+hChLVlzgbdya74Tljujgy9RYaBIR9ocsGTuEMEntlSGaHw==
X-Google-Smtp-Source: AGHT+IE+tGbSxo25JTfQgRJG0YRuAZnH99p+Vda0DChGHrFzAKzgKRsT1PHPK0TekB3KyYJf9bR2eA==
X-Received: by 2002:a05:6a20:914e:b0:1f5:709d:e0c6 with SMTP id
 adf61e73a8af0-215ff1b725amr4466320637.42.1747223984316; 
 Wed, 14 May 2025 04:59:44 -0700 (PDT)
Received: from n37-071-053.byted.org ([115.190.40.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a0cfc5sm9699366b3a.91.2025.05.14.04.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:59:43 -0700 (PDT)
From: Yanfei Xu <yanfei.xu@bytedance.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [RFC PATCH] migration/ram: avoid to do log clear in the last round
Date: Wed, 14 May 2025 19:58:27 +0800
Message-Id: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yanfei.xu@bytedance.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 May 2025 08:52:48 -0400
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

There won't be any ram sync after the stage of save_complete, therefore
it's unnecessary to do manually protect for dirty pages being sent. Skip
to do this in last round can reduce noticeable downtime.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
As I don't have proper machine to test this patch in qemu and verify if it has
risks like in postcopy, colo and so on.(But I tested this idea on my rust VMM,
it works and can reduce ~50ms for a 128GB guest). So I raise the patch with RFC
for suggestions.

 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index e12913b43e..2b169cdd18 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -838,7 +838,9 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
      * the page in the chunk we clear the remote dirty bitmap for all.
      * Clearing it earlier won't be a problem, but too late will.
      */
-    migration_clear_memory_region_dirty_bitmap(rb, page);
+    if (!rs->last_stage) {
+        migration_clear_memory_region_dirty_bitmap(rb, page);
+    }
 
     ret = test_and_clear_bit(page, rb->bmap);
     if (ret) {
-- 
2.20.1



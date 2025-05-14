Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E0BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBbW-0002sH-J8; Wed, 14 May 2025 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1uF9LC-00064n-PK
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:27:58 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1uF9LA-0003sg-3q
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:27:58 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-403407e998eso4740389b6e.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1747218472; x=1747823272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsw48AKk8CYEWDlWDcJoP4kYuHx7KlGPMhpRO9e6nME=;
 b=LvuYxUy0u5dC7vUMOdoBguMBP1Wm1RUk7fjIjTvTH8x49/pDeJWg3za8vX1u+qcEnn
 tQRcdLJ+/7oqmhoyhh/ZpSnQEjEpi6Tt4UJZ72VF2u6m8lULvbn6TEEl7xcKmRoIXZss
 9b2F1mHsOydywILkZScvKSmO3ycqezTHTTPW5jdrOJFLRIzNpibBS5yBIoGiSAvw1wLG
 wUmwCM+w9Hc2R36yqPhGMzVAABzBFKagFxDwK/KDwjgueZ+txiX4QJS7TjjzygRt3BOm
 o76p5ViVU0Ay2uTq5xQcqGXZqx+cKLKCFupoKz5kGjJbeCEJIYvLG/qU9l0KaWmDZ+I2
 Tvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747218472; x=1747823272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xsw48AKk8CYEWDlWDcJoP4kYuHx7KlGPMhpRO9e6nME=;
 b=tlyPsvvmnRSPZdvVromFN2cw7Fal3ek8ka6+DKC1h2HzYw2BHvkghcRjMnbDRR+DIV
 qN3oref0660MuVBA1N8mkS8AwkwHiGjffKkmuuJL6md0zsUFGZ8jOi4L+lbvesXzjilD
 oiPqoL4pvL7de7pjD6Qkom0cqeoFpC9dDLDBtWVbRbOeMx6ynNeVqSmBvHweiBvIUp7u
 DssoZjsJi0F1byGmxlvx3vf0wdqYOhS4Hi5CH0QfNTar0BV8nrV6cBpD4yphhcP22URp
 nFKMPKtEet013Etn4iDhX9XNbIL/V3mu2gj88L6xcfTn/6ija/GUMnQsvmgmK3NUjXKb
 EuXQ==
X-Gm-Message-State: AOJu0Yxib3jaBmmfP3FKC0NEyXL3a9Uaj33OHRirWWLqKsstW58igVx2
 uLh/ZngJg3EfpCNZMW1BN7r5zUs+jzmhDO4BKEBanzejiLhCFbEcSfk5cttF2OEa6hZBV4wN+ZR
 KIlo=
X-Gm-Gg: ASbGncvBCzaNemPfssipxG/sbsqWucEr7KzpiBKFFDq3oLfYrKSLf9OoZsHSRvLwCub
 JQwHJCgXL60P0Mood+wdlyQ27OJ8yfHr9HB1ydBZRjcgzcm11OMgxKyZYAmYn12GirNXSPt0Or4
 eGlkAj3sQxfHJ/tvNRtcSzPwtOeWn7gwQsn1V4A2eZaorkR1HSlA3fXYt6chjNAhEjv/h0F5G1j
 aeN1OjFalFbkQyJwmuHWFmWW5Mmcvp/woBCbQtB9Gk+5c1RN/KRn2WvfEkVTCSJTmu+i7jz2TRe
 kKpdYpTviE45sym2/QuDhiSSjtWR4Uiu4iqVFHGcba9gH3RycBQz6p1m6a8IKWge3HTR7Q==
X-Google-Smtp-Source: AGHT+IFonfmw3Xf4VKFBloalAvK7boQoglZBFIOQlVlwCGSJsSO7Ydqn6oruG1VBTUpO0OGjgPkpAw==
X-Received: by 2002:a17:90b:4c51:b0:309:cf0b:cb37 with SMTP id
 98e67ed59e1d1-30e2e56f634mr5078606a91.7.1747218461472; 
 Wed, 14 May 2025 03:27:41 -0700 (PDT)
Received: from n37-071-053.byted.org ([115.190.40.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e33482fd3sm1211762a91.37.2025.05.14.03.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 03:27:40 -0700 (PDT)
From: Yanfei Xu <yanfei.xu@bytedance.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [RFC PATCH] migration/ram: avoid to do log clear in the last round
Date: Wed, 14 May 2025 18:27:33 +0800
Message-Id: <20250514102733.3114824-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=yanfei.xu@bytedance.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 May 2025 08:52:47 -0400
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



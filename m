Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3A0F8E489
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVLZ-0007kk-NY; Thu, 16 Apr 2026 18:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wDSzo-00022Z-Cs
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:07:28 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wDSzm-0000He-Ri
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:07:28 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6888f36ceaaso136202eaf.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776370045; x=1776974845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCsFtdTDgbFc/U88ymKe8zR4zhuBtfCqsEs0LceHIRo=;
 b=SDw1r8WbJ17GV93Eh5EZSg0p2fcCToOw9DV+KM/2xjS9tIPI7UKZmcuhEwWKPdVfNC
 nN4dyg/vaA1fvD5ZZUYo9+JuONdtGV4Bs3EnFyp1XskJaQWPvtWjnTFmg/8PCETzlxCs
 39HzRsSdyiBACYP7eSvjmjJWA/3qOJdHeJxa0+/rzLK/8md4+eq7gwJqGWUOs/hdTo0P
 SJbPniT74FfClL7YNf4JqUFfwfmfEWGqXkzXYmQGGcx3atIMk5ynEqoJWYAXfkj/NgJb
 cQw8k/ekanlRZ4tnNMNoZGV3tcmK1KJWkqO/IrtbA3xFj5fpHsv78VzXYeHDgx0NTGi9
 myTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776370045; x=1776974845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KCsFtdTDgbFc/U88ymKe8zR4zhuBtfCqsEs0LceHIRo=;
 b=Hgyisxa6hkbVNGxrGn0j3Pnj+yFOG8WvZ2OzP+tRG8MgFehBxIBuJDI7gNSgK851gv
 vJ37WplWwzNibe6GORziSzFa32nI5Sbgn/T58JbjePaU4N67BviMC15kHxKLIw0rlNNN
 0Q853JNsgDf0AFE1n3LX66QHULgyzfNE25ckROMgl7oXpVvj6vFq9peEfjrZtKyj4FaM
 WbGNYc8191p3KGjCglDQ2Z3hFmR64ck2Z9o8HzugPjmsGboVH8J71OAepR+ITwa82Z+E
 GYXEiuxGy7FnS6CzuWX4a2qTPlu4SbZ2rZA0O9u3mUe8Gfq2sdBNJsMjd5BFAO6v9V1n
 tMrw==
X-Gm-Message-State: AOJu0Yzm4kqermUJlJQF4bTvU+HxTghhBu33SWreeUOvBb/asIHaHgVk
 TngQ+wIOdgLBNb/o95/RfeOYHAgcaAMKw2nYlORyF4V/QF5az3TTagj/8AisqWNP
X-Gm-Gg: AeBDieuHrB6VJOypjXyb0R2dmhUJgYud8hirQTQkJVgl6GXQajiFcYy6xNiKUn7BU6R
 hWyFSknszIzvL6IinsGP0ZmtJKjCzj0/+4kyqe4DQ6nCok19JNzNBc2yv76pZbhf/QylHMfRw5F
 vWaWPqWyiHFw5A1HzRNEpAlWmbF3kllojllRUhv1r1O13SkY9oQ3KU35UIPlw95CgGqWS2wX7Fq
 CJ2+VGws65YmxuE7ppualpyI8ymNxB/qZUdfsy6LabobPg3YRO/eg+U5Ijjch5tiUZwgQSfx7Ln
 qUceQfqCt54stV+AlLjT0rOyyY9uTtr9q7E9IRc1mFpg7P0JOFP1GaJCoE9KKR4ruo15DmcelWz
 3zHsVG+lTiyrBTSu1RxFEr5v/9dGuhQNUWoBGY0tlboiIEg+H1BTpgu9Vdk8ErB1YAoYNhSfnZ4
 SNlnaUVAoluXyPMU83QZM5E/zQJFkaSRzGivRiC2TupGx4/4tAKn6A1Xh2G1ouLiQ94QyWePql/
 Da4MqLZ+3ceDHi46dFccTbT/CrBZG6ydPU=
X-Received: by 2002:a4a:e1bc:0:b0:67e:1552:16cf with SMTP id
 006d021491bc7-69462f04df4mr18380eaf.2.1776370045239; 
 Thu, 16 Apr 2026 13:07:25 -0700 (PDT)
Received: from localhost ([136.49.184.116]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6946044199fsm521624eaf.14.2026.04.16.13.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:07:24 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
X-Google-Original-From: Aaron Esau <git@aaronesau.com>
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, jic23@kernel.org, berrange@redhat.com,
 Aaron Esau <aaron1esau@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] hw/cxl: fix OOB read in Get Log command due to incorrect
 pointer arithmetic
Date: Thu, 16 Apr 2026 15:07:01 -0500
Message-ID: <20260416200702.2374709-2-git@aaronesau.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416200702.2374709-1-git@aaronesau.com>
References: <20260416200702.2374709-1-git@aaronesau.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=aaron1esau@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 18:38:05 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aaron Esau <aaron1esau@gmail.com>

The memmove in cmd_logs_get_log() uses cci->cel_log + get_log->offset,
which performs pointer arithmetic in units of sizeof(struct cel_log)
(4 bytes per element). However, per CXL r3.1 Section 8.2.9.5.2, the
offset field is a byte offset into the log.

The existing bounds check correctly treats offset as a byte value:

    (uint64_t)get_log->offset + get_log->length >= sizeof(cci->cel_log)

But the memmove reads from a position that is get_log->offset *
sizeof(cel_log[0]) bytes past the start, which can be well beyond the
array even when the bounds check passes. For example, offset=65536 and
length=512 passes the check (66048 < sizeof(cel_log)) but the memmove
reads from byte 262144 past cel_log, leaking adjacent heap data.

Fix by casting to uint8_t * before adding the byte offset, matching the
semantics assumed by the bounds check.

Cc: qemu-stable@nongnu.org
Fixes: 056172691b ("hw/cxl/device: Add log commands (8.2.9.4) + CEL")
Reported-by: Aaron Esau <aaron1esau@gmail.com>
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..0adf1e72c8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1217,7 +1217,8 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     /* Store off everything to local variables so we can wipe out the payload */
     *len_out = get_log->length;
 
-    memmove(payload_out, cci->cel_log + get_log->offset, get_log->length);
+    memmove(payload_out, (uint8_t *)cci->cel_log + get_log->offset,
+            get_log->length);
 
     return CXL_MBOX_SUCCESS;
 }
-- 
2.53.0



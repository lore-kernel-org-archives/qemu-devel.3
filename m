Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BBACCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBe8Y-0003Mn-1n; Wed, 22 Oct 2025 15:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBe8S-0003Il-4K
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBe8O-0006S4-IX
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761159870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3NFNwBM4HOw5L4kpkavYak7hDLndWRsBxcKwAsErvpw=;
 b=Y9m145IPedhsxlQhs5gdvIA12mB8bMoDiFYZFPorvFHABiYcjE8dRlceJlvZ1AbqP1V3NW
 7wsNCAiFunLhzw/EumvTKy2vK7yPb2J4/Ef0yJEjBwLzkXM07mmSatjEc7yR4ArRfU4EMW
 MsNQx/vIrxPxAQIsFoDcqqd3jrQEttE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-sKgNS7DjNR--aFDVjHijFg-1; Wed, 22 Oct 2025 15:04:28 -0400
X-MC-Unique: sKgNS7DjNR--aFDVjHijFg-1
X-Mimecast-MFC-AGG-ID: sKgNS7DjNR--aFDVjHijFg_1761159868
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-87c1cc5a75dso349757866d6.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159868; x=1761764668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3NFNwBM4HOw5L4kpkavYak7hDLndWRsBxcKwAsErvpw=;
 b=jLe2cKrs3+EXaFiUuDuZW5BIZPI9/qKxxFTXOfm4HzGuNEqZZ60KkH/JazgM+IStqg
 iC3w/kPVGBopy1ht4pkOGiCtnO6GxCFhhLWzyv4OOFDeCh5zUpOrFMYNw3Dy+AU1o9Hj
 8m+3SuJnIeKNsNnKR8DTw5vm0JGD5r71riNes/r6GhbInVbHEH8XVAdtHUgSfPPxw6lJ
 lLMFiFywzvYQrdBN6hDFdmJRNbAqe0Ye8ZV79CGlsDjvJ89xqZkdLcKiTo982lXItPnc
 hh0j6RuxkWLAB3tqj9nu5+z8NT6q9wZqeDkac88GKLiRNTTkYk7cZQp7VMrnlL93uJ03
 Axew==
X-Gm-Message-State: AOJu0YzURfdSjo9sZ7evvuH9xttH5kUDQeCKMwimv9pFe14n8L1fnxL/
 +EZhbZqCB439DXPQURYOAvNC4M48m0I9b71obmVlCAC+VAgFQ8kHDa6kFR5/H8NxucPo6KvaAdo
 p2cYO61T3YjWBWR1nWYiwfeRo7kSXUl7SFMaalsO0DiiZqdeNQ3I3ZNoPXaYcZnTg4DVHo9WAHI
 f47+oTAaq0MoMEKbU6wXlY6pGddRXP99Wde6SHqw==
X-Gm-Gg: ASbGnctHHwUYvj8UzUo2klj3rl9agIpWvr+AeWJ3oI6C9ch/2UTDFf23fjObttUuCCR
 wBKFCRKHfakr8yKX+YZVRe19JRWj5bDu1hylPbeEiF7W3xku93gONlAiwuzE481GucKJGy7uGnx
 VCqGpaQWV1W0G+SvJWP3tzTqQMCprFl1f0M0pfAndlL7Zu3+1BPjrte5J1f9UtPbv1VJQ5Tnnma
 J+YkXJNrLsKmnjNMEfI2DH19meKIgyCBXGcSaJr2yItmPi14adiI7ppf7G7+A3nj2/SKYN7/hki
 xM145P7Nf3VHN4hYsUoxITvaiUcw4RnRLhKdkn5ju2sI33lO2ae7tcE+bGc4KF78
X-Received: by 2002:a05:6214:40f:b0:87b:d338:bdaa with SMTP id
 6a1803df08f44-87c206497a4mr27752086d6.52.1761159867884; 
 Wed, 22 Oct 2025 12:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH61uEuN1jH3XvJYK/OG47bvP1rQtGy+7bXqsN93CPb116bKLm8GYEu+UahC4Nkw1E4r2+qjQ==
X-Received: by 2002:a05:6214:40f:b0:87b:d338:bdaa with SMTP id
 6a1803df08f44-87c206497a4mr27751536d6.52.1761159867302; 
 Wed, 22 Oct 2025 12:04:27 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87f8ff3f362sm379956d6.12.2025.10.22.12.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:04:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] migration/qmp: Update "resume" flag doc in "migrate" command
Date: Wed, 22 Oct 2025 15:04:25 -0400
Message-ID: <20251022190425.2730441-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It wasn't obvious how the resume flag should be used when staring at the
QAPI doc.  Enrich it to be crystal clear.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..48856078db 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1732,7 +1732,10 @@
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
-# @resume: resume one paused migration, default "off".  (since 3.0)
+# @resume: when set, resume one paused postcopy migration, using the new
+#     URI/channels specified to replace the old/broken channels.  The user
+#     should make sure the migration is in "postcopy-paused" state before
+#     the resume request.  Default "off".  (since 3.0)
 #
 # Features:
 #
-- 
2.50.1



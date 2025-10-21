Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0362ACCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 22:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBKSu-0003qw-4D; Tue, 21 Oct 2025 18:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSs-0003pj-MP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSq-0001Ky-Uy
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761084260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjie+EYy7hcnSGU2LzbAjxCFfmcoQEk64RorSJjWBpg=;
 b=EF4963qm27+35nXbu+V6ub8HnqR65+Tj3DQtPW5+AneYfUATvpmvIAwVmeQKjcCilnpNF1
 NJ1f1RsXTv/sX7Jta0AsnPw90EVjjgZ0OaaKk6JIzFLtXMD0d4ICQuU14xTH/DLeMUvcRI
 EX7pNYp5XBh2Gx7Na6jYw7wO8TVxSgI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-R748Db2UNxGENXN3Hel0vQ-1; Tue, 21 Oct 2025 18:04:17 -0400
X-MC-Unique: R748Db2UNxGENXN3Hel0vQ-1
X-Mimecast-MFC-AGG-ID: R748Db2UNxGENXN3Hel0vQ_1761084257
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-88fec61f826so2153541085a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 15:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761084256; x=1761689056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjie+EYy7hcnSGU2LzbAjxCFfmcoQEk64RorSJjWBpg=;
 b=mQGaS6saq2OU4t92AldAfxapxGgIjD2PhuIL4Zw+k7HRWuxNs1QNeH8KV7HVzfnEIS
 MHxKIREjaJr4kTVqiBe7pBNhKFaXjoT5plUe1706fQvIHvhsWz7O5Kxnz8JkvNJ31gYQ
 owFmt5uYt6HONi+mWirLiviAPj7izT2hDS9OSGKrJ2+bKuLo/F4Lb3/KkMdcjkjCPx7R
 ImRm6n/8A6PqAU8trud31zyiUusfw0agQ+/pTJx/aiGS4hk1fHagw4iHWtdfR1jQsKpe
 a8tgKxRguzSPVZkCrqRx/Xe1oeZ6PG1ZdX/29Y88NQYZ6JSkTEZWuwoljncz2vamE9CB
 ky2A==
X-Gm-Message-State: AOJu0Yz6/PK6SujBs/mdskh1VeQaj49+yKzfpB1RpXHAASocbsJDztYC
 iralcBmvG03SGtBpEklUZLeh5xcicpJIrWlpFBYDAuUiIVy9+xSYMC7lEL0mxDprTh3txDNhsEA
 kSRWXoVsV9akzM9HurH/Su2TCxXOt1eoTYERG/PVYeyNfr853L6svmlG/CZ4FepXPkfB6bvu/Ea
 RuopzJL/YkydWbRKG3rMgm/aH54rcp6vAe01PwyQ==
X-Gm-Gg: ASbGnctsoKKZl4WG5iRb47rlezKCE+UCCG/SCrte6tSQNYZIywGSrgBVFR1ywHIdmyp
 HkBP3Z4Tcqywothot+ogUwGMfsSl1EhZVqcSHZ9X2EbFHujJQyO763Hq2u3dK9jAGUk2i+clwtQ
 M1duwv6S1PR5lipNoEpou1/dpPfscOrpeM0ONVa8RSXnrfPWYzntxL5jgUPaTec9bHVeT7shidU
 TD2BFbpI+hZOmcNitSBLLJTm6p4O1KDDiOFhuaE/XLFfI4tc6Z9nYcd31jWFi3DnJXu84ta4cMd
 OgTHxqCgoKIlJ3Y/UcyObsnTuk25fnMQeKwJ1wjhyyMi01bG7D+j7jURJ0lztHLy
X-Received: by 2002:a05:620a:1721:b0:893:5433:7427 with SMTP id
 af79cd13be357-89354337760mr1179292785a.51.1761084256262; 
 Tue, 21 Oct 2025 15:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVzkvSR/XBYtxDj27KV3aGL1srz3sdS8A0LmBJLKnRT7YqCenbjsEk++t8ZMAGlZcvSMJzNA==
X-Received: by 2002:a05:620a:1721:b0:893:5433:7427 with SMTP id
 af79cd13be357-89354337760mr1179287685a.51.1761084255646; 
 Tue, 21 Oct 2025 15:04:15 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd098edasm849197285a.19.2025.10.21.15.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 15:04:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon <armenon@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 3/4] migration/cpr: Fix UAF in cpr_exec_cb() when execvp()
 fails
Date: Tue, 21 Oct 2025 18:04:06 -0400
Message-ID: <20251021220407.2662288-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021220407.2662288-1-peterx@redhat.com>
References: <20251021220407.2662288-1-peterx@redhat.com>
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

Per reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA82ih8RVCm-u1oxiS0V2K4rV4jMzNb13pAV=e2ivmiDRA@mail.gmail.com

Fix the issue by moving the error_setg_errno() earlier.  When at it, clear
argv variable after freed.

Resolves: Coverity CID 1641397
Fixes: a3eae205c6 ("migration: cpr-exec mode")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpr-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 087ca94c87..d284f6e734 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -152,10 +152,10 @@ static void cpr_exec_cb(void *opaque)
      * exec should only fail if argv[0] is bogus, or has a permissions problem,
      * or the system is very short on resources.
      */
-    g_strfreev(argv);
+    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
+    g_clear_pointer(&argv, g_strfreev);
     cpr_exec_unpreserve_fds();
 
-    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     migrate_set_error(s, err);
-- 
2.50.1



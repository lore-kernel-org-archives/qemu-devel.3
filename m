Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B7FD0636
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0DZh-0004sG-IK; Wed, 11 Mar 2026 03:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0DZU-0004qU-Pj
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0DZS-0008HA-3S
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773212488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iXquVMElsRlU3hns3x7tQ/+6aRIf7i/dMX0YT7CJNT0=;
 b=fMnK2k4FxPMcPMbUgh5RwDbSiRITdABGA3e6kaHFwohz8lx3xZ6z4d+bNYlZ5PJyalmvIT
 M5WEk1ka9uDN1hdM77d90a/jokXmPCLwYGoN9eRngAO0GUfJaQ0ViozpJrBFp5cBF7m42l
 px2xvwVYOWwqcgXn/MIdhWk4DFTMBh8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-qP2WX9-LNdq885IMazv7gA-1; Wed, 11 Mar 2026 03:01:26 -0400
X-MC-Unique: qP2WX9-LNdq885IMazv7gA-1
X-Mimecast-MFC-AGG-ID: qP2WX9-LNdq885IMazv7gA_1773212486
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-354bc535546so11866782a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773212486; x=1773817286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iXquVMElsRlU3hns3x7tQ/+6aRIf7i/dMX0YT7CJNT0=;
 b=KTMm57b09mHvjgtcVVP5lrcapGtiTFwD6i6yTOLCISuvIrmj++DTGznyYiKpdk/CWS
 aZ+JdXYrFE/Z3k3j+wx76Tc3a+LFCJHieroYudHgHNT+71tOvZWxeo27c8WX7UgIiXrG
 TVbL/y0rELWVGESpZgMr0czWKyz5z++dZ22y10aWKj1lt8YQGeKixdFJN1YEUlllgK4H
 pFVdphOEdV2MPuH5crUaIC5rt5lhDIR4uYC+xHXMXQg1BcF1NnRgD7ql+uruix3E+qGG
 aUhCtjszCy4Z5F+GY9heyAmdlhtiN9y12+5AvFTJwWKIwYPZb7f27ii1MSH9kHsIPNFV
 iLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773212486; x=1773817286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXquVMElsRlU3hns3x7tQ/+6aRIf7i/dMX0YT7CJNT0=;
 b=TMB4+oYubrvEz9F5lnxmozvO/iz54+WP78lgpRe2Wo7j3KWSmE9uHqKtRIKYr0jlK7
 jgnXK8osrSS/ClKzjc8o2jrPBJzQkC1scNaMf6swOOZ5F7t/oYKVXinJ0TV9XanvS0GE
 nKYwUAZqmvCi8hkfhvayzRFbprzSFS2XQC1DBynqX4CToiABgGlYWADVebXIxKqYkLon
 OpVjpTjCueXXRbF2ZJVxW57hGrERjha2jLbq6xbAAt6p878JvmtQTB2VZoRXBBhMrJoJ
 vjPi7UIE/C7Ps8XGGAO/eUtcG6gAse5ZEE2x2Nvev4O0n5kpRtrL9pJ+YC2UxBjNuqha
 /qWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbanntdv+PaWTALOteuZwdOA0mdosioAomg90cDeU9Lk1N1SHFbeLP1vb6UABgcF3+PvKv41bipNB1@nongnu.org
X-Gm-Message-State: AOJu0YwQmyWK0k78kFqfQryrS76iE4zUGQVLx9IiDlvH8ioPVMHvdScG
 5oTGg3pevoQCV0r5knaJUePJJZQ4f+m8uVwzhhtfecqYXZC76S4XyLtlzDeetB+7U2tLUd5VlAz
 u9Vnv/XUi2wDJP8ib3vYRUoynUXaeGxHNnUyBs5k4OW+vR3hVZE83b2DW
X-Gm-Gg: ATEYQzzxrXImT1LDNDpqmXFcm9cOnmazco3Z6b/vAD3fNPQC5ne6Za0+N/bgEMyTJwf
 R8+v6wizGzmmbltfA9j9br4klb7gfG7uX79qVyC+6k8hE0NKm5jFSHuRlpPM4Igi6IxK13OlqZI
 LxBMsHNw9cHR+VZ2NDyvQUHRiRo08pr7BwZBxfucb1xKkrScVaWA2URvcnC7pmmXoMUaJEmqO2E
 ZcKX5quMxMgg06r4o/zXXbPzGg4r2sAgbJR1ksU3dZEicRPC5tnZtyDFW3ztXQggD3dUGY+18kw
 OgzO7VPsv8BeVR9nKIpLS2dmRD6A6jHpPg61saVj3AzArluGBElHvdbFAapzGENQ6SXTjB0QuZR
 KdDvWop/fjbTyiY79DGhN6IwrYq2iUgNIAxnGiw81TJ03nZWxI6dvBcsH3g==
X-Received: by 2002:a17:90b:1f85:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-35a01268290mr1578338a91.12.1773212485769; 
 Wed, 11 Mar 2026 00:01:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1f85:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-35a01268290mr1578307a91.12.1773212485330; 
 Wed, 11 Mar 2026 00:01:25 -0700 (PDT)
Received: from ani-lenovo.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359f06fa04esm5179448a91.6.2026.03.11.00.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 00:01:24 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org
Subject: [PATCH v2] migration: assert that the same migration handler is not
 being added twice
Date: Wed, 11 Mar 2026 12:31:14 +0530
Message-ID: <20260311070114.164434-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Currently the code that adds a migration blocker does not check if the same
blocker already exists. Assert that the migration handler being added has
not been added already.

CC: Markus Armbruster <armbru@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

changelog:
v2: fix indentation

diff --git a/migration/migration.c b/migration/migration.c
index f949708629..4459d85ea5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1694,6 +1694,8 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
+            assert(g_slist_index(migration_blockers[mode],
+                                 *reasonp) == -1);
             migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
                                                        *reasonp);
         }
-- 
2.52.0



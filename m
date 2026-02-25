Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C828EFD23E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBic-0001GL-UJ; Wed, 25 Feb 2026 05:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvBib-0001Fy-8c
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvBiZ-0000rE-7V
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772013725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K+joFx3iPOxG3eoOHWmFiLx5HkRaAfpoBC1U9nf1zII=;
 b=QgsY81oye1fgDGJv82w76IlpR//EN78cZN0qFr89sea0mnx4q+gqIIZfk/+By3nSOu1Rv8
 ypnztYIuOM+K5Pt2WIX9iqgpxEDAyO3auvpwhxa2aruWBwnzqx2PmKh2KgYm2TB5vO5jf6
 mN5ZheFDQlyu1Ai8ZY3YtFwmspiddx0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-3YBSRRngN5unthaP7UMhdg-1; Wed, 25 Feb 2026 05:02:04 -0500
X-MC-Unique: 3YBSRRngN5unthaP7UMhdg-1
X-Mimecast-MFC-AGG-ID: 3YBSRRngN5unthaP7UMhdg_1772013723
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2adca7aba8bso7124325ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772013723; x=1772618523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K+joFx3iPOxG3eoOHWmFiLx5HkRaAfpoBC1U9nf1zII=;
 b=GbDVo0jW7q5t7NgZcYCzAjDsdFfDp3xogO0sOilo97Gi5FmJO4kfsDfpNeIC1RAhvC
 9Jnc2jhIz7ppI4zGD8xby+WWxvkt8h9cXYB2Q7JEjd1EIzUpkmnRmBohNaOY+lKDaQ88
 nMuSeWIeseL29YOzra4VXfao19m7GxiqpMbc1w3NWGKlw/Lf9HAYCrC7FhqLX8wWFIuc
 YMif1KlIVsbBxBxgxZ/8RRZoHicscfnW0BRi3Dp5Aa37CMdQj05cHY1AHk1fuJKqasXI
 Y77cSQLgJKytTNjUW5rPxxsmKlwBg5ynt9VQbrI4ftpyZVXtgWC2bB0ujSwsz/wfMXFG
 oCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772013723; x=1772618523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+joFx3iPOxG3eoOHWmFiLx5HkRaAfpoBC1U9nf1zII=;
 b=jPNgdCAs8+8TTrH3sbbx3w9Qkqsf3GgkK8QJYDwBSXc6YhvvMr7i9njUq128AxkOfa
 FCAbmSCJlAeIhzPBsmH9GHVVXR6pi2ICG9tjxTKhVsVjamaD3AAd/eNcg9JKq5LkhzDP
 CG5eisinqBt9cAhz7bmf3JvmiBVasib9mPTIqZmyoIC3uZe3/FW1G5SY2rsCQCXFQoEI
 EzlRd6FgzEgZRYuAubpQFtTyQosSwngKKzqIavQj86//TmaE+HRQFUHP5wnAMDJqcaPH
 E1+SqJq6c6opDmqNmWYeDL9oXLEv3GdTtnvm6sn1eNnlvSUnV7wbyBaMZPvLLx6jPIrm
 1lMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfkXe+GUv/KTEkXPVVfcrj4SAc+efzGbqHsvF81zo++4ijAEGkY3SS0yyE8AYCUROER1jviQLvlYIH@nongnu.org
X-Gm-Message-State: AOJu0YxzZ6PhitJ0sCWAFy3skusEACG8NOnIovX/BDaXmqtvINLRh61i
 Fnxf/zdz24YuiOmiJGbfh+4RUua10hksLUfBM6xBU0plTOAlxFoDZ2g/4FlNn/JJv5s7zjbBS/p
 X8O2m7uEbCebDcqdu+dkRJj95d7sjZtOekZK/38SiYDqYN+BYNI7GRPlZ
X-Gm-Gg: ATEYQzx9vu8zwm8XrsZVGBH7XLhNcDwbz9lMWGmZ7GdBqt8fgqZ1DMFgcO/mZyZCdfm
 mflV3CbIN8vVonFaL7Q9LUjF3RbB2zHGQA3Ybim4Kt0F7T/vLRbdGFu8fFqStImybGnyKkvkrZ2
 O9FyVPGgEVcm/mGDrz2fw+WID3ovtW2fAAcARSTElFw+MlXT/QWcypvZM97P/1LWAzwrahBxSKz
 uD5UTflVnM7z23Mv/Zab1gMY7CacNk85XGrjpLHUCbpAzw/ILiBNaapENPMUXIz48Zg6r8U3XaI
 NV64kUSHE9ZYMPfas0N+cT02NLGDf/QmHyJnj8XIi0LYXYJp/pyKiWMdfMQvyoPpbxsCD9atAeU
 fhwrJG+gQwdOZSYmT3UlzR8Izudq8+eow1lzLgl9XkrEISe6CspE1CD0=
X-Received: by 2002:a17:902:d4d2:b0:2a3:628d:dbea with SMTP id
 d9443c01a7336-2ad74465567mr154813965ad.24.1772013723014; 
 Wed, 25 Feb 2026 02:02:03 -0800 (PST)
X-Received: by 2002:a17:902:d4d2:b0:2a3:628d:dbea with SMTP id
 d9443c01a7336-2ad74465567mr154813755ad.24.1772013722583; 
 Wed, 25 Feb 2026 02:02:02 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad74e3507csm135275435ad.8.2026.02.25.02.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 02:02:02 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v7] migration: return EEXIST when trying to add the same
 migration blocker
Date: Wed, 25 Feb 2026 15:31:47 +0530
Message-ID: <20260225100147.389784-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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
blocker already exists. Return an EEXIST error code if there is an attempt to
add the same migration blocker again. This way the same migration blocker will
not get added twice.

Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 migration/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index a5b0465ed3..eb82e964b2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1702,6 +1702,12 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
+            if (g_slist_index(migration_blockers[mode],
+                                 *reasonp) >= 0) {
+                error_propagate_prepend(errp, *reasonp,
+                                        "migration blocker already added for: ");
+                return -EEXIST;
+            }
             migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
                                                        *reasonp);
         }
-- 
2.42.0



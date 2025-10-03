Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDBDCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huw-0005SW-Sq; Fri, 03 Oct 2025 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huI-0004yL-N7
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htj-0007hU-Eq
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eBNLmWbsAxeJ9A3hl/lSDxEzseLn9pvSToGPnHoiaA=;
 b=A4udMetuhmTDKsC8Zvgoox5kXJH2dIcBQvbXq68LUJ+ANQDWmVTjcrx9iQfM+o43qVO4kA
 bVaUR6Ch1dLA7vAeXwW2be2RViYeuMlya9SY7kUsdjEb+W5sdLbrTvBxEjQNFz1DLflzvP
 6Cm+krEp42Ir6mlTuAJmruS77+pkxOc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-KUZjD359P_aLJtme3yWe6w-1; Fri, 03 Oct 2025 11:40:34 -0400
X-MC-Unique: KUZjD359P_aLJtme3yWe6w-1
X-Mimecast-MFC-AGG-ID: KUZjD359P_aLJtme3yWe6w_1759506034
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78e30eaca8eso74442516d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506034; x=1760110834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eBNLmWbsAxeJ9A3hl/lSDxEzseLn9pvSToGPnHoiaA=;
 b=KCooflwEGdL0GijH7Gt6nL+//noPyu0jlVLB7Yal20e00g1LsaIN0nQuNUg38hVNQq
 /44uTb8tlHGZ9WjmMBxs5MRl/b2SPnQ18pT44389YZz4zI6ZvcgdexmD23Gi2Kr90Ktu
 GDoFtXaBMM0BoobYFUAWUhJNQfj2Md5Qn4C0GSEy/CZTVp9lMGYvdRlTYrD4E8Kj5Mnf
 pzsCiPeBOzGKKtIZDQ1kMZwGzW7PSGD54cbAPFBRphadpAYRvAeN0xwsCOw4j7+PVLve
 v7ig/mgkHKp2KkMqk/+dhqLRTxcJdhdoJbiGD45lbJ7DeQTNVRM+s76AvuZ8H3AStMNv
 qyIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8AuGIC7D27tmBFIBM5sRXLeTBgwHe9KYbk5seVKmSWDc6pKbdaB3+q8YfOn8hZtQgCLISCLOElT/x@nongnu.org
X-Gm-Message-State: AOJu0Yy7dHLqmufOD93UUQL943h9Z5vMFBZAIduigq1wcF4a1keOezb0
 57rJpVzfe1n2fkYuSpS4K60IquweIhEiludfMHyAv+9t5oX6CG9Kd0C/trWiwZWPIxFZg0eqsQO
 rmwUKyNV2Q8I22GN1xxwdwy0JVjN2Nv+OZlGpLpRGyuacd90Az5FQPi2hhnPhjEn5
X-Gm-Gg: ASbGncvCvV7hc6xWzVzRIRITmiU+5dgU8bWYSK89jd2Ln4UUT5fW9MpqOx2tL8ZSjtv
 tFIYDIFg8iVYjLqF0WUyiRpQBvm1mzP2zyfsoGZuXM9oAMRotAJUEvJH6KcplggpHHQ2FKjxqVW
 o7ZVwZhm6KuJ+e3Et9ORLkAmY3xAdOjpWgIvtNnBFILkp+S9gPptceERh+4zD0fvYaXwiTGo8x5
 VrZ81EH/12jJ7ECCLxHuktJgaFONdjAI6a+h/usAx6J/kq+B/WZZm2tZQZU9bdN+xstgv9xf/Qr
 7R5fu2y8ndVRIglAZE9zI+JDmQN0NtZsvnCxxA==
X-Received: by 2002:a05:6214:20c3:b0:790:3b37:8ec6 with SMTP id
 6a1803df08f44-879dc77bb05mr42056196d6.13.1759506033624; 
 Fri, 03 Oct 2025 08:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd4VA2qvnbzFaO22cJuyuRxlzQHKK1hgHhxKZXvW5VwbTM1fIdk0MrR1Zu+HSfvTWJZWHK/Q==
X-Received: by 2002:a05:6214:20c3:b0:790:3b37:8ec6 with SMTP id
 6a1803df08f44-879dc77bb05mr42055696d6.13.1759506033120; 
 Fri, 03 Oct 2025 08:40:33 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 29/45] migration: HMP: Adjust the order of output fields
Date: Fri,  3 Oct 2025 11:39:32 -0400
Message-ID: <20251003153948.1304776-30-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

Adjust the positions of 'tls-authz' and 'max-postcopy-bandwidth' in
the fields output by the 'info migrate_parameters' command so that
related fields are next to each other.

For clarity only, no functional changes.

Sample output after this commit:
(qemu) info migrate_parameters
...
max-cpu-throttle: 99
tls-creds: ''
tls-hostname: ''
tls-authz: ''
max-bandwidth: 134217728 bytes/second
avail-switchover-bandwidth: 0 bytes/second
max-postcopy-bandwidth: 0 bytes/second
downtime-limit: 300 ms
...

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250929021213.28369-1-guobin@linux.alibaba.com
[peterx: move postcopy-bw before avail-switchover-bw]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0fc21f0647..814221b260 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -353,6 +353,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
             params->tls_hostname);
+        assert(params->tls_authz);
+        monitor_printf(mon, "%s: '%s'\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
+            params->tls_authz);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
@@ -361,6 +365,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
             params->avail_switchover_bandwidth);
+        assert(params->has_max_postcopy_bandwidth);
+        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
+            params->max_postcopy_bandwidth);
         assert(params->has_downtime_limit);
         monitor_printf(mon, "%s: %" PRIu64 " ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
@@ -383,12 +391,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
-        monitor_printf(mon, "%s: %" PRIu64 "\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
-            params->max_postcopy_bandwidth);
-        monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->tls_authz);
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
-- 
2.50.1



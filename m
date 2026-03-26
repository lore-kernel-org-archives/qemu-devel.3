Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD01106F2E1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5fMp-0001LO-R6; Thu, 26 Mar 2026 03:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5fMo-0001Kd-2O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5fMm-0003OQ-Bd
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774510975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJJl4g+pm93/aFX9CDaHwTcxxJ7X1MbqgcUNI7Fijsg=;
 b=dPoG9WHU+/AcfPh1QPZ8NLFgwpJqY3Eai1szDSXs9EPeOArUlwcI7wYhl8TSdQ1ki87XUe
 uBBAvKaur5xX89vUeMYqO1BgZPgu54Js6q3tXv/RRyuWn3ymU8YNTKC9paCyYLULqTb3TB
 3m7sRMejhStjEbh8PmZYvoWZ9a78q+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-sm1l_uuHNbuIS0CupWDpSw-1; Thu,
 26 Mar 2026 03:42:51 -0400
X-MC-Unique: sm1l_uuHNbuIS0CupWDpSw-1
X-Mimecast-MFC-AGG-ID: sm1l_uuHNbuIS0CupWDpSw_1774510971
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E90A919560A6; Thu, 26 Mar 2026 07:42:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68FE91800351; Thu, 26 Mar 2026 07:42:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E052121E66C9; Thu, 26 Mar 2026 08:42:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 2/3] migration: Fix references to parameter names in error
 messages
Date: Thu, 26 Mar 2026 08:42:46 +0100
Message-ID: <20260326074247.188674-3-armbru@redhat.com>
In-Reply-To: <20260326074247.188674-1-armbru@redhat.com>
References: <20260326074247.188674-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Migration parameter names separate words with hyphens.  A number of
error messages in migrate_params_check() use underscores instead.
Wrong since day one.  Fix them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/options.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3eb5b39186..7556fbc06b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1133,103 +1133,103 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->throttle_trigger_threshold < 1 ||
         params->throttle_trigger_threshold > 100) {
-        error_setg(errp, "Option throttle_trigger_threshold expects "
+        error_setg(errp, "Option throttle-trigger-threshold expects "
                    "an integer in the range of 1 to 100");
         return false;
     }
 
     if (params->cpu_throttle_initial < 1 ||
         params->cpu_throttle_initial > 99) {
-        error_setg(errp, "Option cpu_throttle_initial expects "
+        error_setg(errp, "Option cpu-throttle-initial expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->cpu_throttle_increment < 1 ||
         params->cpu_throttle_increment > 99) {
-        error_setg(errp, "Option cpu_throttle_increment expects "
+        error_setg(errp, "Option cpu-throttle-increment expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->max_bandwidth > SIZE_MAX) {
-        error_setg(errp, "Option max_bandwidth expects "
+        error_setg(errp, "Option max-bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->avail_switchover_bandwidth > SIZE_MAX) {
-        error_setg(errp, "Option avail_switchover_bandwidth expects "
+        error_setg(errp, "Option avail-switchover-bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->downtime_limit > MAX_MIGRATE_DOWNTIME) {
-        error_setg(errp, "Option downtime_limit expects "
+        error_setg(errp, "Option downtime-limit expects "
                    "an integer in the range of 0 to "
                     stringify(MAX_MIGRATE_DOWNTIME)" ms");
         return false;
     }
 
     if (params->multifd_channels < 1) {
-        error_setg(errp, "Option multifd_channels expects "
+        error_setg(errp, "Option multifd-channels expects "
                    "a value between 1 and 255");
         return false;
     }
 
     if (params->multifd_zlib_level > 9) {
-        error_setg(errp, "Option multifd_zlib_level expects "
+        error_setg(errp, "Option multifd-zlib-level expects "
                    "a value between 0 and 9");
         return false;
     }
 
     if (params->multifd_qatzip_level > 9 ||
         params->multifd_qatzip_level < 1) {
-        error_setg(errp, "Option multifd_qatzip_level expects "
+        error_setg(errp, "Option multifd-qatzip-level expects "
                    "a value between 1 and 9");
         return false;
     }
 
     if (params->multifd_zstd_level > 20) {
-        error_setg(errp, "Option multifd_zstd_level expects "
+        error_setg(errp, "Option multifd-zstd-level expects "
                    "a value between 0 and 20");
         return false;
     }
 
     if (params->xbzrle_cache_size < qemu_target_page_size() ||
         !is_power_of_2(params->xbzrle_cache_size)) {
-        error_setg(errp, "Option xbzrle_cache_size expects "
+        error_setg(errp, "Option xbzrle-cache-size expects "
                    "a power of two no less than the target page size");
         return false;
     }
 
     if (params->max_cpu_throttle < params->cpu_throttle_initial ||
         params->max_cpu_throttle > 99) {
-        error_setg(errp, "Option max_cpu_throttle expects "
-                   "an integer in the range of cpu_throttle_initial to 99");
+        error_setg(errp, "Option max-cpu-throttle expects "
+                   "an integer in the range of cpu-throttle-initial to 99");
         return false;
     }
 
     if (params->announce_initial > 100000) {
-        error_setg(errp, "Option announce_initial expects "
+        error_setg(errp, "Option announce-initial expects "
                    "a value between 0 and 100000");
         return false;
     }
     if (params->announce_max > 100000) {
-        error_setg(errp, "Option announce_max expects "
+        error_setg(errp, "Option announce-max expects "
                    "a value between 0 and 100000");
         return false;
     }
     if (params->announce_rounds > 1000) {
-        error_setg(errp, "Option announce_rounds expects "
+        error_setg(errp, "Option announce-rounds expects "
                    "a value between 0 and 1000");
         return false;
     }
     if (params->announce_step < 1 ||
         params->announce_step > 10000) {
-        error_setg(errp, "Option announce_step expects "
+        error_setg(errp, "Option announce-step expects "
                    "a value between 0 and 10000");
         return false;
     }
@@ -1264,7 +1264,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->vcpu_dirty_limit < 1) {
         error_setg(errp,
-                   "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s");
+                   "Parameter 'vcpu-dirty-limit' must be greater than 1 MB/s");
         return false;
     }
 
-- 
2.53.0



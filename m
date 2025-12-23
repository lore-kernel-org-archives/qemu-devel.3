Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C639E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Q9-0002tD-UY; Tue, 23 Dec 2025 09:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PT-0001KQ-Qr
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0003p5-Rv
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7WbYF7qYMna7oUmNsPZRA2X5VE2aXwMx0VCq9+LsYw=;
 b=CAQxgr+XrKXF20CIMIQ3Pg6Wx6M3Olg5fjTp8okqdNX297S7H5/fZf9X5yEADt5IbU8rcS
 o+kmdfci8iGRPncsDthoCfRVKwuPMAfjcWEd+1cBXrkjzcV18qq/J37X3nHI0w4fZmrsUc
 k0lkwVTtM2khNhNhFsoE0HVZqlK5INM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-iZ6Rz83vOgKfPi2HNrbAqg-1; Tue, 23 Dec 2025 09:30:35 -0500
X-MC-Unique: iZ6Rz83vOgKfPi2HNrbAqg-1
X-Mimecast-MFC-AGG-ID: iZ6Rz83vOgKfPi2HNrbAqg_1766500234
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b6963d1624so1222449385a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500234; x=1767105034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7WbYF7qYMna7oUmNsPZRA2X5VE2aXwMx0VCq9+LsYw=;
 b=bkxJF/tozMGbZXCrWJru8jnukgt4y8u87a3psDmlXO0Ag4vY18HaKSGCtyCLUtgOrl
 VnZm04VT9ImdVAnZX5F2HjKtKZJCaJYUqg88JWlzbW+YhebcufiGS9VLjoYkdCBSQvqj
 /62+upUjLoF/fldsWBACopNy1X+Ky6uaslJwsce2uskiz5kJBgKmmsEUQgq2/AygcqXL
 FR0RO0tfKVOemOxxNmcV5EB9nyWK1pfTS8K3CHjpOMiI1f5AMQCxbI7BOIXRhVCPeoFO
 ozcpYBWmM7+r1//myx30jFLz2i/NX5vf5tpYiw11wWn21/cyaBwzSOts+/emu0//67ao
 +QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500234; x=1767105034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7WbYF7qYMna7oUmNsPZRA2X5VE2aXwMx0VCq9+LsYw=;
 b=ltERQ0Lmq17txr2fJxkeOGGfgfk8TEwVrpJ4JTkQSqQlCaPU/6icL89TT+ZEihPbUq
 QvsP/JzCjg3uInOjJPbTbHFFbbgQxIKWpfvHo2z6dVZH5g27E/2Yx7c5KoRTO8eVhqWc
 rp1JjH9VpNOtq7ElIGW7WEJF/WBUL8u5/rian0GrYhQq0WDps0leimlHPGNivvs5sRfz
 a8nhRlSy+0vbWNTl2omzYwNLyizGLCBTB/ubDOPM2WJRHghVDPhAxELaxHPiKQ2UODYj
 2I10Bh753XqWBCBjXsolbIP4jqVvYjBIt3+HbJXLWAHNi99PrWGqJS6TobDdSK0sDRDg
 Ml9w==
X-Gm-Message-State: AOJu0Yx1XQho8MeVLNAIXAZftz8v2m+ZfO3mXbnAnxTXuD5Pk8iztxl9
 xizmpUt3LwB0XvMH23J4Z5RM5hCkkFjFZboBxCoydDjU/dtDEyBrmgxmKKqIeMnR62vRNRQXnEW
 TXA2qj4LIHi3gD3ASvr6NGOeH398Ue2mHFlCV3SvbgNUIp1NEkAim9c18Lx1wqBEufyMostC7ay
 DrNF6yG/q1OdL5kypBkCyktScRlnVt3LB85ud1SA==
X-Gm-Gg: AY/fxX6SDVHJ+OfEg0LiOuTOEpW0LccxmxrI4FHo5Tj98Sxxl1ea+rRWHnsgjY/orku
 T48YtObwPlnvwh5y0N6SFFc/2KhLUBouVhFMUtSPGkGq+jm0F1gQeTsO3jYixXB2foesnG8/T4n
 3xxBUwsYIwr4qDfSFgiI0Q7zP+ay7ZNaq2/l2M6FAbnbZotvNAkPHYkOg87yyRLJkluHEWmIE6L
 PyRyYoM9pEsAkA/XzY5BrOHFCbPx6dDV+QDF/4rGkJ8yJd+opjPdQMToO00mkh1auW4Da19B7Af
 ynW3w5FA24Hdm1vOXmtzpEGcmVAeteGwZmEAS6LbK72JKDXbfHQaq0lrTCpCVvnb5sI/JMFnqjT
 14JI=
X-Received: by 2002:a05:620a:46a6:b0:892:25d5:2ec with SMTP id
 af79cd13be357-8c08f668c10mr2222175185a.27.1766500233827; 
 Tue, 23 Dec 2025 06:30:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT4fG0zo4SG3pvlNLbarIY23bYy/HxTwhLrFb1xh0SOh5+I1KaL6w0oS41wx3cAsfbJqe40g==
X-Received: by 2002:a05:620a:46a6:b0:892:25d5:2ec with SMTP id
 af79cd13be357-8c08f668c10mr2222141085a.27.1766500231367; 
 Tue, 23 Dec 2025 06:30:31 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:30 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 24/31] migration: Remove checks for s->parameters has_* fields
Date: Tue, 23 Dec 2025 09:29:52 -0500
Message-ID: <20251223142959.1460293-25-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The migration parameters validation produces a temporary structure
which is the merge of the current parameter values (s->parameters,
MigrationParameters) with the new parameters set by the user
(former MigrateSetParameters).

When copying the values from s->parameters into the temporary
structure, the has_* fields are copied along, but when merging the
user-input values they are not.

During migrate_params_check(), only the parameters that have the
corresponding has_* field will be checked, so only the parameters that
were initialized in migrate_params_init() will be validated.

This causes (almost) all of the migration parameters to be validated
every time a parameter is set, regardless of which fields the user
touched, but it also skips validation of any values that are not set
in migrate_params_init().

It's not clear what was the intention of the original code, whether to
validate all fields always, or only validate what the user input
changed. Since the current situation is closer to the former option,
make the choice of validating all parameters by removing the checks
for the has_* fields when validating.

Note that bringing the user input into the temporary structure for
validation still needs to look at the has_* fields, otherwise any
parameters not set by the user (i.e. 0) would override the
corresponding value in s->parameters.

The empty migrate_params_init() will be kept because subsequent
patches will add code to it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-11-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c |   2 +-
 migration/options.c   | 102 ++++++++++++------------------------------
 2 files changed, 30 insertions(+), 74 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f1378c3bf4..754abe0b5a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2118,7 +2118,7 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC &&
-        !s->parameters.has_cpr_exec_command) {
+        !s->parameters.cpr_exec_command) {
         error_setg(errp, "cpr-exec mode requires setting cpr-exec-command");
         return false;
     }
diff --git a/migration/options.c b/migration/options.c
index 20e9438656..35fbe9a6ef 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1097,32 +1097,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
-    /* Set has_* up only for parameter checks */
-    params->has_throttle_trigger_threshold = true;
-    params->has_cpu_throttle_initial = true;
-    params->has_cpu_throttle_increment = true;
-    params->has_cpu_throttle_tailslow = true;
-    params->has_max_bandwidth = true;
-    params->has_downtime_limit = true;
-    params->has_x_checkpoint_delay = true;
-    params->has_multifd_channels = true;
-    params->has_multifd_compression = true;
-    params->has_multifd_zlib_level = true;
-    params->has_multifd_qatzip_level = true;
-    params->has_multifd_zstd_level = true;
-    params->has_xbzrle_cache_size = true;
-    params->has_max_postcopy_bandwidth = true;
-    params->has_max_cpu_throttle = true;
-    params->has_announce_initial = true;
-    params->has_announce_max = true;
-    params->has_announce_rounds = true;
-    params->has_announce_step = true;
-    params->has_x_vcpu_dirty_limit_period = true;
-    params->has_vcpu_dirty_limit = true;
-    params->has_mode = true;
-    params->has_zero_page_detection = true;
-    params->has_direct_io = true;
-    params->has_cpr_exec_command = true;
 }
 
 static void migrate_post_update_params(MigrationParameters *new, Error **errp)
@@ -1158,34 +1132,31 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 {
     ERRP_GUARD();
 
-    if (params->has_throttle_trigger_threshold &&
-        (params->throttle_trigger_threshold < 1 ||
-         params->throttle_trigger_threshold > 100)) {
+    if (params->throttle_trigger_threshold < 1 ||
+        params->throttle_trigger_threshold > 100) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "throttle_trigger_threshold",
                    "an integer in the range of 1 to 100");
         return false;
     }
 
-    if (params->has_cpu_throttle_initial &&
-        (params->cpu_throttle_initial < 1 ||
-         params->cpu_throttle_initial > 99)) {
+    if (params->cpu_throttle_initial < 1 ||
+        params->cpu_throttle_initial > 99) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "cpu_throttle_initial",
                    "an integer in the range of 1 to 99");
         return false;
     }
 
-    if (params->has_cpu_throttle_increment &&
-        (params->cpu_throttle_increment < 1 ||
-         params->cpu_throttle_increment > 99)) {
+    if (params->cpu_throttle_increment < 1 ||
+        params->cpu_throttle_increment > 99) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "cpu_throttle_increment",
                    "an integer in the range of 1 to 99");
         return false;
     }
 
-    if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX)) {
+    if (params->max_bandwidth > SIZE_MAX) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "max_bandwidth",
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
@@ -1193,8 +1164,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_avail_switchover_bandwidth &&
-        (params->avail_switchover_bandwidth > SIZE_MAX)) {
+    if (params->avail_switchover_bandwidth > SIZE_MAX) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "avail_switchover_bandwidth",
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
@@ -1202,8 +1172,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_downtime_limit &&
-        (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
+    if (params->downtime_limit > MAX_MIGRATE_DOWNTIME) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "downtime_limit",
                    "an integer in the range of 0 to "
@@ -1213,93 +1182,82 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
-    if (params->has_multifd_channels && (params->multifd_channels < 1)) {
+    if (params->multifd_channels < 1) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
                    "a value between 1 and 255");
         return false;
     }
 
-    if (params->has_multifd_zlib_level &&
-        (params->multifd_zlib_level > 9)) {
+    if (params->multifd_zlib_level > 9) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_level",
                    "a value between 0 and 9");
         return false;
     }
 
-    if (params->has_multifd_qatzip_level &&
-        ((params->multifd_qatzip_level > 9) ||
-        (params->multifd_qatzip_level < 1))) {
+    if (params->multifd_qatzip_level > 9 ||
+        params->multifd_qatzip_level < 1) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
                    "a value between 1 and 9");
         return false;
     }
 
-    if (params->has_multifd_zstd_level &&
-        (params->multifd_zstd_level > 20)) {
+    if (params->multifd_zstd_level > 20) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
                    "a value between 0 and 20");
         return false;
     }
 
-    if (params->has_xbzrle_cache_size &&
-        (params->xbzrle_cache_size < qemu_target_page_size() ||
-         !is_power_of_2(params->xbzrle_cache_size))) {
+    if (params->xbzrle_cache_size < qemu_target_page_size() ||
+        !is_power_of_2(params->xbzrle_cache_size)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "xbzrle_cache_size",
                    "a power of two no less than the target page size");
         return false;
     }
 
-    if (params->has_max_cpu_throttle &&
-        (params->max_cpu_throttle < params->cpu_throttle_initial ||
-         params->max_cpu_throttle > 99)) {
+    if (params->max_cpu_throttle < params->cpu_throttle_initial ||
+        params->max_cpu_throttle > 99) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "max_cpu_throttle",
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
 
-    if (params->has_announce_initial &&
-        params->announce_initial > 100000) {
+    if (params->announce_initial > 100000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_initial",
                    "a value between 0 and 100000");
         return false;
     }
-    if (params->has_announce_max &&
-        params->announce_max > 100000) {
+    if (params->announce_max > 100000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_max",
                    "a value between 0 and 100000");
        return false;
     }
-    if (params->has_announce_rounds &&
-        params->announce_rounds > 1000) {
+    if (params->announce_rounds > 1000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_rounds",
                    "a value between 0 and 1000");
        return false;
     }
-    if (params->has_announce_step &&
-        (params->announce_step < 1 ||
-        params->announce_step > 10000)) {
+    if (params->announce_step < 1 ||
+        params->announce_step > 10000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "announce_step",
                    "a value between 0 and 10000");
        return false;
     }
 
-    if (params->has_block_bitmap_mapping &&
-        !check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
+    if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
         error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
         return false;
     }
 
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
-        ((params->has_multifd_compression && params->multifd_compression) ||
-         *params->tls_creds->u.s)) {
+        (params->multifd_compression || *params->tls_creds->u.s)) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
@@ -1313,23 +1271,21 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_x_vcpu_dirty_limit_period &&
-        (params->x_vcpu_dirty_limit_period < 1 ||
-         params->x_vcpu_dirty_limit_period > 1000)) {
+    if (params->x_vcpu_dirty_limit_period < 1 ||
+        params->x_vcpu_dirty_limit_period > 1000) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "x-vcpu-dirty-limit-period",
                    "a value between 1 and 1000");
         return false;
     }
 
-    if (params->has_vcpu_dirty_limit &&
-        (params->vcpu_dirty_limit < 1)) {
+    if (params->vcpu_dirty_limit < 1) {
         error_setg(errp,
                    "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s");
         return false;
     }
 
-    if (params->has_direct_io && params->direct_io && !qemu_has_direct_io()) {
+    if (params->direct_io && !qemu_has_direct_io()) {
         error_setg(errp, "No build-time support for direct-io");
         return false;
     }
-- 
2.50.1



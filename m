Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6A2E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3QR-0003pX-IH; Tue, 23 Dec 2025 09:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PR-0001K6-Um
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0003ot-RQ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g1e2RcMyr3RE9l6mWQowsXU+sG/GbnP/uOGtbzUCGU=;
 b=VNAiiXx2K7sJjaQG1gIXpELThLRuwpDC1ytY+My/ycyue89bolfbbnbL3QziG7CsTLRSU6
 j7SGipB74wi6IN5Gj+sLTXTY3B+0aIJ3gUNFTGDFHAL1J65BTIHtYVI8bqwEzrLoSPhfG9
 BIUgPQkhW5ERKSGaSMzZPmKVZBi0SKA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-sVbzgi3PMQahHjRX7rTBHw-1; Tue, 23 Dec 2025 09:30:34 -0500
X-MC-Unique: sVbzgi3PMQahHjRX7rTBHw-1
X-Mimecast-MFC-AGG-ID: sVbzgi3PMQahHjRX7rTBHw_1766500234
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8bbe16e0a34so1182825685a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500233; x=1767105033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/g1e2RcMyr3RE9l6mWQowsXU+sG/GbnP/uOGtbzUCGU=;
 b=SXNGX7djAMJfaXEv4SMIwkEhfvAwMZC+vGH0gvODvplfic3IBbOQMHEIK2zif2zpL9
 R3ctRzJgQbJMhu8sfQpsLmWXmXYYfxMx2qwRZMcoE24a/nbFmUj3vXhxt3gpS+r0oy28
 rivLvOnZrTyznCLDJgOJLCnG24M2A2Vy6GOa19HrVBXAaPj+PWGMoH4v9ogP55eTO5oO
 SKQl4UV2p12pcdB1ptOfaWwmNUuMuwiQe2CkVxW9YjrcMGFlhqr8sZ9sSpB0YCFo04v2
 GeIdNdNqmKLRX8WYAeckEFO8F2ZOxsTiP+XLNd74mrk7d0GLh0OXh8A45Kh5lK4i04hR
 9jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500233; x=1767105033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/g1e2RcMyr3RE9l6mWQowsXU+sG/GbnP/uOGtbzUCGU=;
 b=qsF/xfN4OrtfkUc/jy955nCcYaR6/AO2hsdLM8BRgfpuQNRjoYfc23ik6475n81hn2
 KN/pkDIG+/GrzFnw3IHHWgV0Y12mMFspwM7nxlqIIo88OPpdXk+Ly1z4C3XPgb2OPP2R
 DKveAlXWMGKOxnvat+dYNxQznpTtGU8mGSdQOJziFAt0EP7VYgKfz5hpuwBuQQoiPqa3
 dZaCoBcIhlTlB0ziU7MCvCd6Fs5ZBhD7BA1SEIJPHi+XueIA5SatgpYXqmD9hJ99twhE
 JSZfwvZ3Z1r6/WF7ybPHhi7xTSECfPxjc7UMCNmJb2quA4tUxr/SJhgATWGZbjxhTQ79
 O7oA==
X-Gm-Message-State: AOJu0YyM7zqZpUbDHAKtvtEiBwIRYePTgCluESK7owqq+GIIkp5Lo6H6
 lp525FY6vLfAs1NX7HVZ5+lgDlS4NCXLi03K3/68057pVlKZHNfviH0mHRB/RVSaLuTcSIkw2mt
 6Pn7yO+K4S1uZX6XpiWqvpZ5CzB1+IFFUYNaiBTX7gJGHuSrumb9TjK6kw6Yby9UMwDaK/yOKJo
 uTEcbM2n750FrQxtSnCIyY6rqP+hovhutAw8D4wQ==
X-Gm-Gg: AY/fxX7qzoiN7tmAQQBVaCqEA3i3KCPrU5M4he4Z6jXXFjegH7QI2XVoCb+FS1JdC6I
 xc+dFzNg7AIwbM3vfHv68K8pZrr762EpQkBysUPpgq+r4SQ0+Yyj+hlJwF2pXtT/XeRwlS+k12f
 8iUuDmdTuXqBWiXdY9ge34NaGRdZhYY3XY/+5ccf00mFq39T//yN7ihI58ceD/8de7u4OpSjuZI
 5qbbuhPDPFHE5YIBSp8V4vGRzMRiNbfzfzkVluSZqJcInYz+hUk3VDlKfyHnBcZIgMJ1woXvOGd
 MPk2jYFoJMcaPY6ewH+v0pVsGagcyh/uBTspEpxkJJnOZCfmMY0wY6RoAaj2XiJYMC7Tj2txXro
 VRL8=
X-Received: by 2002:a05:620a:29c4:b0:811:8bbe:7a3c with SMTP id
 af79cd13be357-8bee76c9096mr2672330285a.23.1766500233040; 
 Tue, 23 Dec 2025 06:30:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIAhZajexBkeW+o28RuHCxW/3WqbnMAWo3/m28v3MnRpaw3CaulsnjbAwwnxpp6jlvUH+3Aw==
X-Received: by 2002:a05:620a:29c4:b0:811:8bbe:7a3c with SMTP id
 af79cd13be357-8bee76c9096mr2672322285a.23.1766500232399; 
 Tue, 23 Dec 2025 06:30:32 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:31 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 25/31] migration: Do away with usage of
 QERR_INVALID_PARAMETER_VALUE
Date: Tue, 23 Dec 2025 09:29:53 -0500
Message-ID: <20251223142959.1460293-26-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

The QERR_INVALID_PARAMETER_VALUE macro is documented as not to be used
in new code. Remove the usage from migration/options.c.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-12-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  |  3 +--
 migration/options.c    | 56 +++++++++++++++---------------------------
 migration/page_cache.c |  6 ++---
 migration/ram.c        |  3 +--
 4 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 754abe0b5a..635851fe8c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2325,8 +2325,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
         file_start_outgoing_migration(s, &addr->u.file, &local_err);
     } else {
-        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
-                   "a valid migration protocol");
+        error_setg(&local_err, "uri is not a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
     }
diff --git a/migration/options.c b/migration/options.c
index 35fbe9a6ef..4652478e6a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1134,120 +1134,105 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->throttle_trigger_threshold < 1 ||
         params->throttle_trigger_threshold > 100) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "throttle_trigger_threshold",
+        error_setg(errp, "Option throttle_trigger_threshold expects "
                    "an integer in the range of 1 to 100");
         return false;
     }
 
     if (params->cpu_throttle_initial < 1 ||
         params->cpu_throttle_initial > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "cpu_throttle_initial",
+        error_setg(errp, "Option cpu_throttle_initial expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->cpu_throttle_increment < 1 ||
         params->cpu_throttle_increment > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "cpu_throttle_increment",
+        error_setg(errp, "Option cpu_throttle_increment expects "
                    "an integer in the range of 1 to 99");
         return false;
     }
 
     if (params->max_bandwidth > SIZE_MAX) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "max_bandwidth",
+        error_setg(errp, "Option max_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->avail_switchover_bandwidth > SIZE_MAX) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "avail_switchover_bandwidth",
+        error_setg(errp, "Option avail_switchover_bandwidth expects "
                    "an integer in the range of 0 to "stringify(SIZE_MAX)
                    " bytes/second");
         return false;
     }
 
     if (params->downtime_limit > MAX_MIGRATE_DOWNTIME) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "downtime_limit",
+        error_setg(errp, "Option downtime_limit expects "
                    "an integer in the range of 0 to "
                     stringify(MAX_MIGRATE_DOWNTIME)" ms");
         return false;
     }
 
-    /* x_checkpoint_delay is now always positive */
-
     if (params->multifd_channels < 1) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "multifd_channels",
+        error_setg(errp, "Option multifd_channels expects "
                    "a value between 1 and 255");
         return false;
     }
 
     if (params->multifd_zlib_level > 9) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zlib_level",
+        error_setg(errp, "Option multifd_zlib_level expects "
                    "a value between 0 and 9");
         return false;
     }
 
     if (params->multifd_qatzip_level > 9 ||
         params->multifd_qatzip_level < 1) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_qatzip_level",
+        error_setg(errp, "Option multifd_qatzip_level expects "
                    "a value between 1 and 9");
         return false;
     }
 
     if (params->multifd_zstd_level > 20) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "multifd_zstd_level",
+        error_setg(errp, "Option multifd_zstd_level expects "
                    "a value between 0 and 20");
         return false;
     }
 
     if (params->xbzrle_cache_size < qemu_target_page_size() ||
         !is_power_of_2(params->xbzrle_cache_size)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "xbzrle_cache_size",
+        error_setg(errp, "Option xbzrle_cache_size expects "
                    "a power of two no less than the target page size");
         return false;
     }
 
     if (params->max_cpu_throttle < params->cpu_throttle_initial ||
         params->max_cpu_throttle > 99) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "max_cpu_throttle",
+        error_setg(errp, "max_Option cpu_throttle expects "
                    "an integer in the range of cpu_throttle_initial to 99");
         return false;
     }
 
     if (params->announce_initial > 100000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_initial",
+        error_setg(errp, "Option announce_initial expects "
                    "a value between 0 and 100000");
         return false;
     }
     if (params->announce_max > 100000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_max",
+        error_setg(errp, "Option announce_max expects "
                    "a value between 0 and 100000");
-       return false;
+        return false;
     }
     if (params->announce_rounds > 1000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_rounds",
+        error_setg(errp, "Option announce_rounds expects "
                    "a value between 0 and 1000");
-       return false;
+        return false;
     }
     if (params->announce_step < 1 ||
         params->announce_step > 10000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "announce_step",
+        error_setg(errp, "Option announce_step expects "
                    "a value between 0 and 10000");
-       return false;
+        return false;
     }
 
     if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
@@ -1273,8 +1258,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->x_vcpu_dirty_limit_period < 1 ||
         params->x_vcpu_dirty_limit_period > 1000) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "x-vcpu-dirty-limit-period",
+        error_setg(errp, "Option x-vcpu-dirty-limit-period expects "
                    "a value between 1 and 1000");
         return false;
     }
diff --git a/migration/page_cache.c b/migration/page_cache.c
index 6d4f7a9bbc..650b15e48c 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -45,15 +45,13 @@ PageCache *cache_init(uint64_t new_size, size_t page_size, Error **errp)
     PageCache *cache;
 
     if (new_size < page_size) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is smaller than one target page size");
+        error_setg(errp, "cache size is smaller than target page size");
         return NULL;
     }
 
     /* round down to the nearest power of 2 */
     if (!is_power_of_2(num_pages)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is not a power of two number of pages");
+        error_setg(errp, "number of pages is not a power of two");
         return NULL;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 18e4e26eaf..df7e154877 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -193,8 +193,7 @@ int xbzrle_cache_resize(uint64_t new_size, Error **errp)
 
     /* Check for truncation */
     if (new_size != (size_t)new_size) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "exceeding address space");
+        error_setg(errp, "xbzrle cache size integer overflow");
         return -1;
     }
 
-- 
2.50.1



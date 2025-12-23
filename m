Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C60E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3QQ-0003e5-83; Tue, 23 Dec 2025 09:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PT-0001KR-Qp
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0003pH-S9
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16WwaROPOGxqzPPrcHj/Vz1tZC3raJ52XyW9rKxC2Ho=;
 b=D+gsi6ZW4HC55heW3oFunQEnBGeE/9HkuDBctYPWMb3zQMKMegphWHAMVP3+2kJAFDnRaE
 gCIfkwZz4FLKW0hGnRRiS1sLb4ccoSQvQ20QO5qw9utfMKc/on1vYfTsdoDIvjKMifDS5x
 El99sZoejMGVaOF8CrwCCVbTl5Yg21s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-7DOr1DeaPC2Om_7I1aABDg-1; Tue, 23 Dec 2025 09:30:36 -0500
X-MC-Unique: 7DOr1DeaPC2Om_7I1aABDg-1
X-Mimecast-MFC-AGG-ID: 7DOr1DeaPC2Om_7I1aABDg_1766500235
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b234bae2a7so1193323885a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500235; x=1767105035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16WwaROPOGxqzPPrcHj/Vz1tZC3raJ52XyW9rKxC2Ho=;
 b=J3i0ANvp0gBBKwOQluATsoZGNLKcS9GXnZ6pI7+8DJo6nLENJFUtfxsFMcF6exBSlg
 Qq/Cylz0FLD+EmiFMkhaPLGRahRvfCd0w0eSS4JZjonp7h1GTwUTu2/TN+yLcJPE0Qp+
 wRlTmgpQcPAuzYoIk2eUHwyYq09JgVDYxRJO3waDL4t83jD6X5VavWw7kwCUwBcZkVaz
 Wzacby436nogoBY2q9VnQEqYRB9CCSvqLVGt1QRDW6m3UBtQpWGKhIk0OTXRIEoJHNP+
 aPqnahZfVGS3zhVKe4qFdUys0q111tXDX7MTwSBsnqwTkN+IIMu0omlp7MIN6zbtinhU
 OcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500235; x=1767105035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=16WwaROPOGxqzPPrcHj/Vz1tZC3raJ52XyW9rKxC2Ho=;
 b=T4CdHsRU1g5XWGvUM2OYOQYFZONy4OyJ151DxEvXNUpWN8nC7yMY1gb0t8FyZj68lp
 Shp/JWURJe4rrBvCe9AEwU5kQJphRaklnIQlq2eanhyJGFJG00dWTdFG+ms6uSs70F+m
 QpKUHrO+dnalggqel/mCti/GyqGWTWfAy7NTwcnFh38wUA7h3NIluZdMjFAJWWLmvS1d
 DPYcOcx5J7T5FODjsP2w/Ss933ARmwm2gwe9k8C+kCi49SiwmnQO+wEFPgp1ozhyq7hN
 wXTchBX24kVZ0p8q9j6IOzL0a1o2QIa6SAZKad0360cuzIUFC5C5lGBY0WzZopUGBbRI
 iqrQ==
X-Gm-Message-State: AOJu0Yx/KwcfA2+5sy946hBOLOUYssqZZMrfBxEpWvcXAMR4Ggrr1kql
 hRzQ08jAHT5ppWEhp2ibHy/4gsy50ACVMewz15KQJ4hpzwLBED+kr96UIA2mBXp8CkARjZRoU7m
 ktyTWaXZaxKUH3eZtMckLsXfjX0N51F0WJ9caSyhLCIGiqkW5OwT4l7Fqa1EDPL4BZ9msVC5Iqa
 fj6xY3Nx7PPM8AQbnw5takSR3OLSNZFLPULwsPRg==
X-Gm-Gg: AY/fxX7FYcwl0REFQ5wOkqFmokbQ1Ooe/vZ5R+noc+ELm52rJJhdlyCK0zFELESPLV3
 yotLsn5HZQfKpWmZS87BpeN2DCJaHwwCIGnAuC1q6hzObeVKbjvM8RmXZwUv7+vuzY0zh1uJ3bB
 xhNy1mrO4fQbXd1Uz9isjNa2FCGeQFGNn0VNQAGhrToJzwqO22V1dUIsvBJClFHgWpvUUuukZcX
 iAkcTJkfS/WjyjBnqDMBZ5L4YCOsjNqKVZNbTRM1BmrpP6j4Wk/TEta4Oy8FY7IQUABUCPzaRO0
 hhK5w1YiEM+854wQl4VUzpV9q21AvJOKRrOD/SxCoOBpFT3gz91gIsm8BLlzgCfVcTYkxwUTDg/
 P1vo=
X-Received: by 2002:a05:620a:4445:b0:8b2:ea3f:2f91 with SMTP id
 af79cd13be357-8c08fbc1f3bmr2153028485a.81.1766500234661; 
 Tue, 23 Dec 2025 06:30:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk0DIg/kA/mqtXdQCOTyF3N+cNqou0KdevcnVKKJys/3bzrDl1HkuPrUWXrabPQAuOsWupvg==
X-Received: by 2002:a05:620a:4445:b0:8b2:ea3f:2f91 with SMTP id
 af79cd13be357-8c08fbc1f3bmr2153018785a.81.1766500233833; 
 Tue, 23 Dec 2025 06:30:33 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:32 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 26/31] migration: Extract code to mark all parameters as present
Date: Tue, 23 Dec 2025 09:29:54 -0500
Message-ID: <20251223142959.1460293-27-peterx@redhat.com>
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

MigrationParameters needs to have all of its has_* fields marked as
true when used as the return of query_migrate_parameters because the
corresponding QMP command has all of its members non-optional by
design, despite them being marked as optional in migration.json.

Extract this code into a function and make it assert if any field is
missing. With this we ensure future changes will not inadvertently
leave any parameters missing.

Note that the block-bitmap-mapping is a special case because the empty
list is considered a valid value, so it has historically not been
present in the command's output if it has never been set.

CC: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-13-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 89 ++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 4652478e6a..418cb44413 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1020,6 +1020,44 @@ static void tls_opt_to_str(StrOrNull *opt)
     opt->u.s = g_strdup("");
 }
 
+/*
+ * query-migrate-parameters expects all members of MigrationParameters
+ * to be present, but we cannot mark them non-optional in QAPI because
+ * the structure is also used for migrate-set-parameters, which needs
+ * the optionality. Force all parameters to be seen as present
+ * now. Note that this depends on some form of default being set for
+ * every member of MigrationParameters, currently done during qdev
+ * init using migration_properties defined in this file. The TLS
+ * options are a special case because they don't have a default and
+ * need to be normalized before use.
+ */
+static void migrate_mark_all_params_present(MigrationParameters *p)
+{
+    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
+    bool *has_fields[] = {
+        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
+        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
+        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
+        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
+        &p->has_multifd_channels, &p->has_multifd_compression,
+        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
+        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
+        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
+        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
+        &p->has_announce_step, &p->has_block_bitmap_mapping,
+        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
+        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
+        &p->has_cpr_exec_command,
+    };
+
+    len = ARRAY_SIZE(has_fields);
+    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
+
+    for (int i = 0; i < len; i++) {
+        *has_fields[i] = true;
+    }
+}
+
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationParameters *params;
@@ -1027,70 +1065,53 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
     params = g_malloc0(sizeof(*params));
-    params->has_throttle_trigger_threshold = true;
+
     params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
-    params->has_cpu_throttle_initial = true;
     params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
-    params->has_cpu_throttle_increment = true;
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
     params->tls_creds = QAPI_CLONE(StrOrNull, s->parameters.tls_creds);
     params->tls_hostname = QAPI_CLONE(StrOrNull, s->parameters.tls_hostname);
     params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
-    params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
-    params->has_avail_switchover_bandwidth = true;
     params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
-    params->has_downtime_limit = true;
     params->downtime_limit = s->parameters.downtime_limit;
-    params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
-    params->has_multifd_compression = true;
     params->multifd_compression = s->parameters.multifd_compression;
-    params->has_multifd_zlib_level = true;
     params->multifd_zlib_level = s->parameters.multifd_zlib_level;
-    params->has_multifd_qatzip_level = true;
     params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
-    params->has_multifd_zstd_level = true;
     params->multifd_zstd_level = s->parameters.multifd_zstd_level;
-    params->has_xbzrle_cache_size = true;
     params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
-    params->has_max_postcopy_bandwidth = true;
     params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
-    params->has_max_cpu_throttle = true;
     params->max_cpu_throttle = s->parameters.max_cpu_throttle;
-    params->has_announce_initial = true;
     params->announce_initial = s->parameters.announce_initial;
-    params->has_announce_max = true;
     params->announce_max = s->parameters.announce_max;
-    params->has_announce_rounds = true;
     params->announce_rounds = s->parameters.announce_rounds;
-    params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
-
-    if (s->has_block_bitmap_mapping) {
-        params->has_block_bitmap_mapping = true;
-        params->block_bitmap_mapping =
-            QAPI_CLONE(BitmapMigrationNodeAliasList,
-                       s->parameters.block_bitmap_mapping);
-    }
-
-    params->has_x_vcpu_dirty_limit_period = true;
     params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-    params->has_vcpu_dirty_limit = true;
     params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
-    params->has_mode = true;
     params->mode = s->parameters.mode;
-    params->has_zero_page_detection = true;
     params->zero_page_detection = s->parameters.zero_page_detection;
-    params->has_direct_io = true;
     params->direct_io = s->parameters.direct_io;
-    params->has_cpr_exec_command = true;
     params->cpr_exec_command = QAPI_CLONE(strList,
                                           s->parameters.cpr_exec_command);
+    params->block_bitmap_mapping =
+        QAPI_CLONE(BitmapMigrationNodeAliasList,
+                   s->parameters.block_bitmap_mapping);
+
+    migrate_mark_all_params_present(params);
+
+    /*
+     * The block-bitmap-mapping breaks the expected API of
+     * query-migrate-parameters of having all members present. To keep
+     * compatibility, only emit this field if it's actually been
+     * set. The empty list is a valid value.
+     */
+    if (!s->has_block_bitmap_mapping) {
+        params->has_block_bitmap_mapping = false;
+        qapi_free_BitmapMigrationNodeAliasList(params->block_bitmap_mapping);
+    }
 
     return params;
 }
-- 
2.50.1



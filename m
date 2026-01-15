Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2662D46638
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgWFM-00064S-I2; Thu, 15 Jan 2026 17:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWFF-0005z3-Gg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWFD-0008K0-JB
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768517709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UTvCRrCxtTkj+Ju1MWnq26AwmT7ZdK3+wgM27zhBZs=;
 b=IiNmi/bMKZv9sz3JWqFh0Wd08xc0Am+YmEfhpFFgTOZTHU/SkjfZ0X7c9XtyVlUAbE0B4l
 /e/mYHgXS5lWScBueVfkKro55iPeQLucXHi9b7y5PF/PtnToWQF1+7rSJvFAUVxXXU66h5
 C32i2zzD1lGkeIl82wTwe0kTq2V/WKM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-UUXa_N0qNo-uQ1SUnmSunw-1; Thu, 15 Jan 2026 17:55:08 -0500
X-MC-Unique: UUXa_N0qNo-uQ1SUnmSunw-1
X-Mimecast-MFC-AGG-ID: UUXa_N0qNo-uQ1SUnmSunw_1768517708
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8bb9f029f31so459550985a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 14:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768517707; x=1769122507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UTvCRrCxtTkj+Ju1MWnq26AwmT7ZdK3+wgM27zhBZs=;
 b=YDp/W+1tHJorzfwjuYacaE4tA7MWPa3KlynwxcxkX0AiTaXxTUmfeeVCnuInnZHRzS
 VaNQamXqPsajqwE5TTeb1azvXNanHAvVmObehd1pZld1DOwBLbTYbT7+9B5HN05s+O9f
 W3cCOrzrvpibaCLayrewzzlKMag+H0cXTL8L4adcLDKUqV2qKkzEfEhkv4CdzNEuF/MF
 kfAqBt0b9oHW/ThluiHxvqVXceL8iumAcAjbmskpvprJ8+XrOJPDC5QZJUHlLosPZ0+q
 NU+waCtL3JJTSLTsSRGibadF1XPpAm007tIx6V3jfPFd8EUFfAKomHY9CIa41uyDZKWv
 IDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768517707; x=1769122507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7UTvCRrCxtTkj+Ju1MWnq26AwmT7ZdK3+wgM27zhBZs=;
 b=CuBlri0xwjnCRU5fSfA0sLjXpcI3kLNIPFHeiDjQj7B1Yozow7jgXkUAW37XpJY8/K
 y9/Mi6ouxK4PESKEN8WoBXrTIjhQldVI36nFP26PT5qOKP40z5RcT7rBSy2szaHH8OVi
 5A8QKCMgELzNb8W030OPi0PleHgmBBiJy/CPAwobzFkNOIB4RRtjj231gV04vOzJo5Iq
 c3XOrhHRv77xX92NRPo0QyGroYhJiLuyK+HYW1H/DUYtrhhnPF1x9LfCR0WNGgHHcNsH
 3cdmTsm19TbfRZ6mzDL8k0F0cZOqYbBuCXSScMlbCWRQpQdXtPaMRjWl0GGB8c/PiApx
 ZGkA==
X-Gm-Message-State: AOJu0Yz36Hem9mjg7W2IBhS37SVE/2ON4+n7v+MN6POLjx9kWtVLMTfH
 +WSkujn3QEeepc9KtwnI48p8C8kUy2XWWIs/phpBF4PLmnSdRQSmEjrhxf4AtWQVwll3NMQCmEL
 6/cQNrWYgdZAWX3ipwKtqFnq5ebSnkirwn/l4AsED3DLX9HSKcoXMHIAWN7l+CWSOqjhgSvuV8r
 dTMuLneePpfJcYG/wnLfsZ/3B9FmtcG3p6n2276w==
X-Gm-Gg: AY/fxX4WWpF9YhDYBBOQMgxqQVwLYx2lw9fv4ssRxi58sPvWLThN50vcDvf5Effd9GE
 iz4ME5LFaKbd3I0o7SBE1v5zs45bjd4Itqha3rOdPlQJ1xt8ROxCJyhdXgUlpTa+gHKGdgmFtA9
 h5JH+5+S7ICpb3XNAosMwt/8jS4FkfTb9UZyorSDlcfUBoFH3DxMzg9Rcbbd7Jdd1bdqGIQgdA2
 qW3L6xu8yQG4vOxjaZFYQxMiBc0vXZ5HL8igW0rOwUjwCQJM+z2vLNX9lqXIOXmQa85SSGwIwBy
 j6iX+VuHYgfzUJrV7AedVza2iG9tyIVwcCd47ruKWrQXNwczXOQgBZma2RQl1PrGlXezVPba3yP
 r
X-Received: by 2002:a05:620a:29d3:b0:8b2:f090:b167 with SMTP id
 af79cd13be357-8c6a670434fmr163061685a.24.1768517707254; 
 Thu, 15 Jan 2026 14:55:07 -0800 (PST)
X-Received: by 2002:a05:620a:29d3:b0:8b2:f090:b167 with SMTP id
 af79cd13be357-8c6a670434fmr163058685a.24.1768517706723; 
 Thu, 15 Jan 2026 14:55:06 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71d8314sm70353185a.24.2026.01.15.14.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:55:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 1/2] migration: Remove zero-blocks capability
Date: Thu, 15 Jan 2026 17:55:02 -0500
Message-ID: <20260115225503.3083355-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115225503.3083355-1-peterx@redhat.com>
References: <20260115225503.3083355-1-peterx@redhat.com>
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

It was declared deprecated since 9.2.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  7 +++++++
 qapi/migration.json             | 12 ------------
 migration/options.c             |  5 -----
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7abb3dab59..dfb0a6eba5 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -574,9 +574,3 @@ usage of providing a file descriptor to a plain file has been
 deprecated in favor of explicitly using the ``file:`` URI with the
 file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
 command documentation for details on the ``fdset`` usage.
-
-``zero-blocks`` capability (since 9.2)
-''''''''''''''''''''''''''''''''''''''
-
-The ``zero-blocks`` capability was part of the block migration which
-doesn't exist anymore since it was removed in QEMU v9.1.
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e81d79da47..4aae30918d 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -717,6 +717,13 @@ Block migration has been removed. For a replacement, see "QMP
 invocation for live storage migration with ``blockdev-mirror`` + NBD"
 in docs/interop/live-block-operations.rst.
 
+``migrate-set-capabilities`` ``zero-blocks`` option (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``zero-blocks`` capability was accidentally left behind when
+block migration capability got removed in 9.1.  Removed with no
+replacement.
+
 ``migrate-set-parameter`` ``compress-level`` option (removed in 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 201dedd982..be6ebda5a0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -440,13 +440,6 @@
 #     footprint is mlock()'d on demand or all at once.  Refer to
 #     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
 #
-# @zero-blocks: During storage migration encode blocks of zeroes
-#     efficiently.  This essentially saves 1MB of zeroes per block on
-#     the wire.  Enabling requires source and target VM to support
-#     this feature.  To enable it is sufficient to enable the
-#     capability on the source VM.  The feature is disabled by
-#     default.  (since 1.6)
-#
 # @events: generate events for each migration state change (since 2.4)
 #
 # @auto-converge: If enabled, QEMU will automatically throttle down
@@ -531,14 +524,10 @@
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
-# @deprecated: Member @zero-blocks is deprecated as being part of
-#     block migration which was already removed.
-#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
-           { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
@@ -595,7 +584,6 @@
 #           {"state": false, "capability": "xbzrle"},
 #           {"state": false, "capability": "rdma-pin-all"},
 #           {"state": false, "capability": "auto-converge"},
-#           {"state": false, "capability": "zero-blocks"},
 #           {"state": true, "capability": "events"},
 #           {"state": false, "capability": "postcopy-ram"},
 #           {"state": false, "capability": "x-colo"}
diff --git a/migration/options.c b/migration/options.c
index 9a5a39c886..68a4536150 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -188,7 +188,6 @@ const Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
     DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
     DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
-    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
     DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
     DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
     DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
@@ -576,10 +575,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (new_caps[MIGRATION_CAPABILITY_ZERO_BLOCKS]) {
-        warn_report("zero-blocks capability is deprecated");
-    }
-
 #ifndef CONFIG_REPLICATION
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
-- 
2.50.1



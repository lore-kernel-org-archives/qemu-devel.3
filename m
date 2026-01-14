Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB57D39016
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 19:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg702-0001Xs-2B; Wed, 14 Jan 2026 14:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6ze-0001NN-NT
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6zc-00023I-Vy
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768420643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bYt2DfDycuBHru+tnnZlfBQjJPIyfZZW47KxB1sqtI=;
 b=RzBMZt7Izzo3Xvh+FzQrQ3p6r3qLOkccw80qFx9g6UNtxyYcSvTI1dhcn/zliyexKlm1je
 8yTxdygJaz2Ppp6yiDFVeNPW0YIWFmDw6n2bNN7ERAwVoduRTqnMlypSx3WmsGFlPjDh3s
 LqYjdf0dlSYI3xdIan6gqDc8VqrCiR4=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-UbSbG3KHM2CDNbtFonziBA-1; Wed, 14 Jan 2026 14:57:22 -0500
X-MC-Unique: UbSbG3KHM2CDNbtFonziBA-1
X-Mimecast-MFC-AGG-ID: UbSbG3KHM2CDNbtFonziBA_1768420642
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-93f4ff789c5so593006241.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768420641; x=1769025441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bYt2DfDycuBHru+tnnZlfBQjJPIyfZZW47KxB1sqtI=;
 b=pCoALMP9Km76CYPgl6Cz/7fmhFyUkmXCs13LSUFJlwaF5sPDW2ykFqClFRxSPZ1tq4
 A5rcWsIQh6pL4eLQ0iiLiAGoeKEUy5AZ31656Nenkj7AuhqohBhW+L2Z+KVHfEnCTJ5y
 XUr2vh+6UwTALONW1GJBZso5FL45WojmsFy+Y9Jz/yQzxvrmUqs6lDIIoCe5sOOfE409
 ASW08RSlOvxRTg0WKKVa5iUtrXRpZNvElYYbftiZwt8AWO8ZQkXG978iusUQEluKXXC0
 i9ueNmAwY1a5u24jW6NMz5PJN3VWgrtmU/DC6YRiYDJ7SQ9cPIkEZ6+Hcf+ZGKsX78l9
 BX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768420641; x=1769025441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bYt2DfDycuBHru+tnnZlfBQjJPIyfZZW47KxB1sqtI=;
 b=vCt8AyLBIpj3P7TSC4HqzE7yF3WVROSYIpoveX1lSjyYGEvNdWnPHBcH0fxJN+0BCy
 aZUo6LSUWCWU0TaOwwaQaHnD6fR3DA1yaXuj/5hrCSiPxfpwT3tC6E8HPL0bUyDuF0J8
 IkwwwxNiueidldMuWXFvQtlkpgq+3HAN5JhAuhbF4PImuFa49MSDJtpNicjXOOfKcr+s
 AXIamr/GbUPK1df8oIP2z7qvdXI2vzbC7Gv+86SaGkoHtWUYE6IL8vqqpcj+wd/KX9ui
 /YN9met+Vpxok0JRJ2AoSDLfh/f7zTd8GLFlk6rxveTAyQJdVCIwfRr4MX+ZlFhTMbn/
 xk3w==
X-Gm-Message-State: AOJu0YxOsofjBken+H/RAbLJitOGnyh9pigxg7kaf6jDUnCgMvZ5SQXY
 OKIJAKhzmwe1tX4/WKiNmV7PBn7nlB4Mciavu09WFh6K7n9nODQQjPoy36t+YsF/KylvZ3O4nJ5
 Wqe5493gc+ojBbIlvYZXnPQp4bUeClkgiGSlovtH+G9B677Sr5nzkF+u1DBBoIfNNMxf2j+7PId
 JXl/7pZoa2/E/dt253zKCCU0/RutrtoBgyJVzWOw==
X-Gm-Gg: AY/fxX5hfSkqtBbzGwk/mrXTxDQmi7+4RVpCD4uJAt73eci8lIMjhKX+Z2Bey0SILTQ
 3pDrwD9Yv7HzRXbjq4JQ3upwkKWImfW9dwrA4+FRxt2iD0igYNMQR/3H7DtI64EB5z1ROXSYe/F
 Rx2HAqDgHIRPdNEb2DC6H33FacQsARJqsUcT9V1sb4gjMgsto9Ar2eOAzBALhFIxERc7amf9h8K
 7v2D65jlPis7abppNAFR2qkdmC8GJSqzqs2tLGr5Ff+oHD4YhntbbhU1l8VNIKEPjWPA/0MChfU
 d8ibKOrVGLPY8OC2ZV8+8OrMVWonvLgMsBiDT5SWGlMazLNqMACfyXq7XkNDeZnGgxGaU+fY6I+
 M
X-Received: by 2002:a05:6102:f8c:b0:5ef:a67d:e957 with SMTP id
 ada2fe7eead31-5f1838c36edmr1567580137.17.1768420639927; 
 Wed, 14 Jan 2026 11:57:19 -0800 (PST)
X-Received: by 2002:a05:6102:f8c:b0:5ef:a67d:e957 with SMTP id
 ada2fe7eead31-5f1838c36edmr1567561137.17.1768420639358; 
 Wed, 14 Jan 2026 11:57:19 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-944122d3040sm23024832241.4.2026.01.14.11.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:57:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 2/3] migration: Remove zero-blocks capability
Date: Wed, 14 Jan 2026 14:56:58 -0500
Message-ID: <20260114195659.2543649-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114195659.2543649-1-peterx@redhat.com>
References: <20260114195659.2543649-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  6 ++++++
 qapi/migration.json             | 11 +----------
 migration/options.c             |  5 -----
 4 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b499b2acb0..6e4e2e4833 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -575,12 +575,6 @@ deprecated in favor of explicitly using the ``file:`` URI with the
 file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
 command documentation for details on the ``fdset`` usage.
 
-``zero-blocks`` capability (since 9.2)
-''''''''''''''''''''''''''''''''''''''
-
-The ``zero-blocks`` capability was part of the block migration which
-doesn't exist anymore since it was removed in QEMU v9.1.
-
 COLO migration framework (since 11.0)
 '''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e81d79da47..8a9d21068a 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -717,6 +717,12 @@ Block migration has been removed. For a replacement, see "QMP
 invocation for live storage migration with ``blockdev-mirror`` + NBD"
 in docs/interop/live-block-operations.rst.
 
+``migrate-set-capabilities`` ``zero-blocks`` option (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``zero-blocks`` capability was part of the block migration capability
+that got removed.  Removed with no replacement.
+
 ``migrate-set-parameter`` ``compress-level`` option (removed in 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 3c868efe38..490f72090e 100644
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
@@ -531,13 +524,12 @@
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
 #
-# @deprecated: Member @zero-blocks and @x-colo are deprecated.
+# @deprecated: Member @x-colo is deprecated.
 #
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
-           { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable', 'deprecated' ] },
            'release-ram',
@@ -594,7 +586,6 @@
 #           {"state": false, "capability": "xbzrle"},
 #           {"state": false, "capability": "rdma-pin-all"},
 #           {"state": false, "capability": "auto-converge"},
-#           {"state": false, "capability": "zero-blocks"},
 #           {"state": true, "capability": "events"},
 #           {"state": false, "capability": "postcopy-ram"},
 #           {"state": false, "capability": "x-colo"}
diff --git a/migration/options.c b/migration/options.c
index 318850ba94..edb16ad9fa 100644
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
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         warn_report("COLO migration framework is deprecated");
     }
-- 
2.50.1



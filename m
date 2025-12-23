Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECF0E6F096
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Q0-0002Xc-Pm; Tue, 23 Dec 2025 09:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0001IB-T5
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PF-0003o0-Uh
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FW6saTDWb9JM/IHJRxAm7DnbZ1DOTG3pr4vDqtJT2A=;
 b=DNZD/ATwOtBAqlPcO/fsReCXs8TUOfOpr7MhCj3+52Uk4gpNyqTQ7CLK8t73RYmkInVJaL
 GMz1kLSS1XOcFMxMDrDQ/fcB1sb3cm+jR2d14PmnaM8jXx74maTu1+bCWDbOBlLsOm26Y6
 QFqD/EFRNXTfpSuS+YxHmx59sWrv5SA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-QPACjXczMs61PzBYzkTbLw-1; Tue, 23 Dec 2025 09:30:29 -0500
X-MC-Unique: QPACjXczMs61PzBYzkTbLw-1
X-Mimecast-MFC-AGG-ID: QPACjXczMs61PzBYzkTbLw_1766500229
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8bb3a245d0cso1115792885a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500229; x=1767105029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FW6saTDWb9JM/IHJRxAm7DnbZ1DOTG3pr4vDqtJT2A=;
 b=GkXvtAxtsmwPkRl6hFHYt5V5Pw2C9dm67b3gUZ6Ix54XjybBsiR31TaCXRvWt1hV0o
 yCHonmoFO/DvD0M4fL5cw8QnocLnOzmi3IsfiY365qb9CooF8ycXb9eEGmd7gozsrUCE
 5En137SifetWRdv21TsoQh/qb+wiGBq1n5SDTN3sh1pNt64NvD9ljOsWmLZyufXAQtTO
 B8LJznqRT2IGLuAXkolyVhjHE4rHpX/LWPx04cMFbn3rBD5R80VWnx4nspt9vuffXEzx
 7JZiSun3Wi4ajPh+TWrcMthWCC+EZb0Guy4OXZHTY6gMIa1OfxMLhk8D9R8VUEzf6Jtj
 r83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500229; x=1767105029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0FW6saTDWb9JM/IHJRxAm7DnbZ1DOTG3pr4vDqtJT2A=;
 b=OIuvrlclF+As3XT2rMVzvtAOsva0xkWdArqwWyfO7NbgfuiMLc3QVRRlj6hLXIVKhf
 jxkSUOGeE2Hp3/CewHAfXGiC5BJEG/OwKOwAnbAll1UwsLKl2Vl3l4uQPQaz7m2eQ5Wf
 8yt5dRn8cgEbAmckUOGsV75BND6FFF3iUNOX0bJD3up1BQ/xp3kcGs2fsyC5RCcBE5KF
 6aqfAMHx/VrfDIxlw17qzrQXCGoILQHePoMKsT6mtT+Ayl/D0o9iuezhO5TVOdKUAG03
 z43k/esjePL0rY+rKIVBgicAtjT3wVZ8OHhWMJlsni2koiGTQvlWn5lYpgA0E1t9OTw+
 IYiw==
X-Gm-Message-State: AOJu0YyxzCQcoqSLX60ymIzX+KlJlWWfBfvjM+mkAtnUMEEnt/NFlNH1
 lQo7yb9RluMIg99tRiWKAc4rsX3Mt5n9JJne7CNYqB5QSMzLPVF//30lCgUw+PTJ/WZD+7jvKzH
 Rz5+XP2EiZU7OkW07MFjPOGDaWTeMIOO8W/1neELdvHvtEltGhs9eAE5rXFayKC7vte5OCBXvb3
 ZNdf7zUN9BMGj2R/V4ox3ulWAmFRPrkizoHtAZ5Q==
X-Gm-Gg: AY/fxX7jvEBJ70dTMLGvTALEZ1UoJIUxu/v/o7zc+2R8+BlIuLRGv849YT7KlWTXzc3
 e3WJMm5QPfjLvh49m1Bsil/p1svpdZd5VWAL6kou4lFa5OQp73LxHE0Kt7UIS1GvbPqGMfm9xNY
 mnEH7OR79jHRJm8G2bNnwRQlvuj0AW+fkCNBv30STaUBc5W3vz7uFkufyRYBG+K9h8V4smnVF6t
 vZURTPkBJpQhtE94MQSuH/HBYYTxckB6pjl1c7RkiP+sciPYaiE68HGO7japuOv8D7fK0WNP+ke
 CxgiIzcwUM40IeykRhipFvZudkzhDw1wC26TpeiHPba3gq7/v2NBRIDYCgPerSjsMq6aOU3P0ro
 LKTk=
X-Received: by 2002:a05:620a:454e:b0:8b2:a049:4ac0 with SMTP id
 af79cd13be357-8c08f675f0emr2415885385a.30.1766500228708; 
 Tue, 23 Dec 2025 06:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU7eZHtlrQXoBHzNAHPA8gIKc1tySdThp0bw/ZMDkXPVe7sE4YhiPF+GJIed8PRjgeZ6UO/w==
X-Received: by 2002:a05:620a:454e:b0:8b2:a049:4ac0 with SMTP id
 af79cd13be357-8c08f675f0emr2415871485a.30.1766500227814; 
 Tue, 23 Dec 2025 06:30:27 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:26 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 21/31] qapi/migration: Don't document MigrationParameter
Date: Tue, 23 Dec 2025 09:29:49 -0500
Message-ID: <20251223142959.1460293-22-peterx@redhat.com>
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

The MigrationParameter (singular) enumeration is not part of the
migration QMP API, it's only used for nicely converting HMP strings
into MigrationParameters (plural) members and for providing readline
completion.

Documenting this enum only serves to duplicate documentation between
MigrationParameter and MigrationParameters.

Add an exception to QAPIs pragma.json and stop documenting it.

The generated "QEMU QMP Reference Manual" now lists the enum members
as "Not documented."  Tolerable.

Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-8-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 154 +-------------------------------------------
 qapi/pragma.json    |   1 +
 2 files changed, 3 insertions(+), 152 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index fa4491b9b0..201dedd982 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -806,158 +806,8 @@
 ##
 # @MigrationParameter:
 #
-# Migration parameters enumeration
-#
-# @announce-initial: Initial delay (in milliseconds) before sending
-#     the first announce (Since 4.0)
-#
-# @announce-max: Maximum delay (in milliseconds) between packets in
-#     the announcement (Since 4.0)
-#
-# @announce-rounds: Number of self-announce packets sent after
-#     migration (Since 4.0)
-#
-# @announce-step: Increase in delay (in milliseconds) between
-#     subsequent packets in the announcement (Since 4.0)
-#
-# @throttle-trigger-threshold: The ratio of bytes_dirty_period and
-#     bytes_xfer_period to trigger throttling.  It is expressed as
-#     percentage.  The default value is 50.  (Since 5.0)
-#
-# @cpu-throttle-initial: Initial percentage of time guest cpus are
-#     throttled when migration auto-converge is activated.  The
-#     default value is 20.  (Since 2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     The default value is 10.  (Since 2.7)
-#
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage.
-#     At the tail stage of throttling, the Guest is very sensitive to
-#     CPU percentage while the @cpu-throttle -increment is excessive
-#     usually at tail stage.  If this parameter is true, we will
-#     compute the ideal CPU percentage used by the Guest, which may
-#     exactly make the dirty rate match the dirty rate threshold.
-#     Then we will choose a smaller throttle increment between the one
-#     specified by @cpu-throttle-increment and the one generated by
-#     ideal CPU percentage.  Therefore, it is compatible to
-#     traditional throttling, meanwhile the throttle increment won't
-#     be excessive at tail stage.  The default value is false.
-#     (Since 5.1)
-#
-# @tls-creds: ID of the 'tls-creds' object that provides credentials
-#     for establishing a TLS connection over the migration data
-#     channel.  On the outgoing side of the migration, the credentials
-#     must be for a 'client' endpoint, while for the incoming side the
-#     credentials must be for a 'server' endpoint.  Setting this to a
-#     non-empty string enables TLS for all migrations.  An empty
-#     string means that QEMU will use plain text mode for migration,
-#     rather than TLS.  (Since 2.7)
-#
-# @tls-hostname: migration target's hostname for validating the
-#     server's x509 certificate identity.  If empty, QEMU will use the
-#     hostname from the migration URI, if any.  A non-empty value is
-#     required when using x509 based TLS credentials and the migration
-#     URI does not include a hostname, such as fd: or exec: based
-#     migration.  (Since 2.7)
-#
-#     Note: empty value works only since 2.9.
-#
-# @tls-authz: ID of the 'authz' object subclass that provides access
-#     control checking of the TLS x509 certificate distinguished name.
-#     This object is only resolved at time of use, so can be deleted
-#     and recreated on the fly while the migration server is active.
-#     If missing, it will default to denying access (Since 4.0)
-#
-# @max-bandwidth: maximum speed for migration, in bytes per second.
-#     (Since 2.8)
-#
-# @avail-switchover-bandwidth: to set the available bandwidth that
-#     migration can use during switchover phase.  **Note:** this does
-#     not limit the bandwidth during switchover, but only for
-#     calculations when making decisions to switchover.  By default,
-#     this value is zero, which means QEMU will estimate the bandwidth
-#     automatically.  This can be set when the estimated value is not
-#     accurate, while the user is able to guarantee such bandwidth is
-#     available when switching over.  When specified correctly, this
-#     can make the switchover decision much more accurate.
-#     (Since 8.2)
-#
-# @downtime-limit: set maximum tolerated downtime for migration.
-#     maximum downtime in milliseconds (Since 2.8)
-#
-# @x-checkpoint-delay: The delay time (in ms) between two COLO
-#     checkpoints in periodic mode.  (Since 2.8)
-#
-# @multifd-channels: Number of channels used to migrate data in
-#     parallel.  This is the same number that the number of sockets
-#     used for migration.  The default value is 2 (since 4.0)
-#
-# @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
-#     needs to be a multiple of the target page size and a power of 2
-#     (Since 2.11)
-#
-# @max-postcopy-bandwidth: Background transfer bandwidth during
-#     postcopy.  Defaults to 0 (unlimited).  In bytes per second.
-#     (Since 3.0)
-#
-# @max-cpu-throttle: maximum cpu throttle percentage.  Defaults to 99.
-#     (Since 3.1)
-#
-# @multifd-compression: Which compression method to use.  Defaults to
-#     none.  (Since 5.0)
-#
-# @multifd-zlib-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 9,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 9 means best compression ratio which will consume
-#     more CPU.  Defaults to 1.  (Since 5.0)
-#
-# @multifd-qatzip-level: Set the compression level to be used in live
-#     migration.  The level is an integer between 1 and 9, where 1
-#     means the best compression speed, and 9 means the best
-#     compression ratio which will consume more CPU.  Defaults to 1.
-#     (Since 9.2)
-#
-# @multifd-zstd-level: Set the compression level to be used in live
-#     migration, the compression level is an integer between 0 and 20,
-#     where 0 means no compression, 1 means the best compression
-#     speed, and 20 means best compression ratio which will consume
-#     more CPU.  Defaults to 1.  (Since 5.0)
-#
-# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#     aliases for the purpose of dirty bitmap migration.  Such aliases
-#     may for example be the corresponding names on the opposite site.
-#     The mapping must be one-to-one, but not necessarily complete: On
-#     the source, unmapped bitmaps and all bitmaps on unmapped nodes
-#     will be ignored.  On the destination, encountering an unmapped
-#     alias in the incoming migration stream will result in a report,
-#     and all further bitmap migration data will then be discarded.
-#     Note that the destination does not know about bitmaps it does
-#     not receive, so there is no limitation or requirement regarding
-#     the number of bitmaps received, or how they are named, or on
-#     which nodes they are placed.  By default (when this parameter
-#     has never been set), bitmap names are mapped to themselves.
-#     Nodes are mapped to their block device name if there is one, and
-#     to their node name otherwise.  (Since 5.2)
-#
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
-#     limit during live migration.  Should be in the range 1 to
-#     1000ms.  Defaults to 1000ms.  (Since 8.1)
-#
-# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#     Defaults to 1.  (Since 8.1)
-#
-# @mode: Migration mode.  See description in `MigMode`.  Default is
-#     'normal'.  (Since 8.2)
-#
-# @zero-page-detection: Whether and how to detect zero pages.  See
-#     description in `ZeroPageDetection`.  Default is 'multifd'.
-#     (since 9.0)
-#
-# @direct-io: Open migration files with O_DIRECT when possible.  This
-#     only has effect if the @mapped-ram capability is enabled.
-#     (Since 9.1)
+# Migration parameters enumeration.  The enumeration values mirror the
+# members of @MigrationParameters.
 #
 # @cpr-exec-command: Command to start the new QEMU process when @mode
 #     is @cpr-exec.  The first list element is the program's filename,
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 023a2ef7bc..193bc39059 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -59,6 +59,7 @@
         'IscsiTransport',
         'KeyValueKind',
         'MemoryDeviceInfoKind',
+        'MigrationParameter',
         'NetClientDriver',
         'ObjectType',
         'QKeyCode',
-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B98E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Q9-0002t5-U4; Tue, 23 Dec 2025 09:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0001IA-T2
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PE-0003nC-7b
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uP5Rm/AMKEfc2II3yNWrhClaDs/tXid3PE8jTqH0eCU=;
 b=LJFKxsBRCXjh2PolwiJA6Wl866ikHF4d/WpCvrrRGKNB3feY7SWa3ZftR1x7ohEfr8P5US
 skzxIeN7N6KeGjptpJj+ZQFARr0vfwiGGihE0P/NbmxCbM+90Us+mVdBMvIboLKi7HMb5/
 kvArNloYsjSBG1AJQsAC9hX4OjUjM1U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-HtaoYnl8OByYd6SNy1twPQ-1; Tue, 23 Dec 2025 09:30:28 -0500
X-MC-Unique: HtaoYnl8OByYd6SNy1twPQ-1
X-Mimecast-MFC-AGG-ID: HtaoYnl8OByYd6SNy1twPQ_1766500228
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8bb9f029f31so1351722785a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500227; x=1767105027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP5Rm/AMKEfc2II3yNWrhClaDs/tXid3PE8jTqH0eCU=;
 b=qoOLHMZNqF3GwRbN0U81fWNbIvhHwiJQcMaET8cGnmyi+L/s6pQskb3BsyIl9Nlbzk
 5BnTfzj03+3rYjM+eBaNCv5cPQT2eluA8sV4UpAubCOCuUeHvXWcfSqwG9nhN4DJS9lc
 Ty2/tSejkijKnbr8IYnXAAMoIOIE8Q9qH9a42K6syuxPO5hU70N3aP/o9j7ssQTT0Lte
 hApzgs3ZbEVBAXtLEUaSyMufCPd07UjjjatubmrNy0XNYhzZHv4aKmcBYbE1eiOrw5/M
 THIlEnMPdaXJfjfkC8N+Abw4OD9fkVrHtmFBP0HKFapT9pdrLYxdV7NaPQXbZ2Hxgby8
 31KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500227; x=1767105027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uP5Rm/AMKEfc2II3yNWrhClaDs/tXid3PE8jTqH0eCU=;
 b=JPpzN9TtcL4/nztNZyZ0YHXQ4rLkAIibS5U2cvQ4/ZNNH0mxRT4bPjtyyl3B+QER6b
 ozu4+xAgRYpE5mn39KRw+8KqUCQ7WibXi4xm2+w1e8/junjX3vVTCN3cCEZ0sHChfJh5
 p1e81a4NxHIk9MzMdH3iXtT7QhIIoqGEJynYchTfjUKc7RGxQWWS1AvhcoS763HZMojD
 n5k7ouIrBIqY9KfmYkxBzr1M0GIjcCuCyi6vX0olsw3Q1wavOVqsksvWJCmQkYQ3fz9J
 RtDZ4Gaaluc9oK4j5AYuTVFFbR5AusbBqUX62MZi4Fh+axRf8rmgIpQmy/4NA/WExI3y
 mDRg==
X-Gm-Message-State: AOJu0Yydsw2g5yGeyexdy0qhbbH6oQLpN8dL2wD/Lju3WriGUJrfOKuJ
 BXI2pABiiYYpzujFx/PLNGl2US4IMQRb16+P399+p+f2G18m3OE5Qfj+EY663yJ/eKwV1Pj3fal
 FJqEPB75vYxZjuTIm7ggNq6cY5DspRsS/Cka1SHnKILXzzLsYGSNxdqGV9nNKbtgj3Gc1RVHTzb
 pK4FgL6S0Lj/0y1vj46WvFjmR4wnYAJL1YsDzmHw==
X-Gm-Gg: AY/fxX7Sql3m/jl+TSDjs+KhKO6HgYA92rf/pMVNf7VEM89JVLfGhboxEfHfWT/uU9D
 8PUAP9IEWgYe+ptGGaGvHh0Uvf3qee8rQ/QuAyA5lxAsUr+cGCfOjYjuI8P/hKzJW5MYjcK6hwn
 AWZpf8J3Qv98uIaj5uFXhl1xU4zXIInZC8uF8DaUHAjZSUe/OdLm5RUQyLI5JiBazqbxBr11xZ5
 KRxTz1XovTnt62EWlJDrSZsS6wSTcH7y1jSHvpAMUlHwV4Gdj0kljMt2dj0E4GMuSwib5nXqUjH
 iLcrJy12rA1Ry7y2QDzZNjVQ2f75vbcfUfnlSyuRP71UnHOlrdc2fEXg3zEel4MUfNtUpMyPJEo
 IHl8=
X-Received: by 2002:a05:620a:2a05:b0:8b1:498b:77fe with SMTP id
 af79cd13be357-8c08fbeacbcmr2000518085a.33.1766500226999; 
 Tue, 23 Dec 2025 06:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7JoiINpiIRX2McDs2eMb3j+/xxQ8GODxzZ1SfILKkkECLRksM5ouAD+JV+JwpkJtg6GvPyw==
X-Received: by 2002:a05:620a:2a05:b0:8b1:498b:77fe with SMTP id
 af79cd13be357-8c08fbeacbcmr2000508285a.33.1766500226270; 
 Tue, 23 Dec 2025 06:30:26 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:25 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 20/31] migration: Remove MigrateSetParameters
Date: Tue, 23 Dec 2025 09:29:48 -0500
Message-ID: <20251223142959.1460293-21-peterx@redhat.com>
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

Now that the TLS options have been made the same between
migrate-set-parameters and query-migrate-parameters, a single type can
be used. Remove MigrateSetParameters.

The TLS options documentation from MigrationParameters were replaced
with the ones from MigrateSetParameters which was more complete.

Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-7-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 239 +++------------------------------
 migration/migration-hmp-cmds.c |   4 +-
 migration/options.c            |   6 +-
 3 files changed, 26 insertions(+), 223 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 30a0eb2d7e..fa4491b9b0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -993,7 +993,23 @@
            'cpr-exec-command'] }
 
 ##
-# @MigrateSetParameters:
+# @migrate-set-parameters:
+#
+# Set migration parameters.  All arguments are optional.
+#
+# Since: 2.4
+#
+# .. qmp-example::
+#
+#     -> { "execute": "migrate-set-parameters" ,
+#          "arguments": { "multifd-channels": 5 } }
+#     <- { "return": {} }
+##
+{ 'command': 'migrate-set-parameters', 'boxed': true,
+  'data': 'MigrationParameters' }
+
+##
+# @MigrationParameters:
 #
 # @announce-initial: Initial delay (in milliseconds) before sending
 #     the first announce (Since 4.0)
@@ -1155,222 +1171,6 @@
 # @unstable: Members @x-checkpoint-delay and
 #     @x-vcpu-dirty-limit-period are experimental.
 #
-# TODO: either fuse back into `MigrationParameters`, or make
-#     `MigrationParameters` members mandatory
-#
-# Since: 2.4
-##
-{ 'struct': 'MigrateSetParameters',
-  'data': { '*announce-initial': 'size',
-            '*announce-max': 'size',
-            '*announce-rounds': 'size',
-            '*announce-step': 'size',
-            '*throttle-trigger-threshold': 'uint8',
-            '*cpu-throttle-initial': 'uint8',
-            '*cpu-throttle-increment': 'uint8',
-            '*cpu-throttle-tailslow': 'bool',
-            '*tls-creds': 'StrOrNull',
-            '*tls-hostname': 'StrOrNull',
-            '*tls-authz': 'StrOrNull',
-            '*max-bandwidth': 'size',
-            '*avail-switchover-bandwidth': 'size',
-            '*downtime-limit': 'uint64',
-            '*x-checkpoint-delay': { 'type': 'uint32',
-                                     'features': [ 'unstable' ] },
-            '*multifd-channels': 'uint8',
-            '*xbzrle-cache-size': 'size',
-            '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle': 'uint8',
-            '*multifd-compression': 'MultiFDCompression',
-            '*multifd-zlib-level': 'uint8',
-            '*multifd-qatzip-level': 'uint8',
-            '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
-            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
-                                            'features': [ 'unstable' ] },
-            '*vcpu-dirty-limit': 'uint64',
-            '*mode': 'MigMode',
-            '*zero-page-detection': 'ZeroPageDetection',
-            '*direct-io': 'bool',
-            '*cpr-exec-command': [ 'str' ]} }
-
-##
-# @migrate-set-parameters:
-#
-# Set various migration parameters.
-#
-# Since: 2.4
-#
-# .. qmp-example::
-#
-#     -> { "execute": "migrate-set-parameters" ,
-#          "arguments": { "multifd-channels": 5 } }
-#     <- { "return": {} }
-##
-{ 'command': 'migrate-set-parameters', 'boxed': true,
-  'data': 'MigrateSetParameters' }
-
-##
-# @MigrationParameters:
-#
-# The optional members aren't actually optional.
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
-#     throttled when migration auto-converge is activated.
-#     (Since 2.7)
-#
-# @cpu-throttle-increment: throttle percentage increase each time
-#     auto-converge detects that migration is not making progress.
-#     (Since 2.7)
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
-#     credentials must be for a 'server' endpoint.  An empty string
-#     means that QEMU will use plain text mode for migration, rather
-#     than TLS.  (Since 2.7)
-#
-#     Note: 2.8 omits empty @tls-creds instead.
-#
-# @tls-hostname: migration target's hostname for validating the
-#     server's x509 certificate identity.  If empty, QEMU will use the
-#     hostname from the migration URI, if any.  (Since 2.7)
-#
-#     Note: 2.8 omits empty @tls-hostname instead.
-#
-# @tls-authz: ID of the 'authz' object subclass that provides access
-#     control checking of the TLS x509 certificate distinguished name.
-#     (Since 4.0)
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
-# @x-checkpoint-delay: the delay time between two COLO checkpoints.
-#     (Since 2.8)
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
-#
-# @cpr-exec-command: Command to start the new QEMU process when @mode
-#     is @cpr-exec.  The first list element is the program's filename,
-#     the remainder its arguments.  (Since 10.2)
-#
-# Features:
-#
-# @unstable: Members @x-checkpoint-delay and
-#     @x-vcpu-dirty-limit-period are experimental.
-#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -1410,7 +1210,10 @@
 ##
 # @query-migrate-parameters:
 #
-# Return information about the current migration parameters
+# Return information about the current migration parameters.  Optional
+# members of the return value are always present, except
+# @block-bitmap-mapping, which is only present if it has been
+# previously set.
 #
 # Since: 2.4
 #
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index edc561a34a..8b1096db86 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -578,7 +578,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
-    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
+    MigrationParameters *p = g_new0(MigrationParameters, 1);
     uint64_t valuebw = 0;
     uint64_t cache_size;
     Error *err = NULL;
@@ -765,7 +765,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     qmp_migrate_set_parameters(p, &err);
 
  cleanup:
-    qapi_free_MigrateSetParameters(p);
+    qapi_free_MigrationParameters(p);
     visit_free(v);
     hmp_handle_error(mon, err);
 }
diff --git a/migration/options.c b/migration/options.c
index 6ef3c56fb6..b17347e43b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1312,7 +1312,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     return true;
 }
 
-static void migrate_params_test_apply(MigrateSetParameters *params,
+static void migrate_params_test_apply(MigrationParameters *params,
                                       MigrationParameters *dest)
 {
     *dest = migrate_get_current()->parameters;
@@ -1439,7 +1439,7 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 }
 
-static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
+static void migrate_params_apply(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
 
@@ -1575,7 +1575,7 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 }
 
-void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
+void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationParameters tmp;
 
-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC40C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAg1-0006Ql-Ca; Wed, 12 Aug 2026 11:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAft-00066R-Lp
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAfq-00073u-EC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3umiU2VQlfFldgzpAdABpy12j6rspPaYQokfsxVpno=;
 b=WeIQSvEVVM2XHeK4dCbYtH5wCRdxcsBgGIWquKQgg81Xd34/xMVqI8/KYauNt3GouyKvbH
 JV4iH3PEfpUITY4cbPTB9Zz/f/8hMXXeZOH9F8uqsRwG/abGCKXQJKEcpHJfgvqF594xCU
 NPAFkb74Bryc4tBz2cgOHwTLxrmFRgY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-S4pp5Kv6MoaBdm8sLdGSqg-1; Wed, 12 Aug 2026 11:15:19 -0400
X-MC-Unique: S4pp5Kv6MoaBdm8sLdGSqg-1
X-Mimecast-MFC-AGG-ID: S4pp5Kv6MoaBdm8sLdGSqg_1786547719
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so18790701cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547719; x=1787152519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C3umiU2VQlfFldgzpAdABpy12j6rspPaYQokfsxVpno=;
 b=asVJyzIPKPTwpRl6UdTyaYpmYOKQROVPjfwTkYz/G1vMx8Q3/texdakQhQyQgJ4zZD
 9bCwReAlDEZZUrs3zZwudtHV/h8ZKVHCWkkX9vHbdPxVDZKgPnRfJJkCGbut74CrPjz6
 o1XOaQ4u21uEsJtoQpjsbLZHbptYhK85CmPpO0OGjxP6lk36A1JAXo0Mg6xBfC0XMWyr
 BucbMMUVEJOgePmquJ65LT7WGZrBt7BNMlBa/oJaOoDwwSp8NadkHRrtVnO7/exLQAYD
 gmdOPuyXpdiq0UuYH0XDpCyb/bH8FYe0KGBNMJH48e3pJqEXEYGGakss43+nDrZaWzr5
 wOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547719; x=1787152519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C3umiU2VQlfFldgzpAdABpy12j6rspPaYQokfsxVpno=;
 b=HUZeK9k39Y4dmrohwNyltb+ltyuuBP6WZTrrbMCRl5Cxl6k95ZInYy0xdS10YAsMh9
 gaGl4fO6zt0DmDukkbGlcC8BAaM8SFtQrewld9rRNgzEWZwvB9h0wd6hD8w+iPBZ4i+4
 ASmxwmkw5bLtRD2dJkY0yIj2fknKDreyHzq9auAflIZGnGYwP3uBy+tYs+gBAWY9wesl
 2WlIaBTGYJbE9nOa+3FmnmGofA22L1iGQyDk2aSZfY9T8D2IOpgpll09Wj4+a/KFzKXN
 W8+9o6amWVXRbOZ876cKYmzI9BLzc8BB+ophu7OAYRhBk+Z2auR+jr2chMgmt/wwErhd
 3C6g==
X-Gm-Message-State: AOJu0YxzuP3+a+m7dkj1g5ONjdzyIyUbp960KIQKqCvY2xu/9Yl7VKMd
 MinCzj1Fx4mt9OoTE2bE3nqODPov7RuHt56I0GdiKo4XYAl+CPlFEsZo4olsIhqL63Z/+8IxsAI
 8aVbgtbc9yi355hcLD8gBjLFS8HBxeoyWMHa6n2TXER72BkdTdJeI5RxfjWDqJc/7wFWudyQRwz
 tgO/2UNNBIdu9kTVogEw3NjKyoJLoyyS41ycFSVA==
X-Gm-Gg: AR+sD11e7gOLxUhEXzwppRG4XyZkp5TNMw6vXYWGe8Xc8MP56qPz0IOaqZEFqY87/Fu
 InxOmAwfGu4pyoFNWgx27EUM/Ele8WTrqyprj1jkgQHC3NKntpH8m/9+LN+3iJ4oeNr8MH8P0ZN
 68S9OeE8yva89f1KQcDS7wZfILmC89OT6fsmVe4M5Cf6VHkeYX6Dz0VgtyJqrdSCoIIPDsUK1c0
 JJuJQ4W4I3Zwr0nExiwnlL1hdb9vhWKAr0CnIbwiZip2E/2XyVl4qCANbAZinMfpVAVFxf0LS89
 pJOcDXQHTIxmsMtADMbEAwtw9UiO3MnpzTHkkmGlTuyKpU1m1V6pjD4YArwGD1rGrQ==
X-Received: by 2002:a05:622a:148f:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-52d646fd1d5mr46855401cf.11.1786547718644; 
 Wed, 12 Aug 2026 08:15:18 -0700 (PDT)
X-Received: by 2002:a05:622a:148f:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-52d646fd1d5mr46854291cf.11.1786547717949; 
 Wed, 12 Aug 2026 08:15:17 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 02/10] migration/cpr: Add HMP support for cpr-transfer
Date: Wed, 12 Aug 2026 11:14:35 -0400
Message-ID: <20260812151444.2611689-3-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongli Zhang <dongli.zhang@oracle.com>

Currently the cpr-transfer source QEMU instance cannot be driven entirely
via HMP.  The source must use QMP in order to specify both the
main migration channel and the CPR channel.

Extend the HMP migrate command with an optional CPR channel URI. When the
migration mode is cpr-transfer, HMP uses this URI to build a
CPR MigrationChannel in addition to the main migration channel. The new
option is rejected unless the migration mode is cpr-transfer, so existing
HMP migrate usage is unchanged.

For example, source QEMU HMP commands can be something like below. The
"-c unix:/tmp/cpr.sock" is for CPR URI.

(qemu) migrate_set_parameter mode cpr-transfer
(qemu) migrate -c unix:/tmp/cpr.sock tcp:0:50002

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/20260728085903.173265-1-dongli.zhang@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 18 ++++++++++++++++++
 hmp-commands.hx                | 12 ++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index b04fc4489f..b5eb27467c 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -837,9 +837,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool detach = qdict_get_try_bool(qdict, "detach", false);
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
+    const char *uri_cpr = qdict_get_try_str(qdict, "uri-cpr");
     Error *err = NULL;
     g_autoptr(MigrationChannelList) caps = NULL;
     g_autoptr(MigrationChannel) channel = NULL;
+    g_autoptr(MigrationChannel) channel_cpr = NULL;
 
     if (!migrate_uri_parse(uri, &channel, &err)) {
         hmp_handle_error(mon, err);
@@ -847,6 +849,22 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
+    if (uri_cpr) {
+        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
+            error_setg(&err, "-c can only be used in cpr-transfer mode");
+            hmp_handle_error(mon, err);
+            return;
+        }
+
+        if (!migrate_uri_parse(uri_cpr, &channel_cpr, &err)) {
+            hmp_handle_error(mon, err);
+            return;
+        }
+
+        channel_cpr->channel_type = MIGRATION_CHANNEL_TYPE_CPR;
+        QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel_cpr));
+    }
+
     qmp_migrate(NULL, true, caps, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7ae2468a3d..7f43cf537f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -928,16 +928,17 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,resume:-r,uri:s",
-        .params     = "[-d] [-r] uri",
+        .args_type  = "detach:-d,resume:-r,uri-cpr:-cs,uri:s",
+        .params     = "[-d] [-r] [-c uri-cpr] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
-		      "\n\t\t\t -r to resume a paused postcopy migration",
+		      "\n\t\t\t -r to resume a paused postcopy migration"
+		      "\n\t\t\t -c to specify a CPR URI for cpr-transfer mode",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d] [-r]`` *uri*
+``migrate [-d] [-r] [-c uri-cpr]`` *uri*
   Migrate the VM to *uri*.
 
   ``-d``
@@ -945,6 +946,9 @@ SRST
     query an ongoing migration process, use "info migrate".
   ``-r``
     Resume a paused postcopy migration.
+  ``-c`` *uri-cpr*
+    Specify the CPR URI for cpr-transfer mode. It must be a UNIX domain
+    socket.
 ERST
 
     {
-- 
2.54.0



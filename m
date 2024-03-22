Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5427EC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfJ9-0004yn-Pg; Fri, 22 Mar 2024 09:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfJ8-0004yf-N5
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfJ6-0007l4-Sv
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711115500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HE1/LAbBgKNGZUN4vVfwfMG2XgQCV3fyiLC2K6eI99Q=;
 b=WYjCebqV8yFbB618yR/oFWmcPGJ5prrsX1Uqz69irzzjNInJlwtvLzZsLIz9n3eB6f5aO7
 0SBhHijQTio5F2+xDfcAqQ3XhZQ3TLr1IhqPEXyIqYdbcesAne8JZ3zI0Qu72dgujNtkrt
 mmqj+gYoak5XfuZuwTdBCRUqkS5nrJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-PHdL2ihnNOqjEDv1gbHG8g-1; Fri, 22 Mar 2024 09:51:38 -0400
X-MC-Unique: PHdL2ihnNOqjEDv1gbHG8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B71285CBAC;
 Fri, 22 Mar 2024 13:51:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FBCC3C54;
 Fri, 22 Mar 2024 13:51:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1124E21E5D27; Fri, 22 Mar 2024 14:51:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, berrange@redhat.com
Subject: [PATCH 1/3] qapi: Improve migration TLS documentation
Date: Fri, 22 Mar 2024 14:51:15 +0100
Message-ID: <20240322135117.195489-2-armbru@redhat.com>
In-Reply-To: <20240322135117.195489-1-armbru@redhat.com>
References: <20240322135117.195489-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

MigrateSetParameters is about setting parameters, and
MigrationParameters is about querying them.  Their documentation of
@tls-creds and @tls-hostname has residual damage from a failed attempt
at de-duplicating them (see commit de63ab61241 "migrate: Share common
MigrationParameters struct" and commit 1bda8b3c695 "migration: Unshare
MigrationParameters struct for now").

MigrateSetParameters documentation issues:

* It claims plain text mode "was reported by omitting tls-creds"
  before 2.9.  MigrateSetParameters is not used for reporting, so this
  is misleading.  Delete.

* It similarly claims hostname defaulting to migration URI "was
  reported by omitting tls-hostname" before 2.9.  Delete as well.

Rephrase the remaining @tls-hostname contents for clarity.

Enum MigrationParameter mirrors the members of struct
MigrateSetParameters.  Differences to MigrateSetParameters's member
documentation are pointless.  Copy the new text to MigrationParameter.

MigrationParameters documentation issues:

* @tls-creds runs the two last sentences together without punctuation.
  Fix that.

* Much of the contents on @tls-hostname only applies to setting
  parameters, resulting in confusion.  Replace by a suitable abridged
  version of the new MigrateSetParameters text, and a note on
  @tls-hostname omission in 2.8.

Additional damage is due to flawed doc fix commit
66fcb9d651d (qapi/migration: Add missing tls-authz documentation):
since it copied the missing MigrateSetParameters text from
MigrationParameters instead of MigrationParameter, the part on
recreating @tls-authz on the fly is missing.  Copy that, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 63 +++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index aa1b39bce1..cbcc6946eb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -809,16 +809,19 @@
 #     for establishing a TLS connection over the migration data
 #     channel.  On the outgoing side of the migration, the credentials
 #     must be for a 'client' endpoint, while for the incoming side the
-#     credentials must be for a 'server' endpoint.  Setting this will
-#     enable TLS for all migrations.  The default is unset, resulting
-#     in unsecured migration at the QEMU level.  (Since 2.7)
+#     credentials must be for a 'server' endpoint.  Setting this to a
+#     non-empty string enables TLS for all migrations.  An empty
+#     string means that QEMU will use plain text mode for migration,
+#     rather than TLS.  (Since 2.7)
 #
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7)
+# @tls-hostname: migration target's hostname for validating the
+#     server's x509 certificate identify.  If empty, QEMU will use the
+#     hostname from the migration URI, if any.  A non-empty value is
+#     required when using x509 based TLS credentials and the migration
+#     URI does not include a hostname, such as fd: or exec: based
+#     migration.  (Since 2.7)
+#
+#     Note: empty value works only since 2.9.
 #
 # @tls-authz: ID of the 'authz' object subclass that provides access
 #     control checking of the TLS x509 certificate distinguished name.
@@ -1006,22 +1009,22 @@
 #     credentials must be for a 'server' endpoint.  Setting this to a
 #     non-empty string enables TLS for all migrations.  An empty
 #     string means that QEMU will use plain text mode for migration,
-#     rather than TLS (Since 2.9) Previously (since 2.7), this was
-#     reported by omitting tls-creds instead.
+#     rather than TLS.  This is the default.  (Since 2.7)
 #
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7) An empty string means that QEMU will use
-#     the hostname associated with the migration URI, if any.  (Since
-#     2.9) Previously (since 2.7), this was reported by omitting
-#     tls-hostname instead.
+# @tls-hostname: migration target's hostname for validating the
+#     server's x509 certificate identify.  If empty, QEMU will use the
+#     hostname from the migration URI, if any.  A non-empty value is
+#     required when using x509 based TLS credentials and the migration
+#     URI does not include a hostname, such as fd: or exec: based
+#     migration.  (Since 2.7)
+#
+#     Note: empty value works only since 2.9.
 #
 # @tls-authz: ID of the 'authz' object subclass that provides access
 #     control checking of the TLS x509 certificate distinguished name.
-#     (Since 4.0)
+#     This object is only resolved at time of use, so can be deleted
+#     and recreated on the fly while the migration server is active.
+#     If missing, it will default to denying access (Since 4.0)
 #
 # @max-bandwidth: to set maximum speed for migration.  maximum speed
 #     in bytes per second.  (Since 2.8)
@@ -1240,17 +1243,15 @@
 #     must be for a 'client' endpoint, while for the incoming side the
 #     credentials must be for a 'server' endpoint.  An empty string
 #     means that QEMU will use plain text mode for migration, rather
-#     than TLS (Since 2.7) Note: 2.8 reports this by omitting
-#     tls-creds instead.
+#     than TLS.  (Since 2.7)
 #
-# @tls-hostname: hostname of the target host for the migration.  This
-#     is required when using x509 based TLS credentials and the
-#     migration URI does not already include a hostname.  For example
-#     if using fd: or exec: based migration, the hostname must be
-#     provided so that the server's x509 certificate identity can be
-#     validated.  (Since 2.7) An empty string means that QEMU will use
-#     the hostname associated with the migration URI, if any.  (Since
-#     2.9) Note: 2.8 reports this by omitting tls-hostname instead.
+#     Note: 2.8 omits empty @tls-creds instead.
+#
+# @tls-hostname: migration target's hostname for validating the
+#     server's x509 certificate identify.  If empty, QEMU will use the
+#     hostname from the migration URI, if any.  (Since 2.7)
+#
+#     Note: 2.8 omits empty @tls-hostname instead.
 #
 # @tls-authz: ID of the 'authz' object subclass that provides access
 #     control checking of the TLS x509 certificate distinguished name.
-- 
2.44.0



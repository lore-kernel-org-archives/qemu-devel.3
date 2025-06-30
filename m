Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F0AC83033
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKf9-0002Xh-Pt; Mon, 30 Jun 2025 15:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKf6-0002Wt-5t
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:32 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKf4-0007St-CA
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33C9521161;
 Mon, 30 Jun 2025 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqJoHTBSRcc/4YjI8DdE3M7UxBxe/r5RCR2ucSwG+oE=;
 b=WK9XlLMYZOr05baFzcMDCRGn+Q8r5RYKN3isWlPefcTSbd8MlnEt6PbUDrKwLy+Xh0yFIn
 ESTDcV6IodIrFYr9E+oTTBuSKNjVPXtoAs8DzUkv+kaNtrnHoAKM1GNmX/DtuIeLaQLDQ7
 opg5YkGDO6KeNg2VUMjRF6dNKm5pAOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqJoHTBSRcc/4YjI8DdE3M7UxBxe/r5RCR2ucSwG+oE=;
 b=+UaFsfVLwir9bLtc1uSHCv9t83Jeb5hCt6vtiCJPpu5V5C4NJhDlmGy9dBBcqTXnIYYzwK
 Y68IFxL8cOTTq+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqJoHTBSRcc/4YjI8DdE3M7UxBxe/r5RCR2ucSwG+oE=;
 b=WK9XlLMYZOr05baFzcMDCRGn+Q8r5RYKN3isWlPefcTSbd8MlnEt6PbUDrKwLy+Xh0yFIn
 ESTDcV6IodIrFYr9E+oTTBuSKNjVPXtoAs8DzUkv+kaNtrnHoAKM1GNmX/DtuIeLaQLDQ7
 opg5YkGDO6KeNg2VUMjRF6dNKm5pAOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqJoHTBSRcc/4YjI8DdE3M7UxBxe/r5RCR2ucSwG+oE=;
 b=+UaFsfVLwir9bLtc1uSHCv9t83Jeb5hCt6vtiCJPpu5V5C4NJhDlmGy9dBBcqTXnIYYzwK
 Y68IFxL8cOTTq+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DAC11399F;
 Mon, 30 Jun 2025 19:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sKSxF5jsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 02/24] migration: Add a qdev property for StrOrNull
Date: Mon, 30 Jun 2025 16:58:51 -0300
Message-Id: <20250630195913.28033-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
was done about eight years ago so the migration code could make use of
qdev properties to define the defaults for the migration parameters
and to be able to expose migration knobs for debugging via the
'-global migration' command line option.

Due to unrelated historical reasons, three of the migration parameters
(TLS options) received different types when used via the
query-migrate-parameters QMP command than with the
migrate-set-parameters command. This has created a lot of duplication
in the migration code and in the QAPI documentation because the whole
of MigrationParameters had to be duplicated as well.

The migration code is now being fixed to remove the duplication and
for that to happen the offending fields need to be reconciled into a
single type. The StrOrNull type is going to be used.

To keep the command line compatibility, the parameters need to
continue being exposed via qdev properties accessible from the command
line. Introduce a qdev property StrOrNull just for that.

Note that this code is being kept in migration/options.c because this
version of StrOrNull doesn't need to handle QNULL because it was never
a valid option in the previous command line, which took a string.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 162c72cda4..384ef9e421 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -83,6 +83,11 @@
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
+const PropertyInfo qdev_prop_StrOrNull;
+#define DEFINE_PROP_STR_OR_NULL(_name, _state, _field)                  \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_StrOrNull, StrOrNull *, \
+                .set_default = true)
+
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
@@ -204,6 +209,48 @@ const Property migration_properties[] = {
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
+/*
+ * qdev property for TLS options handling via '-global migration'
+ * command line.
+ */
+static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
+    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
+
+    /*
+     * Only str to keep compatibility, QNULL was never used via
+     * command line.
+     */
+    str_or_null->type = QTYPE_QSTRING;
+    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
+        return;
+    }
+
+    qapi_free_StrOrNull(*ptr);
+    *ptr = str_or_null;
+}
+
+static void release_StrOrNull(Object *obj, const char *name, void *opaque)
+{
+    const Property *prop = opaque;
+    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
+}
+
+static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_str(op, "");
+}
+
+const PropertyInfo qdev_prop_StrOrNull = {
+    .type  = "StrOrNull",
+    .set = set_StrOrNull,
+    .release = release_StrOrNull,
+    .set_default_value = set_default_value_tls_opt,
+};
+
 bool migrate_auto_converge(void)
 {
     MigrationState *s = migrate_get_current();
-- 
2.35.3



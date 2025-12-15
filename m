Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D5AD5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGcy-0002Zx-Tv; Mon, 15 Dec 2025 17:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGcy-0002Zn-6N
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGcw-0002bT-Jl
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE8CE3378B;
 Mon, 15 Dec 2025 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHyH1wi1BDyLIvGvjJgSYDkoyZ9MRoI9THVPAKUCfYE=;
 b=FJ5E9FSRJk8BkeezYpia4TkQQgvd2rETsLyJHpO8pVQ5z6AwGCPs2W6XjL+saeDBEQ8mSq
 cEfdjPjYXKoC+uakyrmIbz0lihlSRMlSsY8LsEQq7CkyUqt9+I3XhUrumFSUpWIgfb6jZO
 ovnHSpx6L5z+uYjJ/Yew9arcJf7KTUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHyH1wi1BDyLIvGvjJgSYDkoyZ9MRoI9THVPAKUCfYE=;
 b=OBP+Hg/ONQr28qpNkI5pGxCBMkBF0OoEJcJ9moee/ZhYxXCOIMiJpryjunjbmBXfXGOgEj
 uNBzsPi5BMBxSOAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHyH1wi1BDyLIvGvjJgSYDkoyZ9MRoI9THVPAKUCfYE=;
 b=mALyZqfATZsDI/IndyPAJsLB3CrQOha9KoFXY8Csb1iZjHZica7GJY1rBSzc0aG8khBqLn
 ElhmpHg9rJn6jxKnfbxkCnV5OeglpyMltSGyumfApps7juJU5tDpdWUVZfL3ATwviYSvUC
 pL9MJZy/toFXjNkr0SLUDmML56XJ2nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHyH1wi1BDyLIvGvjJgSYDkoyZ9MRoI9THVPAKUCfYE=;
 b=vqvkh9ZjtXYooMj7h4XI+mY9aSC+KHLeA+Bvl84vJBhnVZ6DV53YY4CoA+auPOcMtdUduU
 pqXPQTJMOIeJSdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B7023EA63;
 Mon, 15 Dec 2025 22:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2FCTBxuFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:00:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 03/51] migration: Add a qdev property for StrOrNull
Date: Mon, 15 Dec 2025 18:59:49 -0300
Message-ID: <20251215220041.12657-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.988];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
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

Note that this code is being kept in migration/options.c as this
version of StrOrNull doesn't need to handle QNULL because it was never
a valid option in the previous command line, which took a string.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index e78324b80c..5f387437d1 100644
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
 
@@ -206,6 +211,68 @@ const Property migration_properties[] = {
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
+static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
+    StrOrNull *str_or_null = *ptr;
+
+    if (!str_or_null) {
+        str_or_null = g_new0(StrOrNull, 1);
+        str_or_null->type = QTYPE_QSTRING;
+        str_or_null->u.s = g_strdup("");
+    } else {
+        /* the setter doesn't allow QNULL */
+        assert(str_or_null->type != QTYPE_QNULL);
+    }
+    visit_type_str(v, name, &str_or_null->u.s, errp);
+}
+
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
+/*
+ * String property like qdev_prop_string, except it's backed by a
+ * StrOrNull instead of a char *.  This is intended for
+ * TYPE_MIGRATION's TLS options.
+ */
+const PropertyInfo qdev_prop_StrOrNull = {
+    .type  = "StrOrNull",
+    .get = get_StrOrNull,
+    .set = set_StrOrNull,
+    .release = release_StrOrNull,
+    .set_default_value = set_default_value_tls_opt,
+};
+
 bool migrate_auto_converge(void)
 {
     MigrationState *s = migrate_get_current();
-- 
2.51.0



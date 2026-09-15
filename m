Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C881C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GdO-0003Re-Fc; Mon, 14 Sep 2026 20:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdN-0003R3-BK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:49 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6GdI-0004oQ-I1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D9951FF68;
 Tue, 15 Sep 2026 00:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myFIaXNmvl469O/7W29LW3v/i9d5K9UTEqiLSqTboW0=;
 b=oftlW7OfUSqLC8cH7/6VpEnaJuUJFaMAwrFwIVlLGtCRmewchrGVAZ06VVdS1cTJer9n/4
 D5yk5w4wzl5+Xj+AD4vWxCcuGYx+r+8otGOQzTOe7/gLU22dG4x6X7XlUvow3H8gqLt1Xr
 nOrk2ZhEWNsH7rwKL++MYTElKqwiyU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myFIaXNmvl469O/7W29LW3v/i9d5K9UTEqiLSqTboW0=;
 b=GpR9h+wX4dVl50yq9Ys+hBg8mMDbEhYgEmFKG4ThnVJbWqvlCpSmT5h2wikiUQ9uoJNTyD
 ezQs61a6Yd9OefCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hUh9aCCc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9mLm32Il
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myFIaXNmvl469O/7W29LW3v/i9d5K9UTEqiLSqTboW0=;
 b=hUh9aCCcyr1Gp1GeobYiBtKTAdafdwFfgXcZkQKhkN4gKxX636KCMQFD5Kd6IkbG9fL0y6
 Xstps2zUHyjCb0vtBkLQ2deXJ8vRENPhq0UUd8847w7zLroqkmLOhWBAnAHNDT+Jp/KkLL
 kKkWkFbWWXjibAA7OcjLib+4yEO2jV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myFIaXNmvl469O/7W29LW3v/i9d5K9UTEqiLSqTboW0=;
 b=9mLm32Ilcq5tLjgYbZCB2TYxOzRwsGyJ2uf/OvcRK5poSVzWTrWuciAsUS7j9Za+0qjgA8
 Bx2+XvxJj93DeBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E36F13806;
 Tue, 15 Sep 2026 00:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig:T12
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 11/20] migration: HMP: Change bandwidth parameters expected
 input unit
Date: Mon, 14 Sep 2026 21:01:59 -0300
Message-ID: <20260915000209.3692668-12-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915000209.3692668-1-farosas@suse.de>
References: <20260915000209.3692668-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D9951FF68
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[treblig.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The max-bandwidth and avail-switchover-bandwidth parameters are
declared as bytes/second in migration.json and interpreted as such
throughout the code, except in HMP input where they're expected to be
provided as mebibytes.

Adjust the HMP code to take the values as bytes to make it uniform.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c     | 23 +++--------------------
 tests/qtest/migration/misc-tests.c |  5 ++---
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 27b38d0e5f..67ea2eea15 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -596,10 +596,9 @@ void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
     MigrationParameters *p = g_new0(MigrationParameters, 1);
-    uint64_t valuebw = 0;
     uint64_t cache_size;
     Error *err = NULL;
-    int val, ret;
+    int val;
 
     val = qapi_enum_parse(&MigrationParameter_lookup, param, -1, &err);
     if (val < 0) {
@@ -644,27 +643,11 @@ void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
         break;
     case MIGRATION_PARAMETER_MAX_BANDWIDTH:
         p->has_max_bandwidth = true;
-        /*
-         * Can't use visit_type_size() here, because it
-         * defaults to Bytes rather than Mebibytes.
-         */
-        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
-        if (ret < 0 || valuebw > INT64_MAX
-            || (size_t)valuebw != valuebw) {
-            error_setg(&err, "Invalid size %s", valuestr);
-            break;
-        }
-        p->max_bandwidth = valuebw;
+        visit_type_size(v, param, &p->max_bandwidth, &err);
         break;
     case MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH:
         p->has_avail_switchover_bandwidth = true;
-        ret = qemu_strtosz_MiB(valuestr, NULL, &valuebw);
-        if (ret < 0 || valuebw > INT64_MAX
-            || (size_t)valuebw != valuebw) {
-            error_setg(&err, "Invalid size %s", valuestr);
-            break;
-        }
-        p->avail_switchover_bandwidth = valuebw;
+        visit_type_size(v, param, &p->avail_switchover_bandwidth, &err);
         break;
     case MIGRATION_PARAMETER_DOWNTIME_LIMIT:
         p->has_downtime_limit = true;
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 41bf123359..f70d35c658 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -161,9 +161,8 @@ static void test_hmp_migration_parameters(char *name, MigrateCommon *args)
         TEST("announce-rounds", "6", "6"),
         TEST("announce-step", "15", "15 ms"),
         TEST("downtime-limit", "400", "400 ms"),
-        TEST("avail-switchover-bandwidth", "2097152",
-             "2199023255552 bytes/second"),
-        TEST("max-bandwidth", "9876543", "10356305952768 bytes/second"),
+        TEST("avail-switchover-bandwidth", "2097152", "2097152 bytes/second"),
+        TEST("max-bandwidth", "9876543", "9876543 bytes/second"),
         TEST("max-postcopy-bandwidth", "1048576", "1048576 bytes/second"),
         TEST("vcpu-dirty-limit", "20", "20 MB/s"),
         TEST("x-rdma-chunk-size", "1048576", "1048576 bytes"),
-- 
2.53.0



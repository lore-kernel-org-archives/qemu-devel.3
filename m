Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD73C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXn-0007Qf-FK; Wed, 29 Jan 2025 11:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWA-0003ur-Be
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW8-0005P1-D5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 470B121109;
 Wed, 29 Jan 2025 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9RbctlBSsFSGov6OwDxhUnlNdnsy7Q1F7c9N+LWQ9A=;
 b=WjR+Uc6C/p4ZlrIXLY3lnPKCLEZtxw5hQ5am6n5gbU6Cf/pejQ2dUc9UQUk62/TLpYNghg
 0cBKKwcEll6BIzdriFAp9iFq/NHmpZ1lc2pn7DSeYq/Ls5cjhSR8D0CpuLxJbiepyJAgDE
 L9tuUKsvbX5Uu9qxLHWyYqp48se5WvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9RbctlBSsFSGov6OwDxhUnlNdnsy7Q1F7c9N+LWQ9A=;
 b=BQGpt7z0SMeIt7Sh1agilJTzacI1K8+jZETptb8v/CREP+2xY2BmTA/F1OgCybwLhy1/Hk
 HHs1BG1dqKrFidAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9RbctlBSsFSGov6OwDxhUnlNdnsy7Q1F7c9N+LWQ9A=;
 b=WjR+Uc6C/p4ZlrIXLY3lnPKCLEZtxw5hQ5am6n5gbU6Cf/pejQ2dUc9UQUk62/TLpYNghg
 0cBKKwcEll6BIzdriFAp9iFq/NHmpZ1lc2pn7DSeYq/Ls5cjhSR8D0CpuLxJbiepyJAgDE
 L9tuUKsvbX5Uu9qxLHWyYqp48se5WvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9RbctlBSsFSGov6OwDxhUnlNdnsy7Q1F7c9N+LWQ9A=;
 b=BQGpt7z0SMeIt7Sh1agilJTzacI1K8+jZETptb8v/CREP+2xY2BmTA/F1OgCybwLhy1/Hk
 HHs1BG1dqKrFidAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7C0E137DB;
 Wed, 29 Jan 2025 16:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OGDvHQVRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 35/42] migration: Take BQL slightly longer in postcopy_start()
Date: Wed, 29 Jan 2025 13:00:52 -0300
Message-Id: <20250129160059.6987-36-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
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

From: Peter Xu <peterx@redhat.com>

This paves way for some follow up patch to modify migration states at the
end of postcopy_start(), which should better be with the BQL so that
there's no way of concurrent cancellation.

So we'll do something slightly more with BQL but they're really trivial,
hopefully nothing will really chance with this.

A side benefit is we can drop another explicit lock() in failure path.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-11-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5a3d0750ec..4ba6c8912a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2753,8 +2753,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     migration_downtime_end(ms);
 
-    bql_unlock();
-
     if (migrate_postcopy_ram()) {
         /*
          * Although this ping is just for debug, it could potentially be
@@ -2770,7 +2768,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
         error_setg_errno(errp, -ret, "postcopy_start: Migration stream error");
-        bql_lock();
         goto fail;
     }
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
@@ -2781,6 +2778,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_rate_set(migrate_max_postcopy_bandwidth());
 
+    bql_unlock();
+
     return ret;
 
 fail_closefb:
-- 
2.35.3



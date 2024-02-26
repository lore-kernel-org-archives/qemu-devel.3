Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018E6C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehdV-00058f-0s; Mon, 26 Feb 2024 15:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehdM-00057I-Fb
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:31:34 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehdK-0001mL-Ql
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:31:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79AE21FB6D;
 Mon, 26 Feb 2024 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708979489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkYAKUbIVXfvlnyqRX1w3xvaidp9O1g9QosMrFa8HGU=;
 b=d8ga6ytykxrNyG5HkpWysGgSmmLgxYug74MxF3GGOJHZqyv1UD+ovTH5PBUrmbU698gntg
 qeGIqS323W7U/r/hgFLXwbQlf3JeAyakYOzzY6aZwCDpT/lrb60yhp/sOFM46C1WrjTkry
 onY3fzIChsZWjLXzmKDbmwUD7DGTxek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708979489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkYAKUbIVXfvlnyqRX1w3xvaidp9O1g9QosMrFa8HGU=;
 b=l9h0AU9YNCqthciVh/pusJPGWdfDguLzUfnXEfzEx6z65+Bop2B9eDjKw9KuTQaFjMjho5
 sIWW8sonwXDm+sCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708979489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkYAKUbIVXfvlnyqRX1w3xvaidp9O1g9QosMrFa8HGU=;
 b=d8ga6ytykxrNyG5HkpWysGgSmmLgxYug74MxF3GGOJHZqyv1UD+ovTH5PBUrmbU698gntg
 qeGIqS323W7U/r/hgFLXwbQlf3JeAyakYOzzY6aZwCDpT/lrb60yhp/sOFM46C1WrjTkry
 onY3fzIChsZWjLXzmKDbmwUD7DGTxek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708979489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkYAKUbIVXfvlnyqRX1w3xvaidp9O1g9QosMrFa8HGU=;
 b=l9h0AU9YNCqthciVh/pusJPGWdfDguLzUfnXEfzEx6z65+Bop2B9eDjKw9KuTQaFjMjho5
 sIWW8sonwXDm+sCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A9113A3A;
 Mon, 26 Feb 2024 20:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OEU/ByD13GWJSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 20:31:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/2] migration: Use migrate_has_error() in
 close_return_path_on_source()
Date: Mon, 26 Feb 2024 17:31:22 -0300
Message-Id: <20240226203122.22894-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240226203122.22894-1-farosas@suse.de>
References: <20240226203122.22894-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.99)[99.96%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

close_return_path_on_source() retrieves the migration error from the
the QEMUFile '->to_dst_file' to know if a shutdown is required. This
shutdown is required to exit the return-path thread.

Avoid relying on '->to_dst_file' and use migrate_has_error() instead.

(using to_dst_file is a heuristic to infer whether
rp_state.from_dst_file might be stuck on a recvmsg(). Using a generic
method for detecting errors is more reliable. We also want to reduce
dependency on QEMUFile::last_error)

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
[added some words about the motivation for this patch]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3161be7cde..5316bbe670 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2380,8 +2380,7 @@ static bool close_return_path_on_source(MigrationState *ms)
      * cause it to unblock if it's stuck waiting for the destination.
      */
     WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
-            qemu_file_get_error(ms->to_dst_file)) {
+        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
             qemu_file_shutdown(ms->rp_state.from_dst_file);
         }
     }
-- 
2.35.3



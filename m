Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05FDC83033
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 19:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKf6-0002X2-MP; Mon, 30 Jun 2025 15:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKf0-0002W5-Jl
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:26 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKey-0007S7-HI
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 15:59:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2086D2115E;
 Mon, 30 Jun 2025 19:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8sBxHCz6UsEHsBrqDBr0hFHfzK51JJaKNlFGGAXLwU=;
 b=n0Mj1B0nvKXgmPoqjldpRFmOzPEsL9wt+0QSFiAZbuU3wU+G6H4pbnLtBs7//3UT2wt6T2
 rf1xVCaT9XESYxbTteOImxbAhMW65BHuj9jS0jgJ9O3A+4oxWrHcSo+cXr6zq1Pp+iSx5X
 ZhbI/wOk3gDWG0S7bTUKc+vc78Myt9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8sBxHCz6UsEHsBrqDBr0hFHfzK51JJaKNlFGGAXLwU=;
 b=BU2th09RJ4BRLkUXmmt/UH88rarzsMx5QfQ/gIiGXKQgjz9fcODz84g9+dkdqHEbIryCGg
 6/3MulkFvMkNI/AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8sBxHCz6UsEHsBrqDBr0hFHfzK51JJaKNlFGGAXLwU=;
 b=n0Mj1B0nvKXgmPoqjldpRFmOzPEsL9wt+0QSFiAZbuU3wU+G6H4pbnLtBs7//3UT2wt6T2
 rf1xVCaT9XESYxbTteOImxbAhMW65BHuj9jS0jgJ9O3A+4oxWrHcSo+cXr6zq1Pp+iSx5X
 ZhbI/wOk3gDWG0S7bTUKc+vc78Myt9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8sBxHCz6UsEHsBrqDBr0hFHfzK51JJaKNlFGGAXLwU=;
 b=BU2th09RJ4BRLkUXmmt/UH88rarzsMx5QfQ/gIiGXKQgjz9fcODz84g9+dkdqHEbIryCGg
 6/3MulkFvMkNI/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 952541399F;
 Mon, 30 Jun 2025 19:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iAySFZbsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 01/24] migration: Fix leak of block_bitmap_mapping
Date: Mon, 30 Jun 2025 16:58:50 -0300
Message-Id: <20250630195913.28033-2-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Caught by inspection, but ASAN also reports:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
 #0 in malloc
 #1 in g_malloc
 #2 in g_memdup
 #3 in qapi_clone_start_struct ../qapi/qapi-clone-visitor.c:40:12
 #4 in qapi_clone_start_list ../qapi/qapi-clone-visitor.c:59:12
 #5 in visit_start_list ../qapi/qapi-visit-core.c:80:10
 #6 in visit_type_BitmapMigrationNodeAliasList qapi/qapi-visit-migration.c:639:10
 #7 in migrate_params_apply ../migration/options.c:1407:13
 #8 in qmp_migrate_set_parameters ../migration/options.c:1463:5
 #9 in qmp_marshal_migrate_set_parameters qapi/qapi-commands-migration.c:214:5
 #10 in do_qmp_dispatch_bh ../qapi/qmp-dispatch.c:128:5

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 4098870bce..7ec60d97f9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4050,6 +4050,7 @@ static void migration_instance_finalize(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
+    qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
-- 
2.35.3



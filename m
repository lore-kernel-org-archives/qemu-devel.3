Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BDFC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoa-0003Hv-1B; Tue, 20 Feb 2024 17:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoW-0003G5-Tf
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoV-0006Kx-5f
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CCBA2225A;
 Tue, 20 Feb 2024 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=900XvnPK2l/P0GLLO6Va4KDZ6PV5wQ65E53gkQyrLFA=;
 b=wuN/uzEnDnYhbhGwuNxGTBpkMh542IXvbcfmYux1qWx/v9wp/BIw7hGdAr8DdwFPpKD5mz
 2bkn/7zvKJlYvLyK6On0kkNR4ci9zu4mFxGB5KhRxwaXIJBgRp0y50EenfjFsD6ILFj9va
 aC64dt8JidL/hi4+n787To/MsJlOZyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=900XvnPK2l/P0GLLO6Va4KDZ6PV5wQ65E53gkQyrLFA=;
 b=8EKwWSm3k7gkWAQ5UxSu5nSDNFcnbhUGsGtwKlUIHvNEOGWVYhLfZniEnkAXgT1+WSrPS9
 sAzT6Sy3i1q8xIDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=900XvnPK2l/P0GLLO6Va4KDZ6PV5wQ65E53gkQyrLFA=;
 b=wuN/uzEnDnYhbhGwuNxGTBpkMh542IXvbcfmYux1qWx/v9wp/BIw7hGdAr8DdwFPpKD5mz
 2bkn/7zvKJlYvLyK6On0kkNR4ci9zu4mFxGB5KhRxwaXIJBgRp0y50EenfjFsD6ILFj9va
 aC64dt8JidL/hi4+n787To/MsJlOZyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=900XvnPK2l/P0GLLO6Va4KDZ6PV5wQ65E53gkQyrLFA=;
 b=8EKwWSm3k7gkWAQ5UxSu5nSDNFcnbhUGsGtwKlUIHvNEOGWVYhLfZniEnkAXgT1+WSrPS9
 sAzT6Sy3i1q8xIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DBB3139D0;
 Tue, 20 Feb 2024 22:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLJkDcAq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 12/34] migration: Add fixed-ram URI compatibility check
Date: Tue, 20 Feb 2024 19:41:16 -0300
Message-Id: <20240220224138.24759-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[99.99%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The fixed-ram migration format needs a channel that supports seeking
to be able to write each page to an arbitrary offset in the migration
stream.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..16da269847 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -142,10 +142,39 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     return false;
 }
 
+static bool migration_needs_seekable_channel(void)
+{
+    return migrate_fixed_ram();
+}
+
+static bool transport_supports_seeking(MigrationAddress *addr)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        return true;
+    }
+
+    /*
+     * At this point, the user might not yet have passed the file
+     * descriptor to QEMU, so we cannot know for sure whether it
+     * refers to a plain file or a socket. Let it through anyway.
+     */
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        return addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD;
+    }
+
+    return false;
+}
+
 static bool
 migration_channels_and_transport_compatible(MigrationAddress *addr,
                                             Error **errp)
 {
+    if (migration_needs_seekable_channel() &&
+        !transport_supports_seeking(addr)) {
+        error_setg(errp, "Migration requires seekable transport (e.g. file)");
+        return false;
+    }
+
     if (migration_needs_multiple_sockets() &&
         !transport_supports_multi_channels(addr)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
-- 
2.35.3



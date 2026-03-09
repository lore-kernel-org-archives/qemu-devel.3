Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FAAF3C24D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaL0-0006ek-Rp; Mon, 09 Mar 2026 09:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaKz-0006e6-A9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:07:57 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaKx-00087Z-Mx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:07:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF5865BDC1;
 Mon,  9 Mar 2026 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy8KN+46QRzcDgjMvL5YwDy3AmTxB6WCiZtfuFM46VI=;
 b=0N2+0aGqt74OYtFwe0WioHoAW1hK9zYW7YDjMy8SaRIgm9C8ueysIgrTrPFpfrJhvxw9KO
 IhqDF24opYbEHcHC9s4TLHH6WAUj87g94+/QTKcQ1le2BOhrvZtr7iMGzfle5wnr9FFWJs
 yKzklVAyicE+tqgwUYGQXPUdlo4jNlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy8KN+46QRzcDgjMvL5YwDy3AmTxB6WCiZtfuFM46VI=;
 b=9JZI58J7syBLe2N5CGtwVGae9lI1YdSV7+qEMCX8FvUlN/0FwqQLg4J+QKeqo3c1XoENrh
 HOca5xiw0zWz+wCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy8KN+46QRzcDgjMvL5YwDy3AmTxB6WCiZtfuFM46VI=;
 b=0N2+0aGqt74OYtFwe0WioHoAW1hK9zYW7YDjMy8SaRIgm9C8ueysIgrTrPFpfrJhvxw9KO
 IhqDF24opYbEHcHC9s4TLHH6WAUj87g94+/QTKcQ1le2BOhrvZtr7iMGzfle5wnr9FFWJs
 yKzklVAyicE+tqgwUYGQXPUdlo4jNlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy8KN+46QRzcDgjMvL5YwDy3AmTxB6WCiZtfuFM46VI=;
 b=9JZI58J7syBLe2N5CGtwVGae9lI1YdSV7+qEMCX8FvUlN/0FwqQLg4J+QKeqo3c1XoENrh
 HOca5xiw0zWz+wCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B104E3EEF2;
 Mon,  9 Mar 2026 13:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJlRHSLGrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:07:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 08/22] multifd: Move ram state receive into
 multifd_ram_state_recv()
Date: Mon,  9 Mar 2026 10:07:13 -0300
Message-ID: <20260309130730.20526-9-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
References: <20260309130730.20526-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Lukas Straub <lukasstraub2@web.de>

This is in preparation for the next patch.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260302-colo_unit_test_multifd-v11-7-d653fb3b1d80@web.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 178c6b3350..4259ab2628 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1253,6 +1253,15 @@ static int multifd_device_state_recv(MultiFDRecvParams *p, Error **errp)
     return ret;
 }
 
+static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
+{
+    int ret;
+
+    ret = multifd_recv_state->ops->recv(p, errp);
+
+    return ret;
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MigrationState *s = migrate_get_current();
@@ -1387,7 +1396,7 @@ static void *multifd_recv_thread(void *opaque)
                 assert(use_packets);
                 ret = multifd_device_state_recv(p, &local_err);
             } else {
-                ret = multifd_recv_state->ops->recv(p, &local_err);
+                ret = multifd_ram_state_recv(p, &local_err);
             }
             if (ret != 0) {
                 break;
-- 
2.51.0



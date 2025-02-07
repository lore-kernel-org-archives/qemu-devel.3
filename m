Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33190C0219D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 19:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgUQl-0003Er-EC; Fri, 07 Feb 2025 14:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQj-0003Ee-LT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:25 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgUQi-0000Of-9d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 14:54:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 259FE1F44E;
 Fri,  7 Feb 2025 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNA3SEN7KgPoyguB35y2YPNML/Ov8n9pyOGoDsi+c90=;
 b=YWvDJj4xjaa01ZYrLFvWXWog2IOwvC7JzcZK9UW1gLsdzVFaCfXFwtN6ibYXMSQ6rdDMLK
 o8bHmhSDEIgHIe0ijfTJVV1gPan+ANOQq1EEMpqnDZr67MIOupi3Ou37GFC03FF1rpvHtO
 htYdMny9rUcO0/NIw6ZufRMB5ZXqJFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNA3SEN7KgPoyguB35y2YPNML/Ov8n9pyOGoDsi+c90=;
 b=i7pWd+9ErvWfIJO5flirwotWa7sL79xtvjW24rkZMQUbQazOxr90dZPHJ1w5jXXz+jrLZr
 49gvVDMb7YPP7EDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738958063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNA3SEN7KgPoyguB35y2YPNML/Ov8n9pyOGoDsi+c90=;
 b=YWvDJj4xjaa01ZYrLFvWXWog2IOwvC7JzcZK9UW1gLsdzVFaCfXFwtN6ibYXMSQ6rdDMLK
 o8bHmhSDEIgHIe0ijfTJVV1gPan+ANOQq1EEMpqnDZr67MIOupi3Ou37GFC03FF1rpvHtO
 htYdMny9rUcO0/NIw6ZufRMB5ZXqJFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738958063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNA3SEN7KgPoyguB35y2YPNML/Ov8n9pyOGoDsi+c90=;
 b=i7pWd+9ErvWfIJO5flirwotWa7sL79xtvjW24rkZMQUbQazOxr90dZPHJ1w5jXXz+jrLZr
 49gvVDMb7YPP7EDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80B4413694;
 Fri,  7 Feb 2025 19:54:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uNd+D+1kpme1GQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 19:54:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v3 8/8] migration: Check migration error after loadvm
Date: Fri,  7 Feb 2025 16:53:59 -0300
Message-Id: <20250207195359.17443-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207195359.17443-1-farosas@suse.de>
References: <20250207195359.17443-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

We're currently only checking the QEMUFile error after
qemu_loadvm_state(). This was causing a TLS termination error from
multifd recv threads to be ignored.

Start checking the migration error as well to avoid missing further
errors.

Regarding compatibility concerning the TLS termination error that was
being ignored, for QEMUs <= 9.2 - if the old QEMU is being used as
migration source - the recently added migration property
multifd-tls-clean-termination needs to be set to OFF in the
*destination* machine.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index bc375db282..4046faf009 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2940,7 +2940,11 @@ int qemu_loadvm_state(QEMUFile *f)
 
     /* When reaching here, it must be precopy */
     if (ret == 0) {
-        ret = qemu_file_get_error(f);
+        if (migrate_has_error(migrate_get_current())) {
+            ret = -EINVAL;
+        } else {
+            ret = qemu_file_get_error(f);
+        }
     }
 
     /*
-- 
2.35.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6743E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM86j-00078k-Tt; Fri, 13 Dec 2024 11:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tM86e-00078G-Jj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:01:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tM86c-00059r-Gs
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:01:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B0B41F785;
 Fri, 13 Dec 2024 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734105684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6pJxDp7MKQBHqt4WjMMKPKGJberSHFhCSRsI8woF6wg=;
 b=SOzsl/Zdvb9wbxr228pAg2LHmyW0d4+TBZRAaL6keJtYwqy7ms9FopHhF8r2iWDZDONOTf
 FAT5tEaIUo2bRTmqh3m8LtTzYTP36LaWwpfgavZJzoKkCVdAbEM7QwvxzkMXIXXb2PNI7g
 z8ufQ36k+UjAips0UDVLKE4xQR1DTd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734105684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6pJxDp7MKQBHqt4WjMMKPKGJberSHFhCSRsI8woF6wg=;
 b=14g9IKsQe2pWuC7tWqhKDui8YBoarKMY8sAybNypD0LCPTTNiBDz8PFTbMsZQYD1nT9Svn
 Xv5qr4cz+yjtpABQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="SOzsl/Zd";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=14g9IKsQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734105684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6pJxDp7MKQBHqt4WjMMKPKGJberSHFhCSRsI8woF6wg=;
 b=SOzsl/Zdvb9wbxr228pAg2LHmyW0d4+TBZRAaL6keJtYwqy7ms9FopHhF8r2iWDZDONOTf
 FAT5tEaIUo2bRTmqh3m8LtTzYTP36LaWwpfgavZJzoKkCVdAbEM7QwvxzkMXIXXb2PNI7g
 z8ufQ36k+UjAips0UDVLKE4xQR1DTd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734105684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6pJxDp7MKQBHqt4WjMMKPKGJberSHFhCSRsI8woF6wg=;
 b=14g9IKsQe2pWuC7tWqhKDui8YBoarKMY8sAybNypD0LCPTTNiBDz8PFTbMsZQYD1nT9Svn
 Xv5qr4cz+yjtpABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B55F137CF;
 Fri, 13 Dec 2024 16:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fm8XFFNaXGc9QwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Dec 2024 16:01:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/2] migration: Fix regressions
Date: Fri, 13 Dec 2024 13:01:18 -0300
Message-Id: <20241213160120.23880-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B0B41F785
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.92 / 50.00]; BAYES_HAM(-2.91)[99.62%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Hello,

A couple of fixes for regressions we have open in gitlab:

multifd from old QEMUs - https://gitlab.com/qemu-project/qemu/-/issues/2720
s390x CSS - https://gitlab.com/qemu-project/qemu/-/issues/2704

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1587733433

Fabiano Rosas (2):
  migration/multifd: Fix compat with QEMU < 9.0
  s390x: Fix CSS migration

 hw/s390x/s390-virtio-ccw.c |  2 +-
 migration/multifd.c        | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.35.3



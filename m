Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB4FC6172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 22:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spEQK-0000pL-Bk; Fri, 13 Sep 2024 18:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1spEQH-0000me-Us
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 18:05:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1spEQG-0002Fh-BL
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 18:05:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30CA0219B2;
 Fri, 13 Sep 2024 22:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726265146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VIS+/v5Dnf70mTwaDtHe2DRRn5PhKjTWu5XLODyjuQE=;
 b=FVfbrjmVLXbVqJgYf2x8ZBwPG6GDoyimYyoDa48f9vF/8k+hRr0F++JiliXnbByk5YaKcA
 o1LRpssmPGL9Metoms/KmtQgLoChZNSaHMjm9Amla5JPn2h+U346khbyRWHCxEDj0JGgt+
 yiyMcAt99lRRb+dJ/r3NlwZXkKh4Uqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726265146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VIS+/v5Dnf70mTwaDtHe2DRRn5PhKjTWu5XLODyjuQE=;
 b=hOlquGSumRDNIhwGdnXm/O55Gr5Yt4q2VKCx7IfH2WXJigzWbOQTcOiDWswhCwssTtjyn+
 qPEo8bId3rSyS8Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FVfbrjmV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hOlquGSu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726265146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VIS+/v5Dnf70mTwaDtHe2DRRn5PhKjTWu5XLODyjuQE=;
 b=FVfbrjmVLXbVqJgYf2x8ZBwPG6GDoyimYyoDa48f9vF/8k+hRr0F++JiliXnbByk5YaKcA
 o1LRpssmPGL9Metoms/KmtQgLoChZNSaHMjm9Amla5JPn2h+U346khbyRWHCxEDj0JGgt+
 yiyMcAt99lRRb+dJ/r3NlwZXkKh4Uqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726265146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VIS+/v5Dnf70mTwaDtHe2DRRn5PhKjTWu5XLODyjuQE=;
 b=hOlquGSumRDNIhwGdnXm/O55Gr5Yt4q2VKCx7IfH2WXJigzWbOQTcOiDWswhCwssTtjyn+
 qPEo8bId3rSyS8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F039013A72;
 Fri, 13 Sep 2024 22:05:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CQYtLTi35GaQQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Sep 2024 22:05:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] migration/multifd: Fix rb->receivedmap cleanup race
Date: Fri, 13 Sep 2024 19:05:40 -0300
Message-Id: <20240913220542.18305-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30CA0219B2
X-Spamd-Result: default: False [-5.00 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_THREE(0.00)[3]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

This fixes the crash we've been seing recently in migration-test. The
first patch is a cleanup to have only one place calling
qemu_loadvm_state_cleanup() and the second patch reorders the cleanup
calls to make multifd_recv_cleanup() run first and stop the recv
threads.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1453038652

Fabiano Rosas (2):
  migration/savevm: Remove extra load cleanup calls
  migration/multifd: Fix rb->receivedmap cleanup race

 migration/migration.c |  1 +
 migration/migration.h |  1 -
 migration/savevm.c    | 11 -----------
 3 files changed, 1 insertion(+), 12 deletions(-)

-- 
2.35.3



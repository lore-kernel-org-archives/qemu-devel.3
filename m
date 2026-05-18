Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE396CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0I1-0004ir-V3; Mon, 18 May 2026 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP0I0-0004iU-En
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:53:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP0Hy-0002YC-SX
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:53:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 061836777C
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779119632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C1psPl0I0Zr7kCvAo4ivWnug5E2Lfql/sMUZ2k2ci6k=;
 b=staDJRVE32lCN5/WxDbrlGsNGqZX43Lc3Fw97LFiaJ/2J0MxzjnEy/Yzw8fNbB19wPJFOf
 R0Hm1f5VgwH+NbBlyZRfitG8sI5f9R6oosxf7uOtE+fpagqG4zW8tZqigoVBaXM6H45/IM
 yPfA79Y6/635RvScXLqJGQ8+bfSJiO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779119632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C1psPl0I0Zr7kCvAo4ivWnug5E2Lfql/sMUZ2k2ci6k=;
 b=6m6EK9KuEwx2bP2mFfA9e6RdXRixS1jZAOO4D4+xkoZBVg+I292qZ6dnsKmZ4a4LPo1TAc
 1h6nUEZP16D25KBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779119632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C1psPl0I0Zr7kCvAo4ivWnug5E2Lfql/sMUZ2k2ci6k=;
 b=staDJRVE32lCN5/WxDbrlGsNGqZX43Lc3Fw97LFiaJ/2J0MxzjnEy/Yzw8fNbB19wPJFOf
 R0Hm1f5VgwH+NbBlyZRfitG8sI5f9R6oosxf7uOtE+fpagqG4zW8tZqigoVBaXM6H45/IM
 yPfA79Y6/635RvScXLqJGQ8+bfSJiO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779119632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C1psPl0I0Zr7kCvAo4ivWnug5E2Lfql/sMUZ2k2ci6k=;
 b=6m6EK9KuEwx2bP2mFfA9e6RdXRixS1jZAOO4D4+xkoZBVg+I292qZ6dnsKmZ4a4LPo1TAc
 1h6nUEZP16D25KBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FB74593A8
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 15:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UYtqEA82C2pEXQAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 15:53:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Qtest patches for 2026-05-18
Date: Mon, 18 May 2026 12:53:43 -0300
Message-ID: <20260518155344.5945-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 gitlab.com:url]
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

The following changes since commit ac6721b88df944ade0048822b2b74210f543d656:

  Merge tag 'vhost-user-rtc-pr-1' of https://gitlab.com/epilys/qemu into staging (2026-05-16 17:37:33 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20260518-pull-request

for you to fetch changes up to e68da5b7a2cd8f4635d3b253ac1581552a3df16f:

  tests/qtest: fix discarded const qualifier warning (2026-05-18 12:15:42 -0300)

----------------------------------------------------------------
QTest pull request

- fix strstr issue

----------------------------------------------------------------

Matthew Penney (1):
  tests/qtest: fix discarded const qualifier warning

 tests/qtest/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0



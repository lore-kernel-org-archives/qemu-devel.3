Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA848C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2FZ8-000735-2w; Thu, 03 Sep 2026 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2FZ0-00072I-4P
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 18:05:42 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2FYx-0003Xt-4R
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 18:05:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F551221F9
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2026 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788473131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AOvwEdeWVwaimxdlXVPcwP2LP65whoesmaxe/3UhXD4=;
 b=2Czy+YXo7ekSOXvPiJtUzti9IYSEWeY7HxYdO6zgzNR+HPkk86ZZEsKxUpblTTzF5xNpTp
 s0QhHgExhqfFQQ07aY9OLycYCmVubzEl9Q/8+yAVoctRC60cMu+M2Id6ZjsrBP0mGRuqiL
 012fVqCw8c4oFNecLK8G0INTCnpRZ7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788473131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AOvwEdeWVwaimxdlXVPcwP2LP65whoesmaxe/3UhXD4=;
 b=OfvAeFjg6tSxWcmvOMedzLfnmfVB0brdY0wr8ApIiEB5ktwRHIIuOQpha97mZxMlLXRIen
 MaVpC0g6toxzMjAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788473127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AOvwEdeWVwaimxdlXVPcwP2LP65whoesmaxe/3UhXD4=;
 b=dS7xHyO//FiTmBI0Q5udMvpRm5XOaVf6n5Z5bujdzJeauLZ2hT9azWRp4wyWx6+1x0OlFd
 uKNSw4+ElMXuHxbymx0+J6+XIfNOvc7fFCpXd3lp0PWVSy7V/1pJJDAaYxHAPzPGMuhbA0
 XprLfCkyk1ipBX3DQCUE+MumbgjfJUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788473127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AOvwEdeWVwaimxdlXVPcwP2LP65whoesmaxe/3UhXD4=;
 b=GDfcVf+JVh1f6SiPZ1fPY4VfLDqqC8ylDPsY4mxM38SHrHnKZuroubRzGzyNa8JuWbRBt6
 bfq6KRAol/VOqICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E45A136E6
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2026 22:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PmMyBybvmWppUQAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:05:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] A few leak fixes for QTest
Date: Thu,  3 Sep 2026 19:05:20 -0300
Message-ID: <20260903220523.2849019-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
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

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2818383684

Fabiano Rosas (3):
  ahci: Fix leak of IRQState
  migration: Drop iochannel reference during snapshot setup
  migration: Free the JSON writer during snapshots

 hw/ide/ahci.c         |  1 +
 migration/migration.c |  2 +-
 migration/migration.h |  1 +
 migration/savevm.c    | 11 ++++++++---
 4 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.53.0



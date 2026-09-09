Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036A9C88E40
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 22:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4QYn-0001jl-AY; Wed, 09 Sep 2026 18:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4QYm-0001jX-4a
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 18:14:28 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4QYk-0000xl-MU
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 18:14:27 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E84E1FCED
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2026 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788992060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jPC9uTxdoYOFJ5vRBxkyrlgGDaWtELoWUPi7BpmD8Qo=;
 b=P8D0bTnQEAXaLKV8TLdhzlZ3NG/Q8iKTVk/NWjrRpD5pcDW3JxVR9kgHZjeEX7fwcUa8x3
 20czqikHRvfArZTzS69Z76Sf+stScgz6b/eowem+Ek+Fh5do2UDySNdVZzilcY/SMrMip0
 mqcIVGmG23JYTOvF8wiyVNJa8mKNR/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788992060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jPC9uTxdoYOFJ5vRBxkyrlgGDaWtELoWUPi7BpmD8Qo=;
 b=sHAOI2nM+8raVi9N/Y88PVREW5yQkI/QnmTr44KkMB9WC9LG64kVLQA4WNcRTkuNReBypu
 vaG1QzQFQyvMMOAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788992056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jPC9uTxdoYOFJ5vRBxkyrlgGDaWtELoWUPi7BpmD8Qo=;
 b=Vk+Ru+S4rki/5Xf8e/U1m7gRFT8L9ZxaCMx4yF6dqhMCt0pAdk9MTSRhzQzt/cOypuygxi
 C6plAh8Gevlti3cku1nvbVsSMaZ6LxcOnlpDcnx76gKyWKBTURfUCQGLDoJsJm++vzveP4
 5MT0/BMjiDK8rVa3/gvTx3YEi8opFB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788992056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jPC9uTxdoYOFJ5vRBxkyrlgGDaWtELoWUPi7BpmD8Qo=;
 b=oVs1/hAQxgPu6q7tyXixtFrY28qc97nRlZ/rXCiA3pyDQ0IJ8tsNRSsHpCN93a349rWadF
 nI541ZKrPnb+XeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A63D113185
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2026 22:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yqpdHTfaoWqMPwAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 22:14:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] A few leak fixes for QTest
Date: Wed,  9 Sep 2026 19:14:06 -0300
Message-ID: <20260909221409.291560-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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


Fabiano Rosas (3):
  ahci: Fix leak of IRQState
  migration: Drop iochannel reference during snapshot setup
  migration: Free the JSON writer during snapshots

 hw/ide/ahci.c         |  1 +
 migration/migration.c |  2 +-
 migration/migration.h |  1 +
 migration/savevm.c    | 10 ++++++++--
 4 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.53.0



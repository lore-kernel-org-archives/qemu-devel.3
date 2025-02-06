Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92539C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg69Z-0005w1-6n; Thu, 06 Feb 2025 12:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69X-0005vI-TO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:03 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69W-0001Ia-CB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:03 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02AE52115F;
 Thu,  6 Feb 2025 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z4dgHOSSEyPp7cYp3bp7jB3Gp6bAXeF6Y/Td8liEeUg=;
 b=ZKBn5LEcW2FuaRpBC/aXof2CIRyWO9cXUCqrxtKSOgdOD+DFu2mj7VTcM+7i4nIwsqrOWn
 is6Ss3xnqxWwzaNr5afs3S1ESaJZxRCHlsSVCLiEDv6IRWeR0qPYNv2olHI/h0GGdmzEvs
 giLT757LOW/NBe6IcG+LbVQl1SJv4bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z4dgHOSSEyPp7cYp3bp7jB3Gp6bAXeF6Y/Td8liEeUg=;
 b=sAyeLuJjUUAwFEVvORe3iomX07+VPWVm+urhIn8ifSzR84TlGFpNMRl4Ua41/c6fGNxyJc
 fDhb3DgcehHI6VCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z4dgHOSSEyPp7cYp3bp7jB3Gp6bAXeF6Y/Td8liEeUg=;
 b=ZKBn5LEcW2FuaRpBC/aXof2CIRyWO9cXUCqrxtKSOgdOD+DFu2mj7VTcM+7i4nIwsqrOWn
 is6Ss3xnqxWwzaNr5afs3S1ESaJZxRCHlsSVCLiEDv6IRWeR0qPYNv2olHI/h0GGdmzEvs
 giLT757LOW/NBe6IcG+LbVQl1SJv4bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z4dgHOSSEyPp7cYp3bp7jB3Gp6bAXeF6Y/Td8liEeUg=;
 b=sAyeLuJjUUAwFEVvORe3iomX07+VPWVm+urhIn8ifSzR84TlGFpNMRl4Ua41/c6fGNxyJc
 fDhb3DgcehHI6VCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D60013697;
 Thu,  6 Feb 2025 17:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VU6kAmP4pGeVZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Feb 2025 17:58:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 0/4] crypto,io,migration: Add support to gnutls_bye()
Date: Thu,  6 Feb 2025 14:58:20 -0300
Message-Id: <20250206175824.22664-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

Hi,

We've been discussing a way to stop multifd recv threads from getting
an error at the end of migration when the source threads close the
iochannel without ending the TLS session.

The original issue was introduced by commit 1d457daf86
("migration/multifd: Further remove the SYNC on complete") which
altered the synchronization of the source and destination in a manner
that causes the destination to already be waiting at recv() when the
source closes the connection.

One approach would be to issue gnutls_bye() at the source after all
the data has been sent. The destination would then gracefully exit
when it gets EOF.

Aside from stopping the recv thread from seeing an error, this also
creates a contract that all connections should be closed only after
the TLS session is ended. This helps to avoid masking a legitimate
issue where the connection is closed prematurely.

Fabiano Rosas (4):
  crypto: Allow gracefully ending the TLS session
  io: tls: Add qio_channel_tls_bye
  migration/multifd: Terminate the TLS connection
  migration: Check migration error after loadvm

 crypto/tlssession.c         | 40 ++++++++++++++++++
 include/crypto/tlssession.h | 22 ++++++++++
 include/io/channel-tls.h    | 12 ++++++
 io/channel-tls.c            | 84 +++++++++++++++++++++++++++++++++++++
 io/trace-events             |  5 +++
 migration/multifd.c         | 34 ++++++++++++++-
 migration/savevm.c          |  6 ++-
 migration/tls.c             |  5 +++
 migration/tls.h             |  2 +-
 9 files changed, 207 insertions(+), 3 deletions(-)

-- 
2.35.3



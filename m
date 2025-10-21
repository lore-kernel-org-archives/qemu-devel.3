Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5368CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8ov-0001mu-PL; Tue, 21 Oct 2025 05:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clopez@suse.de>) id 1vB8ou-0001lZ-9V
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:38:20 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clopez@suse.de>) id 1vB8or-0000kJ-W4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:38:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46A8421197;
 Tue, 21 Oct 2025 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761039487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RbHQrxrqTZ5WCWGuMWr94x1LRY7unI19x4o0Rkpk0oE=;
 b=c70gG8JYEHiJ1xwWvutCraV5AIkEsiPdPQtoItpErvP4OuD5Y3GohlfQIh0WAy0g4cUsHX
 r1jM5Y9XdNUC9n9YA2bl96c+LPNJtDQwhcWzPnVYvEwrgKAkVKtut/AlwkHQj6iUjQWMDb
 d5kJzlJjBq2PrmUATU38sBNH27pdIrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761039487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RbHQrxrqTZ5WCWGuMWr94x1LRY7unI19x4o0Rkpk0oE=;
 b=s3w/yYHQdFI/yx9jKxFeV8xtV16ndZ+kMQn2JYcaTMRXltOmI4qyFImZcwPQCfKfM5lfsB
 g+QeKuT2tfq/4gDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761039483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RbHQrxrqTZ5WCWGuMWr94x1LRY7unI19x4o0Rkpk0oE=;
 b=h4ENgzdc9CQG6TQczQW55ghKcW/TFf+esYlhSqGBHP0PF6qFKLO4jQIl8eclysgB+JKU6A
 G2rbp6lJRMY2/6BXIKwBfB80MoMGEepFAkIEom+FPwGJDem9BncBNXkjMD16gN9hCMI4Wq
 sw/sdTlFuQndd+htOIHN6vnmef73+zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761039483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RbHQrxrqTZ5WCWGuMWr94x1LRY7unI19x4o0Rkpk0oE=;
 b=tX1bl/iOV79zn5ce0Wq/7wyF5WyCZGXLT/rijusmLmAHuCtFKyx5edQgbUussIWK1x+aSl
 mQlQ8qWsjMgjlKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1CFC139D8;
 Tue, 21 Oct 2025 09:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N95fNHpU92g6UgAAD6G6ig
 (envelope-from <clopez@suse.de>); Tue, 21 Oct 2025 09:38:02 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] docs/system: fix vfio-user console example format
Date: Tue, 21 Oct 2025 11:35:51 +0200
Message-ID: <20251021093550.766872-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=clopez@suse.de; helo=smtp-out1.suse.de
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

The rendering for the console example for vfio-user is displayed
incorrectly because of a missing indentation, causing the example to be
shown as regular text. Fix this by adding the required indentation.

Fixes: c688cc165b32 ("docs: add vfio-user documentation")
Signed-off-by: Carlos López <clopez@suse.de>
---
 docs/system/devices/vfio-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
index b6dcaa5615..e31548b3a4 100644
--- a/docs/system/devices/vfio-user.rst
+++ b/docs/system/devices/vfio-user.rst
@@ -20,7 +20,7 @@ Presuming a suitable ``vfio-user`` server has opened a socket at
 
 .. code-block:: console
 
--device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
+  -device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
 
 See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
 information.
-- 
2.51.0



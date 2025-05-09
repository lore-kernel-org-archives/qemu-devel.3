Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BF5C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 21:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDV73-0004s6-7p; Fri, 09 May 2025 17:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV70-0004rS-S1
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:30 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV6y-0004Jv-Rm
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AAC62117D
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yDAgfpoOgY9w8u6REk7l88gsk9cb05562YbJb1Hi3uo=;
 b=z/lE1bYIAkxqpOmgkrCwDjzicoQ84lFHVMPApHi5LFoW+pJa0AsCubppTp7zO+NQELd3me
 cB6s2W0OPeSEIo3z9RoU7tft+dn2Tn567tne1iaHmiGr4R7JPZTGK0U3U2zKTUM9qXZmM+
 a+HUn57CRaIegOJ6ynVr9RCbRNn1Si4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yDAgfpoOgY9w8u6REk7l88gsk9cb05562YbJb1Hi3uo=;
 b=SKn7nEe84Rfdqmf6xdU2IyPEP7JtTmsF5J7rWTyq1O2F4RQuVaOvyt+9j+2DH4/l8IhQod
 HaVcn0b+14VPJFDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yDAgfpoOgY9w8u6REk7l88gsk9cb05562YbJb1Hi3uo=;
 b=z/lE1bYIAkxqpOmgkrCwDjzicoQ84lFHVMPApHi5LFoW+pJa0AsCubppTp7zO+NQELd3me
 cB6s2W0OPeSEIo3z9RoU7tft+dn2Tn567tne1iaHmiGr4R7JPZTGK0U3U2zKTUM9qXZmM+
 a+HUn57CRaIegOJ6ynVr9RCbRNn1Si4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yDAgfpoOgY9w8u6REk7l88gsk9cb05562YbJb1Hi3uo=;
 b=SKn7nEe84Rfdqmf6xdU2IyPEP7JtTmsF5J7rWTyq1O2F4RQuVaOvyt+9j+2DH4/l8IhQod
 HaVcn0b+14VPJFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7808713931
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 21:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KgIFDSBxHmjkNwAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 21:18:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] QTest patches for 2025-05-09
Date: Fri,  9 May 2025 18:18:18 -0300
Message-Id: <20250509211821.23684-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

The following changes since commit 4b1f5b73e060971c434e70694d571adfee553027:

  tests/functional: Use -no-shutdown in the hppa_seabios test (2025-05-08 15:38:40 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20250509-pull-request

for you to fetch changes up to 98008aa41b93b2477782205dcbd9ce5978f26a7e:

  tests/qtest/cpu-plug-test: Add cpu hotplug support for LoongArch (2025-05-09 16:14:31 -0300)

----------------------------------------------------------------
Qtest pull request

- Fix migration-test invocation of qtest_init
- Simplify byte-swapping for virtio in libqos
- New cpu hotplug test for loongarch64

----------------------------------------------------------------

Bibo Mao (1):
  tests/qtest/cpu-plug-test: Add cpu hotplug support for LoongArch

Thomas Huth (1):
  tests/qtest/libqos: Avoid double swapping when using modern virtio

Vladimir Sementsov-Ogievskiy (1):
  qtest: introduce qtest_init_ext

 tests/qtest/cpu-plug-test.c       | 24 +++++++++++++++++
 tests/qtest/libqos/virtio.c       | 44 ++++++++++++++++++++-----------
 tests/qtest/libqtest.c            | 18 ++++---------
 tests/qtest/libqtest.h            | 30 +++++----------------
 tests/qtest/meson.build           |  3 ++-
 tests/qtest/migration/framework.c |  7 +++--
 6 files changed, 70 insertions(+), 56 deletions(-)

-- 
2.35.3



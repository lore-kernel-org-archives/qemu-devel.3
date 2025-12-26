Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24947E7AD77
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 17:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZBbB-0003ye-DB; Fri, 26 Dec 2025 12:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZBb9-0003xx-CL
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 12:27:31 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZBb6-0007AM-Cn
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 12:27:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D08DD5BCC1
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766770043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=il5kEA+xTQRgbovyGOTeYq1mhdzbNnBlC8HeeISoKO0=;
 b=XSwPKxjghG9fj7pnz6scVgMMPT8A9uVPdzphJnn1k+jh4E6C46H4I/eeTp7nqResxIpbox
 lqaGLSnKWtb6RwZZAA8z69oU9U2clvP8vwBbV4QRejyKUpaxLm6MxZ//JrufVubcUf7vw6
 GHGQO45xguAU5k4RruISCxcEFdwGqL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766770043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=il5kEA+xTQRgbovyGOTeYq1mhdzbNnBlC8HeeISoKO0=;
 b=OrjNNqZvtAi0VbpOfr+rPWxov/IVNyyoH37U5xufoeMGVnGFCKu1c/K8IK4Vmo17soDgWf
 hg6VVDA99SQrfRCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iD+1viho;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eK0WC0xu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766770041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=il5kEA+xTQRgbovyGOTeYq1mhdzbNnBlC8HeeISoKO0=;
 b=iD+1vihowUsjacohmxAoD/LRvkB+VtdQWgWzLOi+JG8V00XecgeWmFiw+aYbvXTw3mz+1N
 Tp1V6gOsBJMZ5ZOCIDptzizQaiFT/heo7xX9w3BITg7x7yKD80e9BXmU0vJASS8lG/Q3+V
 sfKjqVi8WVI9tZUHYb2AqHuqzpQIvqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766770041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=il5kEA+xTQRgbovyGOTeYq1mhdzbNnBlC8HeeISoKO0=;
 b=eK0WC0xugDRdjlXeFfkPB9jfdPmDT4E2XrOLMgZiZhxMN0CcDk9f37f14kxkDW69j43ACc
 fvLC71xlwfMv7UAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C4723EA63
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 17:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDHPLnjFTmmTAwAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 17:27:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] QTest patches for 2025-12-26
Date: Fri, 26 Dec 2025 14:27:17 -0300
Message-ID: <20251226172718.12071-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D08DD5BCC1
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.966]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

The following changes since commit 8dd5bceb2f9cc58481e9d22355a8d998220896de:

  Open 11.0 development tree (2025-12-23 14:45:38 +1100)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20251226-pull-request

for you to fetch changes up to 9eef3854d30911d117f85253f1f2a154e4076adf:

  tests/qtest: Do not use versioned pc-q35-5.0 machine anymore (2025-12-26 12:06:46 -0300)

----------------------------------------------------------------
Qtest pull request

- Fix tests using deprecated machine versions

----------------------------------------------------------------

Philippe Mathieu-Daudé (1):
  tests/qtest: Do not use versioned pc-q35-5.0 machine anymore

 tests/qtest/fuzz-e1000e-test.c | 2 +-
 tests/qtest/lpc-ich9-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0



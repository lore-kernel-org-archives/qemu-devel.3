Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A92DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSLF-0003mw-0l; Tue, 20 Aug 2024 13:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgSKx-0003kx-LI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:08:03 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgSKu-0007bJ-Sw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:08:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6350D2001A;
 Tue, 20 Aug 2024 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724173677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z862uK9sj7173dIjv/buZa3UNv6lp+ar8kxX7ypLB+Y=;
 b=cn4czjfodJTGokFl90WmwyQtgGI7Q9MA2gvfXG/XbYlXiva0131PU0rd5GzqMHZx2Oc4Ge
 qNt+bj7zPlUvnbDBDzLCw9j2HpMhqZn66KhYzTOrICCoTN8wOAMQ5bvkzWhwEUy7FF+eIR
 burC4wef2npXRkXqlssnzIr4qu/1tDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724173677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z862uK9sj7173dIjv/buZa3UNv6lp+ar8kxX7ypLB+Y=;
 b=GqfBUMTcTTa+giTF7xYfDxjo6Ce+NPIGOeh8qYFotvFmTP8E6REZ1KrXt2uyRJm+JCSfsz
 6FsowirmTS+NvhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724173677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z862uK9sj7173dIjv/buZa3UNv6lp+ar8kxX7ypLB+Y=;
 b=cn4czjfodJTGokFl90WmwyQtgGI7Q9MA2gvfXG/XbYlXiva0131PU0rd5GzqMHZx2Oc4Ge
 qNt+bj7zPlUvnbDBDzLCw9j2HpMhqZn66KhYzTOrICCoTN8wOAMQ5bvkzWhwEUy7FF+eIR
 burC4wef2npXRkXqlssnzIr4qu/1tDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724173677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z862uK9sj7173dIjv/buZa3UNv6lp+ar8kxX7ypLB+Y=;
 b=GqfBUMTcTTa+giTF7xYfDxjo6Ce+NPIGOeh8qYFotvFmTP8E6REZ1KrXt2uyRJm+JCSfsz
 6FsowirmTS+NvhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 370EE13770;
 Tue, 20 Aug 2024 17:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9KVuO2vNxGZfUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Aug 2024 17:07:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/1] Migration patches for 2024-08-20
Date: Tue, 20 Aug 2024 14:07:40 -0300
Message-Id: <20240820170741.27055-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.57 / 50.00]; BAYES_HAM(-2.78)[99.04%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.985];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 075fd020afe3150a0e6c4b049705b358b597b65a:

  Merge tag 'nvme-next-pull-request' of https://gitlab.com/birkelund/qemu into staging (2024-08-20 16:51:15 +1000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240820-pull-request

for you to fetch changes up to 4c107870e8b2ba3951ee0c46123f1c3b5d3a19d3:

  migration/multifd: Free MultiFDRecvParams::data (2024-08-20 12:44:13 -0300)

----------------------------------------------------------------
Migration pull request

- Peter's fix for a leak in multifd recv side

----------------------------------------------------------------

Peter Maydell (1):
  migration/multifd: Free MultiFDRecvParams::data

 migration/multifd.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.35.3



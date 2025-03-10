Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CA9C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 22:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trlhx-0003rO-Np; Mon, 10 Mar 2025 18:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trlhv-0003qv-Pu
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:34:47 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trlhu-0001hX-5A
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:34:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4131A1F387;
 Mon, 10 Mar 2025 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741646084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGy2TsyA3o/HdQ72pklf2EWmARvcUSSRi580sggsnCY=;
 b=HjQQOOa4wTKmavmmmmOCv8WACWxGmKukosH+tlHC06njYJ3KZF64S0RZzsKZIRkWk1Vi+m
 4cf2bBXx/meF9CQ3ZaPNM22gJSm6gJJdEUhXQYTHArIUA+mnGfurxOIngT+diDB3Q/PmR3
 FloNaKue4U8FzVkR7aXcNe9u4fmBDd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741646084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGy2TsyA3o/HdQ72pklf2EWmARvcUSSRi580sggsnCY=;
 b=aDmK1pyyzrvEbESgKvXYdSMuK0KaMst8e2GHEuVPJ7MMtXciWq88714FdF4BSNDDbzTLm8
 j1bHzn0v4/UxMaDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741646084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGy2TsyA3o/HdQ72pklf2EWmARvcUSSRi580sggsnCY=;
 b=HjQQOOa4wTKmavmmmmOCv8WACWxGmKukosH+tlHC06njYJ3KZF64S0RZzsKZIRkWk1Vi+m
 4cf2bBXx/meF9CQ3ZaPNM22gJSm6gJJdEUhXQYTHArIUA+mnGfurxOIngT+diDB3Q/PmR3
 FloNaKue4U8FzVkR7aXcNe9u4fmBDd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741646084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGy2TsyA3o/HdQ72pklf2EWmARvcUSSRi580sggsnCY=;
 b=aDmK1pyyzrvEbESgKvXYdSMuK0KaMst8e2GHEuVPJ7MMtXciWq88714FdF4BSNDDbzTLm8
 j1bHzn0v4/UxMaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D25B1399F;
 Mon, 10 Mar 2025 22:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zOjmNgJpz2dzRAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Mar 2025 22:34:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL v2 0/3] Migration patches for 2025-03-10
Date: Mon, 10 Mar 2025 19:34:37 -0300
Message-Id: <20250310223440.31328-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit 5136598e2667f35ef3dc1d757616a266bd5eb3a2:

  Merge tag 'accel-cpus-20250309' of https://github.com/philmd/qemu into staging (2025-03-10 13:40:48 +0800)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250310-pull-request

for you to fetch changes up to baa41af1c083446971feac39b0da845e547ca068:

  migration: Prioritize RDMA in ram_save_target_page() (2025-03-10 12:09:24 -0300)

----------------------------------------------------------------
Migration pull request

- Fix use-after-free in incoming migration
- Improve cpr migration blocker for volatile ram
- Fix RDMA migration

----------------------------------------------------------------

Li Zhijian (1):
  migration: Prioritize RDMA in ram_save_target_page()

Peter Xu (1):
  migration: Fix UAF for incoming migration on MigrationState

Steve Sistare (1):
  migration: ram block cpr blockers

 include/exec/memory.h   |  3 ++
 include/exec/ramblock.h |  1 +
 migration/migration.c   | 40 +++++++++++++++++++++++--
 migration/ram.c         |  9 +++---
 migration/savevm.c      |  2 ++
 system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 6 deletions(-)

-- 
2.35.3



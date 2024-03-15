Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243F2C54E6A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rky7t-0003y1-GE; Thu, 14 Mar 2024 23:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7r-0003xn-D7
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:20:55 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7m-0004I7-2s
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:20:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EE7721D92;
 Fri, 15 Mar 2024 03:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F8qrIv7mQhacO3t8RnUsPVa35XmVTI24qqzcArXw4fo=;
 b=paKuRdAX0KOk8yW0LDxjkb/tH0ncZT77tWOiJ1Jh4PKP1aLUykSiRX1/oLybUVccjM1lRA
 wb4aQVgbfyhMGb7yHClnYb9PtXe40tL7tFovaSDGM0V19TLMDcUjNpL+AuU5a2fM91LUEg
 S57pAgKFvNUroy1ACYDzIwLrwYXtO9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F8qrIv7mQhacO3t8RnUsPVa35XmVTI24qqzcArXw4fo=;
 b=zcaRTAy17fZFELnZ4c3TqOLzAmlibpDQzWbr8dOvmgnePBDYeBc8AZTXVeTU2LmD3oIPZN
 EHKb3H1n5n9uMNBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F8qrIv7mQhacO3t8RnUsPVa35XmVTI24qqzcArXw4fo=;
 b=paKuRdAX0KOk8yW0LDxjkb/tH0ncZT77tWOiJ1Jh4PKP1aLUykSiRX1/oLybUVccjM1lRA
 wb4aQVgbfyhMGb7yHClnYb9PtXe40tL7tFovaSDGM0V19TLMDcUjNpL+AuU5a2fM91LUEg
 S57pAgKFvNUroy1ACYDzIwLrwYXtO9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F8qrIv7mQhacO3t8RnUsPVa35XmVTI24qqzcArXw4fo=;
 b=zcaRTAy17fZFELnZ4c3TqOLzAmlibpDQzWbr8dOvmgnePBDYeBc8AZTXVeTU2LmD3oIPZN
 EHKb3H1n5n9uMNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56F801368C;
 Fri, 15 Mar 2024 03:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S+cLB4u+82XZcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Mar 2024 03:20:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 0/3] migration mapped-ram fixes
Date: Fri, 15 Mar 2024 00:20:37 -0300
Message-Id: <20240315032040.7974-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.87 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.83)[93.99%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In this v3:

patch 1 - The fd_is_socket() verification and an update to the comment
          in the code;

patch 2 - The fix for the fd-reuse bug in outgoing_args;

patch 3 - A proposal on how to fix the fd-socket vs. fd-file
          issue. I'm basically moving the fd_is_socket() call earlier
          to be able to do the checks properly.

based-on: https://gitlab.com/peterx/qemu/-/commits/migration-stable

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1214405210

Fabiano Rosas (3):
  migration/multifd: Ensure we're not given a socket for file migration
  migration/multifd: Duplicate the fd for the outgoing_args
  migration: Add fd to FileMigrationArgs

 migration/fd.c        |  20 ++++++---
 migration/file.c      |   9 ++++
 migration/migration.c | 100 ++++++++++++++++++++++++++++++++++++------
 migration/migration.h |   1 +
 qapi/migration.json   |  11 ++++-
 5 files changed, 119 insertions(+), 22 deletions(-)

-- 
2.35.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF42CAC596
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqdP1-0000se-4U; Tue, 17 Sep 2024 14:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqdOu-0000TI-1G
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 14:58:12 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sqdOs-0007sv-Cb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 14:58:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F17B20175;
 Tue, 17 Sep 2024 18:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726599487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pDOutgHgC+7cxFV9D4fDdbCwOnf71UDR4fsrnyECtk0=;
 b=Ls9anWnDaQV2td7zUkv4D9FeZcx7Ncz0OLMoKuKbVKrlg5ojrHBfic+zHQcGP8+7qSFtqa
 PPPfJ3I+F1OyOs5PIZ43Vb2w2+w0BeizZlzUHA7IeoAl9y2EfetzXhXvtxaAxnn+ZrnBMY
 YdSn/elqwXPQn0a7np0i7n3/GuePKUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726599487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pDOutgHgC+7cxFV9D4fDdbCwOnf71UDR4fsrnyECtk0=;
 b=Q6OU7PEuRpU44mSiEb/M9JJf+Gx6W4C/57umI17dg6/Ex5WfAUIoQiUbrTC+po9qk/KrQ6
 mtcoKrSjkl42G5Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tvyQY9Vj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0jIDp2eb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726599486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pDOutgHgC+7cxFV9D4fDdbCwOnf71UDR4fsrnyECtk0=;
 b=tvyQY9Vj0Rnn4CTwg5UUhLUuZV+S9d9PfZw1kp4PPpxcVLjiPbE28wgGr/AC+6kUM4IziI
 2SI57CRLvhsI1ZmUUbm1xBStQrGlT14lGaopYpeEVclQAc2p3uXDvAVln2Xbrz0iwDIODz
 +u9ZmnAIJjdntzCbiw6pRmnu16/GdEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726599486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pDOutgHgC+7cxFV9D4fDdbCwOnf71UDR4fsrnyECtk0=;
 b=0jIDp2ebPQ4g71BseOMGbUoz3m+TOfYeKeIRQ0t4Ui7XkcXpkS4RaN3NXaTVIXSJy8zEAd
 DoCNyg3wDOT3EQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C7A5139CE;
 Tue, 17 Sep 2024 18:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OJwyAT3R6WYiDgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Sep 2024 18:58:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] migration/multifd: Fix rb->receivedmap cleanup race
Date: Tue, 17 Sep 2024 15:58:00 -0300
Message-Id: <20240917185802.15619-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F17B20175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_THREE(0.00)[3]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

v2: Keep skipping the cpu_synchronize_all_post_init() call if the
postcopy listen thread is live. Don't copy stable on the first patch.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1457418838
====
v1:
https://lore.kernel.org/r/20240913220542.18305-1-farosas@suse.de

This fixes the crash we've been seing recently in migration-test. The
first patch is a cleanup to have only one place calling
qemu_loadvm_state_cleanup() and the second patch reorders the cleanup
calls to make multifd_recv_cleanup() run first and stop the recv
threads.

Fabiano Rosas (2):
  migration/savevm: Remove extra load cleanup calls
  migration/multifd: Fix rb->receivedmap cleanup race

 migration/migration.c | 1 +
 migration/savevm.c    | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.35.3



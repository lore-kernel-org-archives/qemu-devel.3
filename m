Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CFFCD8C81
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVUYZ-000789-Nu; Fri, 05 Jun 2026 09:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVUYX-00076y-G6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 09:25:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVUYV-0000we-O2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 09:25:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2842F758E3;
 Fri,  5 Jun 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780665943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gQsjTIKMwKoY+vb82+uO28bh6P+YLORkXkXsEgMvKvg=;
 b=nqH9QGa1lsePLb/QzSGnzCKq7b1pWLmHZL6Qkbv6UKOG1WRurucppzNHTRtNtiVHK2KmEN
 LpDX3M7ykowazQWVf4mSnHs7+8CGqqn/9g2zsBe6HfHZizIgrpU217z9di2bktqU+OWEL8
 QqIIwV7tMIXYvsoRPQWyZthbCqNs4SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780665943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gQsjTIKMwKoY+vb82+uO28bh6P+YLORkXkXsEgMvKvg=;
 b=BtZ/XabrR2vf049GHa0Uor5xeh0zcH7VEvOVvNHn51jgYDLXuw+yDutSQayedw6ZPV5MeU
 kUR8mYk0ZANlTGCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nqH9QGa1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="BtZ/Xabr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780665943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gQsjTIKMwKoY+vb82+uO28bh6P+YLORkXkXsEgMvKvg=;
 b=nqH9QGa1lsePLb/QzSGnzCKq7b1pWLmHZL6Qkbv6UKOG1WRurucppzNHTRtNtiVHK2KmEN
 LpDX3M7ykowazQWVf4mSnHs7+8CGqqn/9g2zsBe6HfHZizIgrpU217z9di2bktqU+OWEL8
 QqIIwV7tMIXYvsoRPQWyZthbCqNs4SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780665943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gQsjTIKMwKoY+vb82+uO28bh6P+YLORkXkXsEgMvKvg=;
 b=BtZ/XabrR2vf049GHa0Uor5xeh0zcH7VEvOVvNHn51jgYDLXuw+yDutSQayedw6ZPV5MeU
 kUR8mYk0ZANlTGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39170779A8;
 Fri,  5 Jun 2026 13:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i60HA1bOImpGEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 05 Jun 2026 13:25:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] tcg: Silence ubsan error on tcg_splitwx_diff causing
 overflow
Date: Fri,  5 Jun 2026 10:25:39 -0300
Message-ID: <20260605132539.2775364-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2842F758E3
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

UBSAN complains:
runtime error: addition of unsigned offset to 0x7bc06e1f5000
overflowed to 0x7bc02e1f5000

Change tcg_splitwx_diff to ptrdiff_t and silence the error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/tcg/tcg.h | 2 +-
 tcg/tcg.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 45c7e118c3..7669dc1c2d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -447,7 +447,7 @@ static inline bool temp_readonly(TCGTemp *ts)
 
 extern __thread TCGContext *tcg_ctx;
 extern const void *tcg_code_gen_epilogue;
-extern uintptr_t tcg_splitwx_diff;
+extern ptrdiff_t tcg_splitwx_diff;
 extern TCGv_env tcg_env;
 
 bool in_code_gen_buffer(const void *p);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2ca44766f6..1e77f2365a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -244,7 +244,7 @@ unsigned int tcg_cur_ctxs;
 unsigned int tcg_max_ctxs;
 TCGv_env tcg_env;
 const void *tcg_code_gen_epilogue;
-uintptr_t tcg_splitwx_diff;
+ptrdiff_t tcg_splitwx_diff;
 
 #ifndef CONFIG_TCG_INTERPRETER
 tcg_prologue_fn *tcg_qemu_tb_exec;
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8923C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNdH-0001Ro-A8; Tue, 20 May 2025 10:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1uHNdB-0001P8-4A
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:07:45 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1uHNd9-0007oj-E7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:07:44 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8DCC220730;
 Tue, 20 May 2025 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747750057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qDUedziC/mCqsLlLqtHrAKTTMLoPqhXwP7rGHeZL2os=;
 b=wIuhMEgXfBJo1zJQhViBzgFaGH/tMKbJ84aD+TkwFF6fTfwgmUp1MVyrRjzP7GfXAYNTTg
 DTY5YKHTn9fviouz4t1OJGaPFfnPTSUAd6vYmkGfeIKgrjZvJCCqe5xVnK3ujU4BC+3/qY
 BKcK7xozhTe0psg+MYuWplE8zasm39Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747750057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qDUedziC/mCqsLlLqtHrAKTTMLoPqhXwP7rGHeZL2os=;
 b=WsuCr3yY1tJw9EJPnaP7C2xJrOy3ThoqF9fcdrjt2g1qQ1uPg667aAL/PcYT37Eo9Plprk
 JzBdIIkwpT33x9Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wIuhMEgX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WsuCr3yY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747750057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qDUedziC/mCqsLlLqtHrAKTTMLoPqhXwP7rGHeZL2os=;
 b=wIuhMEgXfBJo1zJQhViBzgFaGH/tMKbJ84aD+TkwFF6fTfwgmUp1MVyrRjzP7GfXAYNTTg
 DTY5YKHTn9fviouz4t1OJGaPFfnPTSUAd6vYmkGfeIKgrjZvJCCqe5xVnK3ujU4BC+3/qY
 BKcK7xozhTe0psg+MYuWplE8zasm39Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747750057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qDUedziC/mCqsLlLqtHrAKTTMLoPqhXwP7rGHeZL2os=;
 b=WsuCr3yY1tJw9EJPnaP7C2xJrOy3ThoqF9fcdrjt2g1qQ1uPg667aAL/PcYT37Eo9Plprk
 JzBdIIkwpT33x9Dg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 7BFD54AADEC; Tue, 20 May 2025 16:07:37 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: implement pgid field of /proc/self/stat
CC: qemu-devel@nongnu.org
Date: Tue, 20 May 2025 16:07:37 +0200
Message-ID: <mvmfrgzcr4m.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.73 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-0.97)[-0.966];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.09)[-0.475]; MX_GOOD(-0.01)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:92b1:1cff:fe69:ddc:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_ONE(0.00)[1];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim]
X-Rspamd-Queue-Id: 8DCC220730
X-Spamd-Bar: ++
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=schwab@suse.de; helo=smtp-out2.suse.de
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

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8820ca4dfd..5536e364dc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8235,6 +8235,9 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
         } else if (i == 3) {
             /* ppid */
             g_string_printf(buf, FMT_pid " ", getppid());
+        } else if (i == 4) {
+            /* pgid */
+            g_string_printf(buf, FMT_pid " ", getpgrp());
         } else if (i == 19) {
             /* num_threads */
             int cpus = 0;
-- 
2.49.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


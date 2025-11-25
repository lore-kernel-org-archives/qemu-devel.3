Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EEBD0EE0D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNx3J-0003zG-KA; Tue, 25 Nov 2025 12:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vNx3G-0003vG-2N
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:42:06 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vNx3E-0002en-Ga
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:42:05 -0500
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3E9E75BD12;
 Tue, 25 Nov 2025 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764092521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=hu1BUFyuC16J9n18VyCz3JY1QmqEUV1QBw1wENIm5V8=;
 b=wt0VywSGYhKl9+1R7vw4zHn4S9G5u4QeftPfX+4+D6Fw2MfRggIAGawL68wqxymJLyTubO
 UOPcTpx9JrJfF3WYJcVD7iTaSfknfDmEfdh5oWbcNdS95bBII6X2qRt4nRbVtCW0vUV5Gw
 z9cfe30yzcjXpcCyZYlCKXtCBugmmjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764092521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=hu1BUFyuC16J9n18VyCz3JY1QmqEUV1QBw1wENIm5V8=;
 b=0LL7X5O6ICHYl+0lEjI7DK7jMjOw2m/qG3+wgNtX9eNN2Ga5a4CUPIh8GPfWtPQbGbiUNX
 Q+szYvQs8uaq+XAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wt0VywSG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0LL7X5O6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764092521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=hu1BUFyuC16J9n18VyCz3JY1QmqEUV1QBw1wENIm5V8=;
 b=wt0VywSGYhKl9+1R7vw4zHn4S9G5u4QeftPfX+4+D6Fw2MfRggIAGawL68wqxymJLyTubO
 UOPcTpx9JrJfF3WYJcVD7iTaSfknfDmEfdh5oWbcNdS95bBII6X2qRt4nRbVtCW0vUV5Gw
 z9cfe30yzcjXpcCyZYlCKXtCBugmmjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764092521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=hu1BUFyuC16J9n18VyCz3JY1QmqEUV1QBw1wENIm5V8=;
 b=0LL7X5O6ICHYl+0lEjI7DK7jMjOw2m/qG3+wgNtX9eNN2Ga5a4CUPIh8GPfWtPQbGbiUNX
 Q+szYvQs8uaq+XAA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 25A1A4A056A; Tue, 25 Nov 2025 18:42:01 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH] linux-user: look up executable in emulation dir for execve
 syscall
Date: Tue, 25 Nov 2025 18:42:01 +0100
Message-ID: <mvmtsyixb4m.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.27 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_SPAM_SHORT(2.98)[0.992];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_NONE(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 hawking.nue2.suse.org:helo]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 3E9E75BD12
X-Rspamd-Action: add header
X-Spam: Yes
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
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

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f7ca155679..e379ddb1b7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8972,6 +8972,7 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
     if (is_proc_myself(p, "exe")) {
         exe = exec_path;
     }
+    exe = path(exe);
     ret = is_execveat
         ? safe_execveat(dirfd, exe, argp, envp, flags)
         : safe_execve(exe, argp, envp);
-- 
2.52.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93972CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDg6c-0002qx-2k; Mon, 05 Oct 2026 06:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1xDg6U-0002qK-U6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:39:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1xDg6T-00039R-8a
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:39:30 -0400
Received: from hawking.suse.de (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out1.suse.de (Postfix) with ESMTP id D855521BF8;
 Mon,  5 Oct 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791196762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iQGC9LDZjjog8dmS0QYk+0SInCQGVgps86NPyJ2ICtg=;
 b=fHOqO70TWmfUmAr2JOtjOIDFSHmhjTmmsVipY7EF72/ClA7/PYOVOtzfTOJal2eyM1hRw3
 6UHjTRhtFFOIluTsKsU3UPhfhHqLNcB3a6l5crJAi7JkzQRLAzSQyDUKBGwNRYfVhae9bH
 3neLlxeYVkuO9OVvwCAVLEqTrZOB8Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791196762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iQGC9LDZjjog8dmS0QYk+0SInCQGVgps86NPyJ2ICtg=;
 b=kv8nu1YSFchxArWQoBRSQGSrEMcl/dDqG2wnq0ARsH+t6Gr9d/i1h/IXwgU8CoPWmmw8/F
 r6/fyHbt3Gc8LCCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y62x07mM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tfkNXe84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791196757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iQGC9LDZjjog8dmS0QYk+0SInCQGVgps86NPyJ2ICtg=;
 b=y62x07mMQvneW5CuG35Cu5cohgt3FkfoE7UWhwiqH60cpRabkw9KTAByB1lTaAp7pGDQgM
 4A5pFXZn0Nsl7F2gpJ3kF9/B7mOsUBWYrN2FRUQfETWNy/8gUDCWbAgbeY64kNI3MSIpQt
 ye2RqB5Dop+HrM5xSGkNK9zrE+DLQPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791196757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iQGC9LDZjjog8dmS0QYk+0SInCQGVgps86NPyJ2ICtg=;
 b=tfkNXe84yw4lwFjGhu4drPU6lK/L0AbBAV9RJrTENj9taMntWoV6Cf3NkW4qg/Vzvv4NG/
 2zDFSqPbhe743EAA==
Received: by hawking.suse.de (Postfix, from userid 17005)
 id BC9F14AAD7A; Mon,  5 Oct 2026 12:39:17 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
Subject: [PATCH] linux-user: don't print core dump message by default
Date: Mon, 05 Oct 2026 12:39:17 +0200
Message-ID: <mvmzews2zze.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.23 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_SPAM_SHORT(2.94)[0.980];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.suse.de];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.suse.de];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmx.de];
 FREEMAIL_CC(0.00)[vivier.eu,gmx.de,oss.qualcomm.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:92b1:1cff:fe69:ddc:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_ONE(0.00)[1];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: D855521BF8
X-Rspamd-Action: add header
X-Spam: Yes
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=schwab@suse.de; helo=smtp-out1.suse.de
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

When the target binary is killed by a signal with core dump print a
message to the guest_errors log instead of stderr.  This avoids breaking
various testsuites due to the extra output produced by the emulation.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index f0a22577e5..cabcc2bb28 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -839,8 +839,8 @@ void dump_core_and_abort(CPUArchState *env, int target_sig)
         getrlimit(RLIMIT_CORE, &nodump);
         nodump.rlim_cur=0;
         setrlimit(RLIMIT_CORE, &nodump);
-        (void) fprintf(stderr, "qemu: uncaught target signal %d (%s) - %s\n",
-            target_sig, strsignal(host_sig), "core dumped" );
+        qemu_log_mask(LOG_GUEST_ERROR, "qemu: uncaught target signal %d (%s) - %s\n",
+                      target_sig, strsignal(host_sig), "core dumped" );
     }
 
     preexit_cleanup(env, 128 + target_sig);
-- 
2.56.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


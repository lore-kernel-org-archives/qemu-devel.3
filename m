Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B336EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpk0m-0000vB-18; Tue, 10 Feb 2026 04:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vpk0a-0000cK-BN
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:26:12 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vpk0R-0001Dt-QE
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:26:11 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 31C135BCD3;
 Tue, 10 Feb 2026 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770715562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=PHWDImYY74MKpc3uiLbl38IhGD6EmOsNvNmAikAZizc=;
 b=gBrjMKoEmm2LI/EiopOqdNKslbz1yKGU8GV+S5IpyquO+dSJTv/viCsYbyK3zP3SqIt1sq
 5Vr9PHkQMT15ZlojOB8qHY9+0ViIbiVagwmxmNh75Cm+xvxer+/7doYwNLYOd7c2J2qSXx
 MxzWVR8rTj/nn6Wuqd5eGTCO+KDLs8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770715562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=PHWDImYY74MKpc3uiLbl38IhGD6EmOsNvNmAikAZizc=;
 b=U0Jthf00lKX203CrJUf2+BPm9aJ0RtdZgOercnYYWQm2APdqnCt+yhwU+8C8sLyBejKHYY
 CNPOR9EJXWi6frCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770715562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=PHWDImYY74MKpc3uiLbl38IhGD6EmOsNvNmAikAZizc=;
 b=gBrjMKoEmm2LI/EiopOqdNKslbz1yKGU8GV+S5IpyquO+dSJTv/viCsYbyK3zP3SqIt1sq
 5Vr9PHkQMT15ZlojOB8qHY9+0ViIbiVagwmxmNh75Cm+xvxer+/7doYwNLYOd7c2J2qSXx
 MxzWVR8rTj/nn6Wuqd5eGTCO+KDLs8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770715562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=PHWDImYY74MKpc3uiLbl38IhGD6EmOsNvNmAikAZizc=;
 b=U0Jthf00lKX203CrJUf2+BPm9aJ0RtdZgOercnYYWQm2APdqnCt+yhwU+8C8sLyBejKHYY
 CNPOR9EJXWi6frCg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 231A04A0A2A; Tue, 10 Feb 2026 10:26:02 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu> (odd fixer:Linux user)
Subject: [PATCH] linux-user: properly check flags in openat2
CC: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Date: Tue, 10 Feb 2026 10:26:02 +0100
Message-ID: <mvmpl6d9cgl.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.19 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.975]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=schwab@suse.de; helo=smtp-out2.suse.de
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

target_to_host_bitmask truncates the bitmask to int.  Check that the upper
half of the flags do not have any bits set.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8469b81878..667aea6a03 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8822,6 +8822,10 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
         }
         return ret;
     }
+    if (tswap64(how.flags) >> 32) {
+        return -TARGET_EINVAL;
+    }
+
     pathname = lock_user_string(guest_pathname);
     if (!pathname) {
         return -TARGET_EFAULT;
-- 
2.53.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


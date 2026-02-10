Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0A1EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkK5-0002qk-8P; Tue, 10 Feb 2026 04:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vpkJt-0002iZ-EO
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:46:11 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vpkJp-0006KJ-C2
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:46:07 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 132905BCD3;
 Tue, 10 Feb 2026 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770716763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=fZSqrlvkWiCmxgzf/P0uEo5wzC8ItzFC/hD3xRCaDSQ=;
 b=KmO39hqSfX+tTr1dh/cglacBIIzN7bPuB2iyOSrSmARTpXdRpf05uZZeiSKnUCMOghAE11
 rzVLs4HK8sYGleaYUuzDSRLujtt3Vsi4Tx8g0X/ljgFfYxSaGTPxigOGVXSl5QZFri2qNl
 NTkH6yc/QqAhIkOn7UgxL0bZEaNr07M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770716763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=fZSqrlvkWiCmxgzf/P0uEo5wzC8ItzFC/hD3xRCaDSQ=;
 b=905G1jtyjnq6Huqdlrcym+VOfYya/K7FMttBS1F0nO9Hfhd/zvzj//sjjHraelfBGlwdA3
 it6eDh3BAYcdXmBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770716762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=fZSqrlvkWiCmxgzf/P0uEo5wzC8ItzFC/hD3xRCaDSQ=;
 b=iYHm19SmOwQy1cdOhbE48z+o8IfGA3oEZFXe2sAuqUcLeP1dGWys6cmlVUg1XdVXx7IcnZ
 eiJllbiggHKtJmb+XV3ignj0Cjuebfp9wpRw4ZqT2zVY/8YBHiZ9RGAXgM+6kTyMgK+O8T
 gIiB2mFoxeHOz+qT57Nobb85/nbAAwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770716762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=fZSqrlvkWiCmxgzf/P0uEo5wzC8ItzFC/hD3xRCaDSQ=;
 b=9VRzTLzoWZG5wZfePAMlbSsl5siqir1AG36DlCo7qIsqCThQttxYLIxidCqPlxHBTspW6x
 TPx7mdtBEdVEoPBQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 04C764A0A2A; Tue, 10 Feb 2026 10:46:02 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: fix matching ioctl numbers in print_ioctl
CC: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Date: Tue, 10 Feb 2026 10:46:01 +0100
Message-ID: <mvmldh19bja.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.990]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[hawking.nue2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
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

target_cmd in struct IOCTLEntry is a signed int.  Make sure the ioctl cmd
argument in the syscall is converted to int when matching, so that it
works correctly with an ioctl cmd that has bit 31 set.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/strace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index ca67cfd09d..8e026e5d8e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1017,12 +1017,12 @@ print_syscall_ret_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
         int target_size;
 
         for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
-            if (ie->target_cmd == arg1) {
+            if (ie->target_cmd == (int)arg1) {
                 break;
             }
         }
 
-        if (ie->target_cmd == arg1 &&
+        if (ie->target_cmd == (int)arg1 &&
            (ie->access == IOC_R || ie->access == IOC_RW)) {
             arg_type = ie->arg_type;
             qemu_log(" (");
@@ -4338,7 +4338,7 @@ print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
     int target_size;
 
     for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
-        if (ie->target_cmd == arg1) {
+        if (ie->target_cmd == (int)arg1) {
             break;
         }
     }
-- 
2.53.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


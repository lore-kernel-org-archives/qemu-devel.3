Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C719CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 12:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qCK-0005E0-5h; Thu, 09 Oct 2025 08:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1v6qCH-0005Dr-Ov
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:56:41 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1v6qC2-0006CT-4e
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:56:40 -0400
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id C8CAF1F78B;
 Thu,  9 Oct 2025 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760014577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qYkInKhhPBx5SouEm5tn+SG3ejCC9ViTxz2g3amQtFk=;
 b=GzHR4ODlwRIRbXioHfjChKpYm9CDd+/h/2HWM8RgnhQLHFeVowV106sFL1r6usD8iUM48z
 r8I51o+8a54tE5quzPB7RdIPT2Co++kd12LyPKy6cdghvSNTp3zLLDcPUCIo/z08W9jUDG
 vTc6ZEBnzhv/NJkb0k2u/u6P5nYLzfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760014577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qYkInKhhPBx5SouEm5tn+SG3ejCC9ViTxz2g3amQtFk=;
 b=lgwmATSE0bC7yd8YyCnWSPDMcdzeDUFR+NguTnSIXNrrcCTU3uX6rkgZWOXXsBmHfQXXth
 Br/ff7y+WzecXNDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760014577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qYkInKhhPBx5SouEm5tn+SG3ejCC9ViTxz2g3amQtFk=;
 b=GzHR4ODlwRIRbXioHfjChKpYm9CDd+/h/2HWM8RgnhQLHFeVowV106sFL1r6usD8iUM48z
 r8I51o+8a54tE5quzPB7RdIPT2Co++kd12LyPKy6cdghvSNTp3zLLDcPUCIo/z08W9jUDG
 vTc6ZEBnzhv/NJkb0k2u/u6P5nYLzfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760014577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qYkInKhhPBx5SouEm5tn+SG3ejCC9ViTxz2g3amQtFk=;
 b=lgwmATSE0bC7yd8YyCnWSPDMcdzeDUFR+NguTnSIXNrrcCTU3uX6rkgZWOXXsBmHfQXXth
 Br/ff7y+WzecXNDw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 64E8D4A0784; Thu,  9 Oct 2025 14:56:17 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: fix layout of struct target_msq_id_ds
CC: qemu-devel@nongnu.org
Date: Thu, 09 Oct 2025 14:56:17 +0200
Message-ID: <mvma520fd3i.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.983]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

The msg_lspid and msg_lrpid members are of type pid_t, which is a 32-bit
integer.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0956a7b310..3dcdb3ef42 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4185,8 +4185,8 @@ struct target_msqid_ds
     abi_ulong __msg_cbytes;
     abi_ulong msg_qnum;
     abi_ulong msg_qbytes;
-    abi_ulong msg_lspid;
-    abi_ulong msg_lrpid;
+    unsigned int msg_lspid;
+    unsigned int msg_lrpid;
     abi_ulong __unused4;
     abi_ulong __unused5;
 };
@@ -4206,8 +4206,8 @@ static inline abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
     host_md->__msg_cbytes = tswapal(target_md->__msg_cbytes);
     host_md->msg_qnum = tswapal(target_md->msg_qnum);
     host_md->msg_qbytes = tswapal(target_md->msg_qbytes);
-    host_md->msg_lspid = tswapal(target_md->msg_lspid);
-    host_md->msg_lrpid = tswapal(target_md->msg_lrpid);
+    host_md->msg_lspid = tswap32(target_md->msg_lspid);
+    host_md->msg_lrpid = tswap32(target_md->msg_lrpid);
     unlock_user_struct(target_md, target_addr, 0);
     return 0;
 }
@@ -4227,8 +4227,8 @@ static inline abi_long host_to_target_msqid_ds(abi_ulong target_addr,
     target_md->__msg_cbytes = tswapal(host_md->__msg_cbytes);
     target_md->msg_qnum = tswapal(host_md->msg_qnum);
     target_md->msg_qbytes = tswapal(host_md->msg_qbytes);
-    target_md->msg_lspid = tswapal(host_md->msg_lspid);
-    target_md->msg_lrpid = tswapal(host_md->msg_lrpid);
+    target_md->msg_lspid = tswap32(host_md->msg_lspid);
+    target_md->msg_lrpid = tswap32(host_md->msg_lrpid);
     unlock_user_struct(target_md, target_addr, 1);
     return 0;
 }
-- 
2.51.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


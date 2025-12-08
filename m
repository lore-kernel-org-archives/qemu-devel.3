Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41871D3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 13:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSbTG-0001Vn-3h; Mon, 08 Dec 2025 08:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vSbTD-0001VX-Ct
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 08:40:07 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vSbTA-0005VI-Lt
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 08:40:07 -0500
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id 231DD5BF32;
 Mon,  8 Dec 2025 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765201200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iyOKmRDwi3q/5TiVoHTxTdgNt2oeoLAuQ6m5bu+mQLc=;
 b=nwmyJII2XjVDH4vUrj+hkhwTS/aZY4rJwp67wmdQ0JCC/BLj/BYpoI3OkrYEd8jb19NBXc
 auHxdByG6KhFJAIBiE4c2C/+rAifO/47d+OGZ5ot8JgowB5EoqRZ8oHDIfNwGI4xdGfoVy
 yW4odkq0eZMDQmqSEAfDkDla8fNDe4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765201200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iyOKmRDwi3q/5TiVoHTxTdgNt2oeoLAuQ6m5bu+mQLc=;
 b=Pbflqql7b5CKJSBHNba7/egbezzTbF6PzmSVk/VzRS2Tkr7J88L0F+DwviKCI0pXniPOxX
 rVQnid44oKLVneCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nwmyJII2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pbflqql7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765201200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iyOKmRDwi3q/5TiVoHTxTdgNt2oeoLAuQ6m5bu+mQLc=;
 b=nwmyJII2XjVDH4vUrj+hkhwTS/aZY4rJwp67wmdQ0JCC/BLj/BYpoI3OkrYEd8jb19NBXc
 auHxdByG6KhFJAIBiE4c2C/+rAifO/47d+OGZ5ot8JgowB5EoqRZ8oHDIfNwGI4xdGfoVy
 yW4odkq0eZMDQmqSEAfDkDla8fNDe4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765201200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=iyOKmRDwi3q/5TiVoHTxTdgNt2oeoLAuQ6m5bu+mQLc=;
 b=Pbflqql7b5CKJSBHNba7/egbezzTbF6PzmSVk/VzRS2Tkr7J88L0F+DwviKCI0pXniPOxX
 rVQnid44oKLVneCA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 0A3FD4A055A; Mon,  8 Dec 2025 14:40:00 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: update statx emulation
CC: qemu-devel@nongnu.org
Date: Mon, 08 Dec 2025 14:40:00 +0100
Message-ID: <mvmwm2xum6n.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [15.29 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_SPAM_SHORT(3.00)[1.000];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_ONE(0.00)[1];
 SPAMHAUS_XBL(0.00)[2a07:de40:a101:3:92b1:1cff:fe69:ddc:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 231DD5BF32
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes
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

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c      | 3 +++
 linux-user/syscall_defs.h | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e379ddb1b7..248c5b5f7c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8049,6 +8049,9 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
     __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
     __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
     __put_user(host_stx->stx_dev_minor, &target_stx->stx_dev_minor);
+    __put_user(host_stx->stx_mnt_id, &target_stx->stx_mnt_id);
+    __put_user(host_stx->stx_dio_mem_align, &target_stx->stx_dio_mem_align);
+    __put_user(host_stx->stx_dio_offset_align, &target_stx->stx_dio_offset_align);
 
     unlock_user_struct(target_stx, target_addr, 1);
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cd9ff709b8..6ae6e1fa13 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2734,7 +2734,11 @@ struct target_statx {
     abi_uint stx_dev_major; /* ID of device containing file [uncond] */
     abi_uint stx_dev_minor;
     /* 0x90 */
-    abi_ullong __spare2[14]; /* Spare space for future expansion */
+    abi_ullong stx_mnt_id;
+    abi_uint stx_dio_mem_align;
+    abi_uint stx_dio_offset_align;
+    /* 0xa0 */
+    abi_ullong __spare2[12]; /* Spare space for future expansion */
     /* 0x100 */
 };
 
-- 
2.52.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


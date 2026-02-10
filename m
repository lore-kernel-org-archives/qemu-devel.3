Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B4AEA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjvN-0005Yv-7d; Tue, 10 Feb 2026 04:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vpjvL-0005YV-Ae
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:20:47 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vpjvI-000690-Q5
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:20:46 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id B87035BCD3;
 Tue, 10 Feb 2026 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770715240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=ScxZPKxHohlrJ3ifN13B2McD7WhwZ2f8L32i9/63m1A=;
 b=KXxLeFWlPFe7Wze2beagsmiMzoumlGJ5iwsuVCJe24L7k0B60T9A8hkT1gJTaUUavaX0AE
 NFco0v7uoyXjHNnva35tSOCQq6rvln1NoZr4OihNN4JfP9fOEFamMXUR/Dn1Ac9gL3N2xk
 dIivB+apZqtsWp2ik3QoyjH3kTb43HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770715240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=ScxZPKxHohlrJ3ifN13B2McD7WhwZ2f8L32i9/63m1A=;
 b=ilvbI6F1pS73aYaKtRMKWQlty+6a7kYid8UYb+wkmGQG7hfsmI8mfwNpVm1oFy4XV9jC6U
 7qej6rV8YehH6XBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770715239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=ScxZPKxHohlrJ3ifN13B2McD7WhwZ2f8L32i9/63m1A=;
 b=PfJZsdMdlxUJMExTTXrzPet8qD1gzRpUHAVWD1vF85ySSNbKrTtGOc7JOWkBAVEK3ytAvg
 PVyAmv3dMymbMT3fpNh3mGlsWsOTeQ+sIl7G4nn7VoLOWLg5jhOvifwZKvHohUUu0u6uJL
 nFKvDiw6v/zMKUIaWuezTiavYqCyDdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770715239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=ScxZPKxHohlrJ3ifN13B2McD7WhwZ2f8L32i9/63m1A=;
 b=5cNlp2yUlSnOZl209dlbXXWimhtQvF2qt+w+x4q9JwVf7dBiisY5T+Cq5akQSY7HnQwxb5
 K8YjdMtYASmL37AQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id A919D4A0A2A; Tue, 10 Feb 2026 10:20:39 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: fix TIOCGSID ioctl
CC: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Date: Tue, 10 Feb 2026 10:20:39 +0100
Message-ID: <mvmtsvp9cpk.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.979]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
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

TIOCGSID is IOC_R, not IOC_W.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/ioctls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 6ecfe6306e..5b7d00e92f 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -26,7 +26,7 @@
      IOCTL(TIOCSCTTY, 0, TYPE_INT)
      IOCTL(TIOCGPGRP, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(TIOCSPGRP, IOC_W, MK_PTR(TYPE_INT))
-     IOCTL(TIOCGSID, IOC_W, MK_PTR(TYPE_INT))
+     IOCTL(TIOCGSID, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(TIOCOUTQ, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(TIOCSTI, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(TIOCMGET, IOC_R, MK_PTR(TYPE_INT))
-- 
2.53.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


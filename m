Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B0BC282D6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 16:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpVVv-0005C1-8B; Tue, 04 Mar 2025 11:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tpVVs-0005Bl-SQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:53:00 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tpVVq-0004nW-OL
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:53:00 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 47EC81F441;
 Tue,  4 Mar 2025 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741107172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=n5mpIw+zydjJcUnLTOyBRRdB1kJAS2opwH3W7uf10gE=;
 b=Qu4JNA2Yv6GTk2tU8KB0Em3+j7okybmY2miTnnErujJ9hSfkoLUItseiM97LFyC/iItHf0
 M4Gv7j4H5Jg/+1L5qiwWan5bOp4kr21Dzh/M871XOLEPdoU73bW0IlpHq4aPNtkHh2XpLc
 dQGteJM5xPY5xJEbS6ivVXa025UtMIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741107172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=n5mpIw+zydjJcUnLTOyBRRdB1kJAS2opwH3W7uf10gE=;
 b=pXz+izjE0Gc2N4lMFdRgDzfw+f9byssmvPFjyMh7yg3kk5udNuO52TVwsTbmHrFmpnlri+
 X7yZZ9JbqDg5zkAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741107172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=n5mpIw+zydjJcUnLTOyBRRdB1kJAS2opwH3W7uf10gE=;
 b=Qu4JNA2Yv6GTk2tU8KB0Em3+j7okybmY2miTnnErujJ9hSfkoLUItseiM97LFyC/iItHf0
 M4Gv7j4H5Jg/+1L5qiwWan5bOp4kr21Dzh/M871XOLEPdoU73bW0IlpHq4aPNtkHh2XpLc
 dQGteJM5xPY5xJEbS6ivVXa025UtMIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741107172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=n5mpIw+zydjJcUnLTOyBRRdB1kJAS2opwH3W7uf10gE=;
 b=pXz+izjE0Gc2N4lMFdRgDzfw+f9byssmvPFjyMh7yg3kk5udNuO52TVwsTbmHrFmpnlri+
 X7yZZ9JbqDg5zkAA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 3694D4A056D; Tue,  4 Mar 2025 17:52:52 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: fix handling of cpu mask in riscv_hwprobe syscall
CC: Palmer Dabbelt <palmer@rivosinc.com>, Robbin Ehn <rehn@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Date: Tue, 04 Mar 2025 17:52:52 +0100
Message-ID: <mvmo6yglouz.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.19 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.973]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

The third argument of the riscv_hwprobe syscall contains the size of the
cpu mask in bytes, not bits.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a22a5df8cc..4cc1a31d0d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9120,16 +9120,16 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
 
 static int cpu_set_valid(abi_long arg3, abi_long arg4)
 {
-    int ret, i, tmp;
+    int ret, i;
     size_t host_mask_size, target_mask_size;
     unsigned long *host_mask;
 
     /*
      * cpu_set_t represent CPU masks as bit masks of type unsigned long *.
-     * arg3 contains the cpu count.
+     * arg3 contains the size of the cpu mask.
      */
-    tmp = (8 * sizeof(abi_ulong));
-    target_mask_size = ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
+    target_mask_size = (arg3 + (sizeof(abi_ulong) - 1)) &
+                       ~(sizeof(abi_ulong) - 1);
     host_mask_size = (target_mask_size + (sizeof(*host_mask) - 1)) &
                      ~(sizeof(*host_mask) - 1);
 
-- 
2.48.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


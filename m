Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AACC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE3P-00029V-8o; Wed, 30 Jul 2025 17:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhDnD-0004PZ-KW
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:52:55 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhDnB-0002Iw-L1
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:52:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1591F76C;
 Wed, 30 Jul 2025 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753908771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaZ+Yz+zcCEr2tVtA+J5m5quEPo6bIi7orrs7mVcXNo=;
 b=XPniET5MoLUt+5GlUWuJnU09nHdPIs+J8gMzVFMn1I8XiVoqh0P7ETn7AZ40xo5hN32NNj
 vLxhNVgA+v3H2pAYTG8fXWPcfPvFn/ourd6JZ2Gal4vl6lybRuyFtRESgIl+46rYdU+S2m
 pk01MjWUUMK2agXlQcUX+GCllrZ51k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753908771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaZ+Yz+zcCEr2tVtA+J5m5quEPo6bIi7orrs7mVcXNo=;
 b=3Nk1oLIRKcNGV/RNIranxFQxfnDIeomnKZGzhqQu1fCiWv90xFbSjW+EbKL15tGuT/34su
 GzFsogC9vodsQYDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753908771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaZ+Yz+zcCEr2tVtA+J5m5quEPo6bIi7orrs7mVcXNo=;
 b=XPniET5MoLUt+5GlUWuJnU09nHdPIs+J8gMzVFMn1I8XiVoqh0P7ETn7AZ40xo5hN32NNj
 vLxhNVgA+v3H2pAYTG8fXWPcfPvFn/ourd6JZ2Gal4vl6lybRuyFtRESgIl+46rYdU+S2m
 pk01MjWUUMK2agXlQcUX+GCllrZ51k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753908771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaZ+Yz+zcCEr2tVtA+J5m5quEPo6bIi7orrs7mVcXNo=;
 b=3Nk1oLIRKcNGV/RNIranxFQxfnDIeomnKZGzhqQu1fCiWv90xFbSjW+EbKL15tGuT/34su
 GzFsogC9vodsQYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0734313A50;
 Wed, 30 Jul 2025 20:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YEynLiGGimjhPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 30 Jul 2025 20:52:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 1/3] target/arm: Fix migration to QEMU 10.1
Date: Wed, 30 Jul 2025 17:52:43 -0300
Message-Id: <20250730205245.2118-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250730205245.2118-1-farosas@suse.de>
References: <20250730205245.2118-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The DBGDTRTX register definition was removed from cpu->cp_regs in the
10.1 cycle. This breaks migration from QEMU versions < 10.1 due to the
present of an extra, unknown (to 10.1) register in the migration
stream.

Change the cpu_post_load validation code to recognise that the
register has been removed and ignore it when present in the stream.

Keep a compatibility list with the registers that should be ignored
when sent from versions older than 10.1. The value of the cpregs
hashtable key is used because it can be derived on the destination
(where this patch applies) from the cpreg_vmstate_indexes array.

Note that this solution is *not* generic for other QEMU versions
moving forward, this is a stop gap to avoid machines being stuck in
QEMU < 10.1 without a migration path. A proper solution would include
versioning of the register list and recognizing any registers
removed/changed.

Fixes: 655659a74a ("target/arm: Correct encoding of Debug Communications Channel registers")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
Will an older guest using the register have issues after migration
once the register gets set to its default value?
---
 target/arm/machine.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6986915bee..2d4df53817 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -8,6 +8,7 @@
 #include "cpu-features.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
+#include "target/arm/cpregs.h"
 #include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
@@ -868,6 +869,14 @@ static const VMStateInfo vmstate_powered_off = {
     .put = put_power,
 };
 
+static uint64_t compat_cpreg_keys_virt_10_0[] = {
+    /*
+     * { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32,
+     * .cp = 14, .crn = 0, .crm = 5, .opc1 = 3, .opc2 = 0 }
+     */
+    ENCODE_CP_REG(14, 0, 1, 0, 5, 3, 0),
+};
+
 static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -951,7 +960,7 @@ static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
-    int i, v;
+    int i, j, v;
 
     /*
      * Handle migration compatibility from old QEMU which didn't
@@ -987,10 +996,23 @@ static int cpu_post_load(void *opaque, int version_id)
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
             /* register in their list but not ours: fail migration */
+
+            for (j = 0; j < ARRAY_SIZE(compat_cpreg_keys_virt_10_0); j++) {
+                if (cpu->cpreg_vmstate_indexes[v] ==
+                    cpreg_to_kvm_id(compat_cpreg_keys_virt_10_0[j])) {
+                    /*
+                     * ...unless the extra register is being explicitly
+                     * ignored for migration compatibility purposes.
+                     */
+                    i--;
+                    goto next;
+                }
+            }
             return -1;
         }
         /* matching register, copy the value over */
         cpu->cpreg_values[i] = cpu->cpreg_vmstate_values[v];
+    next:
         v++;
     }
 
-- 
2.35.3



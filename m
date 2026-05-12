Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805B4CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuPb-0006ZW-MK; Tue, 12 May 2026 17:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuPI-0004rG-Fq
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuPG-0004te-Mw
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C25E76219;
 Tue, 12 May 2026 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NECWdCLypRsj1vTLHE3330kjB9zLgieAyYq8O97ZDpo=;
 b=VRE16G/iwRnxXKveTd+yhtFW5f6t+9o1zZVdQQGkNLinpTgCoEUBb+AbaR7lchNjQJwdX4
 OzTDEeopa4QISTDG+zQD2lcpGVXKecY3OLy1GWUgIFgxU24r3rKMz9/KH7Hwf9i1KhnaRb
 RtqDDGobXe5Bu9B3gMAVwVuGWckSNCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NECWdCLypRsj1vTLHE3330kjB9zLgieAyYq8O97ZDpo=;
 b=mT7iwXUPJTf7tc2wgRZl4R7Fweo/Z8zg1FbyIico0Aol942zve5Pg6Wuxgcx/n/FpYAcxC
 /YthEjSpiYcPFqAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NECWdCLypRsj1vTLHE3330kjB9zLgieAyYq8O97ZDpo=;
 b=VRE16G/iwRnxXKveTd+yhtFW5f6t+9o1zZVdQQGkNLinpTgCoEUBb+AbaR7lchNjQJwdX4
 OzTDEeopa4QISTDG+zQD2lcpGVXKecY3OLy1GWUgIFgxU24r3rKMz9/KH7Hwf9i1KhnaRb
 RtqDDGobXe5Bu9B3gMAVwVuGWckSNCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NECWdCLypRsj1vTLHE3330kjB9zLgieAyYq8O97ZDpo=;
 b=mT7iwXUPJTf7tc2wgRZl4R7Fweo/Z8zg1FbyIico0Aol942zve5Pg6Wuxgcx/n/FpYAcxC
 /YthEjSpiYcPFqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E108F593A9;
 Tue, 12 May 2026 21:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6IDyK7+XA2r+IAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 May 2026 21:12:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 4/4] tests/qtest/iommu-smmuv3-test: Skip if no TCG GICv3 device
 present
Date: Tue, 12 May 2026 18:12:21 -0300
Message-ID: <20260512211221.3173-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512211221.3173-1-farosas@suse.de>
References: <20260512211221.3173-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,linaro.org:email,nongnu.org:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

On a KVM-only (--disable-tcg) build, the iommu-smmuv3 qtest fails:

qemu-system-aarch64: QTest does not support GICv3 emulation
Broken pipe
../../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

This is because the test runs the virt board with the qtest
accelerator and gic-version=3.  In the virt board this selects the
TCG (emulated) GICv3, but in a --disable-tcg build we don't compile
that device, only the KVM GICv3 (which isn't usable with qtest).

Add a check to the test so we skip it if the arm-gicv3 device isn't
in the QEMU binary.

Cc: qemu-stable@nongnu.org
Fixes: d8d19c31b220142641 ("tests/qtest: Add SMMUv3 bare-metal test using iommu-testdev")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/iommu-smmuv3-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
index dae9821b92..708fae5fd3 100644
--- a/tests/qtest/iommu-smmuv3-test.c
+++ b/tests/qtest/iommu-smmuv3-test.c
@@ -64,6 +64,11 @@ static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
         g_test_skip("virt machine not available");
         return;
     }
+    if (!qtest_has_device("arm-gicv3")) {
+        /* This can happen for a KVM-only build: qtest uses the TCG GICv3 */
+        g_test_skip("gicv3 not available");
+        return;
+    }
 
     /* Initialize QEMU environment for SMMU testing */
     qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 "
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F214EE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTLA-0004KD-2j; Thu, 02 Jan 2025 17:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTL3-00049B-5r
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:46 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTKz-00078l-Ss
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:06:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6408C1F785;
 Thu,  2 Jan 2025 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RD7yB4BqEnUokwZcylesgnfu2Hu9btZJIlzMQiLvSCQ=;
 b=j9a7f+t8/7wiNSjaK0rMtpT2LlMFn0Pv3wfKTWfGbm/k8wCuvJqcYHezfJKKlWizf2/PNs
 uq0US7FaAH/m+pK4AWIkHDd8ig2QfUy++ZT7blDZuAZ0a+PYWFBprALtnHTkqf7qGSHWnG
 WDsGrfBk5amnqYiDnamto2BnQXcTwX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RD7yB4BqEnUokwZcylesgnfu2Hu9btZJIlzMQiLvSCQ=;
 b=EEY3YrEy9Ug3IBW8zEyIrW1SDk7tK5ePfGbb8wkmp/1+Bf5gqU3obGCs9vaLHz/3ffikLp
 px6oX+xfMFSccACg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j9a7f+t8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EEY3YrEy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735855600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RD7yB4BqEnUokwZcylesgnfu2Hu9btZJIlzMQiLvSCQ=;
 b=j9a7f+t8/7wiNSjaK0rMtpT2LlMFn0Pv3wfKTWfGbm/k8wCuvJqcYHezfJKKlWizf2/PNs
 uq0US7FaAH/m+pK4AWIkHDd8ig2QfUy++ZT7blDZuAZ0a+PYWFBprALtnHTkqf7qGSHWnG
 WDsGrfBk5amnqYiDnamto2BnQXcTwX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735855600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RD7yB4BqEnUokwZcylesgnfu2Hu9btZJIlzMQiLvSCQ=;
 b=EEY3YrEy9Ug3IBW8zEyIrW1SDk7tK5ePfGbb8wkmp/1+Bf5gqU3obGCs9vaLHz/3ffikLp
 px6oX+xfMFSccACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B949132EA;
 Thu,  2 Jan 2025 22:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKGFC+8Nd2emeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 Jan 2025 22:06:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/8] tests/qtest/virtio-iommu-test: Don't pass uninitialized
 data into qtest_memwrite
Date: Thu,  2 Jan 2025 19:06:26 -0300
Message-Id: <20250102220629.11351-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250102220629.11351-1-farosas@suse.de>
References: <20250102220629.11351-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6408C1F785
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,linaro.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

Valgrind complains about:

Use of uninitialised value of size 8
&
Conditional jump or move depends on uninitialised value(s)

both at:
   at 0x5265931: _itoa_word (_itoa.c:180)
   by 0x527EEC7: __vfprintf_internal (vfprintf-internal.c:1687)
   by 0x528C8B0: __vsprintf_internal (iovsprintf.c:96)
   by 0x526B920: sprintf (sprintf.c:30)
   by 0x1296C7: qtest_memwrite (libqtest.c:1273)
   by 0x193C04: send_map (virtio-iommu-test.c:125)
   by 0x194392: test_attach_detach (virtio-iommu-test.c:214)
   by 0x17BDE7: run_one_test (qos-test.c:181)
   by 0x4B0699D: test_case_run (gtestutils.c:2900)
   by 0x4B0699D: g_test_run_suite_internal (gtestutils.c:2988)
   by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
   by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
   by 0x4B068B2: g_test_run_suite_internal (gtestutils.c:3005)
 Uninitialised value was created by a stack allocation
   at 0x193AFD: send_map (virtio-iommu-test.c:103)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241209204427.17763-5-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/virtio-iommu-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/virtio-iommu-test.c b/tests/qtest/virtio-iommu-test.c
index afb225971d..98ffa27912 100644
--- a/tests/qtest/virtio-iommu-test.c
+++ b/tests/qtest/virtio-iommu-test.c
@@ -105,7 +105,7 @@ static int send_map(QTestState *qts, QVirtioIOMMU *v_iommu,
     QVirtQueue *vq = v_iommu->vq;
     uint64_t ro_addr, wr_addr;
     uint32_t free_head;
-    struct virtio_iommu_req_map req;
+    struct virtio_iommu_req_map req = {};
     size_t ro_size = sizeof(req) - sizeof(struct virtio_iommu_req_tail);
     size_t wr_size = sizeof(struct virtio_iommu_req_tail);
     struct virtio_iommu_req_tail buffer;
@@ -147,7 +147,7 @@ static int send_unmap(QTestState *qts, QVirtioIOMMU *v_iommu,
     QVirtQueue *vq = v_iommu->vq;
     uint64_t ro_addr, wr_addr;
     uint32_t free_head;
-    struct virtio_iommu_req_unmap req;
+    struct virtio_iommu_req_unmap req = {};
     size_t ro_size = sizeof(req) - sizeof(struct virtio_iommu_req_tail);
     size_t wr_size = sizeof(struct virtio_iommu_req_tail);
     struct virtio_iommu_req_tail buffer;
-- 
2.35.3



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kL1Zv9yJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3CC-00082S-W9; Mon, 16 Nov 2026 15:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C5-0007ui-0p; Mon, 16 Nov 2026 15:20:49 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C3-0008UJ-4e; Mon, 16 Nov 2026 15:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=iGmpaBwYWM3eHjQxJF1QYPsp8dZjY54snE8gdfQB6Ns=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kL1Zv9yJLVSox2D/6DabG6cntSSGgOqG/+qPXyfsqKOzK8ZAcZG0B1SD5IE1/uBrM
 XTIgzCk/EaCMJVld5EfBPouPw0o4RzUMtZL36QW3XM5r09Ybpuh9MMpyKaERyXpIMK
 JZu5jMcokJZB7RsNwSsYXPXCxZUDSB2uyshLekWKrTYVYg2kPtOsxAMVnLAbf4f3Y6
 AIGm3KPPjXreSm2bL8CbBVI4NiI6h3fEbAe1L2kz5mJp2ns5/OQi3JljUTwoWaIFlo
 yX4HV5T81Sqm7cFkM0ktfBmxhtyc1WxrJE5YodMdFnp4bXq2fY2kvddl8FsavQ7rmC
 KLADheASYajuA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B76C91E7147;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B4B9145FB7D;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6F5DEB8DF0; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 oxsignal <awo@kakao.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 17/59] qed: fix incorrect denominator in
 qed_bytes_to_clusters() (CVE-2026-118594)
Date: Mon, 16 Nov 2026 23:18:21 +0300
Message-ID: <20261116201922.534306-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Hajnoczi <stefanha@redhat.com>

cluster_size - 1 is often used in bitwise mask operations in qed.h, so
this bug is probably a copy-paste error. qed_bytes_to_clusters() uses a
division and the denominator should be the full cluster_size value.

This bug can be used to leak heap memory to the guest with a QED file
where cluster_size <= 32 KB (the default is 64 KB) and table_size = 8 or
16 (the default is 4).

Fixes: CVE-2026-118594
Fixes: 298800cae72e ("qed: Table, L2 cache, and cluster functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4737
Reported-by: oxsignal <awo@kakao.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 2a2fc7ea6c72b0f07d6e58493b05296de85dee57)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qed.h b/block/qed.h
index 26d4bf038c7..04bcd7ac4fa 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -253,7 +253,7 @@ static inline uint64_t qed_offset_into_cluster(BDRVQEDState *s, uint64_t offset)
 static inline uint64_t qed_bytes_to_clusters(BDRVQEDState *s, uint64_t bytes)
 {
     return qed_start_of_cluster(s, bytes + (s->header.cluster_size - 1)) /
-           (s->header.cluster_size - 1);
+           s->header.cluster_size;
 }
 
 static inline unsigned int qed_l1_index(BDRVQEDState *s, uint64_t pos)
-- 
2.47.3



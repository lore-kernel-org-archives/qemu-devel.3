Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C70606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=VISr8+p6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp1l-0003HO-Is; Fri, 27 Nov 2026 01:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0v-00029V-Uc; Fri, 27 Nov 2026 01:00:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0t-0004z3-HN; Fri, 27 Nov 2026 01:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=i5X1u3+Bt1oKDBtassV/H+3lLcs9gWv5KVDbsmdKntY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VISr8+p6n5dkp64Zo6NVBbeSdEY2UN98Dz6srTWmTqxv7rxSdleqtz+rfe/qqNR7H
 qQd8OdH7mG81/JZlInGWnpg89ehrxGUnUbE3B6703lv3V3NU8Vroi4suwaFGSW7Q/n
 BHNBx3+2fv7HbqPKD6vv34szMq2Ke+JTliqk2O58Mze+sdUkJ83HvooRDvuuVJrBOM
 ELPDlT2X0e3rSAycTkpzU7qTQylxC/nwUnv+2VHnkB9h8oiqXWnn1F4itCTEL2Zgmb
 RXV/b4joBcddf50BSkU1IbutEgBD6cOk7scWZ+GGoOuHkQwdrV4UC8I0hPgFvCr6sU
 yeMeZaRaUkiZg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A77A81EA309;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A5447469943;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9182BCF292; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Harshit Mukhedkar <harshit007k@gmail.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 126/140] hw/sd/sdcard: Validate migrated blk_len
 in post_load
Date: Fri, 27 Nov 2026 08:53:52 +0300
Message-ID: <20261127055421.39015-67-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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

From: Harshit Mukhedkar <harshit007k@gmail.com>

Migration streams are untrusted input. A crafted stream can set
blk_len larger than the 512 byte data[] buffer, so a later block
read passes that length to blk_pread() and overflows data[] on
the host heap.

Reject such state in post_load.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4725
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 2a9bd40be705978b721f7a9f570dc797f2f9db47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 07ec83dbd87..700041b5db7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -946,11 +946,24 @@ static int sd_vmstate_pre_load(void *opaque)
     return 0;
 }
 
+static int sd_vmstate_post_load(void *opaque, int version_id)
+{
+    SDState *sd = opaque;
+
+    /* Check for blk_len that overflows data[] */
+    if (sd->blk_len > sizeof(sd->data)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription sd_vmstate = {
     .name = "sd-card",
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
+    .post_load = sd_vmstate_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(mode, SDState),
         VMSTATE_INT32(state, SDState),
-- 
2.47.3



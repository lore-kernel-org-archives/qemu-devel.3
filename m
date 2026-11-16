Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F923606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Bi/PwL1t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3EZ-00069r-Go; Mon, 16 Nov 2026 15:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3ET-00064p-89; Mon, 16 Nov 2026 15:23:17 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3ER-0003fG-BF; Mon, 16 Nov 2026 15:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860374; bh=H8tlbCm7D3TYtborLP2DonHy9SO7bZXeEwGDIYyp7Fw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Bi/PwL1tR6+VWFlifR2xuctEGlNVwSu2LFHzTDq00jmd0at8wDaI3oS/MftsJBklb
 OaTACdFhxbuL9LjMWI16eRJCvsffV26zl73fNLuOQ6qAVQq5GgFipOgXqzvEwV+47D
 lGndaRHxCBqiM1t2DFKpT/y8Cgcpk1BZ/ma9yyK3cUDSg2dDYwUTzL9Xs99whLLg40
 m57QcgRG1DcJtRSkXtAzcjFO174tTBw6+YYX/jDykH0lZDUIVR7nHiHjtpSfbebi7C
 C/UWNKc04LfEwpac5EikaES0rX9cphprwQf/KrysIlGrah69D2RIwuEn/G9gvkyiHl
 g2c59ITyw2OMw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE8011E7160;
 Mon, 16 Nov 2026 23:19:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AAB0E45FB99;
 Mon, 16 Nov 2026 23:19:34 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A040AB8E22; Mon, 16 Nov 2026 23:19:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 42/59] block/vmdk: Avoid assertion if image file has
 no extents
Date: Mon, 16 Nov 2026 23:18:46 +0300
Message-ID: <20261116201922.534306-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

On a malformed image file which has no extents in it, we will open the file
but then fall over on an assertion in vmdk_co_get_info():

    $ cat bad.vmdk
    # Disk DescriptorFile
    version=1
    CID=fffffffe
    parentCID=ffffffff
    createType="vmfs"

    $ qemu-img info -f vmdk /tmp/zz9
    qemu-img: ../../block/vmdk.c:3104: int vmdk_co_get_info(BlockDriverState *, BlockDriverInfo *): Assertion `s->num_extents' failed.
    Aborted (core dumped)

(This was noted in passing in the report of #4571.)

Cc: qemu-stable@nongnu.org
Fixes: 7fa60fa3778f1c7336 ("VMDK: open/read/write for monolithicFlat image")
Reported-by: router0mail <https://gitlab.com/router0mail>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-2-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit fdf80a4f5162f345405c3a18b223e54decbd1e6a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vmdk.c b/block/vmdk.c
index ffdaf3c9014..c059f8493d2 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1297,6 +1297,12 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
         extent->type = g_strdup(type);
     }
 
+    if (s->num_extents == 0) {
+        error_setg(errp, "Invalid file: no extent lines present");
+        ret = -EINVAL;
+        goto out;
+    }
+
     ret = 0;
     goto out;
 
-- 
2.47.3



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C8606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ARpvr96S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Ei-0006Lp-OX; Mon, 16 Nov 2026 15:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3EU-000671-Fe; Mon, 16 Nov 2026 15:23:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3ER-0003id-Or; Mon, 16 Nov 2026 15:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860375; bh=wS68NHd3/LFn2/P1rEYu7xGocZk21XRhnud6V7zBcM4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ARpvr96SIAeF0v+fMenNj6fDSOogw/N1Td6rfXbNeiUT61MhA4HeGkDoMbRlv7un4
 wDmcsooIHzARcsTJjAZYH2uryB6ZQ1n0wzrEMEUDGq77j3eOthQlePqzRj69eJvjAl
 74eatm6WKvJuYBIZgqA8wL3MTLhMbL5wLIMf0Kd8etYMRYD/YqkbOTHRw8J3ZX3/K1
 XQyasB+A2mdAT8j/uqCzaxAYPIhZ/pYt6fMJO1Yf5RsxgYZ89FTPsh61xNYgr8mowi
 HgtSpI59q6Ww3bI2XLsAC0JhIRc2BBwyIRpMahGcsUVip30xMyNkXByo2PhWi5Qe9P
 bKrZnGqoZUpUQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DC8151E7164;
 Mon, 16 Nov 2026 23:19:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DA1DE45FB9A;
 Mon, 16 Nov 2026 23:19:35 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D33C4B8E24; Mon, 16 Nov 2026 23:19:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 43/59] block/vmdk: Avoid reading off the end of
 descriptor memory
Date: Mon, 16 Nov 2026 23:18:47 +0300
Message-ID: <20261116201922.534306-43-mjt@tls.msk.ru>
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

In vmdk_parent_open() and vmdk_read_cid(), we read DESC_SIZE bytes
from the image file into a malloc'd buffer, and then look through it
for a keyword using strstr().  If found, we skip past the keyword and
attempt to parse a value from the next part of the buffer.  However,
we failed to check whether the end of the keyword is right at the end
of the buffer, and so a malicious image can cause us to read off the
end when parsing the value part.

Check for this condition before attempting to parse the value.

The worst case here is that the image causes us to read some junk
from the heap into the BlockDriverState backing_file and
auto_backing_file fields; the image could control those anyway, and
it's unlikely that this heap data could e.g. be leaked to the guest.

Cc: qemu-stable@nongnu.org
Reported-by: router0mail <https://gitlab.com/router0mail>
Fixes: 5f4da8c0f3736b2 ("New multiple snapshot support for VMDK")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4571
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-3-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit fe2cbdda07c20c3b55e91522113b10a5d70ac0b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vmdk.c b/block/vmdk.c
index c059f8493d2..117e25492bf 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -330,6 +330,10 @@ vmdk_read_cid(BlockDriverState *bs, int parent, uint32_t *pcid)
         goto out;
     }
     p_name += cid_str_size;
+    if (p_name >= desc + DESC_SIZE) {
+        ret = -EINVAL;
+        goto out;
+    }
     if (sscanf(p_name, "%" SCNx32, &cid) != 1) {
         ret = -EINVAL;
         goto out;
@@ -501,6 +505,10 @@ static int GRAPH_RDLOCK vmdk_parent_open(BlockDriverState *bs)
         char *end_name;
 
         p_name += sizeof("parentFileNameHint") + 1;
+        if (p_name >= desc + DESC_SIZE + 1) {
+            ret = -EINVAL;
+            goto out;
+        }
         end_name = strchr(p_name, '\"');
         if (end_name == NULL) {
             ret = -EINVAL;
-- 
2.47.3



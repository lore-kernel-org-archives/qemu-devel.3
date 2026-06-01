Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078A6CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU010-0004Uf-HR; Mon, 01 Jun 2026 06:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54dd352c59269fdb5241e7b6dbcecaff107e7f5a@kylie.crudebyte.com>)
 id 1wU00y-0004U3-LX; Mon, 01 Jun 2026 06:37:00 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54dd352c59269fdb5241e7b6dbcecaff107e7f5a@kylie.crudebyte.com>)
 id 1wU00w-000788-R6; Mon, 01 Jun 2026 06:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=GTomEbl5MoBywpmJl0J2ohNoLwUhaPLNBuJe7ZYv6qI=; b=gVv45
 gChDcnqIu0pgv5KI8Fq24xKjnV9pwl5DZKcofz63QFVQ/7thAtcdOeMhBcalbbYOw8HZO8iFambwJ
 ZsuJFeEP+Aq3nanpnFVn1FoRNLjuoo0saBN4Adfcc4siaFAKLNSGIV3+iTtn869nAlgosRGYRP1Fl
 sSY6tpmhvYhj7hixF3ETyg1D6fqcceadJ8SmDu5QjvuSOWDsVb3MchpTycnq7OBlJAhVd6HUS52XH
 OR+bt9CVH3liTSyaL3WsDdViUIu9dmytPDlOnvA065ihtCFVbSdTjULPMEaM8q5+nFlYhAHlv6H5m
 R+isCDA2T/ShEcB/Z5ZJjwdTt5TqgkjlE0OGiSVVekXE87TsRSrlEE5W+2uSuRKve6U1/RdEnJ8Zu
 iQysks+rbtPWCk9SE2RxEK1XH+aqgrdr0jJ5VJ2OiGyp79ee5R9dPTAUN2Y40K0XF+3S+3eLgEfTU
 EGfB6zSyU7q3CW/6cvZ78C7kS/OVpAouHgAWaDsUn2c1F2/YiTimtTOLWJAHUXjF9Y5ddrX82XkFJ
 XtBGhEePBr/6pxop9kNeYjqGs7Xj5nZB/aCf8CtHiowGGfqjITAZZ9gJ2+POVt1WZHgfS/mvkrOHQ
 6oanm7rnF7Zd3HAfs0e5hy0h28A1SQXcbjX2JeK47S2KGUavpiQu5SL6mEix3I=;
Message-ID: <54dd352c59269fdb5241e7b6dbcecaff107e7f5a.1780307575.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780307575.git.qemu_oss@crudebyte.com>
References: <cover.1780307575.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 01 Jun 2026 11:52:56 +0200
Subject: [PULL 3/7] hw/9pfs: add error handling to v9fs_fix_path()
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wang Jihe <wangjihe.mail@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=54dd352c59269fdb5241e7b6dbcecaff107e7f5a@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Update v9fs_fix_path() to return int and propagate errors from
v9fs_path_sprintf(). This allows callers to detect and handle
path formatting failures.

Link: https://lore.kernel.org/qemu-devel/a0592741a918b7cbe751980ec7ec0c03f505924c.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 88894ec9d2..d704de644f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1417,13 +1417,15 @@ static void print_sg(struct iovec *sg, int cnt)
 }
 
 /* Will call this only for path name based fid */
-static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
+static int v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
 {
     V9fsPath str;
+    int ret;
     v9fs_path_init(&str);
     v9fs_path_copy(&str, dst);
-    v9fs_path_sprintf(dst, "%s%s", src->data, str.data + len);
+    ret = v9fs_path_sprintf(dst, "%s%s", src->data, str.data + len);
     v9fs_path_free(&str);
+    return ret;
 }
 
 static inline bool is_ro_export(FsContext *ctx)
-- 
2.47.3



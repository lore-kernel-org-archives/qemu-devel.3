Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7E3CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU00t-0004SG-18; Mon, 01 Jun 2026 06:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <abb0cc02fb56e2432837e34b80fe68768f95e774@kylie.crudebyte.com>)
 id 1wU00q-0004Rj-Tr; Mon, 01 Jun 2026 06:36:52 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <abb0cc02fb56e2432837e34b80fe68768f95e774@kylie.crudebyte.com>)
 id 1wU00p-00072a-4m; Mon, 01 Jun 2026 06:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Gc/QErGR5RsT8fG68U+RgVCSzjXhNLLHjAN27KCzsA4=; b=SbiBn
 dg3r54umTtdmeoOq4ZoknmyEcj81qSk6N5uQDZoq8JhwOrWFHkA95rsGeknakBUP6GVNQoZOLeENx
 92r1wr7BmbqWadAjbLYc+i1CANAHtmGW9FTsClBxWlZNFqqNM9F8mjP6sPyxqDaS94X8o9oae6I4Q
 8+7/JW/MSRl3JrO04gdUANVrT89C3dlj3Vpgli5tV6ccRyDlJp0sgR62a8poSWbUevIVJm4m+11Gp
 dmLW6OQJlBwgXk8ze3AgUiJNb8HlxSvAaBX8kak4qIbYs9VcCN0YGqocUKyPnCZbrsIYdB9P0pv0a
 Xxuyt4+CXelybssb/nxARcBNc3OO1RucTe1ZtVGvaw4mleJLMbG1rIZaeNiCk6r3X95VOchxfaM8T
 y0fiGY29ocoCkKt92BxrNo+xKTqcnbzHpflg/v8ehhggE8hmakF1to0My5rDfkFPhvMA7ErlM7vVQ
 q+58PehEC0cbCS2CK3K2hFTvDHSQf+ZsRsmQYJIjqITIAS71QVE5zgzrbgyH8kqsnTGw56FFZN1AN
 ye/gnhck0iMQ6dhagz4SNASvJd97j04N9mRYi2k/K6jQ4Tg17C33J6LoG3qct564CpNFjbES7BY3e
 hz/S3aMtBWWB5wLW1l6+QQkkmLp82yiQIOa8zIZBJM9ALT9jrWW/yoPrvLpgWQ=;
Message-ID: <abb0cc02fb56e2432837e34b80fe68768f95e774.1780307575.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780307575.git.qemu_oss@crudebyte.com>
References: <cover.1780307575.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 01 Jun 2026 11:52:56 +0200
Subject: [PULL 1/7] hw/9pfs: add NULL check in v9fs_path_is_ancestor()
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wang Jihe <wangjihe.mail@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=abb0cc02fb56e2432837e34b80fe68768f95e774@kylie.crudebyte.com;
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

Add NULL check for s1->data and s2->data before using them in
string operations. This prevents potential crashes when dealing
with uninitialized paths.

This is just a defensive measure. We are currently never passing
NULL to this function.

Link: https://lore.kernel.org/qemu-devel/3348c4d683f061c23083bd45994d527be4fb7cbc.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e2713b9eee..e590c414ab 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -241,6 +241,9 @@ int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
  */
 static int v9fs_path_is_ancestor(V9fsPath *s1, V9fsPath *s2)
 {
+    if (!s1->data || !s2->data) {
+        return 0;
+    }
     if (!strncmp(s1->data, s2->data, s1->size - 1)) {
         if (s2->data[s1->size - 1] == '\0' || s2->data[s1->size - 1] == '/') {
             return 1;
-- 
2.47.3



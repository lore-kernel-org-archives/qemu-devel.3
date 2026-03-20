Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C6F109317A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 06:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3TNb-00078r-10; Fri, 20 Mar 2026 02:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1w3TNV-00078C-VW; Fri, 20 Mar 2026 02:30:37 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1w3TNT-0004zW-De; Fri, 20 Mar 2026 02:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Js
 i3rx2NTu//mo3V0DUno2SpJJQcJu/Js12Lz0UsJJU=; b=DP7iSB+HEgL4X999ux
 S+m6ZgUJkb9I3lhrsVoxYq1oieleBM+aczbkaRMNgxaFAoNE5Ate1NG6+GuChHU1
 hbgAUkvBAetb13DRaNRY7tcF8gC0vpQppstzcHD9MhutHqWSvExFSzIQk39FSNAA
 4M7ZoHihakBbAiBQow0yQF1/0=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wA3VCx46bxpboheAQ--.56002S2; 
 Fri, 20 Mar 2026 14:30:18 +0800 (CST)
From: zhaoguohan_salmon@163.com
To: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] block/curl: free s->password in cleanup paths
Date: Fri, 20 Mar 2026 14:30:16 +0800
Message-ID: <20260320063016.262954-1-zhaoguohan_salmon@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3VCx46bxpboheAQ--.56002S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw43Kw45CrW8GFWkGF18Grg_yoWDtwbE9a
 43AF18Ary0yFsrCay0y348KrySkw1UtrWxGrn3J3sxJFWIvay7Aa1xu34vqrsrGayfC3sx
 CanYgw45Jr1rXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8veHDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 52kd0wpxrkt0xbvdzzlrq6il2tof0z/xtbC3BoiMmm86XoXMQAA32
Received-SPF: pass client-ip=117.135.210.3;
 envelope-from=zhaoguohan_salmon@163.com; helo=m16.mail.163.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

When password-secret is used, curl_open() resolves it with
qcrypto_secret_lookup_as_utf8() and stores the returned buffer in
s->password.

Unlike s->proxypassword, s->password is not freed either in the open
failure path or in curl_close(), so the resolved secret leaks once it
has been allocated.

Free s->password in both cleanup paths.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 block/curl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 66aecfb20ec6..419df78258bc 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -903,6 +903,7 @@ out_noclean:
     g_free(s->cookie);
     g_free(s->url);
     g_free(s->username);
+    g_free(s->password);
     g_free(s->proxyusername);
     g_free(s->proxypassword);
     if (s->sockets) {
@@ -1014,6 +1015,7 @@ static void curl_close(BlockDriverState *bs)
     g_free(s->cookie);
     g_free(s->url);
     g_free(s->username);
+    g_free(s->password);
     g_free(s->proxyusername);
     g_free(s->proxypassword);
 }
-- 
2.43.0



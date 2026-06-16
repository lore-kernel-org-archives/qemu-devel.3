Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B71CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW0Q-00077B-8b; Tue, 16 Jun 2026 11:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4b33cd1aaa2551efda220a6f651e3660d27f4746@kylie.crudebyte.com>)
 id 1wZW0O-00076h-QH; Tue, 16 Jun 2026 11:47:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4b33cd1aaa2551efda220a6f651e3660d27f4746@kylie.crudebyte.com>)
 id 1wZW0N-0000Cq-Cb; Tue, 16 Jun 2026 11:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=FJnPQEyZdoiQuQZJb2PXLEBll9rUFdPWbbpBDzmHekw=; b=VyXcY
 Y12CeyImnPa46AkTEAgKhA1gL/PHafgRa5HDryaRUs2/CAmdJivzA5V27xAcad6IC+6H/e6fcgBz+
 hmRtzYSUUu5svURVmNF+Al4utajFmKSRI2w6DoK+tPPFzDX5D1HWsdsrQyTlYDoQeETXD60K8MO6M
 aoRAH4YEQQ7FgiBLHd1CXpsmGqKTxKuy5rXnYt+f6MP+4ZURpI/5tjGA2y1zquu+6GqSi/eF3OV4v
 dn+akxPK6feLS3I0BVWk4j7aqg4VwfA2JUzo9gJsUI6bkc9ai/+/eVv1nvL3EjsWuvMn4QW5eRLOb
 KnDkppU9SDS6CeQ85lpN98U4KAd8xtyR9ILFuktFfN+3LeKme+8wBRLDsXXRO9usqzoTquw1yh5JF
 H4dPXVo+WC/Nq1Xu+DDAGdd7vM9sjcb7l9+4Z5XLQMj9HIk2eHrzjznWQggYj0oljZJATzaOkv6Uh
 CHd8cjiDvGE8++efvG4IJ0Ps815ANVc8xkZCpcbjJz23jRhf89EEmEodVjVUaRwT1xIbJSb1Hfa4F
 9kI38EUDiasihyCcK3qAKR0j3Ul9hPko/UGjg/atiJ0dcPbHz7Ch6FalKzeWpeeSErpbJzH14MqK8
 cm+VLFE0nMvgWP6hb/qT7PGc7tl3r/D3eVQRXzpkrkVZqfhzI2E0QpVxFHOWd4=;
Message-ID: <4b33cd1aaa2551efda220a6f651e3660d27f4746.1781621428.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781621428.git.qemu_oss@crudebyte.com>
References: <cover.1781621428.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 Jun 2026 17:00:11 +0200
Subject: [PATCH 2/3] hw/9pfs: fix invalid union access by v9fs_co_fstat()
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=4b33cd1aaa2551efda220a6f651e3660d27f4746@kylie.crudebyte.com;
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

The individual FID types (P9_FID_NONE, P9_FID_FILE, P9_FID_DIR, P9_FID_XATTR)
share union V9fsFidOpenState with FID-type specific fields. Accessing any of
the union fields must comply with the FID-type to avoid undefined behaviour
or information disclosure.

Fix this in v9fs_lock() and v9fs_getlock() by checking if FID has a valid
file descriptor before calling v9fs_co_fstat().

Fixes: 10b468bdc533 ("virtio-9p: Implement TXATTRCREATE")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 6dd6a57e7a..c83df57698 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3852,6 +3852,10 @@ static void coroutine_fn v9fs_lock(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (!fid_has_valid_file_handle(pdu->s, fidp)) {
+        err = -EBADF;
+        goto out;
+    }
     err = v9fs_co_fstat(pdu, fidp, &stbuf);
     if (err < 0) {
         goto out;
@@ -3897,6 +3901,10 @@ static void coroutine_fn v9fs_getlock(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (!fid_has_valid_file_handle(pdu->s, fidp)) {
+        err = -EBADF;
+        goto out;
+    }
     err = v9fs_co_fstat(pdu, fidp, &stbuf);
     if (err < 0) {
         goto out;
-- 
2.47.3



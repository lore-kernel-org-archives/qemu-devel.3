Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C0FC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCFW-0000ug-7e; Mon, 29 Jun 2026 09:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <32cae47c332f88241632905e0a3abcbb35b019c3@kylie.crudebyte.com>)
 id 1weCEb-00084P-98; Mon, 29 Jun 2026 09:41:17 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <32cae47c332f88241632905e0a3abcbb35b019c3@kylie.crudebyte.com>)
 id 1weCEZ-0005JM-Sr; Mon, 29 Jun 2026 09:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=LEQEllSuWrpoBefPi0ya9mS1eZ+GpNqLPFo4p4F5poY=; b=LR+ly
 OLN3gfsLGSTnszRCX6UE5XP6bNqMrjlvpn0PfIrBGgCGmZyAzEZbXkooogAv6iMhO2PA2gwXerUAy
 o7vnzynxr28Rbrx9EeNNoyceZv7MqpFgQugTJcFxrwkh5O9IiqojGEslLjvRd3ADLKW0cngyP0pnl
 RBXKINbBTRfJjR0mQnSAOIyZ0RaE1SPmUWTpuLg9zeQh3SYaIKMTukQ9OA+vhCmVK1bxGxaFeiH2r
 61KTdw/nUpnPUwiFN/PNP6xwP4ViINHYdxigMN3U/roJguhrSOMOams+r88/byKAlJaDbKJsIKWN1
 00w4zq1LlDy5jqNBDY/Y3veecnfwM8ptVD+4Uls74xC5F29+tfIsCiX5uuB/ovHoY27wB2VN9qbf/
 bgEFD/GO7UlHjqWiSjzpAL4t2o/+CjDSmSdHDGzSPTDwrNdaHOcxLXcwFVlu6IIfj0KbtU20mP8Wn
 m9sPo7Na6GrWjUzXLkVuFqnDSotPkuJenVeW2UOu0NJzWLTLA6A8Avo8DVRCXeBKcTE8OVZW8Y/SF
 q27zWlOHsSS04I2/3VrNedF/uO2g2dZj3HDzA05I34AvgTsXqzyoeCIOXoffuNud1RnfouaPfqCGt
 Yth2M7KqoKZWrCDvimcKqU+tRlkticql59Ykl+ZRMs/GY4tGCxkfzvALBz9Rgs=;
Message-ID: <32cae47c332f88241632905e0a3abcbb35b019c3.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 21/23] hw/9pfs: fix invalid union access by v9fs_co_fsync()
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=32cae47c332f88241632905e0a3abcbb35b019c3@kylie.crudebyte.com;
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

Fix this in v9fs_fsync() and v9fs_wstat() by checking if FID has a valid file
descriptor before calling v9fs_co_fsync().

Fixes: 10b468bdc533 ("virtio-9p: Implement TXATTRCREATE")
Reported-by: Feifan Qian <bea1e@proton.me>
Link: https://lore.kernel.org/qemu-devel/b583e29d5a0776e41263732c93ac9f0da0a6016d.1781621428.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index d1ec3c0c14..a2b7335515 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2305,10 +2305,15 @@ static void coroutine_fn v9fs_fsync(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (!fid_has_valid_file_handle(pdu->s, fidp)) {
+        err = -EBADF;
+        goto out;
+    }
     err = v9fs_co_fsync(pdu, fidp, datasync);
     if (!err) {
         err = offset;
     }
+out:
     put_fid(pdu, fidp);
 out_nofid:
     pdu_complete(pdu, err);
@@ -3640,6 +3645,10 @@ static void coroutine_fn v9fs_wstat(void *opaque)
     }
     /* do we need to sync the file? */
     if (donttouch_stat(&v9stat)) {
+        if (!fid_has_valid_file_handle(s, fidp)) {
+            err = -EBADF;
+            goto out;
+        }
         err = v9fs_co_fsync(pdu, fidp, 0);
         goto out;
     }
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC892C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QEy-0003Pr-Gj; Tue, 15 Sep 2026 06:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEw-0003PG-Us
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:14 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEX-00039b-VC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:14 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so1186004a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467466; x=1790072266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8RfjQjVOX1tJDdARKFAxVYWhrl5wDLHiadJICm/sXU=;
 b=sXVuJnvJg8xQBD0MstKCp2Ovqi7Vdws5oRb5qM7+poQGPlqEExuy7TdpbP58I6b1CY
 4neb6VF00+Yd/IUq1qCZo1P3tFo8yke3N57mYF/TrR6qvDslnczzoPLQCJnkTjksKaOj
 yDRz49SEjZG14esI1DYP3yjYbyhL8zo6sN0CQOFlUhbarZxOzQcyDUcSMoPdmRcUTr/v
 R7itZaf2asEVMsvwdRduZ+LdK4Qs24FJAhkOlWNOqC1vkFO/QY+9w1Rs3UurcPAaAeWh
 bdz/8RGr20ixLwLgYDggcB9sQPcOoydWCd0zUARuUSwf3aZDN8DscdMvoSCmfiEERY6k
 9ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467466; x=1790072266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8RfjQjVOX1tJDdARKFAxVYWhrl5wDLHiadJICm/sXU=;
 b=OcQQ4zjYR4enWNgLhdKGL542lwJxo9k3e0zBDs6JhRnNFq5eCsLcbGhhzqPqFnU4UY
 UhTuOj6c+ylW+Bii936cLX53/oTsXMETQb90WJuxVtfW5XEIwlbpyC9O2sZww9kmW7f3
 7sSrMeBcYlZYFBCna7ZjVRarTgdyUqWNJbIWRph5AwMBJezJg7Ba/dcLce4nPLy72T2u
 mSxqskiVLzVe9DrtXzk1zc6EhidZ7rXT2ScDKaw5Z/K1jVdmaX75b0zAmq7UFMKWYVNV
 TVX9MiRoRBm//scnyW7xutAYkIdZuh44FMtp2YuYfCoqicV5R930FPpm+yA6nKHKnVqq
 NY+g==
X-Gm-Message-State: AFuF++ms4tPvsyyg8e7XAXsmSOk9I8wAL7r9w5lJf9ysoqhFuXs+ewWD
 foo6/AR02Vuu3agIcnNZlXfhjocC/sF4+gK15C3JQSwTVURnymumURUWsP22Kg==
X-Gm-Gg: AYBFou2geJkJJ/gP0jiS8PjNG12D0VTVLopdp4g/0Dd4es6q7UcHpVn6hXVO26It6aa
 OrzzKJb6lSjqkK81Q5o0o/QfwZQaZgdmf3m2J4w+KFr16pFycY7FppiAIcud0VnBNU89cgEjBMc
 zzWrV0XDuqQlzB+1SObgZcUfGiwkH5T+8/3GWne40El+6ZK8c05xRafshrYfcBdhMiKHxJHGxde
 MSs6+HLcylNFWYMfIDEKwM0G8Rp/lRFJLQsPyHMyWKcHfe//oq7ZJKDeeSLQMR2uLgXXdXDz9ob
 mSEsW02Ao02UWvcB0Uq05bDqC5y4gJz3niJNsDzYhGXN/Sw74slZ1694rjKEwcJtPV5WHKS80Jx
 xYM9h52cN/MbPneYQj93yqphILUvfcMqmUfJ1Q5AfViYxIGLVnEyNLw9GpqplLXIQjjcdzABS/r
 +2JKdNUVHmH/yD54cDm4bZFMeF64Ne3xUH6SYt+mDqJ0rjUWKoHwvKUfaK1z/zZa4s3isf8Krff
 VH8TawHD5QPUsX3cGtcndAG5LE=
X-Received: by 2002:a17:90b:2e85:b0:39b:5622:d645 with SMTP id
 98e67ed59e1d1-39dfdcf350amr3107038a91.0.1789467466406; 
 Tue, 15 Sep 2026 03:17:46 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:45 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 10/13] xen-block: Update tracking iothread users with
 holder name
Date: Tue, 15 Sep 2026 18:16:52 +0800
Message-ID: <20260915101655.3216101-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..9dfe06e1be 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.43.0



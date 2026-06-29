Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A06C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0fL-0006Pu-88; Sun, 28 Jun 2026 21:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1we0fK-0006PH-Gb
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:20:02 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1we0fJ-0006yW-09
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:20:02 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-37fc01a7835so543917a91.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782696000; x=1783300800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8J0YAmkDWasxDwmJ95vBba8FPTuu/EGMk2LoxTWPWk=;
 b=Vt0pG+fncSdpJeVBqViaNXocjxKfoMeO+mhCoB+ATVW0GOAJP3jedvKIqxyGwwA/JH
 lSAJlsSz35tXCaVJscnSTaNOQhhC7oQZSAmkpXTPQlnA30ZNs+9yZgK1Kbgq6DcpkQzT
 tcjIuSUQCypdyA83Cb+hg1j3RflbGmk8F612sGpIpVSkdZDXCZUmLtyNIfS9KY96VZN5
 vI5HdkTXK5Iq36L/myX+NUe9KGTSaDIo/kfzN2ehdhAGP59fE5qcqBDTDJWWit/AroOL
 Alow3MLvj1OuaSP3VuhcFCiAipz7g9rpCz41SH6qNTJLtR5tAFk7m2kniXc32AYYB418
 jB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782696000; x=1783300800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z8J0YAmkDWasxDwmJ95vBba8FPTuu/EGMk2LoxTWPWk=;
 b=iHvCpVL0EbvDhVLJBxNT7XaZ9gJxivGl0eTyLZCQXvh0ryMD+W4u/MeCmW3qxn8ccB
 Z6VAPoViKCXDmNwEafaoHRiL/Fr9LksdmJ7TUu8MpnXsgrIBNYFiReI5mdlS/jDbi8Fb
 iSuBxyJ/Js/H28KPZ8a62yNmx+AOdZ/fE64jSpzZ4AsPCU41B2hQSwr4jZj+SL/esoSv
 UaPOX9PAj850gJ4Vc8fac0AAmzqdayI8dzDd9LxArFTgKN0JqLSjlblaUajqDRQDXv+X
 XlAu/8nDfNYPNXRAvGespgoxay/YH1JNK096szRudwq9TMpXpClAB3AcX3SKdaRyhJIR
 Sw3w==
X-Gm-Message-State: AOJu0YzkfDeKtSbfeGAc6IhequudYJuRF3iMrpvqk+5qJvveWghIJh3V
 nDnRks0k4MDkdQMDDUSFAydYZrl4td1S/p4IxtCU5jUBUfvkUcveLDlXjfiFJA==
X-Gm-Gg: AfdE7cmJHhSUzlYLqMxx6sJRA/NvU/BRhL5wCm5MllcKpwC+lWygCJZlqwSIuEw4sok
 9a2JpOxFbGnEtxJn36Lc8LnaEuFuFKABfDhvtn2r1yBj8Zf1B1QLnVKxL75TIYIcabXI3ALgfsa
 29IY4H69uthk+83zVL4jG5jU6uEvo/NkioU5ZWO+qK+KkKS0x6kd47s6CuGElsMSy8GZUKpxPvb
 EJkt4E/c46BzHpI2BwTLWQmjD9qoECrRoQjXR1sX0Ir6PbD06Gc/NL0RkzgP3AV95XzB6vcF9Nf
 luNmx3sKGMxOlKduCIwChLhiLhyJz4cPaHBkH8o2FZmyq9k/pwTEv1gM79CGkqAqdZA2vzieZPu
 e4ASdZee0jsbMfgn2EbDSoP4wyXiRHt+8LGsn2K1lZcxPfMLVIHH9sct8bkPyqbmP8soVOdqUFx
 hTP3Df2zyZSHx5Brmo6OAZ
X-Received: by 2002:a17:90b:2683:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-38021b7eaecmr10225a91.14.1782695999599; 
 Sun, 28 Jun 2026 18:19:59 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e24b13458sm4614058a91.13.2026.06.28.18.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 18:19:59 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com, jaemyung.lee@samsung.com
Subject: [PATCH 2/2] hw/ufs: Populate cqe.task_tag for UFSHCI 4.1 tag decoding
Date: Mon, 29 Jun 2026 10:19:35 +0900
Message-ID: <1de023f4793f05ccd5dc038b715fbd4da515f78d.1782695631.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782695631.git.jeuk20.kim@samsung.com>
References: <cover.1782695631.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102c.google.com
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

In UFSHCI 4.1 the MCQ completion queue entry carries the request tag in
the cqe.task_tag field (DW5), whereas 4.0 hosts derive it from the UTP
command descriptor base address. The device reports version 4.1 in the VER
register but left task_tag/lun zero in the completion path, so a
4.1-compliant host reads tag 0 for every completion and cannot match it to
the outstanding request.

Add the task_tag/lun/iid fields to UfsCqEntry per the UFSHCI 4.1 CQE
layout and populate them from the request UPIU header.

For example, the Linux ufshcd_mcq_get_tag() uses cqe.task_tag for
version >= 4.1, so without this SCSI commands hung (e.g. INQUIRY to the
device W-LUN) while device-management commands still completed.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c        | 6 ++++++
 include/block/ufs.h | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ee7eba6793..464fd465b3 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -520,6 +520,12 @@ static void ufs_mcq_process_cq(void *opaque)
         req->cqe.prdt_off = cpu_to_le16(prdt_off);
         req->cqe.status = status;
         req->cqe.error = 0;
+        /*
+         * From UFSHCI 4.1 the host derives the request tag from cqe.task_tag
+         * rather than decoding it from utp_addr.
+         */
+        req->cqe.task_tag = req->req_upiu.header.task_tag;
+        req->cqe.lun = req->req_upiu.header.lun;
 
         ret = ufs_addr_write(u, cq->addr + tail, &req->cqe, sizeof(req->cqe));
         if (ret) {
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 66e8f35c0e..d19b3c65ef 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -1333,7 +1333,11 @@ typedef struct QEMU_PACKED UfsCqEntry {
     uint8_t status;
     uint8_t error;
     uint16_t rsvd1;
-    uint32_t rsvd2[3];
+    uint8_t task_tag;
+    uint8_t lun;
+    uint8_t iid_ext_iid;
+    uint8_t rsvd2;
+    uint32_t rsvd3[2];
 } UfsCqEntry;
 
 static inline void _ufs_check_size(void)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F05C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12R8-0004DZ-Nc; Mon, 31 Aug 2026 09:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R7-0004D6-N2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12R5-0003yE-Sn
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mARaIROY7KV7DEbzkF9LPUd5zvGcOmMBrV5r51m4f3k=;
 b=C6YWcAWugI9rckkpXL2MoWSP5Tb2FIik4sFo1z5bpTuwvW4rXqXWy9QQqMGe7z6ymhL6Gj
 XrfHjPjiALXHZF8+hi7ul0qUzCCc0mWw6wd4J4OUbf3tSpueKWsRKngnB/bbPYJv0SMaF1
 v51vJHq8hD9dNyEF56yTgELqgODcLtA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-lUGHsFX6OEyk_kw5ibttxA-1; Mon, 31 Aug 2026 09:52:29 -0400
X-MC-Unique: lUGHsFX6OEyk_kw5ibttxA-1
X-Mimecast-MFC-AGG-ID: lUGHsFX6OEyk_kw5ibttxA_1788184349
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b0d7a07acso34422845e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184348; x=1788789148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mARaIROY7KV7DEbzkF9LPUd5zvGcOmMBrV5r51m4f3k=;
 b=oCCo8lFvO3PVf9zoN824Yzew470/IA1MFCii3MTXQmZH+Y7LEQ+mxGesf859+Sol2V
 dXo+ONy+aXtoGtnYmwEGC/P+pPV6MgV61il0x3iEMBWWYwV+y+ri4eBTMdnFPYTdt4fC
 UtvnXVgFCfHJAJhv43VB7pxrGtqxXnAOJAgASLtnW2s6HMBqzOfiiJR2jh7rXsIP0xW3
 5z5omHMFBqV0eWd60CWZHQJ4xW/ZIufUIlbFzn+v+G0H7MtLjwYKUF4J/LS+4JK/qnJv
 Vu6FK7Gh0eOUnx7dayvWH5IK1h18hruhswBLvcs435PJymC7SJC89A4QTiUCn3cjmo2U
 oVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184348; x=1788789148;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mARaIROY7KV7DEbzkF9LPUd5zvGcOmMBrV5r51m4f3k=;
 b=CHvBPCaAu1XLfZLPJS/hJ4ludW67ZJcdnPPEtt2jwddHoS+yOW6PXkMS/90zRrPeqM
 6h7iGDTCC/rbC4anhH02hRhruK2aLxPVQRg6+NqhQXrmjvoClTD8DJvM9Xw6sxGiQ3ry
 jFh8W1cX3eHdbbSrK5P0Hnl9z0B6fpJMZ32V5pPI5sU+gKRTYWuDg7J0l2PuBteSstXD
 X0cFlgG6dfsl7xSTdAJo097t7SzB5hTo9gQXgxaqxzDEsl0Q8eUj0SYNJF6Dn13ZOXdK
 hk/nccBHVkttseVtyqvAP9K3KRCIT3hzeWC2PLTIp+THDgKxH+6+IYL7DWQ8Cb5xvy0A
 F0yg==
X-Gm-Message-State: AFuF++lHqpEh1x/rh2aHc+6apQF1hMNWBGZqJExVkNOrYSlg8JCQaCtf
 WQX2rZn7Pgb08GA8kyQYEM/6HrQV5Vh8vHPyoyDjZmd3dvYO4FSnSVnVxeSA0IiSG7uVRjO98j4
 IytecL5Z8z6SH27fCVyiS3g5W6aTHb668oA5ReG52R4qhk2lCGOBr+CjL
X-Gm-Gg: AR+sD11iqXSL3LOqcgRS0sW2eeXwo9hX4KcFtAkSE1GxwR7ehcl1w1sPhhpqehsalL4
 qxDnXVWDDu/y1DRb/BZrnMNgz5Ma1z5fNm2GR6PrgTb6FgLrdR9hNbdU90COJDTINBjpzP3Nn7w
 DMJE67BZfBNtIiFO9u31uWPEo/zmUrA3rbRIa9FEGxcYndpg1coI1JktUC8L5cB6Vpnd2umEQzE
 dwHEiYoo9JH1o99EmjHv1xPHwVJPYyxCsh9ENC/cPuL02xzcYK7o3Hdc/lvAvg9UuLnJ5YjifsR
 sJ/6OBxho94H5x/ycV6S5kS+F3TtOxDNO0emXBF+JNeZ+mOi1lX7FBo4QbE6cetxC76xwbpCHsE
 dLJogK2nNPqY7mSB8nFJGRjjSR9PFPyaHwrpVYgELY8HgJLpmqwvFY4NcMFM=
X-Received: by 2002:a05:600c:1d1d:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49b91c2dfecmr398052745e9.8.1788184348546; 
 Mon, 31 Aug 2026 06:52:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1d:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49b91c2dfecmr398051545e9.8.1788184347971; 
 Mon, 31 Aug 2026 06:52:27 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc61cfsm410444125e9.6.2026.08.31.06.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:27 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/9] block-backend: Public blk_get_attached_dev_path()
Date: Mon, 31 Aug 2026 15:52:00 +0200
Message-ID: <20260831135206.126184-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Make blk_get_attached_dev_path() public so we can use it in the I/O
operation delay QMP event to identify the affected guest block device.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/system/block-backend-io.h | 9 +++++++++
 block/block-backend.c             | 6 +-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index fd84723d9d0..63b2dd2e24f 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -41,6 +41,15 @@ bool blk_iostatus_is_enabled(const BlockBackend *blk);
  */
 char *blk_get_attached_dev_id(BlockBackend *blk);
 
+/*
+ * Return the QOM path of the block device attached to the
+ * BlockBackend.
+ *
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
+char *blk_get_attached_dev_path(BlockBackend *blk);
+
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                   int64_t bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc40..164bda846f4 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1053,11 +1053,7 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
     return blk_get_attached_dev_id_or_path(blk, true);
 }
 
-/*
- * The caller is responsible for releasing the value returned
- * with g_free() after use.
- */
-static char *blk_get_attached_dev_path(BlockBackend *blk)
+char *blk_get_attached_dev_path(BlockBackend *blk)
 {
     return blk_get_attached_dev_id_or_path(blk, false);
 }
-- 
2.55.0



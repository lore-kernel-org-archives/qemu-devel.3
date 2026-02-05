Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B1FE83F1F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0eN-0007kw-6G; Thu, 05 Feb 2026 09:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eK-0007kB-0I
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eI-0004CI-JF
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770302881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBLrgUT4SfRJL0oHz2LpcYh6U/+GwUwU1+4XoRPSUmo=;
 b=akRCU+mD5J4krEMn7yOIPrDqKDcSlmQKEcZZyyOme23XQ93jfsRdQjgzR9RTIyWNTNlqsC
 aHcmkgXvXmw2d1rJZ2Tloxyzv1lDUNFCa6xE8W2ka2LI+9aIaBMMmFW5cg44cxpTf8SsgG
 t9syPzT5ebkf24AzKueERRcfye5JWrQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-ajfyp4JiMQKkYNXgWi2YcQ-1; Thu, 05 Feb 2026 09:48:00 -0500
X-MC-Unique: ajfyp4JiMQKkYNXgWi2YcQ-1
X-Mimecast-MFC-AGG-ID: ajfyp4JiMQKkYNXgWi2YcQ_1770302879
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435991d4a3aso734138f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 06:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770302879; x=1770907679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBLrgUT4SfRJL0oHz2LpcYh6U/+GwUwU1+4XoRPSUmo=;
 b=bN7MNtrtJkCP9utYXzHmwCVgq1gg4v+oLB4l0OkJU6VM9reqPF/wwZ05cieS4omvNI
 X3ekuNpTO40GJY/ctXecTMnMo1n8fyzKRWptJ6nFQKSxAopBDanxX7fiM5VejRUaBhxw
 9fLLKdkaQ1iLaNByh3cnjtMoYUyrXMuxxkYWmWSA8KBjdk1pPMm4CKeQAmWlvBD8x9pp
 K8hMPeIXBXP26NlqDUgOIfAkwUH0FVzaKV+jNJbhgZ9CQU7r5qcFtMp0/T5IO5tP/bQZ
 T5Lk3ER53dK3AvylqG5jxuBx4hEgDuzjNM0YsGrvn3R6V5AVZlttNc6rafdAh9DNpW9F
 hV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770302879; x=1770907679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OBLrgUT4SfRJL0oHz2LpcYh6U/+GwUwU1+4XoRPSUmo=;
 b=iUxweQuC+6sjaW/MagUGsyHbeMcEpw0ZMLBfSC6r4onaVBqD8b5p0eA/5RNo7an+2N
 mZZKIem+UqHu+xbYMXXG0XtNAlJcdQPjU27770TMURTgBW45RmLWbzsstxwoAEYYQqoq
 tr/PgM2J68zj8Hi/mjYOpsCQao3s9iHn2sIK/F2kSgFysyBsRyeCesrac1RXW1+FLxp2
 4ebHkV3PShjOmxpJgwH8RTCXvXJpkQ2pBfREJaXGe+oXmG0SDDzZwSyD1scTh8ehomgF
 rxEYaax2DBeOvmnAIyQR71BvkpX494RrfDRKDlwH+BGIs9igoQHS8zPVHorx4/pe5tPP
 m2bw==
X-Gm-Message-State: AOJu0Yz88GwCkaqZRxGpe9i/oZ2GJTv1WUn0DEQXFoJQZp+1aqGMEm+U
 4LYhTG4e2s3cZ/n0OeRcg3lDyeQpQX3IXV/tC6iEKLz1WXnToY1DdBsq8lRqtj6jyLcvWSoUVar
 g8YN3orquBnk6e5UJRkeR6ONwSG+Go5ixJq/kw3zTvRuftgnW0SY7qbPo
X-Gm-Gg: AZuq6aKpETIh9cSBs28uilM4Rk7q6I4tnkh8iWSSQg9cy4kiv3wUCD6QuW+Of1PS20U
 Sl/qGofGRMGC+2Ud8Vij9F/BuumR2sm3H7eV+1vSr0I2hfPSp/4IFXCGNMc7MdfYXk1LXoDGq8P
 K8roGX70K4bNid3cPQ7D/GEJ06LmZBxvVxA323Tx4Xlrbx/shUkKyebhuAzD4gYqeqmNMLINaWY
 BzCLY2qrau8wqotqV3EmdCOEeNpJqtxq3+G6rmF5SjjqUIYEcAK5Nx9PR+PaT6lrq+IealpgCqL
 s62qYeN4D/obEqUpXzEf2JKbBrb4lEqMdOJQGzJYoiDg4UO7xwVnVW2vlJktiw1YJs87vPxFgNk
 gyl09mwrJAURBYgC5Hml6m+yV1PUEwDgkB/fcQrse6givPI4WOReoSgcyFFjAwf84ZHMU
X-Received: by 2002:a05:6000:26c9:b0:435:a83e:88f with SMTP id
 ffacd0b85a97d-43617ccd136mr9324854f8f.0.1770302878956; 
 Thu, 05 Feb 2026 06:47:58 -0800 (PST)
X-Received: by 2002:a05:6000:26c9:b0:435:a83e:88f with SMTP id
 ffacd0b85a97d-43617ccd136mr9324802f8f.0.1770302878404; 
 Thu, 05 Feb 2026 06:47:58 -0800 (PST)
Received: from localhost
 (p200300cfd737d06375fda007e5d3c5c8.dip0.t-ipconnect.de.
 [2003:cf:d737:d063:75fd:a007:e5d3:c5c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805815esm13324642f8f.20.2026.02.05.06.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:47:57 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
Date: Thu,  5 Feb 2026 15:47:32 +0100
Message-ID: <20260205144737.31131-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205144737.31131-1-hreitz@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
pure data (no metadata) children.  These are going to be used by qcow2
during formatting, when we need write access to format the metadata
file, but no write access to an external data file.  This will allow
creating a qcow2 image for a raw image while the latter is currently in
use by the VM.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/block-common.h | 11 +++++++++++
 block.c                      | 15 +++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index c8c626daea..504f6aa113 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -245,6 +245,17 @@ typedef enum {
 
 #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
 
+/*
+ * Promise not to write any data to pure (non-metadata-bearing) data storage
+ * children, so we don't need the WRITE permission for them.
+ * For image creation, formatting requires write access to the image, but not
+ * necessarily to its pure storage children.  This allows creating an image on
+ * top of an existing raw storage image that is already attached to the VM.
+ */
+#define BDRV_O_NO_DATA_WRITE  0x100000
+/* Same as O_NO_DATA_WRITE, but for resizing */
+#define BDRV_O_NO_DATA_RESIZE 0x200000
+
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
 
diff --git a/block.c b/block.c
index 48a17f393c..cdfed7a4d8 100644
--- a/block.c
+++ b/block.c
@@ -2887,6 +2887,21 @@ static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
         if (perm & BLK_PERM_WRITE) {
             perm |= BLK_PERM_RESIZE;
         }
+
+        if (!(role & BDRV_CHILD_METADATA)) {
+            /*
+             * For a pure data storage child (no metadata), these flags
+             * respectively promise that
+             * - nothing will be written, and/or
+             * - it will not be resized.
+             */
+            if (flags & BDRV_O_NO_DATA_WRITE) {
+                perm &= ~BLK_PERM_WRITE;
+            }
+            if (flags & BDRV_O_NO_DATA_RESIZE) {
+                perm &= ~BLK_PERM_RESIZE;
+            }
+        }
     }
 
     if (bs->open_flags & BDRV_O_INACTIVE) {
-- 
2.52.0



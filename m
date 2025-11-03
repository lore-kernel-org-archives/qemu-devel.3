Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0A0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lJ-0000uS-Ix; Mon, 03 Nov 2025 16:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lI-0000uI-2U
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1l7-0005BA-WB
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762203995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbJvfmaLlaPCev4kAet4tVlQUBZt0s2JoPEA+6NaSU4=;
 b=fntlordftfjr/sGb9IDHd5+P9dhetLclsPv/NYJCBsgIbG1mkglCTtaF6qIHxnDKuUQnFh
 tI36qaBgRbdrMz9AJ+eKxeiMkdg8ypzYh+6HayrAeRW+vH5uwFKnzvQTGyunmpd5GJv5gI
 +cQmr9zqsoEpAOfxb5h6e1aeXV9mJjg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-E8pu72uWPWyBk5RuHuqX2A-1; Mon, 03 Nov 2025 16:06:34 -0500
X-MC-Unique: E8pu72uWPWyBk5RuHuqX2A-1
X-Mimecast-MFC-AGG-ID: E8pu72uWPWyBk5RuHuqX2A_1762203994
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87fb496e4d1so220913496d6.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203994; x=1762808794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbJvfmaLlaPCev4kAet4tVlQUBZt0s2JoPEA+6NaSU4=;
 b=KzzrkzPfyptBB9i/xy1lT3SfvKpbBkwRRvH89ZRlcILhNKu24oMZCHN5D4Jo7MISqt
 z0Hs50wO+hkpsjeiZUiCZlEMeSr3/afUyD3mMlse7SmjQmtUD1rap6IPtzz47xM3+odx
 XMTtwRsF2koSqej+KC2uHN7KhVsI3Cpsgc3YB47C2SV+Nju9QvxWssElmzPytEvd442y
 148GT/vC0qtwLTrE984Maf5uLtTx9raKrpqWoCfq1F4uq9YCjPzj5MdT/JwBs2CYbm1M
 lDWU+5govztblRb769jvA/c5HgmMxeZjIlcROjJGhtQYIyggrTSQelm4mlobXNnBChf8
 Ts+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203994; x=1762808794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbJvfmaLlaPCev4kAet4tVlQUBZt0s2JoPEA+6NaSU4=;
 b=WeLP+3BbvQJf/XCzUN2nF7Uciwj3HB8gjQ1rjy3IGBTMJUoG96YMi/qn9oOGYVAyo3
 S7yfovNOog552swmZ3x1Rw9l/tEK0hznNNoxRAJAqf2jIhBAhpM1zvr6KcK9QwDbqEOS
 rD8SdOXWQG1bw6AZgCDsgvEWzk4C/a+FgvmVZZ7MjRDa1Wpr964/AcNLgj/XjlGXi115
 gwMKR1Iyv4SyTeiEYSXHJsTqRSNLd69wsFS93JNqvKlfVprj1Z5r6cMZAkgimPJGE3dS
 jrbT5kNmWzL7a8SL6+OA+r0O5sYlxVOE4koVZrQjMKGwHfYVlOv69No+mIKVPAsE74S9
 Yblw==
X-Gm-Message-State: AOJu0YxHiOg/aVqQ+/UYQ5r7ze6kiSHRraUZNfSugX/CeGdc3LX3Dlru
 BjQZqv9LDE0XpwNmbaHg53TRJRe/tusFJrv8HWIeAeNd3hbVH/1Dprj0ivaiw3WxHh419e8XO1K
 mKFoBr/quFRWcu1YoULyRBUfvtrltqQ5xyO5SJbRXsUrBVceJa3hVxli1UuY4nMLEFUCZ1AgfsE
 TCwg/+L+QGsRWAFjxCP6ZZ7stfwKQNM0Ii00qD0g==
X-Gm-Gg: ASbGncvuPtxYXEQyagSPJPltyI4j6+0gOKbpyKOn5dwwHpO5pkICHyZzMtUOFCFvfFU
 ouKESB5QcADSSGxk9vtsm80hfCUVov/aPkbJVRgc+bmlJMrEFiMjNuppnM5AvfwhgkzUYF/UNwR
 ym8wGU5E7S2ASFly6jUQNIoSznT8zTg1Df8/BcQGGMzIGOyQlUtFp/kHWypfyYMzaze2uxiK0Rk
 /vZZkokONkZOpOXqoK9tHbyXftqk3BFJbEn2B6UVFPoXpS707R6CxjTnO1lb0pkkLr0Q9C4XIVu
 XAoJ8UUzu48zvJdfs01FQcekUv0wtBDsv5Gz9CmMu3h+R0LNTYSkrJ4yR1UhJxsi
X-Received: by 2002:a05:620a:2943:b0:8ab:7ac3:3271 with SMTP id
 af79cd13be357-8ab99a7670emr1847631685a.36.1762203993809; 
 Mon, 03 Nov 2025 13:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhdzCv54ThExEJmkv1fyxYsjPwkGj7Jkv0djglpZfIsc0M0si2narzo7GUwntgHsJl5RLGSA==
X-Received: by 2002:a05:620a:2943:b0:8ab:7ac3:3271 with SMTP id
 af79cd13be357-8ab99a7670emr1847626685a.36.1762203993312; 
 Mon, 03 Nov 2025 13:06:33 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:32 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PULL 04/36] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Date: Mon,  3 Nov 2025 16:05:53 -0500
Message-ID: <20251103210625.3689448-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marco Cavenati <Marco.Cavenati@eurecom.fr>

Enable the use of the mapped-ram migration feature with savevm/loadvm
snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
QIOChannelBlock. Implement io_preadv and io_pwritev methods to provide
positioned I/O capabilities that don't modify the channel's position
pointer.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Link: https://lore.kernel.org/r/20251010115954.1995298-2-Marco.Cavenati@eurecom.fr
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel-block.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/migration/channel-block.c b/migration/channel-block.c
index 97de5a691b..9cf383d4b5 100644
--- a/migration/channel-block.c
+++ b/migration/channel-block.c
@@ -30,6 +30,7 @@ qio_channel_block_new(BlockDriverState *bs)
     QIOChannelBlock *ioc;
 
     ioc = QIO_CHANNEL_BLOCK(object_new(TYPE_QIO_CHANNEL_BLOCK));
+    qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
 
     bdrv_ref(bs);
     ioc->bs = bs;
@@ -96,6 +97,47 @@ qio_channel_block_writev(QIOChannel *ioc,
     return qiov.size;
 }
 
+static ssize_t
+qio_channel_block_preadv(QIOChannel *ioc,
+                         const struct iovec *iov,
+                         size_t niov,
+                         off_t offset,
+                         Error **errp)
+{
+    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
+    QEMUIOVector qiov;
+    int ret;
+
+    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
+    ret = bdrv_readv_vmstate(bioc->bs, &qiov, offset);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "bdrv_readv_vmstate failed");
+        return -1;
+    }
+
+    return qiov.size;
+}
+
+static ssize_t
+qio_channel_block_pwritev(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          off_t offset,
+                          Error **errp)
+{
+    QIOChannelBlock *bioc = QIO_CHANNEL_BLOCK(ioc);
+    QEMUIOVector qiov;
+    int ret;
+
+    qemu_iovec_init_external(&qiov, (struct iovec *)iov, niov);
+    ret = bdrv_writev_vmstate(bioc->bs, &qiov, offset);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "bdrv_writev_vmstate failed");
+        return -1;
+    }
+
+    return qiov.size;
+}
 
 static int
 qio_channel_block_set_blocking(QIOChannel *ioc,
@@ -177,6 +219,8 @@ qio_channel_block_class_init(ObjectClass *klass,
     ioc_klass->io_writev = qio_channel_block_writev;
     ioc_klass->io_readv = qio_channel_block_readv;
     ioc_klass->io_set_blocking = qio_channel_block_set_blocking;
+    ioc_klass->io_preadv = qio_channel_block_preadv;
+    ioc_klass->io_pwritev = qio_channel_block_pwritev;
     ioc_klass->io_seek = qio_channel_block_seek;
     ioc_klass->io_close = qio_channel_block_close;
     ioc_klass->io_set_aio_fd_handler = qio_channel_block_set_aio_fd_handler;
-- 
2.50.1



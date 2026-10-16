Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46EDCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhCO-0001Aa-M0; Fri, 16 Oct 2026 08:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCN-00019G-Ca
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCL-0002r2-2S
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792154288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgAkLgYQ7Ca1BTa7iCbAs0dyMhrSR9GZ47HLfvAB6aA=;
 b=Mhm+HbVFhk1lqS7HDa3Ut8TTb3VhjWU/TLDtlIkaeH1P3ErRPa581S/ojUzBitG1svFWsY
 URQiDEpCuyiIkV2TBhyO7929nZ3HuV4SBdVuvybPgVzXarp+hapH1MBWru5kShnOFTHx97
 7u5N6SZdERFfcd4WiJ+DhHdVlnWTxkQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ULu9DO-0Oay6h68Zk1MSvQ-1; Fri, 16 Oct 2026 12:38:06 +0000
X-MC-Unique: ULu9DO-0Oay6h68Zk1MSvQ-1
X-Mimecast-MFC-AGG-ID: ULu9DO-0Oay6h68Zk1MSvQ_1792154286
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4887e5afd67so4952901f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792154285; x=1792759085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZgAkLgYQ7Ca1BTa7iCbAs0dyMhrSR9GZ47HLfvAB6aA=;
 b=S+uBg7T8j+REKsLCWbErgxK/8vcx21Uj0gRGj0Yt7T14LktGcS19t0M37Y/Wb3tIun
 XifWZo73wZ1uWjM60WdaoHaKXK2lBr2wobgneUThz8ewZg3rrGfiLugth/DKtGBhShJF
 XvrNVo9671vMRNixr/XE++vEwQym7JGwue4fqGJ9Nmm0F/5FsVIutTf6XoxhyqZXCqI8
 xRsK+h+tQfbJIe67iR1DYrS1YNr24Ik8E5kwnvl9i5nlU/AcdNst6t6CuLM/JFAVoKHF
 VF+/smQa9pS3ZSKHBmEVGSr9d3gmkytNFxW00uDw0HNjUivmNazW/8UqEoj9hY+7gHzt
 P+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792154285; x=1792759085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZgAkLgYQ7Ca1BTa7iCbAs0dyMhrSR9GZ47HLfvAB6aA=;
 b=Kgmx9yiGB+KrfuuZ4vAfywAU13VJyK/xuliZQ0o2zwNNm4+iZVyrZyRW8mlJnCZ7Z3
 1PuUoGdHfuQEmayBKxRG+ByPVQ04pbS9sxGPAnj4LXaLjAZ+6QElSHlKDrveQVZC6fCr
 99BGdfcOjqoV6kt3HY2BXQ2Mboe8GpwFDzIGDnUnvGCFnM1y13k0mVGcNiK+SNsMx/V1
 7FBvOAhFzvN8VYA4W+FBpxMUiXD3K+FlWnIEBvmPtK1UPSSBonTAfkZIvt31Rnu+zPN9
 yIGza8cF4zbX5IDv/4w7Tax5p4ZK2konbreRYudd/h0Khd0KFvrfaUJTxb9n7lnc+BS6
 j0NQ==
X-Gm-Message-State: AFq9FYKVqvolDStLZFKwRdZBn6hXiOFcL21ZG2yi7b73XGJecMRuT1/l
 XnvAJ0sgrJh/OrGYMaXuMF7zK4OOl2zX/BKIatxOsKdjn6ck2ZYdKHhUN7bN6+xlODFDRlsBzq6
 ywzadmrEDOVY3JnzoyL3KMlQjF28sFsFd77w77WEO3Jnv+oq/vJwVRd+c9rA8O2yOvvFJov274Y
 yLTlWsve9G6owAemh5XHo66wgvmO2fDkKIZNRvkHjn
X-Gm-Gg: AYBFou1Nf/eetpa43TrFaSr5KREX0VSbDjUXhhEAxvDAZGcJtjPrgQXpyHt0TTWnHd9
 HnPL9m76XZJ146+9ko6QjvjdEy4MzlEBrH7LAx9S84Q5qfxMEV7dtPhrUWUURowqFwpHXA88brw
 BoRQw2Plr++EfFaud1lbvfsGMTY4WQw99icmTKUS7knslDMdR3BeDS4qlDxCuxRGuEtiw6oExGl
 f7H40CJYpZgO0JxtfViUY0ypU8FVhgXbAPiv/Mf6DSV2c8hww9kgGQenCw3XXWVWt0tQ0JRz3o+
 UBHn7dfWpwx1yVpV7Qgia64i5MUIqLQUrH/dWYogCxze7XKTYBTD79mXKApmHhZ1ccwKdhyuknp
 Lfenm19vvo3LnO15jeTqgHZBwaDmWTVZxHh6/jxhIyybogFk+LJqMaIDkpuLDyCFqQB14vNo843
 FtNOBIL4BDObk1iSoXpjh+D8lSyI6GM1jf
X-Received: by 2002:a05:6000:388:b0:48d:ed0a:e064 with SMTP id
 ffacd0b85a97d-48ded0ae0b8mr17515175f8f.24.1792154285681; 
 Fri, 16 Oct 2026 05:38:05 -0700 (PDT)
X-Received: by 2002:a05:6000:388:b0:48d:ed0a:e064 with SMTP id
 ffacd0b85a97d-48ded0ae0b8mr17515111f8f.24.1792154285276; 
 Fri, 16 Oct 2026 05:38:05 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7889sm4730097f8f.24.2026.10.16.05.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 05:38:04 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v3 3/3] block/vmdk: add eos marker for stream optimized disks
Date: Fri, 16 Oct 2026 14:37:50 +0200
Message-ID: <20261016123750.94769-4-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016123750.94769-1-sraymaek@redhat.com>
References: <20261016123750.94769-1-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The end of stream marker should be at the very end of a stream optimized
disk. It consists of a regular marker struct with `val`, `size` and
`type` set to 0. It is then padded with more 0s to fill out a
sector. This effectively results in 512 zero bytes.[^1]

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
---
 block/vmdk.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index e090e122f1..b1848130a0 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -195,6 +195,13 @@ typedef struct VmdkGrainMarker {
     uint8_t  data[];
 } QEMU_PACKED VmdkGrainMarker;
 
+typedef struct EosMarker {
+   uint64_t val;
+   uint32_t size;
+   uint32_t type;
+   uint8_t pad[512 - 16];
+} QEMU_PACKED EosMarker;
+
 enum {
     MARKER_END_OF_STREAM    = 0,
     MARKER_GRAIN_TABLE      = 1,
@@ -987,12 +994,7 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
             VMDK4Header header;
             uint8_t pad[512 - 4 - sizeof(VMDK4Header)];
 
-            struct {
-                uint64_t val;
-                uint32_t size;
-                uint32_t type;
-                uint8_t pad[512 - 16];
-            } QEMU_PACKED eos_marker;
+            EosMarker eos_marker;
         } QEMU_PACKED footer;
 
         ret = bdrv_pread(file, bs->file->bs->total_sectors * 512 - 1536,
@@ -2182,23 +2184,29 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
                            QEMUIOVector *qiov)
 {
     if (bytes == 0) {
-        /* The caller will write bytes 0 to signal EOF.
-         * When receive it, we align EOF to a sector boundary. */
+        /* The caller will write bytes 0 to signal EOF. */
         BDRVVmdkState *s = bs->opaque;
-        int i, ret;
+        int ret;
         int64_t length;
+        QEMU_AUTO_VFREE EosMarker *eos_marker = NULL;
 
-        for (i = 0; i < s->num_extents; i++) {
-            length = bdrv_co_getlength(s->extents[i].file->bs);
-            if (length < 0) {
-                return length;
-            }
-            length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
-            ret = bdrv_co_truncate(s->extents[i].file, length, false,
-                                   PREALLOC_MODE_OFF, 0, NULL);
-            if (ret < 0) {
-                return ret;
-            }
+        /* Stream optimized disks should only contain a single extent. */
+        assert(s->num_extents == 1);
+
+        /*
+         * Stream optimized disks end with an EOS marker,
+         * consisting of 512 null bytes.
+         */
+        eos_marker = qemu_blockalign0(bs, sizeof(EosMarker));
+        length = bdrv_co_getlength(s->extents[0].file->bs);
+        if (length < 0) {
+            return length;
+        }
+        length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
+        ret = bdrv_co_pwrite(s->extents[0].file, length, sizeof(EosMarker),
+                             eos_marker, 0);
+        if (ret < 0) {
+            return ret;
         }
         return 0;
     }
-- 
2.55.0



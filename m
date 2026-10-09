Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36441CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF8U8-0006K3-5r; Fri, 09 Oct 2026 07:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8U5-0006JV-2Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8U3-0004KQ-Iq
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791544190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THbHmPcOnWna3rDRL3qlDBa4vGxL3Q3ZNaUJ270cj4E=;
 b=MNpT4o53B+fnrDOqzb6aMtqlQbU4Xp9h7i2RfXkk2HEYQ4RAYurbki86tB3dujOMM6VXl0
 8ke6VXoq8Cx/oQvuhYYKnd+iTSf7cNUmitqPhyOIf7G+s26ZHE4oJXR8BmPlN59anW/rT3
 rh7H7YE0UrM01D/ljPE4/Lkbsk771x4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-SDsz--VYNjaNrcLmuSUEiw-1; Fri, 9 Oct 2026 11:09:48 +0000
X-MC-Unique: SDsz--VYNjaNrcLmuSUEiw-1
X-Mimecast-MFC-AGG-ID: SDsz--VYNjaNrcLmuSUEiw_1791544188
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso63924685e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791544187; x=1792148987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=THbHmPcOnWna3rDRL3qlDBa4vGxL3Q3ZNaUJ270cj4E=;
 b=GsZl0d/CRVi67JLNwu02krc1QGbBsvEXFqUE5le6XR0f9+FCxpMEJUZGxDSqdUw2KS
 T+0Is4wEAfeFsLGXia7/EOT1T84o3euL2P5p/1fRVKvx8UrbD/ZwGkngxr84YRto/c9I
 kzxw9ipaxJ4Yoiud+rZ8riJ+xgojpIRq760MmS2CWhxCxskZCNPJaVNlwTu1ob//8O3F
 faVCDVHu15VGT3q7JERCWO1k5FPnL2DxUm086qcoMJ/UuIiZVASzBV/IC+T5FSF5ugZE
 7qdlb3ZGqowd233TBzWtMoTT8ZZDZMOfvbV/AerCs6DTtfSOdljUjFObXk8ZYUPEu5y+
 9PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791544187; x=1792148987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=THbHmPcOnWna3rDRL3qlDBa4vGxL3Q3ZNaUJ270cj4E=;
 b=iX9iOM2eyZvt77M0CTsqqjTyEOda1pH8SQ0L2EImKCMT3JaSxttd6+P9G2HEypjrip
 PkhoO5oGDQpzfvZSG6t5PCeK64/IERwufOE4ZWrrkRrSA1lQncfJaeq8oLFfZ4DlkORa
 A083Dqenhwn1Rz+kIREwZAuthKfqjWCpHsMPGRZBsuKPtROApRp3dlmcu8YxTb5v4AqJ
 qOXw/KPgCuOP2c3OMLNwHUSxSccLjfr8lfWRIe9O7oHri8vwuRR4ohEiRUrKd+nfTiPJ
 P1GXE5Q0zK1joumD9dcW9Hq25uCKdhNDMYz3UVmPENCOc7x6WB2M6R0wJyrRddsTMlWT
 onQg==
X-Gm-Message-State: AFuF++m1WjBkRkQ0YvIFbrEUiy2V1ON1jWXY8DCZhw7wDiyRq3rYJ1e0
 4jvCmTwBJfBsPv/S2r055diNZTZVa1YqzKzJJ+z/H7VzJ5+8iCh12aYixL/x636gU4R+bkq5uqM
 FStMsPM0T2lzEBSRxcfjB4LokDm75RPAE2t0YEh++cmAS6bA4YA8Sr+LYzIduPTr6oV19iLHHn8
 4VmoANK9U8rKo6tnNvMSkmNWcuzi/BQo+OLrKpTyKV
X-Gm-Gg: AYBFou3Mdn5G+K6mh0wn8xfdBdL5uzYD1oI2u/V4hwKDwQQVnurnVvijU2Dpgmn99ZN
 htmswHJ+WFVhlsUiAmiv2IJa9fJYHFbKxjLJphbqK53qwL9EwE4Rv4PZXYVs61rfotHfTlcSQf1
 g7YKfcFyzQcvkwyLJbai2d7RJKR+UqeMF+io6Pg0ebjpvvMKG4h1itI8g83riwrynuMWHL/zaVu
 JF0Exk2E/CmgXtrBTszFGEn5nBtjLag6vx0mHmIlRasZPRSl9WwteQ1PekErmFNZfEk8OIQTGnY
 /eDsMMmRMP1bb9zBE65sqK+6/P+7QXt9eZZCdpIU/oGkiyDnn2wU4JUYivasGTpDYxkxo6k+HV/
 kWvzZiD9gXV3H4B9B4Bw4dgke8bjWW9LfsOG0UW0ja+Fgyp5dB4F2/KIMCk+4X/Wck6ArA+d98h
 V/7FcUuKBsCj+Qi7ULYPtnDJEqHV2xcySI
X-Received: by 2002:a05:600c:4ec9:b0:4a1:7739:f9ab with SMTP id
 5b1f17b1804b1-4a18e4ca953mr27318385e9.20.1791544187444; 
 Fri, 09 Oct 2026 04:09:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:4a1:7739:f9ab with SMTP id
 5b1f17b1804b1-4a18e4ca953mr27318005e9.20.1791544187016; 
 Fri, 09 Oct 2026 04:09:47 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm3295680f8f.13.2026.10.09.04.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:09:46 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v2 3/3] block/vmdk: add eos marker for stream optimized disks
Date: Fri,  9 Oct 2026 13:09:05 +0200
Message-ID: <20261009110905.905070-4-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009110905.905070-1-sraymaek@redhat.com>
References: <20261009110905.905070-1-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The end of stream marker should be at the very end of a stream optimized
disk. It consists of a regular marker struct with `val`, `size` and
`type` set to 0. It is then padded with more 0s to fill out a
sector. This effectively results in 512 zero bytes.[^1]

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
---
 block/vmdk.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 68eebd4a78..4811928595 100644
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
@@ -2180,24 +2182,28 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
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
+        /* Stream optimized disks end with an EOS marker, consisting of 512 null bytes. */
+        eos_marker = qemu_blockalign0(bs, sizeof(EosMarker));
+        length = bdrv_co_getlength(s->extents[0].file->bs);
+        if (length < 0) {
+            return length;
         }
+        length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
+        ret = bdrv_co_pwrite(s->extents[0].file, length, sizeof(EosMarker),
+                             eos_marker, 0);
+        if (ret < 0) {
+            return ret;
+        }
+
         return 0;
     }
     return vmdk_co_pwritev(bs, offset, bytes, qiov, 0);
-- 
2.55.0



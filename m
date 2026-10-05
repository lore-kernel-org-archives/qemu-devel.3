Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49005CA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDk39-0006RB-7J; Mon, 05 Oct 2026 10:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xDiqZ-0001mm-Ti
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xDiqX-00066A-SS
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791207310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4FWQdbM07j/9au5SYYXb29KFoNEF+u0Wkfmi1bFWgI=;
 b=JJDmFSt/mSqbKBlu3ZFP2p4CSXGDshThlwxjd8RuQ+cexsAJPWsjzDbTNcVBZ/N24eLXNB
 xkp/sXDbOMADG6Gusx3l3Q7duQci9BN+35gHaUPimm0wl4N0HOxM2r1Ty+wDmUMaJ43GqI
 DwLaF4KYzkokOG80lB3zAXP1BmK0qhY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-hqbbA0tHO6unx02texvQ4g-1; Mon, 05 Oct 2026 09:34:03 -0400
X-MC-Unique: hqbbA0tHO6unx02texvQ4g-1
X-Mimecast-MFC-AGG-ID: hqbbA0tHO6unx02texvQ4g_1791207242
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a013ea30c0so13630955e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791207242; x=1791812042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b4FWQdbM07j/9au5SYYXb29KFoNEF+u0Wkfmi1bFWgI=;
 b=oWacmDWkES+LugHgL9QaNF9iGiRL8l1R5TKxmRb3z0Mmm1CjQLR5B3xf5TKpbznrmo
 rOENf4i976zCToyYBK9sioIjvhOffeyWd/HDjhPrNKNHeKRhmFKU7llvfntt/msV6/7w
 T9MZq7WnsHUQhToYPhKBw6l8BJ8KxFBjRDAsaNOdwVez/imkU4ZyqpqWPMAuTniAyPK6
 uvha1GMjXgtMdbfdjf7LZt4cwJK7uv6XncOlCJJYR226EQ5sk4TDMsB/DGAxR3iQhMeW
 pLTIkpfMH5IZsAPv+kr0/yyuqvZpJ4NjAbCkmtkW/TcoLjs3klGSpxBIUtS2zPyAUaRK
 /4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791207242; x=1791812042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b4FWQdbM07j/9au5SYYXb29KFoNEF+u0Wkfmi1bFWgI=;
 b=0ReiXVIoLCjcfddP3Gi18lywvK73t6JvjCBItX1qzfnmOA0ws1BzjuBFhs8q7/Z+Ho
 i0P4PNbQF2+6RXs2E6OgeFFXzwc4f1Evm/5t75pX5Wv4C4fNNdbrUuZ8PAq9U1sgFoTA
 y9HBcpoe6aLS7FN2Rflpkvmr2R//NtUvMhuedQnfqObCRmcCWtl7y8UikUb/d30xNr57
 s82HwEJOh2O5utpIxUgTlheF7TQlRXql0w4A4xWfU/vM2Q5wo2Tox4kPHduKJ/ReaZiP
 zIwafdnCdIK6TsMQKhly8HxE5+hFmRjcKIZoVzZxmY3V0WMymZZnQKC1Bze3oI5bThya
 I+2Q==
X-Gm-Message-State: AFuF++lTiVgjYy19o9AtGQidqI8Azt5B9i78zgcq9YqgDkI10C/HGCSI
 4YeIF+S4GJ+s9G5FmLY2PVXYJt6cMIBo893I6aaIs0JRpxZg7FnC9q8XFMQxnqObrES6OVlpMSI
 NOXiRiDGUQSGFjMMtGokWOKjX+exQDNeIAql0NIGLTI5/GEOUpOHQ3Cm2jEHcIFVfCZR+1/wake
 S+X8kZdN2ZtHMA0YkocG/xi6smS5rKyAQgTJiFGrc8
X-Gm-Gg: AYBFou1CznBFjwnaYdef7WFJ9GiCYO9ns1aozlJxtsHp3eYM1YWOE0VlAX+VFAf7HAX
 lXLyVb7FcDYemNm8qSyKJeql5kGuxi7Tp6rLaP97KPx3Bl5dtFNabWxu27OPPKG275HF6jC9Jb+
 Z5mVR/u2doqdrvIDYdtgABVyYS/RXR/1usynIgoLD1KWeYUu2qIYmRXeqtRzfs9NYPeSHTlLbwu
 b374ox5YwgY4EFBYqZTAJA7NO2X2YB2bcVUehu36HqcNZSPgtXfzvce5wAtVbWWjv/6RY2q369D
 eNzCOqCr5SnCBvwbOOByjZeWdfXgEjT1LiK8v/xwHTwhYs9GuWE7sEQNLXkKGBxr/UnJJ7Lcpaa
 k2ekYFvgLsNGLcd3c6fyvFCfurPwWhMUTIHTvBbcB82aSxV7nmuYR1xmeQusvBh/LhFXAYHGq+j
 oDNbx4NjbfkEJDlOq9aqLhu2MQOCDdrlSR
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id
 5b1f17b1804b1-4a0275840aamr167428655e9.13.1791207241620; 
 Mon, 05 Oct 2026 06:34:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4e50:b0:49f:faa3:3ca2 with SMTP id
 5b1f17b1804b1-4a0275840aamr167428105e9.13.1791207241076; 
 Mon, 05 Oct 2026 06:34:01 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a030326132sm279730405e9.0.2026.10.05.06.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:34:00 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH 3/3] block/vmdk: add eos marker for stream optimized disks
Date: Mon,  5 Oct 2026 15:33:16 +0200
Message-ID: <20261005133316.198087-3-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005133316.198087-1-sraymaek@redhat.com>
References: <20261005133316.198087-1-sraymaek@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Oct 2026 10:52:16 -0400
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
 block/vmdk.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 040f38cd1d..c10321146e 100644
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
@@ -2180,6 +2182,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
         BDRVVmdkState *s = bs->opaque;
         int i, ret;
         int64_t length;
+        EosMarker *eos_marker = NULL;
 
         for (i = 0; i < s->num_extents; i++) {
             length = bdrv_co_getlength(s->extents[i].file->bs);
@@ -2193,6 +2196,20 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 return ret;
             }
         }
+
+        /* Stream optimized disks end with an EOS marker, consisting of 512 null bytes. */
+        if (strcmp(s->create_type, "streamOptimized") == 0) {
+            eos_marker = g_malloc(sizeof(EosMarker));
+            memset(eos_marker, 0, sizeof(EosMarker));
+            length = bdrv_co_getlength(s->extents[s->num_extents - 1].file->bs);
+            ret = bdrv_co_pwrite(s->extents[s->num_extents - 1].file, length,
+                                 sizeof(EosMarker), eos_marker, 0);
+            g_free(eos_marker);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+
         return 0;
     }
     return vmdk_co_pwritev(bs, offset, bytes, qiov, 0);
-- 
2.55.0



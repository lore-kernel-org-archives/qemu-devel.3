Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5708C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojuc-0006PA-2u; Tue, 28 Jul 2026 11:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wojuW-0006FL-8Q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wojuT-0002wR-Ve
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785253200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dKgIX1Wog//EVWZwPllS3MiXsHvu6/rPB595bN/eOZI=;
 b=RT4MjHhyokvlndoqcZQxk6s4xFTMbn81KsGmdUpS0LhBBR+MJMYRtQ4nxRDA0iZ3qC9K4G
 fHbXV+4AADCkq5l5L+tanNi6cySdNr0Ba4lYlmZ/7AJe7tOh2Eazc6J9vnBVoqCO1y8MQK
 AiaPQP09elRpQYrJnYXqxiLCI6QtY9k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-UusUzVdtNry_ts19halrRw-1; Tue, 28 Jul 2026 11:39:58 -0400
X-MC-Unique: UusUzVdtNry_ts19halrRw-1
X-Mimecast-MFC-AGG-ID: UusUzVdtNry_ts19halrRw_1785253198
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so1687985a.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785253198; x=1785857998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dKgIX1Wog//EVWZwPllS3MiXsHvu6/rPB595bN/eOZI=;
 b=Gz7CNF8vtsFHgXOB67K0CKYBpx8scPB986NM7lXnquzCPHRm7Zd5SJMsbLHa+fikFs
 uXBNetK2vZMTBw6aCqVBkqojdLZaynlt+hm5vCBtu6Jsfa9O3rlqcyITBDWtyRcIQqzF
 9AdGSfZR1Hbwp776rBGe6bfy3Xdwg35Tsn3bFbxrSLwKHVrxshCPrBsdyoHAsVD/++pv
 7WFBDkFSRdGWxaNrjNVuF/AnMackq1u+m5qjylOrDORV2u8J1BZd8UDorMhDWyF+pPZr
 S/VVnW82X071Sjxq6BHeepzHYv4ek8ItUFfiWBKRkqY1UBx+JrLxJDOxhcH4JEeqzxW4
 kzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253198; x=1785857998;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dKgIX1Wog//EVWZwPllS3MiXsHvu6/rPB595bN/eOZI=;
 b=rVKz9F+Pv0BEYTRY8CQF1Hjuwep5GJ866NYEmmHvjYDk9I58yFZWblf85SczioztX6
 JHeST2HH9pmMMp/EsPPdcBZ9ziga45NvDSk96LM48S54VgeMWsGmROu8UWZnLNoBcZd8
 pamBLxyZeNDSf65vdNoeuguoZPaDt/YtG2k5GFw8NaGyUXOUeCmNVluHqfvC6mTS/rCa
 VPZTfOmhucBaQcp+2EopEmswJlR+bsq//4bfNhogzGlzU9a4YRcylC5S6VLv6rXSMI9N
 GYWigrmRnxIaV3xBCNIs1FprFqzHKcSS63/C0DZjAe9J1OrVYZKiCINpLmJuJxzY7sIS
 oz5g==
X-Gm-Message-State: AOJu0YweX41zAi8THbEMWSDI5tFcS98gNTvXicJCy98bSMTa5dOmIDwj
 3NHUtetCG7CQX+WyOTVH1SsC4zVDR/Cl+Zqcxbx8Rwez1gCZ+Nzy7ZgMN0AoNTWJQmAUfTB7WO4
 dsszOHVIw45ec5CnqFT2rfBDcDJqqpA4+KUIN4VgxEku/rDj8Imvf8Tk0QR+mdqWT25oYcG1TP4
 NVBYuA0pPe9TAG2sXuA4FsioLw4Gs0jl8NSeK8Gw==
X-Gm-Gg: AR+sD13Af80aju06Irk60h13AZ1Dxn+san+SiIxTGvg74rY9OqymwbIDG5FP53hCGl9
 +v0Edpghb3oqHotIiofMuNBBwWaIAx5lf5FT8LD/dSMY35vgm1x0Eu45S0cZuJfAvd/go+DHvUC
 8ujALYIw2Cf5BBLuHNuaD8os8UzO0Ud+J3cn1+etn5Cv6AFKfNPWbXvNZDYdCPnsbESdtbzNfOJ
 GkiXgYQK49hofuCvfNL7WsuaOp3XSqfW0ws6+qsVwSdUdyVJ4lZHfvo+MeLIQUeTQ8hqlGQa6Ps
 /k0sUr+5kJc7X5oBnWX7xyE9Ey6hj7PEt16elZX/zx0hjOiCEHoSfg9Co8RBHUIIWQ==
X-Received: by 2002:a05:620a:3910:b0:92b:6805:91bc with SMTP id
 af79cd13be357-9330270bd62mr323675885a.68.1785253198164; 
 Tue, 28 Jul 2026 08:39:58 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:92b:6805:91bc with SMTP id
 af79cd13be357-9330270bd62mr323668285a.68.1785253197329; 
 Tue, 28 Jul 2026 08:39:57 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de676a41sm867274085a.46.2026.07.28.08.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:39:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?=EA=B9=80=EC=8A=B9=EC=A4=91?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH] vhost/migration: Fix incorrect size used in inflight->addr in
 VMSD
Date: Tue, 28 Jul 2026 11:39:42 -0400
Message-ID: <20260728153942.1891677-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It was overlooked that VMSTATE_VBUFFER_UINT64() won't really work with an
uint64_t, as vmstate core only treats the size as 32bits, and maximum
INT32_MAX (see vmstate_size()).

Considering that we do not need real 64bits for the size, stick with the 2G
limit, converting the size field into 32bits.

Since we can't touch the wire protocol on migration from an old QEMU, we
can't directly modify the type of size to uint32_t.  Instead, we need to
introduce a temporary variable for this extremely rare issue __size_32bits
to be used only for VMSTATE_VBUFFER_UINT32().  Document it and name it
weird enough so people won't get confused on having two size variables.

Remove VMSTATE_VBUFFER_UINT64() altogether, because it was never going to
be used right.  It means QEMU will only support 2G max for VMS_VBUFFER.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
Reported-by: 김승중 <seungjung0711@gmail.com>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Fixes: 3a80ff0721 ("vhost: add vmstate for inflight region with inner buffer")
Signed-off-by: Peter Xu <peterx@redhat.com>
---

PS1: I only did smoke test as I'm not fluent with vhost inflight feature.
Please kindly try it out if possible. In general, migrations from older
QEMU should work even after applied.  One can also treat this as partly-RFC
from that.

PS2: Michael, we have just discussed what we should define as CVE for
migration, and this one shouldn't fall into CVE category, please refer to:

https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de

So I didn't yet attach CVE tag.  Please correct if I'm wrong, thanks.
---
 include/hw/virtio/vhost.h   |  5 +++++
 include/migration/vmstate.h | 10 ----------
 hw/virtio/vhost.c           | 19 ++++++++++++++-----
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 684bafcaad..1d1cc24c04 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -17,6 +17,11 @@ struct vhost_inflight {
     int fd;
     void *addr;
     uint64_t size;
+    /*
+     * This is a temporary variable only used during migration loading to
+     * satisfy VMSTATE_VBUFFER_UINT32() typing. Please use @size otherwise.
+     */
+    uint32_t __size_32bits;
     uint64_t offset;
     uint16_t queue_size;
 };
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1b7f295417..a349b2d84a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -782,16 +782,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .offset       = offsetof(_state, _field),                        \
 }
 
-#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
-    .name         = (stringify(_field)),                             \
-    .version_id   = (_version),                                      \
-    .field_exists = (_test),                                         \
-    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
-    .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
-    .offset       = offsetof(_state, _field),                        \
-}
-
 #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
                                      _test, _field_size) {           \
     .name         = (stringify(_field)),                             \
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b52..e7c570d0f5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2022,15 +2022,24 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
 static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
 {
     struct vhost_inflight *inflight = opaque;
-
     int fd = -1;
-    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
-                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
-                                  &fd, errp);
+    void *addr;
+
+    if (inflight->size > INT32_MAX) {
+        error_setg(errp, "inflight size '%"PRIu64"' exceeds "
+                   "migration limit '%"PRIu32"'", inflight->size, INT32_MAX);
+        return false;
+    }
+
+    addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
+                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                            &fd, errp);
     if (!addr) {
         return false;
     }
 
+    /* Only used in VMSTATE_VBUFFER_UINT32() */
+    inflight->__size_32bits = inflight->size;
     inflight->offset = 0;
     inflight->addr = addr;
     inflight->fd = fd;
@@ -2042,7 +2051,7 @@ const VMStateDescription vmstate_vhost_inflight_region_buffer = {
     .name = "vhost-inflight-region/buffer",
     .pre_load_errp = vhost_inflight_buffer_pre_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
+        VMSTATE_VBUFFER_UINT32(addr, struct vhost_inflight, 0, NULL, __size_32bits),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF9DC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrg-0008WP-Cm; Mon, 27 Jul 2026 15:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrZ-0008Vm-LC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrY-0000Ky-1d
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gLoWFknB1MQPf833VKaVMeYT284G3Gy3H1HalWnTKlw=;
 b=i+jDlNaIwCmxiFjmdYmaEMNMrZXp+ap6Q3uaqZJjDbZjP31JRedYFUUBY9L+tdiay3s+4N
 JsRPfYBUrqFz4+kkU+irLYnedDzt/KhSV5Dg6pvdAzKNySKZnYDbOq2HINFxsHDasJk/pd
 1vxqSVLYqExsIIIf8rwcwOHGy80XSc8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-FXXw_jzTPWy1aXOHpckbTQ-1; Mon, 27 Jul 2026 15:19:41 -0400
X-MC-Unique: FXXw_jzTPWy1aXOHpckbTQ-1
X-Mimecast-MFC-AGG-ID: FXXw_jzTPWy1aXOHpckbTQ_1785179981
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f84ac1990so1980069f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179980; x=1785784780; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gLoWFknB1MQPf833VKaVMeYT284G3Gy3H1HalWnTKlw=;
 b=OGLrFUF++/84pDl2G6IFU2+9NiIt8yFP+Rf9E9QR2n8eN1tmn1dthjLF8BFxp2ptWj
 jzA0c+bS+uuRb6+faY0a4AQPcRMmhFaNxZWFUSQV151Qt8LY4dYrvK0dH4yN/oy/CKRb
 20gLoShEmgo/s9FgcvYG+NuOtGYcCizuX18Yslnbxe7Zn/d4lJmAcJS7jBSBEUPjjYn9
 wGl/S9mFxXEjPoNe+MVwkILehsJ//sFyLLj93xwhEleD8ZdkwVhLGKg0Bpp5UbaKzYkU
 EYBdRu45IsvOz2UN77CLaYS7NYjFNfCAPrn12yfiBPV1Ko7FuW5auECuamTmtz7N+Paj
 /v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179980; x=1785784780;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gLoWFknB1MQPf833VKaVMeYT284G3Gy3H1HalWnTKlw=;
 b=gLxa4x6+IOY5rRXVd0uDfMonkU+JxHh0zkzlBLB2y1AOtiJzOPQU1ShDyLNCVxuQEe
 B2Rb+T25+wyb0Ak83VFMMS2Zw3qEavla2FLpmTfMyoMY2wFHAusxiMNcgHuGFUEs1Y6e
 IQxrsT0lH5baIUlAuTabHsalA1Bk2uMdkXP5yaxJG5vpeqnm2zMJfBbAtVO3KPtD51TL
 jRVICKjquezerWfowRZTyAFwFQaba2jrDA0fLr/XZ7eIRwdaM1t0MfxUXlmCTKdC4sWP
 I3EXro9dKgfYupk3ZdqMmWGEz+fa1GVsrhOYm5f16an0UnQN9ydnb4ynHBzypyJP3IIV
 c7Dw==
X-Gm-Message-State: AOJu0Yyyvy20xutwjX90y77JEwH/Kh/WwCQ6u8fQQLDVrx7ndbA4JzP5
 tqQStZUDbgOsIe/Lv/ShSbbMXYp6xzN9QKb5tLoiFr10GNMWRJjG10WkfHr/nMxudJXUcEXIBXy
 JulYp0Pb30aOqgKPKuyILQjzhOlLGbjsLGE8WQukzmhi2kUVZi6zx+PhlRw8ENX0h5wR5RA1LjM
 gxS3ZqWWOSMD+Z1fjg0iIKlpsFvKSXSkgl0g==
X-Gm-Gg: AR+sD13ho/QCTzK/SLuDUMHyEC+pOy4jgK3E6OuFM3sxY0OGbSGizRAhW2KLlBCaM8B
 0w47FNWwtjMbyo6ba/AopMXM33ceXLqAk7WiZKhlsx2BdQpQ7DfIXEGfk2ONCdb+JJaH+1lT+B+
 kSP5wadVFTG3X+UjL8ddHtVJ1Q4ScF7e9CJCZu1Nc5uqs4RvGjGoc5xBo2ObcH7i2NDjd5S4fZx
 YL2mNB+Wwip+SfZDWLAoP+uAJi1bSPSEeK2pD/Yym/kAjxSbGnhKXyT5ze2xLP8DPNLjclwbNBL
 V/AL5lkVfyg4PEmhxltmUzNMTB48/z++OeskgJn5hbLfjr6MhRXNJQZFic+eyGuNLk/PxJ/kGOi
 ROn1lYB9ZA5lq7jwBsHKP5w==
X-Received: by 2002:a05:6000:230b:b0:475:f0f0:9ec9 with SMTP id
 ffacd0b85a97d-47f9feb0549mr14024571f8f.52.1785179980495; 
 Mon, 27 Jul 2026 12:19:40 -0700 (PDT)
X-Received: by 2002:a05:6000:230b:b0:475:f0f0:9ec9 with SMTP id
 ffacd0b85a97d-47f9feb0549mr14024542f8f.52.1785179980010; 
 Mon, 27 Jul 2026 12:19:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm50027694f8f.33.2026.07.27.12.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:39 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, huntr bubble <bubblehuntr@gmail.com>
Subject: [PULL v2 01/30] virtio: use masked features with set_features_ex
Message-ID: <a6e0519ea8ed6fc84fab9bf9ca82c7a55780f880.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

virtio_set_features_nocheck() calls set_features_ex
with guest-supplied feature bits, without masking the value
with host features (unlike set_features which gets the
correct val & host_features).

This does not matter if the driver matches spec, but drivers
can be malicious or buggy and set bit outside the host mask.

Devices don't expect this, so unsupported guest feature bits getting set
can break the host. In virtio-net, this can enable RSC without vnet
header support and cause out-of-bounds reads from short packets.

Pass the masked features to set_features_ex, consistent with set_features.

Fixes: CVE-2026-63321
Fixes: 64a6a336f4 ("virtio: add support for negotiating extended features")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <dfd27c9b26e442a2076f6ddc9bb3d38363d9b2da.1784891251.git.mst@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a3655..7c19080db5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3320,7 +3320,7 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
     virtio_features_and(tmp, val, vdev->host_features_ex);
 
     if (k->set_features_ex) {
-        k->set_features_ex(vdev, val);
+        k->set_features_ex(vdev, tmp);
     } else if (k->set_features) {
         bad = bad || virtio_features_use_ex(tmp);
         k->set_features(vdev, tmp[0]);
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FFAC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnIEM-0005Yq-DC; Fri, 24 Jul 2026 11:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnIEH-0005Xt-9s
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnIEF-00053Q-49
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784908464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpBLduXIbVgc1kr/XPshxc9Bgw6om1b+VeMiROGQBGk=;
 b=Hv4+4TciUXqdrIMwhyS0uErPFTjY3ual2chlICsiveL970PZ16W7kBtO7qjOEBDszf/0Bb
 pu80TVU7pzO1FBv8uOjHBXa5vaHoaXS5SsUavRy27BuVdLzD5I+WaEZecRm7Ap90MxVU6v
 xFxURkTDaRoQgUxEHF4BN+yc6Vee16w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-la054TKyP66_Xx1oPvo55w-1; Fri, 24 Jul 2026 11:23:26 -0400
X-MC-Unique: la054TKyP66_Xx1oPvo55w-1
X-Mimecast-MFC-AGG-ID: la054TKyP66_Xx1oPvo55w_1784906605
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955edc851aso3736115e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906605; x=1785511405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rpBLduXIbVgc1kr/XPshxc9Bgw6om1b+VeMiROGQBGk=;
 b=nDH2RMN15uglLtNwbmecnRD3o9ZcLXknrv6zAxuHCa9LhI0Z3C6GDFjhksY8XyOvX7
 NynyudUt4CE1NRJify4bv9bT5R6oHnJclUPQZokaEN70H5TT/MyTCbrnudDzCClsswcE
 rJCn2nz2zrOSjJvpN1yNBFAhrBasBGh9ruTlZ6sL0R8+aXELQZuZtIohY4/fp65E/WcY
 GjTIheJ0U3TTDZZfAjnw5Kp9hzR/6x0Pb910VI42TJ046G96PryMEeJ6d6BQuNN9oywl
 SDgndXz58wzcW3poqjeTcZd88YXloryUAFRscQDdnwTiW+P36FpR6VymE+BsbZUAta4G
 c9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906605; x=1785511405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rpBLduXIbVgc1kr/XPshxc9Bgw6om1b+VeMiROGQBGk=;
 b=Y3zEQPyPcSHM7FhJJmpDM8IrsxNxMVyN4pvFgy79/HOdSlby0ABaVMlQji9whZF+qS
 9C3st1U7UCPrB0xbnMbz3sB/u9Gjg+ATyppF+Pk0mDBEoeHW70vJm6yBFkF+PBIeDJ8C
 Q7xQdam4aRfuVcYRzysNaQCq2CxbAXdiEyUac/6toHrlSaZFsrf4T3ToKrnW1iZ5kSpr
 HQjOLv8I2dOvk43cA9oGL5jbNLUDgtZUP/boUAO283UNy9aBVG3ElYz8aaACUsJjAkDi
 BVlwTZZgSX2a50YLwVQRc/mzyyytmvPrkmvY1mSMAXq24i/ibcMi9y4F5f2qP6M6BEMj
 BANA==
X-Gm-Message-State: AOJu0YyR486ZEZ6PlOUcXoffXhLqzJFntmRQPlajwOCnzE2EuBEAgxrJ
 RWjeS4/IW82KpjkdISapgh+YIcCAgNEhJg6rlLKvfB6evJ1l0BQp+pqj/ZeIBMkguflquAo25B3
 DA2EWKhMP8tSV6LtdP1fVkmBzY/nR6Bj+Cio85l1aNLZIBa/icMQ2ndcWSEGMVPwU
X-Gm-Gg: AR+sD12ObpKvSfjg0wm+qlusIZ1lXpjBXCPuQv6Hgc3sw/2Do1dRY+T3TuWwl5sImbP
 wXvIpvDuQNcGMl2XDujyDy4cF4AfEeGZnBDzEd6GkWEsiWiWS2vwYlXtn/v0sOJqUNz1AdGQSVq
 vnfKhiuQqArjlXt9LOdMpofQ+IGsDdpxZvbDesUBD/grLoSK4uE7FdQp3n8Paau9Zpv2GyjY+48
 338kxR5mC5uyAA5ELUrcmR5i/BXpUUY7FoLT3D/Lm1pgzmZBuwZBF3DlJknjzSgzWVpc3jmz8ed
 QrBBtDvydN4WFpB8jzV9Stogl7qaTfl5AVVi5a1BhQqCGY1K3a2XHLxBer3VdGXTnpc64Y8Gl9W
 kC2lrKhQk5OIR8w6S1rJuxVtyqMK7aj7Xs71QXWxxV9gBYSfv/4NfK7WkmCE=
X-Received: by 2002:a05:600c:3107:b0:495:6338:1453 with SMTP id
 5b1f17b1804b1-49573ca9945mr83365595e9.16.1784906605124; 
 Fri, 24 Jul 2026 08:23:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3107:b0:495:6338:1453 with SMTP id
 5b1f17b1804b1-49573ca9945mr83365335e9.16.1784906604792; 
 Fri, 24 Jul 2026 08:23:24 -0700 (PDT)
Received: from localhost
 (p200300cfd7075d8bc03b74903e90fa9c.dip0.t-ipconnect.de.
 [2003:cf:d707:5d8b:c03b:7490:3e90:fa9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a6d7sm26167782f8f.2.2026.07.24.08.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:23:24 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 2/6] hw/virtio-blk: Complete zone-append cookies
Date: Fri, 24 Jul 2026 17:23:11 +0200
Message-ID: <20260724152315.234183-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724152315.234183-1-hreitz@redhat.com>
References: <20260724152315.234183-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

virtio_blk_handle_zone_append() starts accounting via
block_acct_start(), but this is actually never completed.  Do so.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/block/virtio-blk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 56bfe1840c4..384a5ee3f1c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -755,7 +755,8 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
 {
     ZoneCmdData *data = opaque;
     VirtIOBlockReq *req = data->req;
-    VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
+    VirtIOBlock *s = req->dev;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
     int64_t append_sector, n;
     uint8_t err_status = VIRTIO_BLK_S_OK;
 
@@ -778,6 +779,11 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
 
 out:
     virtio_blk_req_complete(req, err_status);
+    if (err_status == VIRTIO_BLK_S_OK) {
+        block_acct_done(blk_get_stats(s->blk), &req->acct);
+    } else {
+        block_acct_failed(blk_get_stats(s->blk), &req->acct);
+    }
     g_free(req);
     g_free(data);
 }
-- 
2.55.0



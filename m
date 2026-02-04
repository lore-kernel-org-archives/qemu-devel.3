Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7AFEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAy-0002Xu-4J; Wed, 04 Feb 2026 14:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAs-0002Cf-Q1
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAr-00088n-4a
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvGS5jk5i1GJ7axRKGKJTx5StEXiwhAEatUhAVxCO/0=;
 b=NL/D7dh3FEnle5YlMlGnhrxekQnsYxJwb6KU+tF+Gfh6b6nDKEAK6JEBHLoYOQ3We7elAF
 IjbmBnOY0Y5zRyWqwqL/k+Wa2XDbU9Z1WFGeRc0WH5QtMy14ucxOb1DdZ3UwbgJAeEXvmC
 WOvF6OaHbvGsuoSK0v4cFyhoRmbB2oI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Q70X_FuKMhqNCWdYzpE-Bw-1; Wed, 04 Feb 2026 14:04:21 -0500
X-MC-Unique: Q70X_FuKMhqNCWdYzpE-Bw-1
X-Mimecast-MFC-AGG-ID: Q70X_FuKMhqNCWdYzpE-Bw_1770231859
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so1256375e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231859; x=1770836659; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hvGS5jk5i1GJ7axRKGKJTx5StEXiwhAEatUhAVxCO/0=;
 b=lh506so174ZITDzfUiX+TQ9gp8cELGNi1SRmakkwkkEe1rF0NHb+5fYtlOWoML7GSp
 5P+6hIC1fur1bLezq2NvbPMCP6zMNN7KjZS1OM5y8j9IdtRBhvm7xZ2KEk2eOkwaQGhr
 ydIcZ6CsNbO3J9o4wXSFu5uTz57Qv+hBeNhx2Ar3g2cKNAA7ZTUnm7PT5lfDTxcGYIcz
 ZUNfhqRUFPvpLsbWfNygUmdg+7reFKAPTC5mGgF/T7l4Zvl5w8UsIhisMt+0pL3zV9Ww
 M6Z/NyL7zbjuWwaNqWfw1dKx53bIgyiYR+tOR8EUP7I0gs8gV5IXMShf3Kmup0oX8L59
 D5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231859; x=1770836659;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvGS5jk5i1GJ7axRKGKJTx5StEXiwhAEatUhAVxCO/0=;
 b=iqXJk3tSTy+YA1OfuZ3ZlogA8xBdThvUSoIfR6Au3028iXweyc0fylPuiwtpQvmotc
 TYEjOJk47X3SfecHXRmhCOgO84rNqUUJdOgsX/AECZ35IaEcwTGypRe+xu8LYz6LvC7d
 4wze81prtTki7GwDjnjroNkSRO9geoG0sUhRhpO6pBF1n350p02gK8d/9tSFv7LKAPrs
 9JN9cfksYiJrpUcNILEEj1QvDoug2jWXTpU5VhHzkwYqdufIBpOb95Fm33Peb12kbZBg
 9JtBphgpTBS4xOy0+tx+O6Q5JPT/b92LATvkPq+4at3wkvj+tlG95LRTYhfDqWEvTyPa
 Iycg==
X-Gm-Message-State: AOJu0YxxgDXKHByL93swp+ZMS6A/Ncsw/rBX8DcL7/z42YdQKuut+7WN
 wCBWCIquwa5unJ5J2OHxjmVvgJnprvoHvLEDItbbNt3lGE692U0wvggPeIoDjy9hpZjSppdnB9G
 thXV+mpHhKqTeifKImWUJ6x4eNMmCoxk01CYOyqftxKw/RMPYKR5Jlbulf4cfvQMavOKAB8kUzb
 Xt7cCZX0Y4TqZYejBMEsMFCvkrjK5Nnwslxw==
X-Gm-Gg: AZuq6aKz9xf3quGMLBNUiAa3ELQ9lo7I30Ylce42TvKcCwURSERZ+wHJATDVjv/Vuca
 ZxXE0dWQ5lCMSzou6DQ7zEOLocPX410E5rvdnyXQhXoelv8jY6esG+NzTWtd846DyMaRpDnbWdQ
 Kpch/Xq2gtm7lmyUTxUjz68hWRBBbnrzD7gUadw+0kqi4AwphR1W6P8/PtoDcCG1o/R+Mz973u4
 uZzfcjwbYQHDuEqVjNwj2O7MbfvF1OnIU/4HxTzpBzpt5qHP6uzW52imHv4H4be67GJ1UWuUeKx
 NmO03e8qaDKym9Mbc+EAZPO7pvswJKLFDc1DGRI6Y0411WXaTzryskq39EXbmI1IyzgjERp353P
 eWpDJW+QgWRwtgcUIIn4KtR7rM64563x9ww==
X-Received: by 2002:a05:600c:1d99:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-4830e9344dcmr59654965e9.13.1770231859025; 
 Wed, 04 Feb 2026 11:04:19 -0800 (PST)
X-Received: by 2002:a05:600c:1d99:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-4830e9344dcmr59654255e9.13.1770231858559; 
 Wed, 04 Feb 2026 11:04:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38e38sm8598634f8f.11.2026.02.04.11.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:18 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhenwei pi <pizhenwei@tensorfer.com>,
 =?utf-8?B?7J207J6s7JiB?= <nakamurajames123@gmail.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 38/51] hw/virtio/virtio-crypto: verify asym request size
Message-ID: <d1d0b971a1f9cd4bbd1ebd710f70002846294de1.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: zhenwei pi <pizhenwei@tensorfer.com>

The total lenght of request is limited by cryptodev config, verify it
to avoid unexpected request from guest.

Fixes: CVE-2025-14876
Fixes: 0e660a6f90a ("crypto: Introduce RSA algorithm")
Reported-by: 이재영 <nakamurajames123@gmail.com>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251221024321.143196-2-zhenwei.pi@linux.dev>
---
 hw/virtio/virtio-crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index cbd1810fbc..6fceb39681 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -767,11 +767,18 @@ virtio_crypto_handle_asym_req(VirtIOCrypto *vcrypto,
     uint32_t len;
     uint8_t *src = NULL;
     uint8_t *dst = NULL;
+    uint64_t max_len;
 
     asym_op_info = g_new0(CryptoDevBackendAsymOpInfo, 1);
     src_len = ldl_le_p(&req->para.src_data_len);
     dst_len = ldl_le_p(&req->para.dst_data_len);
 
+    max_len = (uint64_t)src_len + dst_len;
+    if (unlikely(max_len > vcrypto->conf.max_size)) {
+        virtio_error(vdev, "virtio-crypto asym request is too large");
+        goto err;
+    }
+
     if (src_len > 0) {
         src = g_malloc0(src_len);
         len = iov_to_buf(iov, out_num, 0, src, src_len);
-- 
MST



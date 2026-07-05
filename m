Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0F9C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNy6-0001Ej-J1; Sun, 05 Jul 2026 10:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxJ-0008WT-KR
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxI-0001WN-7x
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VL9SVSCLPpegZXGAsK+ObdkDF+yta4rye0Ei4JYBCYs=;
 b=Gh3H1mWOzcAe5QQatuApA8BrtlSNEffCKliA/OVQdtWsF+jsHLXAVDjc1dggKxOd9PDC8Z
 9XOU4m3QnfFoC33pk/0b6ziA3niwBIX/3/QS6teuLrcHfTPw7NNbPJgd1cZwaN6jpG+5jv
 Ph0Igy4PRSqknkPpDJ0qhEa/U7iZJJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-4jSWvkP9Otqv-u81YvYtfg-1; Sun, 05 Jul 2026 10:36:22 -0400
X-MC-Unique: 4jSWvkP9Otqv-u81YvYtfg-1
X-Mimecast-MFC-AGG-ID: 4jSWvkP9Otqv-u81YvYtfg_1783262181
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493ba771d1bso17680495e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262181; x=1783866981; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VL9SVSCLPpegZXGAsK+ObdkDF+yta4rye0Ei4JYBCYs=;
 b=kn5CRCC5UhZ0RHq9TbiwiTfWVqrPWU2MRtWy+cqS1JyQgCS0MHkYqsLJaD/b7PNsIh
 AZE2qF8gBCP1uYkSI4ySymuDNv3V9N1CYrXkIWonZNrCv3sPJvcPiqk4Za+Jw3ezHWPV
 +XfXRFAUHUFwGCyS5frJ6ss23aomvAWgnFTpnmWhepg4bBdoyz6ApBq33hIbeiGe8/kR
 v9WoMvfE3GqGVer9ENd+ZhRuRl+ovvY0YvasJo9xKiezBZPRu4NZr/T8WMpkYMvM/159
 jr5UEyse9tHYBvsB/IneTBEBe1Oz4Cy/hhnruiY2ixAZgADxGBMrBu+cDo5P8z+za6hQ
 74ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262181; x=1783866981;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VL9SVSCLPpegZXGAsK+ObdkDF+yta4rye0Ei4JYBCYs=;
 b=QZcBNSjluq0fWSwtFEYQSIS+PlpVQczfk+svJ4JhYVXo+XdL8Aa03otrtCrS8T4z+m
 Zxiu35KPplmLZ8D1jufleKb2NTHRA+aK/tDqcYwgEVH5CCcpGKvyqgO/cSLX5HwIKDpo
 8mXRC5Cy2XZTXs4+AT3XwB4MfX+SHnmuHbAmEfgY8cf2Qdv4k4azCaFgMvf8QsIObVa6
 LTE5nOs/cs1wActFQajfJNVCW67xi68T/sR7L2ZHx5iJrsC29G908zESjodaABl08RN7
 qJe8EM435K8/dhxcg1jcqdWPxm9kyK2CwbM73HDPJqLCNoVQfehTxCtaQ2NwisWIGOcI
 YbxQ==
X-Gm-Message-State: AOJu0YzkOgTn+NokSKae+nd7H9UQ1IM2i5cHBKeK8TCO3pna20hSyVE0
 A8wjNgGaFPozB/41G3duW5z7+IzCbTWn657+/Zw4IUQx2mMDb1mNI2KE5GRQWm5Fd3hSMct8y0X
 aoC0LYOHCfLubJkp2jW8+1SHLXH4d9/3h6tdQ2PgH3Y4/HAAApDCfJDJf8MP4GnvTxzv9nbvNLU
 FJe0j4dtfk9RzR+E3GcNg/rmRxirqxmyna9A==
X-Gm-Gg: AfdE7cn45Q11XPoCNkWf5swoueQzR/Ol0CHrvgXqJPlNfgFN3IjT2dQ8Pas1pBhXXmf
 jx3zUg7nn+tR7aKwj7JdGuMQ7+ik3nkUVCV4OD2tNtCCsUHlf4IR7wB+Bc1Z5MkPO6MKz+MUjVL
 GRsdrIJwYVhr4kApzcVtY8EcczjIvn9z90DJd6tKT/tpNGM2SXg+Fxu+SCJn9x6veAO0pVK8C6p
 IZwTuD9yB8ctWj41k9o8afvGSmgbveNRQGA/eS5dtiDuLm8VHFX5eLHM1cho6o+ev7FNV3nkw2g
 4Oz4+OoUyOPOPXe/oL8FMQde8fWmHUvpD/15V++m5YojwQavgIIy8RDEKR9lG2D/j3rjfTJDaSQ
 S1PKmWUFp9H76dVJpsow5ynUctYC5di+Z
X-Received: by 2002:a05:600c:a00f:b0:490:e913:656a with SMTP id
 5b1f17b1804b1-493d11fa971mr77581015e9.27.1783262181169; 
 Sun, 05 Jul 2026 07:36:21 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:490:e913:656a with SMTP id
 5b1f17b1804b1-493d11fa971mr77580615e9.27.1783262180687; 
 Sun, 05 Jul 2026 07:36:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cfb6f199sm182315125e9.3.2026.07.05.07.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:20 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, helei <lhestz@163.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 41/44] hw/virtio-crypto: enforce max akcipher key length
Message-ID: <a2134e938a0c43d2f06f04689c59de4052d0b986.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: helei <lhestz@163.com>

enforce the global max_size boundary for akcipher session creation

Signed-off-by: helei <lhestz@163.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260616123251.26446-2-lhestz@163.com>
---
 hw/virtio/virtio-crypto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 6fceb39681..79e2acb56c 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -216,6 +216,12 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
+    if (unlikely(keylen > vcrypto->conf.max_size)) {
+        error_report("virtio-crypto length of akcipher key is too large: %u",
+                     keylen);
+        return -VIRTIO_CRYPTO_ERR;
+    }
+
     if (keylen) {
         asym_info->key = g_malloc(keylen);
         if (iov_to_buf(iov, out_num, 0, asym_info->key, keylen) != keylen) {
-- 
MST



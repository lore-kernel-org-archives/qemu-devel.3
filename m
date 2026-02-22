Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F375FC6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASn-0000PL-6m; Sun, 22 Feb 2026 09:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASS-0008Di-Hc
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASP-0006qB-U6
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4A1n1SInCCQTIrX/1lNM4s5moTtIwvB3Wd7tcemWs8A=;
 b=CiifNsGi1Y+wDk9kCugiXbi8fsXvIwVR6QFOplLrNYJWMlYC1TG0Cle/e57azI1HHkb71x
 gQLPD+Q4wuloUoJCOkEdKCY4pmwFYcRPT2QobD41L9E0WHjfT2rTSCzdtuaYJBlI3X1q0W
 ARRZawRv41BCZubpRhK69IZw8l/lZEw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-mnHjmuMZMF608PiUHwEUkQ-1; Sun, 22 Feb 2026 09:29:11 -0500
X-MC-Unique: mnHjmuMZMF608PiUHwEUkQ-1
X-Mimecast-MFC-AGG-ID: mnHjmuMZMF608PiUHwEUkQ_1771770550
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43964455342so1755566f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770550; x=1772375350; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4A1n1SInCCQTIrX/1lNM4s5moTtIwvB3Wd7tcemWs8A=;
 b=nysDU9bfwvPDK9UyYy6Nn9PEMbKVKawe5TXJjIxL9w4s246RrBelaVXJdFIFlpp61G
 NekKc1fgR1KCl3Nvvt0UqJ4C/5lD6O6btepHpKLWPeNkk4awsWEIbWYvxcHtqUjrc031
 kSDnCUdbDyuLvfZJza+EB2/Iv5pbd0wMUxvL9GHQ0HTONHUw1FHOrgmVS3hjGIP68qx5
 4CPCvdJeTNx1An0oEnDid3DjlXz80leAmVDhZUKlqm59eIuL1EJSfwwWOxKewYH1NRth
 H6ogCd7wljJdj4tvmSHbh1Wqpom+rf8IRrP/TUzf8ADmq7VNuCeBiHt3Jrw3JbCvPAHF
 idTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770550; x=1772375350;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4A1n1SInCCQTIrX/1lNM4s5moTtIwvB3Wd7tcemWs8A=;
 b=e3gj6lWV8+OOa/YCYXYuglnjkgdLo4AcT1c2mlztG77WBD9RJA3qi62TpiX1/8YzEM
 EO/XV5lDPm2j6hOcfoyXC1Kif+lNjRQhGeOp3DQVopjzJR18jGhNtlnLshZ4qOrSR4ps
 iGzoYgrW0cXoUj4JJSyxKPT9y2eV7q50S1RThMxMiD5n2IuxYtieeLOwYhRs8BDrRa1M
 NP8/Q02kx0BIoBYQMCt1isSuMu2pAiTfoDOJLvEx76itq55OZCj9TMjVxi3WoHt8oc6f
 ze+a79zwZPg+HuV/bHT+6geuu2YqQ+0I0IGH3zeFAPdt01uVrB1xiW65pg/3IcdeNGpW
 ZB9g==
X-Gm-Message-State: AOJu0YwhL09Aks38l+uhCiOaJvf/U3jPEFh7ho87+cePeJ8JM2m3z9Hs
 +4oeDnRzeVjBv/BC2eOpICRroDrdbZYj6Vd5JJrEjNYY4IIcEqX1QcPZA1nLeyUpjc6m1SWfM22
 bNdyed3y4SzrTbiaZq1h20hPIvPoz3L8o8bx0P3MxLFFmNSf+PDJgV81V43We4tyhlw20EkVVs9
 lcP4ID/h2j3UPsvIwIHBkrGCDNlAnRuz90fA==
X-Gm-Gg: AZuq6aL4gHhj5nHYXLwQFtZiLYqyJiKeRLy7diGj14qgvZRy6gK+Od2O2U4K0/Miwoc
 B+MX4pORQtARWqF0ucS/FqO59YOVOjKKPa1vIPm6sQSq2xRu8rMMVnNejscBd5S0YBtVz41Fnk3
 vikyUezPczVNgIEPkX/TNeWe5ZWYkBxYIJ0/ZUyBFOf7j3hZFIPUEnr91S/qBwF01aoBK2Iq9o9
 WOMJtT16FYL6ZuQ62bwoWzUgYNKwD0xrslWuXbxCKDVf9eiRkvi0LK0cU638S1dlPCfVumXotuN
 Bmf0N9gKxRnHQjmSCg201kPMdLd7hOs82HAm1n9XwlWbCDHUAfvvnsORk269h6mlqnp6Kjlkdfu
 Co9XCwmfAISCIT5su19LA4tByvcaevX7dayuWI+MWuDrE3A==
X-Received: by 2002:a05:6000:2c08:b0:437:6963:a10e with SMTP id
 ffacd0b85a97d-4396ffde572mr10374499f8f.23.1771770550017; 
 Sun, 22 Feb 2026 06:29:10 -0800 (PST)
X-Received: by 2002:a05:6000:2c08:b0:437:6963:a10e with SMTP id
 ffacd0b85a97d-4396ffde572mr10374457f8f.23.1771770549475; 
 Sun, 22 Feb 2026 06:29:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c60bsm11915907f8f.27.2026.02.22.06.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:09 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 22/33] net/vhost-vdpa: Whitelist virtio-net GSO for shadow
 virtqueue
Message-ID: <25730acda4ada4f136e04b246b31dd54d3bb54b1.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

Even if it is deprecated by the VirtIO standard it does not affect the
layout of the queue, or introduces new operations. So Shadow Virtqueue
can handle it just fine.

Tested with OVS DPDK and VDUSE.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260206144717.730799-1-eperezma@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index f4b1f0e9e0..3df6091274 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -116,6 +116,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
+    BIT_ULL(VIRTIO_NET_F_GSO) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A33CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6W9-0002Hy-EJ; Sun, 09 Nov 2025 09:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W6-0002G1-Mu
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W5-0001pG-AV
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ONThtaYMpfEDNo4b/8/a5deM0gkmLYr9IT8+NA0OabQ=;
 b=FToP/BR2gUjCJmXMFtIHdCPfPYNXbm/9G5vLa6JqgOI/xKGSJ1zt4n8oHHgvRpwBA503tb
 MLudtbYe7CD5G/K0hgmf8vf+Upl3segDDl3rbkzKSP32uxuFY5mwN9AjtP4r1PZa9Tiibm
 0TX+Ug+SDD3HEfMFAa0Zqlgh2ywimWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-reD1SJ-WPe-MHx8LEgprMA-1; Sun, 09 Nov 2025 09:35:39 -0500
X-MC-Unique: reD1SJ-WPe-MHx8LEgprMA-1
X-Mimecast-MFC-AGG-ID: reD1SJ-WPe-MHx8LEgprMA_1762698938
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47777158a85so10901395e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698938; x=1763303738; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ONThtaYMpfEDNo4b/8/a5deM0gkmLYr9IT8+NA0OabQ=;
 b=izXf7Fel77FTb4akKgiYqPzo67vBQ5NU50bkmCpLwfojDjusWvb2uQtzfhI2baohv3
 SgMNIuDu9nxQJaspcBn8XJKEL/YkHHwC30zR+NFwIgylZgnpb6IkbpnvFUoLLRTtEjQ6
 lAOK2BZgHu4Qp3L2fIVJCHqtr5uPmqSMLsIRsy3C+jqYA5lkmO2IEeM6wJYwz+Tp4azC
 Gl2pSn3pJLtNmltPO7G5rz9796m5GUaMdKGnfa+evjz99NxtZ6daoZirWlVFfMof02hE
 +ZpjewWiKgBg1zwJ1G7KD0xJK2NJeW2vLR60woTD1tbLwW9ih7wY3H7PvjdVYSkqmCyT
 PCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698938; x=1763303738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONThtaYMpfEDNo4b/8/a5deM0gkmLYr9IT8+NA0OabQ=;
 b=pBotKNii5BBq4neDFlYDkN23D02NjowcbgIC5SYIbtJO+JEElo+7LzFUyPGlhC4bPE
 qTVKTGkC5tRiHcdW+NH/zDI4AGmFaCh0yLFIWhvIYNC3uxrW95Xih/4UbRJKENHoUk0f
 q5mytUIFzxpEqp7c3Dp9ndnejvrDyVVvSsL8zM0nNv4lCycUgj1+RuMQlTaPeYIcQDZG
 LY6OwXcIHD+U4h1S/nQpI4pcmElzbClJiTcyVTDXWpZVM18VyNe0B/U5HBeHAadkxuPc
 AtJ3hUJ6JQKNcv0azKwdGkhRZ5isVOAbcikuz81LCFARROt47I3jX/9hqs8SWo6fHGpd
 cHzA==
X-Gm-Message-State: AOJu0YxJr1tVoMbFQAR/iMdLI7EaDpNJ4EVwzEQRmQ9Q5fn4t0KzMs+F
 EdxlsfmPlcYebuLZlseDWTmDKbXL87sIfcyv97NhTHh0ygVMN307qLtyJpzMvD10i/0YRo1Tr2L
 EWJgWxllPFaePdH9JLIZE2ZPVL9nfFiHduLvdrvQ93TWxVR4Ed1CzjeLxaNFAAOfX6y00G3L2nj
 KLJNM4ogdj/q+ufeAX7YuPggCY9uiy4a5ZwA==
X-Gm-Gg: ASbGncsA2ksoC2Ss6XyM34Yw2jl3zqZl182y83NYPwIyIOz+Lb7TX8s4LnhVtravhet
 3OW05DG5mmEY2qxH+qJrZBZmMG5jJPn3Celp5APpcbfrNHQTzqZPa7C+OBU96aAl63nBMECQaL6
 C/1B5A321UjSHdxIXfizUhVogD3QA8Sl/aGppoqvmm6BNRIo69tP0OTr9bR2eB9/SFE9dxJebnb
 NaIPWmpAW82c4z3H06JuYKSwNK+rJopvADe0UNiyLXhaoAegsj2TyDvZi6rrowW1hty5OVPfhMZ
 +cPa2LpDjjGxURSaMqyDXUadq2vzupdXIuL3dSt5vvLosm+l6+9iN0r7AgWOs2ZaSsc=
X-Received: by 2002:a05:600c:b86:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-47773236f9cmr44476565e9.15.1762698937872; 
 Sun, 09 Nov 2025 06:35:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOlZrPkclZ2oUIzGWvQGRlGiYyVswgEkONUfufS1Ajv5GzdoYDMSHWWlw7jI4pLDAo3gkHpg==
X-Received: by 2002:a05:600c:b86:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-47773236f9cmr44476315e9.15.1762698937266; 
 Sun, 09 Nov 2025 06:35:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477641b622asm90691765e9.4.2025.11.09.06.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:36 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/14] virtio-net: Advertise UDP tunnel GSO support by default
Message-ID: <1c79ab6937ae938d3dfd4da1c01afc7eb599857e.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

Allow bidirectional aggregated traffic for UDP encapsulated flows.

Add the needed compatibility entries to avoid migration issues
vs older QEMU instances.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <9c500fbcd2cf29afd1826b1ac906f9d5beac3601.1760104079.git.pabeni@redhat.com>
---
 hw/core/machine.c   | 4 ++++
 hw/net/virtio-net.c | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0580550e12..06e0c9a179 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,10 @@
 
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+    { TYPE_VIRTIO_NET, "host_tunnel", "off" },
+    { TYPE_VIRTIO_NET, "host_tunnel_csum", "off" },
+    { TYPE_VIRTIO_NET, "guest_tunnel", "off" },
+    { TYPE_VIRTIO_NET, "guest_tunnel_csum", "off" },
 };
 const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 17ed0ef919..3b85560f6f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4299,19 +4299,19 @@ static const Property virtio_net_properties[] = {
     VIRTIO_DEFINE_PROP_FEATURE("host_tunnel", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
-                               false),
+                               true),
     VIRTIO_DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
-                               false),
+                               true),
     VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
-                               false),
+                               true),
     VIRTIO_DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet,
                                host_features_ex,
                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
-                               false),
+                               true),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
-- 
MST



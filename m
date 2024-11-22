Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3BEE65D26
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELpP-0005ps-Ue; Fri, 22 Nov 2024 00:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpK-0005lb-Ah
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:30 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpI-0006U4-M8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:29 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5ee58c5c2e3so837550eaf.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251807; x=1732856607;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+nFMN+RotazVwbRC0Glc2LmAaySUwmgO7t30fjYowY=;
 b=zuKqmoO7FoUK1ilMytiCZzfhp7KO8/mnF87el+8Pm2W+Va6CsirYrKNcfNZUdltr4w
 kK5PHlVfTpujBw55+XCNXqvIowO5zWwj1Y6Szeh33RUQ7iZZ9O9GLSbdiWFyqhsmphu+
 JSByJ/I2iHyX35NDs51ClfmgycvkJjIBuKX6TC77H5poPWN3woJ/7z+Mdvdsk1fpp+tT
 zbQnD1T6APAH2CplaGknsOW6REpCbkJXyDQTKYd3+T3eMmAUOoEwWV0G9DzTfS9REJvR
 uzvY8+PW/4Dw9yBapB57Tr3+UCx56bjazHhjduWLVCGKlN5Ql2B2GPxbq9JOhFTS0yOE
 0H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251807; x=1732856607;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+nFMN+RotazVwbRC0Glc2LmAaySUwmgO7t30fjYowY=;
 b=lu5bTL7luapRvVQXnzdmEAaVKqj0AvRGzaylRUv9wU7eIFWIvZuBvT4M6AqvYEMPYH
 9fbf6cT9/L/L0fwoYJk1tlWNoNbUp9L5Nr5WqLnbA6mdg6HZrniK1b6T6nilcfxTC7a2
 RYlizIyu20vfjJmKeIzEd9Uj2yRci0isP0yhqAdeBSPC01lQvZsvjcjaI9+Bro5i3804
 UXnhcAib15NLQY+dA7/tA/Tb3IsEgQCjwul1GQIn5WLGpbxrQKMqT6WNTfmQwfPwxy9T
 d+k1rg3YYUYaevRSlFyQXB/nHfqXywwoV1z/pYrgFXTdttZdu/aEzi+0yX2tFOjz1xZY
 cByA==
X-Gm-Message-State: AOJu0YzQzCPCADG9Hfx7XrsPd0hnrgy1ibtBKQ2s/LLkbAQ45ZwHbBmR
 JdVK7JLWVjXukRq4DVW8nInHdInZCxC+bKF6JZwDWnA6AnFOXIb8c430Ipb3QX9XJJePEKS+W8A
 WYus=
X-Gm-Gg: ASbGnctXtWBCmgx1TzA6EAKdzog83BlVA3Lzwvl/d4aT+JvToJdHuh7AvHYmi06OSfQ
 nLb+tslo0bLb2VEitmotxMVb/iuKkz2r+1GAMKkzVpEuSblElzmnEDQ0qt3RZt6a91t1yP9epau
 eJmg+tzn0Jsa5v8Q6bRGtRHf2DTauZ3RMwf89baDR89wj/cDxDU52kFEUKcyPFeLJcO4ufz31UO
 wK97Y7vHGIDhdJ//Cr38vh4+Rh0VVj/kq6UCFT7ngsaU8EQcUEYKA==
X-Google-Smtp-Source: AGHT+IFP/8j7E1U3w4AAzhqTkNSbbOzH3dT9owXxO4OlvyJY242mrSUnlEyWXzb2YL7/sMuz+RJrMA==
X-Received: by 2002:a05:6820:2d49:b0:5e1:c19d:3f4e with SMTP id
 006d021491bc7-5f06aa6f0a9mr1404436eaf.8.1732251807312; 
 Thu, 21 Nov 2024 21:03:27 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 006d021491bc7-5f06972add3sm259571eaf.1.2024.11.21.21.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:03:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 22 Nov 2024 14:03:11 +0900
Subject: [PATCH v3 5/6] virtio-net: Initialize hash reporting values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-queue-v3-5-f2ff03b8dbfd@daynix.com>
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
In-Reply-To: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The specification says hash_report should be set to
VIRTIO_NET_HASH_REPORT_NONE if VIRTIO_NET_F_HASH_REPORT is negotiated
but not configured with VIRTIO_NET_CTRL_MQ_RSS_CONFIG. However,
virtio_net_receive_rcu() instead wrote out the content of the extra_hdr
variable, which is not uninitialized in such a case.

Fix this by zeroing the extra_hdr.

Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b544d2e91a77..44ea72b50e0e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1911,6 +1911,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
+    memset(&extra_hdr, 0, sizeof(extra_hdr));
+
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {

-- 
2.47.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDCDE65D25
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELpH-0005fh-FR; Fri, 22 Nov 2024 00:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpA-0005bQ-P9
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:21 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELp9-0006Rt-Ce
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:20 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71811707775so963404a34.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251798; x=1732856598;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDsLPJ4AXpeDDZy1IJMYSeMrcK9siIVRfnf8cnUeqpk=;
 b=iTYLeI8vYbYphVExrApX1bKYzuCnLkOafY84I8r5fRH60ej3kU93luhyACaBUeDpaq
 x7GuvqQQ9p6B2Rw7Vs3CiuHYkhxCjaJN67JeykA7sIDCen9/pj1fyRgtDOgMLNUuw8MH
 D86snC+5tA4XQgbqfFaBlxu0LylTqbivOKBPfOYH6JsnJAQx3qPL0E54ysT5i5Mfi8QA
 cKo7SAAEwosMw6faIBy73k07J66H1CKVvWg/9eE15M2RgyTKErep78+5sAFCeOTMvDoA
 npwiYm9C0M9eDBk9PuDBgmzZXWFVXX9lbp9gdysvWRvC7K1eLAjnsbTlBjaKpVN4P+Sr
 WAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251798; x=1732856598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDsLPJ4AXpeDDZy1IJMYSeMrcK9siIVRfnf8cnUeqpk=;
 b=Itff+k+zFwc61dhstcVvyva3T8+ybGjfl65Xazu/0Yy9suyeLIWpPFTwCJRfwIf/aA
 S2STzGhFJICWI/juIsDOgDJo+64QICh8HsoHrgbn496Mb2fN2SfiZraAtMktH/c41XsO
 lTblkw9Av5XYmN4uFof0Rmf8MZXbWpIgpmtdQkMEb96HlHeANaXyBZ3ObuQYILRcsuC3
 7FLO45NTXDV7dJwDXgJRJWfJ+ZBTy+yLgZcRlOkC8fifW379VXFak1gqAEkYJULXaAQW
 pGrfS5l13HZfTaOBLQDqu/pLwz367wuamidUlbsUOr+FWMqtmTJ5h1cn2oTjohWjXVCw
 LJWg==
X-Gm-Message-State: AOJu0YzSXfNqotGDB3ogmOzUTtemgTU9Tw7BAs92s7xWUgm9cjtq8bix
 6vTILF4vJ0DabAoAhecZzaVL3Jxa3jnMZAwoh9/b7LQ9IEWmRaTz415gmDMF0qi90/ipFR95h08
 AtSI=
X-Gm-Gg: ASbGncuwvipDTZWUEiXZ+Lp0/+g/OgYmLDVhVheeROoHljHHRUuvuSr9WEXi23r2fP0
 sMt1TU2f6uhfbHA+yCV9cQd/r/BNRi1C3OLXfPtvpHKyYqMyUdcAaJu/ARjuIh1/Z4RAxut9NpZ
 vS0dtdEV5/zVNWkLkst2ckGDxSAFXjSsOkSMzvnYTosWtIbVr8gwZNS4Dh/jOLjfzubyg/ppZ+x
 C9SKCFmnbrIW0zZiVvGK35vKT+M1/JfVwasLzAqFRcVqyeOHD3Tbw==
X-Google-Smtp-Source: AGHT+IEyaOwnTFPID7ftcgOOzVhgbKk/zi/GbCqHSp8hTOuQrmrzYt64z5FQm9WYCKfSvJnWkGGonQ==
X-Received: by 2002:a9d:67c8:0:b0:709:4757:973 with SMTP id
 46e09a7af769-71c04cec8d3mr1298360a34.23.1732251798078; 
 Thu, 21 Nov 2024 21:03:18 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-71c0381ed10sm284235a34.45.2024.11.21.21.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:03:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 22 Nov 2024 14:03:08 +0900
Subject: [PATCH v3 2/6] virtio-net: Fix size check in dhclient workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-queue-v3-2-f2ff03b8dbfd@daynix.com>
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
In-Reply-To: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x330.google.com
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

work_around_broken_dhclient() accesses IP and UDP headers to detect
relevant packets and to calculate checksums, but it didn't check if
the packet has size sufficient to accommodate them, causing out-of-bound
access hazards. Fix this by correcting the size requirement.

Fixes: 1d41b0c1ec66 ("Work around dhclient brokenness")
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 75b4a28fb3ae..a2a8d6b07bcc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1697,8 +1697,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
 static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
                                         uint8_t *buf, size_t size)
 {
+    size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
+                       sizeof(struct udp_header);
+
     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
-        (size > 27 && size < 1500) && /* normal sized MTU */
+        (size >= csum_size && size < 1500) && /* normal sized MTU */
         (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
         (buf[23] == 17) && /* ip.protocol == UDP */
         (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */

-- 
2.47.0



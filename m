Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10EDD12D78
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 06:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAO6l-0006mG-5G; Mon, 11 Nov 2024 01:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6X-0006jh-G6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:55 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6W-0000ev-1O
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:53 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so3065408a12.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 22:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731307250; x=1731912050;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BOsglgpsLx9wpsaJb8iY+XQFXuDJKY3A8oUUKLrc94g=;
 b=oX+AzBVAZfs3QnBgqGdB7krQwGahc8jMmx3TpVp2UK0gKT/GOf2PdXlj24CYse09Id
 ZfD2qi4Tn8u+o2FOrb5jq//76hHy27uOFahH5iFygeix8c2LjPwm6i1OO1QuS8pHVgGA
 Bg4AON2wVGjN6B58kL+ZJY9dq55jp4zUYEf91FAt4YmskddiRlmiB6K3LD/ABP2dS3a6
 cFII8qcja9eiWv39tEvbjs3PRbZJ7ou205/vNNwqsvMUcfJwnZgtITJabrTq8xuuBCx+
 w909cPn7K1dpbHVn58Ib1bcRrHLAnf7nLyfQ6wYnfcsBEKwU8KMrk+sPacgiiySyVDJi
 mN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731307250; x=1731912050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOsglgpsLx9wpsaJb8iY+XQFXuDJKY3A8oUUKLrc94g=;
 b=lX87zgn82JcYXr7cwnu1jK0wdxen6hpP1BivoZooAeL25GCAFHaV8v61qBDQ8pxIVb
 wrwuUYCpzk9Ew8C/FyvYC+87ytu9iNT363WbYBGeGE18mkwGkQyWOevzDKHOW+9orjd3
 ibliwGxBoy9O6B+mJwO2ZQ/0q8KLGhv/eUOWacRvZLcmJ3NmsEuiVfKFBiF7u7mqsqsE
 1GqvPR9guiKccX4aaq4Qv06NcMvr6RRDAy1j8btQ8dv0tlk/RiaJYiZS2WTeaMfhrm9K
 ZSkWPqMioUhMmNoKc2mcyusPXVEHFeTHL2qy0kKvtgMo9ijXLXkfvtfGiIv1JK2JK0ty
 hgAQ==
X-Gm-Message-State: AOJu0Ywg5fA9D3mTxXo7S/3acOm6Fs9TQMM1HmL1pnc+5CKLV3poAysA
 xYqtfTyyPKyrtsIB3C/xkVf6WmuXMHbOP3jEqa/rN2WljFoFGtq4zJUGBLZACzE=
X-Google-Smtp-Source: AGHT+IG36MJY2TmBKfT+kmxNeZIzbpQkWmKvA7O+ozCy0TDKqUximtg9pDtUWdeM0mQQj31KTqbBCA==
X-Received: by 2002:a05:6a20:394b:b0:1db:e501:682d with SMTP id
 adf61e73a8af0-1dc22b59d1amr18018685637.33.1731307250373; 
 Sun, 10 Nov 2024 22:40:50 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21177e41890sm69268275ad.147.2024.11.10.22.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 22:40:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Nov 2024 15:40:19 +0900
Subject: [PATCH v2 2/6] virtio-net: Fix size check in dhclient workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-queue-v2-2-2f7883a1004f@daynix.com>
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
In-Reply-To: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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
index fb84d142ee29..62e396e8d2fd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1692,8 +1692,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
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



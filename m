Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B40CED270
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy43t-00018P-KW; Tue, 08 Oct 2024 02:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sy43s-00017z-97
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:51:12 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sy43o-0006S4-Ox
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 02:51:12 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e077a4b8c0so3727732a91.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370267; x=1728975067;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z8H1l1RnezQQYsp1g3XxYvGFbv/mtFIUiqzu3ZLJuso=;
 b=gxnbaIOpc2OSV3kF3EcBuBx4WZegWsSmAqfmX07rr/Mh65tpL2T5XH805/QKNXZjWY
 3DC27rxPGGbJpPKMdGnOsSY06YKmxLSKjRshQl1EsNR87yNUHnhmZStxrn8qE1Bdxg+j
 mCbIjqtPVeu5yxGcfl7LESv01jkQ2X8bmGX9cXuPYGY9C5o4FBQJv6txFLazDox9vBq1
 vNL79EIXDkvcO04IusC0UjB3nZFEg00esEClSRvNKj/POgf98wsSnezMlfzkHLEgHzhk
 uNy4cZhiS0RnyYwjPpKQ579irz88L9fTp9RKUiobPrGQkcnlGcjf+/QdhADOj6gLsGvz
 TUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370267; x=1728975067;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8H1l1RnezQQYsp1g3XxYvGFbv/mtFIUiqzu3ZLJuso=;
 b=QORclG/FeV5OZlLI2x4/HHbX1pnWeSE4qFUanb6lBIQPfnjURch2GSPsme38pOSD62
 kBHNBpWRnSjTJkExtukekYm1sUIKCt7W+syJruZv/5OJU1vGOt5QjaGU1pRirH5Zn5ne
 nbnT6H5jiCeLmRkDjYNGXzf999eix1S8meHKdkUg5PPFmuiUREuki8mQJORpxiIGEj/6
 1MkvJpDiH+MthENnEnpDoWN2Ga7+STOKywfkCNpJxW4rW4ZzJwxYlGd8uTuMcVlw9FcX
 ExYJOG2tsWzg/Kw+nep2hPGZfSPb1UDoHatLEr0jYOtvpAUDlLTX/HQkbvHPrxK4b6zI
 1Ujw==
X-Gm-Message-State: AOJu0YwefhcgPxqw/iCKMbl1X1lVXpPGcn89uH6UVdlCr4m14XYX1WSX
 NrmweuB0it8S9CDW6YraqTxf6OFoxv7oOpJck2tzrxTYOMdP/7nSDvWEIbgyCr8=
X-Google-Smtp-Source: AGHT+IF1uRsTZpbSRzJGDujPWK360hNR7PCiLG8WHc9tN5rLqC/mG5YR9tuUYqQ7M7q/Yg2b5uIeMw==
X-Received: by 2002:a17:90a:17ad:b0:2e0:7580:6853 with SMTP id
 98e67ed59e1d1-2e27df0ce96mr3252964a91.17.1728370267009; 
 Mon, 07 Oct 2024 23:51:07 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2e20aebc40csm6732940a91.23.2024.10.07.23.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:51:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:51:03 +0900
Subject: [PATCH] virtio-net: Avoid indirection_table_mask overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-mask-v1-1-679ae2720bd5@daynix.com>
X-B4-Tracking: v=1; b=H4sIAFbWBGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwML3dzE4mxdE3OL1BSztFRTYzNTJaDSgqLUtMwKsDHRsbW1ANX5A+V
 WAAAA
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We computes indirections_len by adding 1 to indirection_table_mask, but
it may overflow indirection_table_mask is UINT16_MAX. Check if
indirection_table_mask is small enough before adding 1.

Fixes: 590790297c0d ("virtio-net: implement RSS configuration command")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8f3097270869..625852a590ea 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1400,17 +1400,17 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
     n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
-    n->rss_data.indirections_len++;
     if (!do_rss) {
-        n->rss_data.indirections_len = 1;
+        n->rss_data.indirections_len = 0;
     }
-    if (!is_power_of_2(n->rss_data.indirections_len)) {
-        err_msg = "Invalid size of indirection table";
+    if (n->rss_data.indirections_len >= VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+        err_msg = "Too large indirection table";
         err_value = n->rss_data.indirections_len;
         goto error;
     }
-    if (n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
-        err_msg = "Too large indirection table";
+    n->rss_data.indirections_len++;
+    if (!is_power_of_2(n->rss_data.indirections_len)) {
+        err_msg = "Invalid size of indirection table";
         err_value = n->rss_data.indirections_len;
         goto error;
     }

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20241008-mask-478ed6fe5365

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



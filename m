Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0327C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBo-0000iM-Fu; Wed, 04 Jun 2025 09:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBC-0007SH-OX
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoB8-0004o7-7k
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJVEpuiiNfZnhb7Ztjzy3HYaaYZg1QRE5Cn5bXQ5Q9U=;
 b=SEOv9HS9jkikkmMCeXI26ezh5B3wAON2OENWje5R2NFi9j2Jtmn2DILjsbK77qS5uPbqXi
 bwruXHDFE3YK+5sH64s3KHaeZKKaXVdeJeu37/2ve+DZeVetpWKmaPYJYJuuO9aNvydZCV
 dzmWlF/IG+gbMpOpsBmxbAeoR2KfFJ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-TrH50S-MM1m4DY4it5QLNA-1; Wed, 04 Jun 2025 09:29:12 -0400
X-MC-Unique: TrH50S-MM1m4DY4it5QLNA-1
X-Mimecast-MFC-AGG-ID: TrH50S-MM1m4DY4it5QLNA_1749043751
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso3775671f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043751; x=1749648551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJVEpuiiNfZnhb7Ztjzy3HYaaYZg1QRE5Cn5bXQ5Q9U=;
 b=QN14ym2e3SQ/4JsX95GbrymkMEuao6a8TO3pLKSXh2x6PWs8+x2UmpH8sG4U+/gwft
 4G6Gs+MRRiOGc08ysBUWA67E3AUdbNMJiGRsHPSEvt5s2FfGi9OVARwysfhQrMa/wpCf
 XroYrzuBW4nv062V8SCztNZmCa4AZy2x9utIkeqS7F4ZtrqwKWG11h8k2zZVxo9aYDx7
 c0N7bIFaFU3qgqH/NBFNcPfixucoQhcfsSaUg2PQg3N91bc6+/twfZJBDrPUMPIG7091
 luRZ+p/J7wwJHHsjDYgpCl2OhUG/kp8GIirwcBUEAMbed0vC0J8Q7LCzsZK6vphbbLQS
 xrqg==
X-Gm-Message-State: AOJu0Yylzs/I6nCHkU1UXgaHWS7QBZxF3ZTp9O2XVa+c9D1x92MeMLoQ
 FzhkdKfSRZKvVxc//N/4p3/G7B2ZX6hnYtoZX6la02f+OzW5UbZqEsZ8I2q7QEbG4Sd6755JWCV
 s0VOX5vXkTdOpZz1TSmVwftcNpMbCk3hUhqONgE//VroaKRw1fRGHTxXe
X-Gm-Gg: ASbGnctCOEcyhV2cDwnjUcARN7wutpDdtnBbcRJ7lC/5kyzjI/O9S6W7YfRdrrNxfTX
 NsDFmT4PQN7ZX3dmzl2zxLWBxN17RMRA9wiGpGAyCcghmIpeKRjSAvU5j9GBaHodkIHrH3pYCd2
 oW45nVwuLXawhgkK1V7kcoIoaA+P+E7t6eAr2hQ5nS7JdSviqoZLEMUIKr3Z6H4i9QKF7jKlIJ0
 s/MwugRTC6ABg5xaGWB6wT+GK92UtfYqtkk5De46k41tacEy8e+d+rZE8SyrG/27d5we1W3sGMI
 phPznJ9cHhO+qo2XZjaUXomoXUgHGxu8jpivtqHfZeyfFG7gRNnzIG5gHR/tBE8aJGRS+K/dt6K
 PjvqT
X-Received: by 2002:a05:6000:2004:b0:3a4:fc07:ba2f with SMTP id
 ffacd0b85a97d-3a51d918dacmr2405213f8f.14.1749043750645; 
 Wed, 04 Jun 2025 06:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES+7dGy2W2jiOBBUH740j8DpkeuY5nzVjyprj98QJBbXgBfEumQEW3kCWDFQoLHBWpwTUO5A==
X-Received: by 2002:a05:6000:2004:b0:3a4:fc07:ba2f with SMTP id
 ffacd0b85a97d-3a51d918dacmr2405185f8f.14.1749043750221; 
 Wed, 04 Jun 2025 06:29:10 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb8990sm204486535e9.32.2025.06.04.06.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:07 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 14/21] fuse: Reduce max read size
Date: Wed,  4 Jun 2025 15:28:06 +0200
Message-ID: <20250604132813.359438-15-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are going to introduce parallel processing via coroutines, a maximum
read size of 64 MB may be problematic, allowing users of the export to
force us to allocate quite large amounts of memory with just a few
requests.

At least tone it down to 1 MB, which is still probably far more than
enough.  (Larger requests are split automatically by the FUSE kernel
driver anyway.)

(Yes, we inadvertently already had parallel request processing due to
nested polling before.  Better to fix this late than never.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 926f97a885..ec3a307229 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -45,7 +45,7 @@
 #endif
 
 /* Prevent overly long bounce buffer allocations */
-#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
+#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 /* Small enough to fit in the request buffer */
 #define FUSE_MAX_WRITE_BYTES (4 * 1024)
 
-- 
2.49.0



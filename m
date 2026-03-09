Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5AFF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcF6-0001Iw-F1; Mon, 09 Mar 2026 11:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcF2-0001DW-Rc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEz-0008RT-Ch
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ri63c0zIoSQgAinKj4Gr9ogtshcXsY80vNDrWEB/NVk=;
 b=GDzP8GyANw7jMf9C9+IUshsW2StizenNk5qFoEDgEQmbI1K//dR+9RLVyRfp9pXRvAJRWp
 1/VspIQvZxEMo48bRWK4a8tZa8xKkuPzMkZik1OFFPYuH4QHrEYAPCZR3/dGIXqpEAzzBL
 ki1RIE8uacHideuNKxj/4v12dI1JEfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-GHRI3WG7PdGx1TGdfMrjGQ-1; Mon, 09 Mar 2026 11:09:51 -0400
X-MC-Unique: GHRI3WG7PdGx1TGdfMrjGQ-1
X-Mimecast-MFC-AGG-ID: GHRI3WG7PdGx1TGdfMrjGQ_1773068990
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-485355493aeso3417015e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068990; x=1773673790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ri63c0zIoSQgAinKj4Gr9ogtshcXsY80vNDrWEB/NVk=;
 b=gBJINylToqoIein58AZtJD2uY7Mani6ESzz5EDwsObgGBZRt86eazL/z/tmnusRa4r
 +UgaSI3/H68DwjT/VNTqoX4SAKC0Taf5xCFYe3qpmVoUSx68uDgtpr8SDpjNMBts6eG9
 mDUnjcUW0BTCERATb0wmyI6nDFTqHflyKxQbcgjQjGiTQj20+p9C4iMTD7g253TiOhRa
 xDOWs96TTpbJIL4ppiEJ978zZzqra5a1dO1lXYxOiO9T+vL6IZxewr9wz85bJ+pBwa//
 R6TQuZo9WCMqPBGNYufp05tUXXzV4ppRKdrkpWW8ZkdLR0fgvrHyct8mhNPNI0TDVKUn
 4skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068990; x=1773673790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ri63c0zIoSQgAinKj4Gr9ogtshcXsY80vNDrWEB/NVk=;
 b=rrj3BfcyJ594HhVG2PXfEPksm3wv2plsRLutpxiGLEVXa8UMFxsB35eXRvm+XhgjQf
 YFh318b2H70Ix2kUNECKz0D7cX0N6hSaA0YKaLLM5dgUr04UOC8rLjpyBx/NliBEkBg6
 muUWg8mbc6SpLEdhZ+9XfjX0NlhoNSurthqhfrVzeAzAoQMnWT9NTv5oAs8ECLrScrGO
 op0zNtEouL5SgAWq8KHWBs0pHIt93c/cP5J0aw+cvdIXs8ubeF8K77ZxIy4bspumd6OV
 NLi7ZHcREDzoDWNAHNGWcxvHAFm7J+NC4iihibtBI/kSRuax8IDh9g17dT1sW/2ENWyY
 iFDQ==
X-Gm-Message-State: AOJu0Yx34nwI08I+AjW7wPD2lx/hut01Z66sp3igp7jLCxGESsfvQ9H6
 GtDkesqYKb6ZRsH5rx8FZYBA/lHiLDwpReQ7hC++I69oeBC9pZn0x6rMiyUA/jaGqsbssC9VwCk
 bqSZ1MLiHhVCItuavWon/8L+RI5aKy858npQ2RkUYlaONEoP2aq07mvwz
X-Gm-Gg: ATEYQzzsnE5sZUYhwT2G7mZmho1WO5HCaDDZdTEechOjhoUyhZJrQU1iMn2gB1sVziQ
 z4q4ekIKnTLgquNMP3tgY3tWpIyBHCBlEbclMN+n0wdZUePJ0R433RTs3wR+3r0eICE2CCj54Cs
 3JsMHfJrUIknDNj2Xc6yRo3unSJ/A3+ktZAwXLJwXASR4MJr3xPnYeoFJZtkY0lKx7ECVEP6ByE
 dMeovdcDgSJeNexbN817P/kfJ8y0Kvz/EvJ7TOl2OePx0JTOJa+wju2xBq71EabNxVR8LrQz3Wi
 kNF2AhWJeuEksz61OX6Qz9t5ssYOyf/CjFZyFP7u6JRG8Lh8cyUvMx4v9oHeoCUqz4Z+x5YVzoM
 QkVSpnRYPPy2AfZRyuxs8qamBlvc1CUZlAXqrlCY5oGDxYwRqGnfFhQWXvNdeg8yQcr1ireyU/2
 zcqoMw
X-Received: by 2002:a05:600c:46c4:b0:485:304a:58cd with SMTP id
 5b1f17b1804b1-485304a5a00mr136119535e9.4.1773068989701; 
 Mon, 09 Mar 2026 08:09:49 -0700 (PDT)
X-Received: by 2002:a05:600c:46c4:b0:485:304a:58cd with SMTP id
 5b1f17b1804b1-485304a5a00mr136118845e9.4.1773068989214; 
 Mon, 09 Mar 2026 08:09:49 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48531818b5asm88131615e9.3.2026.03.09.08.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:47 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 18/25] fuse: Reduce max read size
Date: Mon,  9 Mar 2026 16:08:49 +0100
Message-ID: <20260309150856.26800-19-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
index bd099d1291..f32e74f39d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -45,7 +45,7 @@
 #endif
 
 /* Prevent overly long bounce buffer allocations */
-#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
+#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 #define FUSE_MAX_WRITE_BYTES (64 * 1024)
 
 /*
-- 
2.53.0



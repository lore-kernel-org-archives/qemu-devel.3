Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A42CC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4n7R-00041t-G3; Thu, 10 Sep 2026 18:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWs-0006bm-KK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWS-0003gO-4R
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqIBh6wrg3/cCLBO/xish158SNEF5YQcKd9WgGS4UWY=;
 b=aAGF1sKxfPkvbGa6cB0yiD8brKNmhBJI9gDMONFdgoMBvWLA45Ii/hn0Y8aFfc42XA8Sl2
 J7TKzNpNtBoRtOGiqNyTQaMi+pXSIPeBQ/3txxm5QGkJt68A0qhQ3Vb1DB6FrKCuIJ/ubK
 Uh+g/QN1Y4fQ3f45rh/HJY0T+uF8ids=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-ymP0DvhPPHKdWExvqlcJZQ-1; Thu, 10 Sep 2026 16:13:32 -0400
X-MC-Unique: ymP0DvhPPHKdWExvqlcJZQ-1
X-Mimecast-MFC-AGG-ID: ymP0DvhPPHKdWExvqlcJZQ_1789071211
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so1573155e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071211; x=1789676011; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wqIBh6wrg3/cCLBO/xish158SNEF5YQcKd9WgGS4UWY=;
 b=qFcpfCtTIDGR6htxUlVmUtvdzWtZXXgfNo2X1PD1az+tE0ZRuuGLaUMRBmCjBGFhlC
 EimLhm1DXsea011Ou2l7aWedBw0BjUHdmeZ68d0kfi8VhHSbXHlngeRNxA12mKdWl0BD
 5Dx6MzKTrB6EL0O9TRC50goGt9mryC8fF+KHg59w/zOVzsVV/M38D/zMbdx4HBMJFjTI
 THGUpBc7L5Duz4F1jz2ufsv+BNcRFPq+iZy7pdJLH81vtOHaL8vb75OjhMTevc49pFRl
 ur7zDKEjJixwHVbrMmv6Vey/pIrRBvcPugPhJBzKuUM19T2HstQ+fCyE11UBFPN4bIWE
 3Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071211; x=1789676011;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wqIBh6wrg3/cCLBO/xish158SNEF5YQcKd9WgGS4UWY=;
 b=lE3jS9iooeNbMecJBB72k0RIj2j9xSST+Eoe6XgKncJzfKRYZDp2cUfjQ3bf1T61oZ
 Ggn4H4vDzOF6gVA3k5wgJCEWIXLeKWGvmwiWPsMLxGiIHWZnIQGada3TOzDIBXkLbWmN
 QFEOw0g3S17mrGKNRwCfNb+iEcWrjX46RWcEatJ4hvXmcHYSz1o8UO0rG2Ng0PQGQQVk
 +XS4sH/Z3zCEcANUZ/LM4yhv35U+OSUPp8Ai512tdZ4SAv1mY8PAl90chAP5ik9Emw18
 OJwK4HisWnLr21QcVb+u54axkImS9LVI5vpjWSHHciQHKlRwBdJ5T3g+y/ySY/8e62Gz
 BNTw==
X-Gm-Message-State: AFuF++l3zlwBczKkwxVutQYgNF4K1gUPx34CqBPwTrLS7s1n/00QsBUm
 ENXSYPJGDQsWGcn2h9fYy7Wx+Cqrx3uhoi+Jk2OukPPKVHv7GU26p8oFaECQi7s8eyFYAq/I1+e
 fuY+Xki8wSKbWxUu56trUb80QhiDyT0O2qxh7ojOpRgRF4xb9Eg2ssSy0vYFRTXigOHnpYfnv1n
 LXVCAukWeS3VRr/2Eek9a/AV2713Q5Yvzp6A==
X-Gm-Gg: AYBFou3NO8+gwlt3cLHxWvNicTO8M94C0izGfOU/vzvviTNgpTtSvQlDO1speKTh55Q
 a36/SaGpD2PL0b8ll2bU5504Kiaiavy07iA216na28W/jIHHbk3HbB7vGd3N4dB4soS3xp+Kp3y
 3M+/4dZzI6DVowLEx7DuyF6NUfm80kKCaQ87hk5nU38+OabOQ2DWdN3AnOgg5VUFJBh0Rb3SbnG
 4A+fRaiZqlqlVku/X4uD3wXqyGLZgJMy79Y0dywETzzTm1EHdrb/pfiQvjFkXW5xZHi2BpF4m/w
 mQRq7s8rNXPp2N1nFB681mRVZxPM0L7Agc85C5dgRFvYU8AIMfhB5pWlKuA4Lh4K9IKk8sIl/ee
 IIiNRd5IpUbFyVQVMSREMUrk=
X-Received: by 2002:a05:600d:8649:10b0:49c:e1cd:536 with SMTP id
 5b1f17b1804b1-49e61988908mr5905755e9.12.1789071210942; 
 Thu, 10 Sep 2026 13:13:30 -0700 (PDT)
X-Received: by 2002:a05:600d:8649:10b0:49c:e1cd:536 with SMTP id
 5b1f17b1804b1-49e61988908mr5905485e9.12.1789071210529; 
 Thu, 10 Sep 2026 13:13:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60aba026sm19984575e9.3.2026.09.10.13.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:29 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org
Subject: [PULL 49/90] hw/ide: Have ide_dma_cb() complete accounting
Message-ID: <125d3d551e07dcbbb79cb1b4ff83bd4120f09278.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

ide_sector_start_dma() starts accounting for reading and writing, and
ide_dma_cb() is supposed to complete it, but currently does not always:
In one case, it just forgets it altogether, in the other, it uses
block_acct_invalid(), which should not be used after a cookie has
already been created.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-6-hreitz@redhat.com>
---
 hw/ide/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index ef573798d9..06e6bb6067 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -898,6 +898,7 @@ static void ide_dma_cb(void *opaque, int ret)
 
     if (ret == -EINVAL) {
         ide_dma_error(s);
+        block_acct_failed(blk_get_stats(s->blk), &s->acct);
         return;
     }
 
@@ -968,7 +969,7 @@ static void ide_dma_cb(void *opaque, int ret)
     if ((s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) &&
         !ide_sect_range_ok(s, sector_num, n)) {
         ide_dma_error(s);
-        block_acct_invalid(blk_get_stats(s->blk), s->acct.type);
+        block_acct_failed(blk_get_stats(s->blk), &s->acct);
         return;
     }
 
-- 
MST



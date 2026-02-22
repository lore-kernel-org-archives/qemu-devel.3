Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D74FC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASn-0000R5-8p; Sun, 22 Feb 2026 09:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASQ-0008CH-56
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASN-0006pI-94
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rgB949WAU4uCVPWaxAF4bhPoWYrxnuzG+Bl2uU3jGIo=;
 b=G4aH0YyEuWaPjKijnk1v1a9bVG7p0WEFFG48b4ufXrpZSebWvqmfvTcCqo0k0SzwF/DgBx
 2hsAsl+jaXp8qujX+WT91e9QeWCkR8QK0FyHJEJ9iKqd1roAGALE9ZsazApt+OGL0Egvyy
 TYPGfIYJOJ5w70pIYy/zVOOCVbiHHXg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-5ucY2ylnOHysOlcE73ukEw-1; Sun, 22 Feb 2026 09:29:09 -0500
X-MC-Unique: 5ucY2ylnOHysOlcE73ukEw-1
X-Mimecast-MFC-AGG-ID: 5ucY2ylnOHysOlcE73ukEw_1771770548
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837a71903aso3184855e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770548; x=1772375348; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rgB949WAU4uCVPWaxAF4bhPoWYrxnuzG+Bl2uU3jGIo=;
 b=iFg0P59vMGl9JFoc1mDAOV/ItvgxARXuBVi+SUaJ6W0zukT4j7EAoAHgGwx0adKtmK
 GL2mnmEmrLfLZSqGISW7o6ki0MbUa9Wc0sKmOFQCtllv+DDqN3JnD7La7fv9JVipz6BM
 a0ETfOMa/FzPwnVl/D7RNXcQeN2dQ7K3pULdbjoPvCz+d3KoSLfSAte1kEOz0r1C8N8C
 xmGXibbzL3IHkqGakymPb1+s6cyIWgD2DOA89KvAejcvfKprGhyRrkKhq+eoh7gZmoyf
 zIVhgoVGe2c7zK2pHtqSckF1dRAA6laCPRElnEnFVYvnDPwnvygUCvCFSORJnF2MOLMZ
 +Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770548; x=1772375348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rgB949WAU4uCVPWaxAF4bhPoWYrxnuzG+Bl2uU3jGIo=;
 b=VLLUf5nkc435ohBYQwUkui19X/DC1p52wE/JN2ixHspMD7zy1y5Rjh02XNVcwjf9LI
 q9KQc1iogQ/LRBixcM1AYZPAEYqrrhcncioFvJsxopS4uGvDGyr8jjaAP7sZTkp4UWF6
 yLuv9Qraxex/0e2sl0aOFMdUN6wprYoegJAaUmT8I7gGowHSi+RqgHt8plSdFzWBhC8A
 mFHVG+EFS4OLjWAmbdqRV/1HSm5ri2WWCwR7audyQla9gUkMoXenCmYangS91h6EOEbM
 KG9IGFIkZJUABgK94/KDrnwUPhtQnJFelsNb2S54SwavqiobNNw95cNPJwGUNRL0LyNQ
 ZSdA==
X-Gm-Message-State: AOJu0YzPZ//gdcbmnaH6m95H90204oRx6VrdyuHJlqNSuU1deujDEOtK
 JHKkchAf09gb0roBfqrevmQTPqPk/PlrS0OMdiz1PVUme6mXEcmsatYJVadmfWZFPVYGRndWlaw
 murd1LROWzETNrof9fGO+iHnYAF5MgSKBwzW6VNIjl85kGSqwzGemQ41Nj3DK/zR9m/XEkbUBW9
 ECzL4Ya24iGFKQwGhVSzMqmTqesbczzHwefQ==
X-Gm-Gg: AZuq6aKOF3BiPBhc9AdV5shgxf23Di+W2LBkE/tPC5qH0gKc4CRb5B4OfTQxhy1d+/s
 YKyQ6f5aUhLCvhnZpPqs6TAG6Zd6OxCsWs6ACSONRz0dSR0SgpzwvZBOPXAY0qFJjRyXMwNDQNK
 57H72+GCm1siSn8MMJ3PGmMgk3+hvLbdlu1OwMJE7ag+zEMtAIfw7eMaTKVlZpjSlZQHb3mLJ/t
 D1GSpUnZVU+x7j1/wBbl1xFE2SW333NW9TdgouXYQ4Gv2vWot3+MONg2NScdxYBxI1kfZatShrt
 KoK/7E1F2BUyK77lofZj3wordVLnEAL6CDa5J3MpKMXgbwtMJZPW+sWYTqxrXsi8vEYP4+nS/Tf
 H1HjsArb4iT/pi8f5rZBlWIXBB+lJRFRp8vQ8/hXLVIggmQ==
X-Received: by 2002:a05:600c:820e:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-483a95f7d94mr85604315e9.8.1771770547852; 
 Sun, 22 Feb 2026 06:29:07 -0800 (PST)
X-Received: by 2002:a05:600c:820e:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-483a95f7d94mr85604035e9.8.1771770547363; 
 Sun, 22 Feb 2026 06:29:07 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42eb84asm80113065e9.17.2026.02.22.06.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:06 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan.Cameron@huawei.com,
 Dongjoo Seo <dongjoo.seo1@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 21/33] hw/cxl: Remove register special_ops->read()
Message-ID: <defdfab32c78e8ad134e43494a835e0b3208705b.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Davidlohr Bueso <dave@stgolabs.net>

... this is unused, unlike its write counterpart.

Scope needs to be added to avoid _Static_assert() immediately
after a label. c23 makes this valid but before then it is compiler
dependent.

Suggested-by: Jonathan.Cameron@huawei.com
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204170936.43959-8-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a7d36e1128..07aabe331c 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -68,11 +68,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     ComponentRegisters *cregs = &cxl_cstate->crb;
 
     switch (size) {
-    case 4:
-        if (cregs->special_ops && cregs->special_ops->read) {
-            return cregs->special_ops->read(cxl_cstate, offset, 4);
-        }
-
+    case 4: {
         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
 
         if (offset == A_CXL_BI_RT_STATUS ||
@@ -105,6 +101,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
         }
 
         return cregs->cache_mem_registers[offset / 4];
+    }
     case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
-- 
MST



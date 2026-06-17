Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A91DCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIk-0006p0-OU; Wed, 17 Jun 2026 10:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIj-0006ma-ID
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIi-0007r9-2F
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+W8LJ/ZjxvHjWpSXIWcZo3qSbGV39HrmijBCnFpCQY=;
 b=QyDK4wjAR738q6YzJrtWZsWSwe2JliJ3+zjazEIbYCYSU8mO5wXbODQdtzegfBQgOAZNBN
 rtMHJm2JrciDFTIe2cE0OyNUBFMfteboz0bYmt8TcnkIN5djrsNNjZNkTPgKtC2o5i/lmc
 xHal+o0l9/es84Sqwna5hgvmKkdWpuA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-eBghD1fwPQWRywV_4WkleA-1; Wed, 17 Jun 2026 10:31:30 -0400
X-MC-Unique: eBghD1fwPQWRywV_4WkleA-1
X-Mimecast-MFC-AGG-ID: eBghD1fwPQWRywV_4WkleA_1781706689
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so53377535e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706689; x=1782311489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+W8LJ/ZjxvHjWpSXIWcZo3qSbGV39HrmijBCnFpCQY=;
 b=mWg/PdUycGfmOJgWdx/mQRdFwR5Hhq8IaGPlPtj2a3dcMTf1OjocXRtRvWKAxJf+sj
 q0mhzrL1acMCxVXbqx5a8LNSQbl/co1nJAWbAWxzwy2LbAERYVLYvyIYvriSS8JzUfHm
 wyMTeHkwhHajzZTQ946qgsBcmZpChB6yiDGI0jGMrh0loqXegLVJfYl5UUjtUpsJw1FF
 Ynr4kEvFk2MvduFvw4uq0Lsd7Obs7NQk9Qun9f0WczDBhZs64EtsMvBKsDCu14F3iAWv
 KdN9Wp4i91Br+CtGsA4f04TtJpTtBhfvfXIcXk3MXU1Uc7GiPdQEn7de37z90GJ401oS
 zWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706689; x=1782311489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9+W8LJ/ZjxvHjWpSXIWcZo3qSbGV39HrmijBCnFpCQY=;
 b=k5v+8X+vKcSLWx5FPNyEfc/JHcGTKwAUpA5x81ACTBIg0088SwqnIKcia7S6ScQvSH
 s465DnklFDPF2za+6O9T8GK2CrDKITLV7EiiwfyQACJusUB3yyDvqPV/8nemjkRmqnx0
 x/LrBUe95/B0LqoijVLvzFTTEsAP+0LhtvKipMgODSSxpZ5XSd32PFdcYpqvjZiZervs
 7gR7A6ApAWLKln16OwxH6+ljsSneVPGo6HteCevRKURQvIjhzEB56zREly/9mba8bPFj
 7cfZxwPhPd4qP9up6ForVWTRtTHlRdPuSFUIV3bM0TpAj/hf2Wnv5/gq7TkA4MDS9ehg
 7Xcg==
X-Gm-Message-State: AOJu0YzEvuUqadJ5DCiyoJ+hrEdKuBHVE0UC2TkfihfCIJB4s5WmBeCS
 PSQdTGOJC3IYmFHY6Fovj8xDO88IeTsXvqMuog8uIYu++VD08Wu4BO6LRuWPOlT0kE9FkVWB+//
 sTe+GT7+Qwd4C63fEl3ffLuyvXm6YjvJqUE9JXniG3iRJTT/otufJnG2YMH/agYSooGqrQwW79E
 6A473dpxwKavrDMX/1GUkmlzROBJ5Jh+CY62nnKZUz
X-Gm-Gg: Acq92OE/a1SuCfKzQFecq0WcOIQK/e6AH21FfzDbGiXEB96zShLoGObdCa1vfyUTx8R
 S6AD7mBN5YzWVPORngfo9fi4e110P4uT6pWyhQwR3QzvmxNhoZuPMrYrETgUW3PLCK6jwElVd9s
 9IB3cxPkt3g9c7ZL8ZykflueFvcI+SaIz1+8j+rGfdC/34HINw+J7UEu7qHWsWXzUzarffowiSK
 +a9iPIlrg2kEAs6tl7+s7L93PKHIAbjaFpW0PLQade5rD9Z9iSp4cWiDzPy3RWqh6b7kW6QWWZp
 SsibW/N4B5yOi+s0g9kH4qzh2XCH7D06I/kDK24pwN4bx/mvozgOb/nCbSXVP49Lw5oKDh7HFbA
 zgg2Ks+3k1yrnEcdODglxi+Pm/HEJNP4rTMRZxhyetSIRPT5Tc2ZikSsAnGsME881b/l5hlTQ/F
 EcbVSmQKC0HGj8vheH
X-Received: by 2002:a05:600c:8283:b0:490:d38c:7836 with SMTP id
 5b1f17b1804b1-492333a1683mr72473135e9.3.1781706688768; 
 Wed, 17 Jun 2026 07:31:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8283:b0:490:d38c:7836 with SMTP id
 5b1f17b1804b1-492333a1683mr72472185e9.3.1781706688093; 
 Wed, 17 Jun 2026 07:31:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47da9sm201715755e9.5.2026.06.17.07.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 15/16] qga/vss: Remove unused undefs
Date: Wed, 17 Jun 2026 16:30:45 +0200
Message-ID: <20260617143046.445322-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

We don't include any headers that provides VSS_E*, so
no need to undefine it before including vss.h

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260330113906.168002-7-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/vss-win32/vss-common.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
index 0e67e7822ce..db849127c2f 100644
--- a/qga/vss-win32/vss-common.h
+++ b/qga/vss-win32/vss-common.h
@@ -33,19 +33,6 @@
 #undef uuid
 #define uuid(x)
 
-/* Undef some duplicated error codes redefined in vss.h */
-#undef VSS_E_BAD_STATE
-#undef VSS_E_PROVIDER_NOT_REGISTERED
-#undef VSS_E_PROVIDER_VETO
-#undef VSS_E_OBJECT_NOT_FOUND
-#undef VSS_E_VOLUME_NOT_SUPPORTED
-#undef VSS_E_VOLUME_NOT_SUPPORTED_BY_PROVIDER
-#undef VSS_E_OBJECT_ALREADY_EXISTS
-#undef VSS_E_UNEXPECTED_PROVIDER_ERROR
-#undef VSS_E_INVALID_XML_DOCUMENT
-#undef VSS_E_MAXIMUM_NUMBER_OF_VOLUMES_REACHED
-#undef VSS_E_MAXIMUM_NUMBER_OF_SNAPSHOTS_REACHED
-
 #include <vss.h>
 #include "vss-handles.h"
 
-- 
2.54.0



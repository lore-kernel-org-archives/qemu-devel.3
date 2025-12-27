Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C04E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxf-0005rK-OP; Sat, 27 Dec 2025 04:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxe-0005k9-5B
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxc-0007WT-D3
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WuNs2w9txl5m4wEfxZiVSZfBD4Gfk5ARbpTQPjey28=;
 b=SAdWfbuTm6VV5x1Fvaw4Vfnl3cesogektWRhzEvp3T5vs7kzx+PT3mI8VxfgKgsq7VUDiE
 EMqQGYYUW2PpOVAWPA+ipENTwbLDRPChhXqRVHt/Vk+duoggUlhVxO6BF9HnRb41Co1UP2
 mv2NYZnuO6TAifxIsT38KY/1/kxb914=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-dkESxMJSOFKJEsshrsOJ_g-1; Sat, 27 Dec 2025 04:51:42 -0500
X-MC-Unique: dkESxMJSOFKJEsshrsOJ_g-1
X-Mimecast-MFC-AGG-ID: dkESxMJSOFKJEsshrsOJ_g_1766829101
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fd96b2f5so6789931f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829100; x=1767433900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WuNs2w9txl5m4wEfxZiVSZfBD4Gfk5ARbpTQPjey28=;
 b=fScxaVfzPFlte2aR0A1Xiudh3qJa796uYkeDpdi2hJp7SOYPMu7Mh4fyhefEF7+Zaz
 mYH6UursVgX99HGGie3oG9a3I01gAcMnCge1yrRQwC8v1e9DwpspWvMlsaCBfjwonvJ2
 2cvYB0IJKPY3i7nuPloTRrKr+dAXz0f9DApcF86F7HP86HeuHSwsYRYR9O7oEcIeqWql
 Lfy+XZt38cwNpiKRzWO61Zl6fWlCgchZ0nKn/69Lae1w94pNyA89YGiNfj1/TSN3gTUC
 OgMU6Pu+icdaBLQLLY4FUlimP0pe8DlmGKsZA60ul90r5gKataFtl3y3LUWON3eAs6ej
 JwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829100; x=1767433900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6WuNs2w9txl5m4wEfxZiVSZfBD4Gfk5ARbpTQPjey28=;
 b=agN37Hhy4VNOBmyE3VytPocLV6i52IU/F7baL4X1k7Ch13vPH1LO5mwAbm9CYIz27F
 On3fBiL6Q5N3muETogRbtTrsCbwtaz8fhIhTJw0sO5x1T4GYiXrtGpFP5iDyN0nlmCsG
 Bk8vwsKPv5W0wEV5hvw2XQECq7nR0VdkbLkydZcwR+q/q5EpZR0Ptz60WIn0DnjOUEWF
 jvvShW0cqR6mptB/izDk2hNJugXNA3J11U0M/YX2XnRM4PMJE2icFhgKNdO9iO7Oe5eQ
 GCu7WKQp8tmvt/N4JlPxk3rWWNH2IcRvhIxrxVxlfcWjDquUYL8/eOS6pWiaOhb8iDgH
 1sNQ==
X-Gm-Message-State: AOJu0YzMFE+59L8+qxwxWWxBYZ3SkMvFPBGN5irj2BN3+W/G12/0mr28
 WK15bp8lEL1XRB97EcK5odUjp/9bW82hqOOZphGzWSdpr+IuZP6KqGYEumx6nMdsOcx1t2XPOmD
 oDEYte+XsODGqBMX4lNLu/IoEf69WVijWNleEiznfK7K5Y1a1QUpKh1geFCcv1AUWYX9VaxDJL8
 W9pOxbLPf08dGIqoyQ196UnVbgCdtC62QKhlq4r+Q3
X-Gm-Gg: AY/fxX7TNkwZQeieqbnLQD9TWrt5OE9XDqlRAvwPGYFLwkh0Qo6Jnj5R3tWsHc6QJGJ
 uuapRpzaJaDsaxZ8HZEmqO5esaMfIFxrdkMumDvaYO2SyIeUo67cMhfu3f3lnzWXFsTa0wEcG4t
 lNjKbiByGkGPGvhu2SXYLx6w9U8LdhoTYLNCPtBWaMvDCXCVGQ1rR3Zj+2HSrkRYdBbiido3ZyZ
 45+s0kle5K1Qev1bhcxxzZMGw5moH8kvM9CK80FZ+cOQXYcEBnzhR+JxVTYP4EeEJSWDHbaT2+M
 C92lAt8z5QnLkyNzpyTek5IZF5J1M13GvrmhF1pt55kgegom/ZKPCX4Mewx31ni97B86S1CvLsX
 ci5FDIK1A5suAJIJk5mU6ocu+/2/RpkXkYUBp2QqAnJjqKhtRvBtefwLd960nIclU/xc/DjVkOR
 Pp8Pfmej8jZmUo9xM=
X-Received: by 2002:a05:6000:7:b0:431:3a5:d9c1 with SMTP id
 ffacd0b85a97d-4324e4fd96emr22656037f8f.30.1766829100219; 
 Sat, 27 Dec 2025 01:51:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEY31mxmfCWucBpyKHqFftrJiaElJQsYiHv8K6zcwNmqy3Xepah1QX0RpQRFzNvdWR+8CxMA==
X-Received: by 2002:a05:6000:7:b0:431:3a5:d9c1 with SMTP id
 ffacd0b85a97d-4324e4fd96emr22656020f8f.30.1766829099708; 
 Sat, 27 Dec 2025 01:51:39 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325b6bfe88sm41939069f8f.19.2025.12.27.01.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yu Chen <yu.c.chen@intel.com>
Subject: [PULL 146/153] dosc/cpu-models-x86: Add documentation for
 DiamondRapids
Date: Sat, 27 Dec 2025 10:47:51 +0100
Message-ID: <20251227094759.35658-72-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Current DiamondRapids hasn't supported cache model. Instead, document
its special CPU & cache topology to allow user emulate with "-smp" &
"-machine smp-cache".

Reviewed-by: Yu Chen <yu.c.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-12-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/cpu-models-x86.rst.inc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
index 6a770ca8351..3605d05a8c4 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -71,6 +71,26 @@ mixture of host CPU models between machines, if live migration
 compatibility is required, use the newest CPU model that is compatible
 across all desired hosts.
 
+``DiamondRapids``
+    Intel Xeon Processor.
+
+    Diamond Rapids product has a topology which differs from previous Xeon
+    products. It does not support SMT, but instead features a dual core
+    module (DCM) architecture. It also has core building blocks (CBB - die
+    level in CPU topology). The cache hierarchy is organized as follows:
+    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
+    CBB. This cache topology can be emulated for DiamondRapids CPU model
+    using the smp-cache configuration as shown below:
+
+    Example:
+
+        ::
+
+            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=thread,\
+                     smp-cache.1.cache=l1i,smp-cache.1.topology=thread,\
+                     smp-cache.2.cache=l2,smp-cache.2.topology=module,\
+                     smp-cache.3.cache=l3,smp-cache.3.topology=die
+
 ``ClearwaterForest``
     Intel Xeon Processor (ClearwaterForest, 2025)
 
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FA3C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAj-0004aP-Cy; Fri, 11 Sep 2026 05:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA8-0003yi-Q5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA5-0008Gr-Sl
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+sod/F5ZJD19JAbUugoGre+d4N7kWAhYD4EQjfTMC7Q=;
 b=Nv2eG2cRH5KsuS/WWn8Whuih/nBW9yKQaE86LegCGImnitsLzRovB7kh4Yplmiow2LUN3a
 oenSaDLSrRunelg88Kl2nSI9BW3dABC0etFlDq9Z1W4Z6guwLAPJyAt1sajlRc0doQT93O
 EVcYU3gZsUILMUcBsf/jAvTUhm5jj4A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-Vp6hFUcZPH-H2O-C5fmDDQ-1; Fri, 11 Sep 2026 05:03:07 -0400
X-MC-Unique: Vp6hFUcZPH-H2O-C5fmDDQ-1
X-Mimecast-MFC-AGG-ID: Vp6hFUcZPH-H2O-C5fmDDQ_1789117386
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f1eee015so121917f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117386; x=1789722186; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+sod/F5ZJD19JAbUugoGre+d4N7kWAhYD4EQjfTMC7Q=;
 b=L2YI4hzdTgM8OrxejdgvPpmSyyh0ZI7sAOCKPdDwwvDy4rOQQA2PeO4LqUGuRz0fGx
 sEcYCe+6yKAtQF3c4coR59HDCUIYoNT9cDESEthd5cNApg2oZR5BOUt5AIof4fErlOqQ
 u41PDw5pNFK4wHdIU+1pumd49S4dkg41ZZUSillf7xE7Zy1U5ohOk1Bohl0R2HQBAiZU
 CY8t5PJTnJ1KhtmTyp6XWKAwFiMmi1Y/nBeoVkurcA8U9jLBNh/Dawo5GOeCYQyxQ42Q
 p1u4K+auO1KJO5Hn6rkYZtEO4MtLXTtL7mXYCbf1u5w/a8ZidyFRhQ3FzY1a7rwdXyJ6
 lg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117386; x=1789722186;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sod/F5ZJD19JAbUugoGre+d4N7kWAhYD4EQjfTMC7Q=;
 b=cjw0sbGd+wPLvg+hoU9LgnwCdtZiC3xMWyaBsTv7g+7P2hAk+WKiWWxhvun1DmLsXi
 jfD7hW5lnQEIZ088ajmfnP0D5jTpJSOQJ9wX27ZBMqTTDwOPZVapl4PjKHa6nMnxEyb5
 XegIkd0adjWG87j9gBBNeKI8BGpYC2Y+pY3rcyv69QyhRHLV8pXfjp+GQLQq9/GGPjzz
 PEKKtYNT7DBk/FjcFde3RLqVOUjzEbBCSalReorrXmVu7Tyl1GFjHVwlDIdp1nF6756T
 ti97n6sjDsXQq9TVhDD9mZjQQWqrw3Notj+EgZpb5NexZoNkNAccG29JMn4omKFdATfJ
 5bNw==
X-Gm-Message-State: AFuF++mUFupViEApZaR0kXcvIjqcYZmy/mXHa9QxwSur2KX0KFQTMpa4
 MZLoSMV1xe47IlVVvy62cVQMH6DnWq/0M8rtfNllpBqaRBzySfCW5tapOkP/OEJuBTsfK/Xcbek
 9VdYWGY5Ptx1OL8FbQAahtO8NuuHF8Ky9qA4VpvHMSkzw/A65uNPt3p8w9dOd09I2D4VBmXvYBc
 N5QkKzqk/eIB3xSQ2Rcf35TWrlHFppXM0ylg==
X-Gm-Gg: AYBFou2KOWOnAREwSkqu3EnvNh7vP39OaSJ6BY5mC4p2UE+dHvQjNjEZufDniK0HYf+
 3j6F70YyuPSgv1T1ilpdCxOk9KUUmKGDZ0h5anYEmKia/BtTClrd074+pxImTivcWjEAaYMi1WV
 ykfKwtN2L6NfDj8v+hq/FrqtJ52XNkzsN23QW5LU05j4C6J1vUTlyUtTxCjSL1qBPe2RRPy4pku
 IobDWDwM3/xeUqczAASW3pKDzk9l4sod6ISMzMyagsfpIb8p1hD0KvrNrvTIIPaBrUdne62Aa0F
 XOlgxS5BG0h7Gm/LXXKdNquNuuUh+2mTwNya1GXi5Y6im/C67DGcJuH/eIIrqCCYaJV0VjfH61n
 0o1tSC/Mzmb3BgGrVDNtwzZ8=
X-Received: by 2002:a5d:5e82:0:b0:485:8101:dc40 with SMTP id
 ffacd0b85a97d-486eb2d8278mr8393074f8f.9.1789117385592; 
 Fri, 11 Sep 2026 02:03:05 -0700 (PDT)
X-Received: by 2002:a5d:5e82:0:b0:485:8101:dc40 with SMTP id
 ffacd0b85a97d-486eb2d8278mr8392907f8f.9.1789117384948; 
 Fri, 11 Sep 2026 02:03:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35c071sm4601237f8f.33.2026.09.11.02.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:04 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 44/75] amd_iommu: Return empty efr for stub call
Message-ID: <85e4587c2b3000c1dd2626664741f1f27e297773.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

The stub call should not return normal EFR as it is used as place holder
when actual AMD IOMMU calls are not available. Hence return 0.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-2-sarunkod@amd.com>
---
 hw/i386/amd_iommu-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu-stub.c b/hw/i386/amd_iommu-stub.c
index d62a3732e6..fb36dee903 100644
--- a/hw/i386/amd_iommu-stub.c
+++ b/hw/i386/amd_iommu-stub.c
@@ -22,5 +22,5 @@
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
-    return AMDVI_DEFAULT_EXT_FEATURES;
+    return 0;
 }
-- 
MST



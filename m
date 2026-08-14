Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41F8C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuorF-0002bV-0u; Fri, 14 Aug 2026 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuor8-0002Zy-7c
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuor4-0001ij-8R
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786702176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weNCvrYxiG1ry/VVeRBPbdMpdQuUb6BkoTQLxb0Mqas=;
 b=HyKYou2YcmzgNFfXMocUtvPxGZmURLMbBORCpaHginr/A2vxkVKxS5KiVuGFVa6utBl2mZ
 +Aj8RV2BwXYrRdqHy9mwWSvKy9MVxiAWJGZJ2cUFb5WT75+DMg6GYr94zxvO1hxM1+iRfR
 BSl2i2zr0PiTniD9W7ZXN/Gzae5B8e8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-Ym4cSchnN3iQCUNHilpgIw-1; Fri,
 14 Aug 2026 06:09:33 -0400
X-MC-Unique: Ym4cSchnN3iQCUNHilpgIw-1
X-Mimecast-MFC-AGG-ID: Ym4cSchnN3iQCUNHilpgIw_1786702172
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F6C71956080; Fri, 14 Aug 2026 10:09:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01876422; Fri, 14 Aug 2026 10:09:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: [PULL 6/6] hw/i386/amd_iommu: Avoid undefined behavior in
 amdvi_setevent_bits()
Date: Fri, 14 Aug 2026 12:09:17 +0200
Message-ID: <20260814100917.163448-7-thuth@redhat.com>
In-Reply-To: <20260814100917.163448-1-thuth@redhat.com>
References: <20260814100917.163448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The code in amdvi_encode_event() calls amdvi_setevent_bits() with
start = 64:

    amdvi_setevent_bits(evt, addr, 64, 64);

and amdvi_setevent_bits() then calculates:

    uint64_t mask = MAKE_64BIT_MASK(start, length);

but this MAKE_64BIT_MASK() macro shifts a value left by "start" bit
positions. Shifting left by more than 63 is undefined behavior and
could have unexpected results with different compilers / architectures.

Fix it by using "bitpos" instead, which was likely the original
intended behavior anyway. (bitpos is calculated as bitpos = start % 64).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3633
Fixes: 1d5b128cbeea ("hw/iommu: Fix problems reported by Coverity scan")
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260731140229.259272-1-thuth@redhat.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 90252c52af4..578c27ccbef 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -323,7 +323,7 @@ static void amdvi_setevent_bits(uint64_t *buffer, uint64_t value, int start,
                                 int length)
 {
     int index = start / 64, bitpos = start % 64;
-    uint64_t mask = MAKE_64BIT_MASK(start, length);
+    uint64_t mask = MAKE_64BIT_MASK(bitpos, length);
     buffer[index] &= ~mask;
     buffer[index] |= (value << bitpos) & mask;
 }
-- 
2.55.0



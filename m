Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2300BC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xB8-0006y4-Pc; Fri, 11 Sep 2026 05:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAd-0004SM-Fn
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAb-0008LE-1H
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDN0pKO3NI28SBsIJ08S3mFqoBiJB+cbySC7sAon6z4=;
 b=TVT2cqUXUcy2niCiGJ9qzO/ZgJh8xvmPegxlvQvtfyRtAT+Bnt21X9s943MV9tPRhhurxc
 7yRgguLw23UMoXe5Lpekw0nAeWLyQg1gxp+Gg92/FCS3k/p1QW1T+QaHthIvpSqc1PcaLP
 7SoHzSTummIpZFzr/doD62/7J43kN8Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-H4ZKI3e6N_CVIKBW0x-lsQ-1; Fri, 11 Sep 2026 05:03:39 -0400
X-MC-Unique: H4ZKI3e6N_CVIKBW0x-lsQ-1
X-Mimecast-MFC-AGG-ID: H4ZKI3e6N_CVIKBW0x-lsQ_1789117418
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so5968715e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117418; x=1789722218; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mDN0pKO3NI28SBsIJ08S3mFqoBiJB+cbySC7sAon6z4=;
 b=Cg615xuICHM+PCQxPdYjvttLbnes2E7kOZ28k0s591zzFNKPGlpPfJS4V9MysZ81kF
 ZSqBCU4x9zceAdkY8z8e853l4RDKQFEV8azPznNLmksS02XXiO9uIJuYu4REacwE2Zbl
 Iyeav7xXigc9bhINlPZBQgNaqyyQbLewPxTbIqNxTjcTiQ82n229xszlOOOhKbEGpW+7
 Jtfkt7C/VIO5UIzQoL/HIfSPIr0U2PoU0Agz6vk5DcKEwYTDrRN1TOn49/HFDkgiHLu1
 4+W7gW/9YWBr8UB0lbGbuGd23Qrv6tPIYVxLMasgL9JW9Xf6ypo7HXnWoOR85pxXVG92
 haIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117418; x=1789722218;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mDN0pKO3NI28SBsIJ08S3mFqoBiJB+cbySC7sAon6z4=;
 b=YKOpRw6zJoytbkeIcaHhwt0tbDtRy6b3fJ9SCaLmbBbt6vH8E/scnCKP5V05iJEG4j
 2AiMw080gg5pR3SFYnx494myw/EtB7ligoKtFtVpw82hcwTJqEtpTaJ3MTPHbOpb+ifu
 NUk0Tr1Mm0Lc+TuW7MimC5SIx/CRfeJcOUmrbzfDHW2b0UnmCEKLxGVy3Vc21N5MNiyI
 nSgFHTxyrkHEjyvQQ+IkMo6VPuuV0Oi0T0hZj/LPKzM3GA9rZB0CbdD+r6GBb4NhGLB+
 1x0VHJeWBetb94RAnnX5YwYjBX1H731U06izZohh8Un30G8w01yZNUmNuhHAzmxq72bt
 a0Ig==
X-Gm-Message-State: AFuF++kjg8FwdmOOkNP6MDqW88V5w3tNwlBku+vkcjN/WwZ8TanVHamt
 5kt/KCIZK7FMTMQW8M7Wrbo9DcPQ5ArlUADpjWhGhSTF/xm1i8AaWve77RTvSNb/VbsfEUNYWjw
 xtdn2lkWlvL4gLVaxuLHqUAiqEfeXue23TUaqiQDhjSPdF6+aPjrhnekMp0rKAfCiZ6/ciA4JcO
 tUORpS7n/tBwoNoDWXDteM2mvapuExvoIL9w==
X-Gm-Gg: AYBFou1ytALWyVLqn2v9//u6LwwkMyAyxXR1vtfJr3dxkbcAzNyCvyuJhdwcQEJ7LWt
 lJY3i9IwIQvtDr5maUzJ7mg//QvQfAE+C2/3Kq0wSwdFhQhMRi58LbUBoOPMd3SlhP//3e99AS8
 j0FzydHqt8iCk8dPEeMdYu7m5KicJeqYtT7RI6K9fIhs/Xoq8dMuc7KQusQkUqKnY2pgW7kDLWB
 D/aBn2AZpg+jaI9WK0sni0+jy9KRH8IHYBI/DJrXfURgZgzJiAlA1DxaRSxeuZB5zV1TFf7CO1M
 EWgX8mZDqmDNnht9Iw2w8k3X9SuDhqSI/nB6ca9z0HBxYuS82zann5nAj9ryF+6TXpZsq7Ftdjd
 I2kkXFmkGNvkmYzQk+O+7bsU=
X-Received: by 2002:a05:6000:430a:b0:482:fb60:2f0 with SMTP id
 ffacd0b85a97d-486eb2ec2dfmr3661518f8f.8.1789117417810; 
 Fri, 11 Sep 2026 02:03:37 -0700 (PDT)
X-Received: by 2002:a05:6000:430a:b0:482:fb60:2f0 with SMTP id
 ffacd0b85a97d-486eb2ec2dfmr3661452f8f.8.1789117417091; 
 Fri, 11 Sep 2026 02:03:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm4641204f8f.9.2026.09.11.02.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:36 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 58/75] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Message-ID: <c52b99d58b88922718df52a0c4da56f9f2660e13.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

Setting the dirty bit without the write bit in vIOMMU creates a spoofed
shadow stack PTE that misleads the guest OS. This results in infinite
PRI requests from the device, as no actual write permission is ever
granted - the guest OS treats the PTE as a legitimate shadow stack entry
and considers the permissions already correct.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903150649.2281104-2-clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7c442a86ca..eccb16346c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2039,7 +2039,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
 
-        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
+        if (vtd_is_last_pte(fspte, *fspte_level) && *writes && is_write) {
             flag_ad |= VTD_FS_D;
         }
 
-- 
MST



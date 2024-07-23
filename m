Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6A2C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDCY-00067z-9v; Tue, 23 Jul 2024 06:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCT-0005XS-G1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCR-0001m0-4z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzUslSpv+tevRPtwsSDiIptOoVAEmUbWgTJDTpf/8Eg=;
 b=S6YxBldOImiy/25yeTrFfisjV+4HdciBctL5RUTzJq085gpYw7xHMgBOhJ28N2hARtlbQg
 KN02j1xBWTiuV8HNx6vXXOgxG4k/+zDldpvRlkv41slnqyDtgWiMzwWZUBHj1Nho4k2GDd
 zKL31IbyjPPlyTWVlOqrkVlX5w4+83c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-jHHNXMuIOqGxR89qSrvmng-1; Tue, 23 Jul 2024 06:56:53 -0400
X-MC-Unique: jHHNXMuIOqGxR89qSrvmng-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a4c36f66c3so2157364a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732211; x=1722337011;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AzUslSpv+tevRPtwsSDiIptOoVAEmUbWgTJDTpf/8Eg=;
 b=lGx5UkE93Cl9XhZjYzqzS9RgTHmGKT14/8PasrkhpRg0esuPjy6W48chvJEzph49wB
 zVolVroPU98Wk40gLxa5KfRVRe5HRmGf/ockHgk7SgbYDRY+sd++CGOfJnZu0toeZeuO
 ceP3aZvF4cKdiEYZfKz0mh8MHWVDMAOtl6o60MfZ8hS3d7lcepi8ZOIp61iG81WyokTD
 EX9jof6/kHCT5+bM73SPzEj/i1d0qqhkad8v4dTzivU71i27UdNuW3TIbLG7oKNHliiA
 9P6SBNCkFcf6EYseVwSGmM9vdQsSA1tyDfum3YDZxs/xd7GU3BO2K+6t6eNB6XZKonZ0
 zt+w==
X-Gm-Message-State: AOJu0YxBLWVqmvC2X8yrz8JMIyQAgJtVa14KBGY0voUQNib6ZENWSHJm
 0m2JZYmsJasFxPIPG20bceNoDTa5lBd34jX3lCLDcOE5ebeAbbjf29OOR5O6L4J2SwLWDDmnw48
 u4wMuCfYHnqZMLDq3UCMUKeK4zhxL2pkZLfwwXbR+FSTgdj6coFmh0uldO4d9xwMme3Crx68RaG
 iKXu41KpXKAsCA/LA6B3g+/hzNcTy/4A==
X-Received: by 2002:a50:d703:0:b0:5a1:6c50:a3d with SMTP id
 4fb4d7f45d1cf-5a9425dcb32mr1784973a12.20.1721732211518; 
 Tue, 23 Jul 2024 03:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Bf2C7fYAddN+JwEXsuze8rTSUY/vvZLURON/scoIZsM13h8EivqGbiTLJ7rlwCtDFVOQAg==
X-Received: by 2002:a50:d703:0:b0:5a1:6c50:a3d with SMTP id
 4fb4d7f45d1cf-5a9425dcb32mr1784951a12.20.1721732210988; 
 Tue, 23 Jul 2024 03:56:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c7d213csm7307711a12.80.2024.07.23.03.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:56:50 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Minwoo Im <minwoo.im@samsung.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 18/61] intel_iommu: fix FRCD construction macro
Message-ID: <a3c8d7e38550c3d5a46e6fa94ffadfa625a4861d.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

The constant must be unsigned, otherwise the two's complement
overrides the other fields when a PASID is present.

Fixes: 1b2b12376c8a ("intel-iommu: PASID support")
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Message-Id: <20240709142557.317271-2-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f8cf99bddf..cbc4030031 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -267,7 +267,7 @@
 /* For the low 64-bit of 128-bit */
 #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
-#define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
+#define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
 #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
 
 /* DMA Remapping Fault Conditions */
-- 
MST



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFC606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=V4FhHKuN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbS-0002Y9-6n; Mon, 26 Oct 2026 08:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHP8-0002kq-UY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:12 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHP7-00080e-2F
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008449; x=1824544449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U6hnYornSWU43U02GU6HnS0UKYROmnqdzpVcvZQfMTM=;
 b=V4FhHKuNUpZnfxpWwfHjv03XWkAz5Hbfg/H4dJ/nUuRuDLnKXBY3HsqR
 U445KestR//uSwxx30S8OOrzqfT53LU5TsqVLfj+LsCRuIoy4j4p3k3Mj
 oSzIC4djGNIw+D4pZT4/noNsyJYm22fPJP2jXV8qqN6sSfGDbRbSk/De7
 tYlWS+TITId6lyM8tWgOFrCVfXIAg/dgDEX6M+y28+PPJlIpTy+xTG+gn
 tUtJ7gSQswOOgRZjfCLXvwlT/ynvAw8ZWFfx8aWFTlKxDIjOJwVSV0VrR
 OsR0HhI2GtBu8nYLq917WQES0O/N8IJVkrVkTmFJIIsIsW/pTCHgSBoTg g==;
X-CSE-ConnectionGUID: bAPuUB8CS0ORLCj39yeXTA==
X-CSE-MsgGUID: uKPf1mmzTHyZGB7trHwzLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="238359875"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="238359875"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:07 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 453B41C000CF
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:07 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTP id AD3C9C00420
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:06 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 75DB92069EA7;
 Mon, 26 Oct 2026 18:54:05 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
 linux-cxl@vger.kernel.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 1/7] QEMU/hw/cxl: add program-hdm-decoder option for CXL
 Type 3 devices
Date: Mon, 26 Oct 2026 19:03:22 +0900
Message-ID: <9c6f4c19cd72085432734ed6c427201f853d2bab.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.252; envelope-from=fj2110jc@fujitsu.com;
 helo=esa7.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:14:56 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yukiya Takaki <fj2110jc@fujitsu.com>
From:  Yukiya Takaki via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a `program-hdm-decoder` property for CXL Type 3 devices.

When this property is enabled, QEMU will program the HDM decoder so that
the guest can automatically create CXL regions for Type 3 memory at boot.

The property is a boolean and is exposed as `program-hdm-decoder` on the
`cxl-type3` device. It defaults to `false`, so existing configurations are
not affected unless the user explicitly enables it.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c          | 2 ++
 include/hw/cxl/cxl_device.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a04dc74ecc..b65ddd264d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1360,6 +1360,8 @@ static const Property ct3_props[] = {
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
+    DEFINE_PROP_BOOL("program-hdm-decoder", CXLType3Dev,
+                     program_hdm_decoder, false),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa5f9..a2c830d181 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -777,6 +777,8 @@ struct CXLType3Dev {
     /* BI flows */
     bool hdmdb;
 
+    bool program_hdm_decoder;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
-- 
2.52.0



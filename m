Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0181CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB6n-0005uC-S8; Fri, 13 Dec 2024 14:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6l-0005mQ-6O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:51 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6f-0007SU-9Q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:49 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-294ec8e1d8aso1684567fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117223; x=1734722023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHwJArgtR7CjMdMdWS4p4NXW2ugDhJf5dpnL9eQostM=;
 b=SXcrlsGG66rbccSDoUWD1lH8x2od0SxfJZHZxdxnKcKYGBBuVDiI7yShG4eukwvv2F
 Uvo8dNNeaPwwqGSluNxgV0NYolYt9WPx0vKScg2OIAsOgbu95RdJSgFmsDvk6MG0w5Ws
 OeFnboJIuRgUmGyR6ZAAEC/5I/Jn+Qcv7nHktXmn56r8cK/bELpLjSQs+jwr25GeUwEz
 YWC19wtI9jcOkjVJiHOsRT4yBdrF3+BgBLAsncLIqFJZLC1Dt3ZGm6CIt4A4Uaz8wQOF
 JXBAgnxT2tWCEpCk4Gum7exoagOmJscOwapKnQYlx4I8q8HQQzJGzu8ueJCxdf6TAqMQ
 XksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117223; x=1734722023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHwJArgtR7CjMdMdWS4p4NXW2ugDhJf5dpnL9eQostM=;
 b=W0MEv4eNDea/DWfOo/W11maYrVFGnMwRM6zWH4rutMo9wxOw4XERYGtd4vwojuaxQf
 DA4SfbsvWMJ6pn1Iy6mqCHVB7VwyGv3SA9sHMfMupeBzRIThgWHkpULZKAEwkZF2SnDV
 BDC1KygG6+P34OvLKAkM7JxUN198cRFkKvMLSqbipDD/ukTtqA1RbKYrS7WjjkjTKlFr
 c3+WJ2dTeB8cnZz0O6L3TvZ+9UK/2dxKNOL/0RG7MQMVDAak6r32HOsG2RZuIkc0oWYY
 ih3/C3IUK+XjsUX2P8oXC297vB1qVLvx8WRisA44/RzWi9aJmspFoQ57/xQ7MnQZmCgy
 mbxg==
X-Gm-Message-State: AOJu0Yz2+yFQhN2K4Rj19xF4HmZEg7gWTjT37Tuolxp11070YTDsxqyC
 j2LKOnyUVla53LoANynEWLY/T2UviDTB/nHiWg5hEUhHA7ZKj7IlHOMijqGxMyIZ4lRLRUw9MUZ
 lzDVVxxYM
X-Gm-Gg: ASbGncs0Iw6Gc+uKorDfcAQ3hMStFS2Rc6UyRH5+Ix1/EpQV6na6hoGgoax5QSgc8KE
 tWn07tJQBkS38N6qeS7QSqNxHZmli2KKx90mDWgmVGQo6AZev5pMjLHYA4RM/onHR7Ckb4Giyws
 XYxviDyzKJXQ2AY3uzLUQvQf5FVe9lI9eFhFFY5h8pZW9WeB7MtgMMbCNqn20g8/gL3TKDkh4l+
 vu6Z1pkdKMGcBd85m3VT6Ocw+3uPBdtlNOrhN8CQvcA+xKr/F0pdxpY9h51ts9R
X-Google-Smtp-Source: AGHT+IHbX9L4Xx0OB5O23fcpRCWFzJyjyxEt1OLlDmWe4wASoffulqhcIKDCrBwWWRj+lo4Hi6zISg==
X-Received: by 2002:a05:6808:f12:b0:3eb:5ab2:5db2 with SMTP id
 5614622812f47-3eba69993acmr2562050b6e.37.1734117223453; 
 Fri, 13 Dec 2024 11:13:43 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:13:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>
Subject: [PATCH 37/71] hw/mem: Constify all Property
Date: Fri, 13 Dec 2024 13:07:11 -0600
Message-ID: <20241213190750.2513964-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mem/cxl_type3.c  | 2 +-
 hw/mem/nvdimm.c     | 2 +-
 hw/mem/pc-dimm.c    | 2 +-
 hw/mem/sparse-mem.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..12205c4d32 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1216,7 +1216,7 @@ static void ct3d_reset(DeviceState *dev)
 
 }
 
-static Property ct3_props[] = {
+static const Property ct3_props[] = {
     DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *), /* for backward compatibility */
     DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 1631a7d13f..10506d52e4 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -246,7 +246,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
     memory_region_set_dirty(mr, backend_offset, size);
 }
 
-static Property nvdimm_properties[] = {
+static const Property nvdimm_properties[] = {
     DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 27919ca45d..49c5f9fd44 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -150,7 +150,7 @@ out:
     return slot;
 }
 
-static Property pc_dimm_properties[] = {
+static const Property pc_dimm_properties[] = {
     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
     DEFINE_PROP_UINT32(PC_DIMM_NODE_PROP, PCDIMMDevice, node, 0),
     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 6e8f4f84fb..8d681adfc0 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -96,7 +96,7 @@ static const MemoryRegionOps sparse_mem_ops = {
         },
 };
 
-static Property sparse_mem_properties[] = {
+static const Property sparse_mem_properties[] = {
     /* The base address of the memory */
     DEFINE_PROP_UINT64("baseaddr", SparseMemState, baseaddr, 0x0),
     /* The length of the sparse memory region */
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C28C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIAQ-0004RK-L6; Wed, 26 Aug 2026 14:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIAN-0004Qu-Mw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIAM-0005LA-34
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787768161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjayTqoTQhg8go9dspt4rTOPn2fzR1zd1pP5i8DKHGg=;
 b=CExWfnDI5B1Xv1n2zAonox96PgNmOFxJ+J8Ov5zWuCP04bmuHBSBXphLedT634I3IicMh+
 eb5AI3P8YFnCwhtrObY757sWpprEjMYiI6Ug+5TZRIy4qgpWnnEmXmLiXbf2na55XbzglV
 Us46r+AaTxQPAxHG55rdT56DGj+e4BA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-cvfrQ6QVMsqssp1339BIcg-1; Wed, 26 Aug 2026 14:15:57 -0400
X-MC-Unique: cvfrQ6QVMsqssp1339BIcg-1
X-Mimecast-MFC-AGG-ID: cvfrQ6QVMsqssp1339BIcg_1787768156
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-69e984607e7so1314341a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787768156; x=1788372956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SjayTqoTQhg8go9dspt4rTOPn2fzR1zd1pP5i8DKHGg=;
 b=H/2TEoYkrmJm+KgQbUQGEmpICP5fGhIxgAmr0oOGP4BGgrwOGvyLYmUI07KsGVqZa8
 BsbW5oU2MGZt0JcKhmch50mXe/7UinhcURch+U1sWWaw1/DxR/5js40cIclJqeTTSD7I
 Ny+8rrnP0Layifi1qH/ZFHRAfaaY2MBVxU+XGKpkGt6dCzXgZyz1me7fhykFmYUVSBhD
 X1aachOqjb7Ddp9EyOc0ws0x2IuFIsIwmMrkdCFyZfKBFimtc0PIx9sUd9o05B42UOFk
 rWOVWxcukXCAjV2o3Fd7OsFSSFCgDTrRYrXaoaMFA/9/UkerbdvkKFaDzgcp3oZe/zTg
 wjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768156; x=1788372956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SjayTqoTQhg8go9dspt4rTOPn2fzR1zd1pP5i8DKHGg=;
 b=B58mPYI1eg2IxqthRo0TADzBGuXfirJg1cSRBkzJxpAXfMchqNzCQRBmVdI4tlbrHa
 t3thZKSmJcdsDB4KRO62R5kIQax1LztvqXg3cLxKnUx7UDhhhXe3deS/NcnmvsatYrnT
 d9IwEuEdWTQuKxOCtv4k7mTjR96lQY1UstyVuDyfPJ79lF6qwTA6qRbRvlZic6QEA7x0
 Szt73XSd9xDGk1dh2lz0gKfgqfEIafrrWFco0KdAvcV9oa7U7KpvAfDzkicRRv7ShyCa
 jJzCI+4FfPqkwZQi6CTndQvR5n/yiFvm4xrL4I4BzrzKbwmqthh+1daGYjRBZaI6+Rwq
 QWbw==
X-Gm-Message-State: AFuF++mB6TMJ4v8wxk9aY00nQ3VRoznOXJnfTt338/WSOWQu74Uv/t5w
 2Jueu5mzMmdTqtcDhbmHklUi7pRimvlfBqWVsFnOa/hRwZyYcCtUyo31lu80X22bOZ9EXbljIYD
 VeZKRWlH19vcfGQkjlXJkJtr/9QrMr7fXbDDI4ulapDyFBU1/xze/ZzU1ZAhhwxKN8Z/cFxW3aM
 z1Axiivkrk/ZL1fQt38vv7meWxFRJh16sW3Lk8RvIw
X-Gm-Gg: AR+sD13/CsW7ZAJSIfXJXyA9Jqk7fxpx89WdSzLtIOdcaIxQcffI+xI0AwS5/xJnq9M
 mnZBjxOvPdSIMDf95JufhauIxENWBmSyTcpJcNP+Lg83cfn+rdfrYyET1Wn66wFkuJm6WHkZtca
 +bkF0PNCPPhOmaFi5yQqeXm3VPylM/LWQgLAZ99jDIo5UL7M3ybKnSMgEQ/0f/9yZKhTL24xKl0
 phPnSpkEAps67/JiAIV7A8sP0WAdiGSdjGKAFGwblr9YWKLn6c1fZIj259LPfdJt71k7B9VtA26
 owRvXTLB+l87GSQnzzJVkaQMQLOyj4SLNkOgUGfdPhQsqrKG3ILkmmcI7hRZkUm8TZ+Ts/x+h8O
 fs35OmS73BFkka/xP0/hrMgrMIfhEz+9QFxadSq6dzD1OI6096cHiwKnMjqkfYNzvufcG/yrGvq
 ulwA==
X-Received: by 2002:a05:6402:2350:b0:6a1:1bea:8ea0 with SMTP id
 4fb4d7f45d1cf-6a5df5c6814mr11912812a12.3.1787768156437; 
 Wed, 26 Aug 2026 11:15:56 -0700 (PDT)
X-Received: by 2002:a05:6402:2350:b0:6a1:1bea:8ea0 with SMTP id
 4fb4d7f45d1cf-6a5df5c6814mr11912751a12.3.1787768156017; 
 Wed, 26 Aug 2026 11:15:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deac24f1sm4968130a12.23.2026.08.26.11.15.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:15:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] i386/vapic: unref MemoryRegion if vapic_map_rom_writable
 fails
Date: Wed, 26 Aug 2026 20:15:49 +0200
Message-ID: <20260826181552.848617-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826181552.848617-1-pbonzini@redhat.com>
References: <20260826181552.848617-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

memory_region_find returns the memory region with an elevated
reference count.  Drop the reference count also if the memory
region cannot be mapped writable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vapic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 8dd9188d96f..78dc2312bca 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -602,11 +602,13 @@ static int vapic_map_rom_writable(VAPICROMState *s)
 
     /* read ROM size from RAM region */
     if (rom_paddr + 2 >= memory_region_size(section.mr)) {
+        memory_region_unref(section.mr);
         return -1;
     }
     ram = memory_region_get_ram_ptr(section.mr);
     rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
     if (rom_size == 0) {
+        memory_region_unref(section.mr);
         return -1;
     }
     s->rom_size = rom_size;
-- 
2.55.0



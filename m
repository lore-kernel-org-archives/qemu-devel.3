Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DB2C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8zS-00009k-R4; Thu, 20 Aug 2026 16:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zR-00007W-FJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zQ-0005Fo-2Q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NobUKJlgERSbbOMWLyOgwAcR7VK/imHBSmo75lvip8s=;
 b=UlxrjWOezoPy4taMZw8fZtTUAXm7zBydQr64XhljnWRcvJApEk+mabNPF3TY/k8wwwKF2R
 iAu7qUWon0zK+WsInyD7DL48vUGRbrfHrX3lj8C/ff4YPoqIH68ZtVVLWuksPVsWR/Gd8I
 A/Jv8r0b9NCfgf7VYJfxXfSKNuWWC9g=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-awsIEHd5PSaXtod2jS49ng-1; Thu, 20 Aug 2026 16:03:50 -0400
X-MC-Unique: awsIEHd5PSaXtod2jS49ng-1
X-Mimecast-MFC-AGG-ID: awsIEHd5PSaXtod2jS49ng_1787256229
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b0e7370be1so223182eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256229; x=1787861029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NobUKJlgERSbbOMWLyOgwAcR7VK/imHBSmo75lvip8s=;
 b=YsAqX1unqHXwuc5iA3soBBGEcz8pLznL8IsM1oZh+MGo8HiQM4CLZbY2Nppv1fpZfk
 Kkm6iCb7jCTSMk5A0CJcMds9kiH2yIz4n6zEIN1767KwB58GH1rxGAMEhoHa70pswSUX
 PbXKldjI/hudc16XS0+E/GQLeA0ZuxjQqaULOoETtywiPa7dez7i4DSqLq3lloSIb3DW
 rIU3UJ2BbS77dVmRqxNDZYhuqlGanfKl91jPQIDrMX31wxTqLdMvblN9oW4O87vCVQg2
 4OULpKYTv/vIPRhcbHfotuFkQTQcMeGR/pW/mpjF8dP5RrPY0VibZvgtYrTKeavfyIjD
 CrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256229; x=1787861029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NobUKJlgERSbbOMWLyOgwAcR7VK/imHBSmo75lvip8s=;
 b=HvVBROxnDsBKgSiNm/9mvBxweTGtXUc5TPUWa0WpiWbwOOJ65IryI9IcEGWz+4HvFH
 gTQK1xh0FpxXFjLOheT65V9ygNeVuQulIRr4PUHYLV7AOkWAfYv+YzO4YqIf77QaYPHJ
 3F/jUKsNaxlQ9zCsNub81enBkPbmQVKfRJE80/dy2A3cCz838g057bdNz1cJOhfH8Hmr
 xCBSg4PxFiEq2mnOi/Ic0CgruE6opWd4H45OK8fdDq+WB9NXEtmqL3EDgDIqZUZkI4Vy
 z3NhHN6tL/NkP9/3kpXxW+jN1x/wdEefqE14OBZYAEmtxHSS7ppJ+PXuC4ALRcuXfkMi
 qgaQ==
X-Gm-Message-State: AOJu0YyNvzzFtBWEpkV47UlaERXpyDlVrFAQDL1okGAayuLVkdvyy/f9
 NHFP7W5VtzMuy2m2+OEfVy8boEIe7EYzYu56QgYA+ypUCt+kW74eFxwC24S/OxQXx7kuyKKmCT0
 Iq8ojKGj+FIVXHJaBVYh0h1vtEgMToqxJJMrPmj1969p6iI6g+el7D8Xc0nDjlapm3pwTxHL2cc
 mOIyqLKTdEiE9A0ooDzM+URDZkghssfd/LhiI52A==
X-Gm-Gg: AR+sD13FTy73scfllZMwesl8WeIJ0dgJnhQIYW493VnnVEszlI3PNoso0RuO8D6qL0E
 7/v4Tla1/ak5BvucF/pm786NpPMRxfuZkGVJE24GzyE6xDZQcu7N76BfGb/jxmJCnkTuJR4bl7I
 DbjAh0nMsL16/360A7c86JCDQYYF/+abwdqXY1tIS9sfxYkWQ8/AMlI1VDK9QOl2/A11BTZBStc
 zETD5LsiDX1BCxKUxMSkO3pkzZDVnsgOlCQxIayqBigCHJ9uf5oswEWkYqsoI0Q92VXN/sXOpdy
 +smaBQczTmxnc1iim99m5+QTn6rjLlmconZ8erVSluld3OQua4m0yW6HX6j31noyLNmbNOjsAfV
 E4ACVGRV/76/aJE4g+yeOyDbnbO8/rkgIDSAXcGrweqNylMYANQrqeM5AywE=
X-Received: by 2002:a05:6820:6aca:b0:6a1:64df:7324 with SMTP id
 006d021491bc7-6b15ac82525mr498131eaf.7.1787256229408; 
 Thu, 20 Aug 2026 13:03:49 -0700 (PDT)
X-Received: by 2002:a05:6820:6aca:b0:6a1:64df:7324 with SMTP id
 006d021491bc7-6b15ac82525mr498041eaf.7.1787256228788; 
 Thu, 20 Aug 2026 13:03:48 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 05/10] migration/rdma: Drop RDMALocalBlock.unregister_bitmap
Date: Thu, 20 Aug 2026 16:03:17 -0400
Message-ID: <20260820200322.3321036-6-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

Not used anymore.

Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 63a8370be2..f9f3940256 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -198,7 +198,6 @@ typedef struct RDMALocalBlock {
     unsigned int   src_index;       /* (Only used on dest) */
     int            nb_chunks;
     unsigned long *transit_bitmap;
-    unsigned long *unregister_bitmap;
 } RDMALocalBlock;
 
 /*
@@ -577,8 +576,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     block->nb_chunks = ram_chunk_index(host_addr, host_addr + length) + 1UL;
     block->transit_bitmap = bitmap_new(block->nb_chunks);
     bitmap_clear(block->transit_bitmap, 0, block->nb_chunks);
-    block->unregister_bitmap = bitmap_new(block->nb_chunks);
-    bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
     block->remote_keys = g_new0(uint32_t, block->nb_chunks);
 
     if (rdma->blockmap) {
@@ -663,9 +660,6 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
     g_free(block->transit_bitmap);
     block->transit_bitmap = NULL;
 
-    g_free(block->unregister_bitmap);
-    block->unregister_bitmap = NULL;
-
     g_free(block->remote_keys);
     block->remote_keys = NULL;
 
-- 
2.54.0



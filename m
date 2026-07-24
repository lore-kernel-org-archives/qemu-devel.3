Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AEDC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHlT-0004Ub-VJ; Fri, 24 Jul 2026 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHlR-0004Qu-UB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHlQ-0008Rq-C5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784906679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ay04XcglQ+BYq8kOxs/s7bi2XnPNmC1IOwCeeW4oP0=;
 b=Z7vd16ssOU9aKhZr2D2pL3FI5H4SwqLtFTFSDmDelYfKpSS95ypbQvmtW8FItKB2oZB1Hd
 a9hPnv8V49vHeHrkMlZ05pB23iedPgKZi53vQ/SCgoMhEynlFDGrsNCdosEgF7uOeMwClm
 8IVKAiBPtzg7z7IE2ecL78quKQoHaqM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-0v9iGQURN9CiJ0IzGD3EYw-1; Fri, 24 Jul 2026 11:23:31 -0400
X-MC-Unique: 0v9iGQURN9CiJ0IzGD3EYw-1
X-Mimecast-MFC-AGG-ID: 0v9iGQURN9CiJ0IzGD3EYw_1784906610
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so298328f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906610; x=1785511410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Ay04XcglQ+BYq8kOxs/s7bi2XnPNmC1IOwCeeW4oP0=;
 b=nyVEAXZXYj4Jx8dxDYyH0O+DPua58uTvX7IZA4It3Q8d5k1b9vYl+E2mKQVf0wDqGU
 FsHQtc4WjLPKDpp9PRIwFnyrfz94fTb/HJ8xcGc5LwAczq/e6meRZXTI4sbA6eJIC+Cx
 Pl1GIDubIwP0UcdhK3ppxVUHd9Hub2+2MYnTifqUKgydnbPX4QF2hxbudtc3GBWEpauV
 n15/V7pL/jc7U8gCGE1gMfHbZ/pT92PIP3LzgXN7k5IPg8vOqtGR7r9TF35im+ICDVIb
 JHJm04bAzzz8n9JuuwQqveOELc9HlYHhps/UXweHIsg6hs3fL6ZpItun1ktnjbRUJcxB
 01yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906610; x=1785511410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Ay04XcglQ+BYq8kOxs/s7bi2XnPNmC1IOwCeeW4oP0=;
 b=hb1II0buPSkB0kk21FJSTVH+8AXc/IVqSRm4jU/0q/lXLVeJ2oNaGP93K0MjcFhi79
 nQWo1b/vws2uDoPVhrK8b59fIVEJYQof3hEVRu4ELNtJzFjXlLruaYvCG73fXlVVz0FN
 moI6Ar6UuGW1K9mhnayFfzDH2kffD+EEoE0wZtXzGwnKr6vjmnQfVTSGtpC5hw7DoLPE
 Zq15JNC/O+Vc/yKcmpb2wBnd+vLlzdBf0EW8MjoolzIhaag6zr4fdkiPNwixmaCgi3Lr
 +svC2ToEoldI4S5EywcUzjhGbzN2H2rksE6j+g599wAMd4eNV2ZnvxYl9ynxJl5KRTJS
 kcuw==
X-Gm-Message-State: AOJu0Yw6gAvVt0q8FTlbOS7Dyi+eGTko9b/rKYV6Z9fCHQsQRIaDp/Lu
 /8FB20FFGn4t/Hn+Yt4iCx0LP30JDdIshsSE5cJvSG+oU3AapvHVnrYvzcSSX6/Bi/bT16G8E3A
 NGzSscPApCVpAnTyVaDmqhN/Vdnr2/Wmb0HsFHxQ0lqAxTzZ6XFkR7vLx
X-Gm-Gg: AR+sD11xPzXQReyjEI3Auipo0O7Zza9CTTh3ZpXdLEjXdCMuV6MR75z0HjLS6uIhnVQ
 I6KVMqA3xwahLKbqk67mjzeiNLD+WD6xA8RX6KgMWqRkxN7f3Q2H7/+ZZjTbArWnprZ3MC8lAjb
 DF3Wly27pQyJQVSd/rTxYwz2qN3OVXIZ2qKaBtvlAK0hM0FOp5YOD15RtYhC/LSmd+0Mozkb010
 abz87xMwQstNBB7Y7f2+KhC5vOjG8BAc1esnEDCQhhprhIggJIZ/9M5zrd98lZi7+cVLZvnyaYI
 qMj8/5HiC1JK3+SeWcY05B6ymJuZl4BtuvYHBCVp8Jq1T9Emy4+zvu1sELssMqJRxJPULHh4KI4
 qgFnpc6va312D7PG9tuDgvMK6121azXc8qnhwferPSn3VeVsotQKsapXrVN4=
X-Received: by 2002:a05:6000:2304:b0:47f:8fda:1af0 with SMTP id
 ffacd0b85a97d-47f9cdaf475mr1436038f8f.4.1784906610369; 
 Fri, 24 Jul 2026 08:23:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2304:b0:47f:8fda:1af0 with SMTP id
 ffacd0b85a97d-47f9cdaf475mr1436002f8f.4.1784906609981; 
 Fri, 24 Jul 2026 08:23:29 -0700 (PDT)
Received: from localhost
 (p200300cfd7075d8bc03b74903e90fa9c.dip0.t-ipconnect.de.
 [2003:cf:d707:5d8b:c03b:7490:3e90:fa9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm27143970f8f.7.2026.07.24.08.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:23:29 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 5/6] hw/ide: Have ide_dma_cb() complete accounting
Date: Fri, 24 Jul 2026 17:23:14 +0200
Message-ID: <20260724152315.234183-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724152315.234183-1-hreitz@redhat.com>
References: <20260724152315.234183-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

ide_sector_start_dma() starts accounting for reading and writing, and
ide_dma_cb() is supposed to complete it, but currently does not always:
In one case, it just forgets it altogether, in the other, it uses
block_acct_invalid(), which should not be used after a cookie has
already been created.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/ide/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index f78b00220b8..d18adceffc0 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -878,6 +878,7 @@ static void ide_dma_cb(void *opaque, int ret)
 
     if (ret == -EINVAL) {
         ide_dma_error(s);
+        block_acct_failed(blk_get_stats(s->blk), &s->acct);
         return;
     }
 
@@ -944,7 +945,7 @@ static void ide_dma_cb(void *opaque, int ret)
     if ((s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) &&
         !ide_sect_range_ok(s, sector_num, n)) {
         ide_dma_error(s);
-        block_acct_invalid(blk_get_stats(s->blk), s->acct.type);
+        block_acct_failed(blk_get_stats(s->blk), &s->acct);
         return;
     }
 
-- 
2.55.0



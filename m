Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4459410D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BBG-00061S-0j; Mon, 30 Mar 2026 07:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8y-0003f8-DR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8t-0005y7-Mt
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZniXf7Th5qb+Qh//mdwiOoh7tVxEGpoHVgDrxDagI0=;
 b=KB/VfMbtqK6bMrjtJwfH4KpXTuGE4O1K3SnuPN+ABW289q7VLJgVWUhNXybNdj9epy9XnM
 QtN+4z9ZXZOhoNFIJ9OMZ2tDCFY8ER84SvbkdwXmj+endNfUzrQbGNw3cpmNf7tjDf4hw0
 0tGtPmm7mHZ547pmpwynqjdA6W5q8vM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-y289Jhn0Mz-lR5DQiRtV3A-1; Mon, 30 Mar 2026 07:50:49 -0400
X-MC-Unique: y289Jhn0Mz-lR5DQiRtV3A-1
X-Mimecast-MFC-AGG-ID: y289Jhn0Mz-lR5DQiRtV3A_1774871448
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48544725bdeso59210715e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871447; x=1775476247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZniXf7Th5qb+Qh//mdwiOoh7tVxEGpoHVgDrxDagI0=;
 b=JUE7o5SbsIu0VNykv7x7rUOgOWWLF3LnG+ydd9xFOAtdsXGkro7xxgJr+W/SKjNSL6
 d+EOIf/r5Lsq4UAEzJ+tCF1eJ9s4GO0flNs7jfev5x+hbaoGf63FLuxmBeB89sS3FFy2
 RxmD1laIv5VgXAq5Ndjh7/c/o1NN35x5m0Hkg46PnN0VyG9kQARr9/u1FKpjHKyPNxCp
 fo9vbIxl1a08jpC4DAAaEpYZYKy3CqEAI90j1+e8Rqv9fd4zXYXCDBOv9AqHNzYlaYmj
 D01g8XAjGenUm4cG+EPFZmKI7Tgxr30HJPu2B4wVaF/Afr7817ziUDWWP5F4Ey6+l2op
 KGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871447; x=1775476247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iZniXf7Th5qb+Qh//mdwiOoh7tVxEGpoHVgDrxDagI0=;
 b=GH9FUb/pz+OgWGzH1dj7F+UNoMvhv9kN9wGeOiyDBEo8iV263Ngez8KosMv5hhHvwn
 zVE/4XNekV55/cO3xRv2V2LBz39XZ7cRyTfOb83J10Di4qRQADZtxkWsa1MuLj5d7P55
 zvmwnh4p83oeKMv2dzRaO/Tahqc0LmKWVgMa1EtOOtR0oZMFRCnBnztvPp5tpOYjx8LP
 UfrmGiLRkRCMByIR/GLC6Tu9psfxVKjAqaNnMnWGUrMFv99wgTFjWAL7g2UKRVxUlwZD
 F9DkMW9xGyui0+jhgbkkjn9TNiBaSIS26eerwNy/j3BNRAmoZiwr8EXBsuDg+wGmbggB
 8UMw==
X-Gm-Message-State: AOJu0YxDg+XPxiM543ftOYv5BY8h3D1fcb7tQ42e6AygPB4s7F30+7O2
 W04eBzIvXFp3Kf8jgbVrDQAhzDF/lZXenTrVeOSGefGwt6tQizpJxn2hF/i8m6xLGweBDgACFnZ
 gCZeD/oaebxHZSW3ImltpfI6jYpt8AMWUXXrUKO37GvDFBWtpunebbSiEWJ4Fppn2A3SiPE5VQD
 7lHCdeGllyRVEZqT9AQgtHN9AAiLN1h/KXKzJF7YIK
X-Gm-Gg: ATEYQzyrlPHbmU7bQECfvm1cK+iWPKhH2vHkT7oSZhFlQiArkDNcvI0ORjxXpKu7RwT
 WxZ3iX6xpYb0zF4VpGkYOr3s6ThVk0UdtXzaOHUocmxR5KieW1E5o10CDzlIPPOIv4Sn4j6ooVW
 4I6f9g/DdqFpBvIdPLT4gBuzomBs55+3rI3wm8m0HOK974xQyEFyFrj9FKI4P+CKX6Gs7gvp8pI
 zj/pRWarOgz584ReyDEkBmeBN3S+zgIhjHDvdEmuKLiqCBWHrZJeP4CXTE+G9Irs3TqZS0xuz5K
 J2zJSzkhLZsI/1Fxsf5Thz6hoM+Amre3fGGAsAiEVEsAfVxfnwWpFBXVMHVH8SA2X6/tkzq+2Ik
 b1zP2YuL/VCv1GT2aSEw3Ir3wL1nIiDDCEh42WKa47a7thJqpFfVJHRpKKyM9K13EWUYiROP5j5
 cFqn17pM3oVErHhOvSBIzcEZ3u
X-Received: by 2002:a05:600d:8451:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48727d4596dmr178503015e9.3.1774871447242; 
 Mon, 30 Mar 2026 04:50:47 -0700 (PDT)
X-Received: by 2002:a05:600d:8451:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48727d4596dmr178502605e9.3.1774871446690; 
 Mon, 30 Mar 2026 04:50:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730688694sm164169325e9.11.2026.03.30.04.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jihe Wang <wangjihe.mail@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 11/12] lsi53c895a: keep SCSIRequest alive during DMA
Date: Mon, 30 Mar 2026 13:50:15 +0200
Message-ID: <20260330115017.256211-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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

Reentrant MMIO can cause the SCSIRequest to be completed, at which
point lsi_request_orphan would drop the last reference.  Anything
that happens afterwards would access freed data.  Keep a reference
to the SCSIRequest and, through req->hba_private, to the lsi_request*
for as long as DMA runs.

Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index b882fc02276..54123f77579 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -637,7 +637,7 @@ static void lsi_do_dma(LSIState *s, int out)
     }
 
     p = s->current;
-    req = s->current->req;
+    req = scsi_req_ref(s->current->req);
     dev = req->dev;
     assert(dev);
 
@@ -667,6 +667,11 @@ static void lsi_do_dma(LSIState *s, int out)
     } else {
         lsi_mem_write(s, addr, p->dma_buf, count);
     }
+    if (p->orphan) {
+        scsi_req_unref(req);
+        return;
+    }
+    scsi_req_unref(req);
 
     p->dma_len -= count;
     if (p->dma_len == 0) {
-- 
2.53.0



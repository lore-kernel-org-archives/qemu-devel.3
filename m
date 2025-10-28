Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED118CCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmf7-0000Gp-64; Tue, 28 Oct 2025 12:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmem-0008LQ-NL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmec-0003m2-Sp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7vN7dYOLZeNiNRrf7J0asvJiliVksASXq2s0Nvc4go=;
 b=cim9FdY211QsVrTCLjxaqv5EbmfyZOVNxYz+jvxxDG6pxxZsvJXQs8+y2bzw+y6/doxQEr
 p+1fnATNtUpsHN7E9HyWGketqQidn8TgkybcR0xLeXzsP72xewyEN+tAVW9NYim9/y+znG
 i+ofaTqEsqZCHpkgBtrgw5Ki9lath/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-P60vn5q8MU2jxtbqBljKoA-1; Tue, 28 Oct 2025 12:34:32 -0400
X-MC-Unique: P60vn5q8MU2jxtbqBljKoA-1
X-Mimecast-MFC-AGG-ID: P60vn5q8MU2jxtbqBljKoA_1761669271
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475dabb63f2so15603535e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669271; x=1762274071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7vN7dYOLZeNiNRrf7J0asvJiliVksASXq2s0Nvc4go=;
 b=vteG4aMgcfRZRF6Nj54ErcLU4/j8LhInUh2MrfZKAkPRXO7aNqplRpKrr6OM8uWOAV
 BFTiEtOPfdbaBMcZ8w/Ud2I3ADABFaaTTnO52OCnmSdt8OrMrcLJYBStUzxT6oygZT1i
 toiPIqWXoKbyccWGtQTGWPHeekqouOJrcMClohSs1ktSySibeXaPOAqlQSRA3yPKIfIN
 yMsckO12uuVv5tWDZoq2OLo7VXQfgH3c9LSOnKjLp1M4SC2aADchNo+16nWejaaoGDWt
 I8KJdIehMURR4rfowcbIUcM1QJEegxLbiPR3o6X0BUH8vFbEmvzO5mKLUXLKPaZI48Ci
 JX4w==
X-Gm-Message-State: AOJu0YxYrw+Ye+Xjkg0m+6sckDhXDClPhJAL2NP6ovItQ9pRRvSBobdP
 mWA74yDwYrCtXDP2K03OrEnMVdxwykR9ftXYVvI8C4WhYMVKTbgC+ICde2X/3UEt+OQJRD9zKAr
 HECIjpizzsrzJvv6XdQWUD0q2S9340reGzcFNVVidp+UttOWSJdXcK5iX
X-Gm-Gg: ASbGncsB8jkEC5tNY9yArsdzbbjNX0OG+EJD9UTjmOUZlWHiAmEEvOJ2R2eGjmGi6ZG
 cdeUuk99W84lGkQCF+HtOzPSqUcpp8fXGsJMkX503tW8SaGH12VRp+PmH8IAIREAWbBVwxNmini
 mSmDFFzwtACK8YLUSCSc5aRj+4YSjaqZuRzACwdPLjhCO2GIep0k4HrdBKI0NuxtiHCEYgKjYkS
 Toj/F045FAto9pZDF+eSysGkMmkPD1R1LERJAEkymjcE9hGBcVn4PLM3k58iVjwaVQ5vEaASaZs
 EvBz4j7xX/EtBov8y9Av/bFzasD+36y607fKV53P3L4s15E1ygTW1KIrA1sy4l+VBb4bY3kTP9h
 eOPGorKaJCUN/WfFxTQx/xJlUM08439xn639luQu/Op1TJgeIQoPemfkCcA==
X-Received: by 2002:a05:600c:310f:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-4771e3339c3mr260715e9.13.1761669271126; 
 Tue, 28 Oct 2025 09:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYdxb5RuBi2BxLrhzHud9f3ArSrcaCNYdXmynVY1hNDnIS8dWweyLNA++8eM6eDEVpLgtluA==
X-Received: by 2002:a05:600c:310f:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-4771e3339c3mr260425e9.13.1761669270690; 
 Tue, 28 Oct 2025 09:34:30 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e39380dsm95705e9.7.2025.10.28.09.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:29 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 14/16] iscsi: Create AIO BH in original AioContext
Date: Tue, 28 Oct 2025 17:33:40 +0100
Message-ID: <20251028163343.116249-15-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AIO callbacks must be called in the original request’s AioContext,
regardless of the BDS’s “main” AioContext.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/iscsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 76c15e20ea..fd51aae692 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -119,6 +119,7 @@ typedef struct IscsiTask {
 
 typedef struct IscsiAIOCB {
     BlockAIOCB common;
+    AioContext *ctx;
     QEMUBH *bh;
     IscsiLun *iscsilun;
     struct scsi_task *task;
@@ -173,7 +174,7 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
     if (acb->bh) {
         return;
     }
-    acb->bh = aio_bh_new(acb->iscsilun->aio_context, iscsi_bh_cb, acb);
+    acb->bh = aio_bh_new(acb->ctx, iscsi_bh_cb, acb);
     qemu_bh_schedule(acb->bh);
 }
 
@@ -1007,8 +1008,7 @@ static void iscsi_ioctl_handle_emulated(IscsiAIOCB *acb, int req, void *buf)
         ret = -EINVAL;
     }
     assert(!acb->bh);
-    acb->bh = aio_bh_new(bdrv_get_aio_context(bs),
-                         iscsi_ioctl_bh_completion, acb);
+    acb->bh = aio_bh_new(acb->ctx, iscsi_ioctl_bh_completion, acb);
     acb->ret = ret;
     qemu_bh_schedule(acb->bh);
 }
@@ -1025,6 +1025,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb = qemu_aio_get(&iscsi_aiocb_info, bs, cb, opaque);
 
     acb->iscsilun = iscsilun;
+    acb->ctx         = qemu_get_current_aio_context();
     acb->bh          = NULL;
     acb->status      = -EINPROGRESS;
     acb->ioh         = buf;
-- 
2.51.0



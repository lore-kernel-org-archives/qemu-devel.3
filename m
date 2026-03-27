Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358D810F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EhM-0002ui-KP; Fri, 27 Mar 2026 17:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhL-0002tq-Kq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EhK-0003dt-A7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZniXf7Th5qb+Qh//mdwiOoh7tVxEGpoHVgDrxDagI0=;
 b=PzJHE7O0cF8DZPtF3M7Aa6amVMUYiY7AauyF26oQIuNVbfATYhiIKiXhmkULuQJI+w/SHp
 kDm9OfYIklorzAztt49/Tm7VIxD4mwPETtVU4zyl+SrxVNoI/GPArMWX3ZeoAj6mEDsdcb
 J2H/xLDIZ30aNXOZQw5ZKKJHiMqbK48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-cjdAACioPq2zLwSPM7PsFQ-1; Fri, 27 Mar 2026 17:26:28 -0400
X-MC-Unique: cjdAACioPq2zLwSPM7PsFQ-1
X-Mimecast-MFC-AGG-ID: cjdAACioPq2zLwSPM7PsFQ_1774646787
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so1932536f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646784; x=1775251584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZniXf7Th5qb+Qh//mdwiOoh7tVxEGpoHVgDrxDagI0=;
 b=fPt59BAlMlA+BtANcCh+Vf4pk3nN3LKgMYStC2O7/ZxMxOudJahyK93Zo5p4GKwRHS
 C2rJMs1OVjSFGAq+eE0nbyYK9aUEyp0nJyNZUdpRr8wcGZ/zLheOLb0MOFT8WOsSbmCg
 3PjrRa0awNJqNjC/oE7X8DxSz6se+V8gqZ9pVYrIlzV7Gc30erKOVcHFfF8v+Wvq69na
 awn96dT2lZnQB+LXaf272Gu16jZtYC2ELR5FZ0xCHf/AubH9f/5//AXbq/ZPdjmheU/I
 Q4Jc9Ow0bG+ldn8Ijjt6U/wY4zpe9Qfevsx02OHc86AZeNAFumR0la3lQrRyDaUHzsCq
 q+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646784; x=1775251584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iZniXf7Th5qb+Qh//mdwiOoh7tVxEGpoHVgDrxDagI0=;
 b=RX0pwF8sAHwSwXWAXzmuJfNaWV6K4Qp2gC/F7fIEifNi0uNT9zscdZer4Jx5NARQHA
 bnU20pdfbUoguRmDkcodsLKLRD0xS0c4NwKVg6uccsta3N1bWaroO/DITeU5TS072pY8
 OolXH1widNc8iN+3pAv70lqobZ8AUsWSvTBBvlhk6xJ6j9AitkGbkxdAhKi+SMjLCWUq
 kBJHU+jBnbfiBj7f+EXNNNQ+K3M7NDXJtvPEYRc6T3i72go8QbOT0cEjuV6yrdi+4OBE
 0pm8aE82XnSNt9vy4fFBwbbhLwnIMYztj6ZmjFxKIDxGdw7WpiOPxkYvXAr8hPQcOT4o
 gmJw==
X-Gm-Message-State: AOJu0YwX2Z2g/dA0y39fERWBDtx3V+NGYf+qmhSq5qmDye0rt/78sfdx
 b8cSdbovTaR9Q/6ncEVloLt+M5vnxiDkDuYL9VaVxH43VTKavyDqZ7IGPQMFEO7VVUk9N4AkN4u
 SF9KQkFZRcY2m7KmgeT0Hn5WJekHwSL3OVTToM1cHGKOVEWT6B5V+CUAdQ8IHUnKC/cRPTLnkep
 /KuslbB2FnsFQQMyS4iaJgxTTiMhWJF6HgV8yjTLLR
X-Gm-Gg: ATEYQzy5bprq38eIe+NlaEwi6t+wpmgC3nYCALlqz+eU6dqrByrb0WQzNrg6mlbz9wf
 kBBJVmJ6aW73BK9+n7BzCxFKNfDXiWcxuizly+93xcNoK7DpyuOn/xG/X9mOy1LwBEuLZM3P7Ug
 ALafsILTlBjq6iJXQ/txdoTJwNmtaQswTEKwptxmsIjSIUTx78RYVRdJfOhAvykJBIwZfdqfkrm
 qw78+TIjsvHxtwx5HdhIihTlwDl3sml6tXRErgChyEvDnOoD4lYpl8Z3ao0Dek2xj5rWDRRu9W7
 gZ/pliwrjsz+whVKGAlXds1YHm+bDAYOQJjx1Nk2nb2j1iKjL1oEcn4TGkJe5JuRlVRlYBEKL4n
 qZ90PA8sWe0CrdMvrflFw/8qqGuD8D0DHRGkuEiumHYlcBjom8ytLAADXqr7OlRnEeOjs4O4gUO
 8bPx2ga3gZhu005+uB5bVDCHR5
X-Received: by 2002:adf:ec4f:0:b0:43c:dc99:7722 with SMTP id
 ffacd0b85a97d-43cdc99778amr1474189f8f.42.1774646784320; 
 Fri, 27 Mar 2026 14:26:24 -0700 (PDT)
X-Received: by 2002:adf:ec4f:0:b0:43c:dc99:7722 with SMTP id
 ffacd0b85a97d-43cdc99778amr1474152f8f.42.1774646783701; 
 Fri, 27 Mar 2026 14:26:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf1db08e6sm1906528f8f.0.2026.03.27.14.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jihe Wang <wangjihe.mail@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 05/16] lsi53c895a: keep SCSIRequest alive during DMA
Date: Fri, 27 Mar 2026 22:25:36 +0100
Message-ID: <20260327212547.460420-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



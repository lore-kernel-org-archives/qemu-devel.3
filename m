Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DD210F2872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Ehc-0003Fi-RZ; Fri, 27 Mar 2026 17:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ehb-0003FD-It
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Eha-0003hd-9w
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JQ9Yj7brdIqvdNhWPI2MQ1hWd0faHyBLi+vTK2i8O4=;
 b=fOzT0DfiufFm6ZEQqnxejUD09TiyLegGYt6AgNIdLWJiwx+ipUyU1LJXztEaQLRgcFoHgz
 Gix8rHmJhUwwxTj2BA7EIeYX4PnY0NcRe4aM+KKJxt4YS6HTtmhSCQtEb/RVk0ClY8e41U
 KGD6WZfzYPppyBfV3wQDbC1SbOuG8cc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-VCrYhd-3Nw2SuqOlQCfsoQ-1; Fri, 27 Mar 2026 17:26:44 -0400
X-MC-Unique: VCrYhd-3Nw2SuqOlQCfsoQ-1
X-Mimecast-MFC-AGG-ID: VCrYhd-3Nw2SuqOlQCfsoQ_1774646803
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so23885025e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646801; x=1775251601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JQ9Yj7brdIqvdNhWPI2MQ1hWd0faHyBLi+vTK2i8O4=;
 b=tkmaRVwFr5XSuv0Gmm07c50f/lxA8nq770VIQFjdZNkC1+DN2HEStNfpMVVMielXCP
 XHrOYygz7KIOk2JHH6ZS062U3XHsXSvELSVimKrF64TUuUubuIG+jPC2ouKTuE3cMMWN
 mfjVitJhC3DVLizpdmVrAQiydgG+v46JiZ4Y+LsESOrzzLrn0V4VHur7Em9nNWeFy1WI
 ACFBiaSkW8tEOuUHVp5HqjWPfvD4YvR9NcFowSRakyOeS6/KFIqS7xmrbps52Wde+eQ4
 UweWkzP2DCM+v3NlrdamOWSu/gbZhao6XWYQPrtRvZcXAhevEWjYNkbsLN9DLISU//gs
 5mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646801; x=1775251601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2JQ9Yj7brdIqvdNhWPI2MQ1hWd0faHyBLi+vTK2i8O4=;
 b=WSpggwNPYFIfnOCUjy9zrGk8aMV0iANaqc4YOQNwEKJjnumc6XqCZcdfeWexiBm+qN
 6tjiCMJLrys1PoUXdJMvFGBfRbKEukiyBNUadKRC7ipoqeJ0QNLTEHYRzHdR9u8Itwdm
 PGC3s/uvlSuMvVPpikmPHDagCvtcvZYrEacvsk+OiTtsCQ6VpcDtIf+Bu90/rs2LFgCj
 Ftb3ELsZBLjY7gb/7uYD6PU83R5YXo87jLFNR2tUtZRdh4IuBfBDolz110sAxmnPRNvE
 83srxYbn4RzUJG0z+Sua4oEmXWGSDlCR59aH+wYolHPVqITubY1qCiyxjM7CdYzaMB1i
 PGGQ==
X-Gm-Message-State: AOJu0YwKRx+ze54svSIisSqoBI5dJRzlO7hSUXFAfbZOKRWXX/IeCXId
 EBwKRWRXlOqy7NEqKjSuTH2pxsYLDHQCotCLYV/WXwKuwAeRWaUj0Ysykyt7HiN3QGzC4ocBo9r
 sli1oSmT0cXBpl0n+9DW5fOidICo163jFw1MW8YFBVYa3bJqgHu4pewRXH556tqvTlrIgl56VEe
 5cnvuTfEROU+9pxY+E9XUH87u2NpXCpxhHC/PE2ITu
X-Gm-Gg: ATEYQzxBlG7TOCZJbfgggFTI3PoCChppFVpE6l+ZCIRKkROQflz2RCBTVF/mJTdpBjS
 UpTtaGJ5IfyD5t0iNj43Sxpt4KmOxcu9bH7TAXxmXd2ucE3vv0p5G5wxk6eJKeAy3x8l5wG5UVF
 Zjp9yhkrCXM9xkCMHYE3ntVZospuQg0CA0u0/Q0SmdbCw7mGSbtPBRAYOi3TMuYllUkVvr/oNO5
 z8jw9taqTI68A9BclSPAvxmtOral1Fh45s78RuQ0eMPnkr0mBIB1L/IrSRDB9Zvux2AqmnIY1vD
 W33HywsCn3DU1JxQl6vbe9A4T3ya2Ad13d0eRcTwbQpHcAOccqvWoUo/OgouBAZJUgPNZL/EKmL
 jitO7vHFD95JcpRG0W6o7FVGP28KSRh/VvuH2piObmJwlPDnFGmdqU/W1bd+2RIvjd3uQaovkdH
 e+n+AEdKWYvG+Let0/ndOhPbQ0
X-Received: by 2002:a05:600c:524a:b0:486:f9a4:d487 with SMTP id
 5b1f17b1804b1-48727c816e6mr65883865e9.0.1774646801023; 
 Fri, 27 Mar 2026 14:26:41 -0700 (PDT)
X-Received: by 2002:a05:600c:524a:b0:486:f9a4:d487 with SMTP id
 5b1f17b1804b1-48727c816e6mr65883615e9.0.1774646800481; 
 Fri, 27 Mar 2026 14:26:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730688605sm13189985e9.10.2026.03.27.14.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 08/16] ncr710: simplify ncr710_clear_pending_irq
Date: Fri, 27 Mar 2026 22:25:39 +0100
Message-ID: <20260327212547.460420-9-pbonzini@redhat.com>
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

The same checks are done in ncr710_request_free.  If req->hba_private is
anything, it is the NCR710Request that points to req, so it would be
cleared.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 7113ce2d8a9..9832d833b37 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -316,11 +316,7 @@ static inline int ncr710_irq_on_rsl(NCR710State *s)
 static void ncr710_clear_pending_irq(NCR710State *s)
 {
     if (s->current) {
-        if (s->current->req) {
-            s->current->req->hba_private = NULL;
-        }
         ncr710_request_free(s, s->current);
-        s->current = NULL;
     }
 }
 
@@ -739,9 +735,6 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
 
 static void ncr710_request_free(NCR710State *s, NCR710Request *p)
 {
-    if (!p) {
-        return;
-    }
     if (p->req && p->req->hba_private == p) {
         p->req->hba_private = NULL;
     }
-- 
2.53.0



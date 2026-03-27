Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2308F10F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Ei1-000467-8G; Fri, 27 Mar 2026 17:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ehu-0003uk-2B
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ehs-0003kF-LD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnVwG3SYokTAtK+IdutEPcnvYRG2V0/1TTaen2gHy5Y=;
 b=fQ51BUr/kuv9w1x6hyjlYFdeieDPWaHuw+iw3m7ogoH6OYkxIztxwWXd1ZrU/TciPv1YN0
 x5HYsYLBg13xOkLWM0hXKTzSva6lQBA553baKYZd0laNYz9k7Pzbt7MAKoUpZU4Art7Swq
 L0aTjNIbUkl6lLhjwCZiEELkTj70Keo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-lCYxLqK8O3mwm2yFn9lluQ-1; Fri, 27 Mar 2026 17:27:02 -0400
X-MC-Unique: lCYxLqK8O3mwm2yFn9lluQ-1
X-Mimecast-MFC-AGG-ID: lCYxLqK8O3mwm2yFn9lluQ_1774646821
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so21694485e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646819; x=1775251619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnVwG3SYokTAtK+IdutEPcnvYRG2V0/1TTaen2gHy5Y=;
 b=aUPdS5OEBzduaao5rFw2sSJC09SdcHz23V3fSqNsv5hmXS82ABDHsNENikVo7buWzV
 EncIrHABmsWXzyhoeCPCLPiNYdt1pId9z4DnEyAMZB0xtY8gLm+9jciQF37psfwTmUaW
 +I+tFXWk9yv5uek20CQDIMXO+O0ZFOPYCRWSmGEka2DdmPzeEARI9zmNWOZYxCrjhpOD
 fqIHQ/GM/3kmXrYZrKbWJg+Y8CGX2E6oZ6ehcPpP5PtTxFPwPfMxomdiBsVo2QEe3wVn
 PNA/ujittKOx7zC0ilB4Qe2lGQhA3EmrbYRh3FbZvnQj7kMG3g1Bl4AlmNY4CSSX5H+7
 VAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646819; x=1775251619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TnVwG3SYokTAtK+IdutEPcnvYRG2V0/1TTaen2gHy5Y=;
 b=jJ66lg/8UvT7Fn2BKbGM6H+AwzvZRK85d6cN8bUpKbvQgMBEiW4aD3cL8WW8PWk1PZ
 STRm0fXJK5lKLVYTbwilJvrlcr2w//qMI54x3A9YQXWGKRV4gJKjY5piJe3SUAFyP4Bu
 2ZHRn0Z9ydLEjnmP+SJKA1hmXIC9wQXoXUoqii8UUvUnXGWtBsLDxGCcOEuAmMucYML/
 D8nUX39wXiev5feM4HKfu2Od5QfClytN5o4V4zmASk0iEopApFFSe9Zh+N7mJ1uAE6Jt
 sbQjnMbHaVhyMJaHJbDtcLKhwGjo9JYJMO9y7AqKSxQXMpyDMWBnpAcBh89/Mx8lU7Jg
 gXlQ==
X-Gm-Message-State: AOJu0YzhCUZXcom6slFIdCFrTOomwDuhl68Fhd0SOvVk9yGQtGFFq3jM
 i5Xk90ijzJtweDqX+LtRenf1P5AJQfu10CoCkP6sOfL22vUJdLVX4JL6Dzx9ifJFHnEv1LwykP3
 URQZ7XW4oY8SgZGXwIL5gv9R48DjTDRmm1PCTJOQ8dEiw6OJQYteTHyjMPvxWJJkRHqCVeyED0i
 kw87fqtYteNsHuFccj5X9R1CVZ14OEPH3uriHkXPWv
X-Gm-Gg: ATEYQzy/HjKv29GYhx6XiLf9xXv2m6sl3QkMMAms+l5ECrTQTdx1u/DOFSsIcd+N4c1
 HfAFJbDGiL3spkJrNLq0NAFIXjN8a4cI9D4WTIxxCIxCSJZCRWb66U9fpyl8d6RlEDrXSUb7Sk7
 Pf5WFnLBUw/GByOGYFWbzN5VTMiiqjwWUYpnDXE9OvP3IOiVtyasOmD9kC64PznhoIGAednaBLF
 87Mf2C/VPFet1P6OUZ+mQy0AB0sWo+He9GT2eTFLzHvHUwS+b8hhwK7cF9utQRUUy+mtOpU+Xbr
 SyN9W9x8adOogPOe+42/a+9skRAslEI/8xkSKYGuvpTmwGbj/k7Ql8KxaXmwCOnrNJ2Q7NFc0kf
 IuUUkAqFe/jigwEQaiFgXHm0Nm40hyORwBkv2tisg16Lm5Ljar7vYRV1h/Re8xFKakoFE9LCdxe
 IyCLgvCtFZINDYuHxxsE4kV90P
X-Received: by 2002:a05:600c:8589:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-48727eef71bmr55847595e9.16.1774646819411; 
 Fri, 27 Mar 2026 14:26:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8589:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-48727eef71bmr55847275e9.16.1774646818930; 
 Fri, 27 Mar 2026 14:26:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf247102dsm911762f8f.27.2026.03.27.14.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 11/16] ncr710: remove redundant req->hba_private assignment
Date: Fri, 27 Mar 2026 22:25:42 +0100
Message-ID: <20260327212547.460420-12-pbonzini@redhat.com>
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

It is already done by ncr710_request_free, so it is only needed when
the function is not called.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ff0d3cf0c86..fd03f243eda 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -748,7 +748,6 @@ void ncr710_request_cancelled(SCSIRequest *req)
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
     NCR710Request *p = (NCR710Request *)req->hba_private;
     if (p) {
-        req->hba_private = NULL;
         ncr710_request_free(s, p);
     }
 }
@@ -791,8 +790,9 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
     ncr710_set_phase(s, PHASE_ST);
 
     if (p) {
-        req->hba_private = NULL;
-        if (p != s->current) {
+        if (p == s->current) {
+            req->hba_private = NULL;
+        } else {
             ncr710_request_free(s, p);
         }
     }
-- 
2.53.0



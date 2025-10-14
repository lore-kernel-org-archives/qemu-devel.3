Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69CECCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEJ-0005qr-4b; Tue, 14 Oct 2025 09:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fE6-0005Y1-Jj
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fE0-000151-DE
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PuR7JKiNJ5s528urmAgX4g6HhfGe6vzMJkniXLSA/FU=;
 b=XOOEhVAeEvlCgZv0BZi7Bq3suxOXZtPNCEV0ZdcmX1gaDFutW/vzHUCQ9kmFedwvr9mzLN
 TP8BWNqpZL0OWzRFPdwq6dtA5g27gR5lT+Q4wv6hgxjT6s+5ZyxgGUt7if9g1tjM3Hsmpl
 XsPuLKvGgx6WB4Ejz7gdPf2lqb4Mtj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-nCe0YvFfPJiOyprMBpRSpg-1; Tue, 14 Oct 2025 09:37:56 -0400
X-MC-Unique: nCe0YvFfPJiOyprMBpRSpg-1
X-Mimecast-MFC-AGG-ID: nCe0YvFfPJiOyprMBpRSpg_1760449074
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e38957979so29727275e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449073; x=1761053873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PuR7JKiNJ5s528urmAgX4g6HhfGe6vzMJkniXLSA/FU=;
 b=ANIpRJJsukRGE2UJLlzT84Ck+9UPuUnPWvm3UN2lWUYCLBKu0mTr+gO01L1J0vMK9G
 IKozz1QuWyHwzKxvS8a57tuPrHCAzJjMpNgSrpbkEMlPtjQywUtO70s6P40dMfXXRv+v
 GSK+JgRH8oHViYYdtuhLeByWL2eRsBmCd8I5l/Pi2n0sL3kmpQ4wbhfn/NkGjFSBsvKW
 J5RK0SqFbq2q14psjIwpI+wNAoYf4mZfr/RnvmrkLlDivIMI4Dz9EWrBIcKnIV5oklIg
 jhraTbEnlEDHHgLsdG3U0kn/zghaXkJsR3Tk+ssjYEquTUmkjsdlIOi2kpzf7DrubydB
 2FAQ==
X-Gm-Message-State: AOJu0YyxUnWlvssPGbQbBsxXDDDKgziBHq6e0vHVrYX6cIikuV13Bcs/
 PNIziJopxQZJxGNO+Q4s6WEOuwE6yjr9XnAjx1AApaKdWZiEa2sosF9BGHNdPpoeckKPH9u9zib
 v+YLiW0/Imn7+XIQfqqORFOvUF6DBwRqTQDaAeGuTdsn8ifZaaaAeigOx6k9uq2l0wjb3xbGJKP
 V/vGFCQK4fLeCNRNoTeI+pHEMiU61AoS5ZcRk9YuAC
X-Gm-Gg: ASbGncuF/CqBFVdlm1rk8zGI4ooVIokqfkgTVmYfHwMg3+prUDWBxS7JnBzBkl48gLW
 7G58Sb4r+w/vE/gKZymtQSKY6Evvo1dgVEw5D3K/1S4ZOh0GsXuLUjWvBXBWSKPT4J+g/AiKRMQ
 9L1iKK2xvUA/JUambkyZ4H13M89KhM/S966klyWMfiQQbnSe94LESungU1cvVMJi/ZS7FvWVpZx
 0nuIzq5IjqMz0AKUJiJuffQpBrgZZbt+bKfXN6xpsNIice8Wt4/cPih7SAhqpVi04vjKPC803tk
 XF0ERbL0kTl69zT2Xu1CvWY7bzuZ6f1j9vsWRfIoatY1cDu60KM8OsSwTwosnhZg6fjaMkcu0at
 +8JvckbPwQ6+0qIeuCavyTcfMGHKTPudmTwe3GwohetE=
X-Received: by 2002:a05:600d:42f2:b0:46e:4341:7302 with SMTP id
 5b1f17b1804b1-46fb15396d6mr120879455e9.34.1760449073192; 
 Tue, 14 Oct 2025 06:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH50wa3Ls8wNEDNx3XBTk9SAL/tgppq/FP1cP7gsNmob0qLIM10/LrZ+4w1UKdT+/LbZtAuLQ==
X-Received: by 2002:a05:600d:42f2:b0:46e:4341:7302 with SMTP id
 5b1f17b1804b1-46fb15396d6mr120879245e9.34.1760449072779; 
 Tue, 14 Oct 2025 06:37:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d404sm23974497f8f.3.2025.10.14.06.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 15/28] monitor: clarify "info accel" help message
Date: Tue, 14 Oct 2025 15:37:00 +0200
Message-ID: <20251014133713.1103695-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In preparation for adding "info accelerators", explain that this command
is about runtime statistics.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index eaaa880c1b3..c2aa40056bb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -271,12 +271,12 @@ ERST
         .name       = "accel",
         .args_type  = "",
         .params     = "",
-        .help       = "show accelerator info",
+        .help       = "show accelerator statistics",
     },
 
 SRST
   ``info accel``
-    Show accelerator info.
+    Show accelerator statistics.
 ERST
 
 SRST
-- 
2.51.0



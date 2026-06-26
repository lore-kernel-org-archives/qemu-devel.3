Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF01CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3f0-0003IB-2y; Fri, 26 Jun 2026 06:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ey-0003E5-Jo
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ew-0005QR-Qj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MvxJQhtTKs4rTFMQQCaiswmThg2o/sTBst6a0P6uok=;
 b=Xmx7yklMS4s+8/nxV1dyqp/BhyLliNv8kuVtcNxVJKSDH9XMzFGfMNeIBeSLNFEczAhnQW
 ++QjoIfMOK2pp+qEZaIxCI+MDnM+Pem5dNzWsUZf72XIBqhI58L5pzYSPSPtbws3L4p4bn
 TBt7uhMUFrKagVfkvQraPSlW8+0DMB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-ATu-asW7OUCX6nrMuZZbdg-1; Fri, 26 Jun 2026 06:19:40 -0400
X-MC-Unique: ATu-asW7OUCX6nrMuZZbdg-1
X-Mimecast-MFC-AGG-ID: ATu-asW7OUCX6nrMuZZbdg_1782469180
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4924314568cso7123065e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469179; x=1783073979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MvxJQhtTKs4rTFMQQCaiswmThg2o/sTBst6a0P6uok=;
 b=T2mo8kaakr0A5VWFKZWon8m5JFGgn/L7RaV1bHIr2ijK0c6dViV78CgDXgC9M0JW3P
 CjZNvsOdk5Fx79gp7E7cXm4WgrEBZvfyRNGgRyuCQhyvej0T/06+f2+v9u5A3ILdIyqI
 OJllLxbEZJEFSgpPatWdLWgG8bOuO8Qq0oNRzR7yKfpGOChN+tFtwSJFpZWo100ex84K
 HBLdHtzURCJLcbLuLqoR94iJkdXLI03Jt3TdOiAqRmDbVgQzv7Z0mA6ZBw17GQfmrbBU
 WEJyfknCVa2FK/Qx4E/3AZ2a1/DkSszxQA77UaKzU3fIGQU6vC1vHtq4hHIk39J0hUDV
 8tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469179; x=1783073979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9MvxJQhtTKs4rTFMQQCaiswmThg2o/sTBst6a0P6uok=;
 b=O4q5HcNEYUAw4gGu5mnM61LIHmDvQdxG8gOFZo3m3tY7ucMEuQ/2HWS/H3CtjmYzqb
 ++4W5j5zmYcACNJizGSagOpCKoAc5rTzMbD2Z9Yp/XgzHuN133O4lSDLzVJJ+t+6vQgY
 G1abjoQdmX9FHIx7KPhDgs6mDx/7N4vRlmzYcUUkdPcy5+4ujTzLZrg3LkaT+j2ZdzUP
 xnNrIsntJiS1+ApOtDr8lbQj+guRm3AIe+7it+GUbBMvovwfyLFnbx0ZYYqZp6XlSpkM
 9ZKH3RNLswbGjsQQnuXzyFiyRpNe00FdjPdUfyasnJU2JqLSrwAsE5ijCuMnxMODyUMs
 xknA==
X-Gm-Message-State: AOJu0YyN4zmsPs3MQ0BjMN1IZgQVv1uNRG90Sxxi1BgzFerYjKXAe3bW
 ipJmcIdmi3SIrR5Sbm7MFwwO9wto8xLdjUjskaYgVmao90H7pklAwE3mHiSoYj4eThWspPiPrO1
 FPq8yOwf84bj2y2Q9dEUFrq9VB563QBan/GvXrcRxDxgtls6/czPuIgtwqb/0H8xKBZp/MDF0oH
 NbDWdW9PT5j8vWMaNI0yufjumNOImifm4AOTA//4mS
X-Gm-Gg: AfdE7cmxDaSHAPdrWEa9X1ckRw8Hw9gwD2tqu5Q+AftQWTBKLU9KX1nSAGJnG1X+Z+P
 Z0T+vVaxb4UGHY90Zf3tX7Qum6uvmZzO8pcPRu9jiqApie5cBTV+7zeDXdD6ZFmHSB0OuOxQtu3
 1eg9ib4tEJqaB8KYeXT+9jbCut3ITxJWZHqUThWRyT/wvHH9OtO8o8ijh4q49a1O14/we8jhmSF
 WUoXLBIvD+NgI69Scd5GMzJO2S4KMcQF3qN0SPdL7eZpN+GdqtUkYemfq/TdyM5gOuQnsgTfH3D
 mjfn9CdW3iYGlvw5SRRKbEln7/H3mb5P62mMjAhA2L1GL/1D9wTNxhl1FR0lH6rIXGignDjTMEv
 a/bJMMn6HjqA7KaTMmhK83PxuTQC7TKHD9JD80nQaXLq2Yh/Y4i4DQRlOqJEHKg95Rg+VyVi0k9
 mJFbSlotKKt8vX7VZk
X-Received: by 2002:a05:600c:c3c1:20b0:492:4335:4d4c with SMTP id
 5b1f17b1804b1-492668833c0mr72293695e9.30.1782469179596; 
 Fri, 26 Jun 2026 03:19:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c3c1:20b0:492:4335:4d4c with SMTP id
 5b1f17b1804b1-492668833c0mr72293175e9.30.1782469179012; 
 Fri, 26 Jun 2026 03:19:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269071c9esm64501155e9.9.2026.06.26.03.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 41/45] qemu-options: Add description of tdx-guest object
Date: Fri, 26 Jun 2026 12:17:44 +0200
Message-ID: <20260626101748.1728079-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Add description of tdx-guest object so that QEMU doc page can have the
description.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20260512084458.622465-5-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index a8ee5d14e14..f1874a05915 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6372,6 +6372,47 @@ SRST
                  -machine ...,confidential-guest-support=sev0 \\
                  .....
 
+    ``-object tdx-guest,id=id,[attributes=attrs,sept-ve-disable=on|off,mrconfigid=sha384_digest,mrowner=sha384_digest,mrownerconfig=sha384_digest,quote-generation-socket=socketaddr]``
+        Create an Intel Trusted Domain eXtensions (TDX) guest object, which is
+        the type of ``confidential-guest-support`` object. When pass the object
+        ID to machine's ``confidential-guest-support`` property, it can create
+        a TDX guest.
+
+        The ``attributes`` property is a 64-bit integer, which specifies the
+        TD attributes of the TD.
+
+        The ``sept-ve-disable`` property controls the bit 28 of TD attributes
+        specifically. When it's on, the EPT violation conversion to #VE on
+        guest access of PENDING pages is disabled. Some guest OS (e.g., Linux
+        TD guest) may require this to be set, otherwise they refuse to boot.
+        The default value is on.
+
+        The ``mrconfigid`` property is base64 encoded SHA384 digest, which
+        provides the ID for non-owner-defined configuration of the guest TD,
+        e.g., run-time or OS configuration. The default value is all zeros.
+
+        The ``mrowner`` property is base64 encoded SHA384 digest, which
+        provides the ID for guest TD's owner. The default value is all zeros.
+
+        The ``mrownerconfig`` property is base64 encoded SHA384 digest, which
+        provides the ID for owner-defined configuration of the guest TD, e.g.,
+        the configuration specific to the workload rather than the run-time of
+        OS. The default value is all zeros.
+
+        The ``quote-generation-socket`` property specifies the socket address
+        of the Quote Generation Service (QGS). QGS is a daemon running on the
+        host. QEMU forwards the <GetQuote> request from TD guest to QGS and
+        sents the reply (which contains generated QUOTE on success) from QGS
+        to guest TD.
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \\
+                 ...... \\
+                 -object '{"qom-type":"tdx-guest","id":"tdx","quote-generation-socket":{"type":"unix","path":"/var/run/qgs.socket"}}' \\
+                 -machine ...,confidential-guest-support=tdx \\
+                 ......
+
     ``-object igvm-cfg,file=file``
         Create an IGVM configuration object that defines the initial state
         of the guest using a file in that conforms to the Independent Guest
-- 
2.54.0



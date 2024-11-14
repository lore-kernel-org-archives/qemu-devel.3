Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BB4D41D46
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBYlr-0001cL-Cc; Thu, 14 Nov 2024 07:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBYld-0001bI-Vl
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:16:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBYlZ-0003lD-13
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731586561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JnPuj/Ao84HNRM35VmPWv8XIuBS/8IHZBk2XRpc9GSo=;
 b=UYJl/EaB984LvXCNplpO4byE9S7ynkQZv41pbr4pPVjIRTrEwVtNrpVYLJIbNUTTxVOPVr
 X7DepR1tZELdcHqTOMURNHQaUeM+wBMtuQ1m9PYZ7Hy9eG0NuDbgWzeZis5qD5cNP/XNOX
 xfEckWAX8uz0HmjZLyKelNxp4YBIa7c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-2qET0l3JNc-BfW6jzkKhqQ-1; Thu, 14 Nov 2024 07:15:59 -0500
X-MC-Unique: 2qET0l3JNc-BfW6jzkKhqQ-1
X-Mimecast-MFC-AGG-ID: 2qET0l3JNc-BfW6jzkKhqQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-432d8843783so4380295e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731586557; x=1732191357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnPuj/Ao84HNRM35VmPWv8XIuBS/8IHZBk2XRpc9GSo=;
 b=dnsQxKexpJIUKGmc2bOPf7WgRfnXSR5o+SlTj2dL7ttvxQ4upIu8uQdwxy8zH3TxbO
 hZ+g2ZUHTHSGr4lot8082VTznpQSpXPJEXfin3kspcdOaOXHgsJVHuaHzEtmk5rf488i
 2n3d27IG8cA4sACmnPgisOtAqLgoJfeCU2ReN71O//UgTykpVgbY+GGoq7/s6ARUuNwX
 rJv1RmUnVyxp2n7gv0ydDyKJCI/QFYd6VLuLwL3wiqsyy6X5Qsq01v28HBF8N8kawtCC
 JsHmnPRKceHifsOpZJWxlJ4mKspliWFuKKidYrlMKUNI9brGH10HFrnzutPFE+Gx0V06
 XgSQ==
X-Gm-Message-State: AOJu0YxsCcsgH+CXAyVCmP2Ht4ahdhRL+7nqLe0ZaqQ134NNet5di+tL
 zPrSdiF3iDNRFfPdWKrex0uZxuUUcmbQU9R6m5FayALQ9DD7DY1LOzktxshdzpZxoGcxxCEbliR
 JQMOOGk28EeO1tRZsC/R+P8UT9IDicpeAsbCvpsofoG01hkEkwpQbSNIfQZy0gDd8Vs4IH0+ZTt
 i28y9LX1UGB1CXP/ieVRHRb8dzHqPptgPArEI32h8=
X-Received: by 2002:a05:600c:a384:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-432d2730ce1mr87167865e9.17.1731586557279; 
 Thu, 14 Nov 2024 04:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiIYQqCgDRL1vOFT8fWhrLCGDN6nrS1BlflxQo2oDP48F4DqtdfxLVijegiyTI14Gx9Q8Mgg==
X-Received: by 2002:a05:600c:a384:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-432d2730ce1mr87167595e9.17.1731586556890; 
 Thu, 14 Nov 2024 04:15:56 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fe68sm22333395e9.24.2024.11.14.04.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 04:15:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] target/i386: hyperv: add stub for hyperv_syndbg_query_options
Date: Thu, 14 Nov 2024 13:15:55 +0100
Message-ID: <20241114121555.1697250-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Building without CONFIG_HYPERV is currently broken due to a missing
symbol 'hyperv_syndbg_query_options'.  Add it to the stubs
that exist for that very reasons.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/hyperv-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
index 3263dcf05d3..5836f53c23b 100644
--- a/target/i386/kvm/hyperv-stub.c
+++ b/target/i386/kvm/hyperv-stub.c
@@ -56,3 +56,8 @@ void hyperv_x86_synic_update(X86CPU *cpu)
 void hyperv_x86_set_vmbus_recommended_features_enabled(void)
 {
 }
+
+uint64_t hyperv_syndbg_query_options(void)
+{
+    return 0;
+}
-- 
2.47.0



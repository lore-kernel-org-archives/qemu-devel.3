Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A5EC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtxm-00045C-AO; Fri, 30 May 2025 03:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxA-0003Bt-Nk
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx9-00070t-6Z
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5KwiWwDCABdi5Dx/KPC7sBiQWwz9fnlUmiiw8lL6j4=;
 b=eifJZEIAXiLAd1YZ6zEjY4Dm83U+7vT8RYCHrHjy+RaAbP/vwtFVMoDrIJA/AK4hM6E+MN
 F1PSniFO+9aKMlqxgipyULJrZ97ONGr+/jMLSIQSSg2isuxAmeI9PKh/i8lVU9021htrek
 i+bHo+sM/6KonXYI+jIH1LpLwFV90ig=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-jfVxP3toMJaqV56bMC87jg-1; Fri, 30 May 2025 03:14:53 -0400
X-MC-Unique: jfVxP3toMJaqV56bMC87jg-1
X-Mimecast-MFC-AGG-ID: jfVxP3toMJaqV56bMC87jg_1748589292
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6045c7d93edso1359574a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589292; x=1749194092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5KwiWwDCABdi5Dx/KPC7sBiQWwz9fnlUmiiw8lL6j4=;
 b=TXBVSzkpuTcsmS7y9flfT+EHAeiWkuJuqI61MuvWZQeVxZpGEnRh/kr6E+psoZ/70h
 oVVD94HJS66VjSLcUe9lIJYwolwGogoHTR2oiQDgwDV4Wx/T9J/Wk9FcCRIReNDgxgXH
 gmJoTE3QlhubXsCF3r3eW460G8AzX5aXCMVZ1/hQyWiNhnVOOGyJneX3RegvlfJNK5c7
 P/AX4E044+AuTkYX3lD9tYFdtKzv9YpJP16rEQcxHlYtZkEwzOV7QjbFsl2O7Sw8HN8d
 tvvxKrA5V0qbBTwFL7hxSN/3Ds3QB2bFLpYPfqo9X11kaVo8Z21Onc5DGVLxZ2q6OeE0
 sb0w==
X-Gm-Message-State: AOJu0YwwkzrsEBAnA/Cxcyus4v4Feb92gTALka0vz5KZTEc5qgbZ/m0M
 yCA81D+EGLvElQJ/hlY6DBP60e6lxANCdXgKYjpYMFozAXsVjZM9yXlRjkSAQsS+Oue61nN6+kp
 I4DzD1ITgkqqDaCGyfS5L9xvQAtGoQXbTKVbH4xT1Ma6bBAUB2drL+as2dsbUwPLwm91VV7n+zv
 9bhr8KWbWYEyAvdyO2kqYSvjMFfUvh1MRd7NLmBVSP
X-Gm-Gg: ASbGnct/9kMqmOYRYwCinhklM1xMAHIuaqnwAiBoMn6PNKIgz4l3/idIx8jJV1VdfgO
 8NqLxmUtHMSElGfcgzwJIMRYV8NmfsoHVhDlC3bTM/ATslB4kN+kma17cE55KOdIjE0hA1XcwkG
 dPimW+9JHBNAhPRF+a/fbnscZfYAOMQGz4qjZ/A5+7JNxq5PJdTp6Lba5WiyzKzuSxlMlcmoE3S
 hxygqj2lKJaEIxx29HIKv7p6UkIN/RYwLDURfc4pWp2YCmrKcO6b1G6CghTncUYda4nvQ4BfAUC
 6UOa9QEYEB5mPw==
X-Received: by 2002:a17:907:9285:b0:ad8:a41a:3cbf with SMTP id
 a640c23a62f3a-adb32264ce0mr191449966b.13.1748589291810; 
 Fri, 30 May 2025 00:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxLU5H4Ouye0SPQSlV0eKkR3lY7REBT3lkarEU8Dxg9bA+IKixbZjRN5wR3N08wJkWtIajRQ==
X-Received: by 2002:a17:907:9285:b0:ad8:a41a:3cbf with SMTP id
 a640c23a62f3a-adb32264ce0mr191447566b.13.1748589291307; 
 Fri, 30 May 2025 00:14:51 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5e2bf051sm273882566b.122.2025.05.30.00.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 48/77] i386/tdx: Disable SMM for TDX VMs
Date: Fri, 30 May 2025 09:12:18 +0200
Message-ID: <20250530071250.2050910-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

TDX doesn't support SMM and VMM cannot emulate SMM for TDX VMs because
VMM cannot manipulate TDX VM's memory.

Disable SMM for TDX VMs and error out if user requests to enable SMM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-37-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 344e560b4b8..87c5bf04960 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -367,11 +367,20 @@ static Notifier tdx_machine_done_notify = {
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    X86MachineState *x86ms = X86_MACHINE(ms);
     TdxGuest *tdx = TDX_GUEST(cgs);
     int r = 0;
 
     kvm_mark_guest_state_protected();
 
+    if (x86ms->smm == ON_OFF_AUTO_AUTO) {
+        x86ms->smm = ON_OFF_AUTO_OFF;
+    } else if (x86ms->smm == ON_OFF_AUTO_ON) {
+        error_setg(errp, "TDX VM doesn't support SMM");
+        return -EINVAL;
+    }
+
     if (!tdx_caps) {
         r = get_tdx_capabilities(errp);
         if (r) {
-- 
2.49.0



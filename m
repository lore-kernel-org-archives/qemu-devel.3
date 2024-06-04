Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BFBC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENxA-0008Fe-8g; Tue, 04 Jun 2024 02:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvr-0004aS-7o
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvp-0007dY-8T
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5Ds/6wWvA9ZKtpiIlGskchmOiVTlP+K7u7gXRzsSMY=;
 b=hAevIqmijKdUBHeiFpTIaNICEQvHG7fif0xXxcJI2S5bYdFpxArpS+V2IVZHRCDj0oOC6g
 Rv0OcFgb548zPZABpT3wHWieOW1Aik4xB23Aiz6832VZ2I21SiwAeFf58xuV09V/4NaVoi
 3aHGmzVZg7Lf+cGHuggllN/sK8zi6Q0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-nshKZAjFOaCk5rqqs-k1ew-1; Tue, 04 Jun 2024 02:45:55 -0400
X-MC-Unique: nshKZAjFOaCk5rqqs-k1ew-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52b9ea6e320so908563e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483553; x=1718088353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5Ds/6wWvA9ZKtpiIlGskchmOiVTlP+K7u7gXRzsSMY=;
 b=PLKIbfqd0L43vcQJEm6JWavhaxjNr4wkMMQHd+ehpnHlIbspLZUjGr9GrZioPIApL4
 C3P/TEfONu1n5xfMeYk8hButx+ZjP4YAiBBExOnTesFK1aURH1s/FVooA+vm6TmVbrNU
 B0Hpkn0VQpUJUGWfV9SBhlJQvcFWHVyeomL1n+jFm6KuK934TJ/ZVa2Gkh4KIURwQwwf
 PBvB1la5RCoganE/FXlciiTCMPQxsOkBOKr18LkDq29n7Q73PDVQt6sF7sx75Ou1/mNR
 JPj0gtlQvlwK3BH1aHwHQtgnO7F2VPFIIfhOZLysOmJKEYspZI0frAijEcAaqAMq8C7/
 aDaQ==
X-Gm-Message-State: AOJu0Yzp5tLUXvHHb+XPLI0CUZm+UGvNTw6RbywRcjauYI329rmJAdH5
 jBwoozO24FxU4OQYOX//mhNvG7LNkv5UuYqbEQAWScye9dotTOo1IQS0MZAX0EbBvHjP1iyt6LK
 GzEaT+7YtMTBdy2uHK3rS1eCDGG0pEMe6NpdgRYkmemGenXyZBDx/SFRC0ijh4I7cET8AwVbyEl
 V7Mm83pezRiaMMkGBCJh8G8FGEG2lFCtBw4mWc
X-Received: by 2002:a19:a40a:0:b0:522:3551:35f5 with SMTP id
 2adb3069b0e04-52b89564058mr6809315e87.14.1717483553163; 
 Mon, 03 Jun 2024 23:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYuP3B4KhN8yWm1LlyvQnT5a4yV7w4AR6/oWkIMPnwLZWxINl+R4RxYtkYMgS2Bxn9y3V+9Q==
X-Received: by 2002:a19:a40a:0:b0:522:3551:35f5 with SMTP id
 2adb3069b0e04-52b89564058mr6809304e87.14.1717483552794; 
 Mon, 03 Jun 2024 23:45:52 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb8219sm6658159a12.22.2024.06.03.23.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 36/45] i386/sev: Invoke launch_updata_data() for SEV class
Date: Tue,  4 Jun 2024 08:44:00 +0200
Message-ID: <20240604064409.957105-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add launch_update_data() in SevCommonStateClass and
invoke as sev_launch_update_data() for SEV object.

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-26-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7b5c4b4874d..8834cf9441a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -74,6 +74,7 @@ struct SevCommonStateClass {
     /* public */
     int (*launch_start)(SevCommonState *sev_common);
     void (*launch_finish)(SevCommonState *sev_common);
+    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, uint64_t len);
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
 };
 
@@ -929,7 +930,7 @@ out:
 }
 
 static int
-sev_launch_update_data(SevGuestState *sev_guest, uint8_t *addr, uint64_t len)
+sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa, uint8_t *addr, uint64_t len)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
@@ -941,7 +942,7 @@ sev_launch_update_data(SevGuestState *sev_guest, uint8_t *addr, uint64_t len)
     update.uaddr = (uintptr_t)addr;
     update.len = len;
     trace_kvm_sev_launch_update_data(addr, len);
-    ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
         error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
@@ -1487,6 +1488,7 @@ int
 sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
     if (!sev_common) {
         return 0;
@@ -1494,7 +1496,9 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 
     /* if SEV is in update state then encrypt the data else do nothing */
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
-        int ret = sev_launch_update_data(SEV_GUEST(sev_common), ptr, len);
+        int ret;
+
+        ret = klass->launch_update_data(sev_common, gpa, ptr, len);
         if (ret < 0) {
             error_setg(errp, "SEV: Failed to encrypt pflash rom");
             return ret;
@@ -1968,6 +1972,7 @@ sev_guest_class_init(ObjectClass *oc, void *data)
 
     klass->launch_start = sev_launch_start;
     klass->launch_finish = sev_launch_finish;
+    klass->launch_update_data = sev_launch_update_data;
     klass->kvm_init = sev_kvm_init;
     x86_klass->kvm_type = sev_kvm_type;
 
-- 
2.45.1



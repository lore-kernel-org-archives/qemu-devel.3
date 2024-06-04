Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6D9C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENv3-0003cb-Rm; Tue, 04 Jun 2024 02:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENv1-0003RI-28
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuz-0007W6-5M
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eBpKMwv8ZIHObCcWR1NvCyq4TOAmQm+iQ+YMChwrck=;
 b=MkYG3Wb0D53OimwVV3W5oVCymjL4E1uS4Zd7U42jue1+JAg/ET9rFnR4FzlzIvEzapB2UO
 m4m9gmqg7ICJaqSyBmx0C7fIWxrQNZSCweHGyVyQH8woeQL7lX6tHiHHYDXCXdDHTA1/Wn
 RVQgs/aFODaIrLCUKFKfQCUON9jtZ4o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Ue3BDUaDOUCyD4Q7JtO6cQ-1; Tue, 04 Jun 2024 02:45:11 -0400
X-MC-Unique: Ue3BDUaDOUCyD4Q7JtO6cQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6912c4ddb1so13735266b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483509; x=1718088309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eBpKMwv8ZIHObCcWR1NvCyq4TOAmQm+iQ+YMChwrck=;
 b=GFStmx6umkMwwParbRwuArcs8oXcB+BLhgED3iTbp8P76LtXAJUt/yethFHw7lDort
 do3SsDJIoZmjbTl8kgyfAOCX9JYuaAow/N0Js4YRizhxQZxPNpJJTtPGwDhOH01ZsMcz
 wNKOv9MHG60pAQ9KCiRbDLijl6i7hsu0G5Lofbwt5dMMRxLqVL3w3kTXhK0AL7Q846dZ
 f7QYhj605cFJZGhzfi8Pfdhn7oPbJw1F9TbR+SkI4DikbEFawQb9lH8985LZp+s7nlRy
 z9KPMhFPXaFxtwwXMJVqqMqGXpvpDIAr8zMQmx/+YLAIq66WnkzIKL7hxjaHeQ/aNe/7
 tVeQ==
X-Gm-Message-State: AOJu0Yyqpr9zge/apwBOth+YsIUKuw9H8AGBWDAE5cGShJpA5n7FHAzI
 G1oZraI355qdLAhDaxPPNCjfUZkz9ozzioAc3pfFHYyqhSjgHVxkQ5nHVR2nNzNQ7Y965gDQQFd
 /gE8sHDd9+zroLRHmXNSf9c7MdP1Il9AVDxQ9oKHQDgQ73eU1StccFMMgOWrhR9eYB5xJb3BRCN
 KJCPDXdvn2GDFnmvypt+FW3As2KV+PRSxR5a5B
X-Received: by 2002:a17:907:830f:b0:a59:ba2b:590e with SMTP id
 a640c23a62f3a-a6821d64589mr532735166b.48.1717483508837; 
 Mon, 03 Jun 2024 23:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6fnb4LHOMoAN/4J1za5ggJwAH9edSZdn6z6CuQWbYHIormQLr3eHTJR50hLMcuLdcaAb33A==
X-Received: by 2002:a17:907:830f:b0:a59:ba2b:590e with SMTP id
 a640c23a62f3a-a6821d64589mr532734166b.48.1717483508447; 
 Mon, 03 Jun 2024 23:45:08 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b59e925csm443157166b.220.2024.06.03.23.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 19/45] i386/sev: Move sev_launch_update to separate class method
Date: Tue,  4 Jun 2024 08:43:43 +0200
Message-ID: <20240604064409.957105-20-pbonzini@redhat.com>
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

From: Pankaj Gupta <pankaj.gupta@amd.com>

When sev-snp-guest objects are introduced there will be a number of
differences in how the launch data is handled compared to the existing
sev-guest object. Move sev_launch_start() to a class method to make it
easier to implement SNP-specific launch update functionality later.

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-6-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 33e606eea00..b2aa0d6f99b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -69,6 +69,8 @@ struct SevCommonState {
 struct SevCommonStateClass {
     X86ConfidentialGuestClass parent_class;
 
+    /* public */
+    int (*launch_start)(SevCommonState *sev_common);
 };
 
 /**
@@ -632,16 +634,16 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
 }
 
 static int
-sev_launch_start(SevGuestState *sev_guest)
+sev_launch_start(SevCommonState *sev_common)
 {
     gsize sz;
     int ret = 1;
     int fw_error, rc;
+    SevGuestState *sev_guest = SEV_GUEST(sev_common);
     struct kvm_sev_launch_start start = {
         .handle = sev_guest->handle, .policy = sev_guest->policy
     };
     guchar *session = NULL, *dh_cert = NULL;
-    SevCommonState *sev_common = SEV_COMMON(sev_guest);
 
     if (sev_guest->session_file) {
         if (sev_read_file_base64(sev_guest->session_file, &session, &sz) < 0) {
@@ -862,6 +864,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
 
     ret = ram_block_discard_disable(true);
     if (ret) {
@@ -952,7 +955,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         goto err;
     }
 
-    sev_launch_start(SEV_GUEST(sev_common));
+    ret = klass->launch_start(sev_common);
     if (ret) {
         error_setg(errp, "%s: failed to create encryption context", __func__);
         goto err;
@@ -1451,6 +1454,10 @@ static void sev_guest_set_legacy_vm_type(Object *obj, bool value, Error **errp)
 static void
 sev_guest_class_init(ObjectClass *oc, void *data)
 {
+    SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
+
+    klass->launch_start = sev_launch_start;
+
     object_class_property_add_str(oc, "dh-cert-file",
                                   sev_guest_get_dh_cert_file,
                                   sev_guest_set_dh_cert_file);
-- 
2.45.1



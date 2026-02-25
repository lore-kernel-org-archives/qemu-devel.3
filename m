Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B237CF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vr-0001Bz-0j; Tue, 24 Feb 2026 22:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vp-00010z-5G
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vn-0008Ap-Ag
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=UlVxt8EsezXutIrQoQWs3HWTo/7SjP8Yoob5j4DNSTirnduRTzAtDrKSoXNp77CINhqzvS
 WxfqlrEzSKjGkbLZ3O1L7PY+CSk8m2hjtWy4EZf/vRKFsA8xy7Yb6ybeHnZko3ohfgY7wO
 IOjIHjy1V5ODjRrMuCe4KD3EMOxxy4A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-o_op9yHnOhukz3QOnFDj3A-1; Tue, 24 Feb 2026 22:51:20 -0500
X-MC-Unique: o_op9yHnOhukz3QOnFDj3A-1
X-Mimecast-MFC-AGG-ID: o_op9yHnOhukz3QOnFDj3A_1771991479
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-358ffccebf1so727171a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991479; x=1772596279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=qs6irPkvkMOc+tDRKM08CXoDd0k0sLoDZOTTx8m3izzvbb7EeQ5oH/nKjtxVrmzh2w
 X9jjjVF6nq1RTLu7SVlvWTbw7eeMoq833Y9VXXnZ+nB0jf34jnUZFwKWOFn3K2UnZ+iR
 P+EFEcbH8pudPRA0k+pH9KHjc5ovrJrDZXMSwUg0kQmiiDUF+GcxFJ2BGvSwkaf1YF0I
 3JBe3FMqy3JklUXRQMP3i169l6W6hohoSK3FPBMRbEggsAAWcbmDERdoIDRXeqhbT1hm
 tfyKp/Hl+0BroGpyPhtwtgRW69FSOQvrDC5L/d+sNnlE6pbyDOjVZBz/+2hu/dsEx8Op
 Vniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991479; x=1772596279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=PQ1jJDSr9VlABKqhLENDuH+kMBWJXK+k5cD0XoubanQ6nDLxXIyIknF32Y8Yub8B6S
 bdiosQgKvAKQ5jzWwJyAU99+J6AtX+gK2C3cwpJ4PtoJKHyLr+QYLL9e6Uk4KPS6dbNT
 DS9aLYS8sGyV5ybWq5Z9K+BaG3UBXCyUs2QtB/d1RvhnOzsJp7copK3pkJ6BZOHDrk/6
 t9LXDglbrazyAMXe5TnoZpowlH09J3mt1TMKoCU50YyhsdnZhj5eXOrR8EgUgwaDL1gM
 6QIDauDEIOrB9pp9UJ5ggrCR+qPEM3DSs8vWTx8XvL7O/p2JWN3s5R/rVGT4ow9MFsT9
 2vUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMilVZRTfRTbvT36bVpgw2eQC27M+uHdRr62znFjJXeYzsfNgf+kzCFfU1fbl69PJOPfP1yx6P2PuU@nongnu.org
X-Gm-Message-State: AOJu0Yx0dRCqy/IuzdBUc1ZM99VckYybZ+cmbT6g/1FLyMQYyechE2lQ
 eytEYEuEb+d0Mf3HRNFk8NlQXxWr+g1UuJfN/x+MG5GcZFdtwo7CiDtFl+iFOw3iA6SVbom8TXK
 r02palrl0SFJWa/oH9sk79l3BfEcJNn6arBPg7oJI00iUwFpuzQBwHncQ
X-Gm-Gg: ATEYQzwwVE6mxDK5Y7PXIP061aNetQyfDFShNS2yAlWWam7f0IXg/oepCUnqln7bEZW
 T9X663CDJXfRoEX7VkqOM17bns51LsH8/PSJOT6T4gm1/bysjzYHiKf3oCpA4vH95Ilgx8SPns3
 bwZNu/n7SbxddfNMwAti62QjfhquRA55B7Kc2Sjs6a88GHw3paOAUzQEv2NSy+VuC+bLXMUHBng
 +Jztg+I3vmoR60Fpgi2NH93bWUUus3QsGxc9jWk+RVhMFTx33Vfp37AhEz434YlFt7fx7oY9hnB
 yg45T5uSYobfU5BvP5au0In4ETBYiuAihFIOUP8Twu4L1b3jjA3ehV2eG9IH3xaKmPDYK8JiU1O
 RKXdrdFQ/8X0uQTecmvl1dXsU/CXapV/YoH9JsIq4+4mFZA8WIHaINAQ=
X-Received: by 2002:a17:90b:3d47:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-358ae8a45f5mr12833952a91.16.1771991479409; 
 Tue, 24 Feb 2026 19:51:19 -0800 (PST)
X-Received: by 2002:a17:90b:3d47:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-358ae8a45f5mr12833928a91.16.1771991478969; 
 Tue, 24 Feb 2026 19:51:18 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:18 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 21/35] i386/sev: free existing launch update data and
 kernel hashes data on init
Date: Wed, 25 Feb 2026 09:19:26 +0530
Message-ID: <20260225035000.385950-22-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If there is existing launch update data and kernel hashes data, they need to be
freed when initialization code is executed. This is important for resettable
confidential guests where the initialization happens once every reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 647f4bf63d..b3893e431c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1773,6 +1773,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevLaunchUpdateData *data, *next_elm;
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
     X86ConfidentialGuestClass *x86_klass =
@@ -1780,6 +1781,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     sev_common->state = SEV_STATE_UNINIT;
 
+    /* free existing launch update data if any */
+    QTAILQ_FOREACH_SAFE(data, &launch_update, next, next_elm) {
+        g_free(data);
+    }
+
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
@@ -1968,6 +1974,8 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(ms);
+    SevCommonState *sev_common = SEV_COMMON(cgs);
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
 
     if (x86ms->smm == ON_OFF_AUTO_AUTO) {
         x86ms->smm = ON_OFF_AUTO_OFF;
@@ -1976,6 +1984,10 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
+    /* free existing kernel hashes data if any */
+    g_free(sev_snp_guest->kernel_hashes_data);
+    sev_snp_guest->kernel_hashes_data = NULL;
+
     return 0;
 }
 
-- 
2.42.0



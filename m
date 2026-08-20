Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDA5C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zF-00063J-VK; Thu, 20 Aug 2026 12:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zB-0005nQ-PY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5z8-0005fV-Kj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptLFXHmPh0mteELcKxHYZlguxqyO/4K7nY1fzdPX0UI=;
 b=Y5DZDpchuglWBAIhzMjpqFlU/xbhVi6tB9eI5tuIyvzFCa2yA7y6nJ2IRHZbQiKxMPZ1V8
 KTgQLbpePaFZGVDX+/8Px+S4tvvVJLIODVfq094xyYKj2e7ZyF0VzqsZFrluCwtwMJG6AI
 ntgCb0umxM9O2y6edoND6yJ+iF04Frk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-nRGnSyopPKWVXJh2hsVxkw-1; Thu, 20 Aug 2026 12:51:16 -0400
X-MC-Unique: nRGnSyopPKWVXJh2hsVxkw-1
X-Mimecast-MFC-AGG-ID: nRGnSyopPKWVXJh2hsVxkw_1787244675
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-482b88653d9so80186f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244675; x=1787849475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ptLFXHmPh0mteELcKxHYZlguxqyO/4K7nY1fzdPX0UI=;
 b=YLhUJthwrAAJa/o60dBtwc3pNXy8Jn1NgHM0Fw6uQke8dLm282FNU994Bdlg+s7nur
 hW9L75gvspfy1p7WjAsnx8jTcZbsVo3ZyopIJXcm+dZNniknpkLXz/20DXaUoejH8fue
 5xHtaWvph6T1/pTTen2UAomPuW/u1Eugb0MBuJGF7EWijygQdxMgfKqWpPGPYj5vh7vi
 huCoJhPW+AIs/1Kv9O8uf8X+/oeHU0ftj1kY2vQ8R5fHfc9JSBjCgQNdegK+WGMTpR4V
 OnUgdLvYmTs1NJatNAJbRo8W47vQEigt7Du5EdpIoELREU+dlZIkygIaTSL8H7qHZhu/
 zvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244675; x=1787849475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ptLFXHmPh0mteELcKxHYZlguxqyO/4K7nY1fzdPX0UI=;
 b=FMNOqtWSgBrBJj0sInqvHr4ve8Dl3fJWhInK2xQ7YthbDT5Se1HvDXYRO8xx+hoJo3
 u4FxCPBZza1KsBz3uHdiDIkWptYI19c1o7uOg/GzcB2PFd6uxOZBJFKeWr+sUqTx2ms8
 8IlbJmouGbJluQTCkRuOjQzS00yh+mJJnFQP0vj595g8tu1m58K45VHXqH88bdb8BEuT
 TmCxJcpobguFkh2CDZtI4EgZGEWSGs9hq7BgX2xGIl5uFTbo3D0TRHRRBRvVMVpRm2Ri
 pPI29iLUbkt6FeRCmmD1WdZedilxaPpMO9GoHeQmsImfh7877qAdg+rAPrrM1BudbxmG
 NocQ==
X-Gm-Message-State: AFuF++lo/iTgOfVXw+3+uGXc8hdWZasILaGYdVXQWp/zAU4RfhkE+mhS
 240cbhVTbm9GUmn69Rs7q+ct/qE9lh9e2VnzF/ra+PKuPaujooJ3j8x3ikMziMCJu7tyi6JGxHe
 7zcgcBjU51ubmYELEgsBod2NxSg+iZTy6LCd7hKnlV5K1E/hCN8zspkVUmPJg3zuRjmpEY3JHCm
 x5FvBXhUSWllO8/H53Aoovgo5uRuIlEzcqRxM1EhwC
X-Gm-Gg: AR+sD12XHsaKCCB4ztp1YVk1b1sLAIZ2YnVFh5oFFWx58K5KKCu3gsk5tgSWHU15wMY
 FmD0tV8j6RG5laRiB0Nle7lVis86XIagSR9YfZHn8pM/0UFJjSXhVGV0pkRSvCE5SAFOJ3H2Zmn
 epZLy8bFYgMIMBgFj6VhjUj5JKkuA1lhB0BM3ZOQ/txw31290NsV7QRapQlT0TAnWM18mgXeVkm
 HFM+qWU/epBrQB9lzBO/k23AVe4jdKsN3kzJZ/TZtbQsk605IAQWeDkmAzUohnggyGbIz5a8/ze
 4BmKWeoHYXaAQNQkecZ3fJf0XJ3dZD37bMl26NBtS91X+HakcpgSLYwyg97Fj8o/g1KfTc6wlW/
 xpyVz7g6YEbNhIJa0x8BBoPXaP99FQ6rkAT/wG6xp0DcEuZpR79FOitCelXJLQBygQLnR/1W92u
 HNIjI=
X-Received: by 2002:a05:6000:41dc:b0:482:aa2a:52f6 with SMTP id
 ffacd0b85a97d-482c0b41f95mr57984f8f.1.1787244675063; 
 Thu, 20 Aug 2026 09:51:15 -0700 (PDT)
X-Received: by 2002:a05:6000:41dc:b0:482:aa2a:52f6 with SMTP id
 ffacd0b85a97d-482c0b41f95mr57899f8f.1.1787244674640; 
 Thu, 20 Aug 2026 09:51:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b80a5sm14620314f8f.24.2026.08.20.09.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>
Subject: [PULL 26/53] target/i386: SEV: Add support for enabling Secure TSC
 SEV feature
Date: Thu, 20 Aug 2026 18:49:29 +0200
Message-ID: <20260820164957.1895963-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

Add support for enabling Secure TSC VMSA SEV feature in SEV-SNP guests
through a new "secure-tsc" boolean property on SEV-SNP guest objects. By
default, KVM uses the host TSC frequency for Secure TSC.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Signed-off-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/9f58b92a173f319b3ef725f5ed8a2a173eed55b1.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json     |  6 +++++-
 target/i386/sev.h |  1 +
 target/i386/sev.c | 13 +++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index ad7e39aa756..4732fa89751 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1113,6 +1113,9 @@
 #     firmware.  Set this to true to disable the use of VCEK.
 #     (default: false) (since: 9.1)
 #
+# @secure-tsc: enable Secure TSC
+#     (default: false) (since 11.1)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1124,7 +1127,8 @@
             '*id-auth': 'str',
             '*author-key-enabled': 'bool',
             '*host-data': 'str',
-            '*vcek-disabled': 'bool' } }
+            '*vcek-disabled': 'bool',
+            '*secure-tsc': 'bool' } }
 
 ##
 # @TdxGuestProperties:
diff --git a/target/i386/sev.h b/target/i386/sev.h
index d19a3966974..7725f92e195 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -48,6 +48,7 @@ bool sev_snp_enabled(void);
 
 #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
 #define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
+#define SVM_SEV_FEAT_SECURE_TSC     BIT(9)
 
 typedef struct SevKernelLoaderContext {
     char *setup_data;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2103a121aa2..fdfeb604f6c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3212,6 +3212,16 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     memcpy(finish->host_data, blob, len);
 }
 
+static bool sev_snp_guest_get_secure_tsc(Object *obj, Error **errp)
+{
+    return is_sev_feature_set(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_TSC);
+}
+
+static void sev_snp_guest_set_secure_tsc(Object *obj, bool value, Error **errp)
+{
+    sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_TSC, value);
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
@@ -3247,6 +3257,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "host-data",
                                   sev_snp_guest_get_host_data,
                                   sev_snp_guest_set_host_data);
+    object_class_property_add_bool(oc, "secure-tsc",
+                                  sev_snp_guest_get_secure_tsc,
+                                  sev_snp_guest_set_secure_tsc);
 }
 
 static void
-- 
2.55.0



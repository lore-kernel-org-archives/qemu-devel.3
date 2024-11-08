Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5446D64070
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SwS-0003fl-TR; Fri, 08 Nov 2024 12:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwP-0003b8-Em
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwN-0007ZT-Va
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3j3uR+M0eiiYaHcDXQAkcIVQRaqZMJIdRPVYO66kVA=;
 b=gwNqVS8da9tFGEQQey0zrA5/NjnaV95do3txQeYuWKM7CdHdGoEaU3ElT3YqY7Svmt9KE2
 +c9aCshJa4JKoIFgy+Syrord+apWvfNd6qimGCmRkgTd+WCOb9XgJx18utaw1cjnU98rdX
 k09LD/gUM3Sjq1gS6VG5LTULY7ZLk9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-0z64-qD2MSeuLj8qtp1TfA-1; Fri, 08 Nov 2024 12:38:33 -0500
X-MC-Unique: 0z64-qD2MSeuLj8qtp1TfA-1
X-Mimecast-MFC-AGG-ID: 0z64-qD2MSeuLj8qtp1TfA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43159c07193so21146895e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087512; x=1731692312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3j3uR+M0eiiYaHcDXQAkcIVQRaqZMJIdRPVYO66kVA=;
 b=fJPX1UZnbv3wb9mSHxGU4M1/lInI08yt9otEBchULi+1pYHMh7qU02kmEiRHCQ2LXo
 q37CQl8IFvzS9RvBUasYvJBNpy7Be0fHT1kaN/D47gQeMaxlBG65gOESPFiA7EinGzND
 PhjYbHkwE0SMAQ7/oSWSv8nZGihP6DqDUybwEEyeOPCCYuX3MnvqXDsXKcDfTjUDa6b1
 kk+Q+eUc5Qx2HJNjYhy2p9lcYaD7TnhXMiJ32yv1mZHGXxCOoCr15LGstr7a9fhNI0yM
 ipeiZzU0DoR8zwX6H3pPgHbZgFfDd0A1sQ3anRHPXscnleoJiKJ+1KmZmANM3zmGJEsM
 B7Ig==
X-Gm-Message-State: AOJu0YwUwm/6u2PqPlruRbcBFX9pfw/Qkml7hw28sFiFNj/AnKw+/FWH
 KH03s9Dd0KUowZq/d2XcSvXNgwWYpXc3NMVNn6BCy4gVSaDgRJADvX/4CLtKvdnHVpgrql2Noqu
 l1meY8jpmNM78dH6RRQsjfMXyGqSiF4cbhOMaqUMkUXjs5hj8uOc28iV8Pxt9r0wMjqQ6ZcnLS2
 U/aE7zjKX7PhnXMe59lzU0OokOeYF34YqJZVnuD0o=
X-Received: by 2002:a05:600c:4f10:b0:431:52a3:d9d5 with SMTP id
 5b1f17b1804b1-432b74a07femr40750045e9.0.1731087511933; 
 Fri, 08 Nov 2024 09:38:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL2ZuGMOzQc75VMbDAu2OWqMHT7eHW/IK7Wjlg1rN3JEfZibnsSCnF26IyddJPMvhIbXUrkA==
X-Received: by 2002:a05:600c:4f10:b0:431:52a3:d9d5 with SMTP id
 5b1f17b1804b1-432b74a07femr40749845e9.0.1731087511571; 
 Fri, 08 Nov 2024 09:38:31 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9a9c2dsm5498347f8f.60.2024.11.08.09.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 01/13] target/i386: add sha512, sm3, sm4 feature bits
Date: Fri,  8 Nov 2024 18:38:16 +0100
Message-ID: <20241108173828.111454-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

SHA512, SM3, SM4 (CPUID[EAX=7,ECX=1).EAX bits 0 to 2) is supported by
Clearwater Forest processor, add it to QEMU as it does not need any
specific enablement.

See https://lore.kernel.org/kvm/20241105054825.870939-1-tao1.su@linux.intel.com/
for reference.

Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 58c96eafea9..3725dbbc4b3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1116,7 +1116,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_1_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
+            "sha512", "sm3", "sm4", NULL,
             "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
-- 
2.47.0



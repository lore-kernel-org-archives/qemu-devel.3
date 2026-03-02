Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE65C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyut-0005JG-Ce; Mon, 02 Mar 2026 03:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu9-0004hu-SE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu4-0001sx-Os
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpvlDRKo/WcstLe6ivw1YblVzY0NV6VzUPEXuT9Sw70=;
 b=fiy2IAOoFsTS3nmJ2jfXgOe22rA0KjfEBqCKkNl68QFuacsm1LKLWA0E6BUoMaNtTdPm6X
 CFL9Bh3F7aKRQWJegBH2q3PKhCpBX+60avmLJtYfTIKgx7TyS6jWnJdtZmekj7A+qtDnmR
 C7m4gICh0oEqfBGYtseoikl89P4oA0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-ZGWgjcEsNbOi8Kmm_VVgjA-1; Mon, 02 Mar 2026 03:45:21 -0500
X-MC-Unique: ZGWgjcEsNbOi8Kmm_VVgjA-1
X-Mimecast-MFC-AGG-ID: ZGWgjcEsNbOi8Kmm_VVgjA_1772441121
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48071615686so32871745e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441120; x=1773045920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpvlDRKo/WcstLe6ivw1YblVzY0NV6VzUPEXuT9Sw70=;
 b=looCP+ug9a6mSt/wZFlFAfag/xlD46pMRy5dY3rGrgOy01NUWIS+ge0BztirY1zzS1
 NZFqoa5uXuHDbh+73OvhfRdMEOXqp3RrRoPq3JTwIVFG/WJnFq1e8pY8lPA1ncft/HO8
 zDCqMY0gB5DAXdalPk2kgoAcCNa0BCUygg2DJVxnquRZOsNv0958v0VcUS7R8XCHpV8K
 FcJWgcclXO5Da+IkWuHmi4B82ssRLxq9PBn8qmV22yqGJJG57LSDQM8Z22cqJgt8EiSh
 LHjggvkm3rkXzoZVAgVdN6B5KKPBf4u/Rcs6GFfSJ6reL1lMkZVAZnexXXAlR46tkGam
 /tdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441120; x=1773045920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DpvlDRKo/WcstLe6ivw1YblVzY0NV6VzUPEXuT9Sw70=;
 b=B/l0IIqSxrd+drVnEbTmDOAa3w+qhRFTiWVqfaGUPd5yO4VtDC6mSFTWIb4SJ83n2m
 +WlEp6t4Z+y9Rh1RNleaBJTaHAApNoI63OJjnctCSdQ+LxfVND+ulT7Tlb69Ijer9p3d
 YugqobyV5y2xw0MLWnvu6Lz+j/NgMNQipenxJcTSEx5b+gc5bHUOU1cTrB26H19klEE4
 U8sjpyHzC6FJXzv5aYF3XrrAwj3J46dQreypCgkFklG+aY7EtJ08o1ka/l/cr/Z+npmC
 xmjvDRyIbSp97g9KRhgRGVYuoRkYT+kJO5vloeZ1Ggf5Um2IzmMTvjEZMAa0qMzy8Ats
 6YXQ==
X-Gm-Message-State: AOJu0YysJYn9VM9JZLPmKI3OlUz6HgcaIYkgv5yDQ5MlXhlugVXxnvTy
 ZMPZvwxwq8wo6JsT4Rs266yd3WKDEQadzqDtJ2J4c9/ZUN6bmhFkOXVW40YL7OmKNwvrmYLhjTo
 hO1odnoxklTDd3T0rd9883pOy3qhuUeTxkQJCKrzXMkf5Rm2B+XCcpzT1+G5AGQdhGP/w8NNdNT
 RrIz+PWMIZsSQroQgsKeX4LzUyQE1rLWLpU+310SCz
X-Gm-Gg: ATEYQzwwOoGz2yrY0abAUh+itWXP6PZJ/CK2aNsim42d8bSAiwJn1qCryZ3hPGFCpQx
 LlvvzL9Pam91l41TavWedaMnnHzhu7CeZ2VC2N16ecD0yQkLkY6oj0dLqtYSR9nrkLD0Z4bs1LT
 NxPIvIA3z5ioOZQ/wm1L8s8ghbcAH7402S2OCBBQStTqpf73RTwU7V7W/Yi39dna7LmVoI2pMb4
 Dr6qBhDf75o+mfOHJy+fPJyQ8TgClYQq1XXaOoeiGbZnKFxtmhOnq5CA32Gnw/B1YZkOoOfRCUg
 2XVUsONLa4hTp35L0yZc1P+ZD4H8S4bCY7gFHy3G1lFPlvSv9ZawLnAj1DC2CO36XUJ9untdYqQ
 95WhlQz2Hwd3tzVKSzxg4tadTjsJrU6sXXigtrr4HjMImKqBzkmQlIvXw7C7mByNZhfieY79vLZ
 eWPu/CYA0UEOQPdmOmpx/6Od/h4Xc=
X-Received: by 2002:a05:600c:8289:b0:483:6a8d:b2fc with SMTP id
 5b1f17b1804b1-483c9babda5mr184977005e9.8.1772441120023; 
 Mon, 02 Mar 2026 00:45:20 -0800 (PST)
X-Received: by 2002:a05:600c:8289:b0:483:6a8d:b2fc with SMTP id
 5b1f17b1804b1-483c9babda5mr184976575e9.8.1772441119434; 
 Mon, 02 Mar 2026 00:45:19 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b770e7sm288907155e9.9.2026.03.02.00.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 037/102] target/arm/cpu64: Allow -host for nitro
Date: Mon,  2 Mar 2026 09:42:32 +0100
Message-ID: <20260302084338.473368-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Alexander Graf <graf@amazon.com>

The nitro accel does not actually make use of CPU emulation or details:
It always uses the host CPU regardless of configuration. Machines for
the nitro accel select the host CPU type as default to have a clear
statement of the above and to have a unified cpu type across all
supported architectures.

The arm64 logic on Linux currently only allows -cpu host for KVM based
virtual machines. Add a special case for nitro so that when the nitro
accel is active, it allows use of the host cpu type.

Signed-off-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20260225220807.33092-8-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 58215216c55..d6feba220e8 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -813,6 +813,14 @@ static void aarch64_a53_initfn(Object *obj)
 static void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+
+#if defined(CONFIG_NITRO)
+    if (nitro_enabled()) {
+        /* The nitro accel uses -cpu host, but does not actually consume it */
+        return;
+    }
+#endif
+
 #if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
-- 
2.53.0



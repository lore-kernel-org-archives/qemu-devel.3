Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F06C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yC-0003h8-Cn; Thu, 20 Aug 2026 12:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yA-0003gF-Og
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5y9-0005NN-9C
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sev1IQ60CGvt7Ba+QHHArfkx7BZ9Sd4nGpl4k53gxI=;
 b=Uf31TjKvsHGaM/2kk+mfdflSecAO5OHIZFfvJ+5EH9aSs+2LCyiMVvpCrzeszW5zjjwdwJ
 pYp9GtjFgoU139dufOK1enzK9qszgc66UdZIqlnBbLXq41IqJbJeWfI2O0PFOxsRDKRvtV
 D7Ix640z80DVYvrPe5BsjeqWCSPUJsE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-alxmhis-N3ma-Uap7uTtUg-1; Thu, 20 Aug 2026 12:50:13 -0400
X-MC-Unique: alxmhis-N3ma-Uap7uTtUg-1
X-Mimecast-MFC-AGG-ID: alxmhis-N3ma-Uap7uTtUg_1787244612
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4996832e7b4so9048295e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244612; x=1787849412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3sev1IQ60CGvt7Ba+QHHArfkx7BZ9Sd4nGpl4k53gxI=;
 b=pLS422gKW4GXRSMbNV25jHLnSn/+TQn7a2ZNFcPM4M7b3xrgXZnFRugHFQugcOsqRQ
 47jjy0teXbnUyGolLaSq3x810ap1I+dNnSWcv9qqrnv0Q65UxQgdN5YkV5wxCPgslDai
 wL/67qGqCdPrOs4Dldi6tsU8GwHEyDJ2DbY1pXProzfPGb84Rsku/F4OajqsafxFbcnk
 M3eM41td+Zj+qAwDCRhLoK16is/rOaTQPHAq2F3UyJ8Y1qOBiycwq0N9v6SyntbYeaRL
 8JI4LLuBsDyMsiU2gNgXmdaQ1T/TItWhY0Svhk4OeICjj40BRMS9vCQ1/i2C1Ze8ExvA
 BWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244612; x=1787849412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3sev1IQ60CGvt7Ba+QHHArfkx7BZ9Sd4nGpl4k53gxI=;
 b=mLhDDUkJf4w0c/lqzwUNraxdJce/e0x8NIdjwQP7a4sv5N6XI/DdCSaHsVP0l643Yb
 BfXYdkah2QBJy+hF9C4IZlXr4amR8oKql2SV+QaYS+m2eGSrSo/yqk9H00yCyAfk+2sb
 /21SxRmmGI6vu0o4nhmD0ibtmVG0AOclSZQav6PhjpeI7m+4W/bKYGfPf+F3nRxEU116
 ouc1rZ8+uPUH9rNkTJmofOql6CDN1U2/aH7b/v/R9E7OFFViju/D1x60sTNXpQMlgRaC
 cbZ4eeJyuK1soMCRWeaC5GtMjM8sktJS6BgLRnU4+uGQuajEvA4AKDHHn0ZUVry9dm0g
 0zMw==
X-Gm-Message-State: AOJu0Yzsi55Aw5FtwhDVoIuYgqSc3Vb7m/Rzap9zlKiv4tEQq0ubboAg
 TobDl8zjybDCLtF6H7yeVRZ2Gu8S1UwQX6RJgh7EzyPjuxu1TqQ15jQdVelHc52m/poZOnNkafI
 NTLVHSu6HkmKVzkSdIiBU2PYNFAcF2wyPumrp5cgBqMoPqVclLYJ2Ct/tAFjx/F97Cuasr4hWKn
 jn4Q9d9pUzwSXw6iRECSUFgvExhgnUtMdYx8kDxjUT
X-Gm-Gg: AR+sD11fu3r7XsRtWuzdfzfRwfFa8AU93kGWsr+v80VVeP5HhvTewCtBN2D42Up5AUj
 ueo3ddKvnYSc/4yh2XxdL8xcggxnjvOUVYJq1g9uweLb9TIHV7oGYJfy2mn/k0bd6u1ZxfN/Qqe
 FDxhYk8ujZnhW8HyfjXHJY+z0kT0YIBlLTQoZGyPAuE/chqf3KyW1AKf/7rfBOSmwij5AyRJkTY
 FBS+NtsDhPZutD2y3Xnabytjik+a1teXOym0Rc0txdKL/I4Ae+WDTi7mPJ8BU+WkrFz5/j6eeU8
 v6dsAlEU8B+y8bU6QTWUVrgqidOBeVWvkWdiP2IfR8ezzcE2J9Y6xflCxaVvbCfrUevc0J1MJOG
 kVwRhrzjc7ymfb1D817tXl5Ny8lzkSbyMwyBWi47VWXS414D3mWlK4Sv3tWafRomI62zJMgUHBq
 9m1Zk=
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr130148215e9.7.1787244612234; 
 Thu, 20 Aug 2026 09:50:12 -0700 (PDT)
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr130147385e9.7.1787244611815; 
 Thu, 20 Aug 2026 09:50:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17f202sm145494555e9.13.2026.08.20.09.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 03/53] target/i386: use ESA_FEATURE_ALIGN64_MASK
Date: Thu, 20 Aug 2026 18:49:06 +0200
Message-ID: <20260820164957.1895963-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do not hardcode bit 1.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/xsave_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 1fa3133b1a2..666a2810029 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -382,7 +382,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
 
         size = eax;
         dst_off = ebx;
-        align64 = (ecx & (1u << 1)) != 0;
+        align64 = (ecx & ESA_FEATURE_ALIGN64_MASK) != 0;
         supervisor = (ecx & ESA_FEATURE_XSS_MASK) != 0;
 
         /* Component is in the layout but unknown to the guest CPUID model */
@@ -394,7 +394,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
              */
             host_cpuid(0xD, i, &eax, &ebx, &ecx, &edx);
             size = eax;
-            align64 = (ecx & (1u << 1)) != 0;
+            align64 = (ecx & ESA_FEATURE_ALIGN64_MASK) != 0;
             if (size == 0) {
                 error_report("xsave component %zu: size unknown to both "
                              "guest and host CPUID", i);
@@ -530,7 +530,7 @@ int compact_xsave_area(CPUX86State *env, void *buf, size_t buflen)
         host_cpuid(0xD, i, &eax, &ebx, &ecx, &edx);
         size = eax;
         src_off = ebx;
-        align64 = (ecx >> 1) & 1;
+        align64 = (ecx & ESA_FEATURE_ALIGN64_MASK) != 0;
 
         if (size == 0) {
             /* Component in host xcr0 but unknown - shouldn't happen */
-- 
2.55.0



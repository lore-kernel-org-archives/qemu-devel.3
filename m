Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D2DFB44CA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBlW-0000MD-Tm; Fri, 24 Apr 2026 04:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGBlV-0000M2-9y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:19:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGBlT-0006OU-Mt
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:19:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so4100005f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777018792; x=1777623592; darn=nongnu.org;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d77vENISFV3A65XabyMzbFCvFzAjCcNL7BdC1hwSU8k=;
 b=FG/Bj/3SQjsBWVE0n6c9RUZXKgVwPLDTwQF2/kcAV0H3k+C085ccR7LaknUJS9QeeZ
 rcKSTEdJSN841r0IAHBuvwmAcehCnm+ZEMdsGtmafYgEQ6GBARMdtZcnWdXLsT+pyk9l
 wOLl6gmWje90Nad9RCcRs9HfTafuhmEHFhOG/ILlrluTwB0yAPSYpMvuEgTlsT819DcZ
 ins/DqDb7uvAcn2JvmOAUaGI1Hhntaav4Nto3TUxqaHKqaIKH0EXTe84l5b9nA2CcY0b
 kLg1BRPvKLSYnvVYEtt2zM5JMyDFvK9rkHWDOspmaxlhpSaVDb/nw3DTrwAOB5ZMKpKX
 sLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777018792; x=1777623592;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d77vENISFV3A65XabyMzbFCvFzAjCcNL7BdC1hwSU8k=;
 b=E7SHcDl65n+R5YBGtxKfTNgt7nytpMUzFge7f3bT7f2vjDe2rs+QNSWrGeAL+8C7EQ
 HCqKGGhu0YFnXeL8JWBCBT+HfDYTZhOOUFgrjwbiF2euGJKDEPQf5EMSVSpjrWGhLG3R
 1TlLa3GJsSci7kt6m518VMkETSqagdAkjku0TCj3Y8ZqPK/k+2cIcZPYOvrDVXEcXmND
 twfdAbJrN6h7owks9hiRX0Bx9Mo/Ht7mcgDhGxUtVeGTRy/yooKorrkmtMq4d/4BFRZD
 e4u7ah70GgQ+RSBuSU4mFArdVvI2HUJZ0lMJE/494rrueVXTx+uZ27wxN4dqegLsF64c
 HjHQ==
X-Gm-Message-State: AOJu0YxAZ5poBA6GrR0ovCDSU8jBQaYhdK0bZZl9OYpCZQry+Er55eZX
 GdeCQjWjI9GvA4sgLGTZMQ7ojdf9aRzzi0Hzn7Hg86is1vYRp7Jz/1KniD62/67A
X-Gm-Gg: AeBDieuZitkoRkLbstbr11bmiwZ6EVmsHevD4pAbdZkI85xEO0+JI+2grCOcRZyFerY
 egCee3g0anhvPE6w3UkkHgxqv42s5foidEsZ0AvJiPMv7IvaK7KmhhFZPkL8PWBFKCIOUMemch8
 ZO1NKCT8AS1Nzt8K+/X+ON/rU0KcSWTftnQKlib31qj2zR+A90k1yy+BwhRtsr2Jgn9peaC7m+A
 qX1KvtTwQ/CCfO2nQNND9Ua6eIIpSuPgTf7Olm4THMFUQNxVB/nxNx2/24OzY35UZtnKDkRila4
 FLUreo13cnjprREv1I6mPaADpGLP2h971ix+IZ+kb62fbcfPzcWFNvOFVtKR6Xg1EJQdAI5P/8L
 LkG0RXOkhtU9THAETb+YZfVuq7W5mHTiJgtOvhanhBBtaUPh+Wguvy24uvTxTjD7SPmp1WXupIB
 bF/oOc1aeOi1bUyqCY90qxbhFB7KEpAxaPOSi+nnXVl4CbFSgTpOVcWAMg1IT8R+u1vsaiZtYC4
 Kg=
X-Received: by 2002:a05:6000:2289:b0:43c:f793:f1c5 with SMTP id
 ffacd0b85a97d-43fe3e0c63cmr47731903f8f.34.1777018791601; 
 Fri, 24 Apr 2026 01:19:51 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm54940068f8f.32.2026.04.24.01.19.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 01:19:51 -0700 (PDT)
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: [PATCH] build: prefer sigaltstack over ucontext on Linux
Message-Id: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
Date: Fri, 24 Apr 2026 11:19:39 +0300
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

=46rom 517099e65de1e2ad3d0f33d3c4a7a71f8728279c Mon Sep 17 00:00:00 2001
From: Elisey <elisey.konstantinov@gmail.com>
Date: Mon, 23 Mar 2026 16:02:45 +0100
Subject: [PATCH] build: prefer sigaltstack over ucontext on Linux

sigaltstack coroutine backend is more stable on some Linux
configurations, while ucontext causes boot failures for certain
PPC Mac OS X guests (issue #3276).

Select sigaltstack first when available, keeping ucontext as fallback
until the underlying issue is resolved.

Signed-off-by: Elisey Konstantinov <elisey.konstantinov@gmail.com>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ab3e97eb9f..742655e007 100644
--- a/meson.build
+++ b/meson.build
@@ -505,10 +505,12 @@ if host_os =3D=3D 'windows'
 elif host_os =3D=3D 'emscripten'
   supported_backends +=3D ['wasm']
 else
+  # FIXME: This is a temporary workaround!
+  # SigAltStack is in higher priority to fix #3276
+  supported_backends +=3D ['sigaltstack']
   if host_os !=3D 'darwin' and cc.links(ucontext_probe)
     supported_backends +=3D ['ucontext']
   endif
-  supported_backends +=3D ['sigaltstack']
 endif
=20
 if coroutine_backend =3D=3D 'auto'
--=20
2.50.1 (Apple Git-155)



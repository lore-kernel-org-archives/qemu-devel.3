Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4EFCA1009
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Yf-00029h-1k; Mon, 01 Sep 2025 09:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4YX-00027X-Pq
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut4YS-0001Oi-SY
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3d0dd9c9381so2945905f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756733199; x=1757337999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+dSMANYXYS4eX2wt62pDprg7NzemwQS+AGCY6LE+2A=;
 b=i8CsUBVWCPUI1LiCR4aJlKMSWtaH3rWgG01BKSsVA1qP+aFFLsPRExjGqxr0V4Ffoc
 JKdUWTcbHzPOKKSiald8IrWMOiWOpPZcn8Kx4wpZ0cqWiu2SeaHvrXKcwPbsaYuVJhIu
 v0GH+QdxoliOR/Sz1aBjSA+219YS3NJdZ5lgeTA+nQkGYl21aUYHTXVRPCN4B40S+DIF
 ebCaFYjZ7tHUxxGoD1bkIetGgg/sl9DXiqvvmBt8CFtkUJxMpUvP/2PxNnL7nA7RhvqM
 DtbOk7Lj+Iw9Is1af/voeL5A2uZFlUu30nzUvE+8LR3NWJCEULhqjgzF42u6jD9LgUNm
 t1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733199; x=1757337999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+dSMANYXYS4eX2wt62pDprg7NzemwQS+AGCY6LE+2A=;
 b=XC6dYLsNRNNqGjFNguhYD1b4IWZXXH2/JT5y2MJcRqShrstoSGRCI6Sf248tfNb/cX
 U4Y23w2MeELTL3NBiP5GPtc3yndTsOfWo49a42xC8+942+3V+WCyQlgsxmLZ4BHUyjV7
 leAjsDLtQvszNN+8hmuTHZBPnlZf0FHA/calqLXqlcG4//2IryFuXS2YM0uD+1UdQ8Jm
 R+fcyyI8KnQUFukT7lgoe15x/GQtt0zoBN+m8OVKXh233K+3zlgScw8hh3wLZ4/Gfe5I
 UuduGLBfS9BWRs+1I09L918rYXRv4Dt0dq+sOm4Eg2KdQWqW+JLplbvObl7FJibAPsgY
 jhig==
X-Gm-Message-State: AOJu0YwW5xnzLCkSN15QMpDSujQXV85A9zbm36bJBx9fXW0NSvUBRIhf
 RpsrkpK/kcHu5vAfLiSLdnVUXwvz2Xvv+fwyDrVojkmuVWIIQ3qa9lRONuilaXHoZQoH4vw78+E
 MKo3y
X-Gm-Gg: ASbGncsYl2a7QqdphQ2cAzVfPCkVZw+nHD/MBhXhMbARSNWxgLZQrkmTyh35VxfIiJo
 PYpUV7DYSqqRdZSqW+kK4xt45V8YlLja6RMyIVoLt4z0NBsGk3C9BEFiZ+DNIGij646w2OyFzLT
 sy8jvbQVkL4jnABEEyqmJzIAEs8ccqC77UtOGma3mIGBM8Zwg/LvWOQEMZXGAnYM2BIt/UagbyH
 sMxB9WjMSbbKB+fydpJkh8N2EpRpkVbr6wTyFp4sppgbEDykXQomp51CpMWq0drZimEBmUVzps9
 BDZHUvazjbYh+NAYn1KKy/GQifDUk/tmM1lKeej1ctCNASX9dWkc/ZUUyQ39DJSGp+MWrlVMVzg
 z/MnI1JKeHoEyCPOS8qGp35Tt2QlINIQPqdP9XXDu9fmSJVh+hLr7Ekczjrd5Qnj3H3cjWPUk8D
 D051bL9tU=
X-Google-Smtp-Source: AGHT+IH/biFnPlU5sduD1LlOAZlDqq09up2/DXS+LzpPSrlccEYwoUtgNnCXPzTclSesIQRP6VzILg==
X-Received: by 2002:a05:6000:4205:b0:3d9:415c:b146 with SMTP id
 ffacd0b85a97d-3d9415cb164mr246904f8f.15.1756733198715; 
 Mon, 01 Sep 2025 06:26:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a7691340sm14439034f8f.39.2025.09.01.06.26.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Sep 2025 06:26:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 2/3] buildsys: Prohibit alloca() use on system code
Date: Mon,  1 Sep 2025 15:26:25 +0200
Message-ID: <20250901132626.28639-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901132626.28639-1-philmd@linaro.org>
References: <20250901132626.28639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Similarly to commit 64c1a544352 ("meson: Enable -Wvla") with
variable length arrays, forbid alloca() uses on system code.

There are few uses on ancient linux-user code, do not bother
there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index 0d42de61ae6..3d1dc2e9e26 100644
--- a/meson.build
+++ b/meson.build
@@ -775,6 +775,10 @@ if host_os != 'darwin'
   endif
 endif
 
+if have_system
+  warn_flags += ['-Walloca']
+endif
+
 # Set up C++ compiler flags
 qemu_cxxflags = []
 if 'cpp' in all_languages
-- 
2.51.0



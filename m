Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAF9FD7F91
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvJg-0003wM-Q5; Fri, 27 Feb 2026 05:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvvJf-0003w9-HX
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:43:27 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvvJd-0001r1-Hj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:43:26 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4398f9e3b40so1904144f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772189004; x=1772793804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z09DeO9ZVounnmVx7N9pPlDmZ1HKHx+K/z55rjb6HgQ=;
 b=O8lKiNDAMZgjcskLGXNo3zc+a7/AwnC0yi/0Q5xEOi4bD0IAd+DUsEWKEB4qnkItlX
 YphSwvf9cqXWyVl2CUCae1i677azpILsR1fBypsXBIK+0UFpgmMOdqLf5c4oNHIyaiTc
 9/HFX32LilJU3Vr4BECznO7MkyhT3r1Cbpn//2Ui+U12djLImEWuBl5fcOZHZMQLaZW0
 s55CFyOLQW/DonoO/nn3OwpplyItkSCHHFSDSm/6hl3wxsaQJged0bhsRM76frVOvEwV
 Dxh/OXi/V5CvypXQFeVFXVrhUHv5qqWTlh2dNB/XSQp+twPgAz63+vGdh3/c3hHHfB9c
 cE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772189004; x=1772793804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z09DeO9ZVounnmVx7N9pPlDmZ1HKHx+K/z55rjb6HgQ=;
 b=NVgTh0ADzJAxXftQ9tD4xnWjpDnfse4KYwWQ2eAcMw8qkOb4DuQVGtXhhBr9tV/ufg
 3QZmVKp2knarbgLATxH48v2qGOu1lCtSqQj02QbJN6r5brryBSdBs2UjqoOup728YE83
 j4vtOvlE8me49i0AEKZUO4wKr4oduPNCJKIVE+32G7g9CNwu9T2qr4IAubDTjipBQWTU
 jYB4Lalccb3gPZ8XK4UYIZH78X7RZD/5dx22viNf77S4H+3pmEeEWb6c3rZajfrFmnrh
 iM/eYUctFKvFQ3idtpklmWIV5WK1WVEnOq5dykvXF6ojZegXi+DjLTLndpdhgbG2yLKf
 DiYw==
X-Gm-Message-State: AOJu0YxU7tf/Oim4ieVurE/gRR1hL1kfhYgTVB0oAmQluCHx9e4qBIiX
 az4qn75xpip73LCkQh6pz5TwqNZ1ahKTcn4j2J+ZAEIYdN4vbQseMonX1rkORLQE1M3iZbJgzw2
 B8Z1EIv0=
X-Gm-Gg: ATEYQzyO+wWovsYoKWPGh22ulC/aXWYaiH+YT6KR1Uxyr57i+wq/kSP1utHVBYd352U
 BOafh+/T07uUBvj80gK/f57e3Shy17Hkj99hfp0px1LhdrdXTqFhhYnMtk4DGnU3sSR2dbVlHFE
 7k4KBQXZ5jbpYKouM5mx4UVQ2sS3TnlBCTEdJs6BSEB6Xu7PpOR9Bn0bGgnbY09kNNucSFxderW
 6W3RdWLYWzYrL5DkABMKFcs77ylsNQj1iuT9RL5wa2m7QUq1jcdlRa3P23L4E8NIexTQ7M5ETiE
 jHDzXorU2WnWUssO5roobk620Olj9/o6lMBFXhyG+XGbk1QgCvj/3bAR6EGIhcrqwKccfp/XnmS
 fRxIkSbheX3qpk1y1LaWBfDTnuHUEJgR6hKJQomuv8POA5QcYCCBycWyT/cIixihHmgqed3vPVb
 WFFtNv6lDFjd5yPh8IZ9CXlI2o6E34XikrpUvIvV6pvVAy0+ubQYDl2rxM3W3cHyd5XIulmvdn
X-Received: by 2002:a05:600c:46c4:b0:483:6bb1:117 with SMTP id
 5b1f17b1804b1-483c9c0fb97mr29471485e9.32.1772189003684; 
 Fri, 27 Feb 2026 02:43:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b841absm109916085e9.13.2026.02.27.02.43.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 02:43:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 1/4] meson: Restrict gdbstub to user/system builds
Date: Fri, 27 Feb 2026 11:43:11 +0100
Message-ID: <20260227104314.81038-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227104314.81038-1-philmd@linaro.org>
References: <20260227104314.81038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Limited builds (tools, documentation) don't need to generate /
build gdbstub files. Only process the gdbstub/ folder when
user / system emulation / acceleration is built.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 3cd1d8dbc66..60415df69a1 100644
--- a/meson.build
+++ b/meson.build
@@ -3724,7 +3724,6 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('gdbstub')
 if have_system
   subdir('hw')
 else
@@ -3767,6 +3766,7 @@ if have_system or have_user
                          output: 'decode-@BASENAME@.c.inc',
                          arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
   subdir('libdecnumber')
+  subdir('gdbstub')
   subdir('target')
 endif
 
-- 
2.52.0



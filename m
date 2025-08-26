Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8044CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwKZ-0001gM-Ek; Tue, 26 Aug 2025 12:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJq-00083e-Eu; Tue, 26 Aug 2025 12:14:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJi-0008Il-AQ; Tue, 26 Aug 2025 12:14:46 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-244582738b5so52761755ad.3; 
 Tue, 26 Aug 2025 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224873; x=1756829673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCoav4mrpfqHaiFY4ajN/hsX2ml/OjgBByRUO4LMbYo=;
 b=ixel1rGR2u7y2Jpq6tR8IVhDetpBV4haWTsqIZwkqdk7lgCJaBlzPKtBzijm4YtFX7
 FWc7b8hvvPAEyJduNQuwyyFHkX2F9zyqQ0Lw8uMUKKAQlsIXuAMgRDFYlG/4zAxskad5
 +4WOFtuTH+WCcLpr5Ne4SS4QLKIaSdqHfdW5nhzy60FosM+lW6VwA0EpJGgmkcF2heFs
 D6LZ08Rjbnw71Sokyw7y1TgpCAnCEIVsYsACibASjlIO37l4I3iRd+oJKteIqR0s3Fea
 XH/9wxL9GcxpW5n7359MvWVpuCFvfy1d6AmFOmbGNJnLDIDmTO0yRxpVbYeWAR0DLGu/
 HaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224873; x=1756829673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCoav4mrpfqHaiFY4ajN/hsX2ml/OjgBByRUO4LMbYo=;
 b=vFuAWeE/5TaS5/eRB8IWq0RYPucrXq33azMhY69KhkNqvB9x2neztNk9K9xg+R0zoM
 CCTBv/tx/bbdVIHhqKB6XJuZxuBpjK9KbbRqY3si+oJH1xyh9MQfNpgmbYapNZ9WywuJ
 xuxjznBMnPOWNlgM/jNzyhMSIjCsx4GcwxzggN8ai9PsE20l6ts8FHzHyZetfJ8fiYWQ
 Vl01sEk+RgEGSlmrlRqxgyY6Xcuw+7ElVpCfEbsGZrfMDD+4pJEytRNKlord67jrrrUK
 zdV7LAdaNmlP/q+66OqZuTIP6ojhXg6JT0uqIpk3NuKuXPT/yyfCl2QLMMOAj0sve4nE
 lyig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS3g3do1pKYvKRG25njV7WKEP59lhgwYktrDgSU3hkcf7FZa6qd2GAo3JWbmufbg/HoN/DdsI/iTfdcg==@nongnu.org,
 AJvYcCWJnK/dXn83sTRS6tzm4hjcDX+JUL8+z9Z9yEnA1IuFUaakwueEu/+nXL1rCvVSMJwQCyoCxgcLqQ==@nongnu.org
X-Gm-Message-State: AOJu0YxNJvZJqttMvVtPBRj79cBzO+JQIAkcTU26oxWTQVUGIqe/XRoK
 +MZNQVm7Lh3/CtDIU4BmXVc3zu4I9hz/tMoxK+H59R44h5pJ8uZgqe0Ik+YESA==
X-Gm-Gg: ASbGncsnAGj0j/axQWkZH/h9p7ypiOSqXjzu0sE8akA6wR+HwdTBilpcC8j/XKvRfGP
 TXjqF4/VKm18QWbFm11IH23K9r8c8m33TWZck01cJAwIBsWE4e6vXzeTVFosbQfTH3q0qHerat2
 vaYIiKX/c6+Je1glO5Yz726YH0fTyS2IMOhiVHiV8XEH4KXR3qGaldMcJK2b6AmIClsPmPJQffD
 JHStv2W68EuB+PUvIIzY1Pwyh3IrwFr4cM0gg5Uefsie6W4LJhi0dXy4zDBE65Z/T4oxJotfBv6
 w2WHRjQRrXWyUzDt+4V0iJSeHDfcGoHECLXtgd/DRSaYFthl693Vr7DkMYH08gm4y10Va7Gdmfg
 Tl0OAve5OBl6Rq6Ll5dAYZg==
X-Google-Smtp-Source: AGHT+IFRCmQWJ9CogmZARXKjErIvYcf/SsL7dJP/MWxh/uQL54ZxQUozCMki9/gXZkOinrrsjTDwHA==
X-Received: by 2002:a17:902:ce8b:b0:240:52c8:2564 with SMTP id
 d9443c01a7336-2462ee8e8f4mr243377115ad.26.1756224873418; 
 Tue, 26 Aug 2025 09:14:33 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:14:32 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 35/35] .gitlab-ci.d: build wasm backend in CI
Date: Wed, 27 Aug 2025 01:10:40 +0900
Message-ID: <3592577fc7a8cbed09c94cf873357dc374dab260.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62b.google.com
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

This commit adds the build tests for the wasm backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a97bb89714..16a3322277 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -803,7 +803,7 @@ build-wasm64-64bit:
     job: wasm64-64bit-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm64-64bit-cross
-    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug
 
 build-wasm64-32bit:
   extends: .wasm_build_job_template
@@ -812,4 +812,4 @@ build-wasm64-32bit:
     job: wasm64-32bit-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm64-32bit-cross
-    CONFIGURE_ARGS: --static --cpu=wasm64 --enable-wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm64 --enable-wasm64-32bit-address-limit --disable-tools --enable-debug
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72147CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut33r-0006uy-WD; Mon, 01 Sep 2025 07:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31r-00045d-JJ; Mon, 01 Sep 2025 07:48:56 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31j-0001wJ-Ph; Mon, 01 Sep 2025 07:48:54 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b49cf1d4f6fso2913748a12.3; 
 Mon, 01 Sep 2025 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727318; x=1757332118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izBMAHH1elIGUTPUqS9W9SlkS9NCVx/jVWrYgAA/7nc=;
 b=SXKBQsnQ0i9/Ql+19vkruBWJLVHrbLrNla4poytlaRU+4Z3F6dz4rg0YdSCYs1l38G
 6/5kR57UEdMTw9rUshMwZqCBXQrplWY35SEjY36FBl+eV9O1c1/CES2aK4HSKepB1SdR
 FqV/SvDvd63xOLcWvM9y+kgtdY0+OM/Om7+chdIkteWgNhJVfkfNVTqhJcOoj1l8VmRd
 fwYZ94elel8pvFNEsCT571RUEHzGfAk4KZiVciu5BRGZhJIB990K6l1C0vCYADv0xa7u
 9glaoMTe9wimmBuTIAqWJjukFnEWCxHkcEjX8RxcNAn316ZnG5FJQ6QW+NXrTaJeiD1X
 tBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727318; x=1757332118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izBMAHH1elIGUTPUqS9W9SlkS9NCVx/jVWrYgAA/7nc=;
 b=TWYKlARHCBssglYev79rKs8aImXN41M/PhuVq2DlQdLzIkPD1eg7mO+r+fiOpVWVh8
 LGRzUQxPvEik4fh2h/Qie2jb1tbvdKyLZRzUpmJS+mMstbXxLUKtXQB/EvVs5jfEn4x4
 s7NlZJOR1v+coLpnWu3zMY+Sl2uU0g22UnqbgKZw9ZK9zFXSYzCZSrlNjsa85yRzzQ7s
 VocnC8pa4xW5TkLnMPxFsT8FrSGNeppZf600SoJ3I5YCNAF17lNaujXWN1X64hrf0xgO
 s8Qcdk7Pc1VNB43AgJfyAxQ/xOFy3NjCd65z+lpTcs3PoDP82mbl0qZQlnq7r75nnUof
 rb/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHWXUZ6rNK+dmWPj6Y5aV2UQ+E3qYYO7zMeakjslOF+sYDLZ+dFaOMRnvITw5vEUkpbGeREOJbkg==@nongnu.org,
 AJvYcCXUXqKbhEyVfdQoiUnviFa2DeRWmg6NHn2ukVYvlBnlH7elt7DcPV+sONhjyPWL/xYyC0wvV5BmAZpnJA==@nongnu.org
X-Gm-Message-State: AOJu0Yw7ZsNiU73tetM3syg/sD0A1E/9Jr07hjic0e8y/1/wN1zsO3hs
 X+002tb+I/19HmlTpGwZ4KY3VC/NPoZvCzGfvci9tlnncHe76nECwb40gn6Odg==
X-Gm-Gg: ASbGnctm/DdgEwDv09Sbd1s5o1BIOjM42+BPSgt6EA2/MjbWwgNZe+Wd/wbuhjB4Cy3
 pRHF+2Db6ctaPjm1tMztAzN6lnRGJSb3uRmVW9RLeHyupQJPjqdFq1l5/bjTYAKUGsiVn6OPqQp
 +wg9bSCAWQTmjUcWtrWS2/QrpXT7X/o54T8Zsx3jBIBRUgSuKDxEdITaJBwu2FyFe8hycmtpgnx
 nh/gn2PlkG1M6l2JUBuQbZ8qXDvsnGhbuVeWjXfo8HyxVBsbS7a8iNfObvBhGkmJ4dipSinzdZG
 0LE6TUxrrAR6Thztr5Mcuj6ushh0lKBhIOlOgvo/9faB+pqQZWwNb9zjq+HpopLXy0psk9sC6d1
 PoTDVhxTk1HIo2Ld/VfqJ6OsyXLOcAxWna7d7QjDwhC8=
X-Google-Smtp-Source: AGHT+IEnkcgQiFfDG8r/K1svMya16Z3P/LTmYW2pXxVN1DRaAJAjP9qgGXMZmBc2ozDpfFJaTEwWXQ==
X-Received: by 2002:a17:902:cec8:b0:249:44b5:d5b6 with SMTP id
 d9443c01a7336-24944b5d87emr96061635ad.40.1756727317902; 
 Mon, 01 Sep 2025 04:48:37 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:48:37 -0700 (PDT)
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
Subject: [PATCH v3 34/35] meson.build: Propagate optimization flag for linking
 on Emscripten
Date: Mon,  1 Sep 2025 20:44:36 +0900
Message-ID: <bbc6981d708b999145275459b632336808dfbb74.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52b.google.com
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

Emscripten uses the optimization flag at the link time to enable
optimizations via Binaryen [1]. While meson.build currently recognizes the
-Doptimization option, it does not propagate it to the linking. This commit
updates meson.build to propagate the optimization flag to the linking when
targeting WebAssembly.

[1] https://emscripten.org/docs/optimizing/Optimizing-Code.html#how-emscripten-optimizes

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index 42b9004a20..ffd16fc167 100644
--- a/meson.build
+++ b/meson.build
@@ -878,6 +878,12 @@ elif host_os == 'openbsd'
     # Disable OpenBSD W^X if available
     emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
   endif
+elif host_os == 'emscripten'
+  # Emscripten uses the optimization flag also during the link time.
+  # https://emscripten.org/docs/optimizing/Optimizing-Code.html#how-emscripten-optimizes
+  if get_option('optimization') != 'plain'
+    emulator_link_args += ['-O' + get_option('optimization')]
+  endif
 endif
 
 ###############################################
-- 
2.43.0



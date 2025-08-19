Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860FBCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR2B-0004M0-L0; Tue, 19 Aug 2025 14:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1s-0002SG-14; Tue, 19 Aug 2025 14:25:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1o-0004kT-TC; Tue, 19 Aug 2025 14:25:51 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b4717330f9eso4046105a12.1; 
 Tue, 19 Aug 2025 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627947; x=1756232747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0ZS0eANdrz5r5AN9KWFnrb1+idZJ7pMgAy4XohkPPI=;
 b=fR25nJV+LVNK5NvOKdzdH0WETCqKRxngqeVOBXHsnzsy1VXQCVGyiT97emZ4nvlfHe
 uaAmTSXy6k52saaINFg4QKbZPy+/+584veFendIme/z7IYqefoFM8LNyE9t6q5ALlBy+
 ug/Bctajcb7DpJW+F0lQM+iC/LXpmoax2MsfZqfQj2CF61fSXr7cBqXV6CgzMMb9xWL2
 NwYvCvTp4WA9pxVxSDmUpEO/Aj8pO8nresnhcG8URYU+2Ixm5iWjss/JwUGDhLUXgHcT
 /fnE6xhTjK6wFHKsKl/jhzAN0Han/OeU8UcsZE8eFqpp88m7Y1x9R87sPwxlegybUh1t
 rNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627947; x=1756232747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0ZS0eANdrz5r5AN9KWFnrb1+idZJ7pMgAy4XohkPPI=;
 b=XLmL+aVbN1ZKxXmS16BzYumiUqtopHHC5UxFp89jJNMjVhAJ5snijoZQKRsXiUTlAr
 OFy9sBq86efezDsPX5U44aolwTQ6qjkhsv4OEqxYJrx2D8HmN615eu+XwwgMJsSj3uwn
 ZWp3emxbReRHpmbFi4aSlvDHK7+N6sHL2u5YHgVKHDi18+JbN8xn5yfPRTMENDEKVNF9
 sBe+cMpMgT8MTWeAPUHz+HStAYA5rJhu6W63+PS4iA3nMGGid77smMsW7cot/EpsiFZi
 SURIpzAyWj+PkEFqPowsBVSrin0UIQEixOik4cDskEFPKVkyjZRcusmeMVK7r8I4QI45
 YENg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU41Wo3dS2iyendSCsD+Op27FvE6+553yG286RpA9xUXcTgRiLP51oYlri2emJYBkKjrAAw3BvJmA==@nongnu.org,
 AJvYcCUPxE0kSMa51zyxLvo7iKRzAShYi5CHpinCLt2Bwp1FtUB6keDYUYd/YI2qHA2jc1BlZZquNYNM+nYwtw==@nongnu.org
X-Gm-Message-State: AOJu0YwioIgypGZ70982ovWGL2+0Rf/QzUzW2hawgc26KErEp1694O/a
 sNE7BOggi0E7xu8gZ3cLRje508rBwtzYGp1vxxQIzoSpyfa4B/L6j9s6R6kwyg==
X-Gm-Gg: ASbGnctc5/6qFq23KpeZoGu1EXWlSyNc4c2rP6mEeivS4jTrqM3Kcl1aVp7O+xFhejm
 4bczX90GW9NCwWOOJjLyzND9mI0O7dI3pc6OIJxXFATrkgOkJZaGLa98WefFEjIDFKvGafz21vL
 w0jsryOg7F1W29/NlLFf0McYw6yVboMqpceA5cUqIhDa8XQD0MEp1fcq9TaFzbYCBfJ9QX7JxEZ
 sLnQiE1OBm3QHlP05Iq+Uj9EVmgP1+qDBGmLcmaV1FyYmP0Wem3zHZXwRunbap0W+4+f3DOV1RM
 GGBgWWs8dNJ44Cql0VTI428eLqruLRtKU7cB9UkFhtN75tNkcGQVPa3KgFZ3SX6RRv4S96jG5px
 TKcPmizW3i/3n8snQMwZjkg==
X-Google-Smtp-Source: AGHT+IHWOvZcNEk7FSavWVndeZWYqWhy5js2qNQ/82vDiEuhfJ4Ba51BpMgeRVwrF5FC0XW1ixu/BQ==
X-Received: by 2002:a17:902:cf4a:b0:235:e1d6:4e22 with SMTP id
 d9443c01a7336-245e02dc4afmr44719865ad.18.1755627946786; 
 Tue, 19 Aug 2025 11:25:46 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:46 -0700 (PDT)
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
Subject: [PATCH 34/35] meson: Propagate optimization flag for linking on
 Emscripten
Date: Wed, 20 Aug 2025 03:22:03 +0900
Message-ID: <07548c6633e8f6be080a988a9e60c3c2beee6eec.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52f.google.com
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
index 5fee61a256..a98b9f836c 100644
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



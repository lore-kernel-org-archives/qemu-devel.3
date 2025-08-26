Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E3BCA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwKH-0001IC-Tb; Tue, 26 Aug 2025 12:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJn-0007nH-0G; Tue, 26 Aug 2025 12:14:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwJg-0008Hs-6r; Tue, 26 Aug 2025 12:14:40 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-24622df0d95so34660675ad.2; 
 Tue, 26 Aug 2025 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224868; x=1756829668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izBMAHH1elIGUTPUqS9W9SlkS9NCVx/jVWrYgAA/7nc=;
 b=MptF9O1z4uMo2jIzA6X1rAJuHXSsDYrm5jYHuNZaef0ciQlIcUiNb2lIlYFmJLAyXb
 2A0Ru3XJ3txRxilzsosPO2NkOVPReP5cGj3NvqGwQDouEUpUZsAnLN/s26QVBDH03r3W
 N05R5d9L3BClrgWQMIVZzV+nrS3fiHqpFxBGQXHxHUImNF51+c+Nih1qjvPlFFCKor9Q
 ec5qsuLXGFIxDSJF4NQHPOhN2DwmXwlrsePzUPQcZ5beGAFNQSbpaGVPhvPjTt/R9iBT
 f4dCbIuCIOnCuOKOZUKrTW4b8LHJvWAwJ5A5DAIsUKA6GeFDtYXUANq3b/PtwlT+sgZ7
 585A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224868; x=1756829668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izBMAHH1elIGUTPUqS9W9SlkS9NCVx/jVWrYgAA/7nc=;
 b=JLwlRKKhBpXg15bVNmULzFdiEYrFxueqQsuimaUa39ihvEpntLMCihucBoJLOf9URj
 oTUskTHSFvlSzm+CNTyobpKdLLAv1O7bSS/A2GFys5UUCDwgG07GSOPVF1kgPkhWCvPq
 ofvD8reMtVlzV9gY5IP6n1FFg022qFz3eRaMnnQl3oGijtSTRrG+sk6f0o0ew815VtJF
 s2/L9Xl3tqhf7jBlSq9Bu8L0ZJuJI+cGGn4hpEf2QQS7yKfpewkvPtuIWWF2/2oEi8iG
 WGhFSRiZnz+RlqZ30afGRvomS6IJKMXb7e604I1fUhxyPIBG2gxDMnyr7j9xBR/r6ZZB
 rklQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6puKNlYKOvAeoBiQfwiMMGe55VPu5JLZGOq2fKWuoL1PMa7gsb+tCq57PStahTOzjd+zfAfsEfcO3bg==@nongnu.org,
 AJvYcCVoTT+yzm/IsN7Ha/AM1VqkoyeftjL/elaqhSfpNYenP63OVaV/3TcXoCLRpZd/YbjJJbUF2UwhKA==@nongnu.org
X-Gm-Message-State: AOJu0YzZBRVv4Y8pWlylvAraDCLIKf+bxRn8vgN8cwBI7UVnbMmSQ9NA
 BrwAe37GCULFPdmNcKPRv3qwAjpcCW1AlZUUdi18nCn1VOy/mzquTX/bIO7UsQ==
X-Gm-Gg: ASbGncs1b77+ooVZrOeKz6RZe+XLSQe82QN342R2kfDI81njzOHINFZXhQjwTnWTylb
 Mta/U30MeG6ebJ3UqM8fNsjK6XIwqPhfs50/9FZ2B5ZYm71VUyKbWgTFftLNXcIGza4Dhqd+R+b
 nd+875+x5yA3cSfc7aOdiNjB8VIvg/c6HicGNnYopGlH0ATGvDiJYHkfY2wyMQsy/6W48ZoPfRF
 8ifO95q/JB/9cMBQ64j5NOjerEBBFmnO6RqiF/IqurpnzYUOAmuBeSXedl7u9fkgl6Xu2m6hquB
 cnfOWSA3nzfLZeBBafVxKk9zndSOvJdK/mpnLKBp6T4UTcCR9rvJ2+hK9n4RHtTbPtLn+lQxg08
 3mXPrRRv4XbrnJgKfIXsulA==
X-Google-Smtp-Source: AGHT+IHUaRym/BgzD7HHyNuwVdR2MthcWmtpFFAqt86o7ToC+57LTEPiipkrB02EMaYkLygJNT8VxQ==
X-Received: by 2002:a17:902:db0a:b0:246:a4ce:1219 with SMTP id
 d9443c01a7336-246a4ce1737mr129343115ad.21.1756224867543; 
 Tue, 26 Aug 2025 09:14:27 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:14:26 -0700 (PDT)
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
Subject: [PATCH v2 34/35] meson.build: Propagate optimization flag for linking
 on Emscripten
Date: Wed, 27 Aug 2025 01:10:39 +0900
Message-ID: <eac7bfbdd2ab204e1310ca33d57ef07b8150523b.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62c.google.com
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



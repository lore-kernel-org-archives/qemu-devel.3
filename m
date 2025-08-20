Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52853CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 14:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uojhI-000454-TU; Wed, 20 Aug 2025 10:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojh9-00042f-8S
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojgm-0006ta-AN
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:41 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3c380aa1ad0so466409f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755699675; x=1756304475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tV9lKlTpVnTEM5miEI9pLJzly0/wCZEDVMKwbl2Bf4U=;
 b=JGGN+ef9bQKl+B8cpELbo+B1nUp7PlqKXsp+bc03wxTrx2SZy6QnSGYoRseNDWzGlw
 vOLcj0AKj5QW00/wZhd5u3kNTS6G2pmNhIQslc+tPzAK1zReBPJkCdKuyjeTz4mOibXA
 x9jhyeNrasYxAXp+LwST44O1y4752cphIikj8rKdTGyWcZFLRHsk9m5t0d3Txm/V5oAy
 aruDOSw6+eJN+8UxVpyx0xZ040eDXgSq7FdOKNPUvz1GBUxT9xrsy8kivt0EtxJDgQou
 +FpWOTjWNzCrGuK3GA7UUqc41330JAzKWPXiEMwOwAiqmaOa6RqACRlhds0kBvMWrMf+
 h0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755699675; x=1756304475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tV9lKlTpVnTEM5miEI9pLJzly0/wCZEDVMKwbl2Bf4U=;
 b=DAq1ypYY5uH0MoXsMmSUdPEO3dxVVOzF4EFQ9xNHqG4eu9paGBjZomgSaCGRg7Tpi+
 OUvv4peO4s6+yRDtmWYX9DeTjdqwvuOPeeY+tOybNf3q0pCMWlqFwakwpIyrqk1UgfbM
 P7NZupmhRsvicP40WxIrp2QCWmh9TatuHDPTy5sHZEFvbuvNYpgjnB4fmsOHuPAUdcxF
 1pzFbzZ0WGXXQVPyIYPn5sgTtfYRvN8rfG4kUIiKK18z/pVru+jQwb/2psLrKzGlP5Bb
 0p/V1swXs5NANVLhxuPoWDB4iat+xRfLaQ1619sUXLIwDwpD2WWtwM770zeIyIN1/him
 hzQQ==
X-Gm-Message-State: AOJu0YwboSZ+SHe00DaXsHDHeNH12C5JOZFwbigxMVa206xlnrPKnMIH
 9A9JOeFhTKms17/SNYhrq9UHwWaUfkt0UKfs/xiuKlnKEtAEj7TaF+dgD3oYxtCsImAljLO7zHb
 ERTRD
X-Gm-Gg: ASbGncvnR8Bhjbvyxzc9xUS+jq7vAv83A5l6M4nte9TmyhspG/+1E/Xhr4+rC4R7Qr3
 +yo4ZBLc9oLRuFpzWWxj/t4gBgQJ+6jonDr8uS5a7SvQZgMNWkmWDd0sNs4O/YHdFeu2Z/xB5ae
 xXNAq7xLZTVMxzpfr2urFlTjhRDHrMrFj3kYEO4RDDrpXoDYJMaMJPVflJwCybhiEdiGtfCjEnr
 w++X6X0o8O5ITJtpj0uRvWh/7QKCGP/CSw3P4dV+uHNXvc6RUuwdBs3ukek18IJw7NPJu5avHmD
 GWjxoCv8lyoTF0IKDt+q4Qe5e2oS/OH2b8e3DMLDoBljQSgHBb2CbeVbTVlWVrbkqxj6vy9Wcdd
 XbAbXBxFLESY/pBoa96J0pbsXSmSPHVKGOmitw8M0KMQvdBlt3C9iZtOsVZivoVPYUaJW16lrlB
 s5ig==
X-Google-Smtp-Source: AGHT+IEd4wSaUboXf2BALxkOyDO4yLUgkE6MStOJhCazaR/TrKcC8xLfcfRtIZtmeu8NZC0uR0xjvg==
X-Received: by 2002:a05:6000:250a:b0:3b7:7c3b:1073 with SMTP id
 ffacd0b85a97d-3c32fe1a409mr2035567f8f.52.1755699675453; 
 Wed, 20 Aug 2025 07:21:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077c5776fsm7924100f8f.61.2025.08.20.07.21.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Aug 2025 07:21:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/5] docker: Remove 32-bit MIPS toolchain from debian-all-test
 image
Date: Wed, 20 Aug 2025 16:21:04 +0200
Message-ID: <20250820142108.46639-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820142108.46639-1-philmd@linaro.org>
References: <20250820142108.46639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

In commit d3322023bfe ("configure: unify again the case arms in
probe_target_compiler") we lost coverage of 32-bit MIPS with the
debian-all-test image. No need to keep installing the toolchain.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 420a4e33e60..bc74d65a634 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -40,14 +40,10 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
-        gcc-mips-linux-gnu \
-        libc6-dev-mips-cross \
         gcc-mips64-linux-gnuabi64 \
         libc6-dev-mips64-cross \
         gcc-mips64el-linux-gnuabi64 \
         libc6-dev-mips64el-cross \
-        gcc-mipsel-linux-gnu \
-        libc6-dev-mipsel-cross \
         gcc-powerpc64le-linux-gnu \
         libc6-dev-ppc64el-cross \
         gcc-riscv64-linux-gnu \
-- 
2.51.0



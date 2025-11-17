Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ACFCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxcW-0004xr-0Z; Mon, 17 Nov 2025 06:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKxcU-0004wt-HP
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:42:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKxcS-0002Uo-Jv
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:42:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso22642575e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763379722; x=1763984522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fR70elkEGu+FKP9bV0fr6f2hWS1wy6kNuGAdttasHzc=;
 b=yBkEu8BUDq/12uscxOGyjM+rvveQDAs4wV+eaLI5OU4c0ycEo3zICcIfPSzVjAFtTF
 OKQthw17R/cc52r9rGSbRKHq0Xl/6loRnAvUhagXQj77aa+PgqEv0+C/7Ggk/YkmOuVV
 oAZtxcGw20ZYsX9r8uJlutUuCZbe9ldzuUP25s91SaXCH0UKNZpvTDva7hq/59eakbF6
 j7lOIc60RTqreM2yYZEETC1VNTs6qANBEhRiGRe9bQNDppmznzRSuVh4o9WCUsppQBrp
 oyV5Sy5ff33K7Ydhnvw8jj/+teXrNKT4JabW41/iQicJStXKrAmOIo632KRCS6vLX5Qi
 wpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763379722; x=1763984522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fR70elkEGu+FKP9bV0fr6f2hWS1wy6kNuGAdttasHzc=;
 b=ortuLApFxbHbjp3S3Z/DXAm6oLRZvbvJtzro1gsqi1lrRoVsZAu7zOaeHxfYIO/+qB
 vq7doA1FUNRtcCClP16fwbJhyCkO+B7ovMG80R3OEzP79vejKZagVeyH4FJNgdjhf55N
 kmK7zX8rfopKFY2STrg293quOTowHz9BTuDShQMh9UD/PFOI0/trOCqmOA/RBLnUQy4e
 pd13tJOKFRsiLxWiQ4+hP9+1HkMqf75quupMJbHsNH/q+YAXeOadWPsEj9AUXxJ/U1ua
 h6SnatW+jvDIhX32OiGyx8ktJG5p7nz5sqHEfR03FlS0L4o1mApLC3cmeOgS28mAVTFa
 z66g==
X-Gm-Message-State: AOJu0Yxj4QR87YMtJYN4wBc/D5zJesbjhWScWb9f/dskymo2KJ7Rlng/
 VjlcxX7Eb0Vu0nTKgsZEh6wKg4sSpoOgMI3PH3lNyVkH9cSjAlm5EKNj/g7jzUvYD6w+Zt8fU3x
 vLWithyg8Yw==
X-Gm-Gg: ASbGncsiwL4qjYm7z/y27h1vUXvN2fnJxueeysnObUFELvVP3LSWUW8wgsWgk8XG0YR
 5iCNTQTSAlDnNa1mZQKPGYh7vFW46dWqUQMxEWog/OSmN2bNcDOzT3iHPhyUkOYqYacGUAvU4aB
 oeWUpWvwRSG5XGd4DI/sjipGKgQDsRtW6QMo2z3OzLFy87nkcdQfp4UcqZdibQC1FZelindx20Z
 j4SOAo0r2VroiiwkxCBtpLc/blBJq34pvlw7M841IsxqiT21xtiEUGmiy4SjNXlzzoLdaSwwg8O
 m6w6hp7mfshKMCIAtOzIIcp1T+DSNGhX9VZ3tcqesbECSZMldLOnXbHSHH2kZurdWcRiX/cv+r2
 cBIpho/BGBWD6AMXewEoEZ5hHuLvfrw/bLk0ODC9G6oq7pNlDWLrYUriY8Lko7asXI2aVTpbz+a
 UmEvJ8UgoAkHb28Z0fE2dJLVdpeickondDcvdK58K3v5BprhV2/Q==
X-Google-Smtp-Source: AGHT+IE8qvPWC62cKZpJnp1rmxQC8sZ69Lrv0gs9APokxYyd6ZUuLfvwauHv+uNb+fgms3Y1r42kIA==
X-Received: by 2002:a05:600c:4505:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-4778feb255emr130182985e9.31.1763379722375; 
 Mon, 17 Nov 2025 03:42:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a2422d93sm24018635e9.0.2025.11.17.03.42.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 03:42:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-10.2] buildsys: Remove dead 'mips' entry in
 supported_cpus[] array
Date: Mon, 17 Nov 2025 12:42:00 +0100
Message-ID: <20251117114200.60917-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Remove 'mips' from supported_cpus[], forgotten in commit
269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index df4460035c3..5ddec8afd7b 100644
--- a/meson.build
+++ b/meson.build
@@ -52,7 +52,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32']
+  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
 
 cpu = host_machine.cpu_family()
 
-- 
2.51.0



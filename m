Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DCFC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzoi-0003a7-T4; Wed, 16 Jul 2025 06:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmP-0007w6-1s
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmK-0002Tu-3c
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:28 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ae708b0e83eso839233966b.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663260; x=1753268060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXWIVuVE+m9Yy/iso2wptIe4IGI2woLURJV3ftNplj0=;
 b=ugiAs1juFic7zuwVM5ef5dQMZj4yS/tM+t8ecITM+7uFB2bSwOJUrycwU7Z7eoP9rN
 iCDGpZ5yqPM/52Y5my5a2vURakxcUhBr2kHYTCytKwGuctckkQckSRoSnm0NTP08VH+L
 S0XiBQChIwmG3fEbT35WSVS7SyGzlCSIB9gDquHZHJ7ZeJyC70v6LQ8K7SptmvXpnI8W
 zjphA5Aq91p10FW0B84DvrIpIgR8QOHGSwo/HBRFqYVH32RZxGdrCtjZXU/l7255OrBQ
 xrmIIOsPTtegbM4P6O/2secxazvDSpti/ELrptoEr1VJqHP5qTC1DUkpx0o9fVYrJUlt
 A8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663260; x=1753268060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXWIVuVE+m9Yy/iso2wptIe4IGI2woLURJV3ftNplj0=;
 b=Oq1WI897QHkhvznTafGf1SQcLeqAX7gdtUrM1CmurbcI2xPKohHVO1KhWJrtUApD3B
 oT7OyeG995ZoTxzsoHa0SHhnvj2IjDLM59SSJTT3ae1LThn29R0ByOnxACrcbOFzKiv2
 dSu2sbgz4yObTz6KcbREMIzzo/6eM2ngb0lKeKpLEUWtW73zCIBv9jQ3DssP0IOuqrb5
 MTRvl++m5/G+7RDysE1oZYFjx5orwb9XKFtaY8yk5CrFiwxyDj6j5KI+UBlKproQ2lR7
 xMscp853gknrrQ6VztfhylqxW1QayCujfH0c7zH3Cj6ctDuwdfQGLdXkwjb78eR0dQjT
 o81A==
X-Gm-Message-State: AOJu0Yyo+alkj3phLyK96hfMX4r8WNUtTWOTSEXLmCmeWObxJQP7ilYe
 Dv11bYykumzaQpKmYQBqfeMlj984vqyFCnUMhuGwOYYtjyk4HW7SojxX+VZCV3HWBtM=
X-Gm-Gg: ASbGncutLLcf3RmNiSSfe83HoLMSDRY3K1egk/L+gUE/R57D4lN25xWgT7KJPxzkJO1
 HZDiRhaRW6X++K8kGmcdorGXL77Ly9ICaoaRuKwvt7ODYbGm6kOn6QjREzCwCdhRAf5ARrWxacK
 0AkBo9v7h6PZdWEX2DOFpmHLaUddRyrbhUCZGXsu8zw0COccFIJjzjuUx5Bw6gBGb9audguDJXH
 Z0znr2wN3Z45Bx+gzMGpw6wLCX7x40O7GQIH2d41m4m/nkmS5h3TajGuV+aU0a+b8V2h47YbzaN
 2UNHFoCJ1DOj9c+mS8Jg5PTxEhqJHrGCiKmZXBv3B3p4k3yH8UAOSmu2rCir9dZiUsENea9p+vj
 /2j2sjBtoW/i9xo+BHd5W/a0=
X-Google-Smtp-Source: AGHT+IESzbaPJc4HVzRfzl8+weFLL1nB4g+dhuUoWtTiIFE7yYEx7M/AsbzpOTr5giDtXhQ3Q3zh0g==
X-Received: by 2002:a17:907:7ba0:b0:ae3:4f80:ac4c with SMTP id
 a640c23a62f3a-ae9cdd834fdmr202574666b.12.1752663260454; 
 Wed, 16 Jul 2025 03:54:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7ee4860sm1153210066b.47.2025.07.16.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:54:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E0335F89B;
 Wed, 16 Jul 2025 11:54:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 3/6] configure: update sparc and sparc32plus target
 compiler detection
Date: Wed, 16 Jul 2025 11:54:11 +0100
Message-ID: <20250716105414.2330204-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The sparc64 compiler can nominally be configured to compile 32 bit and
v8plus binaries although in practice no one is now shipping them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 2b2b3d6597..3651cc3085 100755
--- a/configure
+++ b/configure
@@ -1356,6 +1356,7 @@ fi
 : ${cross_prefix_sh4="sh4-linux-gnu-"}
 : ${cross_prefix_sparc64="sparc64-linux-gnu-"}
 : ${cross_prefix_sparc="$cross_prefix_sparc64"}
+: ${cross_prefix_sparc32plus="$cross_prefix_sparc64"}
 : ${cross_prefix_tricore="tricore-"}
 : ${cross_prefix_x86_64="x86_64-linux-gnu-"}
 
@@ -1371,8 +1372,8 @@ fi
 : ${cross_cc_ppc64le="$cross_cc_ppc64"}
 : ${cross_cc_cflags_ppc64le="-m64 -mlittle-endian"}
 : ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
-: ${cross_cc_sparc="$cross_cc_sparc64"}
 : ${cross_cc_cflags_sparc="-m32 -mcpu=supersparc"}
+: ${cross_cc_cflags_sparc32plus="-m32 -mv8plus"}
 : ${cross_cc_cflags_x86_64="-m64 -mcx16"}
 
 compute_target_variable() {
@@ -1543,7 +1544,7 @@ probe_target_compiler() {
         i386:x86_64 | \
         mips*:mips64 | \
         ppc*:ppc64 | \
-        sparc:sparc64 | \
+        sparc:sparc32plus:sparc64 | \
         "$cpu:$cpu")
         try='native cross' ;;
       esac
-- 
2.47.2



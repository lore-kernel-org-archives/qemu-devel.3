Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27004C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNGNo-0006oj-K7; Thu, 05 Jun 2025 15:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNl-0006n5-1Z
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:36:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNi-00018X-J0
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:36:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cea01b9cso4672745e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749152165; x=1749756965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rl1Q+tx40XbBr5+knuEz+9jWMcm+8B54eODQxezOx1g=;
 b=kUBllly4LO2LIc/Kh7eZ/AZg5veY02yZ7suMxHAPpCWvFUsheBPee5x1ZYoJDdpFsN
 +vrFVPtoKcL2zMOqsVWeU83UpaYxfDZQQdorIUnzi/wE0d2cENpOurmbHihw/1agQBcg
 WEiVWg0dEN2xQLU0+uuNiVfT72IvLng+RV25c+tDzUr/LwbNICNmH81ln0wSci0Jyhlu
 bofxJRK17elnZQ0y5pKFqkL1SK/hNmGylDfyCZjANpOO/tGldd2OPFSViOLItbQfjIRF
 9iuVZCVaTgkVm7GYNgCTnSC6qsAIWGAAUeioU294+EXOAeF3AamTME/CM7Y4/hG6pB/c
 GTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749152165; x=1749756965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rl1Q+tx40XbBr5+knuEz+9jWMcm+8B54eODQxezOx1g=;
 b=Tugr9JD5+eTRYp667aoii9T1VfHIZlfOXBCY84t7EeryesuBNZh5gCdIdYgEOB4oV+
 Z1nnUMZWHc1RFEsaIVrChuG0XohSgQ2/XB+/vH1lNePBjFoG39pGFnFm7mQZZPyMHLHF
 a9rXK6S+RFbJ2B/U2b6twMWDmNxaDI6wjDSOTAAkNnOMgMx0oSBlWHp9Cfu0qBCuDt+6
 9lSr0zs4ZLHh8vu+CR+eks9+D69akge3KsS5bKop73hICbeg2IJX8OPi05DJbsHyFwV0
 Hl3SWv+Lrhmx8zi5vCdYbL3lkqX4eR/Q5Tl+kH4x56nm5N2pBAIru6AvMWFCpTsjgubD
 IFTg==
X-Gm-Message-State: AOJu0YxeiJi83yMpeCD8V93qKltYD4EhU5JiJiatp2QYWzYJFMui13GV
 1LjQnpONOAGEYkwjo3fsyRoFGbmWLQNMWy8ruCqOUuU580Yo5BR+WEsxcaLl9t3gnNqsN5J9jF+
 RSIC32Ds=
X-Gm-Gg: ASbGncsMBiwc0KvA+AN9661BQcceU6eCecEOoCltxkU2pbZR4GJNDbH958FzgIUMdfR
 Ky6InlOjiRk2MC72mZXIffGOT9UUwZIgm5ej8ipQVTmzJOjj8WA3MoknGBR84KAlWEU3ItM8F5v
 TN/w9D2lquY5c53mHvH55WEi/BKsWkf10H6HbBtj9FqHvdYeD7cuJjgeQ5SDSnUlaMp3QTAJDpl
 VX2iuqeuSCOhfTT1eTyXB+T5Q6DiZspJiCCVB/692djBicKtRIbuAH5+rclA792mOiNgmEkUSLG
 nXyMjp/1UT63/EIU5jKqbN/8981VixNVy11+aoWd2COYSrpGA1Zr/yyGonYOtggoVL6ZvJWeqP/
 m4l+4GZITXV2trall4I6slwC25lBEhurOHD19
X-Google-Smtp-Source: AGHT+IHngvxzU4PUDV0Uup5trNoZ4ZlhKEuRRfnCUoHwKu1DvNLPY/l/UWbiAr7tFZSI0B2oAwy7Zg==
X-Received: by 2002:a05:6000:1ac6:b0:3a5:2f23:377d with SMTP id
 ffacd0b85a97d-3a531cb1037mr317670f8f.50.1749152164760; 
 Thu, 05 Jun 2025 12:36:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452137258bdsm2246645e9.27.2025.06.05.12.36.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Jun 2025 12:36:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 4/4] buildsys: Prohibit alloca() use on system code
Date: Thu,  5 Jun 2025 21:35:40 +0200
Message-ID: <20250605193540.59874-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org>
References: <20250605193540.59874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index ef994676fe9..8c6ccb03c71 100644
--- a/meson.build
+++ b/meson.build
@@ -774,6 +774,10 @@ if host_os != 'darwin'
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
2.49.0



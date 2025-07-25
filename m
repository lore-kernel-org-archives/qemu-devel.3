Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88795C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcN-0003bm-3j; Fri, 25 Jul 2025 11:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc4-0003O9-ET
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:42 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc1-0002U3-K6
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:35 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so4816165a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458330; x=1754063130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7g+EQl4FO2y9seoDYtW7fldlHVS7rtc0zlRHDP7pw3A=;
 b=QWU3yvlUZc38sqUvVp3K1sFOC/IFtG+UKxgQGf0bqZ+fAftF+8b0zeulO76mjsZSVg
 K4W0p/H9mWrrOoHhRiDup2FaUC6VPo+08aZDjFK7djBFgO9kn1vJcqV4BefA2HmHQUGa
 GQVOWlRB/vFNn7H2ZeHjyGw8gEgoM40HlIH57tO7OOcrKlbaENDRCkqGdjaSY88y9j/i
 +zNb1gea/DqX0YLIi7UXkEGmDgXLNh8/STcUO9fWzeOKbFVSSFt+94XO/caqDHJVRewG
 lvzNAIaQP8ylW92n6qGJZRDR8bw8G4DH4Iwc5jLjB/64HBDzcOAlRjx8d74nFhlV2eBI
 yg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458330; x=1754063130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7g+EQl4FO2y9seoDYtW7fldlHVS7rtc0zlRHDP7pw3A=;
 b=nGrpBod+BQc8iPjUfxeTn3JGUUDR25A9S5sc4bY4nj7ju4RXlQTHI0MaQBp5PGTcrC
 hH0XnZFlwuWccG2RPCc7Ii1wRuD6LxlKWCE3n/xtWmET3WXFp7TTHDoNZVLSGsryZpU+
 tWWTv8OVxB6DUWFwSFTuXflNgf0T4lSsS5ShNg5F5YfPaO5InISlzW4EVKbt19M00H8v
 nffqXNNvdcjLoyku023be6qV4dNIz7vr7JR05tOfndDuEH79wW1WCU6V5rAi6u2MMY3X
 XqJhItOeV01m46lTja9kFX3oDx1fGKfajzcfCdF8xbPL+v0iGCsFqCWsWZ+dy88iXyNR
 Ucvg==
X-Gm-Message-State: AOJu0YxO8ybF7oesK3Pa6H0MZ5coV5q62Nn/pn3e9l3lQkjUI416olXI
 uZJfXYnnbqMYjYpASZwpd0I1BxPnaVhRLLyCZ/oqwMBY11UjMJnDiiyp6Yy9itn4+TU=
X-Gm-Gg: ASbGncvHLCAqiTtAfgnMv9i5SiCeNV7j49V1qMd+twB7CY8jgIHp0WLztvGLTI8Fufk
 GN3qeGCjnTQPlzRQOixITHAjvXRkAlJDoQW2a3KC7O3VlSJRPpe/lm7gnsT3UKcJCqSUkKoWo9p
 KQK5NMEAi7Z65BuKAmKI9/LuMSTd3r975tsol1FzVsOqIBIhdv5hgCHjQ/bsWb5c2zOKr6I3GiW
 l8RYv/quwWCRCTcL0LSZ6j+OaJZBkSDX8l55iRYQOlPCHxpPBHiQffQREJUNcK1zy2VO97CQZjL
 S3At0X2kVSJHAl4FNdAHZRgu0QJsH7j21Hyt1X0yCothjmqGIJfVwSHMeJfPJRnpw2llmuytLd6
 enR3jqAa5A0vOQ2XPdGdJ4A4=
X-Google-Smtp-Source: AGHT+IFN2pqk8ejQbfoRSTG+yahE5WGO13sjEFuibdnT1MdF0LGYtgsOYS2eVTnaMU9rfBMeAu4dgw==
X-Received: by 2002:a05:6402:50cc:b0:602:1b8b:2925 with SMTP id
 4fb4d7f45d1cf-614f1dfab00mr1986895a12.29.1753458330238; 
 Fri, 25 Jul 2025 08:45:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500ad286esm7112a12.35.2025.07.25.08.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC7DA5F8ED;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 10/14] configure: expose PYTHON to
 test/tcg/config-host.mak
Date: Fri, 25 Jul 2025 16:45:13 +0100
Message-ID: <20250725154517.3523095-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

This will be useful for making $shell calls to something more flexible
than the shell builtins.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 95f67c1a827..825057ebf15 100755
--- a/configure
+++ b/configure
@@ -1800,6 +1800,7 @@ echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
 fi
+echo "PYTHON=$python" >> tests/tcg/$config_host_mak
 
 tcg_tests_targets=
 for target in $target_list; do
-- 
2.47.2



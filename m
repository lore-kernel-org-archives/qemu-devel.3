Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BA5C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt2CL-0002Ko-LL; Fri, 14 Mar 2025 06:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tt2CH-0002KB-BL
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:23:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tt2CB-0004X1-LU
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:23:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc148so1255961f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741947791; x=1742552591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DMcvt7EpRcI2s9UrvwL2kMVfzGjB4NRcTQ9ZyhSq6JU=;
 b=is5dh1YEIY6DKm2WAwECcSVVTHfKWDcHxnoiuW5xCuJeS/MtuU7IUHpqouY52dL9li
 ++smWJuGLuzFw8NoWXlxhqA2sBDHgCCyAa+7Lw0WtIRMhtKxUW/9/T3tvA5BVEn/zk9a
 2IM4nJr340mDcahpxhkz2xgR6Vro1bfT8DTlccqW73AcsDtk34Y2jaiGL+hh8egUC65e
 3wEuqX9kJRJMSrH8vLAnmPWl2IdJq3g4y2opQ+Ge1lZqu1dYI9qgXsHIsKI9XBvs+tWj
 pXFi3RgyADckOYB/YlOMzPvKmvsb8I9vHg8LxkUYVwdc0ueDJ7kTi4h4kS6MEYffkLUC
 qETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741947791; x=1742552591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DMcvt7EpRcI2s9UrvwL2kMVfzGjB4NRcTQ9ZyhSq6JU=;
 b=IuWCPJZt3PGsA1SHQPvWpkZvkOz/N1beqDPyhSzAnmIlZ00JAZn5fTkJ7MLICUy9yq
 U6CZWZ//HmHIy8JStkUIxtUIGTfB0SAEhvWV/HH7W9GNkLa94wPQPNUkDb8BGb5v/sA1
 jcbYUfOo4YA1NGx/LkWCaA4+icz59lUKA68q50Qo/yJDWi5+9IKS6heVCLrVKXBdRhJv
 XdMKKlI3agvX9pL73kXqbXZtuydn03ZBYsDSWo4ZYC94MN2dPRsw+rHkuNaIBua2xPDX
 NUuIaUDqHGMeHLlpqqpvhPgMltcHBmhey6RzG09yxRJ4zp2dFq3ox49fh68jxsa2HGMV
 IeBg==
X-Gm-Message-State: AOJu0Yzuk8KkIDpoCS3H94XdWwuUUTgkS9GV3i2r6i0rd3qigS8OnEg0
 ybo36o+p6PCWsbJ6/q/2rZ9b6kWjauN5N7nyyVV4/NICR91yEMZLkkl0n6m0zKA=
X-Gm-Gg: ASbGnctJAZhy9ANQyaUDAc1ZsBcLftBOKm/NHU7VMXde17wcp+zFERb5Ofp8p6eZsD8
 JZabo7rnAmeCuRLzn0jeC4U4bRtrDfifWyDS8Sq/Q8SS+ktzLPUM7YxuF0a0yzX/8Jq37v0Vjnt
 P3QBWgKQSbl3BtLKMLQd1SHoAdgNg7AkIC1Gd4usy9MGh+M8xeeuvmBX5UGmKqsIwnWMaPosjPQ
 4sozJoOVWLvUlEJuJDCMWzXmfJQO5jbnm6v4t5VwCVn0aJ80sRf95X/rsgBTaTI/eVWT/C6Ayuj
 Vgq7mL5ZWdSiNC7jfThWAjMndyaKkIaO3RFXy1V145768sg=
X-Google-Smtp-Source: AGHT+IHvHlRiYQ2URlSHHpc53wDFax7PtcMuCgjUV7RcGyUtc49vgdN/B3LX5rPHHfbu9uNH5PpI3Q==
X-Received: by 2002:a5d:64a4:0:b0:391:4999:776c with SMTP id
 ffacd0b85a97d-3971ee444d6mr2864526f8f.40.1741947791176; 
 Fri, 14 Mar 2025 03:23:11 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a12sm5072038f8f.75.2025.03.14.03.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 03:23:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF0DC5F92C;
 Fri, 14 Mar 2025 10:23:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] meson.build: don't bother with split-debug for windows
Date: Fri, 14 Mar 2025 10:23:07 +0000
Message-Id: <20250314102307.2806696-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

It was reported this breaks the final artefacts on windows when run
under Wine.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index c2c71b6f8a..9b1af6d030 100644
--- a/meson.build
+++ b/meson.build
@@ -601,8 +601,10 @@ if get_option('tsan')
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
-if get_option('debug') and get_option('split_debug')
-  qemu_cflags += '-gsplit-dwarf'
+if host_os != 'windows'
+  if get_option('debug') and get_option('split_debug')
+    qemu_cflags += '-gsplit-dwarf'
+  endif
 endif
 
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
-- 
2.39.5



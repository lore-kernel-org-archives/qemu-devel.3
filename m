Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E374C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvT-0002Xi-C5; Sun, 04 May 2025 01:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvE-0002Jm-6g
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvC-0004Ru-HC
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso3518659b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336589; x=1746941389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=k/vJMNTSZIJAK/pcqPEPZwqqOtQgsqmarq/73SY6YmOx2M7w6eDajBnJJN7VvDn1no
 XDONImwCqIPgLyX5YNnYar1XDUxwnxYh2jSmgwo+MyA1MTx1uzKYViFcvV2kyaWfh/wi
 g/Rrt4aexFC2kgsbRdLC0leuLHoE7PQD4dB2Uv3WjXaQNdpsdS3C/B6KLUOgOAobLaJy
 bxyJoIBupQk/RMNFP8mNRbk4sE9RQ+Peud2OG+/cdOaXSg2gf3XEQiHJbSSTZAK0mHvp
 vzXD2JykbhgUylfEHc4CB0fTGkTodK4P3pQFPqujDK+51zEa01K/8uIV7WFV3vzCPK33
 1PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336589; x=1746941389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=d6mWg/4yGqE+PpnRWsObBXVM0+0AMLr8kaxRJNk361Ekpeno8e3CTBcP2pdTDC6B9j
 g+v1E/hAkSb6Htv31Q4mh5ao1mbwuVwLs7qCvcJhqj8V7mLj+J0L2ve0xTb6sYYoUMIs
 ndUIClDC+xdF9Fx37D78YMJVum3K01gLzmcYR7R09OgUI9cNeZ2sLXgWCbDLUKHrQqQ8
 v04ofriv1Q+vRK2ykCJjqbPV/m0oBmPGu8K/iQbb4AXRG7xUa+aMSr/UhbAtnygQzw6z
 OEp01QshtiE6TYI26vQs6jI1NmfjeYbimGdwot5crW5wxleWsF04wh3IubemGfy3yFM5
 HgSA==
X-Gm-Message-State: AOJu0Yyq23DQF0I7kQbDTm7iKb1vNq9BvNRDDVmFTxnU2pMvJfs2cnYF
 tRmvgHzi7CiseMcbvdnS02uWnKdOR/JAe8h5r5//46+8hiCz8vfEy5Oc2rGeu9yXp/+8hwmjeCT
 o3ro=
X-Gm-Gg: ASbGncvE+7Q6Tl9Y4jUK3MRsqRYfeaf08JsMiM1hJZv39NPmtjGHmY/GEuzaTHdPxxq
 /4XCBZuU0J0cuKDYg5JPMF1o5WmJCoiI35VlzET7T0EtLo5mzEoDi6m/7ohmTifYGZDwW759spb
 ed0U9f/BmmnvSCoMznThSukiy8F9rPeWJaEQllGQwrmW3rVaA/FeSyrYcZhGlXWdZ6C1Y6fFO/s
 iYvrNkvJ0Vz3i+AINXKN2jzRsrFxrWPWLFfe/ugTuj7lrQbaVdiszqRfTxNs+zr+M/qrlvXIF5A
 AbZBvb2MMsqihjk4keundYBQXxJEMxdQwLJ+cNES
X-Google-Smtp-Source: AGHT+IECb2kqsXYdYx3HexFcHoSRwPANHXQWSjcMKm+7Iwt/AOnqMohaPWxRynpWHSWLdEAcrQgA/A==
X-Received: by 2002:a05:6300:668b:b0:1f3:41d5:6608 with SMTP id
 adf61e73a8af0-20cdfee99ebmr10830982637.26.1746336589134; 
 Sat, 03 May 2025 22:29:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 33/40] target/arm/ptw: compile file once (system)
Date: Sat,  3 May 2025 22:29:07 -0700
Message-ID: <20250504052914.3525365-34-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0327b6f5b..151184da71c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -17,7 +17,6 @@ arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
-  'ptw.c',
 ))
 
 arm_user_ss = ss.source_set()
@@ -40,6 +39,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'ptw.c',
   'vfp_fpscr.c',
 ))
 
-- 
2.47.2



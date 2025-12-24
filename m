Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181FEE776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYROv-0004vs-GH; Wed, 24 Dec 2025 11:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROl-0004tD-Rf
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:39 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYROk-0007v9-6q
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:07:39 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso133995f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592456; x=1767197256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc2VW6af/n6csojn1ZvbCAv3R8hfVcamqrxSvhqJ3PQ=;
 b=ooW7BrBLXWx1R4gIY8MgV9C2jxKGiXhbOZOeRGGAaROzkHN+1EKJPJv86t18OXQNk3
 HV5qjtA8TUHHIwEqeapfW6ekKnnNnfGQ8sYoXY2Sf6z5/I9Jf/zJS4qz/ew476B4iugv
 pd14zPIa5tjn82SyKU3LJKmm2DOcYS44hkbncztkBA6ZeAmeiCXjc6t0ZeGvwyNvMKtp
 IMNz3aypy/LPhQGH1kaFgSB5Mpq2+jLjRTE3Z0cha3gBFYOd8pIgBm44jpYdmZ7r6ru4
 g3FnHTVrgKJxD2itcaue80uzfEKCC0hMwrXsmQxmNoq+LiZ8tJn+TDtf/gXpwTQyTCTS
 oJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592456; x=1767197256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rc2VW6af/n6csojn1ZvbCAv3R8hfVcamqrxSvhqJ3PQ=;
 b=mExZCB8LmLjh8usJSUVHT1KLARD+ge9Z3C2Ng5drbGdvTIKPptt9/S1Zh2xj0PmdML
 MvgMZDsd8/000V3zRjVixrc/+sFP9z5GPIYC68ApPT///zwHd/QGQ2hGFRG5mtW5KSjK
 Ocd+0oiXtKnZzcB0l5E5fhR6hH2tOxAtIZzDEdZj3AyGZJZxJp+jRVneJcSlT6v256fR
 H5rFb41UREj4yBWToeqDiqi8Qdb7Fx16ZFAtaJ5e/q5M1ELiehl8QoidSGrCtqnB+0jh
 B4Rii7S6E4ggcZDRPepJ3PXHP3h0ott3DX5DsSO7WRN+O73+DrAa9VZmyKSmKsbgGFCr
 hq7A==
X-Gm-Message-State: AOJu0Yy/1N56xytBg6mPxW245al98J0Vl0gWD1h6BltmgSE6mg4F0WNT
 ST21ZfBSrOomsuvn8qPMVIuXvM1zY3hLvFeeCJLmNj6poHHWRxShhJDzi1EbqPr3X6v21L2RZeJ
 9A9zDpms=
X-Gm-Gg: AY/fxX66CfQ01YFE8/CoFHVaIKRDkQM7I2+Ea1GpK9PxJ5sWcAELjrLML2Apv5McBzO
 yv8VhpwQW6BeXfmAc3l6Bp5JlPndTJmXUoKqOfAmuYSvpDlOQOmJfDoCBKwSPJECfC/S8NeaN3N
 quIF63dipnLCaPo7qq1XTMaCXDWuB6+s6mof7NMB4Vf6rQtwuAop+gY8ivQd8z/95cEtYXLlmQ0
 dHL/9UKOADyI1rYYMtY2jdIg3B/jlK0G95gknXbdt5J+2gl/AN108dqcbH03aMN22P4yH39hvqj
 wAwp8PRLLJecX/+56/CONX7YwgH0cTiHnZSJ7wcUVWhIShK9QZRK8vgp5MmTa9c3RKewpsIBQeb
 +LnSzntt4Wyyba8r6rDV8D8LNGcpUzckyhxVAMitKsIgwsTPgbTAgTT8aMtjle0RVTKs6etVPgO
 NEbBLe/4fNuoR31CO2LVY9xDLJnkg3KPOwObzBhdDcjIjLyk0ytQB2v10=
X-Google-Smtp-Source: AGHT+IGLRXQfLw1+XDSWsnXQlLqirup5dQhCU2nKSZYkFA3u32XqY8YCTruMXlqIosSuVHztJTZ5zg==
X-Received: by 2002:a05:6000:2305:b0:430:f8b3:e834 with SMTP id
 ffacd0b85a97d-4324e4c155dmr22478818f8f.11.1766592455752; 
 Wed, 24 Dec 2025 08:07:35 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325d10cc48sm25252160f8f.16.2025.12.24.08.07.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:07:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/3] configs/targets: Forbid Hexagon to use legacy native
 endianness API
Date: Wed, 24 Dec 2025 17:07:08 +0100
Message-ID: <20251224160708.89085-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160708.89085-1-philmd@linaro.org>
References: <20251224160708.89085-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The qemu-hexagon binary is buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

  - beb38fda0f0 target/hexagon: Replace MO_TE -> MO_LE
  - fdcb7483ae0 target/hexagon: Explode MO_TExx -> MO_TE | MO_xx

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/hexagon-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index aec1a04d1b4..6763e2111d5 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0



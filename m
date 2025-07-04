Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA68C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGI-0007bP-Jp; Fri, 04 Jul 2025 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFO-0004Ib-Hk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFM-0006vq-LJ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so12233335e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646403; x=1752251203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ipzxBi/iecKjvrSJsxvJBuDTmnzcxt/BXh5rL4Zb7jI=;
 b=flNLjrLBD2kjmzSsJp7QFavmUEQOqqGMOdxMyll9V4mEWJv0DZyzIvpGbVhNo0zrfr
 7fz+MTLkRg81onpP5GEgM7kKLr/UnKGyaUa0JyfsouyifuI5E+dzewIVy6eUedZneklU
 UQD3ollP7PeIHDtm7qethA+fqbdQF5iC5Vponf2znluk0U8GREoQhYIZBibGuvFiCPne
 T3iCaFab+cR15UVC+46MO/Am6d1Ig1puHmtX9/XccfXCm4LNtos6e8j+E9gzL7x+EEX2
 9OXjTgy5bBgC2WF6Elzo4+lNe1D/ffpuPddIEZdXHP4/4QId+odHaFGcBt/w7h8X7myW
 3jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646403; x=1752251203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipzxBi/iecKjvrSJsxvJBuDTmnzcxt/BXh5rL4Zb7jI=;
 b=N0w2070tr7Ew91X0S/IF0RL91ziFdJoJJKSJO///lLSNGMsevgDNYYJk/eI5Tkx7bJ
 DglQYuQaXdR9lwQ+BiaKb9WQBhkq/qAUHlrahKE8YjAnTpRIlN6HY575X+dt6J7LiKOx
 0wl/AaV4JeSomRYQLpasBDxKcW7aXPahkhCkUz07b2AQWtxx1vZ50UghTsgwsfbSGVam
 +z5nWWJ3hoBH+hWeS+UfYb5+IhA+7L9qtwOfIC+QeAXNFKDRPjo0grCUPX2eeuC7zFgR
 SQV2GKZWomKcdhKWRcWonOApOVEUuUTR9henxyko9rPp+5QEJ3XVA8WZusCTnCFxt4j+
 2Nog==
X-Gm-Message-State: AOJu0Ywbrmkb0/4GnHsvmMlKnKBKq7vRQoHR9UnYZvu2NPFy1HmZAzUV
 dIzaR+55tZ7OAZO0HX/9CxU/nPJ88v3U05YO+8Z1T6hzD0DV3v2RMOJOKvrqTciEIAVlOJk6sOY
 7ABCb
X-Gm-Gg: ASbGncvOGhHsID0uGK9py08f3RWR/ZJTFyPzbeJE7mQsdmZdMzTpoTzXbh6F4ka3Y9r
 fqXL+HvobHsPVx4ZCdNGHS+WLZAxPjEA7Sx1Kqa+cZJACG0U3GMrWosEnEK3dcHcrIVxRYdf8dA
 sQVQVuxLKZzMDKjq+xjT110ylHxKNI6vGa60BPc04LmAvunAVuAd1/hHrjv69DbVjU4JTtF7NA3
 N98iNV4OAIpb12Q00vvWOyBMit7UhRr61oFqAvbldT0GKt+vAaJBfx3Fj/lkfhVLk8qMDiUHbHt
 FK1Cp7NTB/iYIqYMXYHPUbgrp5VkKwQfuEaHqSN8TciFyp6vMMGcloA9QYDJOaWVQLNNPwjnt0u
 zDYw=
X-Google-Smtp-Source: AGHT+IHVasOj5vyHJlFTA0SskxzvKJ3d1q4s5qFi+MXFd9LYmxypRJWwWLNtVjfu5Hc3aFXkBX660Q==
X-Received: by 2002:a05:6000:41f7:b0:3a3:652d:1640 with SMTP id
 ffacd0b85a97d-3b49700c684mr2539959f8f.2.1751646403071; 
 Fri, 04 Jul 2025 09:26:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 106/119] target/arm: Split the ST_zpri and ST_zprr patterns
Date: Fri,  4 Jul 2025 17:24:46 +0100
Message-ID: <20250704162501.249138-107-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The msz > esz encodings are reserved, and some of
them are about to be reused.  Split these patterns
so that the new insns do not overlap.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-95-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index bf3d4f4853e..70207718984 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -252,7 +252,7 @@
 
 # Stores; user must fill in ESZ, MSZ, NREG as needed.
 @rprr_store         ....... ..    ..     rm:5 ... pg:3 rn:5 rd:5    &rprr_store
-@rpri_store_msz     ....... msz:2 .. . imm:s4 ... pg:3 rn:5 rd:5    &rpri_store
+@rpri_store         ....... ..    .. . imm:s4 ... pg:3 rn:5 rd:5    &rpri_store
 @rprr_store_esz_n0  ....... ..    esz:2  rm:5 ... pg:3 rn:5 rd:5 \
                     &rprr_store nreg=0
 @rprr_scatter_store ....... msz:2 ..     rm:5 ... pg:3 rn:5 rd:5 \
@@ -1334,8 +1334,16 @@ STR_zri         1110010 11 0.     ..... 010 ... ..... .....     @rd_rn_i9
 
 # SVE contiguous store (scalar plus immediate)
 # ST1B, ST1H, ST1W, ST1D; require msz <= esz
-ST_zpri         1110010 .. esz:2  0.... 111 ... ..... ..... \
-                @rpri_store_msz nreg=0
+ST_zpri         1110010 00 esz:2  0.... 111 ... ..... ..... \
+                @rpri_store msz=0 nreg=0
+ST_zpri         1110010 01 esz:2  0.... 111 ... ..... ..... \
+                @rpri_store msz=1 nreg=0
+ST_zpri         1110010 10 10     0.... 111 ... ..... ..... \
+                @rpri_store msz=2 esz=2 nreg=0
+ST_zpri         1110010 10 11     0.... 111 ... ..... ..... \
+                @rpri_store msz=2 esz=3 nreg=0
+ST_zpri         1110010 11 11     0.... 111 ... ..... ..... \
+                @rpri_store msz=3 esz=3 nreg=0
 
 # SVE contiguous store (scalar plus scalar)
 # ST1B, ST1H, ST1W, ST1D; require msz <= esz
@@ -1344,20 +1352,22 @@ ST_zprr         1110010 00 ..     ..... 010 ... ..... ..... \
                 @rprr_store_esz_n0 msz=0
 ST_zprr         1110010 01 ..     ..... 010 ... ..... ..... \
                 @rprr_store_esz_n0 msz=1
-ST_zprr         1110010 10 ..     ..... 010 ... ..... ..... \
-                @rprr_store_esz_n0 msz=2
+ST_zprr         1110010 10 10     ..... 010 ... ..... ..... \
+                @rprr_store msz=2 esz=2 nreg=0
+ST_zprr         1110010 10 11     ..... 010 ... ..... ..... \
+                @rprr_store msz=2 esz=3 nreg=0
 ST_zprr         1110010 11 11     ..... 010 ... ..... ..... \
                 @rprr_store msz=3 esz=3 nreg=0
 
 # SVE contiguous non-temporal store (scalar plus immediate)  (nreg == 0)
 # SVE store multiple structures (scalar plus immediate)      (nreg != 0)
 ST_zpri         1110010 .. nreg:2 1.... 111 ... ..... ..... \
-                @rpri_store_msz esz=%size_23
+                @rpri_store msz=%size_23 esz=%size_23
 
 # SVE contiguous non-temporal store (scalar plus scalar)     (nreg == 0)
 # SVE store multiple structures (scalar plus scalar)         (nreg != 0)
-ST_zprr         1110010 msz:2 nreg:2 ..... 011 ... ..... ..... \
-                @rprr_store esz=%size_23
+ST_zprr         1110010 .. nreg:2 ..... 011 ... ..... ..... \
+                @rprr_store msz=%size_23 esz=%size_23
 
 # SVE 32-bit scatter store (scalar plus 32-bit scaled offsets)
 # Require msz > 0 && msz <= esz.
-- 
2.43.0



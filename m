Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9281C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT863-0008BA-P3; Sat, 21 Jun 2025 19:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85d-0005Zu-SN
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85b-0006cH-Mf
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74924255af4so607084b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550258; x=1751155058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1wJZbG/FCIYdwEDCXvLbQQm09R6sO+S+0iOGDF4prs=;
 b=tN4qWVrokLPOLLJkVLKG1Javhgx23eaZX278BHZPPhMvFj5yT2gEXn8C2N7S3X1pO3
 EEkWiqCNulhr8GsSucmO8I+W5ElTZhk10qUGK2rAmYnu0/DIRaG2u++gljvdsOYsMZjA
 F0GjuKJsJysNXYrEoZo9VpvLa2P+A0bgJ0ZtAlfga5JivkVZ1PB1GgdLsLetTVbRO6Zo
 ACNMLaZXTx+WN+VdzZMUkgZgjZGHHjRRt4e3sg4daTrxnMZ3R4wwEjiVl61Bt/4G7lK9
 G5dBVBZ1tr+MXVmMUWOd/I0YliyVC7B9opFsDy/XHJar8qVxXfwthEVIBk+Yt96L2IJL
 kNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550258; x=1751155058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1wJZbG/FCIYdwEDCXvLbQQm09R6sO+S+0iOGDF4prs=;
 b=HI9KnH0TCAQBUzaZNnFzAPSraEZQoLpkJYSrX2vu0G6v4oLpfzeunuC7G9G3Iy/SWc
 wOGAMJIoj0SJ2tI44knfKhE+4mjCzyEGMJFAWc2Mugk2n+hVOC+iVxX2JdCx33eweE71
 Mj3+2c2FA/EFNbP4Zdcc7dhV9ba/NDUibAs1dFzz15Wr8AquTxMDTdf/7NculsVxfShh
 UwRnUb+GvSMTcwpnyMWWIxFWBrSkKRz+F8xb/bUOUk4nIuSodxxTWhAdt4S2nPtxCceh
 8m68wDym1vxN2ic1wUemnjd4sBd7b27h9WulHSXflcAi3lLObD2ZvQ/Ckm+hr9oQ8q3K
 DuDw==
X-Gm-Message-State: AOJu0Yw+J3sRsCtgpuM0IzmdW5Igns601L2SPcL3YTkJDEDEgfdH+/Nx
 EHaIzm/JdQgH1OVcwc6R4EKAyv50+Qo/M2dknkrsreWAxqKO8S9cwCoOgabmBWXMW/gf6raRZsf
 axMSr9zg=
X-Gm-Gg: ASbGncty0WkjV3oSgVeo55FirMwVJwBnoQnWIWZ/Lydh6xYsGqMYTmde5obr10z25hM
 0oQbnu91tLfvqGA+aQ9sno79l695flL9BfpYyRZxDhfJEXpzv46jLvLfx5FB0QuEFO4YBFT1Qko
 Y0r2KCfBG5Ztcu5U4LIMwyiXos1jn8x7nHJUoTClkzilP5GZoOE95KWEwXZtO/r8wXuKMNESbOW
 b5JSIoQ8T7lk3VYr9lb6r7G19Uvomulr5PUDfp6lcVKcz5TpJtFwf2cqp9AZ64FaL2Jkq+vCvYK
 ToWpKYmaPHvZhsfmNkYPCbMrjO6gm1qxUrjJW0XK2bsvuaArslCeO8cx1+NG/yXWzN3dDjGpnoa
 nV9o4Za8zkmM1bu5o1qKp45YDWnkRIX4=
X-Google-Smtp-Source: AGHT+IHzpM748hSJHm6WsXvP3Gd7WnXRSUyN7rZNdQkiBf2i0xrXRWOoRvPfYN9IXn0VWRilaPjvhA==
X-Received: by 2002:a05:6a00:2d8c:b0:748:ed51:1305 with SMTP id
 d2e1a72fcca58-7490d4f4be1mr9086585b3a.5.1750550257845; 
 Sat, 21 Jun 2025 16:57:37 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 092/101] target/arm: Split the ST_zpri and ST_zprr patterns
Date: Sat, 21 Jun 2025 16:50:28 -0700
Message-ID: <20250621235037.74091-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The msz > esz encodings are reserved, and some of
them are about to be reused.  Split these patterns
so that the new insns do not overlap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve.decode | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 42eadb3887..76b7804f91 100644
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



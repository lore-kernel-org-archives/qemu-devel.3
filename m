Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24685C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwsy-00013S-93; Wed, 02 Jul 2025 08:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn0-0008Sm-4u
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:16 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwmo-00038N-SQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:07 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2e95f0b6cb7so2083374fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460120; x=1752064920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnQQwPUcGNU55xKcUQdL40GZ68GnX8A1mo+tbkfibgA=;
 b=crq7ut1UnDu1FdvCLzUKjKvVOP0GjiFkFHgM2OEM9brg0WNTQFr8E6EOaGg9jXkAH5
 l+e8r5J0+BhDpsgPWvMzvgEnXC8UKy6ZSwsPA2O76IP5fDyxntUMlmcv8IJ5a0tYQFq/
 W6/KW1Xyu5d+0uV4WfX3HXj4Z5MQmVucr2R1GteEGAZeVg4da8DvXK2JPs0C3pG+ubTz
 Azib2xzB+iRNJBfB9/gcA8UgvDdq8u2XZJ3ukXSTrBZDAWgjJjDQJE8ZLYt7RA3hwLa4
 +4IJcOTmHEE3sVj1/svq2qTQUl/f7iiIwmiYTItqlIkVCS5vCA5oEhHjIt/9+kokBjKt
 NbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460120; x=1752064920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnQQwPUcGNU55xKcUQdL40GZ68GnX8A1mo+tbkfibgA=;
 b=asVFDfbt+Q8S0Tweu+vwC+P8km/yug/jeb2HhxHYYiBHjCPOffpflATVLcqMNWlOkJ
 Jd4/AtLNUlfNIcC4n4yP6/UJ8A0N3bf+3L0S+2Skp4qPj2SoiS4+zVuTRnSZU3Bh9ucg
 KlISOe15UW4vQWsakgYXJVqmSR6sRHtXfySMifQmvEP7SoeSHp6+7SXYbcM+BXbfljqf
 mJe+pEMwn4NWQ0dIWJqs7rlHuLBp5/0U9xZAc7SX2oR3TxUAahS+wWgvdWGTDDmvGl1T
 VCggvyrw2EevYXaNFLj1ROT80kkM0XgE7fhEQdjaT4Uw1bAnAC8pvqFdw/+5xK6QIg8P
 gVEg==
X-Gm-Message-State: AOJu0YwpvA81SGXkRb+Uxwjr3/FB135MubP1nDgybBsZMWL3wWMoa6DX
 NYrlfkFonrrHABXtTCsBa2OJhgozjWhAl2Ak0ZzcsPJ8rwJk+c4HlEnjqwYSPQawe6a2rFEfLiN
 CU4bFvBQ=
X-Gm-Gg: ASbGncttMieExMJZLu/YWSvdWByl+Zhv6DgUBrq0Y5JH3v7qvtGjEItlER8RkakwycD
 QTGPrShpgoyOSQmED5ITSBVofTeA3bknS0hW6ED67uNQrgsHqZtKlQo5PheLy1V1+4opG9sRLrA
 Szf221L2nOgYogP2dA2/5l/OjWmRbg67FFK1PfpGYgKgvvaPyQZdnC+D1dDq3btqlNkCSrHcgF7
 fDgTszds+AVL0SbfryYLE83w/VZkBTmLKiNcSRDQuWbcQ/4uQJ3LwbOqYMBMn1z9NxNByrP7Mjb
 S0BuKMnb0meLE1cjMI/FEV7pXKlppWig6U7+il3Vi2LrAe1IOmHvz9aMb/9P05eWIdrDxQ==
X-Google-Smtp-Source: AGHT+IGzbaPpS9G0BTBbWy2U0nLZUcvSnKbM55hSmF+Gq/YbrgTHDfIUTQt6WBfHIl76qQGfP10nsw==
X-Received: by 2002:a05:6870:d0c8:b0:2ea:73bc:1304 with SMTP id
 586e51a60fabf-2f5a8cffcd1mr2281248fac.30.1751460120333; 
 Wed, 02 Jul 2025 05:42:00 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:41:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 83/97] target/arm: Split the ST_zpri and ST_zprr patterns
Date: Wed,  2 Jul 2025 06:33:56 -0600
Message-ID: <20250702123410.761208-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

The msz > esz encodings are reserved, and some of
them are about to be reused.  Split these patterns
so that the new insns do not overlap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve.decode | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index bf3d4f4853..7020771898 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6999CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuO-00045r-0d; Fri, 01 May 2026 06:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku5-0003yl-Lm
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIku3-0008Rx-Rw
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so14802785e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630522; x=1778235322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eMf0Nfv81bsOU7sGD8NbZmFV5EZggvO8uux0sh3Ikqk=;
 b=jVwRWowCq5OYpMDnD/P2WQzAJA85nSu6v9wuk6XhDkISa7tcQZbQayR1Befa7XzR8y
 3XsGMdJN4kjQB1pOrjTyeyKPxLKOle0IuwhGJaxo8uGfCRGVqsfn++EvkU9VeYCPBheA
 pc3VVi72d1qDiTHSW8x3bUF8BjofMPk7d1RJgGjAmvcWBdxrs1zFst0C3qPkNVvtORMd
 ZWqRr3FIqYajuraq8YHJ/hZM0b0FGXEnwIxELUsNKcPleEsiOoU/uSyW69eTXF1OyNNA
 3Ck2BFL2ou4EhpVj0cb34cnc7AvZj/i+AR2U7yKaoPQYzyCqrBk4fiMZJ8Nt9wDpBwj9
 6ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630522; x=1778235322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eMf0Nfv81bsOU7sGD8NbZmFV5EZggvO8uux0sh3Ikqk=;
 b=DHgz2KXui//GKjBWYW1mY2850I1Fa1eorPDgq/1a28sNWOgdMjnbHCVS+rZVuSKEMt
 Vhy60a391TpP8QR5NX503RRiEPl/zw92/pmarBfeez0gx0gaiNbAbg/wuLaCPcFqZwdf
 ULzobVyO1Bduy6hRb1bqPK24wS+PWgepvr0x5etOJWfSBneNIovePwd6nrDg1Du+o60X
 6Ry5gLKLy+NPaBDKelIv+hyM2m6bB0ZQ1Wly6a2jg4SoX+qbohxi+w12ccMWLMoWNURu
 ANRUklNaspoFYuY4tNvCq8s/kkXli3T5PGGVpzvZBZxyG//DO09DuTNxvg+q3Jfkyum+
 13IA==
X-Gm-Message-State: AOJu0Yx8wTTLBrG59HmVYaiV8AUh2k2nYFCDc4njZOSOeGcKBd20V9Zj
 qN8yfS+Kmfe5WFgV6K01YqtKoE6jVWQZH0OCwDN6293yoqiC8kAZbaXnVYzH/JVkRJSgYUMKflM
 ata8Z
X-Gm-Gg: AeBDietWXk54JiIkm4cEuIiSxrmTLCtlBPstir0kyAU/Ok257F04jE64Qi0FVCSEf67
 EF7K+7tc5dSM7SvoA9rPGFmwXNtmeSfVR35j+XI2SU8YHG54u6jXLNkPL26QyoR1N7K94CIEEVF
 VnjoFKpTy+8T01DZqIxGKtgVQCfYMkkpnIp88px8+E7bW+3E4ud0/+5AMLjYUYh9F5qPRKvNnZC
 SDkBLsPtZc5pHTlrDGwmtIF0jWhZpdAur55Tz4sWYaIEnHIlt+BIosERblqmLHAxys9xL1AyoOg
 EK2SFfr549bI3v1Ody5qPCxB9287xKqo7LiIhJj0cV9EueekfBngsZ/AI7Jok035H8PtrnqgFwI
 sYVJY8BLMbDhBt0Y9GM20hsgXRFTF+9HSjbk8F0N83rQtKL7fddSjcC6yZLlletXKYcN2+ljPjb
 P0rdCOh3kP1kr6XcYeaDbv6NrP8dzZsgpNS0YyHRk37e+7/iplxstix58t9iinEfeG29Hkw+X1J
 iHpyH3spfi6ArymCRcx3EYccx3g6K2189GlmpAeEbcsiB0FU6P3
X-Received: by 2002:a05:600c:3d97:b0:48a:53ea:1408 with SMTP id
 5b1f17b1804b1-48a83d78a6cmr93951595e9.8.1777630521964; 
 Fri, 01 May 2026 03:15:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/28] docs/devel/decodetree: Fix formatting in "field
 examples" table
Date: Fri,  1 May 2026 11:14:47 +0100
Message-ID: <20260501101505.3485916-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The rST syntax for a table uses ASCII art to draw the cell
boundaries; then inside each cell the text is treated as a body
element, so it is rendered the same way as text at the top level of a
document.

The "field examples" table was assuming a "literal document" format
for its cell bodies; this meant that the single line cells were being
rendered in plain text, not a fixed width font, and the multi line
cells were rendered as definition-lists because of their "second and
subsequent lines are indented" layout.

Fix this by consistently using inline-code markup for the left column
and literal blocks for the right column.  (We want to be consistent
within each column because a literal block renders differently to
inline-code, with a green background.)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/decodetree.rst | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index 98ad33a487..33cd6fe583 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -64,23 +64,33 @@ A field with no ``fields`` and no ``!function`` is in error.
 
 Field examples:
 
-+---------------------------+---------------------------------------------+
-| Input                     | Generated code                              |
-+===========================+=============================================+
-| %disp   0:s16             | sextract(i, 0, 16)                          |
-+---------------------------+---------------------------------------------+
-| %imm9   16:6 10:3         | extract(i, 16, 6) << 3 | extract(i, 10, 3)  |
-+---------------------------+---------------------------------------------+
-| %disp12 0:s1 1:1 2:10     | sextract(i, 0, 1) << 11 |                   |
-|                           |    extract(i, 1, 1) << 10 |                 |
-|                           |    extract(i, 2, 10)                        |
-+---------------------------+---------------------------------------------+
-| %shimm8 5:s8 13:1         | expand_shimm8(sextract(i, 5, 8) << 1 |      |
-|   !function=expand_shimm8 |               extract(i, 13, 1))            |
-+---------------------------+---------------------------------------------+
-| %sz_imm 10:2 sz:3         | expand_sz_imm(extract(i, 10, 2) << 3 |      |
-|   !function=expand_sz_imm |               extract(a->sz, 0, 3))         |
-+---------------------------+---------------------------------------------+
++-----------------------------+----------------------------------------------+
+| Input                       | Generated code                               |
++=============================+==============================================+
+| ``%disp   0:s16``           | ::                                           |
+|                             |                                              |
+|                             |   sextract(i, 0, 16)                         |
++-----------------------------+----------------------------------------------+
+| ``%imm9   16:6 10:3``       | ::                                           |
+|                             |                                              |
+|                             |   extract(i, 16, 6) << 3 | extract(i, 10, 3) |
++-----------------------------+----------------------------------------------+
+| ``%disp12 0:s1 1:1 2:10``   | ::                                           |
+|                             |                                              |
+|                             |   sextract(i, 0, 1) << 11 |                  |
+|                             |       extract(i, 1, 1) << 10 |               |
+|                             |       extract(i, 2, 10)                      |
++-----------------------------+----------------------------------------------+
+| ``%shimm8 5:s8 13:1         | ::                                           |
+| !function=expand_shimm8``   |                                              |
+|                             |   expand_shimm8(sextract(i, 5, 8) << 1 |     |
+|                             |                 extract(i, 13, 1))           |
++-----------------------------+----------------------------------------------+
+| ``%sz_imm 10:2 sz:3         | ::                                           |
+| !function=expand_sz_imm``   |                                              |
+|                             |   expand_sz_imm(extract(i, 10, 2) << 3 |     |
+|                             |                 extract(a->sz, 0, 3))        |
++-----------------------------+----------------------------------------------+
 
 Argument Sets
 =============
-- 
2.43.0



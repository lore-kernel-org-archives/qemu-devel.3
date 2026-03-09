Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359E2F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcV2-0001VL-Ad; Mon, 09 Mar 2026 11:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzcUw-0001Tt-PI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:26:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzcUv-0003O0-4J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:26:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so8255915e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773069979; x=1773674779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0y29DJUnuBxj2iK9KwnvP2N8bp4mkTNvUyojM3qXp5o=;
 b=q476In5+Qwf2Bi2NPOS2OnmmxKpdDNBZZvgrLVMws6wq1l3LDjLWiCIvh4Lsby50Le
 tFzdFMdxXijlya8O5p009UjDvsq/gGOqxQyimD/gbPwoP3jBVCyjowqMe9PQo9B8vkJu
 r21TBPgwdwODDD8v291tC/A3NQl0SU+DAiRD6fn9YyXQ83oXoFOHDZhRkywBAeffSK35
 37XaSY/NlLM0SuqpSvtT1dOi7EwdXNK6IPrGulrU65u9zP+YaEwv/WUh+GOr7+Q16vBM
 IZi/vSE4aF9yucXTWx73Sm+sqrW4JGvBS3rt707fyhgtgMDBLStgGkkiguKitR08M8Sq
 zsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069979; x=1773674779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0y29DJUnuBxj2iK9KwnvP2N8bp4mkTNvUyojM3qXp5o=;
 b=c/FcPWFcjX2Fnrq3s+LlSzQbKyXaP+pVcutMXydTHHucovjxB7JslDSbgAEifTHmBu
 VqGQMv/fHtVppESCz76R220zLk4ZXqzURMkcFdi++NdfRpsqBAblZbq18S9xsSTRfrXB
 nRdNK7ZVo3Ng1tRy0A40GNfqLlmrFYrVWt+7hfXtjl0C+KfH27tObu/bXXWuQYeCIPSb
 zd72cUZxpR9SSIdiCKPWoVbErsa4vIIbxa49uD9yhbJpuf3MfdiRGRcQPU5hl9r9C8+t
 7VKUfxtdDkb4zi0d1QsSmFWLLR+bNlAYWvBhtN3r0offliNLqraPPV0lVZR1JKDAumyb
 ObPg==
X-Gm-Message-State: AOJu0YySndvlSmF1lWbgJVuH+tPrp31lewVxBFL8LX96mGwDluY+mk7q
 nhD6aAzKvw/6HuT5LCWOjnMeZgpU8kAMNly3viTlnHQGabelmurepsuDxeDpQjFgCGqOqVhU9wG
 dGDDF
X-Gm-Gg: ATEYQzwxPLTqw285l8agHStkEu4ZB+MCGMtTMWDmOrN9rZkZZ626QRBw0tX1bFQwyDt
 SWWMAi3JHQGtB4tP1r7aFgx3dSabJEMNuUmWT1wyUm0XYJXtUACOmCumUaHHUX6l+o1SsnaLtpz
 fUYh/IXLcSZX6yNbMqej0E2TJ7gKx6AXojnLRT2Y+jBhQui9TjTJfYEAZrpLtsFsKN7ytL+pTW1
 ymdrTsOp4lByDfIPrJLn7Ukk0DhoHJ1qU1rs6awH55lDLIflMoCTEJNI09wzzW3lYUaLtAdBj6Z
 L+B3xKmd6LqVWRd2V6gqRuP6wzTnqVn7eh9U/HcUUmDLZ6ci6iPH/P4OY2ufOZUCYbFKjsAddcr
 C8o7Fu57tM8wwSsU8m2Yu3H6nWdRHU7Ax0XIMVUWO8oRkm0EqAcRvNwpQYdqT20kIW0I9ZwQauG
 3zG7Bn/tvFVd2Rs3Lfr1ObDL5XyB1m0Nfbmw0XGln7RLdjkKPbWcWQ8W7oO+9tDLMjvnkXvf73O
 J9ghbczhD4OozyVHP7Ed3z2UHJUpIA=
X-Received: by 2002:a05:600c:3b0c:b0:483:ad56:8d16 with SMTP id
 5b1f17b1804b1-48526918944mr202277405e9.6.1773069978922; 
 Mon, 09 Mar 2026 08:26:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48534fa65a6sm94844045e9.2.2026.03.09.08.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:26:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] docs/devel/decodetree: Fix formatting in "field examples"
 table
Date: Mon,  9 Mar 2026 15:26:17 +0000
Message-ID: <20260309152617.1611566-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
You can see the mis-rendered version at
https://www.qemu.org/docs/master/devel/decodetree.html
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



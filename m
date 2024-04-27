Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115EFC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kQt-0002no-Rb; Sat, 27 Apr 2024 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQq-0002mK-Ec
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQo-0005Ml-Uk
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-343d2b20c4bso2206074f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233461; x=1714838261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78a0G46O2KG7qu7wAjz0eYAxj9N3YLXQHp2WJkN84to=;
 b=cs9ihlaOHc46phQJkmyPpdFylFW627BfSNvB+//LJh/y2bwAjkQ4eeN9zbD+SIqCME
 oSHb+n7fFv48feI31x4oVKTaSydZ0+EeF1oqgtyamJBQTs+Pg1r90elRNiCesTQRnFaU
 PCIgLBYkCeQJDmoRy5Ls3FPgqWjTNPvQ6Yc1nT78XYrVzeSd4KXZ/CXdG+qKTJEhg9Jw
 1aRtF0JsKF5asvKccui7foC2VLTyTFqkL/pfaWNruTHtmHSBYlpujmSIdMjmTgAn2eDu
 wLu/nCS5ZibjA2WPaAAYmaf760m7e06nA2P/MEa56NpiYckKOMmpTZCtQP1squanFBWI
 t2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233461; x=1714838261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78a0G46O2KG7qu7wAjz0eYAxj9N3YLXQHp2WJkN84to=;
 b=L8hOWdXFm9ZIpTBDupYzg2tchIDAVmGnU+yJoqvCw9s1DK1pPzn1PNHICnLK0nCdDZ
 2pTF4/jm0ibNtGdJS0F7ANfXAEGln0VfmzbhMM+5IdOocyNYyZB7/HcV4PECeUHKluBm
 ZHQ8gAgvCbe37W9brlMDKwi9eum6WZ5r1lEo4qhKT0VptPntZeLBvgPyAO6hGGlcQZh+
 GdCk2c3YOojO8dYihZm5ZiTXkH4KZaEq4eAz2CkeIQJd+tEurY64Ryy70K2UxhAeIMQL
 yuZh0cMvqyIhe4ADsvD363j4rfM/5huvpr28CoLsWkW3JvZdpGT8f76qZkuLIhTRM1RL
 Wzsg==
X-Gm-Message-State: AOJu0Yz5DPXvlxPLPqHQbC65O/U2FkDtS/HV1928gIOP8dyFwytVLW0v
 OrI1FbVbjotnFzaU7ZZeOTeVQiNrVG2rj04YoSiUdJtS/BYmK7R0ZjYJMZ6W4HHTMvE1l39etKQ
 wI+4=
X-Google-Smtp-Source: AGHT+IEEscNpGUrGMsN88FZ9YV2Vn1hpX2pnPnQ4YPZSEQru1jTUIVsTXrLOXyOxxrkMA3XUZS/9/g==
X-Received: by 2002:adf:e40e:0:b0:34b:3f16:ba9d with SMTP id
 g14-20020adfe40e000000b0034b3f16ba9dmr4108720wrm.23.1714233461184; 
 Sat, 27 Apr 2024 08:57:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 h1-20020a5d5481000000b003437a76565asm25091746wrv.25.2024.04.27.08.57.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/14] exec: Include missing license in 'exec/cpu-common.h'
Date: Sat, 27 Apr 2024 17:57:04 +0200
Message-ID: <20240427155714.53669-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Commit 1ad2134f91 ("Hardware convenience library") extracted
"cpu-common.h" from "cpu-all.h", which uses the LGPL-2.1+ license.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6d5318895a..8812ba744d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -1,8 +1,13 @@
+/*
+ * CPU interfaces that are target independent.
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
 #ifndef CPU_COMMON_H
 #define CPU_COMMON_H
 
-/* CPU interfaces that are target independent.  */
-
 #include "exec/vaddr.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
-- 
2.41.0



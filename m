Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCE0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 23:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhzAI-0000Uq-7X; Fri, 01 Aug 2025 19:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8x-0007WG-Gp
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:31 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8s-0005xc-7K
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-31f325c1bc1so1346773a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754090784; x=1754695584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjQRkF3T2e1TLC4uRUvYI8Of7xM4pUkpWBxjX1/U+Cs=;
 b=yWSM7QOabctrvyX59t5uENmnS8rF3qGvxGTCH3VjnobHpRo4Jmx1MZuLK89wy5ZO/Q
 osHuQJQvXP88O+03OMhqkGi9jC7o8FzskxCNuL57jw1bam4rYRbQbdgr1DssUsgSnlQo
 QUVVUCrzRLD4v+0GTi4+lwnsyQhMPY1apSKZNye4+Up98PmbF0NiPzttC+NjX7Gr1shh
 9/kWhv4v7vX/4OdjVjtaQ/GV/lCHTfl/JeZ2Or5C9PjRGLlt8AxOm6mqHThaB5P2GcW4
 8TF3Wdc4vncdGDN6LfniH1suUdDQCY4NTNl4j/810gKA2cUsVjCYERSKci09bnKZ6uy8
 HgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754090784; x=1754695584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjQRkF3T2e1TLC4uRUvYI8Of7xM4pUkpWBxjX1/U+Cs=;
 b=AFfJPprhAjMM5udXp7dr+TUG53+WCs1wNR1FB6OQO4UGeKaFPQ8HYtSWMUffGmFmdw
 W721UYPqKINyH5Jo8fTlW8fq3DdQEQkoGGque0nl8JCxYn8HxTDyvTUoqYOsnM7toEEo
 NNYqEfP0GuuDIuFVX/YOoJqfG9+d32w9E17tsjc8X1aZzg7J7O0Q3U1qDif1bKMU5QHN
 6nDAOC+8kQ+a3hjV6FX663RoioKxrXIeMY9GH5/B7LvbMiqOQmoTfHZuYdgMDB2twihs
 RG64VpLiAKVRys3jcgAtjajA2ZYM6QFB/GhkMMEKtcql7Bp8XRD38zhbsz5YswrqFndr
 mjFQ==
X-Gm-Message-State: AOJu0YyedAUoMGakTJn24Q3RxtzmUlZF7CAsmWCMqn2OUtPPjgrqUprV
 az6/D47nTpOvfkUtR6NawVTtn7xI/jDrDgxGu8GlVdlxvD627MMv4zwowHk5hHXql6WgjG8BAj3
 mXz+DdA0=
X-Gm-Gg: ASbGncv1hRtLnBOMMTj8ZxJFWDbZ3AogPRWrmRAlxPfhwKmFow6fMJ/MVLmijQgSpC0
 pIH9U86BWmhVmo9R8Q84VWu8tSH15Z5WvoxqrHd7GBPmLDgoGgnIb6pRBXqnY5h1QrbTR3zZAN4
 NmnV89Eriy4pyt2LQcdCXXpGUyh5MvD9DU8RwOL6jnpEDzxb1diTzk2UqA22ldiR1n/dwPB02aj
 5OVEnWN3z6Ct3P08prarTCE3fZdq7240BdARfimfnEMd67zQ7BzCeTlqYV1wY6DCN8bPoYZFxKw
 A04ExPr1AApO8SUUDFIRPtrPEzshzUm0B3JwXZ+tmn/RgU45YasRx7qQ5xNLPVd5Z66wEyhXJ9R
 UHtqfydjGgc1huTNmrPkg6g==
X-Google-Smtp-Source: AGHT+IGB0AcTzr6B4F26dGXej77A/yeTKgm5nnIegOXWvsK2bVPvbV/VC1rPwyiZ3A8RMZd45FLWiQ==
X-Received: by 2002:a17:90b:4b83:b0:31e:4492:af48 with SMTP id
 98e67ed59e1d1-321162d3205mr1860771a91.28.1754090784640; 
 Fri, 01 Aug 2025 16:26:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6d3asm5628217a91.23.2025.08.01.16.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 16:26:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/11] semihosting/arm-compat-semi: replace target_long
 with int64_t
Date: Fri,  1 Aug 2025 16:26:07 -0700
Message-ID: <20250801232609.2744557-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 23319552a31..550c8f3589a 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -501,10 +501,13 @@ void do_common_semihosting(CPUState *cs)
         break;
 
     case TARGET_SYS_ISERROR:
+    {
         GET_ARG(0);
-        common_semi_set_ret(cs, (target_long)arg0 < 0);
+        bool ret = is_64bit_semihosting(env) ?
+                   (int64_t)arg0 < 0 : (int32_t)arg0 < 0;
+        common_semi_set_ret(cs, ret);
         break;
-
+    }
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
         semihost_sys_isatty(cs, common_semi_istty_cb, arg0);
-- 
2.47.2



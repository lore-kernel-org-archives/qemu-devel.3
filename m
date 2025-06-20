Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A716C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk7S-0007au-B6; Fri, 20 Jun 2025 18:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaw-0007ws-2G
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfau-0006a1-HB
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso1772729f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440722; x=1751045522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1tMCEumeGtZxPSKXJNNBPHjYlmd0I4GjauIhtNz8Kk=;
 b=r9eiWGYY3diafEQXsI+kRsYPQWrsR/UX6+8IOPg4FiPzGkXuMcscz0Jh0DrKBdqUTq
 kVb32ZcRSrQIRXcoGsuhfRVNxnagOVKw0+DyatQdy/rqZwfrYBw1e4PbsUkGuGQ2OaRm
 pGXefzA64EposGDUPdxZ5xhye0D+yLWipY7nYGS2mvJkIHVS2uYih55HYqBHxgCwb4c0
 sYNMtp+D/yQSlPB29JoqVozIImkmTfCD4Q5YQs6dYAc7fM+5HLLZcYtSkXzT0lE3mItL
 5YmacLXSuwWxllUno3baD9Ul+4IGIw5xahrb2xqHgh2U83AVuKw+Kglhtpa4H/zKb33X
 GDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440722; x=1751045522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1tMCEumeGtZxPSKXJNNBPHjYlmd0I4GjauIhtNz8Kk=;
 b=vP5LsVutDCLj7KcSoC69/SLdn8SEhki+9TqmRqfKZOjPMqd34ypESur/LoFlfpYYit
 QwdD9wLyIeLrax7I5MbpehQOGzidA/8pERNCm0+HXehgdD59YYOJaYqOUTz+lIrnxGYU
 iO628Bm/mwl5BRcm3R9Q01tgCAy35IVehSY5Kv/Wk4NRh5eHM4zU9fFyrGNC6X+/A+9e
 gAM29DRjATXDO/Dn7AMbb5ddCraTHJQNtu8Bk92/J+a7LGNuJCwMPG3sWS9+LsFx+Fvj
 Y4eKSXmV1BpWTbdnlvDg4pmXBI7AgC4RSSey5hPakDcLnCZGFtXvZSOCHRlbakWd1KcK
 h+Ng==
X-Gm-Message-State: AOJu0Ywd1slLlmjy6FnmqZzZEVjqHVgiFtQNH1g2G0kJ3b6QWfhjbWdY
 tSB/hBGLhweOJ7S9p1HlCgmVL+OC8GF3v8lTnzOv5zcqQ9iEjkx1KCTf5CDTxF/eRxlVeHBCDeU
 9HS50rv9phw==
X-Gm-Gg: ASbGncuTHm/sNtjRvrxV4oc+BSdXgvyWv2G2AXvxIKgevcdYh8EGxtT3uzBgLJ2disC
 1AuRKh5d3aojrfkABEpYE1N5Ktj/jtetduPt+7XFCMNR0U19Ro8NvRmHvt3ah+jjkfc+V9HaxRl
 9s2btYxUFZXIeX3SfPBCV/rqaCo5UrjGvc7vG2YAEw9JYJb5bOKuDG0v96ifB5viDRHx7eKxfeX
 q/rfIftOin0IdkN4ptsce6aY277jNW8Op6Tncb1wmTuVruOC6R4aavEmyrZr3S3ee5BpEcVBeAz
 CXM5996JX9f0X6HWO8PUQtKLx6DfSjAAfPPBhFpDYPSC+gblfvp8KQ7mQ5UJv79Vz0nhtmVPmBX
 j4bIUmg/Oy+MwDlqFB9eiN9cmFn5pEEGhmdmptiNywxzKUvVUQwIyhtTC
X-Google-Smtp-Source: AGHT+IGMxPBYDNUrF66USZLIa9VJ36S7Nd2bhjpkTCuP1mLm6stJRzElzGs7eSzHuBM85sgaizM8+A==
X-Received: by 2002:a05:6000:4109:b0:3a4:f892:de7f with SMTP id
 ffacd0b85a97d-3a6d13071e8mr3110701f8f.36.1750440721786; 
 Fri, 20 Jun 2025 10:32:01 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45369eae840sm4414185e9.38.2025.06.20.10.31.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 28/42] accel/split: Empty cpu_thread_is_idle()
Date: Fri, 20 Jun 2025 19:27:36 +0200
Message-ID: <20250620172751.94231-29-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 034b5ebc96c..e1d91ace2fa 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -166,11 +166,6 @@ static void split_kick_vcpu_thread(CPUState *cpu)
     }
 }
 
-static bool split_cpu_thread_is_idle(CPUState *cpu)
-{
-    g_assert_not_reached();
-}
-
 static void split_synchronize_post_reset(CPUState *cpu)
 {
     SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
@@ -291,7 +286,6 @@ static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpu_reset_hold = split_cpu_reset_hold;
     ops->cpu_thread_routine = split_cpu_thread_routine;
     ops->kick_vcpu_thread = split_kick_vcpu_thread;
-    ops->cpu_thread_is_idle = split_cpu_thread_is_idle;
 
     ops->synchronize_post_reset = split_synchronize_post_reset;
     ops->synchronize_post_init = split_synchronize_post_init;
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85521098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYd-000338-NN; Fri, 20 Mar 2026 09:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYY-0002wJ-A2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:26 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYU-00063n-3b
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:23 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-667cc4ec065so3010536a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011980; x=1774616780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ME2yp5h28Rlv+Asr12H5+K2Rp3za2VjxSDO27hHiBk=;
 b=EhJRsYGuuZ+PaVb3hR/kd0PXXxZwPX9hK5o+P1r3yeornk3s0kJ02wWGXXyj7GpdXR
 ReMiuTE6THAYUIRHlAnrn/qY5C6uDijr5WHZA3RoFc0pWwhXDCYsxSieTkrV6j2ZRxl4
 BQMoHtN4Hdjlz+csBPveQKOOMsT7NiqhEsDfHw48z1KMwEkksXmDBH/UU9UOtNCTyhp4
 n8XxeNKDA/2pEbzJeQPEofob/htVcgn81f8Qf3lkhnGm4e69kWhVa3IrkljUYHpn+2uK
 dwj4kSIYxZNxG1OQVVuF9cstkKX00EeyuHMyp1jKnrIkXdPn9dQIFUFIFxz+dXO4Wwo3
 iWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011980; x=1774616780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ME2yp5h28Rlv+Asr12H5+K2Rp3za2VjxSDO27hHiBk=;
 b=iZghCz4cV5tWdhKDq0TLf2TiQKTxLuj3uYamCrKX6qetfq2AWpEpkjRu8wkPmwK4pu
 5N94GB9+QGvKR7u3MOdoeylPm8Fke2ykQCSDKXWxRZPo3nu96PcQ3SSYGG5mXWS5y1IY
 ExbLUwcn65aTBzIfqQuW1Pl0bzq788UaO+9QtZaIRpAJBqn+KY/t40vWLSQMewDm8qGn
 WZSlpxYTOIgzGRM4jQHe5EBbrxRIoFJmWfqs701OZbqXNBmdakf8+u7zxZPwP/xpQkrx
 MQ1fcy969vyvwTbJvk9SAA0pJzhO8mkhO7XzMevtzjqlWUYR07fgoVozFNAmLM0GfhUY
 FYfg==
X-Gm-Message-State: AOJu0YzSw2wSRDcLgJNUhdFAildydxtRG03RCIswn65UyggkmNtmu12W
 PXEALqaAcJQMYL6tjxzicEaAjjHPt0NE4ljhyhkLfzmZGryndOy6iEJTSqttxxRXiq0=
X-Gm-Gg: ATEYQzxI2P14xWpmmZ+xHhzIc1oNU/n+hObJElk49eKmwqB9sniSewxikudML9Vo2Fr
 8ojWzu8A6UtR4kepa+jZvY/0Dwx0OZ3dUMmJvLIx4y6KjP1w4PrXVTr/qwk9VHbfLBV5f3i5dLp
 sUtsxzePO4+4wR4Sfrr/aEPd8MDRPhD6RLpbrjc9/c/F0FNi7SYqh7WNbelfYsBR8jvOiPtcmyB
 wmbwErveR+nLacTzxDyBuZp2pP9i4QjL4Arkf4ok8fMUMgLi2yc3isgM1tdWrGpRYcT6PmcZ3nr
 tgDIOw8QBjp2JXd7AgGR8FXfE6/rcaGiAaTAlvxLf8gGFCI5GQZqzIdIaW7G/xQQGQsTU0B37cj
 DqbNuc9MTB5IBIbWv4D2U60fiP+pzuG+bWSRzhfCXJ4EyVo/3uuqAR5uyWCSl5ipWHfOuzd9dfu
 t3FYlBzkb5ZXBE/tKg6LN23mc=
X-Received: by 2002:a05:6402:3885:b0:658:3972:3a3d with SMTP id
 4fb4d7f45d1cf-668c9620d66mr2267525a12.15.1774011980391; 
 Fri, 20 Mar 2026 06:06:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668d2a4d72bsm1363982a12.30.2026.03.20.06.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2130E5FADA;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 28/35] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Fri, 20 Mar 2026 13:05:59 +0000
Message-ID: <20260320130607.2071996-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

This mirrors the logic for DISAS_WFE in 32 bit world.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 073454b9195..d79c8ab431b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
             gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
-- 
2.47.3



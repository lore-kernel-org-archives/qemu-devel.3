Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3791CC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1X-0005s7-JV; Sun, 04 May 2025 21:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0z-000441-38
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0t-0002ds-9j
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:02 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so3407120b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409978; x=1747014778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUmj3qtC0Uxjt25GgPIz4kBx9RjJCUcgOSDgbgc2pqU=;
 b=LKTarpBEapQPkzc2xdgulb3d//08aVWgKVhhlGnSLJpzQXNezHuzc4m8KeGOfFxW4+
 VYIcL4c8k0+Tiy8SmSgQwCPlQWCLIWcM6l59JhxrsJWpkMSkOl3+CZhpU6KIvi8jPf2C
 a/6Cg89LAnj9dofG7UEmNywbgpMnAajut0eTsJznON4Ox5qyRYA3XXp5E9AKfHSZ6rqJ
 F97imceeeP6p9uZwZwtw21kYyMRLHNrm99xkW/Gui6j9nVUREL8uIEWpqSqf6FP+XzAK
 yxMLSvUPybaoGBlNsm5fNoCqMaCsl1r59xsBq7CqSr16/T2z6/5Lm/vUipu27AOlB1hL
 kPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409978; x=1747014778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUmj3qtC0Uxjt25GgPIz4kBx9RjJCUcgOSDgbgc2pqU=;
 b=TwVPYMaFU3yAcjauPwKgU39VfGK1RpE/GeymOmiA1sgT+56V1qfwDbpVECACygO0Jk
 KIeOlRiJDKBekqKosdpKXf9oOwIzvNO/U5JNHKj72NW1NBXgsurfdW3QS0tdd/MnTJl5
 IlUZpvmmtRZfDutAobCnBfPW29XWlYdUHtNuDrm4IfEvwICgMBhe0gKVv2JOCqkIDCcj
 uAz48rIVbWUkGrg4bAGUwwnBpVyokw9bUqleHu61MWYZ+C3w7g3Zur6oClBojDyo81RM
 ySRK1BAuDtojPj9r+U7KhM52DNPdKZtEVmAMA5B3BYe4EpMz7dcGILFZ9WRg9AztM7s1
 JG3w==
X-Gm-Message-State: AOJu0YzNGnGlU7LMBvxqLRX+mqjkvq0n9rBMKqPNGZo9wRUq5VqpBIA5
 qoKeu/qTJgqvJuafIYx+LPdUl8OIunnuzXMO/toRePXTLh0ktIFLdRY5q6lE8r1d7ehunfv24oi
 pVaU=
X-Gm-Gg: ASbGncuI+cu4dUU6GWk1IUG0BcccSqKm9ByWn4N8lc/UJ++PcPF5CxbDRoiq4npNrnd
 3JG3grelQovnMjgZQsKI9FiAHXgED+GOGR/qXylfquGYXsQc1QTb/iB8c4gqOsoJI75Bqj72hdi
 dPEhogdC3Vr4B+atcTer7vum9bS8XIFCmnRTwCZfpeZF3HZB0X6zUsNJmH57ZpXceLSuUVyK8yM
 lbUXtuBdIwAhsbm7gQb6LZqkg17ELxvo+aFAUdvqYz2wHJDrXDjuU4dK9jG8hpNydr/FYqx9M5U
 /yys5cZetGUrhvV6XFZ6MNMKU7gghH9IEBHoCbTj
X-Google-Smtp-Source: AGHT+IF14+GzXOzwvwVQdwpLvUHkW1dbYN6i+zycvVgUNiek3xtVEptqaBbxaSd7q1Ze+Ybp/RH0Gg==
X-Received: by 2002:a05:6a20:6a26:b0:1f5:8c05:e8f8 with SMTP id
 adf61e73a8af0-20e0692b072mr11046667637.25.1746409977987; 
 Sun, 04 May 2025 18:52:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 32/48] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
Date: Sun,  4 May 2025 18:52:07 -0700
Message-ID: <20250505015223.3895275-33-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

This function needs 64 bit compare exchange, so we hide implementation
for hosts not supporting it (some 32 bit target, which don't run 64 bit
guests anyway).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 26c52e6b03e..c144516aaba 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
+#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
-- 
2.47.2



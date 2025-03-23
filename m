Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D24DC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGY-0005qr-Au; Sun, 23 Mar 2025 13:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGV-0005p0-NY
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGU-0002tf-2W
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22398e09e39so70809405ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751456; x=1743356256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuaWE3TjFjqiJm1M4aj1btd/FSbEJW/CWHj5+bscQKY=;
 b=XA7+3wFzxC1EOFvPNPWaoT7fPdib5G9Hz0r3gTTyaPVp75FhFx3PK8l6FaQqywFZjQ
 80FhYeQcpxjP+QGCaJ3FPOkLJjlZ4FAq+0jS0Wn0JWZQUmAVAMLOWWdyhXrqy0y6767C
 3OnPbl7xaARpw1lkxOgiAJ3awIJxrUoaJWV/Z2221xYJfXJViu6KSQYFR8M8FznAYb4x
 PxnvJFV1Cp1JLTsva+pAgPgp0K3lpc8fv0gq88C9yxlHaKpEF7ptte7it7IRwlcJKfCO
 KgviSL5ewJjNpC9FG1bylF8ik7YtNO9pgXTjVQa50Go5K13zx8GCow5Sm2LgX99p1ezX
 iZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751456; x=1743356256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuaWE3TjFjqiJm1M4aj1btd/FSbEJW/CWHj5+bscQKY=;
 b=CtmngcuAdpcK/0KvoBtE/DO0/WEjd5e3M+iqdH5xRQAqPWiQ3EQQRKun71CTN1ANe8
 hB2pD2kUWky8n5qdNnZj/URfIjS/XsLqbbhLHG2o2hr8Lz76bR7hU0vCpm92l0Bwiiod
 qr7Z9I7N4jc3jWXxkx2pcPavbucI1KF0Xrs783wvIpjwEOT3W70C1JqH/eLItYzDaV8e
 TeSL+q27GpGdcAGz8BlDaBzX/QfWECgo4dulzrlNR/BcaWr1l0yRFVctj7KQjY0WcsZl
 uniIZMkL86JxBuiXPTmR0F6IjrY6SuZ26fsMi1ztgIIqX9hqPeKWbs/G0kl7VRDV1YSG
 P1Kw==
X-Gm-Message-State: AOJu0Yw3Wu82VU98gov/ASmnGmYK8Qac9HxMZV5NOe0ZeF+IYxAb3YwE
 kISse1uJ7kiwdTYnVcUtRf+rMdHPsGqzXs6SFaWZdQBkALjXiib2EtZ3S4wjE4y8fcel6XRM7IB
 m
X-Gm-Gg: ASbGncs/BClFXct3yjxPMTkO3OR53W+juDecpBJD/Anqo/d6cTcwAw2rEbvdIe72ogG
 X80POGeO1aTQ+CW4d6hJH+PYIv8y727D0hDb8OpidYS2PwFNiJIjJNi7+C6CV2N7bmzIjTTCA93
 gyZ1xy8zyFT4lNPYc00jf6XkXTu9+pUqWd8Va7vzquFEY1LuMBAEudHbITa6lpoLbNtR9fmWtEI
 iqgnklQEWdg9RwLzy2e+GqBKoS7LWnct7ExH0il5Lu2XsXd9jrbyiKPMgMeJA2Epgq35X3RRMCs
 Rm6LjOCjYLdr3CGdVN4Lf0Swel+H7H3mczHMzcUu74FZ2p/68DHmjGsIPD16ECN8MXqu4km7v58
 b
X-Google-Smtp-Source: AGHT+IEcRuGLq0u72PQX58NJUYaF6jpBPR3IJ3YCsvzaFOx6+X5tZAlByxXis2tsWh8Gba7zgiHZyA==
X-Received: by 2002:a17:902:ecd0:b0:224:1eab:97b5 with SMTP id
 d9443c01a7336-22780c529e9mr144510455ad.1.1742751456529; 
 Sun, 23 Mar 2025 10:37:36 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 07/17] target/avr: Use do_stb in avr_cpu_do_interrupt
Date: Sun, 23 Mar 2025 10:37:19 -0700
Message-ID: <20250323173730.3213964-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 7cfd3d1093..9608e59584 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -88,14 +88,14 @@ void avr_cpu_do_interrupt(CPUState *cs)
     }
 
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
-        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
+        do_stb(env, env->sp--, ret, 0);
+        do_stb(env, env->sp--, ret >> 8, 0);
+        do_stb(env, env->sp--, ret >> 16, 0);
     } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
+        do_stb(env, env->sp--, ret, 0);
+        do_stb(env, env->sp--, ret >> 8, 0);
     } else {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        do_stb(env, env->sp--, ret, 0);
     }
 
     env->pc_w = base + vector * size;
-- 
2.43.0



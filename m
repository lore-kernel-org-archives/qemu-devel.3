Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A24CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE70W-00033t-4W; Wed, 29 Oct 2025 10:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE70E-00031R-1E
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:24 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE702-0007Wk-Fy
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:14 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-378d710caedso79876021fa.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761747482; x=1762352282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poUkJzrIRnT1qAE62jh+3b2s1+llTl5d/4CRcHNKOhA=;
 b=lw5KxvALJl1Ii3ttu+bfGoim/EXbjFwzGgDJM4svgUvfmmKI622t7SyVZvJK3frv1T
 5vPLy3kjoi4bGiEl5XB1JQltJvgHFj4ojUGwEG4yKXG0yOs5XHDHns+gH9xi6hTV1Uy9
 5WBjQobTIfgK6cI9uOGszBu10Q6LQBls7CltgDndVKoZmkVKsI5BIovhY16FA/snwOLI
 wuVOEB615avHH8vjItuJLKuITLanaekuThNRKAd7jNQSGs7Svk49TaltT88fVVylNjd9
 vTAjDKLbggGO+Mm41jdRyTOP+NVnMI89RjLUKTNomxjkbG2+xXn9+Dw8suqmODv1WEKO
 NHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761747482; x=1762352282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poUkJzrIRnT1qAE62jh+3b2s1+llTl5d/4CRcHNKOhA=;
 b=kNecx5ji4VtsRP5OkQNMbilz9qcKrvTPiPRPN0+dnlmp6Ab7PGdcX+BFKoiacrrHpV
 EV+p14qa2xrFckckcDbSD+0M9XVE7EwQO1WL1QGbecg3GYQ4JIY0Iw8csgUYD+mWjnvn
 qzRN+XiwBQ6frMda0sSxkcz1O60XpBv9lHpJ34/seKP100U81oHL4YBpWPLu9n0yJ67F
 a9Jpwmtt/AjI3dt2nN074Mdv2IUMfaJyHmKewAy9SvuN90XHXKFfe0q+gAwOrQlstvAc
 7LKZDX+eJkfo7HNqk1rKhbks/sxZjycPocZl3YGrJRTzNjRcJbSkFyQqiRjGG9EGmHzm
 9mgA==
X-Gm-Message-State: AOJu0YxyoK/rfG9DeLBljBb4hetYdM9IlnF+CktqmiRV9fBIBCwQIQYM
 HmW+9zREmOlE+qT2dptT7/CCWcz972T2ZSvmCIhVk/aPcFFuD4KA2tySp8MTyHyMJiI=
X-Gm-Gg: ASbGncu2M4+9wBYV8um2sO/NmJmZwuwpoPpF+oeqzkB6t5wmjmcvbKzbNKb6YIxqgPg
 WKM+smUlSXUrCU6J7x3ggvC2JMLssBcC3QbyZhzxYW4JqsubqPk9iwBg4Ipnx5S/EKVT/fgd6d3
 HL3vKnJAPok+2wNygBEmSwca9d/ZEg8v1FFeJ3jl5ZN0h+UDFbc/jQoLS7xXmbnIpMvd9IeTec5
 q4wUpn4Gox/sYvblj3AARl6XX6T9B+YumO7GyjjsQ8lYKwXIcBCZr1tF4GV5/wn4cwCA9HePx5r
 zjd+109NMEIx8tJBjSwE6igAaNRy2/lC6Q+qqstrE8EaoRCfD7M7bQkUCxTPIr0XdD+YJLw8FpC
 yarg77h3sqEBrriXF0bcF7mfojyDqdS3LDXAR1Hgb/fYQ1nBOSSZKaI/YR4xfbBH9oXKWJF4eco
 SIy5HOhNmRq/RCdmQh3dpFjT4gm001c/Tmd2jYupIAJlfP01w=
X-Google-Smtp-Source: AGHT+IGjQuKOriJDB2PpQsVZyQTy6Jb8FsvFirJckFgjTp07BXMdiOPC0Pj/93QkIynxp7iPfPN1Ng==
X-Received: by 2002:a2e:bcc7:0:b0:37a:57c:adde with SMTP id
 38308e7fff4ca-37a057caf49mr9578741fa.48.1761747481377; 
 Wed, 29 Oct 2025 07:18:01 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-378ee0e5239sm35112611fa.53.2025.10.29.07.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:18:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PULL v1 3/3] target/microblaze: Handle signed division overflows
Date: Wed, 29 Oct 2025 15:17:49 +0100
Message-ID: <20251029141749.1274729-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
References: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Handle signed division overflows as specified in UG984:
https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  1 +
 target/microblaze/op_helper.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 14b107876a..d26b933b6d 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -87,6 +87,7 @@ typedef struct CPUArchState CPUMBState;
 #define          ESR_ESS_FSL_OFFSET     5
 
 #define          ESR_ESS_MASK  (0x7f << 5)
+#define          ESR_ESS_DEC_OF  (1 << 11) /* DEC: 0=DBZ, 1=OF */
 
 #define          ESR_EC_FSL             0
 #define          ESR_EC_UNALIGNED_DATA  1
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index d3f688e375..31da2c7c3a 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -89,6 +89,21 @@ uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
         raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
+
+    /*
+     * Check for division overflows.
+     *
+     * Spec: https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv
+     * UG984, Chapter 5 MicroBlaze Instruction Set Architecture, idiv.
+     *
+     * If the U bit is clear, the value of rA is -1, and the value of rB is
+     * -2147483648 (divide overflow), the DZO bit in MSR will be set and
+     * the value in rD will be -2147483648, unless an exception is generated.
+     */
+    if ((int32_t)ra == -1 && (int32_t)rb == INT32_MIN) {
+        raise_divzero(env, ESR_EC_DIVZERO | ESR_ESS_DEC_OF, GETPC());
+        return INT32_MIN;
+    }
     return (int32_t)rb / (int32_t)ra;
 }
 
-- 
2.43.0



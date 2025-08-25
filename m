Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7CCCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVGL-0006iY-Lh; Mon, 25 Aug 2025 07:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVGH-0006hN-Kq
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:17 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVG9-0004Xm-Rj
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:17 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55f42e4c3ebso990622e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756120867; x=1756725667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmWY9YsMzEhbNO3wWmV7lV/F1oyaASTYkCCh8CxGcro=;
 b=RjibE4NbREgiNmsgMBOPB04F5544JiGBktvzMs7ywvGqpAxjHZsoIoaqfnqiB9Bwa/
 2P4B7BUsrjvO7Xtx9Xt8PZdLxpgwif+NmCC1DwGIEhvfsIC0a/tU6i/zZsbpqibz2cnB
 wfirVyUcv84UMgmcCluF8GYZtDz/W+o7/HB6xT05Th95vFXySC/iqn6lk9J9KRp6zahN
 9MXr6cMgvHd7qQskfIzAi76MgIwZ1hd0CaVobG1jrJ+CXsW8QBBEyBldVgipg2gFnlDT
 U13Ut2ILIvqOSP5CutZd+WoYAx3VnRbvSHChiEW6L50sPqH6MQWGcq56QfcUuV8rjuTO
 yMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756120867; x=1756725667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmWY9YsMzEhbNO3wWmV7lV/F1oyaASTYkCCh8CxGcro=;
 b=C/kCEx2Z+g26dIukATUe+0+5ntxsbF2WpzdiUkm2VWY8yzkYc/MNB3Eg9iI7A99Vuc
 YZ7R5TZBZ0h2NrjJVW0ox9AOB0cnUpBRqTnZY0XGN3ajR1EqDFmWKkEnsNrT/lPQRTIs
 gBrYDfjhae6KK+Je+YX0C46gCceKhF6nePNcg/mtRYNMu8flRAOhTGtXwfq/mSYd+qiV
 pTyrEcHudoJTNESXYrMLsq12ojiXgWUsq8pjFKcuCU6eCzPgztPoJCdruGsEOkbrLgon
 wVhfog6VvKNO3Fn0+23hWW5i2gOLD1g18q3ViklSuzw2gFdrxN+RlGFv0BdryWtatOno
 20TQ==
X-Gm-Message-State: AOJu0YxFDOP9nbGM1CCyk7qvNoJ+5MZZ+9W2IuKfJUg/tcRk1xJGDvTo
 +FSfbHiIzExqOTOU8l9nY0DEhBqLKHswXR0R8HK/RIvr+Lu1j2HW5LOY7Or0hIzx
X-Gm-Gg: ASbGncuMhXfaKN2Cy8VugVWZjMXY3JyYpNKU/9HAn2vV9AiiPCIX6DafdFAUgJAQtuW
 KQ+fv0ygwBEsH3MQFxPbSiloHVOGuzyXDbgGV/n8W1SOihHbmJ52jm7fkR1U2QOAo6NkxJ2D9ZJ
 g5nWdpJJNST1DpcKlgt53MzTwLKDgUqzQvTzhXkXIfhw2YHG4pVsJW5G0knsuQnJtMZ4tVjW0bk
 0HtM75aIu/ukfes1UVTTeY72BeWL78q2iu4LmouZ7Cm+f8yimBiMMiDYpR4NjoprulP8Osr2uId
 oN1PjIzPE30BZ2APqIVRnTO59b0AWceFHrMtA59McWb0+EozvxA7GpnKYqw/gvL+IugdnVBxtqB
 TRPVGPpNAoYSHNJy5Soy+MAr3YLZPYnGF7WgiwOoGzeqM0ROQgOldQHtHveLLyYd86irq0A==
X-Google-Smtp-Source: AGHT+IEp2ktByj0UF58yQPgwvoBxuyUlXkDSG8uL44TkZuFdjZ6jBD7rsJ1Wikl7vA4DmNFdSNAntQ==
X-Received: by 2002:a05:6512:440e:b0:55f:42ca:cc03 with SMTP id
 2adb3069b0e04-55f42cacd56mr1647781e87.56.1756120866437; 
 Mon, 25 Aug 2025 04:21:06 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35ca8c40sm1583159e87.151.2025.08.25.04.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 04:21:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	philmd@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v2 3/3] target/microblaze: Handle signed division overflows
Date: Mon, 25 Aug 2025 13:20:51 +0200
Message-ID: <20250825112051.4155931-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
References: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index 3ce28b302f..c9bf9361db 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -87,6 +87,7 @@ typedef struct CPUArchState CPUMBState;
 #define          ESR_ESS_FSL_OFFSET     5
 
 #define          ESR_ESS_MASK  (0x7f << 5)
+#define          ESR_ESS_DEC_OF  (1 << 11) /* DEC: 0=DBZ, 1=OF */
 
 #define          ESR_EC_FSL             0
 #define          ESR_EC_UNALIGNED_DATA  1
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index fbc9c8ca4f..c704233c8c 100644
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



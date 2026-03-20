Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E3D1098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYm-00038z-AX; Fri, 20 Mar 2026 09:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYb-00031B-MS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYY-00066A-U6
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-667cc4ec065so3010641a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011985; x=1774616785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIk29T9DhqqlbPhNrWYQVA1tgjm08zB9Z2xOKW4fUVs=;
 b=zZwOG00pawGtJxtpb+yTXpaSJwnwY3MKoSnwzeCcgVgyd4bDo2UJlZUpcZDX1WpxIu
 ZxXcZ9OXxzxCt4SB8TRorkMCVPqnrUV3yq3TFpnTAciot+TPZf2uHNCnGy7NVIwva9i7
 7gz9/jFkcgEUsqcCjhVuEdszDPuuBrnt281mcXlpB+V47xGpQqMjuQDydFMZfpCx/oM2
 oCvzIe7Ocsrxx0rHaYarxZkY0Tpmscunt9qmYvbAyhtuowk3rqULsrBVsb8TG22WeSsL
 XjXSygGcdNFthkobhpoqAwg6AeoiZwrx7OtJGYBiJGS626JQe5rzOBxNITeRK1wR2++N
 fmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011985; x=1774616785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JIk29T9DhqqlbPhNrWYQVA1tgjm08zB9Z2xOKW4fUVs=;
 b=ivjCIO/8DVOglWNSrG2BwQWGhyNG43lwqqCFTJUNEV6JGWwT7oOIzr34BId3uic9uv
 Oa1QJRsFUIDVw1eLzvX4S4dGPcNF9eZYd0pUoXwFGHlB+MjOvkPsn+jpNkjOfbuhm2b5
 8Hl/zKdQr+hDZ+QyJ1hO1AFMA0n9Rnc2Ov0sW2r6Zab4TTU3X/aTk6lyZmhNLf8SJg+6
 LYQuUxEVV0VdqcPjaNb0+t1wkwe1fVIADJheNojES/GRhP2r8iBNTJVdauCx2XSEdico
 zra0hwRS8bDbrjO5tgZAgD218sI3ocVTlQtCdy3eKBq7D2HI1Vu9ni+E12wSJp6w+Qdj
 AdrQ==
X-Gm-Message-State: AOJu0YwVwOZqBSsbCdXffXwqs/LIjFZj/OSkY/F3XwOk+vaXvuS3wnRS
 SQ+YLIK2DRdx4qC1kF2+S5skqAgP7XRy3Hlbbrf5lnNLDOKZN1TB/6L9wRVqOmWXUmc=
X-Gm-Gg: ATEYQzyPX4pvyQNj45dOIR+3mERUOFFU6A5iDy57Ua34XVR5ijJgqRpz3lxVmVH8Jvj
 9P73yp/aTDwWOMe6iSqil3I+P6dDu34uo1JGhekMJib5BFVPQQAjgqOd0W1xX4g3A/ZEsTVuxt9
 l46S2z34L+Q77J6N3TbuvaPX/yv0fE4gRFjZWkrsBSHkayXJD0G6Z4sAH9aQfrkWjCs/fX+JQgQ
 ryf0nLsFdgA92L/v84bG9uNS1Hi8eNBZvwNtz6arsh1BNt3cL2OvR1lrGgELxvDWtAt5S/SmUVu
 d6RdZxMNTfrX1lUqg8Vzz8UTowLidM/JFmLEOtJgwUo6FoIrqAtMY23UF4T7ngiXy2to8oniT5E
 3aheec9/0DRHJZ7GyjsRn6s3QimM+ItjY84xHoHQ2XpBQpd3Micvks2Wo4snSuaLFUUK6djRq9e
 Z+fAzVQDk895GP5sIhMYpMBXI=
X-Received: by 2002:a17:907:cb89:b0:b93:51df:dd23 with SMTP id
 a640c23a62f3a-b982f1ecb62mr218938766b.16.1774011985297; 
 Fri, 20 Mar 2026 06:06:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f42c8fsm152962266b.9.2026.03.20.06.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 573325FAE2;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 30/35] target/arm: implement global monitor events
Date: Fri, 20 Mar 2026 13:06:01 +0000
Message-ID: <20260320130607.2071996-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Moving from Exclusive to Open Access should generate event stream
events. Technically a non-exclusive store to any address range covered
by the global monitor should also trigger such an event but we can
only detect that after the event by seeing if memory doesn't match
cpu_exclusive_val when processing the eventual store exclusive.

The CLREX instruction has the same effect as do other operations
clearing the exclusive state (such as eret).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h         | 1 +
 target/arm/tcg/translate-a64.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2296ac9cfb6..2e59d58f3d0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -690,6 +690,7 @@ void arm_handle_psci_call(ARMCPU *cpu);
 static inline void arm_clear_exclusive(CPUARMState *env)
 {
     env->exclusive_addr = -1;
+    env->event_register.as_bool = true;
 }
 
 /**
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c25ff9351b4..38a51eb3600 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2270,6 +2270,7 @@ static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
+    gen_event_reg();
     return true;
 }
 
@@ -3336,6 +3337,13 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
     TCGv_i64 tmp, clean_addr;
     MemOp memop;
 
+    /*
+     * All StoreExcl operations will transition the global monitor
+     * from Exclusive to Open Access and at that point generate an
+     * Event.
+     */
+    gen_event_reg();
+
     /*
      * FIXME: We are out of spec here.  We have recorded only the address
      * from load_exclusive, not the entire range, and we assume that the
-- 
2.47.3



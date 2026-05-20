Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7113CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYr-00076W-Iw; Wed, 20 May 2026 14:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYl-0006q8-AT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:23 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYi-0000TT-AS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:22 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so5601386a91.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301339; x=1779906139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYsxgOkKZmN/D6H7dyuNYSLIwdX/Ih93Qf3lIcR+ofE=;
 b=fJySRgRJe4kQlc9AYh07WUhA/7JeaWX9cvlEoHMr3sag6pAeWqm+CZu75IdcUDkL1L
 MS2TzrhihdxXDJegjD6LqtsW8oReFjGIFRuKY4XsmWiyYTY5sV9tHyplNgxpy1myojIT
 7SxwITUSkr6WTAxFMTFiSJt3ABu5QCbmbm4sGeDSQTyFiY50iSrja0lLiiHnYC3iALqS
 hLu7qXgkg7PGgmCFMHr+hn85hZ5TrnxJpZQBfTZgAIUFykix/cjrLAJ1oZyzUPRtUDYT
 GTGX9OqfMY5naYxrUzt92bWZ021m1C2sd/uj94d8vOu/sd3+kwRtNAzCvAyRepCNO8Lt
 voeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301339; x=1779906139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HYsxgOkKZmN/D6H7dyuNYSLIwdX/Ih93Qf3lIcR+ofE=;
 b=CPf3wlRDGWhwxRJ0jIz2gat3dDpm6ihBmwEkjyMHiUS1innAk4c97yjrlzWsjyzWyb
 snvDEO6EUUCORcGzI98t4zRkoSEz6i87v3C4kPU8LanPw3Cl8bWQ2dlFHboXxfIlP5iq
 ADTYf+plCMVuzfh9iEuzGrKHb2ReI7IbIjp102nTe/+M0MHYp9iFrvccc9iciDrFjZnS
 yhdFJLAeKGxHZH8/PBb7LA2AylegKrPYfxgqpRNK0riJ3q2zya3hulqV+SNez0ZCcxor
 q29dV6/DyCFQfz6iCbMjGKg0iocAotOCD+U6en74s2RQrWy8q4a/FajtcUeHaT8XCnY8
 z9KA==
X-Gm-Message-State: AOJu0YzDZMOqmwi0/g1+dc/jXQXESsudFma1QkOlHY+/E/RoTBMiL8CQ
 OFQ2Sg9NEfcXySSGJyOKTKlHhFOUsnrrMFh0j1k7D+636Ia42y32gUl5uZYCZPJBQtGwF8EzQMK
 uHUF0J4g=
X-Gm-Gg: Acq92OGW+Pkl0iGotGEufmBIB4ySAaRLAsltBmnz8nad0Jv/tEjlNFQ6wfkdljte8KF
 sSLnftpW9SExrJCrxJR8Hv0RiC8nKfsV8yGkQXTEFH4JPdM/UP2PyAur8cQ0wvs453rw5Dl03Ex
 TrPcsadeIYEQhGc97JyFiPCyUsUTKKgnavms0zB63wnS9olkFovuXBInhJRZfQsiGiBCCkSy2nQ
 6nXbwK17IjJ71xRghosgxm/0cV0qb5TcjJ55WTnKJjI05SJQXaxLRt1tFViXnRnUc50pCkWJ6Bo
 ARyor92Z708WHeZH2bJCcErQYKaM/lT3Hg8NoV++DmqEJC9T2VQMOt2yaXozMX/OX3rrDH992B3
 JbKvT3XkS0BS5RnYBzebh8RSoaS6jqWpbxrwjS2LLZJCUKWC8GXPRdTV9Jegsj8QuXsChHVHSUO
 eNx77vL9yPTZs7Z4whiqmVrMuytCm1
X-Received: by 2002:a17:90b:4c50:b0:369:d7c6:450a with SMTP id
 98e67ed59e1d1-369d7c64a4bmr12739749a91.0.1779301338786; 
 Wed, 20 May 2026 11:22:18 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 06/64] target/arm: Update SCR bits for Arm ARM M.a.a
Date: Wed, 20 May 2026 11:21:15 -0700
Message-ID: <20260520182213.872945-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15a13b9292..0a11dd9002 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1820,6 +1820,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_AIEN              (1ULL << 46)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
+#define SCR_ENFPM             (1ULL << 50)
+#define SCR_TMEA              (1ULL << 51)
+#define SCR_TWERR             (1ULL << 52)
+#define SCR_PFAREN            (1ULL << 53)
+#define SCR_SRMASKEN          (1ULL << 54)
+#define SCR_ENIDCP128         (1ULL << 55)
+#define SCR_DSE               (1ULL << 57)
+#define SCR_ENDSE             (1ULL << 58)
+#define SCR_FGTEN2            (1ULL << 59)
+#define SCR_HDBSSEN           (1ULL << 60)
+#define SCR_HACEBSEN          (1ULL << 61)
 #define SCR_NSE               (1ULL << 62)
 
 /* GCSCR_ELx fields */
-- 
2.43.0



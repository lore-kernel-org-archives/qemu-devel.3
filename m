Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99021098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYW-0002vX-UF; Fri, 20 Mar 2026 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYS-0002rk-8p
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:20 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYP-000615-Ss
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:19 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-661d20c9787so3080947a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011976; x=1774616776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVhTaVtOsZGTF1nA/GiMlTKKLxEQJ4PvSrc2Fgrxyck=;
 b=GLa4DMtn5nKpDVDZTOCKPSklg47fbF0E/tjSVfk14uCbpvZYnGHQ5TDeQ5fwzI2zUi
 6sV5W4jVDuR7Ugm7jLxC1EnW/jI8wKlxEvVlrCWIpvadnxkiZuwjHEIumeBVJ82XW6Aj
 4SmJLmJsD1PzDlPMILsahX+b1r5L7Im5LgfctX65poKI13LXuUrnl3YIxYu/LCbB7amT
 zSndhYDK47Ie1g43DfEhHMHL1+wxGeqfisV/M7COggoyzkQw3Cqsi4plKTwLSlh1oi1D
 2gFOpE47V44RcE2JMqnoZc7fpgCnzQ2JJIxaxVNrd9Sm4x/7N8LIM0FnZ/zjw4t9F32V
 FOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011976; x=1774616776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mVhTaVtOsZGTF1nA/GiMlTKKLxEQJ4PvSrc2Fgrxyck=;
 b=k5QFnP4ew8G2i1C5kn03giMS6ycWGingUxvLDTaMCvzHJWmffxq//MC9RuRuJynau3
 +RQBq2c0oigY6MA8OYoh4l7AoKqiyXNePmcGFD5kAw98qSsAavy8mzZgdD75WUey+RwK
 oFN4lqEE1HZtdYxgrrdD5xkDQOOYc+AUxnwMRIxM04vJfLkHyQTZn3DX7lhX5nbqgqXn
 6hlIl9bFvWCkrm7L87o6n9m+oHd8WIG3sXpLXaSGjYdaItUmrRi3deCvHgXAZCkSozPF
 Xvow5ICOFCTMaq3n4u+/C2MfZqEErxO8pu1bh6Jg/foeCg2imhUJw89GKKd3nWLhkFKk
 wKzA==
X-Gm-Message-State: AOJu0YxtE3cZShWvKTiO/b0kH2pI5may+jZifGxaTQ4fQGtLmRUHijPp
 I+0vU5b19yBPMG449bCp7sbR17jv7qdLdo18wslfrxGF+aWiQuOjmc99LTfUvjxnrMY=
X-Gm-Gg: ATEYQzwIdkgA882ZaimNwV2cNqD53sOWAnjcYPZpP2sunBXxCp2PqCd+kuB5WdY/9+w
 9SUxn6v8mxR/F6wjsbWDhe59LW+iVXTJu0SOIhC0Fu1X0QZtN0AyhG80KT5+kmjBR/KtqVvpser
 10o6kxSv8mTmqA+fk5ch0L16tLpsZ5GWujhDxhuRbHPP5PPn7jM6/r2vmqg/PdeChYVpFGIpZL9
 dn8B7ihyhwe+/pADqBAlz+lbIVpZ1BSTWJ6BQT5w2MnI7HU1SvnuJsdeIRTAnXMNxs52Z16rWMD
 OI7VKciTnaQd4RjJT29s7Vmtbe5z63yRJaBMA2SveCyGh76oZKIP1FOSK0zWyjuX7+QUKm+swP5
 ZooetxLnV7GN2K1HEPMsHBpZ3HXqQAvXsDTduOUlm5GQkoEFiHs8kMvouyn/Bathq7/eXpPyAcG
 8ZnGCEERnnjYQM0v7p0Eagqy8=
X-Received: by 2002:a17:907:cb20:b0:b98:5b2:77f7 with SMTP id
 a640c23a62f3a-b982f0c9208mr146755066b.12.1774011975601; 
 Fri, 20 Mar 2026 06:06:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832beecf4sm162492366b.0.2026.03.20.06.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E5655F94B;
 Fri, 20 Mar 2026 13:06:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 10/35] target/arm: migrate fault syndromes to
 registerfields
Date: Fri, 20 Mar 2026 13:05:41 +0000
Message-ID: <20260320130607.2071996-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Migrate syn_insn_abort and syn_data_abort_* to the registerfields API.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 87 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 3fd82f5b565..db92a8020e3 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -494,20 +494,64 @@ static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an Instruction Abort
+ *
+ * (aka instruction abort)
+ */
+FIELD(IABORT_ISS, IFSC, 0, 6)
+FIELD(IABORT_ISS, S1PTW, 7, 1)
+FIELD(IABORT_ISS, EA, 9, 1)
+FIELD(IABORT_ISS, FnV, 10, 1) /* FAR not Valid */
+FIELD(IABORT_ISS, SET, 11, 2)
+FIELD(IABORT_ISS, PFV, 14, 1)
+FIELD(IABORT_ISS, TopLevel, 21, 1) /* FEAT_THE */
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
-    return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (ea << 9) | (s1ptw << 7) | fsc;
+    uint32_t res = syn_set_ec(0, EC_INSNABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, IABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, IABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, IABORT_ISS, IFSC, fsc);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Data Abort
+ */
+FIELD(DABORT_ISS, DFSC, 0, 6)
+FIELD(DABORT_ISS, WNR, 6, 1)
+FIELD(DABORT_ISS, S1PTW, 7, 1)
+FIELD(DABORT_ISS, CM, 8, 1)
+FIELD(DABORT_ISS, EA, 9, 1)
+FIELD(DABORT_ISS, FnV, 10, 1)
+FIELD(DABORT_ISS, LST, 11, 2)
+FIELD(DABORT_ISS, VNCR, 13, 1)
+FIELD(DABORT_ISS, AR, 14, 1)
+FIELD(DABORT_ISS, SF, 15, 1)
+FIELD(DABORT_ISS, SRT, 16, 5)
+FIELD(DABORT_ISS, SSE, 21, 1)
+FIELD(DABORT_ISS, SAS, 22, 2)
+FIELD(DABORT_ISS, ISV, 24, 1)
+
 static inline uint32_t syn_data_abort_no_iss(int same_el, int fnv,
                                              int ea, int cm, int s1ptw,
                                              int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | ARM_EL_IL
-           | (fnv << 10) | (ea << 9) | (cm << 8) | (s1ptw << 7)
-           | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, FnV, fnv);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_data_abort_with_iss(int same_el,
@@ -517,11 +561,22 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
                                                int wnr, int fsc,
                                                bool is_16bit)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | (is_16bit ? 0 : ARM_EL_IL)
-           | ARM_EL_ISV | (sas << 22) | (sse << 21) | (srt << 16)
-           | (sf << 15) | (ar << 14)
-           | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, ISV, 1);
+    res = FIELD_DP32(res, DABORT_ISS, SAS, sas);
+    res = FIELD_DP32(res, DABORT_ISS, SSE, sse);
+    res = FIELD_DP32(res, DABORT_ISS, SRT, srt);
+    res = FIELD_DP32(res, DABORT_ISS, SF, sf);
+    res = FIELD_DP32(res, DABORT_ISS, AR, ar);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 /*
@@ -530,8 +585,14 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
  */
 static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (1 << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | ARM_EL_VNCR | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT_SAME_EL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, VNCR, 1);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_swstep(int same_el, int isv, int ex)
-- 
2.47.3



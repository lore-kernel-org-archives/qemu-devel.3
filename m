Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3FDC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOG9-0006oq-IU; Thu, 02 Jul 2026 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFz-0006jQ-4X
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:35 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFu-0000WZ-E7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:34 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so1474310a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025008; x=1783629808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAZNZB4fPjrGXG4vj9WQohVCuClfGm7vYoEvKV7XkkU=;
 b=s3Mh21hWmvNuADUAbi9mOTtFjbrgj1xSVyVj9OdrzdIBTZCSKHxXV6TylDwRNOHJlB
 Eww6qojmBuqFC3qPGWW/DuS5uJy6FmEg5+E75VOuUfwOOKX/P33mbpSdEfHXPn2XCeOb
 v+fRy+n8wjAw2jUrwI6Xgptki9dyINchd6xRShxbRrI3xgXJyveRik9N9xN1QqDJUAgx
 LuHiF/XVkiEOE5DBfMplU2eJLMjl1aCUMBLF7Yx1Y1zKo0MgZbauhsUFu5jYpBUFAOVB
 tDBhnTu71s8lKVh9Sv6qOudFBWnTT2Ccw6P+zjaNXAXUX2TrKch7sv92CYFJ0YcBxQtU
 xEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025008; x=1783629808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hAZNZB4fPjrGXG4vj9WQohVCuClfGm7vYoEvKV7XkkU=;
 b=mvD8VXdqSIYwsqlCLS+c/BXC9yu8mXTRQ4Fo+6mr0/ouDB9f/aWokdgiwJqQYzVPDF
 mRkhmG/aXx2SNnwoWjyK7W68MPc31WvPGoqN8ZBybr39aDKspoPbD1+5j+LdHAB/4A3b
 W5CZC4Yl++/36NM/DJLRZFo+O5g29QLUnedd8w+nsxeK3ftxiPXHSH2ew9IgtwUasCl1
 rRuWSz9RUcx9r4nMWi8hrUsPM94ewyTqi37tgSE0hyYTeubzzgQdzi2tXWZJRaI/M66s
 KOPF+iadmUj0SNlylhrT2ZX/ioYfkSyADIIMhGuYqyTHx/xm1brCBDlbnSPktohVI5yT
 Icsw==
X-Gm-Message-State: AOJu0YwdCTZIc31IHVj+Ix56F/1NRV8jCAyD5b3gN02Xz7YtVuCt588n
 Dt96/Is8nqx4+C+O0DYV6Ftad9al/hY95kdcrhH7q1Uo9ti6pxMcL3smvBGVs48IEMLvttvR1V1
 tGPaU
X-Gm-Gg: AfdE7cmy7g4AKQQhkjLn7qhkEtZ/V0/fLA+liaahBKv+JE0Rr0wDVMmPg+u+qN4FIwq
 qpjuWB62MBYby5tlOK7KgDbKXSSiW3980mx92tMSU4VbhY4ocvTBjoXm826dgrDnt61X1FBVqGx
 1Too5cJC//MGx5hZfDHSOJuKlXuGhOjREsr955f1tZVyDGG27+NytuPofHXMkznDcyBv3niS3RQ
 wUMmEThN9YxYr1UMtvgcDOaPOlmUVKow4VPkdq8oPRMxQ6a2uVUvETzOXfBT7X8JlbdbV+wnDiT
 wiQdVAd8uei7Gs44M0FWJs/2PyCV1lOJd3aIbC7Q611LEpOcIzH4eHrxaygnpG79K9gid+f0gug
 +jisxlJL3LgBb0SfjZUxjG/HRbc1SHxQ4sDLv+w3aga8BDJSukiFL5/xsdT8htTTTB8xZoeh1Pa
 c5uQhv/gCz7eC/BFA0aoeqMfWmHWi8C1102kb+r+FtVrELdPsqug==
X-Received: by 2002:a05:6a21:4c08:b0:3b4:8f4a:3bc6 with SMTP id
 adf61e73a8af0-3bfed3e9292mr8582024637.32.1783025008085; 
 Thu, 02 Jul 2026 13:43:28 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 14/15] target/arm: Implement USMOP4[AS]
Date: Thu,  2 Jul 2026 13:43:13 -0700
Message-ID: <20260702204314.79224-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 5 +++++
 target/arm/tcg/sme_helper.c      | 5 +++++
 target/arm/tcg/translate-sme.c   | 5 +++++
 target/arm/tcg/sme.decode        | 3 +++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 60bc3c6e9b..7fc7129e54 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -399,3 +399,8 @@ DEF_HELPER_FLAGS_4(sme_umop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme_usmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index f5fa69841d..23bb816b6a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2985,4 +2985,9 @@ IMOP4_4WAY(umop4s_sb, -, int32_t, uint8_t, uint8_t)
 IMOP4_4WAY(umop4a_dh, +, int64_t, uint16_t, uint16_t)
 IMOP4_4WAY(umop4s_dh, -, int64_t, uint16_t, uint16_t)
 
+IMOP4_4WAY(usmop4a_sb, +, int32_t, uint8_t, int8_t)
+IMOP4_4WAY(usmop4s_sb, -, int32_t, uint8_t, int8_t)
+IMOP4_4WAY(usmop4a_dh, +, int64_t, uint16_t, int16_t)
+IMOP4_4WAY(usmop4s_dh, -, int64_t, uint16_t, int16_t)
+
 #undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b14aac2c17..dcc4690fba 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2127,3 +2127,8 @@ TRANS_FEAT(UMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_umop4s_sb : gen_helper_sme_umop4a_sb)
 TRANS_FEAT(UMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_umop4s_dh : gen_helper_sme_umop4a_dh)
+
+TRANS_FEAT(USMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_usmop4s_sb : gen_helper_sme_usmop4a_sb)
+TRANS_FEAT(USMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_usmop4s_dh : gen_helper_sme_usmop4a_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index aca6a79be3..53e7e67feb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1128,3 +1128,6 @@ SUMOP4_dh       1010 0000 111. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 UMOP4_sb        1000 0001 001. ...0 1000 00.. ..0. 00..         @mop4_o2
 UMOP4_dh        1010 0001 111. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+USMOP4_sb       1000 0001 000. ...0 1000 00.. ..0. 00..         @mop4_o2
+USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0



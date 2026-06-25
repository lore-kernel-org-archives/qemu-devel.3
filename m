Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F5BCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfq-0005Ms-7r; Thu, 25 Jun 2026 18:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsf1-0004ao-SS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcseu-0002Kp-Pg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:59 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c8857a27041so142748a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426731; x=1783031531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pK4WUnEbTEjEUmPUO5jpL2LxDvXp/H9dTkmG29xPfM=;
 b=u7Bdxftv6xUARYCMlwXIyQIHjdWzBbuumtgerp5V8Kt6r6sk3t3RlqPNM+oRkAASzj
 624wgVR8+DfLwNWZY0Khek/sbj9ouUulflvioJuQ/jxdkWWJHhhjQ4D0uITG9Xa4aKwz
 8uXvslqp82e89eDGJz5lKwmJoqTncf21xSJiAL2LFPHpKyvI8m7jk+MwZg+sDVupmdHy
 aQZzg0PD+f0ooBou8dbK+ATBSf9UnWF2YtJZi4i/Jlc5L5Huh9tsr9JFCzhvKGwnvI1+
 rKD+7ajZNXkg8LTm9SdNOGBbj1+fAle0/yQkgf6UNp+wbD3DBvtrOyCNwKyCI1rMD/PF
 X0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426731; x=1783031531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pK4WUnEbTEjEUmPUO5jpL2LxDvXp/H9dTkmG29xPfM=;
 b=nAqTEDiGOusrBTE6bnXi51KQgb/+rOzVpVedtbpduRvblg+cK1qGE/Aos5iZOhQ8fr
 ZFmRBlqq8SuB9RuH6E4jBZcMQpVvPGk/Edlt5sZFTTCZk8RnmDwBr4ctHTgQ0w+pL72H
 g+PbxWrMYMinEfBOl5wEcJOOaXrUyfYDrVNMymDsN3UW6Qj4dx0VVslKzGoBpjH6X6No
 zmiQGUxp4Vybs6nSPQtPsc8vIla55VriCZDSy/3eRVXiHoxezvhKdr5uhfkkbUbfxRSh
 9nl1qMLA04GYp6zZO9wkM4iTAfgWZxImwEAl8aQCP+HVnxWJ6v4dm4d9kGrSZxs9nnes
 mA2Q==
X-Gm-Message-State: AOJu0YxEU15kll4ImEYLQB7kzZMF12TmVnU6sgizEmixdwxn8iHtUe5N
 CK0541DPDN8M+xpyZwN4Nq3YxDJDyWt9L6RRbtrqqs/NUtyRF3skAha89Wm/uP5oqBDoX1xWHbU
 YQVSk
X-Gm-Gg: AfdE7ckmcgi1JYLSOPTATi8wZ8ve2TR+ICW9AkM0jSIuAW6CeoCLUgfXANO97ucEdVZ
 TRi2h6PtzHxapIL5phGH1eliy3/7jpyAn4eIITniq//IMgesjXaOQil8D8T30oKLVDZ/3cVW7QP
 +OOvvv3IDSJkC7HULTO+bpzyTEIurJxmO0+SHxIzvx4SbOkD9fh1TsMTrQN+ef7awPD6TYYgf07
 vXSKdnzIgVUVdr1cuO7AzQZglcgk3k4D5/o0JmeqGhwvikYGUIa6rTCBL5gjakqJtt5X3nS2kl4
 5dPDVFWCp5ulFERyLtNj60G9JExdKHzClum5jsE15eqmmSthOm+fD2ITv9DT1upCstxuOKisimh
 sQOdUs8i+QLxWGETdoP17Auaap3LGVSoUYju7jaHZQdFDYrpFfQi/ok+96JBhRnZj7uX85PWPOm
 jmVlZ17ecm4wnZWpRAwUDzGIDbNHvf+4QXDvJ4DC/ew13ylPwucFqEOlQTpwTp
X-Received: by 2002:a05:6a20:7f8e:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3bd4af5cec1mr5171189637.11.1782426730813; 
 Thu, 25 Jun 2026 15:32:10 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/15] target/arm: Implement UMOP4[AS] (4-way)
Date: Thu, 25 Jun 2026 15:31:58 -0700
Message-ID: <20260625223200.763198-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 target/arm/tcg/helper-sme-defs.h | 5 +++++
 target/arm/tcg/sme_helper.c      | 5 +++++
 target/arm/tcg/translate-sme.c   | 5 +++++
 target/arm/tcg/sme.decode        | 3 +++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 38b23690d1..60bc3c6e9b 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -394,3 +394,8 @@ DEF_HELPER_FLAGS_4(sme_sumop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_sumop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_sumop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_sumop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme_umop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index fd085850ed..f5fa69841d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2980,4 +2980,9 @@ IMOP4_4WAY(sumop4s_sb, -, int32_t, int8_t, uint8_t)
 IMOP4_4WAY(sumop4a_dh, +, int64_t, int16_t, uint16_t)
 IMOP4_4WAY(sumop4s_dh, -, int64_t, int16_t, uint16_t)
 
+IMOP4_4WAY(umop4a_sb, +, int32_t, uint8_t, uint8_t)
+IMOP4_4WAY(umop4s_sb, -, int32_t, uint8_t, uint8_t)
+IMOP4_4WAY(umop4a_dh, +, int64_t, uint16_t, uint16_t)
+IMOP4_4WAY(umop4s_dh, -, int64_t, uint16_t, uint16_t)
+
 #undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a8fcb0630d..b14aac2c17 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2122,3 +2122,8 @@ TRANS_FEAT(SUMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_sumop4s_sb : gen_helper_sme_sumop4a_sb)
 TRANS_FEAT(SUMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_sumop4s_dh : gen_helper_sme_sumop4a_dh)
+
+TRANS_FEAT(UMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_umop4s_sb : gen_helper_sme_umop4a_sb)
+TRANS_FEAT(UMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_umop4s_dh : gen_helper_sme_umop4a_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9c761f1934..4c61e6ada6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1125,3 +1125,6 @@ SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 SUMOP4_sb       1000 0000 001. ...0 1000 00.. ..0. 00..         @mop4_o2
 SUMOP4_dh       1010 0000 111. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+UMOP4_sb        1000 0001 001. ...0 1000 00.. ..0. 00..         @mop4_o2
+UMOP4_dh        1010 0001 111. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87448C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOFz-0006jO-9K; Thu, 02 Jul 2026 16:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFx-0006hz-QT
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:33 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFt-0000Vo-G9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:33 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so1474300a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025007; x=1783629807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PZ509mhK8YdWn8k+jwYDuBsRUG21T+LRwJ053aJ6pw=;
 b=QGmGbeYnq0/IJISieFfuUxQanC61VhRF919AJD2FR9UyPjYiQ+SaUEzyJkc0kjr6ni
 9GghZHp/ePPXvc8VajUlTs1RAdGlwL+i/MPTyZ6Bf/CQ/WlXoj9a5isp/AFcYWnDluKu
 g8Ve6s+YWaTI7jCqpQtFZOn2YX4VjDlPQ/PU+wqK559PGpqljOBAPwtj7G2QDITq68iS
 srcTiPT3kUhyug+2BUvbZ2XDdcXtykjYgRPrS+C8k8KJD0w3Tq4bwonM+LSDrvanhm+0
 fhpD3rbplSwXvQ2tBdbOQDKoJLYz+yFJQCaN+m48FGebZLhWAkXophG101fZv8MurYYI
 c4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025007; x=1783629807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/PZ509mhK8YdWn8k+jwYDuBsRUG21T+LRwJ053aJ6pw=;
 b=qvl+lwsYgkypan3w0DwcT4cFzQZGx/dwwYER650UeAVNIEYwk3yS8TV8S2aMevLBeM
 U34LpJFM82XE/y2oG5CV7wOWoQ8DZv8SXw7dcRogPPprApn2eKlyDzf4jbU0vZMHaiaa
 eRbYZdogz75lPUeby4FMmATzVwoAuFt/ICirfAtnEhoLFtqYFEUlkOa6cVbpUCrSoXf9
 qUzG9CGrkupKXv+UfGMyuIsAY1ziT8JZGlkkb/Wf0XMIUdETWuKsE8LnqBWOJKc1z403
 b4hfmAGyDbh8NA3RRylnlmnVA4LOcE0GeqVpcx6azfe/XoY+T0vo9s8ZbRZIVUxB9qJD
 RqgQ==
X-Gm-Message-State: AOJu0YxyMpjUEcD/bmJnxtox2b2nh1b+9mDupjSmiHnt+U7589bIHxe3
 0QMftbk+W8CEbDYxDSnItbqDo9ovQd2W/CJgLswyMIIs1VTWKmrj6RH9S2XYaqscYyEMxAIti4e
 4jDKi
X-Gm-Gg: AfdE7cm6RctG3kAp7Ubkti0l1DKIc6DGQMqS6rDh1+yz6XiRWAuD0h72nZ2+/bXj8oi
 pJhGaWHiKruftzTVsC5xxf4Iki8LUwR2GIzh7PUClmpsEcvsobIGScwVb25k6foAzX28HEMBRIC
 QJLEJTDx+VJPSgKYtNYzd8ebvP2dYeve1L+jLuJvjQ6gzAgtWkXokksB2dnFD8SXmf2iNEdJ8CJ
 WFc0IcHjGI/oRuT1x7/SCRsapVcnsciDwgRFxjtIzzidno97eqfw36MGWX6HBo2Qd+yNYr2MFuV
 PjHkN3xnn5naP1Gf3M3yBQWw3rS8L8EfQ/PW8GibRKf2LwpM9OpV9aM3EjPlELDcxKWeA9WrW0M
 X+tyCOkh5WNZ7J28u797sLu6peTUhBUsL7UE+UNAe5B/BBRrKQVy/VmyEDv55FjPn8I/5gRMXDk
 lJp6urwn4wLgi4OxxQKkQstQwceb1NIrbxVPBh+eYamS9x/aRgVA==
X-Received: by 2002:a05:6a20:9188:b0:3bf:9cbd:9a33 with SMTP id
 adf61e73a8af0-3bfed1beedemr9046720637.14.1783025007080; 
 Thu, 02 Jul 2026 13:43:27 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 13/15] target/arm: Implement UMOP4[AS] (4-way)
Date: Thu,  2 Jul 2026 13:43:12 -0700
Message-ID: <20260702204314.79224-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index fbc85b8206..aca6a79be3 100644
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



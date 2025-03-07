Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E5DC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIb-00015U-Rj; Fri, 07 Mar 2025 10:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIZ-00014C-2P
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIW-0008O5-Tx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bdcd0d97dso11445325e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360055; x=1741964855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Od4b3d3rOr7fMBRm5KIcutZc76QQ9AX8573/i1gjMqU=;
 b=gYun6AsMReztoOr8unR7rNvi1wfAeL06gY+A85Lhv76dnBpN1AS+onhnBxPa2RpdQh
 TqNMi3VVRisVoVEmefd5HCkNVHkeKpW6S7D6+sNnRK/jDeNWHJKDOXvxpzAVA2v6hdhs
 WHEnA+XC95GukhdLIck+xYV8ErvbxnwN5LPM53qEuRWj1J0W8P5vtdhcUQiwHUDK7+X5
 m1vvO0clUijRLHj+KT/IGkU557c0v8Ehi6e6bpoox5xATxnxF29UdliCBm31ul21AtJc
 4IANShW5YX3HRp3ONrxUydTnflCOuHvYCjvc3Voa4IFemD/dI6Af6N31Ryvg3c/3NEV8
 Eilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360055; x=1741964855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Od4b3d3rOr7fMBRm5KIcutZc76QQ9AX8573/i1gjMqU=;
 b=GhBd07rR44OeVVreo4u+2LQ8HBLLrfrCkkPcuBZi2QpGm4GxAJP3Q9e9VCG/EirdH+
 xOhpGl+bEuqADPDo+FA7wA396Y+E05VGGplFi005AzfYPxbDKa92QBSXtrOLJxaGIYzf
 3u4ajIDX5WNFL5SVqid2bU/uoTcr7BMecxD85SFaRrZRFY7w0TiBDltvcKwUekQAuMb2
 /CCrXnxbMY8PAtUfXRqQo7snqFQIF43vcrDO2Hba7NRx1ojoUmDJaWmJ+o1XHjX6TrZT
 kmVvgcFK+kU9NsSD/9MP8fSsPKSYINZrKTz8zrX1V8nOSUhSr0FKNKJxwnpJJXetgc2e
 UqSg==
X-Gm-Message-State: AOJu0Yz8tJWA7/4wN8DauRpWTyCZJCV+/pYtcZBp1n4rwnIYgcj0hn+B
 /oJeqkzKOQUkVosSHMUPShpBA/b2Nxx+Ab/vjBA/dALiIdystyIY9C1LnpOuc6az+Pf/82URgEX
 b
X-Gm-Gg: ASbGncvwEX+IEet2K+CHJWYGwE6ajl7PIRhbdTdq7VlrVKHEXynplqxGXLy0faXl5cH
 3HjVvkL2icNxWUfchIQGSj72mv1uun3AtO8pw4grhO2Bd+23veitQaH7E+0JnNbJQv1U54XrJYL
 cacj6zoqia5VWSvkjnP8GA9NQKz2ea5/lK2rGX/MNXtLtiiABvcPZ5gtbLmdaXMqr2ghVpfFmgM
 NgYTNUWT5lLihvVV+10cAJpnGYXHxKhCuevRveTzmSZvJ0lQcq5I8j52G7Gavkd9sfRJDMj/P6F
 j8VvbZHgTbj1FipmzSGPNkHLA0/NhL5JJFgYNUbNsZyJ7l3t7Ig=
X-Google-Smtp-Source: AGHT+IEoIMNAFnjO5XzmagLGHpNdNwOcFL/OOJZUkHhPY1znWBpaXL669magZfTPwXeRTR8eu+EWcg==
X-Received: by 2002:a05:6000:1864:b0:391:39ea:7866 with SMTP id
 ffacd0b85a97d-39139ea7d93mr495744f8f.19.1741360055304; 
 Fri, 07 Mar 2025 07:07:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] target/rx: Remove TCG_CALL_NO_WG from helpers which
 write env
Date: Fri,  7 Mar 2025 15:07:08 +0000
Message-ID: <20250307150708.3222813-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Keith Packard <keithp@keithp.com>

Functions which modify TCG globals must not be marked TCG_CALL_NO_WG,
as that tells the optimizer that TCG global values already loaded in
machine registers are still valid, and so any changes which these
helpers make to the CPU state may be ignored.

The target/rx code chooses to put (among other things) all the PSW
bits and also ACC into globals, so the NO_WG flag on various
functions that touch the PSW or ACC is incorrect and must be removed.
This includes all the floating point helper functions, because
update_fpsw() will update PSW Z and S.

Signed-off-by: Keith Packard <keithp@keithp.com>
[PMM: Clarified commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/rx/helper.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index ebb47394744..8cc38b0cb71 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -4,27 +4,27 @@ DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
 DEF_HELPER_2(rxint, noreturn, env, i32)
 DEF_HELPER_1(rxbrk, noreturn, env)
-DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fsub, TCG_CALL_NO_WG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_WG, void, env, f32, f32)
-DEF_HELPER_FLAGS_2(ftoi, TCG_CALL_NO_WG, i32, env, f32)
-DEF_HELPER_FLAGS_2(round, TCG_CALL_NO_WG, i32, env, f32)
-DEF_HELPER_FLAGS_2(itof, TCG_CALL_NO_WG, f32, env, i32)
+DEF_HELPER_3(fadd, f32, env, f32, f32)
+DEF_HELPER_3(fsub, f32, env, f32, f32)
+DEF_HELPER_3(fmul, f32, env, f32, f32)
+DEF_HELPER_3(fdiv, f32, env, f32, f32)
+DEF_HELPER_3(fcmp, void, env, f32, f32)
+DEF_HELPER_2(ftoi, i32, env, f32)
+DEF_HELPER_2(round, i32, env, f32)
+DEF_HELPER_2(itof, f32, env, i32)
 DEF_HELPER_2(set_fpsw, void, env, i32)
-DEF_HELPER_FLAGS_2(racw, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_FLAGS_2(set_psw_rte, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_FLAGS_2(set_psw, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_2(racw, void, env, i32)
+DEF_HELPER_2(set_psw_rte, void, env, i32)
+DEF_HELPER_2(set_psw, void, env, i32)
 DEF_HELPER_1(pack_psw, i32, env)
-DEF_HELPER_FLAGS_3(div, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_1(scmpu, TCG_CALL_NO_WG, void, env)
+DEF_HELPER_3(div, i32, env, i32, i32)
+DEF_HELPER_3(divu, i32, env, i32, i32)
+DEF_HELPER_1(scmpu, void, env)
 DEF_HELPER_1(smovu, void, env)
 DEF_HELPER_1(smovf, void, env)
 DEF_HELPER_1(smovb, void, env)
 DEF_HELPER_2(sstr, void, env, i32)
-DEF_HELPER_FLAGS_2(swhile, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_FLAGS_2(suntil, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_FLAGS_2(rmpa, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_2(swhile, void, env, i32)
+DEF_HELPER_2(suntil, void, env, i32)
+DEF_HELPER_2(rmpa, void, env, i32)
 DEF_HELPER_1(satr, void, env)
-- 
2.43.0



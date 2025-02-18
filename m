Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428A6C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 21:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkV2J-00034J-5B; Tue, 18 Feb 2025 16:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2E-00032z-Tz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:42 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2B-00033L-LQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913697; bh=rseh06rZwnj1XEKSik48UBym2dlowjYs00+a91IMU/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pPyVDpbilkb/Lg87lqPdvESOf7R6IernWyIfrys9+F8ybiZPtQn/KOiGR9eCzitaV
 XP4G7+4VmuLwFa24EfadqwFnkzMjtdDTqJoXjOIJDVYb/EPaV2SKVLMOR8XvaMUDI9
 BUCdedCH/bWoOl+L3g2x9itiOqy+slNTW2vcTYS+Eveo41UtfohIIUsvl2lOqwNmQW
 wwydC3Yj8LjloV2QV3F+NlW3ptefB3E7A8ySAQhr4eftdhb7CEVbEPmsRf/Ew2jjxG
 C0qUJP4bK9GertIf12m0ose74JKejvkTsFmX6ZEA6YbD5yyTETHmdvV1GiiBEenvWb
 pUeR02TpqH+hQ==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id ECF073F20DB1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 13:21:37 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 0UXT2VrVZUh2; Tue, 18 Feb 2025 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913694; bh=rseh06rZwnj1XEKSik48UBym2dlowjYs00+a91IMU/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wMFItj/5ACqrAqmuVNiG8L9uwxpcVyUlUSrfdAMBRau7AteCr7S4+vHZmLmPmpDUX
 HdZPKt2cBxGj6AiKbPgNM/e/DVqpcLBUusrVeHXFFKxkdy3ZGwZadCpQhZsghxIRI4
 E31jChVom6NpQm1nu5cKEoTzUNfGuRd2qFC8NuMhs/qtaKFhSD21dELC14eJU8UvEQ
 0Kg021iSmExX9XEScKcMzWEaE8a1VsRAlZ5iELoyZXWrdtrf4tsrz51ngd2xCDLcWy
 iIvtlK+ELgCr6MfE/+PDOTfk/9ydSjYYJ3kXPjV3gDj0zd8OsiFsC+pFWy1tx/j1BM
 e2mF3fXGXpqZA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id DD39E3F20C61;
 Tue, 18 Feb 2025 13:21:34 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id BAAFB1E6009D; Tue, 18 Feb 2025 13:21:34 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 2/4] target/rx: Remove TCG_CALL_NO_WG from helpers which write
 env
Date: Tue, 18 Feb 2025 13:21:01 -0800
Message-ID: <20250218212103.2024039-3-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218212103.2024039-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Functions which modify virtual machine state (such as virtual
registers stored in memory) must not be marked TCG_CALL_NO_WG as that
tells the optimizer that virtual registers values already loaded in
machine registers are still valid, hence discards any changes which
these helpers may have made. This seems to also mean that functions which
set condition codes may also not use this flag

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/rx/helper.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index ebb4739474..8cc38b0cb7 100644
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
2.47.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DACFC021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 02:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj7k3-0004Gy-Ln; Fri, 14 Feb 2025 21:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7k0-0004GL-NQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:12 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jz-0006dn-6r
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585826; bh=/tsRwvbTOyoVzLtmCyEuFpgz4OrTtgDazD6Mn8+RzLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NQvCmP90k8rStqP9DgH4pcctkymMcQ/Len6NV524h6CjRH1Ls3XoW9H5BKXx2ufkM
 oeV3/5m9/6P/oYRKnCyI3+U2avKai4TMQuz3jrgrwfbRA60Vgfyimonxf5EhoOF1pG
 L36mymGUmiYurVqp+/7DEBHCHA2oQCmgZ4094kY7gIf9o7JtF4eUrOfLSoBWe74E6d
 G6h6lLFMpkENXFCDMQlX5f+fQbwvEREbfvzZ7eaQLfHE9dt7QW7kht6CyZ4RTa/YCO
 POONiNgkDCAysn0d6yzFYGAhQrYaWindL31GkFRS/vS+pdVlLp+cK9Ny0hl5j9dkyy
 BHRNi4zQCmHeA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 81D583F2294E
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 18:17:06 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id iuS5Aqj3FqQs; Fri, 14 Feb 2025 18:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585822; bh=/tsRwvbTOyoVzLtmCyEuFpgz4OrTtgDazD6Mn8+RzLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mF+fCKjJ3lZaHlce9Es/pvfa9Qd2wG5xAOYTsR1plyUjN6OeGY3iIu0MfLpYoBwX/
 Jm1yfdKycyn05pV2Yjq+Prqvf56ZQBwz0LIKYNY1OBJlrDmVf68JNe5iA/eIQ4x3II
 Os+f+R5m5TSFmtyotDepaoOSAieqU6T26Hxqi5W0i35HJzEQPzfpSMaFWhsCl+/pkD
 uYpHpgquyvuaSs/G9fTcE09aVIyT4LEUX35r3CXF+0P3Erdz7zNLG4RdXQ+mgxClWM
 34bWSRUF7gtB/q6NLn2P90ke2+W3iIL+gaSd28bllCr87g1wt41uFvm91DI0hz2fPg
 SqJ+e6Q8YTorg==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id A41203F22BF3;
 Fri, 14 Feb 2025 18:17:02 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 60A0A1E600A0; Fri, 14 Feb 2025 18:17:02 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 5/5] target/rx: Remove TCG_CALL_NO_WG from helpers which write
 env
Date: Fri, 14 Feb 2025 18:16:54 -0800
Message-ID: <20250215021654.1786679-6-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215021654.1786679-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
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
these helpers may have made.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/rx/helper.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index ebb4739474..ac21f4fddd 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -13,18 +13,18 @@ DEF_HELPER_FLAGS_2(ftoi, TCG_CALL_NO_WG, i32, env, f32)
 DEF_HELPER_FLAGS_2(round, TCG_CALL_NO_WG, i32, env, f32)
 DEF_HELPER_FLAGS_2(itof, TCG_CALL_NO_WG, f32, env, i32)
 DEF_HELPER_2(set_fpsw, void, env, i32)
-DEF_HELPER_FLAGS_2(racw, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_FLAGS_2(set_psw_rte, TCG_CALL_NO_WG, void, env, i32)
-DEF_HELPER_FLAGS_2(set_psw, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_2(racw, void, env, i32)
+DEF_HELPER_2(set_psw_rte, void, env, i32)
+DEF_HELPER_2(set_psw, void, env, i32)
 DEF_HELPER_1(pack_psw, i32, env)
 DEF_HELPER_FLAGS_3(div, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_1(scmpu, TCG_CALL_NO_WG, void, env)
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



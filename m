Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EE8E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSh-0000s6-Fb; Mon, 23 Feb 2026 03:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSa-0000qU-58
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:32 -0500
Received: from p-east2-cluster3-host11-snip4-7.eps.apple.com ([57.103.77.178]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSY-0002J2-MT
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:31 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 8715218000BF; Mon, 23 Feb 2026 08:38:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835910; x=1774427910;
 bh=sec6CMnKYJJI9y5Wj8/7I6YJyCwv3268OSQx7dh58iI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MZk6v56ex4wDs+K2P4yAo5KjcohqHOqct+wm9+nWeraPfoDyzjD7v6h/ulC1Vs6egzOnc9OHa3iGT+ASP+Bpflb9vMkZEX+G8/o4HWZcb6MUwAfJxB0JE5oXJ2wQjV0YYIlmtyHmyehQSDdxMWhxiQCPsaisXJ5gt7vsl4tuIFhOgGE8ILhBTMuJ0JyqjS2M0fgSylar8ZRDfGl4BC39kbFZaXey/lQAPVsyjMTLLBGnm3MnpoI1aHTaITKR8/NyRke89X4nq5LpLw366EslBiMQ9WzYK6kVZDd5S7XMLmbMkTSBG1vtaIRQduKCXNnHhGpBZpoVMfr1El+ytN5Jlg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 407FA180020F; Mon, 23 Feb 2026 08:38:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 21/27] target/i386: emulate: get rid of write_val_to_mem()
 helper
Date: Mon, 23 Feb 2026 09:37:27 +0100
Message-ID: <20260223083734.48533-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX6rGGggbymyM4
 ZYxc53NDQxVTjZqO931s+N+anyP5oRD3L21srkQPr+vS3klaxJ7Srzchj3hXxsAeYE8E6cLULd/
 FHL1X2EFJ4Gwy2VIQSTguW9+M9dz7zZ+6UU7qdTC9uvJy151WsnvjQgPgE1nudmk9g9utiYlVX8
 N7qAZtRySPVewsnj/ki6I5SrMicnP70LKhIdqRKStQa3nMFyo66FJ1RGf8IomijljGwb+3hYR6w
 9UsFVWhGnDe1Pb7azITW7QnlXpQHkH6yCso5IyVGMXo9AdQRcksfGoIH/SoszXnsYfLwCbuxuGW
 ftVgNtCX1rYsRWTa4lZW3ouCXQoXmrJ50RsVxkHUCK33K1EJmAipLIH7gHPJpI=
X-Authority-Info-Out: v=2.4 cv=NrTcssdJ c=1 sm=1 tr=0 ts=699c1205
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=X61gGJnvCjtZcTrZb8IA:9
X-Proofpoint-ORIG-GUID: qyHfEGa_HxO0SY38F7FtLYCeyMAqKAQK
X-Proofpoint-GUID: qyHfEGa_HxO0SY38F7FtLYCeyMAqKAQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=860
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABrrKjmFfhPBvUyColqYVG2RmpldHVjbPu1g0AW77JyMVjJFzFwOwZbKZaCyAuQleiaJ+qHBrBGbJPnYEN2VsmyPlGhtYQY+PjeGVR/yNRdpcbYQ19+cuPuzoRbm+gMNTgXz/DwcZSfsM6TIlgq8bPTVDb3L3QJ/qczF+uidXuOvtks00mppGUizpqKlDZach/zUrIjBvxTwkTCnDllNLxhnNsVkYJSUHUBrBjZRZ/yONRKCEWSSlOul+1n+1B7HhaNFzhF/l5nmPSlrr81jrfpe8C/BQAvpV5URbbHfwd9zA8W6cjl89V8LIbBzry3Jb8NIVEYUT/3bzrt1kmyupU5E798WIXl04d00LMnHHm8e773VwuA+4kfTDXaP5tAsrRAuY9Z+Fe9a3Q6lxNbum2iNuqzBYjQi8SRQ8HvCrz/p0//mSyX5b8Yklc+Hz9XNoST9mMvsrkAWC5rx6buJ/iJVwB732I1SUnUDxtf2K3/g+3pXmFZzon2XD9YAtjl3xMcu4yUzZ4uaP2aAKIn/qaktGzE3H9W0H/DChYRWziprIURDhBesz9IVi5KaORzQsZF3oUPHMjx0fVZBBbQDZJ5SjjQIjxowYz8sHS/zSNxmGaJ7wabOY6NEsfZIra8LWnMverV/m6jMzshBTKE1j9qiMpy7VMYWojsbkyvJ36ovMrACvdoCRVAnmU0YHJ1f2t5TH26hl9qvuOkd5ubcK8fcDT6dNoSo3ZGdWGI+E52D8S3RgijD+DJvXV/0o5YPgXhoO/aGwa+jsh2MbGh1d+clKKJR6MtFENth9mWq4zy5C6yNM5Mk2FW82DGS81/wA=
Received-SPF: pass client-ip=57.103.77.178;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index cfa35561dd..3aedd638a1 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -164,17 +164,12 @@ void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
     }
 }
 
-static void write_val_to_mem(CPUX86State *env, target_ulong ptr, target_ulong val, int size)
-{
-    x86_write_mem(env_cpu(env), &val, ptr, size);
-}
-
 void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
 {
     if (decode->type == X86_VAR_REG) {
         write_val_to_reg(decode->regptr, val, size);
     } else {
-        write_val_to_mem(env, decode->addr, val, size);
+        x86_write_mem(env_cpu(env), &val, decode->addr, size);
     }
 }
 
@@ -548,7 +543,7 @@ static void exec_movs_single(CPUX86State *env, struct x86_decode *decode)
                                 decode->addressing_size, R_ES);
 
     val = read_val_from_mem(env, src_addr, decode->operand_size);
-    write_val_to_mem(env, dst_addr, val, decode->operand_size);
+    x86_write_mem(env_cpu(env), &val, dst_addr, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
-- 
2.50.1 (Apple Git-155)



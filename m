Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9020E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRTV-0001c8-Eu; Mon, 23 Feb 2026 03:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSc-0000s2-7r
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:35 -0500
Received: from p-east2-cluster3-host3-snip4-5.eps.apple.com ([57.103.77.156]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSZ-0002J9-EW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:33 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 8B4EF180021D; Mon, 23 Feb 2026 08:38:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835910; x=1774427910;
 bh=A04BlxLz7/khJrSYJAsW3ORmDALVzlVjhIJh6HzuFL4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CKShV99yYLDTJAERr5f2QZefBqEIlV6evitCOusKaatHG3ug8H1qgTbWe02Gqnfy7XrYrYuG1jBJBwbZn3I04zOt2lku5oNCBVpZzm8xeKfUqotMSzl1/FLIA4dQnIbpQ71UraVoItZAy8Ql7cbJwK51a5tY1FS8MXIevySpF7Ubd82VsWjuum3PB6QIAan9W/IB2v0R/sT8PAyvdNpsH4yZom/mF1XvGqK8pLfdypzgBPqA/rcnibCbRuMhPFQE7wF7aIteIYDiVJBpBYUdKqWKXfx1IxuD/XtfprbOIVFLPkAQQV8t+bgawk7IEfzZj289+rU6L/YM1SrMMsnKAA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 D14211800223; Mon, 23 Feb 2026 08:38:24 +0000 (UTC)
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
Subject: [PATCH v5 20/27] hvf: i386: save/restore CR0/2/3
Date: Mon, 23 Feb 2026 09:37:26 +0100
Message-ID: <20260223083734.48533-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXyeNcEKjCGvzH
 UXJFFkE+jkWzvAbNn6GP2fgp38byhKAOUNGjcwptl1G2l0d1y3nNB5UfafrK28O9P/AX/31bECp
 vylHgCa1jqfcgUYoX9tR5R1+kERdMQXmg7GTnpcMhXqEskjCuK6juyS4Di/ONNHZ2eO0L55sZ/s
 OVml5qDZpGexyRai9blnXUD2tWdw+n+fPLNXzSodJUbU/+wCqBgUp1PoYw/iQx51nu4qA8rVhxj
 WMzrK9ZGwln4USVpcWtG1v6h/3B5fEMS86U6lEAExMFtHvTzz7AzUeVmeP68tfqFO9M7pK1uTD1
 R3Yfr9xq3/4nngsfokgHGEHB2oZbGhDFLsg0BP5qcSAMGLmJIcypNEDlIPmHys=
X-Authority-Info-Out: v=2.4 cv=fr/RpV4f c=1 sm=1 tr=0 ts=699c1204
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8nbFswGFAu2En9I1cXwA:9
X-Proofpoint-ORIG-GUID: 15cdjiEEl0yYNg9W73i3iFOVHRshAJrL
X-Proofpoint-GUID: 15cdjiEEl0yYNg9W73i3iFOVHRshAJrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxlogscore=747 clxscore=1030 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABj8p/Wv8oRtocVz95AdUpUShnXDgK/nU26VUiAFeMR1ePcTGC2VEcORdi3yJBZ+cpkV2tjubleqkSQ9IfQ4chRQvXtE/GvpO7JLxAYulEZ6PHbs4D6B6PTvNLTcf6/hvWHPgGl0Iw9OfkIs4hJX+leOW0gBliKe4GCPKtbe/fL63PVUdrRDUnhxYIVzmZgxWngE1KVEMlcp5w5IYXBLNbdm7Jc32EiuCqdJCd5JulcCcrWH0zdgukrE6neweFYo1+7nbrZqA9FBpB7R7yzm4WQX2vIDYzQ92L+5oye8kPsZSef5fF1rEG0J4u7ouGCJnmY06TZJxGFOo63nh95ByZqShmWyuImachUhaR2052iSwA0R/pylduArZcWGaodOB9nEx8k3CoU+NZmpoRDZuOl3LwkljRYlSOpWdmUOpPn8dgOHS/n3gKn3pCjhd5UrV74z0u+9VBqIvLpZWylCkOpdjuF54/kcQvXUO+fae7M5Y84QcPucF3xm2xOoIcjFWogtuBQ2I2S7aoik7mZGutjRHwf2ePZo2yH6j89/C3h62tZPlhyJvGRduQwX0heII5zd3LBNzvYheIvvTrHhLsv9PFjpve2ZmaQYbQrm5gT7w5IQCUTzOLZEmGCCuIt54ww14oyFRUVLuj4BmSasF5AKLm0jN7COd8agUYhqTvU9wj5IZCJAdbm2gK41cQhvKH8V9hGorfQ4YOko43KQ8gPC2AG+dqiS5qUugqoqc8FOJjjetEVJwmLo/DuPQNhf1Lny7m4bSZsZHx07y3E8znuS4hND2RXcEOWu0q
Received-SPF: pass client-ip=57.103.77.156;
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

For symmetry, save/restore the same set of registers even when not needed.

CR2 save/restore needed as page faults injected to the guest imply modifying CR2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/hvf/hvf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index fb039ff7bd..a70f8461b0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -477,7 +477,19 @@ static void hvf_load_crs(CPUState *cs)
 
     env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
     env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+    env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
 }
+
+static void hvf_save_crs(CPUState *cs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
+    wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
+    wreg(cs->accel->fd, HV_X86_CR2, env->cr[2]);
+}
+
 void hvf_load_regs(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -794,6 +806,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
             hvf_store_regs(cpu);
+            hvf_save_crs(cpu);
             break;
         }
         break;
@@ -837,6 +850,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         assert(ins_len == decode.len);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
+        hvf_save_crs(cpu);
 
         break;
     }
@@ -942,6 +956,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         decode_instruction(env, &decode);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
+        hvf_save_crs(cpu);
         break;
     }
     case EXIT_REASON_TPR: {
-- 
2.50.1 (Apple Git-155)



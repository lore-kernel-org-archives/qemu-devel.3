Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FE9E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRTQ-0001Ve-Hg; Mon, 23 Feb 2026 03:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSe-0000tu-1o
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:37 -0500
Received: from p-east2-cluster3-host2-snip4-10.eps.apple.com ([57.103.77.231]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSc-0002JT-11
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:35 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 EC2E218000A4; Mon, 23 Feb 2026 08:38:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835912; x=1774427912;
 bh=S9AJdBE8oo76V1KEGNHuiIM13A7vPwhp6IK3//MSg3Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JE71G0fiYv5+xBQs5TjdHg9PIRh3fL7fpO70E84Y0hevzAKqMHcFgAjKyCHPPEPQ2Ja5SDZUUvGA2rSmgnaIGAlsR4zK4gbmndAF1aHoQNZGG3Iz2XMopP6V7PmFrPsSzWHY2dxbF1gNqmzb7EJux9nlfYj2aYXjdVOMbgp64c+cBH+yitjxOvAhNeqlM64Jvb/k/Zi3ENlwaRmifhPrMqPR4c68Cc/+mICAcSKRmh4WALD7iB4aLBTD8AXa5mONuCyu9MHJ1UxPAhpnBbWcoof5zJgiLvvDI9C69HMYoSXxm+/H99lCmj0mWPwLbcTJYZSiJgGpTLz6suCL+DWgAg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 AD6E51800179; Mon, 23 Feb 2026 08:38:29 +0000 (UTC)
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
Subject: [PATCH v5 22/27] target/i386: emulate: raise an exception on
 translation fault
Date: Mon, 23 Feb 2026 09:37:28 +0100
Message-ID: <20260223083734.48533-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rrGl6vO-anZ7dDG0eTHvJbAoN_zXIC8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXwpInSagZoX/T
 mpv4E5/ptyBA+tWJW7h6LONH8bsnYr7o1H4r3cBFQmMI9DcwmyEhzR2nv4nRs8t/YOv44O/bxlL
 BLEKoS3LehiVIohkXFe5JB9RiOSRH4cl3BCFp03hohdo0RrCIDe5jGl3ImkTRcH7tFPeT/kfmQc
 2h1j4ZSB0brTmvRJnRNjRUctNRYvWtQQrUy9RJ9erhrvezQSTmqbcYmFtFkzbHSfV93m3IxGUfR
 H/irl+FRAJmqeiGh+TzIK2aacRoFg3Zz+YvfTpg15xiWmxqeUVjPK8xLLuODmHR/BuX4iZFHvRq
 FTekz6qwQ/YO92NW2eEj6q9hGToSH71/+c2fr4tOy6ZEDUr8aSx4e0An3Mk1qI=
X-Proofpoint-ORIG-GUID: rrGl6vO-anZ7dDG0eTHvJbAoN_zXIC8T
X-Authority-Info-Out: v=2.4 cv=N9Uk1m9B c=1 sm=1 tr=0 ts=699c1208
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=L5enj1CBYy6CaSJ8q-IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 clxscore=1030 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=794 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABWiWJJR/yVLAATf6Tn2moeCT3PqHkSN7Wg/qDrXIbjDyf9ShDpi9nk7q05fXM6m3qLVA7SJASir88nkbhXnAMQQthx3xPn8OWNluWlWlvOJF9XMWN1/Tve45xdG136huc2Ncf/xh8hR1v3sRSdckdqyqbN4ThqmujIroo2+bL4fxSYY9KCMZXA8xpjinvnKDzpXgZ8Bh9mqAd58vImga7cnY9LnO51I7DgbGyno64tpLijtVbiz41d+iYe0pfKeNDK8uiWGH7yEtycgN4FQJlYztnVkRVq3rvjH9+GAj2Tl/uwLMvaqgDQaHZojYtJbU7QyneZRflt91tT3o8P5++EgnKtei0NFwZRA3577nLWZUAExCUqJol/YBpfYgw+5Ys9Xz9y67xWOAHzQ1ee7SKoKoBIiH45jyqGnKi2JGHIIKYR6RohgWBbtVlGw9CqTBo8g2eUXlq3rowFWEwV4CXlSoCbEXWL3fSHLVACj1pwUeJKMngIPmPB0oHWj+1WAHuxxnNQBHUCwFu4//zmIsBY0uHIIEIpDlXPmZxgTmLrQsNDSiV9zSJoeCh2OjXfxFrCgqPIFW8kaRz+9PqWi4e4mVZOl6AfesP3nyDegWcHxQ1lcUjOOfppOLKhSdA2OfMhEgTXCFKoAuk2ScYUHDbqJvTiAjfp5GwanMSWnLFZGZcRJ6oc9tg/po1nvi764F6nMmohmPyDyzPffegWT5eR34y4ZTBBpwP193QeYjzVTzmkUppp7LpY7jNenaosZ5i0msZ1b1lQYwXrtrCq/KjFt1HqREyBWtDQX4eeg8=
Received-SPF: pass client-ip=57.103.77.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 target/i386/emulate/x86_mmu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index d664df5e1c..c7d2a77531 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -239,8 +239,29 @@ MMUTranslateResult mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa
     return res;
 }
 
+static int translate_res_to_error_code(MMUTranslateResult res, bool is_write, bool is_user)
+{
+    int error_code = 0;
+    if (is_user) {
+        error_code |= PG_ERROR_U_MASK;
+    }
+    if (!(res & MMU_TRANSLATE_PAGE_NOT_MAPPED)) {
+        error_code |= PG_ERROR_P_MASK;
+    }
+    if (is_write && (res & MMU_TRANSLATE_PRIV_VIOLATION)) {
+        error_code |= PG_ERROR_W_MASK;
+    }
+    if (res & MMU_TRANSLATE_INVALID_PT_FLAGS) {
+        error_code |= PG_ERROR_RSVD_MASK;
+    }
+    return error_code;
+}
+
 static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
     MemTxResult mem_tx_res;
     uint64_t gpa;
@@ -251,6 +272,9 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
 
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, MMU_TRANSLATE_VALIDATE_WRITE);
         if (translate_res) {
+            int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
+            env->cr[2] = gva;
+            x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
 
@@ -282,6 +306,9 @@ MMUTranslateResult x86_write_mem_priv(CPUState *cpu, void *data, target_ulong gv
 
 static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
     MemTxResult mem_tx_res;
     uint64_t gpa;
@@ -292,6 +319,9 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
 
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, 0);
         if (translate_res) {
+            int error_code = translate_res_to_error_code(translate_res, false, is_user(cpu));
+            env->cr[2] = gva;
+            x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
         mem_tx_res = address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
-- 
2.50.1 (Apple Git-155)



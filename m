Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7778AEEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXm-0007NR-8B; Mon, 23 Feb 2026 18:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXh-0007DL-OO
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:45 -0500
Received: from qs-2003j-snip4-6.eps.apple.com ([57.103.86.99]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXg-0004Sn-00
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:45 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 D11C2180010D; Mon, 23 Feb 2026 23:40:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890042; x=1774482042;
 bh=/kVWj4k8zYPDJ4BsTjTUg1SFE+xR58WxAIkclcXxeAY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TKN4k+6CMPdpU3L4hpXfb4BnTm9kjmt8b1xXwHJr0xwNFG72brsw8Jza+gRHoL+/uqx91ZCIiMTkV0u1HMowRe4ARZ0if/lqeVc2wV3vePqz8Set4I9TEMTs3IFKEPD4vS4qFNKhJ9ytRkw7fS0HGIgU+kmdRn6TnENHi7OTa12+MAvThOV+znm3TwfpV+kAKw2IBrd+rzvkn3qy/3tY9KLJSx6jEF9hMb24JPEBYun0qAGL69Km6fXFUTGaaXG1Bdh4S6WU9H73B/kusYdWEpD4G0afk9Jmrz1xFZ9PyZMkwA50iVkLPfDI+5nigtbhAR3b+Iy6BBwRK1cZg0YGqg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 1C4311800149; Mon, 23 Feb 2026 23:40:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 22/28] target/i386: emulate: raise an exception on
 translation fault
Date: Tue, 24 Feb 2026 00:39:44 +0100
Message-ID: <20260223233950.96076-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX8E7OxvzuXAPp
 A0dGCfxxai6TqHGEXmJYXX7uMCfwrzfozSoT7aHgsjGOcO7nywluokzTdA1Q95vtsIwN8EqdKtn
 6oDQnsw44F4OLis7pxTZ8xzfVMDwkyVxf+RhAqIgoVLyg7Gf8BSO4gS77sOtohMVJwVWnhDsrQl
 M9C1fy92CMbbuCOCqe8rFXD5ULPDIoAqYhDi9pQecH7uFuilmst76lqNswLYtWxZx9aFhJpMt99
 T8kqu5st3Bv2dBqo/Yij0bk3Axr2HXt7ZsrhLAW5ilcBrrxvmz/NMNm23YL88z0BQ65fTWzfW6p
 dA8hqYbElKIYUAKQRcuuwHwY0W6O3/CCQD4s6hbXLvJBTzsGH8br3K/5kGXniY=
X-Authority-Info-Out: v=2.4 cv=Lq2fC3dc c=1 sm=1 tr=0 ts=699ce578
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=L5enj1CBYy6CaSJ8q-IA:9
X-Proofpoint-ORIG-GUID: dzRc6nKiRt-QYi1iehKvfYgBLvN-YnWA
X-Proofpoint-GUID: dzRc6nKiRt-QYi1iehKvfYgBLvN-YnWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0
 clxscore=1030 lowpriorityscore=0 mlxlogscore=794 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAAB1yY9wUr2Yi0LqjD0CYnSMXwMtybEtLeFYKkjjoulRJ+lXBnPrAujg9G0nu/8pD2pEafnnwStEkjlDkQawwIJ6tQ1B5Ubbno3NRPb+WOC5ysUeNAckA9aqaIu+ET7Ui3lqv9O/yt3q+SNy9p9xzlgyTamlURot32e7vAISwSYpXIZCorBII1SEoJ3RGMMXcWoBzHZ3kWZm2YuHe3bybYCM5vI80tEvwmddClFe1WL9HUD/W72fSMJfGYBZlyr+cJ3f85P9tbxJrkEbuHP37XTZd0lHdmAAEotgoiSKUp0lppjpqoBzvz3gW1MZwceuuj+WXmogx03/SSEoAeeADDFQH+uY6+ZESnZmkvsRSLedhLqUnv02axhp3ydhCqFF1JlYpBF31bOtTSoeI1hZY1BwRG5OHafNz2g/oA6iwGAoMuQ8qGEAeEfXSLlAYGw/EPBQjf17PAkRdL9KA0XIO6WRnL8iXgjIImw+/BHD3kbnXBktZuMsgIVhOPJGy7r3YcIhzCBn57YgRz+g5HfNz5N5hIoH9oUiRxJpTu5Mp7z4IWY8NCmspj+5TSQUiFuWKTSVfBgqaXfGUqId15KUS5bekpofSHi05gQwxHdy52Dx+YGPXCrDfaZ5fjRTkydtcPJy6rIPQRo+3WrGhEDJfvHV+dRdjnJe//SlUhtNMi1LMmb+EVwi9XHyfd2GrE97Vj3g5mQld18qW8o8h5Y8Bh5lYAvqA7Yn2D2pR/Ss/A45hiH5I3NZ4nDPrDdbR41euOavnIXQcHRGPUpQAyATbgR/qFLxe4d
Received-SPF: pass client-ip=57.103.86.99;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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
index f9ef1070fb..d30f6c4a3e 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -240,8 +240,29 @@ MMUTranslateResult mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa
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
@@ -252,6 +273,9 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
 
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, MMU_TRANSLATE_VALIDATE_WRITE);
         if (translate_res) {
+            int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
+            env->cr[2] = gva;
+            x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
 
@@ -284,6 +308,9 @@ MMUTranslateResult x86_write_mem_priv(CPUState *cpu, void *data, target_ulong gv
 
 static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
     MemTxResult mem_tx_res;
     uint64_t gpa;
@@ -294,6 +321,9 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
 
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



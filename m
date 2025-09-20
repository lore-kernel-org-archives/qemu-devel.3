Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203D5CAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyAj-0006Uy-2k; Sat, 20 Sep 2025 10:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyAZ-0006Ql-7g
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:35 -0400
Received: from p-east3-cluster5-host10-snip4-3.eps.apple.com ([57.103.86.224]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyAW-00082E-CL
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:30 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 EBF54181721C; Sat, 20 Sep 2025 14:02:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zNv66cYWOjcoM4iD8mPZ0d3N5D4+2q07Wwy2NtrQNPs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IOLDUEDwDN8Iq3LaU3lApsJnTyoRXdRFTV6DffGbumbm9etkB6vQiAYEaYIO9Pevx9cMGl/eezAahpxy16pNyQWVhr1FO2YcNbRfPxq8GJInbdsuPrchcKa9qh5H+CspfaWA1G7X3KijypHs7PaAzoJ630BzJveyPYwrp0mh8NyiVgHhZvQYWzG8koEZmO6qNzuBWDTvW9/iF6wZyTxDZtq9Du42Z/wBwSNfGNKkKq8TaBcdBijQ/FpRsmPnnGlzoLP2Pn4CNuS6CCKhgPn1yP6m4O2z96XCZj9Me6vfdlOMh8S+JnykpJ29uzHoedEPjcvCz+Mm5dcF8RDB4VJMGg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 548F61817261; Sat, 20 Sep 2025 14:01:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 08/23] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Sat, 20 Sep 2025 16:01:09 +0200
Message-ID: <20250920140124.63046-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o3u7CCR8NAtDuWC5ymQf3UtFwD8cH3bs
X-Proofpoint-GUID: o3u7CCR8NAtDuWC5ymQf3UtFwD8cH3bs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfXyVPhRy0mwR0y
 e5R/zfR8jzzR8mEtuqqlGlwZ0LSX+tKNgpxBnL1/YVFDDro0LkflYEGQRcxqCAOCUsQnG4/zMDo
 D6/aJkpWGDQkpe/eXP9KgDpl0jyOyyb/ZaAMvnu8tHyjWhLS7pNVcrxNffO4B5iyQoiv+h7nuyv
 akRLoN0ueC9Us3EcfD6MC4kj0ZFRPhzamRmervbltMDIT/YOIPauELW3Q6Ym5nRU354/PnpsXCS
 W2TFLPGV0BjC2E5o7RqN0GmMbCTpwbzJzWYP6CDReW/nDyXG6C6ANtWIUwRRTejtuIBnu0YeA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1030 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABsWmkZRyh+Oq6DMHUgSKM9+XQNVd17uzOMrcC6bpCYw1DQe/lDtYZd0jy8ElzQUkjd48E9voKYSn57K5YEXBczx5fSQlFXI+JgaRF5hO4ZXepeZq9tJpiV0xDgKFfFPtGIDG00s6qJjLh2a9BkQPDHpzYzbeFB8DzGm57lhvDPb6bRU+ci9xid7l+CO2W748k1IkmHiHvokfHE/Hxn+vgfEefh4bjKoyzVn/Vs+Bh1zKm9rJdAECgtQd0c1NwzRhT25eJmXOAU7CBWqtdSczgWD2erL/n/i3o0yYy8WkZDN4CJG/H7PjrOA6xERipimHdpBNE+IwNDEhYmn0IYi9/gBVQPE/KnWVIOpawQbk81QCG/q79NtWMFOvM88se8kUPOWfKcej2jBzoomlSqurAhcuDfL1Wp8Fn2CsBCwIE8fYLowUr4fnJ8nOlWJ9XngvtACLZzd4xuKUvM1Mk9IvLwvwdzyh35NCL4Xj3mn1L3/QZJxRbqTCYJIG5KfkL8H2dWjnHtPhNza+4HYPrawJ3x4DV3q77dhD2bN3wnoEHmifv2eQgJybMtbhODtIF2k5qmnYtD+Ctyqj/y64MtMRkcEeIBGBQn7GIyxj6Twcb1IFLBfaojzLdZXwAadSbDHfvG3mAk/2RD4W+PZiHa+PB8LmrEBWisEwtCQuj27gPWJ+qEAn9jJpxTKYfl8HVYqNplWGsksemCuEMYEETJspmC6k+x506dTI9YgOWVvxU4JrILHxuu+c9Q29SqscLu3du65Lhd7HvGsLRTqMgcJDUenqL2whLRp4MQ6+sN5p2UrAUPKygNWLY/w8ZTJDAjM0WuyhCIrdjvZ0M5x55+PoQKiV90aZ4WknZcUq6EAEOKneaMcKUIl2vPJTxV/iWsAlLipGPjmRrGN6ZzA==
Received-SPF: pass client-ip=57.103.86.224;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 95664a1df7..c0ff6cacb8 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -123,7 +123,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 7a7c607e0a..73b9f7c119 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)



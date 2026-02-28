Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4896FD0047
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUb-0002VQ-K1; Sat, 28 Feb 2026 17:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUa-0002UC-7c
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:56 -0500
Received: from qs-2004c-snip4-11.eps.apple.com ([57.103.84.33]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUY-0005ni-1D
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:55 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 B8632180011E; Sat, 28 Feb 2026 22:08:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316533; x=1774908533;
 bh=Ey38obQgB/4OZtOjl/rhIH61RioqpiOULYFmJqpqNgs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=a57dWPgAcMR7b585XLGCCELI3/oUqq1vOlW5L3Hj0LmCIk+nP8+a8AzUCno/KUJFBQPNT9iJPYhkuxIaF1kucreSHZn5j931/pA7t9krjHax4YgnoRVwYBbSEyFgqvAXWQIwzbihbMRM4TPdLDgeM2j/lHp62VahKdz6VLtvyd/8jVs5tguaeYPWgbGWZAza5DwD42Ibd7Nb7R/HQxv4wvAmWKzxwRLEs33kXdehIcfLAqZh3j+mrUEf+RqunWNGoJMBqqJnTld9bt3u9H0fy6byl+c1eCBwkjIOLi0vNuIZ3mYa3k+jRlvgegSpFUiGo5Tu0HpoKt4rnpOjBe4udg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 EE50F1800385; Sat, 28 Feb 2026 22:08:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v11 06/12] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Sat, 28 Feb 2026 23:08:31 +0100
Message-ID: <20260228220837.35275-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MKZtWcZl c=1 sm=1 tr=0 ts=69a36773
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=PzQS8Z__MZ2uSZov3vkA:9
X-Proofpoint-GUID: UGeJW5jBQj5s7_wykjPGQQptlZDtERhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfX8SSUcE/N/td/
 OtmijG7/Olk3sJM72V8cZT62VovMu38reF0YcvRsJz9YdBC7PjuRJViQKvrLcrYyez7JblrXwe+
 fUZr/SRgpqN/5zXf5Faz1mPnWFxt3q+WColbFk4AGJuOX/JSNPIl8L0A5uCRHCQ3+bBuskwkEXi
 Kfz4bqBnFsmyO3/buqkikAMso3D7rkK5tkK6nL8H5eSpbGBkTduoa/vKWREKeo7QczzcA4/S0cP
 HjFR9ljuk5Uy+WEMd3E6KbIONmF3WYi55QdSkJsesw0LyeCHgczQWOZSlop911EQS1FBCXLGZr5
 PIwCjiKnSj+Bo61j0Y2tecuRyj2EMNmhJA2zbAlWntk4rQFAkr3b3w7b3Q/wHY=
X-Proofpoint-ORIG-GUID: UGeJW5jBQj5s7_wykjPGQQptlZDtERhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=875
 malwarescore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1030 bulkscore=0 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAABlRIcIlsQ8OqYKsGTo6K+96yIfi1T7Re4Lcs3Fx6GaOaFlYzCbGkAL2rLRMrXSP0D2OCJDrvARDxrgBEotR7DR2sNn7FAqEaoT4hfrJBAatGoN//9ZbmcY2cWD+8XJOS7oD7HNhTsLsGXDLajTEbPKZurhV7OHQ1Xiy8kXFZjh8L6GO2xVNsy4qsbIW5LKQtsZlQL+5NTQtrA47vSXFRrgxEhCw6JawvvHFVEI3c7OXzVYVgO9ZNL/hYoq27ElKESeRd45ofYyuSgnr2v6Vcx/7Tp4SH81fSSREAQTcMNHT2bxHQd1fvjsJne5UHPKWoDaqnyFB7NHFUzkEKRdJloSbQzhM0p8vcVc0yI+6bWulXCdEp3Gpu7fRKj8OakJS1RWq3K15zmmEpflCEpTsuTVBMLlWvhcuSDkIjXWmp4ljl9OQvBEjmmWrg/p5FZiS0iBki0LDMngmPjP9CuEUgSklEYlY0jdqDjik97A8KE14AXjKBK2oJxwNPVxBEMtK4yE8LrfzZN6lMfxEizN2cyzOQFDeCtain8M4G1POPtE9yoQApeq1tlB7L5UYto790AoJ5kqPi+tfQu3dZu7G4RRFafVZljwhCr3gMfY+xcD98mmYGSbEV7ZfEWQmWBm42rlwatXWpalXuPbvvoV0e2KhIsoqzM7dodfkzZfB0oQHyeMpQ370Mv+KBJCvIMGENwFdEPAeSY7UixWGCtifpqMBcO2JEz
Received-SPF: pass client-ip=57.103.84.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a80c5f8384..e0a51faf28 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2052,7 +2052,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
     switch (exit->reason) {
     case HV_EXIT_REASON_EXCEPTION:
-        hvf_sync_vtimer(cpu);
+        if (!hvf_irqchip_in_kernel()) {
+            hvf_sync_vtimer(cpu);
+        }
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
-- 
2.50.1 (Apple Git-155)



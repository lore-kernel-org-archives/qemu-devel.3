Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0A7D3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFKB-0004fG-1l; Wed, 14 Jan 2026 23:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK8-0004aW-KJ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:08 -0500
Received: from p-west3-cluster2-host1-snip4-6.eps.apple.com ([57.103.74.109]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK7-000647-6M
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:08 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 1F0D918000BB; Thu, 15 Jan 2026 04:51:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=wcTrG1zEwPBlVwGhcRWu/pgOEGkKr41Ks8EjMTXYUlQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Kppwl4lcsEt3V7kpHhMJEZJXlh1hZW1XHEWSsiWx1+4i3WkeypKMfWgeBSPVKEgSfzazu6apEJwHy6zizf44UN2cA1TVfiRPaOPXt5/hKviZ8izbrCIrMirvEMT1R+pxtTigMs1/tLima+J/xVJU7pv7bWrz1saUCZNrTr1773Ukff6mLlbwcESKmGxHw/qHyDorhqdC2Pvx6KONHRk3vazc0Z91r/e31zi6MkXep7WmHEPjomTasyWQhHRlsKjugs3KGLJOcvq4ojg5fkUhXjxfsZ0+dzrD7QOznGYvLDCo4fFjxyHSpCwHr4Y1hLA+svWDBr8HYdPZSBsxrnPaNw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 092E5180011B; Thu, 15 Jan 2026 04:51:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v7 06/10] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Thu, 15 Jan 2026 05:50:38 +0100
Message-ID: <20260115045042.70086-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A61qsTdmfJROcvMgHVaiTP9rOcbEHjf4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfXzbZ4rcs1Sa5C
 05v1W+mCffP4jB4Vr3nvN4ahb0c75dJNZqMLrb5ER5Q9sxxEOw7MebNtRGwSKlhXys3UjqCh5su
 bebpKH/0Pp42SuM8SdAiFAh79KjvSasByjTZghcgOr1pguDd70v0/ZKRfC6PjxdODpjX0k5zBxj
 vFEbOIQkQeMPrfUoMFK9P4B8Sl7k4Lp6zaZLosGqFuVLQSLVGhr5SjR1gIioXMgRZP3gv2HaFnd
 Ss/hWdk1/ZavaJKM6WdfI8DlJQQqQNWfE3ZQpNj26eXQQJMg2ObR8b+VKAFQlarS5cy5OBUYjBQ
 2vwsu4H7ZAlhW5R4/hS
X-Authority-Info: v=2.4 cv=ctyWUl4i c=1 sm=1 tr=0 ts=69687238
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PzQS8Z__MZ2uSZov3vkA:9
X-Proofpoint-ORIG-GUID: A61qsTdmfJROcvMgHVaiTP9rOcbEHjf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 adultscore=0 mlxlogscore=855 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABBhEFddohb3QJMzSafiGwSys/jFNOQ5H9H/9wJWK+XDF6Lwf/Z9Isxtw6UrEIAPrcEOiuZxSKxYW6ajn3SBQhM5RLszEekM07xvH90p0i5DWqmOetQGRAIX7JRSRIAExtMFzTO1BKq1U2UPyatOOWt3sk1tsmP1dGcbh/7BrvU2OgqSS6WoxngGj/t5h38mBI+sxcHleuqwvtH5dnIO/eoFm+HuFlc1Xw3oMX7Y4HOFnNezV7sEX5V3owylGRsvMFU0P9I8TMKHvVDYALPmv+dNVBEWKTxMMUmU7tnma3eZtm+0H12jvlbl/mNJX2y8+4+nZlaJ/MmyYxIgwwpkrzvph+2z3+uiUxMdJOCVVWFpjuYZL2as0/oBSyE6j2FX6ksw51NtKeCMVvam8MigBbJRTCBONumRIRiJzo2aKv5ZTaz+8qRakQEc3+vkKFHIK8+kmDXDSFD6kbFAdyG2BxhMCck1NDEadxE+GjpAn4g21VsNyxKmvCY8HqziKiLzFSltcK132URKJOHtpeKRY8a3ZL0OI0r49t+f3Hujtrpu3RA309HkSC0lkT2s+fm5476vYDmDtHkOeBp1uNOZ/JrhuXd1lHVdJ7aCHZn6DIuWnsev8p0VOy+lLLdC1SLXMAgMGzaOd6UqmPe2R/olBTbtojrpIivYYSg+2XA7pvabStxNB6I42GTzJBqobFhwiLducSSPLfjwUvDUs=
Received-SPF: pass client-ip=57.103.74.109;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index fdfc8497b1..2c22025d88 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2053,7 +2053,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
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



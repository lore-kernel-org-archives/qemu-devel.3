Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71483C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjm-0000GF-To; Wed, 21 Jan 2026 08:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjD-0008Se-Pq
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:38 -0500
Received: from p-west3-cluster6-host6-snip4-6.eps.apple.com ([57.103.75.119]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjC-0007Gv-3y
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:35 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 4F18E18000AE; Wed, 21 Jan 2026 13:58:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003912; x=1771595912;
 bh=hHN2UeQWP0BPy/RoDgg0xFolpH6ntsl4DoNiOYWCW3w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Qkqtx68Qqa0MyBZ+d843vce51ZVs/Fv1dINLiS93JLNx1h15yluBGBfmzmzsyfv2cbhBY+sXHF2fQ/2ToxfzR20BR7svlgIVKZSTlV9R10cvP9z+sUpJJoEaGDNxAnb0CBmfgCzz7eDJQOuyEWA9L/Nlx1gfgL74Uf7vLT7QnO6WLSbHmB5vSVzZH0OIJ4MB+gIKQwhMvTyH9xu7laCCsoDFv/G+SPYNTB9L0B65w0T1qvsMZWTfj8xG/01VfeL51UNBd1n1jnSwM+xIkzPrf1IgROOpAaYvgpiwOP/PAdcmBbc9z9eCYAix+0Xh8ZIUyCpod4e2OsHIpkv5JU6O0g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 71B0F1801C41; Wed, 21 Jan 2026 13:58:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v8 05/11] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Wed, 21 Jan 2026 14:58:10 +0100
Message-ID: <20260121135816.21258-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=M59A6iws c=1 sm=1 tr=0 ts=6970db88
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PzQS8Z__MZ2uSZov3vkA:9
X-Proofpoint-GUID: uYypuVc9x4UlogP2LWLCWRB_OyPdtr7r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfXx/vN0O2vXAhC
 wiw1K5EdFfNvLkyD19LCnhaM7iu596zplabnc8BuyY3dVQbSNI3K/1h/OV+yQwEWuZkA4jRmNeD
 5pTapjGJD4P/6XOd7A2WMJbQmKeoT+PE1F39vlO3cCQDmrvHDyi3p/qN1WUui6fb7rzekdty7iA
 yuQi15jCGwwpIkG4rwhDJPINjbhwuJ0fs5ydzMOt9boNjvlwGq/9B00jqAmBIWS8V8LaaQVzvJE
 uSqN31HwakhwzC86JqHKZE6zbpx8lKK/g0QlgfX/qoOg/LK6sSHOp5JqVcKAruBA/4FJPRrTrDT
 wnwoOyfzjB2p82cxJBe
X-Proofpoint-ORIG-GUID: uYypuVc9x4UlogP2LWLCWRB_OyPdtr7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=854
 malwarescore=0 clxscore=1030 bulkscore=0
 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210118
X-JNJ: AAAAAAABwU9W6lRVnHT3aWZ9zQryRsgjyTA2f7tf0OCiEmPVpzl0Ikk5cM61zh2cpkJb+5/7XuLhxUw1NRvXw6plOYBDk4i5GTqnBWqndlidwwEm/HVa5vAWdRd64cCcOqQ7qqBbgkxR+EX6wD/GxBS8CQlTLobE7ccnDuttmg+uq+R9Gu572Z8eJuxvl0l8MYK+Uun87TSrSIJjJP0K+e2/oRvgOjSnP8zlhvstzyQytee7o+OF1ijp+Vh256mWZkdu7k+YsQR0wUrCyo5ddes8asvPafcXyaJQmiegtNlxnacELEGryX/lNxB9T5uHDc/C2vZsxDd+lSPazOEt66wKHxUfiL7SVl/WZbxGuyU7yfSQJePmCPMsG6slFZ6NAstMcdzeFAKOenM6xEHSVUtxw82/gC8qF6/w4OHUdrpVH1vS5fd7TgGPOWCO2XbjltKcNAZnHLYbaEy6r6qCNaqq8S8QtMB203VfMaKoEzoKaMSOM7yAtClW+DXtquMybAoBvf8+mM2UjwAjcBNxL9shC+73IMuaTWkvKc2deBODbbapPZbDL5TiGSP8Z895W9uVr5hBwVDXjD+u1fpS3DpaeAIiSPPS053Xg6W5+UM+owwZrMuC6oKgQR006XYS7sJj1Po94JlQiqesjSBCKp2kzqGq71y+PiqS2Ate97lWw6Vs4TVIoM7Kz31d2i2bYuSFBlC9Tt2H1IK7KDWFK1A=
Received-SPF: pass client-ip=57.103.75.119;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index fe9b63bc76..f6313d9afd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2037,7 +2037,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
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



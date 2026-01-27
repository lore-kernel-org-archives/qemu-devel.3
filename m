Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C32D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4y-0000tt-9i; Tue, 27 Jan 2026 13:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4i-0000WP-Go
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:08 -0500
Received: from p-east2-cluster6-host8-snip4-7.eps.apple.com ([57.103.76.168]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4e-0007dE-TZ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:03 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 E390E180066A; Tue, 27 Jan 2026 18:45:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539542; x=1772131542;
 bh=bTIsRao3N9RI3/RDN6YvSt0GamrXJ2tFOWzM4Mi+H8s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LvnkMQt4j9TRtQUqBplPrECFzvKkhs9gjJADD+BcPfz12z3j89taKclMxi36xIPMp8FKCI9tBUHe/vxG41m+Dlwezyp18jhVi7rwL5Rd/VQtdyWzD9mCXk9fr2NECwdWjXBbZROYvPJTuGmxXmAErISKxW/pkSzkLjXTbA4XQLXX9vwZIIU5ttHhNuNvEpqzmGQmSYIzcfptoJH+14eMSxT+dC5jWHbMlQ4uAcxpFAmDPBgdOWEkltRaYSQRNhbf7W04KJTRRbRcQkvqq4zlKKOMN2AkuZaYlo4DVfh9sEyZjQM0fQY8hymNUhb5kkrzwUCmx7iz0CHG7x/d7BsyYg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 A9E10180012D; Tue, 27 Jan 2026 18:45:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 06/12] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Tue, 27 Jan 2026 19:45:17 +0100
Message-ID: <20260127184523.5357-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UyzNVOiijmdfsq49cgyhYgTMe4Eyi-7k
X-Proofpoint-GUID: UyzNVOiijmdfsq49cgyhYgTMe4Eyi-7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX6wHLVDoWKEjr
 OXdzMKDZg0bYKxtUkBLas3rbAlvgK2FiwBi+3qnbDed0D6ImdbZ77dZGvvK/AVUNLTnQCzbg8Re
 JFVTQhqCsOpZeLcd7NOgVcR2FP6Zqd/v301TucVU3cuPfOiH38LxrWXPzmW1pm3w7qDzrWEi4Rh
 oGOKPYPdUeUnauPg/UJTeEwWyP99dWkYJ3WE2AMi7+rjzjGw1VWDubGfavL/1WVFvQS6P/APDXE
 tN4ivLnms9B+oBFY/DCK8FzNy89A/DVUf/gEygAFJUoHM2ZooQtObBPANmpoZ8LFPxMfNQ1Tyit
 soXiwuUaZnwELjslvyleEXtWbggLNe5X4fDGZM+T7IUKrWwlLJbl75q5IS6ByY=
X-Authority-Info-Out: v=2.4 cv=ZYoQ98VA c=1 sm=1 tr=0 ts=697907d4
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PzQS8Z__MZ2uSZov3vkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 mlxlogscore=892 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABdYwbd4l//7jUjjIljZ48CqjpN5v2KIxfV/4vF9JU75jL7sEFmqcI8Wqi91YEi3+w5G0gAkA2h6Yn/GRZoRhx3r+eFAV1QabqJ0SlyIuU5IZfV717605HiYp6/d78ZV1KdvwzZegUrBfmC4qC1ncut8IyCq6n1K7Grw7XoNqVRnZkzyho0AnmSwCbjfCGrxok313AkFvgzzRH6V0fEnhlmOCVeSAiTyH4FAGSzQ8XS/pNJAWRmH4mcOB3/bq11bT1XZjC3j3HfKIWi+/Yt2FBjYrclePga+s9zGbwF2urbhC99d9OxX5I8+n4QLq12XExHh8HXRvdBhjyVfGBnBa3Bb5vfoVImz50snNIsQcEgeM96RxAVzJ/zpQoPqQLw5/Ixzue2aBBR1AXlazlIlOdQZVR/VQcRyLtUd87zKW6ryZPEZzKWDov7K6NgWycU1oLw4/Ss0j4hZxhE30NJrHyc1H5+Ld0ydYMgA28fckgJRLCboxCl25dNVOc9QCuqNT1XKEHDKiHcfhIfQ8B3seLej315+gWXlUWDICAZ9jEg9Z0KXs4TCqFxBClVV0uPYekMGRarVjMMGGxIjP4/luW79iHmYFf7WaWKic1MhJAVy4rfQErb9Jbx10j9ipo8O8XM/e26mZLbghP9Ma82m/jqkb1XIsU4DQlAP7log76nqQ3jkwQmgD9PQdnZT4dHb/ih6DJlQ1Sr5VL69NrVSUR8YO1
Received-SPF: pass client-ip=57.103.76.168;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
index e239f47e15..9dcdff685b 100644
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



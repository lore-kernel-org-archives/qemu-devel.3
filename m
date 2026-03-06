Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA40F0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUop-0001Uc-NL; Fri, 06 Mar 2026 08:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoZ-0001Fg-Il
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:59 -0500
Received: from p-west2-cluster2-host6-snip4-4.eps.apple.com ([57.103.68.237]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoW-00075a-5c
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:59 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 2766D1800189; Fri,  6 Mar 2026 13:01:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802113; x=1775394113;
 bh=fl9HhiIXNnbsmPaClQmnmL8x+KVOWc3J1o8nJMT7VQQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=LlPwtNbV8DyxiN5OyT2ho7dVf3QCg5Pgq0qTRSPvR1A88TaBQFh1x96v9XCAvEPh+NAwtVUxT+zQNrVZTTqP97wse5/pHYZ8HMOTpIpC6oujEdpfuQzOxfLXhu01joAbEZSbD4jVkHosB7QXu4U7l3pWI+18h9QZGp5N8hpS6SWnAyWZqCRo2QLV5bpo5UDJJdQIw/Vnzts7YbH0uM3EdWfJOEMvHGrpS4Srvo+tSTl53Ez/MAc5YsCdNsdam/q9Btk4ekZws0R4Qmi7psCdh9QazMy6Oynn7Mm5zhtz28Fr29xxgBLcxtzx9uEMuUJ0GquODCzHns+PY50Wag3goQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 9B2E9180047C; Fri,  6 Mar 2026 13:01:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 10/17] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Fri,  6 Mar 2026 14:01:00 +0100
Message-ID: <20260306130107.35359-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XO0ruPb5AxxeKIWat6Rk7S3reB4mo98V
X-Proofpoint-ORIG-GUID: XO0ruPb5AxxeKIWat6Rk7S3reB4mo98V
X-Authority-Info-Out: v=2.4 cv=K/gv3iWI c=1 sm=1 tr=0 ts=69aad040
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PzQS8Z__MZ2uSZov3vkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfXy8ThkzQoIj4A
 i92fAiqbz/eirtA731PfBw37x57YV+aCUsRoVc0p9W3ZdjuJMZH4eJkbQgmyIjMbGbCnuj0Px3Q
 9Z8X4qxJ+XL72SFZ9fyCq1FYC+3Ow6pkA+zUlwt5He42/iFnfgRc9XXJ0je295tMGLjM0QeIW0M
 lq4+IRmk7yxJXXhcDfq9GG6mitwNLqPd5hNZJ7xvrXBZtQIOX3vuWcNw9rswOZ53ICtQfnZOxnm
 N6wFfd91a7nZedVY9h2zShD8h9VaxW17T5zQ/+9/5C7nMhPIVRWWxHilkPgsq7piG00Us97yYxy
 C4pJH9p9/r3GvKC9009ByDXuuSu0Ul/RXdAdAyCg0B0EKtQEWBqpd5W1VOKhUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=905 bulkscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABe8RSijmTZ82Y0I8QkDZvIBX/cv+AcHpuFaHfcY+ckIpPSSU12Po2Gfjt7oEIzCg5AdHMToGb9Jr+cyv0CXxXZfDdFHcdZ9QzyscHPzpNAIDS1fbZI1SI+j1zs7+QZOdwFaJxVfMkBiv6P2jq5Cq/uepAJ3oKmYabcjPYxgC6Ov1KTHphZzIZGoK0l2Cl1TQyeJtud/qLbdz55w5qJo0VJ8C0Op6h0tqTbkoylY8/6ArBmTOH8cXqKGdAUW/Rw0T5rv3F9PlL7AXADEi+yfoDJjbF7Jw5RQdf1LB2Usf1ugbGWiRoP5pEeCJ4ZEluo8bxdEiOO9wnIg/WsFv+8ar9ppErpEAnXzTKLTEiLQluaGKsYlvQol1OGBbQh0zwGgkitSRgmVi0m0qU80bVuXb8EjQSAdlzmh36Xhnxz/B0F58fAWRxlYiZDdEjxEapv0ijvJG0Sq7pg8H1bn9IklZCA7QcUpDuliAo8g+dmkCbKwXZGzcZrZPMPXH+Z7P/IqTfh7qqJCiQgPPA5Syfq9DDbBdSuH2bv0mz4ubeiKiASWqOd82LPNDT9SWSAvbY3q/y3Dj7nMZkIY9ESVjKFCgBziDACJ7L4iTZAGi1ilNraGzzciQOY9Sq3u298lTaeDwrx2SXHcJK6Z5uT7siDI9v2Mx3Lodawg38lJPRYKOKAoqwMNG3qTvnsixn3qsGZ5jQcWQFCczbOryMtVk/DjELI6zuF7D8zp1oGONp4sHLFKr5iNQCHoQmrq9+f2NcLkIMtFTEe+jautrLU5cURCpFWLY1IUAZUjjkG7cQqwk=
Received-SPF: pass client-ip=57.103.68.237;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 35b2de7b7a..8363e10eff 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2356,7 +2356,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
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



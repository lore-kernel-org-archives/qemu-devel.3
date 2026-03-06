Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD99BFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqB-0004Fr-5J; Fri, 06 Mar 2026 11:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXq6-0004Cp-4V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:46 -0500
Received: from p-west3-cluster3-host6-snip4-10.eps.apple.com ([57.103.72.151]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXq4-00079r-LC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:45 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 361A018007A4; Fri,  6 Mar 2026 16:15:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813743; x=1775405743;
 bh=JY5TDaxmjc4xPHicBsUqy4bP+LreF1tQd+t0+vzZ5/Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Uf+ysLBskLxcfP1ltdcRlA44ehczyUvC+93Umkotq6M+L5306jedAX+VUuQuOvnaGcy98jwn2Sc7vQv261rN4r9LyUNkZmOtlNxeRvO7BSBQAvPzRVZhbCS0/ogwknaOL4A/n/PZlCi4xnfwkaAoZFWDEFpgX62stLI4vhSs7uT79Qh0G7I2W3h2S0DoUP1vj127jh3rpGQ/oKGM3YmWuJ+SXplmC50ZKX/K7i69USaW2KxS5wwwol38xhKE3d2rpmGGcHvP6I2wFY6j1USEL5TYzGgCHSxInw82gdyNdRzsZMrspF3jM+rQAO+Ntg6EFPedg/RJhr3YiFXhOlOCCA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 7EDAF18007A0; Fri,  6 Mar 2026 16:15:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 10/17] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Fri,  6 Mar 2026 17:15:02 +0100
Message-ID: <20260306161509.79712-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MrZTimDh1jpOThXNPdh-f7zG7wlWY2d8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX9NHCzQY0EBGk
 4YyU5XvV4rHV7N6PenvtSnesNlygQ5UKujNX9A+DBpq2KDKt0bojwy37MMcpBpJwMBfPZKfuIr+
 +tnR+X1tYkk3kHlxT5ieQ8htGkI8xswsRkRYM0Q5POKmcB6PnW8MPLtQsR9jy63tU3mtwtCtQHn
 lhUtIQTQkVFMS3Aqc3+82966ei6epbgbK6V/lOEq/igti52NMMbjbAnSjZgunsiiwb121Ao2Eew
 Lhd0yklQp1PhLarqKMjrDTpdgwhFffvwCw8o2GawsuzdUWYnEiA6Akl0jT6lvwZf6V2+StPoRGP
 Py3apTIeZWuzBio390P3Qpjq5lNwS0kBq0jL6wCZ9jw3k5x6sxPtli6cZOf2b8=
X-Authority-Info-Out: v=2.4 cv=RKC+3oi+ c=1 sm=1 tr=0 ts=69aafdaf
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=PzQS8Z__MZ2uSZov3vkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MrZTimDh1jpOThXNPdh-f7zG7wlWY2d8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=905 bulkscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAAB7AqTt5P/fAHtep6kZm2i+PzuTq3DaN6NnZB+GLYq9ftw6NbHOKeJzZ4Diude0jBqoRmWm3SYseVRDLbJ3dwvGpJD+lsfpIMYF6CJIcSf/4ONG1yH/CWQo7YEAT5noHt7mWHR63JOmqIr9JVnlZ7fgZ3A5hVy5+Tc65eYfIBSa12dv6mlbpANhsLjKxtU9ENzfhuHS61TyNNHK9YRKXGZTdBcwY3qN5JODWchIt4RCcT6RBBHsnrg9QwZ7VF0SlkliTT30YeODJuMQJP77CIyFPyNmpb2trf7/hBeTwuV3d77O4OqjpqghBnRYEMvbQgkJxBUzGLynKDpMDtlkYDqqXu/Lzz9x22oQbXDsp4iSW/wFVdaHL6V4Fnupitb9RQXRAyL2XYQ0HToZRbsbewj3nKzIXzHbkZJtzrhHiGFE3RrmTULmMUH01rjS7zpVCfsxdHUiiGus1xdYioL+dZXN4M/iT5SkrgasnnTLsEc6vi35NMCRhik+StA+MgqAllBmeUOZnVJCRd3jcHiMCEbS9LfyWrteOqxujQQDGSgh9P86uKuQQHQRlwljlIuFxRUO7R6Y6YvIbxEJTsEnw7JE5Alir5tBbQ3BQGjE+WFjKYZ7dVO4TeInq5RwDwpzC3VqMMQwYr9DyYyYkK3HWzDxQoKnwkJC/JinYLJGySrzyIOsdz+vwbQm6X5EgAUIVXby+B+FH69S2jFlpLCKkhl3RH13ce/59ZRpGKRwJg92qLz9b9eM2n0BBaouavLhIPGd+f3Yse8F2MEAJk46FpKCdhnpqM9odk=
Received-SPF: pass client-ip=57.103.72.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
index e4ff14e55f..f06a3088f8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2365,7 +2365,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
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



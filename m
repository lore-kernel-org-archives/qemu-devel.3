Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66485F55105
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0Q-0001t1-Ke; Sat, 07 Mar 2026 13:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0N-0001mn-45
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:59 -0500
Received: from p-west2-cluster4-host8-snip4-8.eps.apple.com ([57.103.69.229]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0L-0003WR-5X
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:58 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 BD593180013A; Sat,  7 Mar 2026 18:03:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906636; x=1775498636;
 bh=CFkZ1ydlJzWs77CaHK66tAU5BFl4876/9Mp4Lq9BU3s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=XvzUNXUFOiA9P9fpbGu5ETVuPVd1ZsrgXdjz99Irr4wUmmV+sb3ea85xophR6owqnmoLXrfjRSJ3R8LIO20Z9lfGcbFsui+g3O2gwi48CujtcRgDyXE7MXE1RjasHlx8dQ3fgXmVLJEkiczxmvzDEY9Vh6+N+coiKBXZNGPyXunZeCGHWiernh1kdyeRmrh8OZ8Y7w7C/qIp3/3ID6LpsvtFQdNwTfXYiKBWjrllohAL6LkHlIFKcgqOOfkj9ctD7wbiTvFR+MuwInJIvl0QziuoVO9FSsS0+mDK5SZ0WERzbAhR5oHCSuHHDH2mhgJ6o3qzjMqIqj7OL8VNXaNSGA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 72CB2180062B; Sat,  7 Mar 2026 18:03:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 08/13] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Sat,  7 Mar 2026 19:03:25 +0100
Message-ID: <20260307180330.75168-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AZa83nXG c=1 sm=1 tr=0 ts=69ac688b
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=DEZpVyLLCdwXg5o-P5sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RkI_bluFi3O-vC_S7DyXI00d0PwkR5ik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfX0T1PB2QeVIta
 tuImiv751yLkdDin7XOOIFtZMCHOU6B0Wvep3WSi8LsuB2tQKEt9KTr6LBO5eN/+Jny/pNIxsGA
 HQvDL2qVX7C3BlEoN/cvfI287wATAu64Rcn1UNxQmBOW0jzBFRkwKTNz3CmDtZUeSqYY5ThQv/T
 y9fkECbc3vNxU0h0VbGwKl5g7NI1rrtt0FJ6x4yQQDuFtkty4nxlDqNJSszFBFpS9rKBx/+VbE0
 uwf9OxKdv/EGwQtvhh/CN8mHw8RJGH/poWSI1GZlTH0JJ3bjQFcpRzH5/tm0AlYLk7ROf6DEUj6
 9tyyoYRDXsRXEcRmhUaxHWgZNvI/1vpVLT6GkhM6qQMwzb52cBEZ2vJvAK+nYk=
X-Proofpoint-GUID: RkI_bluFi3O-vC_S7DyXI00d0PwkR5ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=582 lowpriorityscore=0 bulkscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABbuTxJycPRYtXRtUhjB7MxEUXS0zGl5CzYvH5SqFhiHHHhW3yVRxryu+xq6QMrI4md2aoS1TlKUBYxiIDehcaNTv+8IyK3QTlEwqGs9QPsSMELuP4HrvB5uAcR8BeHyYgtxprDQPBiZPLxJB1SDAx85UUTEeatzBiSmq+Zrlsgu28dgWw08Pt5iMeDrcGdF28/peN/9MIEXGcZPgE4NSp2k5z7cYZF5PwT78FGpZ8mFXxkLgJcrDEBMgpSZfXebPNhxV5mXWvOmHlgaHggaCn/6aVe9NX+Hp7At1SJkrE/F2YfiOpQKHPcmRFtHLuwyAIiConGVEh8xJrZprsuQCcR5N2wmkh9+4I3KFXVFtA0Hrm3wedx24NvKoN771ZBiDDykxB8Z2ppbCw5sZsIFExiVtTUCnYEkQrTatdTizR/j32IkO5CIPDFM0s2V+T0iOBgLzAur6mDQxWeK1FWWUwh/Rat23JxoYF10L6mYejonTE9G5I4icrRBEMIZYOtdPxkiqx42iNjDeFQpl5v6zLou176rYAwH2pJd4XjiVurkZwPxnZC2XjfDpLDAVFXxABndDjJHk3ExhuPqZ5h7qI0rwMLIf8D8AzEXi+VXHkmzjnneQEXK4/Z5s0V437OHJx6TSyw+AcNc4x7glHNbhxgCcfdHCnHSpWVxnsOVVx++a0oZyhXr/4JV/MBrPez/As5GUe3ssVTI1x4FkY0P1HkGSLVj280E8QZ+V5GT35fNJXE9sYcV098IRppBd32/Ex
Received-SPF: pass client-ip=57.103.69.229;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 14c0c7f540..8c568d60bd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1145,6 +1145,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)



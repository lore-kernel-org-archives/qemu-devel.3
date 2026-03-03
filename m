Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97986EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWhN-0006Du-L6; Tue, 03 Mar 2026 15:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh8-00061C-SH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:22 -0500
Received: from p-east2-cluster6-host4-snip4-2.eps.apple.com ([57.103.76.143]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh6-0000kX-7r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:17 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 CA32318000BA; Tue,  3 Mar 2026 20:50:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571015; x=1775163015;
 bh=mLmxlRPFcwMxrG9myQtY85BdAdnRcI/En8EyLObKCOE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=H/x2Y5w+bVpX+/2kexXHdhGfuMYyW2d+5691OLGODzf8P6nwEHRqNUVevTt1vfw1nMUmTPBhY3dWRZODNFr4n8lfiKiHI624teGiUMzueHwjKQ4VuadFyUbCWKhhQn/Wm+x2eOKQQW9jZeg7PhdLdAm+xOF/dd6Ntzu2IoAnoL6qJkHI1lwjD0QHxYnkjGkLyutC1qMu0POHHWUdz8Rz5SCI/i0DVUBvyI5LD0CCAyqauBYFWe+Gq3aQokEVuLFuvDIE4SK+39ddIy9oOsD7DVzyOvBXZ+zXqU6A2O0JZHWqBRlBAq8w2u1Az6Y4OnihYwDWrL+/xiaoewNGjUjHMQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 42D0F180041F; Tue,  3 Mar 2026 20:50:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 4/9] whpx: i386: do not enable nested virt when
 kernel-irqchip=off
Date: Tue,  3 Mar 2026 21:49:54 +0100
Message-ID: <20260303204959.31156-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XQF0VD8i8cg5ptZQ7nl3TbZmGrjT-d_p
X-Proofpoint-ORIG-GUID: XQF0VD8i8cg5ptZQ7nl3TbZmGrjT-d_p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfXzUhIdxsdSmxS
 0LWceMtpO5ToV5z6ZW94NTN3DiaeTYrGwR9JvXukU23hNcnM3at4RauyYaUkcv4gso8vgDQ3K1z
 BEK3pHRQgqqflDdCEIbyQbsl2z0/JhWZwHVnF5jayHJEu4SLoj+4UDn+EEWzqTHu8dHyyWw8u0Z
 sb+u9SYqpYlOAKravLdEnqN/sn9V062LbJIVsDfD8B4sCOlcC+4bMeH+qbgdOtmERShTE6uEB+q
 OuIe16qicd6cUxagQ0LKr923tkAwAtPTMLlMFdzeOPvoPjuvbhYzvbBOANIpn3xR9d7XwxFbVDj
 5BZH5vSQ7kyXcX209We8KhkE7hOc3lo4OtosbU9hfc+03nlq/XmUcdEr+UChck=
X-Authority-Info-Out: v=2.4 cv=H4jWAuYi c=1 sm=1 tr=0 ts=69a74985
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eKpLbWQDCUPTAuIwU-0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=942
 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1030 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABu+YEBTdDFPdVQRImmPkY1UQKHlpqqj5MzYW9cLCwWVNIt6OjJe3LLDeN/iuY34IDt47+5RJAU4AOtubpqwP7wkaPNM1gq4YFuArb+JdUgoLLOL07E5NOzd1wjIrtCV0EVLFkOV939+jWvBxzvbtygUENGzdfYMubghzpHNVRpvrzwIqHIlQYgpD3eepAm2fozOERkTgNOU6HObf+wVRRszg642TJ0g8tc2zmFpHn1LRg659QPK5vQFE9Oadb6X6RrxKoQ0dEOqkELcUAXv31Aol5zaASUGhzHCJPJZGYCj/F6zWxYbTGksglq/HvlMjhxoXDZUuBWKlE5zsNSLJFYWx8KnsMmO8KTXutmG4bsJG+sz87BH7coR46Dx+yK0J9tdPoJFbdKLpuCOPmtp9Qv8KoAvoom9nLxVJJTQoFmFPTVNSE5WgTBj1x7H8tXyt/OSXTIylEb4Fkbn9YaLxbSGsE9nhWAWXrkdLMXHtQEfQL1CYxNXAa348254wrKl0PaMH1xopFPm6CKoZy55/bYy+81VBs372dr4IbmFhSJ579Uz/TnxuEPzQZ6q/htfdW0XL66rpQeg6PmpjKvtrY80SyGNZqZ7dKOQuvXsFwjelEKFJYdfrWGcSD9h/uCrTxnfMgj4uz+/WqODr85rVCa36Kczoa4I8GMx/jGQBMHcCR3OTOP5io7tVOdiM0jmMn8MMPcLBPQ/9qU14MIq8PMHTkbVt4wBx1YbRD6Lzrt0ocAaVqpv2KtAGyU5C/MLXkD7Cf6u0y4kNr
Received-SPF: pass client-ip=57.103.76.143;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

This combination is not allowed as of build 26300.7939 and results in:

qemu-system-x86_64.exe: WHPX: Failed to setup partition, hr=c0350005
qemu-system-x86_64.exe: failed to initialize whpx: Invalid argument

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8dd6f68ff9..4afcbbae25 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2147,7 +2147,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (processor_features.Bank1.NestedVirtSupport) {
+    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
         hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.50.1 (Apple Git-155)



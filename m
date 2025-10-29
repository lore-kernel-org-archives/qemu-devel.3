Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371BFCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6E-0004DF-HW; Wed, 29 Oct 2025 13:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA64-00044w-7h
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:32 -0400
Received: from p-east2-cluster4-host3-snip4-10.eps.apple.com ([57.103.78.141]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5Z-0003Vv-SM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:30 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 98D2B18270D2; Wed, 29 Oct 2025 17:35:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=QZTelCEJESaTGcpDgt/uLDUyv+A/CDP1F90Ud1CwiBg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=H8+rdblk0re5FLngKCPfmaE5Asyu83sQcar5AlNQLTqnaH4q+pmbu8cT+tDcZ8WMR9Gsb3gQxo1ji0KDXGXNXrx2VPGWMqzb7f8w5STPLuTElv3QqYbUdRfYWhZ2yfG2TxSozq1RINyYFaHEH5kRc5p2Qm8h7fpTCK+6SN2vZMbysYV57EWniltp8wZaj7i/VB+mFVZDA2MAg13NH4Cs4DeAyOVpxyqOIOO53UI1xbyX7nHvrxGeRZWgAc6xsrI6Ygjou9wn2/biiKfUE3uecXWsh6Eppg+bDDQWYgWzzM5q876Y32aqT1NsaJQbV+bhZzKMdm20kez1qaQ694Djag==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 4EF0E1822209; Wed, 29 Oct 2025 16:56:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 28/28] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Wed, 29 Oct 2025 17:55:10 +0100
Message-ID: <20251029165510.45824-29-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX7JksRuEiKHEO
 M8tYfBYjRUQEgv6n/xiu4k8DOLnnhcyGIXbqxLrxVTNZd5zx57rzuPWbOcHlftIL/uoRsIYMWkk
 litX59MaskxuQFn+tW1G5KGHIxUODmdAqEGa50bE8d3Zwu5bq67mTXFynfIGQEQ8k1HmB0X1Bcy
 rvHfkZRhmn56qYDXTF9xxv2WHY9NYvBFTElbHwRpZocFnycP+GVlwm2x8Y8GdMFOQ4HYv9rpAqS
 61Fx+NeIqlmaqeiQQz2DR3Q3D4M72iKcCuen/pvl9uG0H3q/qZQxrHw0z1epHDDJL2uM6lbls=
X-Proofpoint-GUID: mjhdJkluoe-umiJNuDIeslAvSBaqt9ud
X-Proofpoint-ORIG-GUID: mjhdJkluoe-umiJNuDIeslAvSBaqt9ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1030
 mlxlogscore=571 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABcysi5JB0a1mrR7KIauJyAJwdEmd6UmQV5Suxijiss3fvhaa219xPL9VeyjxHsiRdhoF1NsN/rx2to3AWFXDQYKjamTsd0LSBXULwAvpTEJy8cEYdhsHenMMVfFZ3ivmve9vaMhkRg5Mfr3b2Z9ZR6in/06SUQT7vjoflzGDUYRmV4lNckMicnLhOh2ZenKlvEMxBlyJuBgRzvYM7G21guvdu0fGzVASu3bSGZI1woigdrI9yvOEIXH5BrSSc1Y5WZoCroClTh0M9v91P3zggBg4UdURMXIiG19i5ieRbGiaj1Z+DCb77in7DCRDecJBGVH7YobvCl9SlNVjnECNIZj9Y4nBbyLHPju350pG9DMZqlBouTmnRVB7wtJprAdcgVaGua74nrGqJCizLIi2gMrNKH3psH+yGs/Yn6z4KOLT0AtJVwNHEDZS3r7jRey5Iopa5RxYbsVoBPeIuTRvpYh02m0jKBi4/ynKhA3OLypNvnz1SChUJ+DSPm9LDreuuXTY+CmF6K8xfJQzQql31VhKvlAI3XASs6rkpK1g2So6U1rsT0HnyTUrzxC8fBUwsLvuXLxI/9zr3Xr5kXfAd0gRnADGfTuYGVvJtgjpZcCvth0Kpwzu1Sh6JspXGWi68V5kH/0C5lIptSZ9xLtZd4dUGEOs6xxhWsN6m85X81FJuGx4L/4UCO+Pbide6D/QdPdSXfLCpYwqlJdoonVlzXrOHVA==
Received-SPF: pass client-ip=57.103.78.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This resets non-architectural state to allow for reboots to succeed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 90b4077b76..40918c025f 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -94,6 +94,8 @@ void whpx_apic_get(APICCommonState *s);
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
         WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
         UINT32 BufferSizeInBytes)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index ce1794952c..c558ab8613 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -497,6 +497,8 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
+            /* Partition-wide reset, to reset state for reboots to succeed. */
+            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
-- 
2.50.1 (Apple Git-155)



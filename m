Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D89EC1EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzBB-0001YN-N2; Thu, 05 Feb 2026 08:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzB9-0001Om-Ga
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:51 -0500
Received: from p-west2-cluster1-host8-snip4-6.eps.apple.com ([57.103.68.99]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzB7-0001mv-Lq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:51 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 D59501800159; Thu,  5 Feb 2026 13:13:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297227; x=1772889227;
 bh=+zW8Xnd3fSoP8tYABJv1S0adhsQ8kwT3yFXLBoRfW4c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A5KwV0bB1nk3XuYlacBJpi02jEKMtBb0SGBCIQPwMlLpDW7D+glN/gRC1tCruI2EPpuVEKeLHHJf5VIoX72G0AcJfO/iwJKjQUJ81Xq7L/8PSfHQUTh48rsMBd+HO+tB/xjnqhsqT12VkAXNfPVUHLsfYnWKpNR7ty5hlasvXyp+XX9pdKZHTLtK8emAjY7R5T/uPedZi86djERz9EhdKmtOQbYbyqhyg7hnQbOZQRkO1BUEF1AQ6jvJ7fJWRu9y0yf7s2IWltAdHyCBvppuN96PuZfIZGiyUZ4lpJ1IGcT1hutEzWNZnSiSWBX+aapA6b96VDQZQkCCMlWrPUUh6A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 03DDE18013BE; Thu,  5 Feb 2026 13:13:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 22/22] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Thu,  5 Feb 2026 14:11:51 +0100
Message-ID: <20260205131155.22780-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=69849789
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: c-VNL5zGSVrE7PXUqhK5lsLxqJIercCs
X-Proofpoint-GUID: c-VNL5zGSVrE7PXUqhK5lsLxqJIercCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX2W/8YM0kRGVq
 NPzhzXsxvNe4hiD4iI5ICdnf72x5060ZeJ3qvwukxPBEZ1JfpJLIBFc5BZNm0vwJ/WNIZH04STN
 1MEyy2nD0b2ljm1NMO8amNIJicDDZ3iu2CSkI/j1lDYLOiXRSlV3gT+NLasq9pSMFc3z3mXoYZm
 I6w/ZvdB0RvzT4mQWvrGmR89VkWuraMIboZ98D6JOCsPUfgZbt1iAh0rVwUxBCKT8KJd0fnggCQ
 JIbyFd0ntIrcfTR3xtHj4I7+ar8hfvfLiMjHtsyHZiAqiV7opvIzzO9410d0KO5jy1ExReEsc8Q
 bHLS1tvibt0Py41Uz11Vyxy65FOASPjfgzosd+qjx848OSLyzczaG2G8DlYKGw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 clxscore=1030 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABwxRYm4VQEWZ5ljWPmcfVCc7lrOBCaogUgGtYSe3HNDSwGbxtD97GEviO3psJgnD6LgQmjG5xGKSsx/DpF8N/TJC1e2rv8khmOjDv+LBEwmDKZjrB5b4Gpgc58YMfQZ+JweiaATQHcwkB0OuToZ4qQ+gfOYYha3kVPHQhkpxAc2HDFosrV2m9RJZeGNn5oweXDq0mdJBDYD6fURsKCg71Cfy9TmD8FBbd99uIoShYE9tVL1JSN8CbV558TtefoGdWruNXUrFzKiOynw4bfJ+UuA9jQ24ZgIM1GwJxDbY3LNEJC0JLz+IwzJ5DB50iLD2AhTQ+aESUqNqYbgV6Sc+DjV9pGWEM/aMx9K/0tC0nvubrpWutErG/evJS+8H3vJjhBgTaieTiAm9RLK1gD+fVw2iGngaUwniA3IqJiuy7jAgNWIXpytA38Uo0mCtiJb+E+gEMRnf2P1Dhwv8bVAudZDIgYdywR0CWXCe7k2XlKed5mTWnf9ZWeXZSHI3P6BrR1yrnBJDWo04F+y5EUSs5AcS3p/Q/5bTTXxCj7h9Sq3u082ozBnUOPs3h2oOKPAvvnKWwQMXraNT4uyRAPjhWkpqb3gA1Sb8mrtGN+ylKTJFVydHgmHV6gKDrLbq6uakuW1rtPACS35Gm2yy6e0lauYa14FtdSdGykcAf8HqEAlJadDXkN5M3gee6rOn5+7TL9HR/D1aG9tz7frp6Tx55XsXfRRGTyHRrVVNfn/gR+Fb6m9pvRq+kSROhSFTStK0TSyqJTD5hhlzf/9vZMGW1Mcb7Gn5V5W/I8D3L6kg8tQ4NHgH3wi1XUqFuxY7SPBqQJTPUKrh6qKZ28NkPD/1wJ5sD07bZefRCyiATfqjESbYwa9y1QsIgM/Tnrf41Gs0xJj/d8hb4kbmZQG1U/rhCi/SsHQinVY7Fq64bMfEGjJ8Sp2K4VB0cuP0OEEKtmz0nclzx2hOV
Received-SPF: pass client-ip=57.103.68.99;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This resets non-architectural state to allow for reboots to succeed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8ded54a39b..ad6ade223e 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,8 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 44ef42307b..36c5e30a03 100644
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



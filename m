Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786E4D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknsS-0002gj-KK; Tue, 27 Jan 2026 13:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknp9-0004Cv-FC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:59 -0500
Received: from p-west2-cluster5-host12-snip4-6.eps.apple.com ([57.103.71.19]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknp7-0003ud-Ld
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:58 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 1BA4318009DE; Tue, 27 Jan 2026 18:29:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538596; x=1772130596;
 bh=Ki1yWlT4xhz1Duca55DyBS8HlXuKABmBDzqTcLTcEsg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bzsgnxVyYiOvn8Aa/wOs3AiU1jtlVCCxw9ax2aiVDNYC6QiMoVyb+dkw2s1d4kk+z8gQgTwOt+9VmfR/FxVstlw/XdW4W1ACVsnQ834HpWoc9kTULNTmFKgbnxIAoUAPnIcy6YP0neTg2vZx5NMkGPofDNNysn1xjQRcJyV00iojHCM+hf8/Vu5Y9dREQCNwhDdtmgafjvvfpKij+7X6tLd7amJzeYubkC6ocycRNF/tqIppjSj5L/FnXtxjQ8YgBsF8PisWLut9KG7JJBNbaW9ub1XhylMuqkQH9E6d2myK+JI2hIONesmfOA6QSPhSjwE5Ca9Bbr8LV/cJmlK2jg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 8C82718009C0; Tue, 27 Jan 2026 18:29:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 22/22] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Tue, 27 Jan 2026 19:28:02 +0100
Message-ID: <20260127182805.73212-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aoY0ojfSOH2B603rE9d5UVxMpkrYOxrc
X-Authority-Info-Out: v=2.4 cv=Dewaa/tW c=1 sm=1 tr=0 ts=69790423
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX29WY6hwjm1Yj
 btZIePzm08J63qf+lcQlkaySbfk6Zly7JVcKO+aIaPXEC0mIrBQ40q557EQhmxs8pFMBYn2tO9u
 IR6XAdBFlWt/tL98IvbZn9vKoNuoq+Miw5j2CxRA0+1rX1U89I0VegHLTS3jc3s2klS3/sj91LP
 kwajWASxa1Qd9g5qKzqRH4txU2kpXLlM7yFUc2pLLp0SBYYt42vw8iFiVd6EN+TMzyZ22yBhtld
 De3SMKvHeq1a1mKms5FsHuvws9IfvzfAk/ZqiKPprKM+a0nTAZoVXQSAADGIWjQMDO6vPjv76jD
 UwzrEN8lJfnMXNoDLxr
X-Proofpoint-GUID: aoY0ojfSOH2B603rE9d5UVxMpkrYOxrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1030 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601270150
X-JNJ: AAAAAAABr4bX3vfOhvFf+jTuaC2lb5IoEGcirO0eUzr2JO86f9M6jEUV8rAHm4SnCu7tZNRjuDK1YNDtYbqVJ0PAVoIpze8hhtzqxklFuPsuNvW+wvkfWoOP3Js2fydthDpXYQ/ikwU+h2MQtV0FrRHQvtdjkIBRq073++0UMZzvEhnMtdLTPYx9pwuN83dzYnI/czn/QsmCYX9COahRYqiVHrcvQddDRzsjXNKofclyyN68ac22QRo9omtOieP6JrxmnISlCcT8gC3UptkwW/UVgguHqSgCT4+eXjddBESfPkuQhbHEvb/JEdO7MgoxW/58P7iNJet5/1lkFfltJzshjQ5xxf5HN+4cygp9Lo+YITvWf37S2HYxpoH7JR5HhMIdTGnD88+alKQB2MSfqK4qjQDpqMYoAuyegrjRFaGODcIzx864XpMtrZnjaBnx/0Zc63F7axAsWyRrvhVCTb8u/11ipWSSVYlEp95mFBzayY6lCFZ3C3+V0Q1TvbjD4MioGAkNFmMQ59SbxjmUqYi/Zxzu3AabIGLBMNMNuDAKQpqH4TurZRoi9tUlAwTjyaYUhqMc+SWKhYbyBbSirF237RK7UBnAzcswM5anPW7lNlO+7d4aoQAY1gG4V3a2lv7wkUY4EcePNMd1LbN6wBZY8OLIXDvunlS7gBOP4U/wLK7e5S5nYeyF0hiKnlvGLPOmyuUMzp+gq9GF69UJFLCgBTxW8E70/pHZ2/v9r4l9wbY5fY/5IKIQyYxZcxTK3bnGcZIRGw0QWt3VgVjtsS7OiLyUSgsLEVQL3PU+53g15ZDkuy6Xn9L3XCXvWSGiYkEj/7NSCT8G31NZsFB6rsq06AkScSR1clSu1iGx546GpyE2n+68NOOt711gSxs1hv8W2TiZ+8xUB/MYBLWpWDfQFf/fCEa7e3ytlUrQZJ4tcUWB0dX0XRE=
Received-SPF: pass client-ip=57.103.71.19;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 55773555b7..444f8c3d42 100644
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



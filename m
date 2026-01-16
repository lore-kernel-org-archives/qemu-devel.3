Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87B9C79FBE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHd-0005uq-ND; Fri, 16 Jan 2026 08:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGq-0003lF-GP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:54 -0500
Received: from ci-2004h-snip4-8.eps.apple.com ([57.103.89.81]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGm-0002M8-JC
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:45 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 0906718000A5; Fri, 16 Jan 2026 13:53:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=HVZ0nutBP3XUU2ghyFsHVCq59Pl0T83DQcCmyje5ufw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LiXmzf1C2u9wIhus3e2EA9ZBWG++Qmz/5sRzDiWZtZsL1d1Tta3vT5VLNf305fFfHUQTVX/zdYwdCScHBoDfgxWGWBLQohe3SyAWmNFquuW1Bp6aPW3XJIWBI+XOQfNcrzPJd6JhnXop0/hx7nnLwkanEja4LfctcxNGiJDMNckCKsYwpZpDTYzmlPTsmbQ8nerRYBuQrOFLnEYUwZ6re3TkRVwjLDjqrEMfUBV9gmE7zgMFw63JzYupxzX01d8CW+3mA4Cz4ayDV8Xo7I0nyljMjcXQdj6JEd+4pTnGRWx03kpkJRIGlkVhYGzrFscB5FBgb4FFIPUH7z/5Upz1tA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 797E8180013D; Fri, 16 Jan 2026 13:53:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 25/26] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Fri, 16 Jan 2026 14:52:34 +0100
Message-ID: <20260116135235.38092-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=CcEFJbrl c=1 sm=1 tr=0 ts=696a42e6
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9ZvnnfcX4Q06VY8nx76EWrQeAa9KIBak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX5RY20OQqmk0T
 S0jn6Wn92GLQdPAJhOp2nC05ZNOGfIAPKS/Ooz/6yDSWLB4hdV3Iw2NEQZbEOgoO3zsUeONCAlo
 wa+z4LMm5cPrEersbRMrjUXgb/HG6ZKkmssztBPZSH19hH7toszmf2nOYWTHl5SuNpxBly3H9Ij
 3+F/b8gPNQWPLDoYh5L3xCL+1NNJXZSMn15ViCLG1S+sMKe2hHK6rlIcNMMy3EWmA1KBXXqqIY3
 modXYllwSare5k5nYTm+ejXWZLGwr7DJarwPH79eoIvG+3sUab0hlTUQr8BXyurCUtmeqtmKMOY
 nV7M0WJLLJMC/hGwokU
X-Proofpoint-ORIG-GUID: 9ZvnnfcX4Q06VY8nx76EWrQeAa9KIBak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1030 adultscore=0
 mlxlogscore=842 mlxscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601160097
X-JNJ: AAAAAAABOWKM0l64/ezOweRz5bcp0yiN9Gev4J1KoREaOHfDEz1AwMJlKhoPtUYKaatQReZpC9MoLbjsZA02i9LVnxTask6Ot1AISzxj8qacueYqYEOS/8vu/HurdekMmKtrEAMw7KbuDN/53db/65688eEQwRw7SvHEFqRbIAk+l4IICFuYTSaD2I9SfL2qeNHVh43WaqlR/BkuQ61/GWYHJZgCk4zqleQX2g/Sbrpj8fBmxKuU1NA+W83kWTmAYI0DGvmYnJ9tdXWhQyLzKNsReYkfVzmAnKFNCMMJvxE2StOm7Jz//aYPeCHQQ/LIqtwolufO/NMMKoIaM02U5C7yNwryOQT1xrriYizFSBxA9WNlxDq54ye2VedOux0He5S7flloiUFayLOOps9YaTWTIpi2i9zEt1LnO1PvfDOeVqclQMEU0LVYPYRheBIV6VO2v+h2+wa3oiecN5kSb4HuL2+n3p4CLj/47WtDmk+IkznS8e4NyzvxsLG0VAl5Y8Mqj8qROZgoxjryVudxrkXtayVNvQJYhNuPaFgBJYAyPUWFBosYRXj3/1xdkajfByRguDKExHJlF4UAidvcolXMvvxn+piXqdw6RXQ+t4PsVzs2DOJP6TrLeGD8q6WmdVUYAs4AEyUDppKkBR+BOni/y8VaEwHQ10nQzGN/9hjZ/rQ6WNexlVDxLPo2u+bYTRvik4+XP+R1m8rFlJVCft5y86L96KbG9xsA6aoc16fLOXAJRkXmWaNPHfRTCqMFYajLwLWE4vhqDtszAxSmSXwfyzDz+rkh4sGWVj5SAMcvBCkSUm4=
Received-SPF: pass client-ip=57.103.89.81;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
index 79e9065d3a..7434735a4f 100644
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



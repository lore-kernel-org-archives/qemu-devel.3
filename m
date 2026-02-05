Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360DFE9128F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0K0-0001XM-Dt; Thu, 05 Feb 2026 09:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Js-0001Kh-OH
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:58 -0500
Received: from qs-2004a-snip4-4.eps.apple.com ([57.103.84.7]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jr-00087D-9j
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:56 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 8DBD31800D98; Thu,  5 Feb 2026 14:26:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301614; x=1772893614;
 bh=yJUrkA3wK08ViV31cAOA/Pb+MGLmCaTb/RGoYUR01yw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XqlPdLrZj3WgGpG/VHhGiZdNHtroRQlF7B1h/K09sh/dai4rKtLwEU87WcNO0YiAU86NlmrO6KNvTsmB8rAuRuXmLG0MdWF5zyVwoV96DLY/ZaCvP59iA6iu/X8xd1bwr18x27RVNV+bvaDDYLDzbzvwhNUHpPZ4VBpCuO5GKqMa3U05pSTsprsasm/QHBcQybKDP9WZSzCsW/lEYkqG4GmbLEBH8ifOp6dMFX3Uw51Cfno7jNJE2E+v7EqZusKH+ZOM3GSkzgjUXVysaB3Mg2+5swFjQsk8RirSduIyOR2uEGpkpSDLdp0MEuZoyySOXX+bjTQWOeCx/Co6W6AKaw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 3CF041800D91; Thu,  5 Feb 2026 14:26:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 21/22] whpx: enable arm64 builds
Date: Thu,  5 Feb 2026 15:25:39 +0100
Message-ID: <20260205142543.64818-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOSBTYWx0ZWRfX/zgSXs2RRl/c
 IgH/b9Whq/jH7FkJmgS9jKoXPH4ASC6S9FbnNRjUQ2gelcGslTG2qb85MzlsH0/9Rkscn6oSz/3
 A0fGUzlgwIv2Z33ejCDNw3ZTYzuWzhjmBHvVx/pDwHqiLIS5xZ4dgMVV3I99Z+tG83kLLS9z4TS
 1GhVqi6KPyNjXsRdrPaf0ZxSjDjWuoMD9bMfIHY+9tDoaifbhiTCvEi4bHN/eqSy8K8V7anNDXR
 jJoOns9oy1PyyugEEWHU+gCp2e5lZ2lrv2e3LyTdlt2Bghu5ygc8djZMTJxyCe9FtaxWoueTn8f
 DJ+x84GwXUXpHGKi+2IvXQYp/yMfkMebGFmFJz9//3HRbRZvn5QT8Fx6D7ZDM0=
X-Proofpoint-GUID: bNuXwyx1dcIRbJXmzFKl-2XtJk5gCoLG
X-Proofpoint-ORIG-GUID: bNuXwyx1dcIRbJXmzFKl-2XtJk5gCoLG
X-Authority-Info-Out: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=6984a8ae
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1030 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=955 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050109
X-JNJ: AAAAAAABZ4Nn6hWQH2tTfoYE8KbpprcjDXWXtPzhKiiWxbUDmDSPiPg47kLih3OCUJ1MVvhwVzurwNi2H/zhqkrJsuDLmNMHEsEdR/veuy9gJndYz+1O3atrKiQklDEmqm2uOE145cadZbfpgjk64GYSXJJTmzIRG1yodOSiCwYcJTHQTFt7/Pgs+E8oipeQK+OxdctO/UAqQWepY0DQM5tYu9Uk/q7BAZ7D6HJafDaW4lOKn5kkxAK4/suthEFt52FMBhti5ER1SxVM4y/2V/XKBFYiq5ZSUzXBOZPJFvTsJlTjeZk+HKfQsT51qEKUC//w99t8/vlLKs2L3oqMmJdGFUd5fUajIACxx0UHRaez+jbiU21tMYg0ye7gx6kH75fZF0Ds5xvcGKWpGiGVPMuD3JYI2/jUVaNz2Qr3jTk+7ooYCT0LldsGJKbMHQBhch96GfyI7Z+9qdisWcpy5ygYAywMWjLZM2fjMOHXxiWUjvga43AlScoqcQpb5FE9TAbqd0H22F+iB7TgdxA2cQQ4n7skr9421bHAnqVy5YBGp7xW03sfkskMR1f294QXXVbXwJTFkvTMTX03OHSWs4V7oBbVDdx3bSLsgvXPNK11ZGAbNE54GXw1c1zUF/aCzWp6FWqe2vhyiPwUZFaXdyLknun6BNjq8IAaNnoUa88Aoy/uUQC778lt9KUji1JWtpt7YsZa/7j5uS9fhApnJIZi/p9o8YM0zUL0CoYeMgEGvfTHiZh1HeFkL5eo+lb8Y0FCTcFw6eabeRS4gAiNi41l/DONDClbco4ddjXffMeLLOuxeN61Qo/GqiKHJqm5e1AEI4XXwG62HYuIAeSnfijE8ztwij7GLrCCN7+GvpuMo/dkBmGg27LG41ZU/MI4YDgo+H15UKveTM6HVrv8XFQZyrLmFsPGMRwL1zga148iyA==
Received-SPF: pass client-ip=57.103.84.7;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 meson.build | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 8c6c0a9a32..eeafd1d42b 100644
--- a/meson.build
+++ b/meson.build
@@ -301,7 +301,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -858,13 +859,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
 endif
 
 if get_option('whpx').allowed() and host_os == 'windows'
-  if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
-    error('WHPX requires 64-bit host')
-  elif cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
-       cc.has_header('winhvemulation.h', required: get_option('whpx'))
-    accelerators += 'CONFIG_WHPX'
+  if cpu == 'i386'
+    if get_option('whpx').enabled()
+     error('WHPX requires 64-bit host')
+    endif
+   # Leave CONFIG_WHPX disabled
+  else
+    if cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
+      cc.has_header('winhvemulation.h', required: get_option('whpx'))
+      accelerators += 'CONFIG_WHPX'
+    endif
   endif
-endif
+ endif
 
 hvf = not_found
 if get_option('hvf').allowed()
-- 
2.50.1 (Apple Git-155)



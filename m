Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2B8CFA76D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO1S-0006ab-RK; Fri, 21 Nov 2025 05:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzs-0004ut-Ny
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:09 -0500
Received: from p-east3-cluster4-host7-snip4-10.eps.apple.com ([57.103.84.73]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzf-0007yU-L9
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:06 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 00FFC1801104; Fri, 21 Nov 2025 10:03:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=vkSMVJ9/I3kIZJy6hP9GjaU6J/uHqykQuo1bKtZa9lA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Iq8DMmxzJPS6OhGPeOLBYleAB/L3Q+AXeoB6oiyvQI6cQcMjw55QYJI3l/kz9lKPcyLKqa61tB/sAtuVB1fJjjxIly/Gjx6KszThyE1s8bxeD2BjbeaiDhceaN8rbrD6GvwO8YjLuTcdU7VXH+A4mSw2aKdSvFUU6Y5RfJN7MU72xT57Ya/VtATsJJqkt7QN2AFpGWeluaIRkhmVeL/IoDCPVZcH6eGrjj9oFgDb0evrKy9UgM57/fx0DlEq2GCrtU3SK2E2Dped3rIZkPPqRtjB0cKjF4YYMuzRq0y41/bkSG2a4moqbfn23a7Hs45wSFKArZ5QDjsRK0YcpStoYg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 094021801103; Fri, 21 Nov 2025 10:03:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 25/28] whpx: enable arm64 builds
Date: Fri, 21 Nov 2025 11:02:37 +0100
Message-ID: <20251121100240.89117-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=692038f0 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=Ck9h3XeVBPDugYI9Na4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mXuD1E5wAzmFnmkZazhi7cdOA9uBEuOu
X-Proofpoint-ORIG-GUID: mXuD1E5wAzmFnmkZazhi7cdOA9uBEuOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfXzUWoH7Q4ZYMd
 oavcFhSLORgok+yu2EYkSxTQj/2h002JurVCfApGH6GfB+yfLIJoKDs7Js4fAVqfs92+yCdAYlp
 GragvbpCNLh31MbYCt+YIm3M/b95o5m8uvkLXKInghdRSRfDDWcUXOg035Ga0w3zXO7KCXZAC3L
 R34uAgzlPmlufsTq+Ayqh5IkB/LlafnemPfV9ulw6PQ/lTB3z7ILCEeDQPJZsnMEW1c0xJg22yY
 wCk4QKbhCpjHwctYiNDvYqVYmWVBdXbSxCTqda2supm3XXTI7oVq4+fldjMkhYxO0eeY6iAtzTb
 kqBXYLnp6lpme29QZJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxlogscore=753 phishscore=0 bulkscore=0 clxscore=1030
 adultscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABiBE9Ey+iL+we2/Dt7MPDoMqNc7DwU7sgPrOFUwgIAOlTUOQjZjAyWeTP8052gWIseBOdiEU5bKfknh75Ds4CFaQumcvCFOMOMZo+odM8vAI9gVKNGi8akoNMqvZt2cRKe7UsJPIT9rAB+0zT+2lDtMK/WAVErA16tk7MNYtJ7M9XFC+q1abWrexNAa3q5Hx/waYxJRww0aHI1mAgtx/6XBi/xMJj3Wu+GEpZoeM5RbN46jdUqTAHm7b4fzJZMvY99pa8pl5OXpwr6lR937ecFZOj2YTCbbw+sI9eslyf4Nu7gFJUy22vztPjiKLvpiy1xK04VqvxILUyfQuqqVCp4zLFs6/zJxvYaR9itHzkBqKJXNF/1bwajOxGadgaL5hnZXGUfaH5vdOhPmwFjgXttaBuK6kFCG/GjoTnG6rajcmY434/46NY1biYgvEujBn5/P5toh+YIlogSxt+s+apBWM9yIbbafC5bbABUz8YqJt/KsFRo0ABs65UxRXd0fnhxpQ0GRetaHiHdp6cKccLiefWFMJhLtXxq8JBtzOlTHdduXqh/AZCPBHCQeULO62MP2sJeTbxREuQQpZHyNEPs7HhcPjYE03rC5cKjKm1S2pdgEw/jh2+R0NfdcMBRtMEcYVjkwwkN0frdwM/yNo/txrrxxCq8naTd8u2hlsO4Pk2ue3Q8Gracn2UDIKS9P6VQsTyzS4p0dBQ57n47agbb/j6yQ8jbcXz18Gdc+g1YONN
Received-SPF: pass client-ip=57.103.84.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index d9293294d8..d7181ed458 100644
--- a/meson.build
+++ b/meson.build
@@ -325,7 +325,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -891,13 +892,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
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



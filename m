Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B009CEB5967
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3B6-0005WW-Mn; Wed, 11 Feb 2026 00:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B2-0005U8-5V
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:16 -0500
Received: from p-west3-cluster1-host6-snip4-10.eps.apple.com ([57.103.73.191]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3Ay-0002pN-Ab
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:15 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 3D8A51800182; Wed, 11 Feb 2026 05:54:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789250; x=1773381250;
 bh=Fw0z6+iB9F4AovKxBQeeShFALB8YJtbOsN+Uwg/naV8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AiunL6BzlliijdUih+t/okZtiz2HPLzK6PVqs/l53C6NWgz9g4tjM8NgUORCDLj266g7L3JadqZAwyfjZ0Ri6CoUun+dSyiueXq+vAPbWCll4BDzVvrf/s9z3z711f10Q1ygzRR7ZUS38Q29ynUj468NxqZCZKf/kLW+MsWQkoqOKWSCeuR2mMcOnVWRkBwX4aPRDrLpOvq/IQrIST6kGX+ZHB9qoT6mPDxiIMjJ3hde+rjamdYRNz4xfiedtPHIIhD6pxErqR230tRGaKmo4mvvlTQauhFvWmTQQngJ32RQyCRCqOshJeinLsE+POURjkCvaQxbkh3mUjSK8BkH7g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 25A1A18000AD; Wed, 11 Feb 2026 05:54:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/7] whpx: preparatory changes before switching over from
 winhvemulation
Date: Wed, 11 Feb 2026 06:53:47 +0100
Message-ID: <20260211055356.44664-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MkUbxFBx3zZaj4x50-GP-B8ZQUEh3dwJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfXx0HNotZbwamy
 7xB9BbcCLzd4Dm8FpjycpkuBXShqN8WnHeNrOjWv1IVu5x9zImPtJ50q9mzSv0pR28MMeNSixuy
 7ffANeXcarGPi1OpQ8h3/OdKYS7sCCYKPar8mqITRrmmGc+wwyADvZPlBhSJe7xBeslOH+36TXt
 TyAjg0Xn4D2PAk+I8iirjTm5aw0lg9EfqIEgp6o1dOZAHt9ag/g1JYNdXEQ0lra1kJvvcFQlZLq
 moQbvVmRLVUcjlouqXD2RBa3U7aFR2EvFe5CCh+MTkBeU90tVzBTeXyuMrbbOIo04npqx+KRBgo
 NqVZzrGXUVbultQqvhJdoFSr2Hb3JRTpFE0rLGB42jf6GWqxnRtDX6qgcSe/Tw=
X-Authority-Info-Out: v=2.4 cv=Q7ffIo2a c=1 sm=1 tr=0 ts=698c1981
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=3ZNzUvD_rHpfP4YyWhIA:9
X-Proofpoint-ORIG-GUID: MkUbxFBx3zZaj4x50-GP-B8ZQUEh3dwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=943
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 clxscore=1030
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110046
X-JNJ: AAAAAAABOCGHBnnZUvLd2ksjkdBtpVswliZaFkOjLmiMZN6Xt1zLjkO8gO4M0iDtaDqmgkHonlB8LyktYFc5K4Q9+cuAkS6QYOrM9UXEv+babCsznzr3LNTOtBdWRuszi0cSZMcs0hJYpBz6I3/IxVgEy2JJ7XascCA9Y+H38BNse6WpVPtG2/k2vGkr2WRhl4HDWWPFkwS+vbMqdIv2mpMvfrkWW45lDYmcOdxNaBObfMB2uun0GYBQx3+V+T9B0REqUHSVMRQbJbhLFL9SHwyaoIWxF854N20owSAt7SMOthnEm1rU9vybQqhp/ICisug3Szd64WI3UCDcPGBO4HAp7cr4vx/IyzMd94Qprap3x2FQmKzcwwD6vqaaOItxqUNjDxvgqJmQwu4ouPIHFjnSPBlIGQE7xEft+NoyyA3RwHAuzbwx9125gKfhpDW1OMX49J3obWVz7qk1CzHMsag1Bd3uLK3V0hIKJCMhHHGzzIzsO686N2MSiw2VybDIm+kEbTZeocBYJwnNCCgp4fJ9JRv0BkHeEKVaavm51ZW1jP76LsRCYvR0nBeOQs57p8pfpvpuvYIhHowjeAzYd0XwwzYHbhmJtd/hNjEz+M4gK9NFpCmC1TK6D+1a/SWXPDOLT25O+IipnIYSBDDGIxZPYOSdT9lItHGKy4QxbuvPUzabW92wttfu2O0CdrhC+ZJ3RhbCegZtl7IVbiN4C6sKwCfaUGfvsjfWy2qyymawRV38QezFqopcUbGTCGOSVnhVVAw+7zU/KoUWHFHTth3C6onPlbQ5cZg=
Received-SPF: pass client-ip=57.103.73.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/cpu.h               | 2 +-
 target/i386/emulate/meson.build | 1 +
 target/i386/mshv/meson.build    | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index da5161fc1a..2f92ee9d48 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2270,7 +2270,7 @@ typedef struct CPUArchState {
     QEMUTimer *xen_periodic_timer;
     QemuMutex xen_timers_lock;
 #endif
-#if defined(CONFIG_HVF) || defined(CONFIG_MSHV)
+#if defined(CONFIG_HVF) || defined(CONFIG_MSHV) || defined(CONFIG_WHPX)
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index b6dafb6a5b..3560f8dda6 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -6,3 +6,4 @@ emulator_files = files(
 
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
 i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_files)
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: emulator_files)
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 647e5dafb7..3fadd4598a 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -6,3 +6,7 @@ i386_mshv_ss.add(files(
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
+
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
+  'x86.c',
+))
-- 
2.50.1 (Apple Git-155)



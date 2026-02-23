Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C24EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXE-0006L9-W4; Mon, 23 Feb 2026 18:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXD-0006Fa-M9
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:15 -0500
Received: from qs-2002g-snip4-4.eps.apple.com ([57.103.87.195]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXC-0004Nz-4S
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 75B0118000A3; Mon, 23 Feb 2026 23:40:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890013; x=1774482013;
 bh=mfxct9QuL+ifLWFIShtfDThHLnEEVf+FJyNrc4eM18s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IP++RAdq9dj21x0DfBzJX18BlXAk1e9yev4RYckX0SOMTpStzl6WPUASLA257LobyU1xkRHxYXiZhiSQViCd1NeKFWvNVz5tJEUzL2hz0YfZDVsdM6MgBWtrfTXOYOukz05EgshodPH8BvDh/m1NusBjN/SMwRWohN+Hs59ebV5cHU9OvvwUwP9SykBq5cHYdv8U4KsZuZInx0f9/mLRjZ6yRLxS+H2KkprkFIQxGN+pdRAf66Yes6uXjXc+bBTLeMy5iQOMRgvsGksY/dm51W7dxMAzvQYFr4z58psNs721phjfLZ6+PNb/qLVjrtsulie26u7P2mssr6maXSWdqw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 CB0A718003B1; Mon, 23 Feb 2026 23:40:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 07/28] whpx: preparatory changes before switching over from
 winhvemulation
Date: Tue, 24 Feb 2026 00:39:29 +0100
Message-ID: <20260223233950.96076-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX0053o7qjlrQq
 JJke9KB2HQST/XF9v4fkaQQgz66bH3kF8jqrPE/h81K+edEWJSBeE4DW2OzfB9uOZ7SkVYCcO+a
 FUYjM1Uq98/n2d4TTMFGRR+9KYWg6YX5WXDDX99cULSeBnqexaX8rX6BsECjk8lWbJVxW1dgJxQ
 ugyvchBN8U/oXRsy8e38R2HUrSoZxwfFgW1CjzarHdtSAVXcD71mw1+aD7lEKZQqcrWaHFJo6Hx
 BSwMP8ku20w1/HP3DvDHVZozoKjaYP2mgOjR3DwwIHAcGEylm3HNa+3ZuXKGSCmphoa8kJAO0ee
 2DyraeSquuFmiYFaWKCyViO4k5PS1nY1yfR5IO88+jyjeLjPz29vGUi+Lx8o+c=
X-Authority-Info-Out: v=2.4 cv=BcfVE7t2 c=1 sm=1 tr=0 ts=699ce55b
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=qtJoQR36IQ-qKrO0xoYA:9
X-Proofpoint-ORIG-GUID: PlMFzuoQG2x7uDKVBynV8Qn_A6LGcbzw
X-Proofpoint-GUID: PlMFzuoQG2x7uDKVBynV8Qn_A6LGcbzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=941 lowpriorityscore=0
 phishscore=0 mlxscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABz9p7WxHtwD/22OL6N2K1GTEyteXsFFgItmtIzlwxEt7hHy6hK6KZXCothpHLRucoPrk29bRK3mufm9w5haYYm5SIHoFsiAZGrHnF16PGWt90bVrgaWYlXJay8UyvHenIiJrToPu+YycynBBjmVHv+mMGhsssVDMGmJP3ZIbM6VnKk4Sgf66QExqgUiYkGuHz8eRO74yq+eT9bTaVLCV0+VHZ2FoOg934j6l+4/3KO2vk3PqxDQcS/re8zUDRFnHuKYWphMlAERlSRjaSNAtjGOFTE8ylJeXMSoJxoW3DafPhfdlBCBV0a+JlMgpiipTQVm8nn0VMHBBpCNEv7C5lUI+X9cVXrEp6yLi4OfqhADmqGFC1SM/6E6/tQOq87DtMkLE40XKokWLfVXg6FrjoWRDAFzI2R6DgGSGs3SkCY3E3mZRCqRp8lHQRLwjSpuBWppQJ6pszTUFAIcNMuMUgain1zeuvTfyUEipP2TeEApgA7ACP7+ox2akHGVHRPpnnshbR8H9RW+67X3m3qRD9rJ2WWZgRPdw9WGamuSlVO40nKvT89pKzVt0QaayyXwjD4KHeBMY8OuRVawTrIJkIMSHaF/eX1eE2hgvo6pgV/mqyhTt8TVEesrtK11nrIeIMlNCyOLZ1M59gMUo0y8yzkR2puyU2LKR3eHm/dCG+tg7KaufJ60HcDr4mAZO8GMNSPCQVBfCCR87tJERYPYGOdXkEw1Ad4dnrGHNLq4m1TlHIvGM3cpdGgd5I/53M9F6c/kcSTe8DuXLe+g2ZqYV2UO56PVfTvgRNmB0=
Received-SPF: pass client-ip=57.103.87.195;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/cpu.h               | 2 +-
 target/i386/emulate/meson.build | 1 +
 target/i386/mshv/meson.build    | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9f222a0c9f..065613722f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2286,7 +2286,7 @@ typedef struct CPUArchState {
     QEMUTimer *xen_periodic_timer;
     QemuMutex xen_timers_lock;
 #endif
-#if defined(CONFIG_HVF) || defined(CONFIG_MSHV)
+#if defined(CONFIG_HVF) || defined(CONFIG_MSHV) || defined(CONFIG_WHPX)
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index dd047c424a..1bb3516249 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -7,3 +7,4 @@ emulator_files = files(
 
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



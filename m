Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CF8EF586A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUax-0000ML-Ky; Sun, 15 Feb 2026 00:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUav-0000L1-I8
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:57 -0500
Received: from p-west2-cluster2-host11-snip4-9.eps.apple.com ([57.103.68.212]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUat-0004sN-9m
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:57 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 3CA461800139; Sun, 15 Feb 2026 05:22:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132974; x=1773724974;
 bh=mfxct9QuL+ifLWFIShtfDThHLnEEVf+FJyNrc4eM18s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PHmZZZ6/Vv49F3QHVpEbdNgaeTyWT4vIly+FlBIKFFZf3+vqaudBh5HinFSb0SVDocJ7WLqdDnYqCDRj+1EsFNk5NWAz+wweWOfdTSo7nM8qD1nIcm5x5ZLYBuBcobEt8o/quKD6OuFwMkU0fuG1gveSBUuJAx5tgdxb4X39eCaT+Fvk8c5+nPFLNqhmckRHvSo7Mq4UGBLD/hUhb+bNNjRLQzHprrU5Z5DCfkx+qxe/ebtiIx35uW/nIHYV5Au3u0UugWBb+ZTPqU1mcaComsppeiCprqHWza+xNSWlz7FcYAjYWc3JJHfKkTcDmc9QDWM/TWdaZbcMeNfbSCgh9Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 C1AC418006A2; Sun, 15 Feb 2026 05:22:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 06/14] whpx: preparatory changes before switching over from
 winhvemulation
Date: Sun, 15 Feb 2026 06:22:17 +0100
Message-ID: <20260215052225.22513-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Dbgaa/tW c=1 sm=1 tr=0 ts=6991582e
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=qtJoQR36IQ-qKrO0xoYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX8U/Ipf/o5huD
 jLT1fuc5ANwoXD6Lw8OT30M/6ZCZbf084TO9GiXlIncW0hkKwF0q/IQKdKxgtVYKHqJA+3axJsg
 BpkyGChauZQbBBb790wAGEZ0SoO0eMjg2pDlxIlFivlHN6hB6mRxkfclsez2N707m7T2SqSbllt
 m9ZQ/dYpZyTnAaZ3jUgtAEl4oWcXUz5oLRkNX+tGGy4yjmG9jTSLJ1tXgFRPLJlg5n4FXt+ZVuT
 aICSGWy60vECM39Kb/QD2ijk/cRmINV5i15sDUQDQcC0/Snf2T7Go5v7lLEs8rvumUbUhdKYyCM
 0geYyqXToq9Y6guVQ3LImLcJU18cpwqupHwqFP59GwszOhT+MAjg89+240Ypfs=
X-Proofpoint-GUID: kGBPQUM1rs1_1wBGPoAFeza-kxJTaWL_
X-Proofpoint-ORIG-GUID: kGBPQUM1rs1_1wBGPoAFeza-kxJTaWL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 mlxlogscore=941 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABoHOty67ZPd+c5nQlsDNNFaaZ41UzO3wIHNDkzSRbDFNXJKa5PxyJsRdaQF5n3O3SLARViG+BjTLhZI4DcjcmX+HiEwgBJ9MfSkwU9EiWBLsSlxbnBZcH+uCAJgCktKdgKF7JHjWzmxEyYfTaCrBdwXl98BFmv5jxM5zGDMSzGlccDK8/kWpQarSdAGTN6KUwN7FKIpgQ5Nc8zakYLams1/KAQRugMWtweRIpgHB01fvag5/b4dRixEd1PZKovefR2Xe/s/Is3a76qscw1DDmOmNApZ9FwxTIa0aRk0+gtRxKnWcCdQvEBY8kbhAIcM24dnGTnH+CxlibhxnTMF2+xdOdhLPbXFx487YjtOgdAfWACfoa5+BT6JXsrFJBGsUCAtY75cAnrszes3+Phn1g/wCJemB/J6MjTOL/E4Dnm1k01P407E8pcQo4Bc3iFTE2R0Pd43ovqYO/iLqg8ddw43D6chsR4CTWeKpSLbUZRxPadOHtVXt07wEOkk/QD8zbLibH8ortF+11YzN9RVPeAMumtkgZBe4t/sOtmtfl3fINtv+p4J9vcSN7LOi8z003Bd8muvslmmZEJ8TBxiC4is+jecK7DGekFPsKv2lYG5NaaP3XQ6J+v4PHKFQqfulskRsNrIb2poibA2O4adCl1APYCfez7A8c6kwnSz26uxHidHRj348OkilVs42NHbKiYjwnQ04b6tKRsD7qkRjAbavJD/StrJwfWm2SdObk0HtF2jDZf9TLWbVHok6lepLqMUhl2igLrodM9U7s0XoEz682PSCf/tyoNGzkGHWWBENZkK45T7Fs
Received-SPF: pass client-ip=57.103.68.212;
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



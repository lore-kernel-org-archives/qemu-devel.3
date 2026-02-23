Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245ABE98E0A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSU-0000bH-MO; Mon, 23 Feb 2026 03:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRS6-0000Eq-9P
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:03 -0500
Received: from p-east2-cluster3-host12-snip4-10.eps.apple.com ([57.103.77.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRS3-0002D5-VV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:02 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 219211800200; Mon, 23 Feb 2026 08:37:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835879; x=1774427879;
 bh=mfxct9QuL+ifLWFIShtfDThHLnEEVf+FJyNrc4eM18s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IxFtgbYZ9ejTHYgZlcyQjK4A/5/1dF2YGbo7ExvXurzdjcIL3P/88yci8s480onXf3MXYIUdJVfr77HdC0GZPc/uCwBu4xb0PVuUSCUBKtv/wt6jMygsRPs0qavaOWs/KI48b9N6+96ak3I1GIhVpH7myJrIdVtbxW1ddfdHddyLnXV/H59QBnaY5zIpJeg/X/MVJokCgJD1Ou6mB2eJ4uzmaoFUdSUckAPafBBGfzNiYBKWryYuWrqPzHap8rrfZUS0LzfC9AS9/DPaxDZECJBhMmRA3xf5ceGmMnzlPaAWiBLmSgYHYBLglCsbbqqx12+bi36E2cSppLtg4Vbepw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 63AF118000B5; Mon, 23 Feb 2026 08:37:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 07/27] whpx: preparatory changes before switching over from
 winhvemulation
Date: Mon, 23 Feb 2026 09:37:13 +0100
Message-ID: <20260223083734.48533-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXz9xn3qzMFQxh
 9m08YIu7v+utVXjHkwXjS27jvFtPMl63r+wP9Jn6l//RECvpwVHBcQh/+Cg3ebwRUA5TQ837v3L
 Mi1Ywq05t+uYCkB1Y/Xisss7gZyW5LKp8D3bqBmKS2wfHccMrqDlSPIWHIWuwN5HReVqjrw+1xp
 fRiS3IUeZa+RjSWToaS1xzlsFcuwrqrfPzUXeEM1M8LoOmz3jJGizQo7mLcnCY2W1r/kB1YP1Nz
 EpYBEDEyFHcmpY8Jey3GmNN3c+OtjwQrScEVrukVqfh3o3jrltHvnWryjx/YJmVjpE2TdNe1c5M
 OUlUYJqLefbIaIW5dd+iygjPFMax7TW+Xtr1FuSH42v/wwbh/z0cRdVz1r03PA=
X-Proofpoint-GUID: qfVl8H127eKKbqfkXA0rwP3o7QThhK9S
X-Proofpoint-ORIG-GUID: qfVl8H127eKKbqfkXA0rwP3o7QThhK9S
X-Authority-Info-Out: v=2.4 cv=Ra2dyltv c=1 sm=1 tr=0 ts=699c11e5
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=qtJoQR36IQ-qKrO0xoYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=941 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABGp9lZ8Orj5z8+jWfbKs2f1DQVXH0+k8rVlWcwfm/+FpjNlMugm39Qe6d1aLLQ2bAUvLhQnxVczWqq/8NpWPXzXwgIiX9HwvSCyKkMhBvLXPQv99Npa0nJIonfTQGQC1/kneSMDid+uiL4sIRoG5ljwoKZdwDqG2atzGAK7Cf7gxjBr0iEJAlcMt1R+mnWYemXrfKpAj5OsycpH6WCLi1Vb7SzR52ciPU7a0DbyctismcRBJdU6yAGVr9YzzEviswxtnTLLD6k8NM1CYhu/INxKnuIBREXE5xWtaZjbd7ULvjYoFYKgItRxeo/CixFy0usCU8Wf9vsPX+BTSqA7+I67nUfCJ69PwZkkaoz85CbCs4F9TcqDuy5br4795KgAnM8kC1ROlOlIlXnFgwq040HK91Npz3ucOKt8Rxz9LydEv1qLxb7IaEzVE+jojsfunnOkjsh944zkHhfoJMa6/HMWKCS9z3C0IprHMJuymLw8PI21/IbYAXOStsGpHVLsm/OylRiN2TZLZNbdPdfwpT/3X6vt4I8XR8GvYQ6kE+Rh7UB8iYNPhunkelxNhlSz723UP+aTSPp8183hsoJhIpLWMLZVdhtkRr++nBRwUMsSBrx97sHqgGc5jac8ooFe91hJUsqgbwz8DT1NyBF0DG+N2b7mqR6fZAscyFxk0saTE5U8aRrBjhCEEjfymFZEFlwBl97cSIQxxM8zwWRo1T2cp4d22dQxI6X5lLU1V78sA9+UD7ytmAdMhiGER46OHkbMvrHLfrTMJeKR0EVLwmnB9oq+7L1i5QXg043DR48fyx2Wfi
Received-SPF: pass client-ip=57.103.77.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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



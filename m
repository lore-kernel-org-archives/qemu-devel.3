Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC15FCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SyM-0001xi-H9; Thu, 16 Oct 2025 14:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sy4-0001lJ-FJ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:55 -0400
Received: from p-east3-cluster3-host5-snip4-6.eps.apple.com ([57.103.86.49]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxq-00029F-T0
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:52 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 8653E18004E5; Thu, 16 Oct 2025 18:44:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=IjYDfMTrkncbuDTd2a9w75izNmC+tTktWKHBCWdBSF0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=S1sFhXX+BQHUEwz6sOvOD9IfxdAjUmDzEUaQN7YkmrSzf5Aw/tjVUrTi29mi4eVeaw4EC8/mHq53ZETFO3OMtfOurm28fbWiPtPPFYFRi8TAPHsJza3U8N7CyV89kJwVc9NhB3Enp9rwoQ09ZuSkDWG/bNaOKy1IM8mJryOjXvTCE96QlyEukp4GyEt0FkevzgDylOT/grIhdADIyvwyJ4m1o8hpbiNp711Y+eehJZhJd5JwZjkSBYeOftDFXEXyePjhbPs1zmJ6+fwKSC2NNvza2iZNzk7ePbdN9TjEfSv9lrnDHxWXSs273fzirXE1MjPRyaYG0rDQxZWgkOgBiA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 BF90018000A4; Thu, 16 Oct 2025 18:44:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 24/24] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Date: Thu, 16 Oct 2025 20:44:13 +0200
Message-ID: <20251016184413.69870-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mHe-0hvzSDPbPjzYT4YTCrLCwBgagbAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzNyBTYWx0ZWRfX2kWCgQOJjsKj
 yitXgAqcdT4D31r+gAbqbGUJPHzVW6AdhYOV+/EdCmRzsNPj5lBnjJyqwJFC9+NrlsRUfneM1mv
 Bm822+3PvNYXVD26Y7/hlYJNqace+HJGIXPd3JBMGwEMAagA1Rkmrgf0gAZEUWgruFjOBJxsm/u
 RCANzdTHBZ36lN/ycDqxdt9BRQz1dO9qztfvFhCO8GJhYKKggMmeCIGMQklVIj8hiULnw+6XpUQ
 rp9GJwipviSyyABHbdykmyWvy3SVCD0RzJ7DrMMHsUmXG2hUZqFRE26iNF3idvtEl4R4oa3Vw=
X-Proofpoint-GUID: mHe-0hvzSDPbPjzYT4YTCrLCwBgagbAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1030 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=716 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160137
X-JNJ: AAAAAAABvNwE8XShqer49z4ohExmv7jvQha9MIW06SHqxHvUj/K+e+oUrOJK4DXLx2bUb2KocI5IkpFJEtbNmTsiww6k3ECibCPy6wGGU9vTCrIZby9mn+waJyTP5SL6RuzXQaJuDyN4Lwu8jnW+SO/X3lkYCRQSiiXsuz0SMTfQdOQs0zsdAI23gHkJvvXgIMrsDNeGSxIhu8oIh6ZCDaBp6Kt27pIEAoUfICULytOa09+ym2rAHjHDucyg9ny2Yq2oINb1z59bGJJssRNGfwLHAB8eHwjvvx4s6A5GJyFibc7xF6pxgzL72MV55tHcyGFpAWQ1GN0Rrs5iLgAPIbkh1c2gvlw5/TGUr41xi3AoJX/IIWUJA1DE1/Rfe0ryRx2dwuO0s+KhfwDkdfLSV8Tx1KMKqVBDi+PzkbOIc9dogL/C5tbYvdGfDkZ250QRKryTtvghFOioMkOoD9PhPtsUsMWwWBHfPFH9Q6v5jYQFKrNUGc+IwTSksNwOWxfA/SDIqOIdl4ZiDMoSvDDBQYWgQAlUnSbfBvDZ3y3smNaqyEtPFm59ayzAKSQ8+rY+xOW2YmfvSjPz2DmiqrteRN1M6nNlcBLszND1u430J/R2lG8phFnhWsyddD6lQyTOlu1qvhTBNWIZhYyY5BopOlVWBFIt35KjTvgcDyMCfT75U2mhYGCj/Rk7Z9GKFeYRC/2B65JmtBvZ/8W43tPF4WNt3q6IZIsJXFeD87NFbY4=
Received-SPF: pass client-ip=57.103.86.49;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

WHvGetVirtualProcessorInterruptControllerState2 and
WHvSetVirtualProcessorInterruptControllerState2 are
deprecated since Windows 10 version 2004.

Use the non-deprecated WHvGetVirtualProcessorState and
WHvSetVirtualProcessorState when available.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/whpx-internal.h |  9 +++++++
 target/i386/whpx/whpx-apic.c   | 46 +++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 366bc525a3..b87d35cf1b 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -84,6 +84,15 @@ void whpx_apic_get(DeviceState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvGetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
+
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index badb404b63..285ca28ba2 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -137,11 +137,21 @@ static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
     whpx_put_apic_base(CPU(s->cpu), s->apicbase);
     whpx_put_apic_state(s, &kapic);
 
-    hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cs->cpu_index,
-        &kapic,
-        sizeof(kapic));
+    if (whp_dispatch.WHvSetVirtualProcessorState) {
+        hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx_global.partition,
+            cs->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            &kapic,
+            sizeof(kapic));
+    } else {
+        hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
+            whpx_global.partition,
+            cs->cpu_index,
+            &kapic,
+            sizeof(kapic));
+    }
+
     if (FAILED(hr)) {
         fprintf(stderr,
             "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
@@ -156,16 +166,28 @@ void whpx_apic_get(DeviceState *dev)
     APICCommonState *s = APIC_COMMON(dev);
     CPUState *cpu = CPU(s->cpu);
     struct whpx_lapic_state kapic;
+    HRESULT hr;
+
+    if (whp_dispatch.WHvGetVirtualProcessorState) {
+        hr = whp_dispatch.WHvGetVirtualProcessorState(
+            whpx_global.partition,
+            cpu->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            &kapic,
+            sizeof(kapic),
+            NULL);
+    } else {
+        hr = whp_dispatch.WHvGetVirtualProcessorInterruptControllerState2(
+            whpx_global.partition,
+            cpu->cpu_index,
+            &kapic,
+            sizeof(kapic),
+            NULL);
+    }
 
-    HRESULT hr = whp_dispatch.WHvGetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cpu->cpu_index,
-        &kapic,
-        sizeof(kapic),
-        NULL);
     if (FAILED(hr)) {
         fprintf(stderr,
-            "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
+            "WHvGetVirtualProcessorInterruptControllerState failed: %08lx\n",
             hr);
 
         abort();
-- 
2.50.1 (Apple Git-155)



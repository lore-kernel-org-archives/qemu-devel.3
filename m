Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD0BC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYSm-0004Vj-07; Wed, 21 Jan 2026 08:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSj-0004T0-OS
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:33 -0500
Received: from qs-2003a-snip4-11.eps.apple.com ([57.103.86.13]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSi-0001B9-Dw
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:33 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 822FE180015A; Wed, 21 Jan 2026 13:41:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002891; x=1771594891;
 bh=rqevPYI5PNmYfO37aWp6zQDTk/Z3PG7nW7DuJwvRyUM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ZdVrQBtgmlHswHiydcnMK9+bdq/h6PkFdIGUwW4WB0vM4vadORhq0E8HgJNTCcmWidWDo+EPN9pDi5qsPmvVSeXl2yNyQZPE0g8vQe3yUQ3yiMVWR1dS3QiebUfOrCPzdej6L4aYYXyX8bre8bvJln5/rZUDL4pcwlm+C84IyiOD9r2/rCPC0tlrzLfCM3pujwaf/dp1KOT2m3gxTW8OvxlNZHflY7Z++y1YsKbvEDEVRhrcQIYMIWVowQ6TeMVKQ+LlJDxrZrUO6CCVaFLOPFnWf30IPvTrhiEfzkCItFiZ6cB3zwjwxJgR/bmAlOaG3VmwwWNuZ8PuBUHbLPsLCg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 D863A180014F; Wed, 21 Jan 2026 13:41:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 02/21] accel/system: Introduce hwaccel_enabled() helper
Date: Wed, 21 Jan 2026 14:40:53 +0100
Message-ID: <20260121134114.9781-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HqMWGN1mpoPoAxwTY4YrLGvuOFvz3mhT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX2/ViOjl8utZl
 qUNQEtEzJBaUApAhuGfLh5SwgI7VZqxZP1r0O8pdJHHF709N6nWLnQeO7DZ8rZWX223AI1yq3cN
 VYL5wpUIP4HrFqOjByOlKDgOwJl/sdLxXGu/lnIbwg/zeHB+/Z6Tkya1XZpgCY56g7Bxr5dQa3b
 zRGViZgh/C1vRDtP037KcpJcMcJ4zRSz9RkdCRd8fqFzMM9nn0kpEtOuN8/wTrP5ro6V0hqV2hB
 VIhB7kkHYvYDY5fJvZkwGkAfpNb/Z3MuJ/cqN+mnNarCFB7eLsHbXVShNnXqMcQGoOyCL6O9qLp
 8ZIkB9Yxlj1JNPHAqiE
X-Authority-Info-Out: v=2.4 cv=AtrjHe9P c=1 sm=1 tr=0 ts=6970d789
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HqMWGN1mpoPoAxwTY4YrLGvuOFvz3mhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0
 clxscore=1030 bulkscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABaKXEcI/6iZ8eo2JUxNYCQcKgUejfarHIlNH5OTUT/sPf1bcn9qvcR5cJ7o9LiN9F3coDFtZ3218H1EqjZq1JXAZuEnHLYwqDWkB8EUMTgDLZCxQ9LB1FSmE2s9GNV56qepo6Acr0TDd34ckVDV1l7BiqvrHc8XEQxaXzneOhHY1JuwzrM5Ch4VnVo4fbMGl37K505hRoFvPhSkEOW5meieGHDiAT47XqdPVj82Ty4K2jaXpTOxmN7NrbTy+Rhnv9byjX8bs3VMKa6vEANv+fF5sFMtC6EUw1heTnZm2YlfsHQW5xW0Xmo8esrVOe2AHySG3YMteW7FPFXil3urqfNfSVmjrAK053B+e6S7UFj/dA81chQ5nP+r3e+KP9oP2NOpDI8MtcdLqUX1TPLcCHOBkVQlnkUl4ap0RMNDnBjulcM9fvG1I2LzUwUPmcAraeY+CzkTbIxB7eLkjj4iFwljkkzNIBMKc3y3mcJElTFCTVL+kwX7hxzziRH9aVSQJ6RcvrMSGBVd3+LbGgEGF3cFj2gEiCNSprXBVVTXHVZ5LwUxcarhUPHqKfahnQv4gmYLMG/V1nvAh4VP5Q2ZGEimW+QplvvbsrOCR+1jwKZC5tAfQezwccKpMpVMk995e5sq3qu/GganDgb1QtGyyYiKub2YHZJIxbnm5fAV5qs62aJYg9Ku3E62PQ5rIsBVeUG1Bn1Wr87ThOPBtvrobYAHNmKPXIBVtEyFGfjGQQf3+K6v75RhMy2FEAn5h96z/tdDnKAJUqzafHO4h12WKT32huLCOtCN6ouMPJicL233SweyZIg63ycCwjyaptWSIkaCldPaIMD3VSABz5F8Eea/rj7bu9lKORgbKmv53NEyVL2J5Uk+MlUshFRtG4k2Ehr5W1xjUhHGipno7F
Received-SPF: pass client-ip=57.103.86.13;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 55497edc29..628a50e066 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -40,4 +40,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.50.1 (Apple Git-155)



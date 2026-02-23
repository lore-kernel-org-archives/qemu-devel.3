Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97579E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRRx-0000CP-GX; Mon, 23 Feb 2026 03:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRv-0000Bq-W9
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:52 -0500
Received: from p-east2-cluster4-host3-snip4-10.eps.apple.com ([57.103.78.141]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRt-0002BZ-D1
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:50 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 4AC27180020E; Mon, 23 Feb 2026 08:37:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835868; x=1774427868;
 bh=eGBzMnvYi2plqRMYS3s+jPbPqZ3R3tScJhTlruf1lkA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=WNmdZqvrA7DDIaW+cZlwptqG1RZvV2xBNUTWM2bIg7NWkswm/rz+cGqZFNU8Vti0/K860W/lR4SdXuWadwnR/GKMohkHUh3JrzQT+0efRhJt2JDa7ow4PpzxTyLLXmdHbnzEQhyLeLSILmkdoLVt/lSns1YWg4lf8e+sTdEiu/e5nFf+NvpZdkBjZBijVvAwnYHWed8lsVza7tzTpz89u6PewsN/m9CL7hi7Kp53DnXBc1xbZflmi416xDdtgRHph3Jnrn4IzjNSBEBMP/yHAaNryo1XrHhEVzOJnQTYGGeITv88j61TqK/ZJF0ddYFKV3KVaH209D9KyQyNutGDdg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 4411F1800173; Mon, 23 Feb 2026 08:37:41 +0000 (UTC)
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
Subject: [PATCH v5 02/27] target/i386/hvf/x86_mmu: Fix compiler warning
Date: Mon, 23 Feb 2026 09:37:08 +0100
Message-ID: <20260223083734.48533-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX6izIIEoSp/CE
 0EI5E8ec5spsPrf4m/gey6gXw4bL/yTGLcsADkUmPUA7F6Mgb9HbQzN/Oa11e89ETOtC/MlqCPF
 B2gaE/mkvjDZUU2nPvpdU4RDss31Xu9DmT7T9CdsfHCdgLQAGKHp+ZLWokuWPDi82X7WzLvKqLZ
 I6TuwG/la016+dYs0yzaghBGFw1fh0WO0L6Y7sehpAjtgd2NhQbzBe73zo4iwpazgrt+rjlq5Eb
 /CrXGpErNJuyPij+GsDzGQnfPnHe0KsrQY8bwhkpDl8yXvrz9Jz5YiILqgqdU8JBvDhSxbYa5Zc
 aVOf4fjzKkwpWk2pq9UWyLPiSUyPh5VrdiEAaAG3kgE9dVauECJoZHPAxZmi48=
X-Authority-Info-Out: v=2.4 cv=Lq2fC3dc c=1 sm=1 tr=0 ts=699c11da
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=VIwFDEqWtveBFbEZvHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VJE0R0qLrOl7HCvPaBqG9EbgsSeLYacM
X-Proofpoint-GUID: VJE0R0qLrOl7HCvPaBqG9EbgsSeLYacM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0
 clxscore=1030 lowpriorityscore=0 mlxlogscore=938 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAAB9nhMTH2M4bLAGE37Al954JpEe++M/0ZMiJp6Any4Da94EU1065ck6oqgPpow0CTRv0WqlIqADm1H9XNvHbykYw8CU5EKt+A9rnqcjb50X2uyExZ3Rt476ujDwLJfJZdaXtp7iAwn/4TbreMLE9wmN2+wenECeWOp4aqOc26c/V6rxpxKoe29M2/Gqsh5VLd0a5cqvKup2vuYbcmUXutBHhkvB4aM4guUCqYX6mHjxvkpZiJxtFgRGgh1PNfzoced/KqEXiPpu1TfbHQZMPUg6PeLRR+yFs6KNpyfyYRmdVVHuNLOUhQ9aQPvO7JPP5VJMN/XTYvs6wSNlrmA+/RKrq/5UtRUEJ+nHShAwYu8cesRnJcXybMmEV1DkM/Ll3Zq/NsPUoKEY0xWatFMw7Lp9lMCJzUxclBwa3ZtnDsUnqJpad/wxOQIdDEV9Uz75gS9F5RvvYWeBBARBGABAp/B12+PfMbjSvWwSdsRhWjrCvEidfjFPsoBNJUi06YsBDOeohFCmZFiXsBNAl1epNPilgNDfWbvV9nf9+35geZDONp/keq5QOpjMMJvCmxDmAVL0J/roGLasT8Medn63jY2Fe2TiU7z6aaiLjBhQhCBOIe8Z3lRzanpd+WZmkaRuOV/Nut+BWrfPbB1B78GZ7WdJTb2KESp1gCBlTGO5SbJZX0+pQJiXK+b/xn7cdJWyulKm+KpPT5ROXmSH0K1O3d4MH8ibEntbNkRBSuB2lzXpRNf/9d2BURprNIUeHomYQL8wLWnFvAYcqEqQIJUKjKJywhM3lm0Ip2OEy1oDtw/QnD1RS480OgTwtO7M0mRbSOQU1AyCS3kLOMDSYzH
Received-SPF: pass client-ip=57.103.78.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Bernhard Beschow <shentey@gmail.com>

When reusing the code in WHPX, GCC emits the following warning when compiling
for i386-softmmu under MSYS2:

  In file included from ../src/target/i386/emulate/x86_mmu.c:20:
  ../src/target/i386/emulate/x86_mmu.c: In function 'vmx_write_mem':
  ../src/target/i386/emulate/x86_mmu.c:251:25: error: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'target_ulong' {aka 'unsigned int'} [-Werror=format=]
    251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~            ~~~
        |                                                                       |
        |                                                                       target_ulong {aka unsigned int}
  ../src/target/i386/emulate/panic.h:34:12: note: in definition of macro 'VM_PANIC_EX'
     34 |     printf(__VA_ARGS__); \
        |            ^~~~~~~~~~~
  ../src/target/i386/emulate/x86_mmu.c:251:48: note: format string is defined here
    251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
        |                                             ~~~^
        |                                                |
        |                                                long long unsigned int
        |                                             %x

Fix the warning by reusing the target-specific macro TARGET_FMT_lx which exists
for this exact purpose.

Fixes: c97d6d2cdf97 ("i386: hvf: add code base from Google's QEMU repository")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
---
 target/i386/hvf/x86_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index afc5c17d5d..fe44d2edf4 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -244,7 +244,8 @@ void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
+                        __func__, gva);
         } else {
             address_space_write(&address_space_memory, gpa,
                                 MEMTXATTRS_UNSPECIFIED, data, copy);
@@ -265,7 +266,8 @@ void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
+                        __func__, gva);
         }
         address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
                            data, copy);
-- 
2.50.1 (Apple Git-155)



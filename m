Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCB5C624DB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnN-0008Qj-RE; Sun, 22 Feb 2026 13:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnE-0008M9-On
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:57 -0500
Received: from qs-2007g-snip4-11.eps.apple.com ([57.103.84.201]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnD-0000Kp-4j
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:56 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 A75CD1800513; Sun, 22 Feb 2026 18:02:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783374; x=1774375374;
 bh=eGBzMnvYi2plqRMYS3s+jPbPqZ3R3tScJhTlruf1lkA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=CTp6YA8pv80Mxbaqnshst24Otnt3O8PFJAYFVwo5Eksb9X+O6gsq1MdvIUyQvvNvEpdD+iaTqysG8E+65YiMh3DZP0x64clRZG7KjxIw+5+K/9mQnrtl1YoAIjGSEF6nRlkyvAeXqg5rUx1KMhFJEf8cj5tFtTHkp1rlatLJhFuyde9zJUcsVqc8TBndwiJa9n4AJ7dWizVPYwwjNTs67qsCkQrrL7nnr4nYsPAcdbAzdo+16iZXPTKVNYCJPKXhK+F6vn930ZfyZ/Bb/kTECQ53tyvMxvTTjEmXunpX/R6LOsrfm8AzRCptFyMqmeSbMlXqn1rQNrRBfzEoaV+cDg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 81E6318004FD; Sun, 22 Feb 2026 18:02:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 02/16] target/i386/hvf/x86_mmu: Fix compiler warning
Date: Sun, 22 Feb 2026 19:02:26 +0100
Message-ID: <20260222180241.14621-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXwi33I5MC0HMg
 y31FlcITFFFZK6fsMLhvk7o6WfTxNOXRoB/Xq2y/qSAq7gaShCHyI3XYJtD8Xz82TE2md0lXxv/
 MJmnAQcKoqGnEBsznP9ucmlrbAfseMxz5uI7dmB9IDoxSdYJ1PQgvGRTu4pzV7F9PEDbCTmEhUF
 Xt4EP4w9GSEBMMiCYHNuyOO8zxD1pNPdjKWbBg8jWdFi8Ul2M3GXVKh2e0eGxopz8h6W3RgGQN0
 w3zaUxBrQlf1NgAMF2Lv3O9MwNgGQZ5IFlK+s1NEQHrCzx1BpS8DoWkTSXoNSRMza4dlVVnDKTJ
 uwly/ifn6v/2fX0AiCin+UTr+JBszihgoih73KoMbWs/BJmybJwB9VYBj8i+fw=
X-Authority-Info-Out: v=2.4 cv=Lq2fC3dc c=1 sm=1 tr=0 ts=699b44cc
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=VIwFDEqWtveBFbEZvHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MVTzU81Y_ePmOHkilDCrVC_yxsbwOQFN
X-Proofpoint-GUID: MVTzU81Y_ePmOHkilDCrVC_yxsbwOQFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0
 clxscore=1030 lowpriorityscore=0 mlxlogscore=935 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABgAtE/n3Vnkjxd6G2n6BtkiCmeK5w79D0c72UU8O9ZA0ITMTDDv5ajcmeQkAOb6yCJ4XkfqCwv0Dbuxsnq3p97c0iY04wmSaRzDn9VQwjAYqXAqIE4QXCiqHT7BpvLeuq5JDCpZWrljl2BAb290JRKRvYyM3wnjOLxj4vC+eZWAWufrr7YVNfs9wUbsPP9wKbGI2+bIiAmbAHks8cQDrVAgai7R8IRVhuEVYQOsBUviLGPQSihP1d8sNHvbdfnycLcXQrG3zOLLDk30nt1cMlt9P7yyiEpwvXjjlxDn2KbHDV6vuedJ+oNQILytfCaRT5mGDWl4Uttx9OzbzjIo9GSibWkNPz+OFmCeRDk8/Vp//XLHTpVKw/NpBoWBof0jJelJlBZuLxBpu1m6r/7WY/j1da8kKG+q6iNrs1S0j0cYysfhL4k9a6CijH5maGhFU8L1s34NvHrMs9hIovA/H3SRcpb3Tz5WBbNAldKpI57KbaL6YDi1+tDTRzbRdIhLni0wK64Oy5T4Km3TUHJjJHU0OTaw9yY+aGFJpouHnZgQ7HXE9Csgp6fc72pSr7SHiCBXC/Z6VL/wnTw+naO9YFmGBg+KTJnjR/+5wmOWwBRZ7rTJnPE74uFsQZiwQgXGOxpb3J9gQXIdK8U/IrIVxI9tEUPaNEGF17hFRYu1/ELZ7pF1FQTMwPSBvMGUgwBQLjdNgtj/M0m0TOjHYfX3wgGVg1JQhRP6mS1+f2Mp8y229TIQAHjqlBXBFIzN5pSRMLekxY0zS0WbSDpJMfB/r1kmsVwVtruWNNNeL7YgxsGxGdbPN/U739Uv/mIMim
Received-SPF: pass client-ip=57.103.84.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



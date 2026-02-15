Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB9EF586C
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUap-0000HZ-MI; Sun, 15 Feb 2026 00:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUah-0000G6-MS
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:44 -0500
Received: from p-west2-cluster2-host3-snip4-10.eps.apple.com ([57.103.68.153]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUag-0004qe-4Q
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:43 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 960091800130; Sun, 15 Feb 2026 05:22:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132960; x=1773724960;
 bh=GtzbZVMV9dNfEpH7m1Fk5+kjapOxKh+I1ihC/JEcyKc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=gN0/ivGopfF8kf1pnH3f+uZGE6uXM5jdahqusK+6P3VpDA8MCCocdMjTKCPeInGnWX7htRnGIfKaNZGcMp607OzmsNNSjknyjRd45Er/KzwAX0lzBTCeXy3dAXoZmvlbp3oUdzPGczTM9h4H3jHRnytflXclOdI1zQ4cixN7Y0Vdu911jTGTLew+uuXHeP5/m/3wo+ihuPIWPk3q1AjRcLiTxpCF5XtwaJL4SXFk8A9kle2NgY0wHMqMlHSrD6nCeAZ8hBponZDML5IxkCmG1kIQI7KbgVLZpXIoq+rqOZxLER6r0kLN6ytOYbyO6zARAmo4fWpdEcT/7csmFdlZ8g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 1CE301800139; Sun, 15 Feb 2026 05:22:35 +0000 (UTC)
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
Subject: [PATCH v3 02/14] target/i386/hvf/x86_mmu: Fix compiler warning
Date: Sun, 15 Feb 2026 06:22:13 +0100
Message-ID: <20260215052225.22513-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX895gXmUdqsot
 J2+TNamSSV9US6pLMoUCS4D2g3kUnMKf+el6BjdL9ksbvTW/1Nm5tnXO++9l8x4riPptgf/Gv/1
 yBZvKHO97BgRpvpmeAmU9Cl/1zTD0fz4iJGAE9kGV36dduYlgqnYKhnIER05BguRhs/QPVpIhJ6
 1tp/naXntCC1affRMLv6bGA8barEOEHUX8KuBEngyLADhI9SxymdcV+NYLo5fqv5+9nN9faSr8h
 PSS2UJFbQMxcPEKxfJvP0sDKTiFJdjZ6JupI2mVK7a1xc1j1m2zINJY9vvrXnuX+AZmD8PBIbbI
 k6bqmjnViwuku9ZbrPjyDzC0+S8X2IGbiFRLrnwaORVlhCoEzBfyDBqXmH7vpc=
X-Proofpoint-GUID: Mk1UuxbWVKbfeb8UiFRqfAgaHpNLGUwf
X-Proofpoint-ORIG-GUID: Mk1UuxbWVKbfeb8UiFRqfAgaHpNLGUwf
X-Authority-Info-Out: v=2.4 cv=EPILElZC c=1 sm=1 tr=0 ts=69915820
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VIwFDEqWtveBFbEZvHwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=944
 clxscore=1030 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABWLAi/VWOqYZRoaC/Xz6L95tLPoZEQawjtM0XxpiynWPYsb6h1D3S0T0YsJjgh7a5C+mUVMJ3pf6H5gnl3yWY1TdBin7lXo4YlR5amRlaGZtruumj5ds4fHMt1/mrtTe570WHolfRviCdg4+ll/J5SCR7etckp2TiTpYw02BqP6AUKhzYsZ+zZe7pq9se5Oe+AgyWbumNllRwjjJR6uzVKhVEFEACS+3xVc3M0dbivT0jq/D0/MMmndWudQywo9lYPypQKcZtFrgmSmrjJDASQmAN66BBgEWJnNtd7qy5gvPlaM7ApYVgGT1CTEM0Vmu88UqCXWiT8dpmabZlgnjBKiwO+gjOShbXAA7Bi9h20JeHX1p7RFH4K5PfN0w7wNHlyuXrZJxmbx2Ltwtou6ZZ4BC00BlN5dgqtfS7uXevxuZ+oarXlUXksD3l81hfSpzk3oY1BVfCadqjDB2erRq4QADdxT+d0SC6jVplrQMJfTv20QxKaie1WksM7IOVaQ7KD2CuNwOJj6S9dMJiBxxLfp72N0qsWHLjVbXnuoetNkdkPrxZI0K5Hg9HEvt/9PmtHkpoY5ov4N9FhHidNor1me9gDhCk37gStpCoNPQeHeDqy44KjDENTUnALnVC1fHrYv4Fo0Q/TDGT48phbigtd+0KEAC3QIrJxauCnVY0VyLI1X+dqDhdUI+eckpbYcKVXHeOk9v+lDwtGvnar094tqK0P4LhMQ4ky0BZUkgv9LsCjNU45cq8V9E8i2tzAHtWW9SyQXbxNWmz+0VHthjT3tKFOaBaPaqS/BWp3OvZLbSdatWh46Kf56sg4NqCjLDA
Received-SPF: pass client-ip=57.103.68.153;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



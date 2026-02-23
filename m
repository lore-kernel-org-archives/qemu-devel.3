Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC71EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufX5-00066S-OB; Mon, 23 Feb 2026 18:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX3-00065B-WE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:06 -0500
Received: from qs-2007g-snip4-8.eps.apple.com ([57.103.84.199]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX2-0004E8-EZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:05 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 D9F951800149; Mon, 23 Feb 2026 23:39:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890003; x=1774482003;
 bh=eGBzMnvYi2plqRMYS3s+jPbPqZ3R3tScJhTlruf1lkA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=bMlfxEeflR2wwWfVphNlzIE0YZWm9oMux8k3/slpzuITZsgCncDLFRAa/svYwKcvh3Jpq2ICbOV6TkW1yLrAo13wkQjRAkAs5c7yOhqtoMO3Dm5qVRnWgLatiXer9JJ9iWbYkNc6rj/EodKjiwvNxybNjUO+40/tozHLqCzEM2Sh8C2YUiFYqPrarDiRxMZsP2454hQI0hXbXTpwSlc3bB8RkmFGFfNG9XIAYPp1jDHBFDBHXJbemvAoiBChUF89jK22mKmLcW5wqCmY9RKbcuupELoH7k1YbDlJTfaFG+ART3W5NQ30SQmUM1BauOMo6h2LsaFrQPpLhLctlnTakw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 2CF2918003AD; Mon, 23 Feb 2026 23:39:57 +0000 (UTC)
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
Subject: [PATCH v6 02/28] target/i386/hvf/x86_mmu: Fix compiler warning
Date: Tue, 24 Feb 2026 00:39:24 +0100
Message-ID: <20260223233950.96076-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX/LqlWRJo1hlN
 YIKaUUStjnyc+Ezz3t/fCrzBuQqu9lCLT18tAeNHjYiuHSS0PRy91gMxxOF7dThDbTgpwL3W306
 aTqdD3RHzUqcvveNkdYJky2GCbR0AAA1PhUrGbgIxc8kuiJXW2ruAQeZZjpaIWBU6x7OLgkqGtn
 JG+2MtGOcOOagwh+UEXMmZKZ/bpjbU2Mcp/mnar0txApBaaCv93OoY1puJGLq0RHJ0jbzVqZqtk
 ehfUIr1LwsTJSFh3ACSueNR+RpKlxvtVSP0oBcWh3HgAG+xKQwBu/mfWSvYdDHvI6wXSXSjLKO5
 2GF22OSjqeF4VpmY1JC6P4rSixGbsebaVGkOtkBIdWlBLVsOQ+BulrjLDg3DvM=
X-Authority-Info-Out: v=2.4 cv=HpV72kTS c=1 sm=1 tr=0 ts=699ce551
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=VIwFDEqWtveBFbEZvHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SBbMa-Bil1D09mWdL804uKsVa3C32wbU
X-Proofpoint-ORIG-GUID: SBbMa-Bil1D09mWdL804uKsVa3C32wbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=938 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1030 malwarescore=0 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABiy/d9UElkPBy4H74Nt4fCOPXaMvOqOKH1Oc/a+gmlfhNuUKkFXcHTv038dZgZ6CruOHzqYul/LmtNxnylgjKcsp6GYk87+hR4GfSaP85eHrdEhpw9W9wqtDr//yVSJPZ7lpiZTdGKm4YK0a4MO6t51rpwBvj3WDHZ7XPSFYavOMvnOwiy3uieA1+t5AnLbpeq8VTvs4X0CGB50shJAcFxpWDQHgCfZIQ84Gt8mew6ROiphQEReB1IkJEUUGMs+faVJqka5m2xc5JLsWrhDSJObtqzyKWS4zpvi9xPVMAT/Kzy0Mvz5I3eV7hpMOYhQO8MqO1NRDeUaniZVJ3xOOTPK1JL12052a9A3LV3b4N6dWubhhEzbH2ReFY4kzIleS66ssxCl5uXk84/fUV8Yt81fEqwwTYR8Hr9FJ80qmOtpBM3kETKty6WlMFNE/rUaHMYpWV4qpIwMpJ2sAvgiMfrYvD0K2rEj7PozMJA1CH0/sytt+5yKveAGxoj9H+3J9SCyAhhE1s9Rzu5arJR6vMWVgXTwCBFsdNhg30HX/WyOSi3/aCYCwDyPNijHGBX0f0y4HSjxDizOFlFk2pAk1lysIb6TASG/BE2BX+Z421W0s2/d3AIoB4iIjK0/XlXqgLnNCVDrImy9anSiGmmXQxkFzO8fPsZVA5TCm7r5yvMadkPgmuEqW/0z3zmG/p5Tdbu0HC3mqbb/+TZjaP7YpyA8VQ5kHHDOL5Cza4szNsv9kbZynM7I6B3+4bhzfkawz8rkJYoLckIayiMV/BidPihmfaOr7nq6DMtI2qabURyQRrQyWNxpvdSvwqnyazDbTCByU=
Received-SPF: pass client-ip=57.103.84.199;
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



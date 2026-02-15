Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC26EF586A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUan-0000HM-Qa; Sun, 15 Feb 2026 00:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUag-0000Fw-BH
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:43 -0500
Received: from p-west2-cluster4-host11-snip4-10.eps.apple.com ([57.103.69.141]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUad-0004qD-On
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:41 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 5097B18003A7; Sun, 15 Feb 2026 05:22:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132958; x=1773724958;
 bh=QtB5IM5BAghTfw4VydIIrSdULvSeei+O6xHHjZ7ePFY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PaiqB263o+dFCh4g0mzLOEFKjo5OvdXiFGRo1mY9Bb/aDmgIhem7mMzGedAfyhwzXY5Nf5qOAhmBpRxfmo2rOCoRAmixu7RVzCh5uISDGhfQPoVEw58zHSitJEsVssoqixPIaE7cMQnoSe+Pf0blRtHFcG/hCUUAb1C0/LC9r3ouP23J5W2+lsZCWWug5XyMERI/lXhvDrhDsoqPQceQOjusZ9N4WpICDlM7mJHszNQOBINst4mDy7cJHSKjICfUrLWxPMNIieU8MmUDAYHKNb5imPkC9WLcYkpJUwwNB0EBhNjzDIGA4YCk96iFgEkk4bKnmcLmUScPuFTrUZxGUA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 A9FF6180012A; Sun, 15 Feb 2026 05:22:32 +0000 (UTC)
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
Subject: [PATCH v3 01/14] target/i386/emulate/x86_decode: Fix compiler warning
Date: Sun, 15 Feb 2026 06:22:12 +0100
Message-ID: <20260215052225.22513-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=cZ/fb3DM c=1 sm=1 tr=0 ts=6991581d
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=1g1V9cNuhepT8r8r7IUA:9
X-Proofpoint-GUID: XwUEs3hcw_O1sliJWqN2K722X_BF4L4Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX9Od3PVwji50s
 O6MQR0rklhxVX3mKrmEEUHorYvZQeBVdV1034+GVW92bwlaYVPZic2Z0hLG0VaVecVWej5uG01B
 w1FL2vQhvu+ga1TYdlTQMEYHB3wLSCBKRwUevUhtDOap9zT9T0JEpeVeKpWkzPQ8ZVsB9u49/1m
 WSKEGBJAyTUTUaQ7NE6HG5dbADfsC/JAqHzhifqEiVYjpc31iYpW/opn22pxiYsUxHctlIvxSWq
 z/ALgXu3ecr0+3fROXCc89U6tmnihJp7cVFtp4nHzqORWd+YC7nrRyc0sXAOQS5I5Q/f8DKYjhm
 vMZtYK8c4CDm00802vuWIVI5Stsnzn8XrIql4QYEZ07K/EldgcMUUft/Vb/V94=
X-Proofpoint-ORIG-GUID: XwUEs3hcw_O1sliJWqN2K722X_BF4L4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 clxscore=1030 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=791 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABaI2wdvfq7k0JyGZszqcAbZ9kC0Sh9VE5K0rkv6NrwX9HYKo26lM6X12VkAT3ovxiN216+Urb/GyU2P5qUMzfkcpA1Y3nq5Jb1mEKlfyzT1euhBv4fpU+tQH8BNALru7h5giuezC3uEtbD39diEiimlpE4h+jBI37cG+DsDIeg08lb7g8NWDrP1kNHxzUkGsYO4d2dtVdP/mGImpmtcs83xdJd0sX7rXky5x1dSYmMS69j+jxHx/Ey1IKxR9pf4ZV/w9mJgQfVmIMEAcz5/PuvFxvrFGzPb9nlac7sEpCXjEI8oz3t2s8OoA+Eb04uq89t0rJxz3wggIMnTckbiu+0x02hElxjumsZQzJcrBnr2pqr3+dPwhfYx5LTfyrKqtp39V+KyeDkS+hXB1MXt08RIpa0TvBjKCUihXgCT3z12q2b8vYm6f34iegpiO6n3M+MOHLZwPg/jPlgtwjhJUoUMzGFw/rYLD3HrEQHGCR1JxHefcSaD96AzBMisdEwzgZjdOYflDZGmRM69Elv+YCt1nya3uWQrB3NR/LRjx0LhZHHAA0HrhHCSvv/13B4tnZlJuEnvxh0bR7MgQK4DzoTIo4R8nmvvPlbV7rvuEkLxrhQXkt9OQPIJou/mJcwZ3cc+H6WrLywQ26ql8nbYKcrKo7v5fzS71HRowGpkvBS49owLDmBeBwIh+J+7YsomvjYBGfCEeSlVyhMDatDibyI+t7CFopfFf0Lh8Beoz2OqZO3uI3gKtB+VM1ZkTvA/Q4Cu7P6qN25WOGay4jwSUBWAGVcez75OmAPjw7Q9PanuNA5IpNVwLdWki5BIvAnN/XazVb2vYJh0SM6g==
Received-SPF: pass client-ip=57.103.69.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When compiling for i386-softmmu under MSYS2, GCC emits the following warning:

  In function 'get_reg_val',
      inlined from 'calc_modrm_operand64' at ../src/target/i386/emulate/x86_decode.c:1796:15:
  ../src/target/i386/emulate/x86_decode.c:1703:5: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'val' with type 'target_ulong' {aka 'unsigned int'} [-Werror=array-bounds=]
   1703 |     memcpy(&val,
        |     ^~~~~~~~~~~~
   1704 |            get_reg_ref(env, reg, rex_present, is_extended, size),
        |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1705 |            size);
        |            ~~~~~
  ../src/target/i386/emulate/x86_decode.c: In function 'calc_modrm_operand64':
  ../src/target/i386/emulate/x86_decode.c:1702:18: note: 'val' declared here
   1702 |     target_ulong val = 0;
        |                  ^~~

In the calc_modrm_operand64() case the compiler sees size == 8 to be mem-copied
to a target_ulong variable which is only 4 bytes wide in case of i386-softmmu.
Note that when size != 1, get_reg_ref() always returns a pointer to an 8 byte
register, regardless of the target_ulong size. Fix the compiler warning by
always providing 8 bytes of storage by means of uint64_t.

Fixes: 77a2dba45cc9 ("target/i386/emulate: stop overloading decode->op[N].ptr")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index d037ed1142..6ad03b71b0 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1699,7 +1699,7 @@ void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
 target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size)
 {
-    target_ulong val = 0;
+    uint64_t val = 0;
     memcpy(&val,
            get_reg_ref(env, reg, rex_present, is_extended, size),
            size);
-- 
2.50.1 (Apple Git-155)



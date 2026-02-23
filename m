Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6796DEEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXd-00074J-5E; Mon, 23 Feb 2026 18:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXa-00071X-VV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:39 -0500
Received: from qs-2002g-snip4-7.eps.apple.com ([57.103.87.198]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXZ-0004S9-FO
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:38 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 1FC931800161; Mon, 23 Feb 2026 23:40:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890036; x=1774482036;
 bh=sec6CMnKYJJI9y5Wj8/7I6YJyCwv3268OSQx7dh58iI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cCveOVcpednxcZYWpCo5EHKnqguYRFqRFxYi6p0cP81MZmjjHTLYGGZvePNtwPvDxKax4TZPJpWOzJTuKGHKGXnO/RGmztOFF+QuNQqzdeuVdQyAWaX1DIbjP3+gEiKL1vrJES5xmiHufh/PG079tCmGLmPPYdkyCWvUDO66o9MGxPA4KdAqXPM0Zb1reoGe3+UY3Mr9aq09ePOtxmes+Rx5y7ceaFkOonZYYd85kdJ8RdXhIBBwxfs6llNTRAV33F9WXBG5USE+ke6CKJwcY9h9l6nv8zBCiCPL6Wak6J1EeFt36EqGOhe9IGJ+iM9E8DLiJ+aA2N7YM1ijWJ+H/g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 2AC2D18003A8; Mon, 23 Feb 2026 23:40:34 +0000 (UTC)
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
Subject: [PATCH v6 21/28] target/i386: emulate: get rid of write_val_to_mem()
 helper
Date: Tue, 24 Feb 2026 00:39:43 +0100
Message-ID: <20260223233950.96076-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX6c2f7ysW+vHK
 LbNO5Xj00eCF33jrMX9wY7gZM/3ajPbb3KQ34vgG3ax8aMrLRsf44CJZc1l0eKfNQLbjWZqe8Be
 sN62R3rDLd1VyFN5TD/M4UwyytfzxuMne4+ifYzuBQ0VE0eK8O1s73e5z1xV5j1ul1ULBUqD1lK
 D6knkxbkThn1IzkYqj9UsDqMAJOBNa8eNcoXa+LzaoLAtkTYh84PfUQhnHACttoGyYpRi4LOitN
 J21LMkJ4ALwAFoyzR7bg7LIYijDdVbhQ/gZ1QxRL1DLfVaNiJHv2YdnOj/nlQjBfO8aY97zijP/
 W5xB9WvO99ovko5I3m7cv3bKui8thZtzgHCWDLzTujrduyEUwXh6VqAhngyHFM=
X-Authority-Info-Out: v=2.4 cv=VPjQXtPX c=1 sm=1 tr=0 ts=699ce574
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=X61gGJnvCjtZcTrZb8IA:9
X-Proofpoint-ORIG-GUID: RgFGYkRxe83aMsNj4ccOokBORpj8XFEr
X-Proofpoint-GUID: RgFGYkRxe83aMsNj4ccOokBORpj8XFEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=860 suspectscore=0 clxscore=1030 lowpriorityscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602230206
X-JNJ: AAAAAAABRBLcM7/ErXM3v5oi+lRGNiAvaKzthW9agut/019oMxs797nkrmEFvTre7ZPlU0rY4uBLNf6QhRXXir5LH0yKU2stWe3DOGe7FuNs6qKy7+hfr3aekf1d6h+SNkcMKrJKpdermXtQ0KvtZ5Bl3kz9wFAsMCgxVcYHADYdtsHlSh3sABoncdOM02Q1UhHEMO9mvTPRKBmw8NijcnmNIl9xa+EWhhALzi5vYA5ewcUYUtFw8CnoS+M064TR270ujeX7EMsaLB8HnPSOJI9MutX4gmsIond5IoIh6K6X1qjasD9Nw/f53HLB7S/hH6x5VvNg2eUnfdGa4/+pfCdi0AJVBP8NuckP08fjidWqcIeHMi3lPqA3CwQED4HbPp18FUWu8tuvRureSOv/bXmqzJl7ZVl8XJCrhtph2P8MgxNCaRTpVy5dJcCnHPd8jHrCiJLg8gBLrN+abSsrczKHnaVvL5zdn4Nv48phtQzyMai2BOEEESXWqYsu44OIjO+COQ7RUcSCF21FCShB8WjHSkwUrtFzkxy93AI+sPY0LlWMDc5WpJ+I6GtqEz/WTvo8OkmHrtkeYRFwEHiE1WsRDN9poAGNRJH7LVA8aBv3hlPAcgYo9BckpBZBIN4ct5KNkT/s08wdSiYjzbcc8FGqi76laFcGqbbcnW+RhlYScQkiaUx2HinU7mFpLVXUNAo6uM8l9kLoldkAbay0+1awIA0ecD249kT9MkBEMHcGckj7xLYCgV/Xh8pxjufRwD+JhtrFsHVSQjvmGnpSlWBc0Xi0Bw4WexkWvaMA1ALCoYYyPegOhmpayb1GqB8Hx5ondMqP
Received-SPF: pass client-ip=57.103.87.198;
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
 target/i386/emulate/x86_emu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index cfa35561dd..3aedd638a1 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -164,17 +164,12 @@ void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
     }
 }
 
-static void write_val_to_mem(CPUX86State *env, target_ulong ptr, target_ulong val, int size)
-{
-    x86_write_mem(env_cpu(env), &val, ptr, size);
-}
-
 void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
 {
     if (decode->type == X86_VAR_REG) {
         write_val_to_reg(decode->regptr, val, size);
     } else {
-        write_val_to_mem(env, decode->addr, val, size);
+        x86_write_mem(env_cpu(env), &val, decode->addr, size);
     }
 }
 
@@ -548,7 +543,7 @@ static void exec_movs_single(CPUX86State *env, struct x86_decode *decode)
                                 decode->addressing_size, R_ES);
 
     val = read_val_from_mem(env, src_addr, decode->operand_size);
-    write_val_to_mem(env, dst_addr, val, decode->operand_size);
+    x86_write_mem(env_cpu(env), &val, dst_addr, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
-- 
2.50.1 (Apple Git-155)



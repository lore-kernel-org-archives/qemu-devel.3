Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C0CEEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXQ-0006tO-Bf; Mon, 23 Feb 2026 18:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXN-0006qB-T5
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:25 -0500
Received: from qs-2002h-snip4-2.eps.apple.com ([57.103.87.203]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXK-0004PI-Hs
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:25 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 6581018003AB; Mon, 23 Feb 2026 23:40:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890021; x=1774482021;
 bh=fg6ASREgM8H3KqayXNpjqghODmRREAt5H2XvAof8pXs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=e45eEvcpfHESNlbZjtt+wv8CD2cGxAJciA2jJwxYCQ5yKPkM+qcfKt0Ahz10DxSPg1eAJBmoZuJ641idQabK9k74YQV1oqO4LFmozRCK9QDhWOogYCfcazb1MVQzbK6sfpaa5jDlofRgMwwS6h+QS+KzuxgxPw4LeMCaJ//cBZT0FzN6tAHiNf4N/91mRaQ2CVlIvXzD9/Kvg0oLQH95zL2tZfd95A+DVqxemSv3TQCD36aIKCc9uZhT+WFEKOZKlJFtcQkK9bptoug/8qhF3Vwl/Mrzcf5WI1MrSUFg0XjV/T/iZZQ9cXnqVSaLX+VeM28KaByzVLU8TQm7TNzbrw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 A800B18003A8; Mon, 23 Feb 2026 23:40:14 +0000 (UTC)
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
Subject: [PATCH v6 11/28] whpx: i386: flags conversion for target/i386/emulate
 internal state
Date: Tue, 24 Feb 2026 00:39:33 +0100
Message-ID: <20260223233950.96076-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfXxR2Cm99u85nj
 MHjNnnbCdIZt4tUcJwCIEt6fD5b1Ng8TO+irnRcCvqAgW3XKIwRzM3NZZtAn1SvEo4ocAPGAR7l
 SFh9sHRDVhJhUbLcvVlKMhZfrH+9bXJXXptqEzGEedpk6YdPuT98wdBW4hwV8xEFnCEkVSqkOkl
 6BMCeznjAf+euIZn5jGt+A9hNn7rUXNX2AC3tjKoZuf2uusZhYijPrSQKHfeoY03DpQ1j6tpgsX
 yu88AeXWTbPXoqMh5sijuEPkDRYfzHaESImYJYN9t2MC+iIh6kv5dY7Wb6sOgMHfRmudyCGvrdu
 y2xwS7W5l5rRRV5f2ffR4PRt9n0H2+MG7CAodPJxapCmv5qWcaa33ce40n3zVs=
X-Proofpoint-GUID: f3DsMulqSm7k-REuwsBQxbxnSZyQs8g_
X-Authority-Info-Out: v=2.4 cv=C/PkCAP+ c=1 sm=1 tr=0 ts=699ce563
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=GO8j3Qv1z8u8_yQncx4A:9
X-Proofpoint-ORIG-GUID: f3DsMulqSm7k-REuwsBQxbxnSZyQs8g_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 lowpriorityscore=0 spamscore=0 mlxlogscore=817 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABNr/LmIF1Nh9Qw7RPM4TJw6jO7QRU6C2MlAH+mkdVgouHLgA/X2uhmGDawW7Zh2W9EGhO14YwSpfEIGkUuoPt0h8mVxSdvcTa0iaKwGzjSUHRuvCYq0gRdPQwERj7uND5MPTZb1Jfsqmu4SG+tfdKN8q4FhSE5kszz1Si8q+wAsYMs7VP6cfchKQFTuX8xxEbc6I7q0p0+h6wUaxPq/IjuEigk0EeG0THLLzwSDZpwZCBQ9yfEim7IG41YAPM/YbMLVFm5VRju0DAC/MhXcAILCNiVH4OE8Rc0IhM8d4OXAtDXGfoY35hz4wbNxQOstdhkFYo3N+a1T9MQL9xvZyNKfkMeIx3rPC/1wj3rfGoKZIw+aVaZXDRmBKGfJDMs78EmMHOAvYILTwCoOS9WZTSxViZ4+fIv1aLlCJVLlKscCz+03uPEDMBNk5z93h5tTULWBnNL3ZcZIVuxf/74tNWykARDDnVvV98WjDSVDWInVg05IYKvTMgK6DzFxWT/sHPd70bdG2f5rzh5Stsl4E/jkz/VL96MuJ3Lotm1omENbdohIYQh413j/hZ3IRElBheAluzc+p+i8R79FF7iuHu3n74W+Cc2YNguk73Lx4IbhHAnzHGcsUxCb0xvNujC6Zv41BPVWm7EoScS2ha7xsUUQJAQZ8+fiui4ZHZ9zIlK7x+pWOqXlLZ0MXcuhZKmd2AX5pR6PX5+sZqwqLRldSgcYv0hBrBvv+tnohKbdrqYtpNjl/rGraB3/I522GbZuaKX5T4o6C+Kq3eiiZlp9rG/8PsM4jVARdK
Received-SPF: pass client-ip=57.103.87.203;
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
 target/i386/whpx/whpx-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index eb6076d2f4..0524885053 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -412,6 +412,7 @@ void whpx_set_registers(CPUState *cpu, int level)
     vcxt.values[idx++].Reg64 = env->eip;
 
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
+    lflags_to_rflags(env);
     vcxt.values[idx++].Reg64 = env->eflags;
 
     /* Translate 6+4 segment registers. HV and QEMU order matches  */
@@ -637,6 +638,7 @@ void whpx_get_registers(CPUState *cpu)
     env->eip = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
     env->eflags = vcxt.values[idx++].Reg64;
+    rflags_to_lflags(env);
 
     /* Translate 6+4 segment registers. HV and QEMU order matches  */
     assert(idx == WHvX64RegisterEs);
-- 
2.50.1 (Apple Git-155)



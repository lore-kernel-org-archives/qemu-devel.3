Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786BAFD0040
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9m-0004EM-DC; Sat, 28 Feb 2026 16:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9i-0004CT-Hf
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:22 -0500
Received: from qs-2005d-snip4-5.eps.apple.com ([57.103.86.166]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9h-0002V4-6a
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:22 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 10505180013D; Sat, 28 Feb 2026 21:47:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315240; x=1774907240;
 bh=lfrkVypbIXt+OmEJPfA0qbh7rrK7NSWT9WdXrP9x0ww=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HrqwZ5KpvA6gMj6vKQCy3zNx9gJEJPw1vf2bnKf8rmZu1Bhb/ziUk1QN4wlUssXwDaJfftQvOnpS/F8ij6H0r9jdgRsq9zw+wwDoSDuwuuENbqpsde40KWicgoI7iIicj7wG4ues02KLCjkulimRBpQshb15WoYFUG5HCmKywv2wdlSzMNimysseee7XvKMOsdMPvXMvrqHpnebycWv7a1CKyUsM6WRmVpk41aspgxXqiDxMvd4tvS0Rk1zOA3LgIsglWl7YWho+J7v4pN9ljGAxUaVgOsbtdA8b3kIY4edsaxMuK9+JFcMz+CX3dZlFt/NoHJs6IDBZ8HcXZngF8Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 2E0861800114; Sat, 28 Feb 2026 21:47:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 8/8] target/i386: emulate: fix scas
Date: Sat, 28 Feb 2026 22:47:04 +0100
Message-ID: <20260228214704.19048-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=69a36266
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VLX2UGPRQwTXjk7uINwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfX64XrjbRAsYtC
 +h6YTajBA9XM2ng4tIOoBeiIp231zkx76NmwwhcSAkWuWzo6ItSgY5b6RNEexX1I35YM8JoAsdO
 ac9hvcHbCkz6XhDSJ2wfgWkLyNwuBbDM6jIQKRieH2dDT1/7TD0n3R9eo/9Bqtga+jMLOipSYEq
 gAPwiIIGsEYNh/GU0ddS849JzpzFNDFlH5a8fCVf+nJ0O2CWE+f23PIXsVpRLTakQw8QWHiiDsK
 bfa2OvUVj6dLwwGLpOwXPT4fUfXwWgKXYhrZDhqJVKYHH3T0PgkyvA4K3gWiZHJ/yPT6aUMQ0mj
 g0KVopX0jwvKL+F+eQJj+WGVzViizqyl8nvc9kB47hML77ILO8Lxb3TfAbjuKY=
X-Proofpoint-GUID: TJpeEPT7pQeQoNbKIgMbpEBQ6QoUHgrW
X-Proofpoint-ORIG-GUID: TJpeEPT7pQeQoNbKIgMbpEBQ6QoUHgrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=740 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABi/AUBT6tqxfjaPw5H6uR0DtQk/pDYjB+6DmtGavfsiKvwM4r1vRR9LAwNGbjuWjtvunLzKZBAUbvhFsVwMfUbArDs4+RS94ECheUiA25b20S5na6lqZHFtlitAhsq1GHZ+KarnH+8BCuicUSJRlErmTb1HuMpCLQ1neV2KuHOQZJUMtD8H/aNwbQ5FYebfnAt7vRSj/V9mLFtkVy/43rBj9J3D1nPnx2Axrh0UUM1FTHlKbf467lb2SOXdTrNCTdc8nwdcZO5ElWxauQVrTmABufSpj6ZYr6DYMUbF6XD39cnFDWeirhQsZFFlarDWxdTKOtKZqHL88hSYX8I2sNdQcmKX3kq/3nFNfJxyZA4LW22E2zUMtJfZQ5DdnHSlirrCOfVPIW+KwkOQR77Kc+hwEcFuvYNgDOeiEzcvheuLGBfVk4+tJSZiuYEm+cwUH2kGSZf53OQvB3L6dTxnSiqLwOozkRU/sjLUE7Pqp20+yVdIFD8N/EiMZseAnvEuJ75yPCvoFK89U6RfPGRgREa+r9noE5GXGU03DkQvpY9qEyx8Yp4KHaMpC9sMz3EYxFagEwCXygCtH23Zswxsy0xx4kh6AiELv6zPaJ34ka5+ODL9ZUjaO6PwfHvFw+orbxP2Dq8Tk9uQDMWiDuJOYFVxWmAA==
Received-SPF: pass client-ip=57.103.86.166;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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
 target/i386/emulate/x86_emu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 6c4ccc4538..55b1a68eb6 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -745,6 +745,8 @@ static bool exec_scas(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = R_EAX;
+    decode->op[0].regptr = x86_reg(env, R_EAX);
+
     if (decode->rep) {
         string_rep(env, decode, exec_scas_single, decode->rep);
     } else {
-- 
2.50.1 (Apple Git-155)



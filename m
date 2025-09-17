Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BCACAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuav-00041l-DQ; Wed, 17 Sep 2025 12:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@kubuds.cn>)
 id 1uyraK-0005YW-8c
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:48:33 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@kubuds.cn>)
 id 1uyraD-0003Ul-0u
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kubuds.cn;
 s=reyb2403; t=1758113264;
 bh=x6PenYb2OYO7DzPSgQ8aaHOUIRmM43ePGDREyY/1fVo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=lzmeFv0dyOLa/tsBguW7baCxJN3bWRO8kvnZ5bxXOfjYDdLytDnPTS3dcegW6R6cg
 Vk30RctssPoFvq+lS56KPjwb1SZM0TyNWC4ij5rleFrS9uGhMVpxRJCnEU8wx5TtBY
 DFb/BIAmssijzhpv51bYdJnrQGcS90ws+X2KVUhI=
X-QQ-mid: zesmtpip2t1758113258t8ce094d3
X-QQ-Originating-IP: wRUuIu67yMSbAyqUUXkUFVaVcPuyWx9rRsCr3WtmfFI=
Received: from liww-ubuntu.. ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Sep 2025 20:47:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 403894999039657497
EX-QQ-RecipientCnt: 8
From: liweiwei@kubuds.cn
To: richard.henderson@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: kasperl@rivosinc.com, wangjunqiang@kubuds.cn, lazyparser@gmail.com,
 liwei1518@gmail.com, Weiwei Li <liweiwei@kubuds.cn>
Subject: [PATCH] accel/tcg: fix self-modify-code problem when modify code in a
 single tb loop
Date: Wed, 17 Sep 2025 20:47:06 +0800
Message-ID: <6F6BF0F431B23852+20250917124734.443966-1-liweiwei@kubuds.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:kubuds.cn:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: N1R4WepIe4yL2Z78mJWGifio32eI50/k8Jg74jeqmQ8Ig9E5vGHEEuVa
 dFsRsJivnioDtniGTUlZllsTO9oIjOBUVFd18NjjFG2IIZWHncDDYtbrrih9x4a4lkof9tz
 wcdH7LDj1Fm7i+1eMn4bzh/IjSaqIxY8ZsoTBZE3wXRzxngyXPJsuyjgaNqULpnpqIb2dHl
 gTj1N2d4jiKcabNrLBQEEMcwFi76g1tYw+DRqSjDGecGZ5VTMSCh3Psrv8iakx42/Sjfijb
 ABIc3sTJVjEZVec066UXg0Y6Pzh+eBAJCmbU3+VlshqGHBM105mDF1dXZmlxftNWZF5fI0a
 QFA2GM1Ul8gdfqjS8slPyNdK2JW7dCGJ6SRefOYf0EEOygmiBqc86cPmdHpimiMLATNApy+
 A67/BDF1PWfvRJNd23u2G+ArhEfoq8NV8RVjetL5q8MqoVFgRjE4Uc5mEjcGBLx6x6XNlwL
 tnBfrbpldr3VM3GYQY8y/mnC7rlTH4U8KTUbM+oFHIabFvLqJhBuCQfTDJXCghcuP7iMsx8
 1ONzUyhlbr5HTI6qmbp8SrWJIiqnAH8ByN8JdVVurHluM45lppsoVcyvEB2xrjyPen+T7Sf
 K2K0+3wGhMLl9iZe3WSC8LkvwbmIUcH3o0DO+fAAglQ+8Bq/qF3XiO2edB8TR9By3AEO9j2
 fyazShBMUF/mHwPYBQ27xxbBM1afT/X1rpyX/T9UpoKrAcAqq7cnlApgk3epIDCMpVjPY2P
 jG7FVKvGdZHXiS2fDlaONJ97IRnQR8sKIEtu7JNWd+WEhXvXGQirj53PO8eQPO5+fmi0wsJ
 /ICZz6Mi4e90L+rTCVg+HyqbNECpWceE+6l68maPehPN4c/8iNQFNQoJIPX2DkcTFWBfc50
 zhe/hO+IkgNAGw7aDAhjMIi2xhB91KnSoDjhxx5QHudEdOLDEjG6pxd24Ry5umGb8T9Co5O
 C86PZaquOwbSbgf2H0fnI20Gt2Xw3QjnxSTM3rBHkJQqxtGaQbGgecKE4iLUolYmgyj0z6w
 n+5ezgSlbSUop9Qke/pCuPWAqtIwrqBfM8tAW024KKykYcdZdX9S76hcDjdSVDr7et45Cw/
 zghotskeeT0wVpZCKhoNAw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.243.244.52; envelope-from=liweiwei@kubuds.cn;
 helo=smtpbguseast3.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Sep 2025 12:01:07 -0400
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

From: Weiwei Li <liweiwei@kubuds.cn>

The problem is triggered in following conditions:
- thread 1:
    run spin loop(ended with a direct jump) like "0x0000006f, // jal zero, #0"
- thread 2:
    do something, and then modify the loop code of thread 1 to nop isntruction,
    finally wait thread 1 exit.

The loop tb which is patched to jump to itself, will not be updated in this case
and will never exit.

Signed-off-by: Weiwei Li <liweiwei@kubuds.cn>
---
 accel/tcg/cpu-exec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8491e5badd..6919d068c8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -973,8 +973,12 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                 last_tb = NULL;
             }
 #endif
-            /* See if we can patch the calling TB. */
-            if (last_tb) {
+            /*
+             * See if we can patch the calling TB.
+             * To make self-modifying code work, we prevent patching the single
+             * tb loop.
+             */
+            if (last_tb && last_tb != tb) {
                 tb_add_jump(last_tb, tb_exit, tb);
             }
 
-- 
2.43.0



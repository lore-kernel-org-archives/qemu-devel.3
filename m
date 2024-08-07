Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C115C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 13:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbgPg-0001a0-Js; Wed, 07 Aug 2024 09:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <JianZhou.Yue@verisilicon.com>)
 id 1sbcvq-00046B-Os
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:26:12 -0400
Received: from shasxm06.verisilicon.com ([101.89.135.45]
 helo=shasxm03.verisilicon.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <JianZhou.Yue@verisilicon.com>)
 id 1sbcvh-0007uE-Lg
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:26:09 -0400
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
 c=simple/simple; t=1723022002; h=from:subject:to:date:message-id;
 bh=3bsNm+7j5zL5P0y+DNmnlJVwBC1tVVTjL7t83RK74Sg=;
 b=QBy5TXycLkpvOBiMF527GLOx2kzCDISKr1JIu2BjDW1yylU+ewn6KLeVw1NjNOUIEHaxpJHmSww
 7JiSGF37FnFcAO7t01n627Rrf3CTFUvgnTOJxJPu+zxODwLtnuLQL9ctiPpxlsuUPZkSNZKFQsqsX
 deLlfgmUQZtw0fhA7yc=
Received: from SHASXM03.verisilicon.com ([fe80::938:4dda:a2f9:38aa]) by
 SHASXM06.verisilicon.com ([::1]) with mapi id 14.03.0408.000; Wed, 7 Aug 2024
 17:13:22 +0800
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] hw/core/ptimer: fix timer zero period condition
Thread-Topic: [PATCH] hw/core/ptimer: fix timer zero period condition
Thread-Index: AdroqgyJa7tdFWP3R9WlCLKb3WaZeA==
Date: Wed, 7 Aug 2024 09:13:21 +0000
Message-ID: <3DA024AEA8B57545AF1B3CAA37077D0FB75E82C8@SHASXM03.verisilicon.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.166.198]
MIME-Version: 1.0
Received-SPF: pass client-ip=101.89.135.45;
 envelope-from=JianZhou.Yue@verisilicon.com; helo=shasxm03.verisilicon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Aug 2024 09:09:10 -0400
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
Reply-to:  Jianzhou Yue <JianZhou.Yue@verisilicon.com>
From:  Jianzhou Yue via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The real period is zero when both period and period_frac are zero.
Check the method ptimer_set_freq, if freq is larger than 1000 MHz,
the period is zero, but the period_frac is not, in this case, the
ptimer will work but the current code incorrectly recognizes that
the ptimer is disabled.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2306
Signed-off-by: JianZhou Yue <JianZhou.Yue@verisilicon.com>
---
 hw/core/ptimer.c         |  4 ++--
 tests/unit/ptimer-test.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index b1517592c6..1d8964d804 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -83,7 +83,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adju=
st)
         delta =3D s->delta =3D s->limit;
     }
=20
-    if (s->period =3D=3D 0) {
+    if (s->period =3D=3D 0 && s->period_frac =3D=3D 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
         }
@@ -309,7 +309,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
=20
     assert(s->in_transaction);
=20
-    if (was_disabled && s->period =3D=3D 0) {
+    if (was_disabled && s->period =3D=3D 0 && s->period_frac =3D=3D 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
         }
diff --git a/tests/unit/ptimer-test.c b/tests/unit/ptimer-test.c
index 04b5f4e3d0..08240594bb 100644
--- a/tests/unit/ptimer-test.c
+++ b/tests/unit/ptimer-test.c
@@ -763,6 +763,33 @@ static void check_oneshot_with_load_0(gconstpointer ar=
g)
     ptimer_free(ptimer);
 }
=20
+static void check_freq_more_than_1000M(gconstpointer arg)
+{
+    const uint8_t *policy =3D arg;
+    ptimer_state *ptimer =3D ptimer_init(ptimer_trigger, NULL, *policy);
+    bool no_round_down =3D (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN)=
;
+
+    triggered =3D false;
+
+    ptimer_transaction_begin(ptimer);
+    ptimer_set_freq(ptimer, 2000000000);
+    ptimer_set_limit(ptimer, 8, 1);
+    ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
+
+    qemu_clock_step(3);
+
+    g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, no_round_down ? 3 :=
 2);
+    g_assert_false(triggered);
+
+    qemu_clock_step(1);
+
+    g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 0);
+    g_assert_true(triggered);
+
+    ptimer_free(ptimer);
+}
+
 static void add_ptimer_tests(uint8_t policy)
 {
     char policy_name[256] =3D "";
@@ -857,6 +884,12 @@ static void add_ptimer_tests(uint8_t policy)
                               policy_name),
         g_memdup2(&policy, 1), check_oneshot_with_load_0, g_free);
     g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/freq_more_than_1000M policy=3D%s"=
,
+                              policy_name),
+        g_memdup2(&policy, 1), check_freq_more_than_1000M, g_free);
+    g_free(tmp);
 }
=20
 static void add_all_ptimer_policies_comb_tests(void)
--=20
2.17.1



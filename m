Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C780EEDEC14
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfjc-000064-On; Wed, 04 Mar 2026 01:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjQ-0008Fy-Dd; Wed, 04 Mar 2026 01:29:18 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjE-000580-K0; Wed, 04 Mar 2026 01:29:13 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246SbBP071191
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:28:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kEjoFE/z8v1YBz7rlA1tyZsjYl3ZY+R8+UlHKj3jxpQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605724; v=1;
 b=Hop2eBHVAochxYlzcSAtBAAV/I6v6yqQ0va1Do2f8eJyYH2O10p8gez4NbG2+uQ6
 5HUFALYaTw8vdcbfgZNV95McgaBvPDKNPeqlIawX1mUtkUz76HIrnBNIPj+52Pp+
 E3Er3hx0ZMspTTw/kyuy2PZ/Zn8wYcIVezTIiobCTGBypzkOXnxBY2llI+mQ5JXc
 CDFvs922qou6V+6n4Sgi0zs5zeJ/2KDTgPA2LKF5JNJQvoCKNx/NLTojfpSfNgn6
 IfWw49JhLB5xLGteXEBNjnq6X9mZ8Ux3qySTZP1vIwNT9eJgrMT8KFMyeF0SUtKi
 8m5aIsTxvyhONo8u9n2LwA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:28:35 +0900
Subject: [PATCH v3 3/4] tests: Avoid sprintf() with "%.6f"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-nvme-v3-3-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

A string that represents a double can be long if it is an exponentially
large number.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 tests/unit/test-qobject-input-visitor.c  | 8 ++------
 tests/unit/test-qobject-output-visitor.c | 7 ++-----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 84bdcdf702e0..beee11db4e47 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -500,7 +500,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
     g_string_append_printf(json, "'number': [");
     sep = "";
     for (i = 0; i < 32; i++) {
-        g_string_append_printf(json, "%s%f", sep, (double)i / 3);
+        g_string_append_printf(json, "%s%f", sep, (double)i / FLT_RADIX);
         sep = ", ";
     }
     g_string_append_printf(json, "], ");
@@ -583,11 +583,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
 
     i = 0;
     for (num_list = arrs->number; num_list; num_list = num_list->next) {
-        char expected[32], actual[32];
-
-        sprintf(expected, "%.6f", (double)i / 3);
-        sprintf(actual, "%.6f", num_list->value);
-        g_assert_cmpstr(expected, ==, actual);
+        g_assert_cmpfloat(num_list->value, ==, (double)i / FLT_RADIX);
         i++;
     }
 
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 407ab9ed505a..3c47b28f6638 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -538,7 +538,7 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
     }
 
     for (i = 31; i >= 0; i--) {
-        QAPI_LIST_PREPEND(arrs->number, (double)i / 3);
+        QAPI_LIST_PREPEND(arrs->number, (double)i / FLT_RADIX);
     }
 
     for (i = 31; i >= 0; i--) {
@@ -571,12 +571,9 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
     i = 0;
     QLIST_FOREACH_ENTRY(qlist, e) {
         QNum *qvalue = qobject_to(QNum, qlist_entry_obj(e));
-        char expected[32], actual[32];
 
         g_assert(qvalue);
-        sprintf(expected, "%.6f", (double)i / 3);
-        sprintf(actual, "%.6f", qnum_get_double(qvalue));
-        g_assert_cmpstr(actual, ==, expected);
+        g_assert_cmpfloat(qnum_get_double(qvalue), ==, (double)i / FLT_RADIX);
         i++;
     }
 

-- 
2.53.0



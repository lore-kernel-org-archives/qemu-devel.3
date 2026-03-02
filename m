Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDA1D58E79
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 07:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwy1L-00044E-Ba; Mon, 02 Mar 2026 02:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwy1J-00043N-Pm; Mon, 02 Mar 2026 02:48:49 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwy1H-0001Am-7g; Mon, 02 Mar 2026 02:48:49 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6227mGm4070526
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 2 Mar 2026 16:48:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Jg8pBL9N8Me78JTlFJP0CdfZhypMtDA3Z4/iYnRGLG4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772437704; v=1;
 b=ufG0hRT7jY+ZsTmItrvKDlpNV//OOUABmDvy5Lug19Y+3XBIa5GtHlCJrG4aExUX
 rxQGcc9s/UoOLz0x9OOzF0xo6unWKm2IGMZnfj7Ycb7CaV5CDzLy9djkCSjozBg/
 KlIDiZPqIXa/2w0v57pv9S0OuJ6MZQwpI0uNzBDtmkTTVoqCI803IoB8ITFOAtXW
 qQIofwB/8bjSOY61JUHX9b+SnrlHnbodcZZumKISTImqMN1y82m2vaMSEKZWeBmX
 2t+sP8VOPRlOC/TBxbT3k5bJ9MS90ScOIrJfyzKTlpDdzR/0NkIjt3Lp1qj9MtXP
 fumiAUmBOmC0Q3Fsm5wFrg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 02 Mar 2026 16:48:10 +0900
Subject: [PATCH v2 3/4] tests: Grow buffers for double string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-nvme-v2-3-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
References: <20260302-nvme-v2-0-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260302-nvme-v2-0-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
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
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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
 tests/unit/test-qobject-input-visitor.c  | 2 +-
 tests/unit/test-qobject-output-visitor.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 84bdcdf702e0..baff9243313c 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -583,7 +583,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
 
     i = 0;
     for (num_list = arrs->number; num_list; num_list = num_list->next) {
-        char expected[32], actual[32];
+        char expected[318], actual[318];
 
         sprintf(expected, "%.6f", (double)i / 3);
         sprintf(actual, "%.6f", num_list->value);
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 407ab9ed505a..ae05a726f775 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -571,7 +571,7 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
     i = 0;
     QLIST_FOREACH_ENTRY(qlist, e) {
         QNum *qvalue = qobject_to(QNum, qlist_entry_obj(e));
-        char expected[32], actual[32];
+        char expected[318], actual[318];
 
         g_assert(qvalue);
         sprintf(expected, "%.6f", (double)i / 3);

-- 
2.53.0



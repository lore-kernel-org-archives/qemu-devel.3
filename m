Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6FC3DA40
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 09:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKxIX-00029A-5V; Sat, 22 Jun 2024 05:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sKxIV-00027L-Bq; Sat, 22 Jun 2024 05:44:39 -0400
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1sKxIT-00011I-6O; Sat, 22 Jun 2024 05:44:39 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id E8DA38082B;
 Sat, 22 Jun 2024 11:44:33 +0200 (CEST)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 3bLECgnesXHJ; Sat, 22 Jun 2024 11:44:32 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 8F8FE80767;
 Sat, 22 Jun 2024 11:44:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 8F8FE80767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1719049472;
 bh=ujbcGKP8+6XadKvbLhzG5RyhLX8RH5RysSuKMS0bOp4=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=tx8gNkpHL4MzRHNy9SjTiGpenXm5mmW7b8ONoPGRpbX0O1qxmQ3L/1MfMoKexlc+N
 8RnZcjhqxg0wyomRamNL+71B7uvyonfO8L834zlh1makiWLt9Qes0rHrRt55sdwetB
 ACVYqWk8oGNGjPi7RfAes7qlTrSOqdH7/LX2htfQ=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 4YzbC2TivhTi; Sat, 22 Jun 2024 11:44:32 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 2CCEC80820;
 Sat, 22 Jun 2024 11:44:31 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Damien Hedde <damien.hedde@dahe.fr>
Subject: [PATCH v4 2/3] hw/clock: Expose 'qtest-clock-period' QOM property for
 QTests
Date: Sat, 22 Jun 2024 11:43:54 +0200
Message-ID: <20240622094402.244604-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240622094402.244604-1-ines.varhol@telecom-paris.fr>
References: <20240622094402.244604-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Expose the clock period via the QOM 'qtest-clock-period' property so it
can be used in QTests. This property is only accessible in QTests (not
via HMP).

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Luc Michel <luc@lmichel.fr>
---
 docs/devel/clocks.rst |  6 ++++++
 hw/core/clock.c       | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index 177ee1c90d..3f744f2be1 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -358,6 +358,12 @@ humans (for instance in debugging), use ``clock_disp=
lay_freq()``,
 which returns a prettified string-representation, e.g. "33.3 MHz".
 The caller must free the string with g_free() after use.
=20
+It's also possible to retrieve the clock period from a QTest by
+accessing QOM property ``qtest-clock-period`` using a QMP command.
+This property is only present when the device is being run under
+the ``qtest`` accelerator; it is not available when QEMU is
+being run normally.
+
 Calculating expiry deadlines
 ----------------------------
=20
diff --git a/hw/core/clock.c b/hw/core/clock.c
index e212865307..cbe7b1bc46 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -13,6 +13,8 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qapi/visitor.h"
+#include "sysemu/qtest.h"
 #include "hw/clock.h"
 #include "trace.h"
=20
@@ -158,6 +160,15 @@ bool clock_set_mul_div(Clock *clk, uint32_t multipli=
er, uint32_t divider)
     return true;
 }
=20
+static void clock_period_prop_get(Object *obj, Visitor *v, const char *n=
ame,
+                                void *opaque, Error **errp)
+{
+    Clock *clk =3D CLOCK(obj);
+    uint64_t period =3D clock_get(clk);
+    visit_type_uint64(v, name, &period, errp);
+}
+
+
 static void clock_initfn(Object *obj)
 {
     Clock *clk =3D CLOCK(obj);
@@ -166,6 +177,11 @@ static void clock_initfn(Object *obj)
     clk->divider =3D 1;
=20
     QLIST_INIT(&clk->children);
+
+    if (qtest_enabled()) {
+        object_property_add(obj, "qtest-clock-period", "uint64",
+                            clock_period_prop_get, NULL, NULL, NULL);
+    }
 }
=20
 static void clock_finalizefn(Object *obj)
--=20
2.43.2



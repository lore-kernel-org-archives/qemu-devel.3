Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA8DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvd8k-00017G-6T; Mon, 08 Sep 2025 10:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uvd8C-0000da-2H
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:46:14 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uvd7y-0004NZ-V9
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:46:07 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 588Ej4xf025149
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 8 Sep 2025 23:45:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=frx2DHIiWCnBnBaIL6IIP0pSeNrhzIYZtzVQTWXs84w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757342717; v=1;
 b=WH2RWKnSvHoaa2LuJn5guNIc8hqdHTDWpD4Iv7bK9AmisC/uOFz52xd4IuETi9Za
 bydQktrpRnxIGClD15AFr1QZu+tmho/OIxj/o66bZGquQ3a7pulKnbDDe+VaasO/
 UeuWTBSSsR/hK4npWnrPV4s6N4b4uG3hCyz9bqXQvhTIHNud0ias37eUvEic9GVF
 i9CryfO7V1l0lvp02KlH9qaIs7f+l9KVm7sZL6h2W4hT+YuGs/ppWKeflB87fkzW
 QeNmxaYNgeqVeQmIt+49XGyrsP/XQo5aJ+P+p09DgJRqW+dAmxbu8UxlNbK/yx9n
 yurkPJy7pwL1IqbFZ+si0Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 08 Sep 2025 23:45:01 +0900
Subject: [PATCH] qdev: Clarify instantiation and realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-qdev-v1-1-df236f7ce5bd@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAOzrvmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMz3cKU1DJdy1TT5CTzZAOztLREJaDSgqLUtMwKsDHRsbW1ALBT9B5
 WAAAA
X-Change-ID: 20250906-qdev-9e5cb7c06ffa
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The distinction of instantiation and realization was vague in the old
documentation so this change clarifies it.

The old documentation said:
> The former may not fail (and must not abort or exit, since it is
> called during device introspection already), and the latter may return
> error information to the caller and must be re-entrant.
> Trivial field initializations should go into #TypeInfo.instance_init.
> Operations depending on @props static properties should go into
> @realize.

The first problem with the old documentation is that it is unclear what
is "trivial" field initializations and why fields being trivial makes
them appropriate for #TypeInfo.instance_init. Another problem is that
the documentation is not comprehensive enough; for example, it mentions
@props static properties, but it does not say anything about the other
properties.

The keys to distinguish instantiation and realization are property
setting and device introspection. The fact property setting happens
after instantiation and before realization implies that operations
depending on properties should go into @realize.

The fact that initialization happens for device introspection but
realization implies:
- Properties should be added during instantiation.
- Instantiation must not have any side effect not contained in the
  instance.
- Any operations without special requirements should go @realize so that
  they can be skipped during device introspection.

Note these two facts to guide appropriate instantiation and realization.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/qdev-core.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 530f3da70218..58f831a198ba 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -21,16 +21,19 @@
  * Realization
  * -----------
  *
- * Devices are constructed in two stages:
+ * Devices are constructed in three stages:
  *
- * 1) object instantiation via object_initialize() and
- * 2) device realization via the #DeviceState.realized property
+ * 1) object instantiation via object_initialize()
+ * 2) initial property value setting
+ * 3) device realization via the #DeviceState.realized property
  *
- * The former may not fail (and must not abort or exit, since it is called
- * during device introspection already), and the latter may return error
+ * Instantiation may not fail, and realization may return error
  * information to the caller and must be re-entrant.
- * Trivial field initializations should go into #TypeInfo.instance_init.
- * Operations depending on @props static properties should go into @realize.
+ * Instantiation should add properties but must not have any side effect
+ * not contained in the instance, since it happens during device
+ * introspection already. Any operations without special requirements
+ * should go @realize so that they can be skipped during device
+ * introspection.
  * After successful realization, setting static properties will fail.
  *
  * As an interim step, the #DeviceState.realized property can also be

---
base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
change-id: 20250906-qdev-9e5cb7c06ffa

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC96C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we7BK-0002j5-SL; Mon, 29 Jun 2026 04:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1we7BI-0002ib-Jv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:17:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1we7BE-0006tR-5d
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:17:28 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65T8GxGW085627
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 29 Jun 2026 17:17:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NPDwT4byuEbOwulOXldf0iWOqtzD9TChvi0MlXrznlY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1782721023; v=1;
 b=MDQG4ePUCXLqvX9WIuanpQoLCvOttE5vA61wDE4sRO7nyPBJQaYmDFv10+vDYGS4
 vouBMxpAi/Dw5mCq8YUJAEyTdiKSii3wOaoHkwMxoBy7cFjSH2Y9BBRgyFSOGpzb
 1fG6tXDrBUB8MUKbUT1leWnf3nQGhKiGojRlG+e50aJPMQC8iVaclcdN3Q4ZVQgY
 Q3YNzYH9xyDTea2uU1z1gNqXDSWcflJRpWMVsIgXCm/rEfP9pYWDxJY2D6QcWic0
 0+bcsdu4u3FA+nEHHnG2mJNRlLms4FdDAzESi3SElzR5oLTS0ZyriuEqODob/TOr
 AK+3w/ovihGl+xvLHgQtOQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 29 Jun 2026 17:16:59 +0900
Subject: [PATCH v2] qdev: Clarify instantiation and realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMQQ6DIBCF4auYWReCNGLtqvdoXCgMOm0iCpbUG
 O5eatPl//Ly7RDQEwa4Fjt4jBTITTnkqQA9dtOAjExukEJWohGKLQYja7DSfa2FsraDfJ09Wno
 fzL3NPVJYnd8ONZbf9Q9cfkAsWcmMlWdla41Vb24+DFwTJ/5iq3tujneaP2ZoU0of2V9ogKUAA
 AA=
X-Change-ID: 20250906-qdev-9e5cb7c06ffa
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4485;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=zqSdAKf7PWEBl3tFs5l9Q5S0Ltvf3y+eRLKnwEcf9wk=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5aT5j8rvqqVLE/vxl1X/dCYKn7Qzic/kDVryt5+LtPoN
 c0HTHZ3lLIwiHExyIopsqQU7ebWiK79VJgQ3wIzh5UJZAgDF6cATKQ8gOF/Xkvh+6j9PHZTJVfb
 ch6/4C7uFrA3UdfjlUkNZ4TQnzOCjAxvY2wjL+Xn/C1feGqOcX2+t53QxT9X9+Q2zzGPulG8aRY
 3AA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
"trivial field initializations" means and why triviality makes
initialization appropriate for #TypeInfo.instance_init. Another problem
is that the documentation is not comprehensive enough; for example, it
mentions @props static properties, but it does not say anything about
the other properties.

The keys to distinguish instantiation and realization are property
setting and device introspection. The fact that property setting happens
after #TypeInfo.instance_init and before realization implies that
operations depending on properties should go into @realize.

The fact that instantiation happens during device introspection but
realization does not implies:
- Instance properties should be added in #TypeInfo.instance_init.
- Instantiation must not have any side effect not contained in the
  instance.
- Any operations without special requirements should go into @realize so
  that they can be skipped during device introspection.

Note these two facts to guide appropriate instantiation and realization.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Clarified the ordering of #TypeInfo.instance_init, pre-realize
  property setting, and realization.
- Clarified that #TypeInfo.instance_init is for per-instance properties,
  not class properties.
- Link to v1: https://lore.kernel.org/qemu-devel/20250908-qdev-v1-1-df236f7ce5bd@rsg.ci.i.u-tokyo.ac.jp
---
 include/hw/core/qdev.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e14762234115..55da09934271 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -22,16 +22,19 @@
  * Realization
  * -----------
  *
- * Devices are constructed in two stages:
- *
- * 1) object instantiation via object_initialize() and
- * 2) device realization via the #DeviceState.realized property
- *
- * The former may not fail (and must not abort or exit, since it is called
- * during device introspection already), and the latter may return error
- * information to the caller and must be re-entrant.
- * Trivial field initializations should go into #TypeInfo.instance_init.
- * Operations depending on @props static properties should go into @realize.
+ * Devices are constructed in the following order:
+ *
+ * 1) #TypeInfo.instance_init
+ * 2) pre-realize property value setting
+ * 3) device realization via the #DeviceState.realized property
+ *
+ * #TypeInfo.instance_init may not fail, and realization may return
+ * error information to the caller and must be re-entrant.
+ * #TypeInfo.instance_init should add instance properties but must not
+ * have any side effect not contained in the instance, since it happens
+ * during device introspection already. Any operations without special
+ * requirements should go @realize so that they can be skipped during
+ * device introspection.
  * After successful realization, setting static properties will fail.
  *
  * As an interim step, the #DeviceState.realized property can also be
@@ -40,9 +43,8 @@
  * point in time will be deferred to machine creation, so that values
  * set in @realize will not be introspectable beforehand. Therefore
  * devices must not create children during @realize; they should
- * initialize them via object_initialize() in their own
- * #TypeInfo.instance_init and forward the realization events
- * appropriately.
+ * initialize them via #TypeInfo.instance_init and forward the
+ * realization events appropriately.
  *
  * Any type may override the @realize and/or @unrealize callbacks but needs
  * to call the parent type's implementation if keeping their functionality

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20250906-qdev-9e5cb7c06ffa

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



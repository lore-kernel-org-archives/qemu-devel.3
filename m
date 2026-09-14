Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E24BC88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x634q-0000oX-1M; Mon, 14 Sep 2026 05:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634R-0000hd-MU; Mon, 14 Sep 2026 05:33:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634M-0000S1-SX; Mon, 14 Sep 2026 05:33:50 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9WXEW020350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:32:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/Bvxk6KnPo0hgWabVbGt/xH9R1ZKFET4Zr3/tO589OM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378358; v=1;
 b=ClVR0MZMbJCOXXzXdwjsc+A5CXKty+BnArkLQzVeJiBl/u6RUfjMNicLUV8QM0wz
 UfAR+7GYG780CyJrKHyK50AbHh25aBXvo7jjxnQPPjEMfUI0G6C6LyCqx4q/C72K
 17jMDZH/7/kxWmQSe5d87aYoVcJW3/UFgF28m9EsdbjEP7xvYo4ocTbnObWgJGx8
 5GMhMIrWKfqBh5JV04PKwQq/Qk05gWNbVUHRuE/umB8/rqPsHnESUoEeb69tHyP+
 XHM7R/OGXMduIpDscl63tOpPNGIbs6e9yaA/VIN8HY0I6WirG7TN15Yj61UABXNj
 UEEJdT/upDWYAJHn05kGNw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:31:49 +0900
Subject: [PATCH v4 1/4] qdev: Clarify instantiation and realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-qdev-v4-1-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
References: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5771;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=b0gqtLvYz6FByvP/TSQ7Ojke53C6GB4YJE92Ws3z45A=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9by/XriIUsz/xyrYilSODyluFB8guGUz/9W7wnbw3Hrk
 tOukCPiHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABOR6Gb4nxt8/U4V76Kqnfye
 j7l3Ojo8PjG7Ke1M+oWwurNBvskpjAz/lFezine2GTr932WiMrP2dPd8zk61b5zbb0yI+XfD7KI
 1LwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The keys to distinguish instantiation and realization are instance
property setting and device introspection. The fact that initial
instance property setting happens after #TypeInfo.instance_init and
before realization implies that operations depending on properties
should go into @realize.

The fact that instantiation happens during device introspection but
realization does not implies:
- Instance properties may be added in #TypeInfo.instance_init.
- Instantiation must not have any side effect not contained in the
  instance.
- Any operations without special requirements should go into @realize so
  that they can be skipped during device introspection.
- Instance properties added during realization will not be configurable
  or introspectable before realization.

Note these two facts to guide appropriate instantiation and realization.

We also omit mention of the realized property because it is a QOM
interface detail, not part of the device API.

The statements regarding a future prospect to propagate the realization
state change are removed. Device realization is propagated to child
buses, but not to the devices on those buses. The proposed recursive
propagation to child devices has not been achieved after 13 years, has
been questioned [1], and is not relevant with the current API usage.

[1] https://lore.kernel.org/qemu-devel/878syd84s3.fsf@dusky.pond.sub.org/

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/core/qdev.h | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f054a214fc6a..b1c5f4780a90 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -23,27 +23,27 @@
  * Realization
  * -----------
  *
- * Devices are constructed in two stages:
+ * Devices are constructed in the following order:
  *
- * 1) object instantiation via object_initialize() and
- * 2) device realization via the #DeviceState.realized property
+ * 1) #TypeInfo.instance_init
+ * 2) pre-realize property value setting
+ * 3) device realization
  *
- * The former may not fail (and must not abort or exit, since it is called
- * during device introspection already), and the latter may return error
- * information to the caller and must be re-entrant.
- * Trivial field initializations should go into #TypeInfo.instance_init.
- * Operations depending on @props static properties should go into @realize.
- * After successful realization, setting static properties will fail.
+ * #TypeInfo.instance_init may not fail. #DeviceClass.realize can
+ * fail, returning error information to the caller, and must be re-entrant.
+ *
+ * #TypeInfo.instance_init should add instance properties but must not
+ * have any side effect not contained in the instance, since it happens
+ * during device introspection already. Any operations without special
+ * requirements should go into @realize so that they can be skipped
+ * during device introspection. It is possible to add properties
+ * during realization, but they will not be introspectable or
+ * configurable before realization.
  *
- * As an interim step, the #DeviceState.realized property can also be
- * set with qdev_realize(). In the future, devices will propagate this
- * state change to their children and along busses they expose. The
- * point in time will be deferred to machine creation, so that values
- * set in @realize will not be introspectable beforehand. Therefore
- * devices must not create children during @realize; they should
- * initialize them via object_initialize() in their own
- * #TypeInfo.instance_init and forward the realization events
- * appropriately.
+ * Child buses are automatically realized. Child devices must be manually
+ * realized (e.g. by calling qdev_realize()).
+ *
+ * After successful realization, setting static properties will fail.
  *
  * Any type may override the @realize and/or @unrealize callbacks but needs
  * to call the parent type's implementation if keeping their functionality
@@ -102,10 +102,8 @@ typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
 /**
  * struct DeviceClass - The base class for all devices.
  * @props: Properties accessing state fields.
- * @realize: Callback function invoked when the #DeviceState:realized
- * property is changed to %true.
- * @unrealize: Callback function invoked when the #DeviceState:realized
- * property is changed to %false.
+ * @realize: Callback function to realize the device.
+ * @unrealize: Callback function to unrealize the device.
  * @sync_config: Callback function invoked when QMP command device-sync-config
  * is called. Should synchronize device configuration from host to guest part
  * and notify the guest about the change.

-- 
2.55.0



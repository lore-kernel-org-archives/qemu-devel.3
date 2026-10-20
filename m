Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D7606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XWLOffIq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7U9-0005DG-H4; Tue, 20 Oct 2026 06:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7Rx-0001Im-GC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7Rv-0006jy-Ar
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792493526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edIbxy8j0ZeLmK0JPM910tAFzYTrVmN4a79XoyzsTPs=;
 b=XWLOffIqp0dzfMN7npTE8ln70l0mHDaJQ4YaNJRInktXlCaBxNhmbyBVPhyAV6otDDtdZy
 SGBHj4GLBUSArH6Iom+X3eSUe1sm1Jj0316wi3U4uAgDVTXTIztlHtKwQV/ossAe8gzT6w
 DXMxUDvxjwkY5B0h7ZOJsOZASue9/7c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-UkF2cxSIP0KFpD-x2kfPug-1; Tue,
 20 Oct 2026 10:52:03 +0000
X-MC-Unique: UkF2cxSIP0KFpD-x2kfPug-1
X-Mimecast-MFC-AGG-ID: UkF2cxSIP0KFpD-x2kfPug_1792493519
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 171B41955DE8; Tue, 20 Oct 2026 10:51:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D26A65BC; Tue, 20 Oct 2026 10:51:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:21 +0400
Subject: [PATCH v7 64/65] qom: use QAPITypeInfo in object_property_get_enum
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-qom-qapi-v7-64-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4777;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=btPOLigegMrUtE/H8gDPhCCZC+0Be3DpIj2amZiGpeM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZdBPk60N5wT01axiLdb48ZwuPjCejnM2ZCc
 8PglQD+RAWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXQAKCRDa6OEJdZac
 5SPyEAC5HRZ0r0eZqxI5kzCsHrclz4H0Z1qTSRRBggURJDWP1KPYcglKwzX4001DDcIq+3FTVpq
 uqL6jJTS5vpJyJyR897eCp/+/txzLU8tlhsslIoDbOhlREexjvA38cJU7R22vQlvcx+DpICRHE3
 a5XvP5h0s1/Pyiwdap+iMevEvuEEcbH/jRuSHep2d8iVv7Koi8q0iUC8zZ9PuwSKBiXi/oILGfy
 aiMrs8f/RgP9W/MoV3ZQRoFzC+PDRjFuTVfcaA60kq0BkbXlZZqC8u7Z+II9Xx+mxD8jpqF0dvl
 YdxYl9iXw3cbjdx662K6DNPPTjQqlqch+lUyD9IDKGSOxwMVRZODMwFtKF8oOvp/VlJSjSI2dYp
 n/X+gSwpl4DPtL64HznEe7j1fcGEq0YFRHnDbDHbwuxtIa57jCuK6wDAdaarfxUiuLtPfX7zXKA
 1mhzw7Xk53JCYfVRtyhDDwz68cwocztkSeDoHbr+rWIMtJWAgR3K0ZgRcwpuhUoaQpp7LtkUpd6
 SttTn4wc4MNuYc4Awpzamcf3DaIFaC+EQhFDU5i9gl+OPJb5rstVcuwsDzcleSXgUaDrqgSpCQo
 Bgm5lkNrnrlf7BG0h6WM3CgbBEadCmph3q1159HTgqfLA36QI7zt946mDEQrtiXWNDke3TZA+Wo
 l6wkFmd77J6ABag==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The typename parameter becomes a QAPITypeInfo pointer, and the
validation compares prop->qapi_type against it instead of matching
prop->type strings.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine-qmp-cmds.c      | 4 +++-
 include/qom/object.h            | 4 ++--
 qom/object.c                    | 8 ++++----
 tests/unit/check-qom-proplist.c | 6 +++---
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3fee45d568da..6b425baeb2da 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-commands-accelerator.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qobject.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
@@ -252,7 +253,8 @@ static int query_memdev(Object *obj, void *opaque)
         } else {
             m->has_reserve = true;
         }
-        m->policy = object_property_get_enum(obj, "policy", "HostMemPolicy",
+        m->policy = object_property_get_enum(obj, "policy",
+                                             &HostMemPolicy_type_info,
                                              &error_abort);
         host_nodes = object_property_get_qobject(obj,
                                                  "host-nodes",
diff --git a/include/qom/object.h b/include/qom/object.h
index a9bbc44cfcc9..9f937e30dae5 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1566,7 +1566,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * object_property_get_enum:
  * @obj: the object
  * @name: the name of the property
- * @typename: the name of the enum data type
+ * @type_info: the QAPITypeInfo of the enum
  * @errp: returns an error if this function fails
  *
  * Returns: the value of the property, converted to an integer (which
@@ -1574,7 +1574,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * value is not an enum).
  */
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp);
+                             const QAPITypeInfo *type_info, Error **errp);
 
 /**
  * object_property_set:
diff --git a/qom/object.c b/qom/object.c
index 791d981dc689..40b569d4d574 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1775,7 +1775,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
 }
 
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp)
+                             const QAPITypeInfo *type_info, Error **errp)
 {
     char *str;
     int ret;
@@ -1785,10 +1785,10 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    if (!g_str_equal(prop->type, typename)) {
+    if (prop->qapi_type != type_info) {
         error_setg(errp, "Property %s on %s is not '%s' enum type",
-                   name, object_class_get_name(
-                       object_get_class(obj)), typename);
+                   name, object_class_get_name(object_get_class(obj)),
+                   type_info->name);
         return -1;
     }
 
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 69155e720751..1cb48c7490ef 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -582,14 +582,14 @@ static void test_dummy_getenum(void)
 
     val = object_property_get_enum(OBJECT(dobj),
                                    "av",
-                                   "DummyAnimal",
+                                   &dummy_animal_qapi_type_info,
                                    &error_abort);
     g_assert(val == DUMMY_PLATYPUS);
 
     /* A bad enum type name */
     val = object_property_get_enum(OBJECT(dobj),
                                    "av",
-                                   "BadAnimal",
+                                   &dummy_str_qapi_type_info,
                                    &err);
     g_assert(val == -1);
     error_free_or_abort(&err);
@@ -597,7 +597,7 @@ static void test_dummy_getenum(void)
     /* A non-enum property name */
     val = object_property_get_enum(OBJECT(dobj),
                                    "iv",
-                                   "DummyAnimal",
+                                   &dummy_animal_qapi_type_info,
                                    &err);
     g_assert(val == -1);
     error_free_or_abort(&err);

-- 
2.56.0.116.g6de20f6092dc



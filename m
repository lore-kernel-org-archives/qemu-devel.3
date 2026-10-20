Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20210606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W/bpnmLm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7T8-0002QW-8e; Tue, 20 Oct 2026 06:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7QH-00073O-6W
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7QF-0006HO-4Z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792493422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CC43HGq5NqmO9GuRv3YOCIPDVNxOH0lYT23DJe+EOs=;
 b=W/bpnmLm1Uz2WwbuFjvvC0161c0UZylGBi05TIrDD6OdY70s/V7tEQJh+OzlK0yT+e2Se9
 IIvy/MRguNONDAAB4b604Eax8BDWfIXsUWil1P2d8woCzBuyrkAIhthNBFDOiPM4eEvhYS
 7SU/fzcHnFkesHVLHEn8PU81pEc/h48=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-0yk3KpK5MBKZ9_x5V_hyRg-1; Tue,
 20 Oct 2026 10:50:18 +0000
X-MC-Unique: 0yk3KpK5MBKZ9_x5V_hyRg-1
X-Mimecast-MFC-AGG-ID: 0yk3KpK5MBKZ9_x5V_hyRg_1792493414
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78F3E1954102; Tue, 20 Oct 2026 10:50:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AABE1956095; Tue, 20 Oct 2026 10:50:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:01 +0400
Subject: [PATCH v7 44/65] hw/nvdimm: convert UUID property to QAPI-aware
 registration
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-qom-qapi-v7-44-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JcrXJbY3n1i8Aie2efrfuUCSPF/58nBE1VKv/oA1cHQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10Zb3uRNyW/Ops8TO0GvUmz+pY4b6iH48X9V4
 dT8KSx5JbWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWwAKCRDa6OEJdZac
 5eITD/46vxBPKKy5DKVq41RW+PpNl8DJi94l5Ic/FKfo92YajuNHmy1WErhgftc0rpWEf92vWp2
 /kk3U5z38JmBDTtBklsCNKY8V6UA1XuWHNxhMtpJz2/4uluVz/cPDYqtyc5XAf9WWJkCw/hKmmS
 GadWFMgjwRsGaAuWAT8IbDB82XGWkgzxZBqh76fEVznt+V5gX1shJ/a/u7KUcuHEJIPgCWlTFJL
 QBCIrSrvGW7MWZ0xI6AR+EAtJ5oG9xc74eILqmJoNMDhp/m+1JEEOl25Mbb1EyX6EfB8kpzqdSH
 KM5tKqVXHz/gpPWacm9DzXGSH+nsG/v0CDnsS4ywByxghoIzo5/Ky0uP3XENBVy1UT+Uf8hu9t5
 CD+bEOs7ExRxdT41kAbWSQ1vB42SwN1uJkXot5RNttTmmYv0IAoxkSuNpwJa+Cs1fdhKaoPZfil
 VUqLPeJmD5Q6WahLYyg8bC0pz2HjinNVlT0LFkveiW9+hmae361bD7hOPLGVvxO7cDzDUOLn1Xm
 E/kEb3lwBP8u23KM6nwMg79RA4QttKHK8lFNs00JdB3dg5vTZuLt8HetlALcd+9l8UGL2rTRW1P
 hEksQQ1rUSoEHWaxQZgtclQUsPD8AksY8ygzbhXCo6fmu78aH5/mTWRUeItn2w9Ul5sPsE2sTFj
 9RH9c/P0NdV/h2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a QemuUUID_type_info and use object_property_add_qapi() instead of
object_property_add() for the nvdimm UUID property.

The type info is defined manually in uuid.c rather than generated,
since QAPI does not yet support string typedefs. An alternative would
be to extend the QAPI schema language with a 'typedef' construct
(e.g. { 'typedef': 'UUID', 'data': 'str' }), which would let the
generator produce the type info, C typedef, and introspection entry
automatically.

Alternatively, the exposed type being a string, we could change the
property to be str_type_info.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/mem/nvdimm.c     | 4 ++--
 include/qemu/uuid.h | 4 ++++
 util/uuid.c         | 5 +++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 123ddc938546..b7ccb5c93678 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -104,8 +104,8 @@ static void nvdimm_init(Object *obj)
                              nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                              NULL);
 
-    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
-                        nvdimm_set_uuid, NULL, NULL);
+    object_property_add_qapi(obj, NVDIMM_UUID_PROP, &QemuUUID_type_info,
+                             nvdimm_get_uuid, nvdimm_set_uuid, NULL, NULL);
 }
 
 static void nvdimm_finalize(Object *obj)
diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 869f84af09dd..ed0c62327d4d 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -16,6 +16,8 @@
 #ifndef QEMU_UUID_H
 #define QEMU_UUID_H
 
+#include "qapi/qapi-type-info.h"
+
 
 /* Version 4 UUID (pseudo random numbers), RFC4122 4.4. */
 
@@ -99,4 +101,6 @@ QemuUUID qemu_uuid_bswap(QemuUUID uuid);
 
 uint32_t qemu_uuid_hash(const void *uuid);
 
+extern const QAPITypeInfo QemuUUID_type_info;
+
 #endif
diff --git a/util/uuid.c b/util/uuid.c
index 234619dd5e69..363a03051aba 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -17,6 +17,11 @@
 #include "qemu/uuid.h"
 #include "qemu/bswap.h"
 
+const QAPITypeInfo QemuUUID_type_info = {
+    .name = "QemuUUID",
+    .masked_name = "str",
+};
+
 void qemu_uuid_generate(QemuUUID *uuid)
 {
     int i;

-- 
2.56.0.116.g6de20f6092dc



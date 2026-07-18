Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CA0C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCio-00005P-1O; Sat, 18 Jul 2026 17:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCim-0008W4-1C; Sat, 18 Jul 2026 17:37:20 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCik-0001xW-0e; Sat, 18 Jul 2026 17:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410638; x=1815946638;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IA4nALdfZQTZQBYqQKAyhaa+NqJeGaJYK8ZpoH8EEDo=;
 b=cUdm8OyehPTCxb839VlFO12Aq+7f7TRPQWsm6E8rvKt9vqD4XgqXVlHx
 U/95+VmG2c7rLhAZ+zggw+fmRZ475ftYFwkQf0uoNIJz79HHvrD3i8NTl
 JzFfViF4BBzQ7v7tSKjPRVtVgz5miIChILmF6jVPZZzchU1Al4sKiE2ja
 JbHTEQKs4pQLUd6KmUEz3VCYjy+/uZOwMAGbjQHgNWrWPYhWsITZMfr4m
 HXLX0bbO8CqjuEac1xz2iDY2wZd20HFAU4s3lk4HebZKNQ9xzBdE6wSGI
 tnX9zoWBdUBaq6OMrfaSwiR2MZ/0QPxrKd+m/dBq0Nfg0N5s/Uf7D6lOy Q==;
X-CSE-ConnectionGUID: TIgUOO8ERKOQTOsykgQreg==
X-CSE-MsgGUID: mLR7Sn1HREScAq49dTgluw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23816217"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:37:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:2580]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.199:2525]
 with esmtp (Farcaster)
 id 2d57d8dc-b67e-476f-8e56-f516b25e8f20; Sat, 18 Jul 2026 21:37:14 +0000 (UTC)
X-Farcaster-Flow-ID: 2d57d8dc-b67e-476f-8e56-f516b25e8f20
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:37:13 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:37:04 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 001/137] qom: Introduce object_new_child()
Date: Sat, 18 Jul 2026 21:34:36 +0000
Message-ID: <20260718213652.37673-2-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

We already have two ways of creating a QOM object with a parent set
from birth: object_initialize_child() for objects embedded in the
parent struct, and object_new_with_props() for heap-allocated objects
that also want a list of string properties applied.  What we do not
have is the plain heap-allocated dual of object_initialize_child():
create the object, add it as a child<> of a given parent under a given
name, and hand the reference to the parent.

Board and composite-device code that heap-allocates children today
therefore either open-codes object_new()+object_property_add_child()
+object_unref(), or skips the parenting step entirely and lets
device_set_realized() dump the object into /machine/unattached.

Add object_new_child(parent, id, typename) as that missing primitive.
The reference created by object_new() is transferred to the parent's
child<> property, so on return the sole reference is held by @parent
and the caller does not need to unref.  Later patches build the qdev
and per-bus creation helpers on top of this.

@id must be a valid QOM child<> property name: non-empty and
without the "/" QOM path separator.  It may contain the "[*]"
auto-index suffix; the qdev id_wellformed() grammar does not apply
here.  The compiler enforces non-NULL arguments via
__attribute__((nonnull)) instead of runtime asserts, as suggested by
Richard and Peter.

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/qom/object.h | 32 ++++++++++++++++++++++++++++++++
 qom/object.c         | 12 ++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..299673d040 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -632,6 +632,38 @@ Object *object_new_with_class(ObjectClass *klass);
  */
 Object *object_new(const char *typename);
 
+/**
+ * object_new_child:
+ * @parent: the QOM composition-tree parent
+ * @id: the child<> property name; the object's canonical QOM path
+ *      becomes @parent's path plus "/" plus @id
+ * @typename: the name of the type of the object to instantiate
+ *
+ * Create a heap-allocated object and immediately add it to the QOM
+ * composition tree as a child of @parent.
+ *
+ * This is the heap-allocated dual of object_initialize_child(): use
+ * this when the child is a pointer member of the parent, and use
+ * object_initialize_child() when the child is embedded in the parent
+ * struct.  See also object_new_with_props() for the variant that
+ * additionally sets a list of properties.
+ *
+ * The reference returned by object_new() is transferred to the child<>
+ * property of @parent, so the object has a reference count of 1 held
+ * by @parent, and the caller does not need to unref.
+ *
+ * The @id assert is a sanity check on the caller's string literal;
+ * the authoritative uniqueness check is object_property_add_child(),
+ * which will error_abort() on a duplicate @id under @parent.  Use
+ * the "[*]" auto-index suffix when multiple children of the same
+ * kind may be created.
+ *
+ * Returns: the newly allocated, instantiated and parented object.
+ */
+Object *object_new_child(Object *parent, const char *id,
+                         const char *typename)
+    __attribute__((nonnull(1, 2, 3), returns_nonnull));
+
 /**
  * object_new_with_props:
  * @typename:  The name of the type of the object to instantiate.
diff --git a/qom/object.c b/qom/object.c
index f79b2cf361..64b0faf1f5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -718,6 +718,18 @@ Object *object_new(const char *typename)
     return object_new_with_type(ti);
 }
 
+Object *object_new_child(Object *parent, const char *id,
+                         const char *typename)
+{
+    Object *obj;
+
+    g_assert(id[0] && !strchr(id, '/'));
+
+    obj = object_new(typename);
+    object_property_add_child(parent, id, obj);
+    object_unref(obj);
+    return obj;
+}
 
 Object *object_new_with_props(const char *typename,
                               Object *parent,
-- 
2.47.1



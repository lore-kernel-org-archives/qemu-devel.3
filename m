Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4F7CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvqI-0006RK-Nc; Tue, 23 Jun 2026 03:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqD-0006FJ-Qk
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqC-0008HR-Af
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zj3tUMqTxLKcBTU+emlXvGnLHK5NtbPWY7r4XNLmt4c=;
 b=iGjVrHRCszjCo4xU6yz13L5CnrzXr8KHdl615GGj9/QyBBdCmGj/kotXaQb+ky9kBJ702C
 3X4EXEFf9EUdFlegK/yGZP6j87eYJ2Jx1CEou/cGRJggAWushtA7MQuSue2EIKTA9No///
 Bhg39jsZqUCdFbb/jpw2I1/WL0m/g3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-RceEqgzBPQGJzqD25f8yjQ-1; Tue,
 23 Jun 2026 03:46:34 -0400
X-MC-Unique: RceEqgzBPQGJzqD25f8yjQ-1
X-Mimecast-MFC-AGG-ID: RceEqgzBPQGJzqD25f8yjQ_1782200793
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D57FA18052E9; Tue, 23 Jun 2026 07:46:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18236195608C; Tue, 23 Jun 2026 07:46:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:36 +0400
Subject: [PATCH v4 21/34] ui/dbus: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-21-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=930;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qOj6edOyjhZsl79Z/n7afG0S5OErckUOFe7CpEAKPtc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjleKLywcXBiUCcCxCo0p8jx0WwdEsvPUhi6p
 8SoaraucruJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5X0DEACHJCK2w5OIm7V6QyXDV0skaBcH3ljRd+Zjv8TOaUfjo+irzktPE9D67yqO/JIvNmpIXiW
 af/ZAy3cfQFAxfEiVObSBmbFm3F8HaXVyqdYDvQ4uIP1akg95dItOHdGgDcJuL/AStWRp3bbRxr
 gqxHJChJwP0wsxMEwWEud7NzMwt+1YkjR+0O9z+J2rhdZHYKH/dAlBmQv3OdjUUx9axJONzldn3
 6uZ3xD/PpF6zDD9QdX7xIL4IdLR+QWQcNNSWPsa2iCFCUavB4ohob6PDypaDXteMAV/6vfCjI5E
 azFcmr9KRWU+mSojbv9Ol8urQMBPcevunypLzrTTYxpfitkxn38xkHsvYx3g3xfvqryCZkWGCK6
 HfuITe8QaMMycNtuCsmuISkZkvZf9/zoUU+f/hFF6luyRzICvYyW4Z5G+2g4FA3I1n4Mxw93wfd
 UvU0HY1vBNfGGPOy577zuGfsNfQjuqvQqtAfHt3kC+e3V10g0YEyf573xIFULJeY+TIl95ckCZF
 rHj4WRs9mTZPvGUAHXzqHkLvA9scloBks9YYoNZ1EsF+w3gAU5I1y8cXWsX2gtLSAu/eihq10xq
 lB/tE+a/QDV6WVs/xuFWhlIQth141AnVSnHaTt7NxV4xNdC9kcTP4gpVxE0DGcQMoboHnv7U7z5
 S2RjBKnGT5UjIqQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add dbus_cleanup() to unparent the D-Bus display object, ensuring
proper teardown before user_creatable_cleanup() runs.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ui/dbus.c b/ui/dbus.c
index e02a94df2f3..b23cb44c535 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -615,10 +615,23 @@ static const TypeInfo dbus_display_info = {
     }
 };
 
+static void
+dbus_cleanup(void)
+{
+    Object *o;
+
+    o = object_resolve_path_component(object_get_objects_root(),
+                                      "dbus-display");
+    if (o) {
+        object_unparent(o);
+    }
+}
+
 static QemuDisplay qemu_display_dbus = {
     .type       = DISPLAY_TYPE_DBUS,
     .early_init = early_dbus_init,
     .init       = dbus_init,
+    .cleanup    = dbus_cleanup,
     .vc         = "vc",
 };
 

-- 
2.54.0



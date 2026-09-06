Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4205C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38de-0002GK-Ep; Sun, 06 Sep 2026 04:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dd-0002FN-O2
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dc-0000lA-4F
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vst5j4QPIcKrnpicAI/fXe4jkP6szpQ/0rL49li+K+4=;
 b=bWSTBIfSKtoR6V1NM3+1aC1bPgSpa/eFwrQxGQXdamlbkgBYNYMKQndwk1UqTxl1e1u8yU
 4jrkuTW93IdRNLdv7Lu6bHMiwbYRxk+gNRDWm5NJ48hvxhYGVCvFbINUaMML6fMcuVRGj9
 wckh1u8PF3seOjaX2BxTEYCgZ2DVXQ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-EPc8slb-NY20ki3Ou5gLPA-1; Sun,
 06 Sep 2026 04:54:04 -0400
X-MC-Unique: EPc8slb-NY20ki3Ou5gLPA-1
X-Mimecast-MFC-AGG-ID: EPc8slb-NY20ki3Ou5gLPA_1788684841
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99583180121A; Sun,  6 Sep 2026 08:54:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 919901956042; Sun,  6 Sep 2026 08:54:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:35 +0400
Subject: [PATCH 3/9] hw/misc/bcm2835_powermgt: free wdog timer on finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-3-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=aiXkdc63nsKgNhTc5ZS/RmEpq+MeWtxUvxktNtqDyD0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoYzhb/L70apQJE8iQq8eM39G226x6BUkqvW
 q9VGGL9p/OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGAAKCRDa6OEJdZac
 5c1MEACOhfNx10f74ac2I+4Pv+FmWZIHK8oPoePNAWDuX0pWDVH+Jvye+5Fjb+6SngjTSlw9Mmf
 l7/QK2Bpv5Qi01t26rdcPXO5VsieeuQH8B6KI5VXMQmqaJ0zWVneWmOVSdrrHe+5jzBF0vjs7o5
 yFMvtVU291SZdbVO6+c17SUXTUgK/PCgc+i415uiJ0y2qNX0kRWMi7bdw8/U8IGNxAw0OT/flMg
 2keFetx5xR4fqIPJofijES0fnpV3Ka4cWD1TNGn4wSepx22KtmB1+nk+be0I2oB9P4vjGtTcX91
 bOt6Qow1yDIkcUpRcRjkKXUdFrNCQm4JqhvLyXvt2+3jD8t9+ucrEZIXOAo5Ictii6LPoo7Po9K
 lBE9se9elWCGrEZB1aKm92NK/oTH/xJoPkvNTOYXf1hw9m/0kKmds0i1coy/mpI8Ov7c3MnuJHx
 DY+mAXZfu+bNbXtsw260xOaP6uco+azl+8XpSn9MQ6yQncNtWxCcMtyzNc7kc6Bon+2fCtZrnF8
 Cd6kOpO+oL1vV0aZTm2JwOeDhmbzI/b6B9aWZb0U9RUlvnmr/0oYeumjl9HMn4921pwMs52b7Da
 rNKw1OH8mKiUkxFAyEzgdqPzlqKWZ55S2jhJxK/oQI5YaF7BPAAWawIoVReRQ49egsMdDQvC8MG
 OVLJVo8NC3t5/mg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The wdog_timer allocated in instance_init  is causing ASAN to report a
leak when the object is destroyed (e.g. during qom-test and
device-introspect-test).

Add an instance_finalize handler to free it.

Fixes: 21fcfb604608 ("hw/misc/bcm2835_powermgt: implement a real watchdog timer")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/bcm2835_powermgt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 7b01be48bb7f..1de5a55a4f5b 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -152,6 +152,13 @@ static void bcm2835_powermgt_init(Object *obj)
                                  bcm2835_powermgt_expire, s);
 }
 
+static void bcm2835_powermgt_finalize(Object *obj)
+{
+    BCM2835PowerMgtState *s = BCM2835_POWERMGT(obj);
+
+    timer_free(s->wdog_timer);
+}
+
 static void bcm2835_powermgt_reset(DeviceState *dev)
 {
     BCM2835PowerMgtState *s = BCM2835_POWERMGT(dev);
@@ -177,6 +184,7 @@ static const TypeInfo bcm2835_powermgt_info = {
     .instance_size = sizeof(BCM2835PowerMgtState),
     .class_init    = bcm2835_powermgt_class_init,
     .instance_init = bcm2835_powermgt_init,
+    .instance_finalize = bcm2835_powermgt_finalize,
 };
 
 static void bcm2835_powermgt_register_types(void)

-- 
2.55.0.543.g5ebe2ebe4ea8



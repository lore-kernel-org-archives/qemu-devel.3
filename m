Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6B9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1sqd-0004ht-JV; Tue, 30 Apr 2024 15:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1sqX-0004h4-1h
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1sqV-00016A-JW
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714504134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5blOXWrzwvaqYRZxsaQzO40nP6otrLzUQWzJTvrUKIk=;
 b=gnIRR3ROzEO5SrNtrGQG+Q6PIX7b2OZmG8lSc7W+G5H5GOEGJ+310tsvGnn/FAbj+BccIc
 O49oI/l7xTvzvF9oLAcxFoh8v+7+2JNQPk+3jMy6ZmsHTNeAqjbBvYlAanuXzJBix3tE6d
 xa22Pw0yr0g+RTN3d6s/xcbzF95lq14=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-FNTxsWmRMxy1ZHVWl7Us9w-1; Tue,
 30 Apr 2024 15:08:48 -0400
X-MC-Unique: FNTxsWmRMxy1ZHVWl7Us9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2A7529ABA13;
 Tue, 30 Apr 2024 19:08:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2F021C0654E;
 Tue, 30 Apr 2024 19:08:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/s390x: Attach the sclpconsole to
 /machine/sclp/s390-sclp-event-facility
Date: Tue, 30 Apr 2024 21:08:43 +0200
Message-ID: <20240430190843.453903-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The sclpconsole currently does not have a proper parent in the QOM
tree, so it shows up under /machine/unattached - which is somewhat
ugly. We should rather attach it to /machine/sclp/s390-sclp-event-facility
where the other devices of type TYPE_SCLP_EVENT already reside.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5c83d1ea17..41be8bf857 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -242,11 +242,13 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
 
 static void s390_create_sclpconsole(const char *type, Chardev *chardev)
 {
+    BusState *ev_fac_bus = sclp_get_event_facility_bus();
     DeviceState *dev;
 
     dev = qdev_new(type);
+    object_property_add_child(OBJECT(ev_fac_bus->parent), type, OBJECT(dev));
     qdev_prop_set_chr(dev, "chardev", chardev);
-    qdev_realize_and_unref(dev, sclp_get_event_facility_bus(), &error_fatal);
+    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
 }
 
 static void ccw_init(MachineState *machine)
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69720C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHsU-00089M-Om; Tue, 18 Aug 2026 07:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsT-00088S-92
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsR-0006rb-UM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0URW6lR2/KJPf73MAYrbfLbEJWbW2eS1XoTE23ePLqs=;
 b=Xi1FKE9d/RzF9MqA/OOm3AsG+/7yn09cD2Y86Y4vbHye2+GZNL0au85HN77kayoMOBk9+e
 LoPGPigZ3XdgNxGr0KD/2Kd92dcmyipFdVIUFT0W+KP4QIVGJbC+pbTqMEANJN27JurFtw
 FkR1citBu7wVsRM7cD1cXmAUeBVpKjU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-yZ3h20rNPZmfMtqInUUAYg-1; Tue,
 18 Aug 2026 07:21:04 -0400
X-MC-Unique: yZ3h20rNPZmfMtqInUUAYg-1
X-Mimecast-MFC-AGG-ID: yZ3h20rNPZmfMtqInUUAYg_1787052063
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABBDF1955EBC; Tue, 18 Aug 2026 11:21:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CC041956042; Tue, 18 Aug 2026 11:21:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:01 +0400
Subject: [PATCH v3 34/74] block/throttle-groups: fix throttle properties
 typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-34-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=evReDyRfw8wz//025H9xYi0Yy1YbciYVBB+xcZMl5Ls=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26uQNtSFkmTM8ZcCLfmBI1tngz0+bI4gqDd
 v9ruaOr1OGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5X7MD/0Wa+/YtIf7IUoDU8HFQFQD6dyz0wno+CtLkzVNydFBfAjxafr3igytJPNRFnSYKMbplIg
 GOFhxv56S8vgWwI2E+7aHFB6HRLBPqfreWrx3vPWgG+Sklf4SnRXo3mfyUZOGwZ9SEo5BfPH5DT
 /Rtz5F2hb02g6cMgizsE86+GzYr45GGbArG6TipmjZ8yzklCoU7unjOdzG8QvYm99UwOsE3/DkB
 Y8kGYzCz9d1MZHmppRXLe6L4E/Uk74XJUxQW9i9HT97OH7P32ynZVmV9zKW62LbNbk2Li1C9yEX
 Im0hPBd6L9NnAw4AfKrDe+kEfTn7+I4KIMRsAqRJricRufbMy99+yx1bh9ri+9dhY3GNsZhKRQp
 IBiFrkHaSEoVKNg2+MuIvCnt2es824WFji6huLBosp029Fg9dmaLdYNWaJA2+K8OqVhnbCsorzi
 zlDtjZS3y4oQ2X601F2X6yJipd29fGyaaadx2fGYdwxydpLDUNxW8QuVbR3jgjV4GpQvGNZKWBk
 W5RqS5nzoVTm8E+D6kXnkHa/m2+AiqCpmVvb72gu0ZlYxNoKduI3Z5dKPVg3cwK5LJzp4I2mTx3
 bidWgfMIdTCY5yvPCR+I59nWCag14fY+sMTWiDvarf16gahpyAT9FZQ5vmUZnp0DkZ6Y3mnGa1c
 ZS2tRXRUGutGuTA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 432d889e55e2 ("block: convert ThrottleGroup to object with QOM")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/throttle-groups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a9d3aea3b54e..6312157802da 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -985,7 +985,7 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
     for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
         object_class_property_add(klass,
                                   properties[i].name,
-                                  "int",
+                                  "int64",
                                   throttle_group_get,
                                   throttle_group_set,
                                   NULL, &properties[i]);

-- 
2.55.0.543.g5ebe2ebe4ea8



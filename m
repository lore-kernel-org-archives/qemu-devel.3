Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E38CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKv-0000Oq-NJ; Thu, 11 Jun 2026 05:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKv-0000Og-4g
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKt-0004et-Rc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+Oi233XiBxp+rpO5j9u0aVn45NZSh3AuQTspxE9xl8=;
 b=H0DbBmswJZ8ayURVzGAWGHY7dS7TU5kEGHlEYZn9l5dfCWtT5bI77DrSIob4FUVR9fYRI6
 iXkdk5FUzKpJCGRe+AiCb3Pyf0A4CKFjydbVPTRfCxzfyW9O4h4/DKabh1tYky7Ks2Zodw
 qJIVG3Q8esIJ2BrECG1zX1qk6EyxESU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-yLej1UJ3PoaWZJj4GC2CcQ-1; Thu,
 11 Jun 2026 05:04:24 -0400
X-MC-Unique: yLej1UJ3PoaWZJj4GC2CcQ-1
X-Mimecast-MFC-AGG-ID: yLej1UJ3PoaWZJj4GC2CcQ_1781168663
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDA1B1956057; Thu, 11 Jun 2026 09:04:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7447630A8; Thu, 11 Jun 2026 09:04:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:23 +0400
Subject: [PATCH v3 08/35] util: make notifer_remove() safer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-8-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UOpL3VWQfoL9NOG90tt8t0YDaaO8SV+WZheSRGL3tSg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnndAFE9tCuKT6G59Y0DAwNdFhEqkJ+zR2vWV
 y1eHjnWyiWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53QAKCRDa6OEJdZac
 5SkSD/9LhsAn+PDeC2F0MiFqztW7/COnzAdfMHx8LtjXlK6JZjmxIG57s+QgMTakcJGz+BzFwnp
 YR2yF8C/i+0l42/vbjuXb0a+MJWnMbr7Gz0OYwmRmcoJhJVHA5n39bj+tG/le8KzYgH1xeu3/RL
 o2FZsuV+qLUl3VpkQbtNeHojc9YqUg5hmBlR25dsSyAHu2VixZqo1iccL9DBuYaLQDwq32+hCU3
 w0Shj1hV8A/L6Ouc3wpJLGkAN0+H5yAJaV1gIfDy7IFoeo0A3b/kUS1rNUzsoPTLV8aMORujtLS
 0ItG7KCLbQ5b+VRgn9KDzaI6TfyXraIlGkC9qzIQQITQpIdhFeX1RMoJyZsfS8apOH7rw5+qCIP
 0XfMw+dDTL8Ewe74p92Co8lfZBPynmK9lDw+Ok1LYq+JksWObWFJqyswydTZZlZaFhjzvmAW+nZ
 II1GQqvuUbj5xImuGwE4FArDTBgR93hP+YOIOH0eKhYvGQmyVlqaa6bvkiEboa/d1TiMauu4zsV
 4b+s+ieCBuuBAiBGm0EtqGtWbVKeXSuWr91KNwjYO5IFAihTyHc8WmeHeeATCHcZYCRC/3KSgwU
 +visnRPPL77e9gxvd6xTKfshlCqm1iSpFH+vB1llz+CF8/z+gSGQb/maMFahcc/qQJFcChyDFF+
 MMXwg43Oe3xksIw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow to call multiple time notifier_remove() safely.
This shoudn't impact performance in any measurable way...

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/notify.c b/util/notify.c
index c6e158ffb33..24420a7288e 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -28,7 +28,7 @@ void notifier_list_add(NotifierList *list, Notifier *notifier)
 
 void notifier_remove(Notifier *notifier)
 {
-    QLIST_REMOVE(notifier, node);
+    QLIST_SAFE_REMOVE(notifier, node);
 }
 
 void notifier_list_notify(NotifierList *list, void *data)

-- 
2.54.0



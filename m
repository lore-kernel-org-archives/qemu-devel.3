Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48158CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbLO-0001J2-Q8; Thu, 11 Jun 2026 05:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLA-0000uT-EI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbL9-0004iN-28
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fy9FDnBBuQA6XOva2yHkr/+J1a7o999MtLZIJzCYeGU=;
 b=f7Ksp86d/0F89pJzjulakN2WbVR82kp8z5LO0Kh0Gp9ce+hE8rhHGixSp13Gqbk6SGf/Mm
 LHwagOC6Te11tncLPx2t7MIstNLPpQKynwO/kZP7JE6R2ydsy7Siy0fIWre24Y3Yjh5nDp
 oEq+QfZ6JhUVd2+vmE6kW29PTSsNj0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-hQ8UocCaMaSeGkCcty7E_Q-1; Thu,
 11 Jun 2026 05:04:40 -0400
X-MC-Unique: hQ8UocCaMaSeGkCcty7E_Q-1
X-Mimecast-MFC-AGG-ID: hQ8UocCaMaSeGkCcty7E_Q_1781168679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62B361956069; Thu, 11 Jun 2026 09:04:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2353018005B3; Thu, 11 Jun 2026 09:04:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:26 +0400
Subject: [PATCH v3 11/35] ui/qmp: keep a reference of console across yield
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-11-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nFUMF9aw2NB5tNGhWCH8b3CLuYQw1GaCHR49bKZmaWs=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGoqed6ih/g6Pkh4EfgpXzqXsEuKI0qnkPA7us6Q0H+QrAtjc
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqKnneAAoJENro4Ql1lpzlhT0P/A9d
 hfsTPofOWCDc54iytPg7lO6FmZksNt/VNLkvCxja6Z5IVlpmSBD98t4yy2vD9bqwUA+1ELlpcPo
 nzukPQmPeLMssnjbzmoQNtw7cH7hDAAxi2bpt2vsnqKu7hv51DIEZMmNSTCZlD9EcJkawV8agdW
 9p0NeS7J2JijBMW6f3NZIjG6pYREeKeEzBGzQCl9WuFDPh0RkIU3y6zkLjZ6bXiAj9WDU6ArRII
 Mrw9J5lxu5M+Z9sP6zyB4KJchLLEy+Bq9tFFk77eILUEuJ4mGsbjcFW9hnPEGKJklIQkRB5/Inl
 RBDNDKB4wDW3ZTwTSxQejpZ+Uaqhf2SUI+NaxeTlAnHseTJNsnjJUT1EnIkQq0uAcQyY6Pc/6Kw
 JyK/jMUnuqn0b1+CHDUZg5ZIJMyRYnKJ9spjZor7h9BVmZxW9gnH3x2MTXZzQ5bRQQNezfOfJ/L
 FE6+xQQs2qcB3gEX9+rFxR7jWfI+ZDCDsdWsbSICbKs4kHqf1J4kfbE5mdLw+tTKpoYh5qhEoF5
 Eo1iqbIph7vqIazanfPjKamfA50GSon3kMtfixiyi6I5mM2JfGSyHmfrDaY/NeTp8z79LK8AzDZ
 3zErfpKq/VViM4RRcHQAut/ToCwd139LfKVyNANn6qNf+aQZN751Jz5Ou0lDy40iYUd07steRQ8
 XcSCY
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

While the coroutine is waiting, the console could be finalized. Keep a
reference to prevent this.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/ui-qmp-cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 1173c82cf7f..753cc2bf522 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -348,6 +348,7 @@ qmp_screendump(const char *filename, const char *device,
         }
     }
 
+    object_ref(con);
     qemu_console_co_wait_update(con);
 
     /*
@@ -358,9 +359,11 @@ qmp_screendump(const char *filename, const char *device,
     surface = qemu_console_surface(con);
     if (!surface) {
         error_setg(errp, "no surface");
+        object_unref(con);
         return;
     }
     image = pixman_image_ref(surface->image);
+    object_unref(con);
 
     fd = qemu_create(filename, O_WRONLY | O_TRUNC | O_BINARY, 0666, errp);
     if (fd == -1) {

-- 
2.54.0



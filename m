Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3948BCD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbLQ-0001gS-HN; Thu, 11 Jun 2026 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLL-0001J4-5i
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLI-0004mt-Pq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtnkDg33MYu/ghaopwN30hvH/Rt4UQH+q1oST+NTnl8=;
 b=SgQythqBwP8MmDhMU0bsHusagAEWe9fTWmMoxxLc5LNGSM0VOS5EWtMo2IRGBR5CIqDjjb
 kp413mYdDyrmaOP5RUmaewsSlvOLDOU0wFNbEOvv5O4Z0CL+owi0iM9+5JkLedL4mvvJqH
 OuJZ13VaejsGqk4LYVsgnWfJPMXAgi0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-ZSHnaKdBPim4vr927yXueA-1; Thu,
 11 Jun 2026 05:04:46 -0400
X-MC-Unique: ZSHnaKdBPim4vr927yXueA-1
X-Mimecast-MFC-AGG-ID: ZSHnaKdBPim4vr927yXueA_1781168685
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C806A18005B6; Thu, 11 Jun 2026 09:04:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EE6A1954B0E; Thu, 11 Jun 2026 09:04:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:27 +0400
Subject: [PATCH v3 12/35] ui: stop ui timer when closing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-12-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1hj0l337W3NJOgj2iQ5HiEquhGCiA0qJG1NmyVMnuVU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnneJrWucxATzN3yF9uH49DNdOPb6BNfSKtYy
 t12Dz+GFBeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53gAKCRDa6OEJdZac
 5QDjD/459XSa8SSkem2tlgPK8UBNb02TRx8K5VQlG42C+4tkRnqATTRLKgn2a3/Rdy7Om+nU1ke
 BlIT6m6gzujaKYPZQ/7U48IzvuCwSdBkj3GZlPf/lWGiy2aIji9bYaTcCnSsgW8dFuuZ33EWGUS
 fXtNCTSYxGS4IzJQ5c+K1IFLAZft9zlFtgzvfJgrUB45RxhQSo358O/Gosxm8rkLv59NnWTsB+y
 kC6Hj2D+fv/s/eKTuRxtgZjcjA8HIB78YijN9NczdrxWu8z1xaJOROhgc55GlOEuMvxwKSC2RtY
 DX4as/Mqa5ktknE1jK/WtPhqBXANu19DY4de8ZxBE+W2uAqtqDjG1x8B27iiAqrahBZ+52frSFf
 IKrOiz56HPSLL4JpFJf5wcqvSuKiMANV8YCsd+YCbpY19vrXL9hMqKqCQhTAvyadcGHHvI9lm0+
 BJk7ElAU0UnOj03BBxOOwgWp6RAVEFxjiHrVLMVtf01nE+l/TI2Q9tz2ZziO0WZqHYmXLhVBErl
 cN1VdJgm+iYMVQWSlM/4VDuAoiJrIocWH/ZBIeEXnZnsup9/oflAQoj4Ah/eOne5JmJ5e0BEJ+P
 9hTZBCIXHS+hAOE2LSpuMdPWM8vw59qvEnzbStmQu+umBjl4sc7DMtfI1GwXw6krWF6YGN2tvbF
 C87x9ZlS4Pj83/Q==
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

hwops is reset, so if the UI timer is pending it will crash.

Fixes: 9588d67e72 ("console: minimal hotplug suport")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console.c b/ui/console.c
index a7c977d0c44..436444723a5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1136,6 +1136,7 @@ void qemu_graphic_console_close(QemuConsole *con)
     trace_console_gfx_close(con->index);
     object_property_set_link(OBJECT(con), "device", NULL, &error_abort);
     qemu_graphic_console_set_hwops(con, &unused_ops, NULL);
+    timer_del(con->ui_timer);
 
     if (con->gl) {
         qemu_console_gl_scanout_disable(con);

-- 
2.54.0



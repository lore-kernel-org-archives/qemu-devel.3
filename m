Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5191ECDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1R-0004fZ-PM; Wed, 24 Jun 2026 07:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1I-0004Do-Sc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1H-0008Cl-Dp
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV+JszmrvNfV8KS2Z0d82nA11LCXYNDlPGROWbfg65g=;
 b=NYwQCX65kEWt6OrvivLegbxCJ2Nxe41BdwcIyr49JQ6mJ/fblNLdHPd6cPGa8OKiEYV80j
 1Hz4mhvjMvsv44uNsaG4J42yNXlk+6zKr93yyHX9wTQUMA4ANoF3TG2Z3O6beX27mA8AVU
 zKmxg0dO8uV84AzcnUH7NBjFbnqZ3zE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-4F5Ey6OoPQuy9iZllpqcbQ-1; Wed,
 24 Jun 2026 07:43:48 -0400
X-MC-Unique: 4F5Ey6OoPQuy9iZllpqcbQ-1
X-Mimecast-MFC-AGG-ID: 4F5Ey6OoPQuy9iZllpqcbQ_1782301428
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5873180064B
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9209195609E; Wed, 24 Jun 2026 11:43:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:47 +0400
Subject: [GIT PULL 25/35] ui/console-vc: fire ADDED/REMOVED notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-25-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bVI4QNS/ekAdRQLw5pAosXwCaMQhDLh1E4BCtCQXSyw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JoBqQJQycKYKF1Oma9e+13WK431l02dYXSF
 4OPvhscoVWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5Un8EACQ27CjECcATryD+4M209mebOQizw0FJlJGPSUHu00KhnlsE67RCZH3GjQEvBn8Edx+0jd
 jlXptaS9iB7zN86HjvB8wigo+9f+7ZDhusXsLkMrXgwTCfh7UaMKkl36OrFmAy0wDJYmv+8BUDL
 Qjy/U9PFvC3xu6eUABtz/gYflBIohJ9xz5659EHV/ngYPsAva3JEPOVckyFEWrRQCTTDeSPlShi
 f/d7/R5KjlTxjkNQ4pJFbixjf20XQ2y8vqbli8lvde0EKJUkNK1eqVA6B7oBh0xHx9PmLw2Z280
 EGeDqI28gZ60ONQPaDadqB080kcGeh4ZWHlhR8g4U+4On+MSzPP4su2kMxZmBpWRNspRxWBU4yF
 kgbQR6pQrvhyI5CBTXO2SAPrYR42TfqcwWmFs1MDhq7h6V3rJu7wPcfZJPWaa2SYp4HsPkoX1Sg
 uI02rWpC0OZQl/wUfMZkTIVgjho7I/bZRN/273Seus5oU4wuFoCKppEN2BiV4C9HCARtPtdX4gz
 gy8KMTgEUDMYWQuQyB46dqJfF0IAXBW+8Niu0ZrDX75GfKlBMQaf3/RqvyoxUcdr18jGwVaKvuK
 x7ad6ILfd6ctBon6a582YkwyUqUZlK6SZdmpVcTEqwMg4lCptxdg9mIT2xR501WFNg/9S0AVVWK
 kTFOUlWo9oXav4Q==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fire CONSOLE_ADDED when the chardev is opened.

Fire CONSOLE_REMOVED in char_vc_finalize() before dropping the console
reference, so the console is still in a valid state when listeners
handle the event. Also fixes a console object leak by adding the
missing object_unref().

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-25-4656aec3398d@redhat.com>
---
 ui/console-vc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 828e78c41ea..53d9e9d39b3 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -255,6 +255,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    qemu_console_notify(QEMU_CONSOLE_ADDED, QEMU_CONSOLE(s));
     return true;
 }
 
@@ -327,12 +328,24 @@ static void char_vc_init(Object *obj)
     vc->encoding = CHARDEV_VC_ENCODING_UTF8;
 }
 
+static void char_vc_finalize(Object *obj)
+{
+    VCChardev *vc = VC_CHARDEV(obj);
+    QemuConsole *con = QEMU_CONSOLE(vc->console);
+
+    if (con) {
+        qemu_console_notify(QEMU_CONSOLE_REMOVED, con);
+        object_unref(con);
+    }
+}
+
 static const TypeInfo char_vc_type_info = {
     .name = TYPE_CHARDEV_VC,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VCChardev),
     .instance_init = char_vc_init,
     .instance_post_init = object_apply_compat_props,
+    .instance_finalize = char_vc_finalize,
     .class_init = char_vc_class_init,
 };
 

-- 
2.54.0



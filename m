Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C1CCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvDX-0001JV-BN; Fri, 29 May 2026 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDW-0001Ii-39
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDU-0008H3-Mw
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42pjXpnS3GuIn7s6Zh3seKv48mIlHa86AQ8iMF/OKzA=;
 b=VYxLcVcpr3ZN/nsh9ShWAYDVx/3On4Xy1riqNQ+2psKO6YeFDK2MW5bqACDrqtniqHvIs3
 ZboAV5j44/7/NSs1I5A5PcdNucCk7xWbMgE2S7rsgwcpfpyZ+F21dyH1fa9x3oJOJ8oKAR
 sLJlzkrhP4bXxVELrJsJnpIR8lHNzdU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-T5hNag_2OGCcX2rAbzNF3w-1; Fri,
 29 May 2026 07:17:27 -0400
X-MC-Unique: T5hNag_2OGCcX2rAbzNF3w-1
X-Mimecast-MFC-AGG-ID: T5hNag_2OGCcX2rAbzNF3w_1780053445
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C75918002C7; Fri, 29 May 2026 11:17:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87F6F30001BB; Fri, 29 May 2026 11:17:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:28 +0400
Subject: [PATCH 07/32] ui/dbus: remove mouse handler on dispose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-7-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=719;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Zlbop9zuN6D0e4GxEJlAcaL73bwcfVgoQ3P7DEp7fMs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPPJofxC63hIwTlGShgcfhitkAPjEetB5BP
 DrPqxJr69iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5fv6D/4hsVkImrjBXeTkB0yX1BDOEueiEw2N0XRUS8QCael0FcG3HCW3dA5KLWEy/5Rcnjm1HUC
 4PhiYJjkEismrNJ6LQ80lfkKBw45oybog77wdBLIn7PXA3/WUKMFxUY7+DG1XMvrk1HtnTrxOr1
 sCW5GUVgQscK5lGkbJfMRc/vl07qQnT7ARrXgYAvOugxUxra+uLIitI5vk8sIPP3afWdWE5Pmwc
 PStuIGwh29qBQk1W4Qjp7YHJU4X2z9xakGAWC3YzHsQc0/08Qv9eX4Ha9gbOI2UxrJadUmIowXg
 e2wOlu7KdHUgTetiiupXuCT28ge+MrSx7v3+d+H/Ixvamg7ILtCLTRgh2Uo+3t6JCLDn9XIFg3s
 5fnKzqvtZQt3aEScC4bF81ToHwyu0NkYY4BxpMPfsWM8FKD9yZkZY8fd4+ks60DtsQJ00FAgNnO
 ts2cHyoEnH7zBNadlX4kEdRMusZyl4HlwMB/bJgj6RENDvJhr+mnyCoTDXoMqVCVJWrTgtDTz6I
 J0qQm9/9FYWnmKfdTQal+/z1sHuIapYxJghkV+hUUKz/1ryB1HQTEOKnvqrDTWj+hWG5ODzNv5G
 GrlsYs3ShR0X9xSpuIULjqbV0N7a6X5OKjlG5bzUxPySk9IOuOLlnaAo1z+A3aNcvI7jkNDdUkr
 KJIWsx6/DQgbFMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 21eceb24362..0813a08f85e 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -151,6 +151,7 @@ dbus_display_console_dispose(GObject *object)
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
     qemu_console_unregister_listener(&ddc->dcl);
+    qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);

-- 
2.54.0



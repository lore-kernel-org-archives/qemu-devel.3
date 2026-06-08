Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8A6CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFI-0007z0-CH; Mon, 08 Jun 2026 03:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEp-0007gU-Nu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEo-0008Pm-CP
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcFD3eGKhNYPPn3etCR+FB+6qCGmANbtAookYVP4Y8w=;
 b=TNoTJ5P/CFGULp/NE4Xw+Yk17lXdqBByNvM6GEWUqsdtnux6wRhP9CXizZb8yI9/KuDApx
 qsg18G4/AmDqmlw5i5/eNLziPgPaa8rGUKwOtUf9SF7v4wCjoVz9hJF0MFXkOnkapI6+/O
 xfa0ZFiyw4E/gx7pTvUxixkU8RC2Tkc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-e7wI3nJ7O0GBFNzAFU7e_A-1; Mon,
 08 Jun 2026 03:17:29 -0400
X-MC-Unique: e7wI3nJ7O0GBFNzAFU7e_A-1
X-Mimecast-MFC-AGG-ID: e7wI3nJ7O0GBFNzAFU7e_A_1780903048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F4701800BC3; Mon,  8 Jun 2026 07:17:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10EE119560A2; Mon,  8 Jun 2026 07:17:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:27 +0400
Subject: [PATCH v2 09/33] ui/qmp: keep a reference of console across yield
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-9-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=979;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0olnm0BeIdXkJ0+wwoqLifsBYBl2XPr7D4I8xkjuhkU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxJdMdDNoXaUOPWZGKtDUajhmm5c4Z60+3kx
 d4U2xf3nliJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSQAKCRDa6OEJdZac
 5ThvD/4hLy17igI54vr3RK0mfeFz59gI6hLG/FOfQtqyPeTtz3Ji+ab7sAIaUYTwOxltBVljY4u
 eJRUZZ58P5iYXlAnGRZ9GwmzTojWQ5mMPfT+2xpAzHqzXKExSOEh61kzCPDUBwHKGAnCOhGQ8Lx
 khU/6MgaTgqhFQ17WyuHwcQyWLdpEIM3h33J4cO9coNVe/NoL/w6wXuI7f7ZIHQD785kH7I7jJF
 MzuYbKEhQzMQQ8d4OiQM4ZzEWja04MrMJFDkY6w14N3gSsI0U6dXw0D/xAZbsNFeu6YK8S0buZQ
 /ws3RjYNo50r/wg94XwBTLTiMvcjZH0RcU1Mz0VfdXMkJSAv9pUeN2mcb4LIsCbl3Ini6XURGnr
 SIbzilE3PxC/r+Dt24krVC2+Ntgz8wMIe6zQR+oC1DC3Zo0jeyhqJGYzl+jSuWKheGvCUTK991f
 6o5v/Z9LNRLeVDIyonMDlYuP4nMfS1zAsEVzpSsuHE+zlv8fG6U54PxfPa0d0nKZeLFC10iZ7Du
 I2ICiowejDFWuMnJIoII1Foi3bjK2zldamyZf2WS96iQh+VcPTGm4ZgwkHADYWVYb+IJhhuhDEp
 vSewljWmH3PrcgJ4xBZSVuD+e4eTtDnbsqsWnlamCbuBW52bTwb6vl4sWosYAzvpYUZ1lJrgP//
 5kRKkQ1kCt9Y6Zg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While the coroutine is waiting, the console could be finalized. Keep a
reference to prevent this.

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



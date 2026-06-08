Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A8FCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFI-00080u-MQ; Mon, 08 Jun 2026 03:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEu-0007jm-DI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEs-0008RX-V6
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6K3XQqYyaBJEyhYGRQWW9UcrsUENmBwDbMiigmHod70=;
 b=SCjTQoEp/aFEHNPS3r7g3/ccKYjXiHChuP1+FVH/hoi3N5pwkXDEaUmZiO9Ycs5UpLzBe8
 3oJTCuA7etU63ty3KvgkICkzw1C8NEhBQuYMzxttsBdt0hW6OiwLM1t65xmGQX6N+JQNQW
 tQ/sVzGhj5oFMZ/RnnQMaFZmtoj4YNg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-oVPsncoXMDKsfeJxEs8C4w-1; Mon,
 08 Jun 2026 03:17:35 -0400
X-MC-Unique: oVPsncoXMDKsfeJxEs8C4w-1
X-Mimecast-MFC-AGG-ID: oVPsncoXMDKsfeJxEs8C4w_1780903053
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A46BE180034B; Mon,  8 Jun 2026 07:17:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 565CF1956053; Mon,  8 Jun 2026 07:17:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:28 +0400
Subject: [PATCH v2 10/33] ui: stop ui timer when closing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-10-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YUzpFgJn1xd0cDCfwxua7PPmtRu9gxO8rB3nqbkqdZI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxJjqDtYesNtgsqNGnU0gH9W39QfXFrlYWnK
 t5p4qDzU3KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSQAKCRDa6OEJdZac
 5QocD/9MTrFCLXs2lJUrTnd24xpOf73yqqFoZbpjSn2icE8oMTvRmnc58aht+OHnQ1ZmGe8WxtJ
 nWhgbZkIzE5FiEIo7pm83R2rFtQIvl5eXciewIp0saYDEUo1/GWFTTj1p5qf/u6M4pZHUKubivE
 wGhzp1HKcoVrg2FcQ1Fn5RDyMJ31E5aELJzv6t8JBG+/z6U2JmxpV/kydefWuV7i1MuEV6RTm2N
 dxAZJSQeyFe+iCNKaqM+vVHdridhr93/cKIXox2wuL8FOH3N8TgeBw0fvZoc+ZCLyx8yaBvCdYf
 1rLtbH3pHICyjis28US89yPAjrATccjYhyMg+C17xeABenQg9n0Z/owXSClz5syxvFBVf/3FJEk
 BiFk7eMNdKeppb+ill7N8/DLgs8D6iYO+BHAf5y9cKjr/XHNvmoWMirtQTm46pQhueb3wm0tLGf
 d13ljPwv5QRNNOGJinZM2m7zFxrfyRIpXA/nWBc+gb//HUGpIwnPAgE7Cu38Iej4RRXByWOfh1L
 75iYfqNebzf/UptZ/VrJ2AP2AGyDqTYJX2kNAaw5UV3W92lPIhmZkB/fcqekjErKJ8bYv1j6Eet
 F+P6TH6jekz6g6fQuxJkV6J0K91VwFQBhLof4HVPxJ1DviQrIRfPGRL1OXmD7QJVJJ55jaEFGBs
 2SgcdPKQhHtvc8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

hwops is reset, so if the UI timer is pending it will crash.

Fixes: 9588d67e72 ("console: minimal hotplug suport")
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



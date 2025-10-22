Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957CCCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSmK-00085V-Uk; Wed, 22 Oct 2025 02:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSmI-00085M-8i
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSmG-00080V-LR
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sn6D8TaKLKB7thke8D1SYCsRnUDMQrsF66p9VZMru88=;
 b=UZhAYlBFESdGBv9EM3DXdazq5JvG1DYTgq77tvOf/ExnZCzSK2Ua80V4y1kd+52IR/OfAl
 gE/MlOG5I6d/FGz8ULeuTyFUjqgfSRR582qezH5tA/MIThzckfJ2Zw0/v5PZg3uJ16LdBw
 O7BOx0NyNM+RqpOnNzVwR3BNZXQvTbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-AJYHHLv0Nne9VY9fouGbgg-1; Wed,
 22 Oct 2025 02:56:52 -0400
X-MC-Unique: AJYHHLv0Nne9VY9fouGbgg-1
X-Mimecast-MFC-AGG-ID: AJYHHLv0Nne9VY9fouGbgg_1761116211
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EA75180035A; Wed, 22 Oct 2025 06:56:51 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A28A819560B0; Wed, 22 Oct 2025 06:56:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 01/42] hw/audio: improve error reports
Date: Wed, 22 Oct 2025 10:55:56 +0400
Message-ID: <20251022065640.1172785-2-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The -audiodev argument is 'model=..', use same terminology.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/soundhw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index d18fd9fa05..b06552e7a8 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -70,7 +70,7 @@ void show_valid_soundhw(void)
     struct soundhw *c;
 
     if (soundhw_count) {
-         printf("Valid sound card names (comma separated):\n");
+         printf("Valid audio device model names:\n");
          for (c = soundhw; c->name; ++c) {
              printf ("%-11s %s\n", c->name, c->descr);
          }
@@ -88,7 +88,7 @@ void select_soundhw(const char *name, const char *audiodev)
     struct soundhw *c;
 
     if (selected) {
-        error_report("only one -soundhw option is allowed");
+        error_report("only one -audio option is allowed");
         exit(1);
     }
 
@@ -101,7 +101,7 @@ void select_soundhw(const char *name, const char *audiodev)
     }
 
     if (!c->name) {
-        error_report("Unknown sound card name `%s'", name);
+        error_report("Unknown audio device model `%s'", name);
         show_valid_soundhw();
         exit(1);
     }
@@ -140,4 +140,3 @@ void soundhw_init(void)
         c->init_pci(pci_bus, audiodev_id);
     }
 }
-
-- 
2.51.0



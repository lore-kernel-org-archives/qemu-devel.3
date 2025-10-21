Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12802CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8HQ-0001E7-Dn; Tue, 21 Oct 2025 05:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8HL-0001DE-33
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8HH-0003tI-2v
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWre/z+vR/CLqO7zzWmcSy+RcJw8bmgEDmfOcom/YjM=;
 b=cGyp7ehAxC+kbQfha8PDKwi6TRLOYmPSyvy9WzsqvK56LXn9fBI+fQqL5OV0EdbCGb083L
 U1Gf5H+ir8na66SFm09kY7gaiHfnWnvvMox7OvgdhxqZAD620DzSgCfqNfeLG7SXzSGxvh
 W9qt0zHp3LgPpkt4U93nBXw0d6yst94=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-hyWAkD73OeCk9xc0to2nLg-1; Tue,
 21 Oct 2025 05:03:29 -0400
X-MC-Unique: hyWAkD73OeCk9xc0to2nLg-1
X-Mimecast-MFC-AGG-ID: hyWAkD73OeCk9xc0to2nLg_1761037408
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 733B9180065F; Tue, 21 Oct 2025 09:03:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D27F41955F22; Tue, 21 Oct 2025 09:03:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 01/43] hw/audio: improve error reports
Date: Tue, 21 Oct 2025 13:02:32 +0400
Message-ID: <20251021090317.425409-2-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



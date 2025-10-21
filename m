Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C73CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8HT-0001EG-0W; Tue, 21 Oct 2025 05:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8HO-0001Dv-Lt
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8HN-0003u1-0e
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/xAV+2Lt/HYeRsni+7q5oxVBDVj2z/c8SKiYPO847U=;
 b=DQGSLFdPXaV0rwxOSr+ohqynsDTod67zy3F7ysd89n3ZFw0vNNJN0HEjshTh+Nfjj2evlK
 Ruz8BqHCR1ce3aosCnLPOhrloP/yd8H8nunsN9gPh0etBf69TjMhGDpmLQcd+wEVkLcegc
 /qqApjGLRz3Kc8OyCA9We+qkgip+Rlc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-lW54-vqVPaWOPj-GKodwVw-1; Tue,
 21 Oct 2025 05:03:36 -0400
X-MC-Unique: lW54-vqVPaWOPj-GKodwVw-1
X-Mimecast-MFC-AGG-ID: lW54-vqVPaWOPj-GKodwVw_1761037414
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53BD11800669; Tue, 21 Oct 2025 09:03:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CA7F180035A; Tue, 21 Oct 2025 09:03:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 02/43] hw/audio: rename model list function
Date: Tue, 21 Oct 2025 13:02:33 +0400
Message-ID: <20251021090317.425409-3-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/audio/soundhw.h | 2 +-
 hw/audio/soundhw.c         | 4 ++--
 system/vl.c                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
index 474c5ff94e..83b3011083 100644
--- a/include/hw/audio/soundhw.h
+++ b/include/hw/audio/soundhw.h
@@ -7,7 +7,7 @@ void deprecated_register_soundhw(const char *name, const char *descr,
                                  int isa, const char *typename);
 
 void soundhw_init(void);
-void show_valid_soundhw(void);
+void audio_print_available_models(void);
 void select_soundhw(const char *name, const char *audiodev);
 
 #endif
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index b06552e7a8..aca077f5ae 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -65,7 +65,7 @@ void deprecated_register_soundhw(const char *name, const char *descr,
     soundhw_count++;
 }
 
-void show_valid_soundhw(void)
+void audio_print_available_models(void)
 {
     struct soundhw *c;
 
@@ -102,7 +102,7 @@ void select_soundhw(const char *name, const char *audiodev)
 
     if (!c->name) {
         error_report("Unknown audio device model `%s'", name);
-        show_valid_soundhw();
+        audio_print_available_models();
         exit(1);
     }
 }
diff --git a/system/vl.c b/system/vl.c
index 646239e4a6..d20a9cbe08 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3077,7 +3077,7 @@ void qemu_init(int argc, char **argv)
                     model = g_strdup(qdict_get_str(dict, "model"));
                     qdict_del(dict, "model");
                     if (is_help_option(model)) {
-                        show_valid_soundhw();
+                        audio_print_available_models();
                         exit(0);
                     }
                 }
-- 
2.51.0



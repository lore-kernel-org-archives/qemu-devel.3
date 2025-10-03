Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262AACCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huY-0005C6-Ow; Fri, 03 Oct 2025 11:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htz-0004qn-DT
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htS-0007e4-Ep
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQD9uiyctbLngMbbep5/otZ3pfbbfdMxuycGepGUXmg=;
 b=jJvZCqNCh7j126Ue4cKe4heFy5O49Q+I1IyR5ElsmEKXJO3EYF6nzU0J5HQvhO+4bcC6N7
 4eJf0J9uOvEAd2oeUV2PXv5edj8KRR8xL0CPE9peudj1p8IWArIFor2N8OiLKm+Msu+L22
 gs0zp0UC9Zocta6tgUoIDl8awpvm2tk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-wzbfPvK5PKijnGLtrNzO7Q-1; Fri, 03 Oct 2025 11:40:17 -0400
X-MC-Unique: wzbfPvK5PKijnGLtrNzO7Q-1
X-Mimecast-MFC-AGG-ID: wzbfPvK5PKijnGLtrNzO7Q_1759506017
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7916b05b94bso62008236d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506016; x=1760110816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQD9uiyctbLngMbbep5/otZ3pfbbfdMxuycGepGUXmg=;
 b=YVEvAOuR7c7fZYJsbXc7Bo1sMH2wAccoAbmKQK86GgLzcAYtqioFhtTXNAw9f4NDeD
 aSx6tu0peBfrvlVHqUl1IxfM1sHGXpYwisXBFofhHJKRclLgRYZgAQdr3jT5QBp5NUb0
 UutLINyqoqVWMBtBZ4hOLfGIrOe3kdegS5+Fz/qKlcralaJqov6iHbvLFH6ycAIKtKFO
 kMGkhTQMQFK5VEED7nsUv/HMzS6/5zmOIA6vUb/m8MNu9OJcVsGCZlT8fxseRVHU1ROd
 fMbtE6kL/BuMv/Ey92lGrPTV+3gCSz+8ct5/AzJyr9AcXSuVPuPIL5WVy+tdA9uIh1xK
 /PpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP+gTvewxVOFVxafKevt8cIwbU3eSmcZgbggbV3kAhlb7aIPb4Ux3FvzihLAjYHE/hqEGnjT3+v06b@nongnu.org
X-Gm-Message-State: AOJu0Yx/+foZvQWBEyrMeDCBnn+W3Woz0l85j2ucPOgON2DIJngjtExR
 HZlW4IYiOxGHlQvpRcjP0Rse+3Lw414Hef+ceBCei0OzICrowzx1pjVLTsUI3Wdn8f0DrHt9sRM
 heSRG0pEy8zYl86v/71gYH1UvZMDeQwcQH10z58Qo4IkOoL+zKwPf7wML
X-Gm-Gg: ASbGncsbpIFZZOTQ3USKOqQxEK7B6rp7lVWPSNUquMcYdBP2lpIlbEXD0VeaESw0sgv
 LnAoWpcrb4QH8mF6OcdKfwCnlwi0FZFYGWMVC/be/V/NL6SodJC+mAvS5Dg7SVbvivw2fZcNLMM
 RQeFkcDyyDInXzPUg9TecqESIsvaF1XXoAMVnr4qpTfEA4lwGudp7l8iRejaqWH08w+ZC6Dyxll
 lpLyj7rZg0KqXzmVTy1PdBrpSTHLHAKc+C65S218XwBx+Bguf43/ZAb8N4TcnW5pvEcZpi7vmvA
 MuGYhmi8fgut4SO383KiomRa7m4VaoRzVpnl7A==
X-Received: by 2002:a05:6214:2b0c:b0:803:3b8e:e9a5 with SMTP id
 6a1803df08f44-879dc82dc17mr42778196d6.36.1759506016343; 
 Fri, 03 Oct 2025 08:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhBLDQ7ecur1FcSuL2mN/DTAsS7kyVaPBapybZp6meREyEHkcA2enetUGakOlyluZRAYinVw==
X-Received: by 2002:a05:6214:2b0c:b0:803:3b8e:e9a5 with SMTP id
 6a1803df08f44-879dc82dc17mr42777806d6.36.1759506015751; 
 Fri, 03 Oct 2025 08:40:15 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 16/45] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
Date: Fri,  3 Oct 2025 11:39:19 -0400
Message-ID: <20251003153948.1304776-17-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_listen() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-16-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 38e22b435b..ce88f56498 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2181,15 +2181,16 @@ static void *postcopy_ram_listen_thread(void *opaque)
 }
 
 /* After this message we must be able to immediately receive postcopy data */
-static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
+                                         Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_listen("enter");
 
     if (ps != POSTCOPY_INCOMING_ADVISE && ps != POSTCOPY_INCOMING_DISCARD) {
-        error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
+        error_setg(errp,
+                   "CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
         return -1;
     }
     if (ps == POSTCOPY_INCOMING_ADVISE) {
@@ -2212,14 +2213,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     if (migrate_postcopy_ram()) {
         if (postcopy_ram_incoming_setup(mis)) {
             postcopy_ram_incoming_cleanup(mis);
+            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
             return -1;
         }
     }
 
     trace_loadvm_postcopy_handle_listen("after uffd");
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
         return -1;
     }
 
@@ -2622,11 +2623,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        ret = loadvm_postcopy_handle_listen(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
         ret = loadvm_postcopy_handle_run(mis);
-- 
2.50.1



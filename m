Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F55CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RtN-00070Q-EO; Tue, 30 Sep 2025 00:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rsf-0006IP-E9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RsW-0003K4-2u
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSbMiD0S6XANubdSaRE+CcxdWMc363o6uw1yalfL3f8=;
 b=SdqH2GHjLoW2Pp9VYq4gyK6VRRaXWBpQLIsMBV6356iqBdH/0B14xbNx57Uyg7TdBMunmy
 cFeIHO1JajiYqFWWkj1S8uu8ddRLdixkt5DU5d6LGy+QgoI7Nb9OcYonSD9PQ8Cz8SKc9y
 zXbWd03/iWAQSDNym9bRASNEcODsktI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-zixeMml6PJiEkm7m8pfxjA-1; Tue, 30 Sep 2025 00:22:10 -0400
X-MC-Unique: zixeMml6PJiEkm7m8pfxjA-1
X-Mimecast-MFC-AGG-ID: zixeMml6PJiEkm7m8pfxjA_1759206130
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-780fdbbdd20so5798174b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206130; x=1759810930;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSbMiD0S6XANubdSaRE+CcxdWMc363o6uw1yalfL3f8=;
 b=EozErRW4Yd2yCTHVvVfz9K+FxJGuVNHDQBiFP7jg5Vxv4M4SmiN9idpe+KxunXuuJy
 bhTmGeoezFVCRveuCcswK02JGiZCkdf3HVwm7sK6ekknAlKJMyssKSv2X7e/+gM0D5JH
 v1mJQRciSaXxc1CqOX/iRXPsPWTTXrGLcLMTUfQb1L13l8PLXOoyo03HUvdAQuk1xAbW
 swzBr1EDAjvAzp8zqmPRQAciItOyQojgSaORM1rKpKqOiHW/120T03rnuBdxV5JC8wrw
 mlWAULX6lc3IXIJF1tOd9c/vrmQ83MRJTSODXrf3yuPybmmk0O0Q3eW1MNYi0qhhpQpY
 I0pg==
X-Gm-Message-State: AOJu0YzIv5Bzr5kB+mXVKdWRJs+pvwbrHZYumFWsIuDtvpHdzfnaXzx/
 4gphfNeanZDtgmqdqpNnZBMWnyl1SND4rLjFO5UuEqDExxPgTyt34hLtbnPklrVIhR7pSeNsVrR
 RnaLATIxg5vN41fAcSTa42uWWoYTMfYEXzGnOLZyfCwIUBq8pxI+Ia+5l
X-Gm-Gg: ASbGncumPKqb/jpWOpf3/W+ciyf+hQtarHS1tjkKze7BWO1v5cXefVcChhFAIjo+LDv
 xRJJ0tucIFA3OvS10wntmkfvvaCvD8NJAJvQRy/Dlyvy8RegjGRWSSNvfm8ZntVDSIZzO0QZXL8
 7HQu99YJHv3zqVUgs1JsmS+YXEg0UZ5YqJTk1GfKZQmWvrZdtbclgRcDLXYliIzY7Sfklgm50G+
 UVxP4llYB6K7qMDd3+/bZiX5mOJFX0LRv6pJx1Tp3BMIqalCAOFZV2IgObD0z4/hdz3CfUOzYXZ
 XFa7q6UdpablNII92Cf4rBCzBjXNrCkItcvgVG9Cv9BeBteI3Xa3Bz2/jw==
X-Received: by 2002:a05:6a21:6d89:b0:2d5:264c:e49d with SMTP id
 adf61e73a8af0-2e7bf47c0fbmr20132308637.11.1759206129778; 
 Mon, 29 Sep 2025 21:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeQqJXlQZo3Xz7swq1CiaKu4JakmJL3iYI84a4Ym80MT9ctRHN/M7FjYsTRZRDQEOlRxNfuQ==
X-Received: by 2002:a05:6a21:6d89:b0:2d5:264c:e49d with SMTP id
 adf61e73a8af0-2e7bf47c0fbmr20132270637.11.1759206129375; 
 Mon, 29 Sep 2025 21:22:09 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:22:09 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:31 +0530
Subject: [PATCH v15 22/26] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-22-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=armenon@redhat.com;
 h=from:subject:message-id; bh=BaBhVPmuOC8KBhh2+81w1uLDIxw24n1+NGBQJ8RFRwI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKKHk2RNjfeeG3vrJFD/vU9L5nrCNx1wOGs6QiJ2xs
 7BlhapTRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgImIrWX4H7Lm1Opu0/m3Pi3k
 eVKRc0Ox5OeDaa8OT3vw1qpBN/sd/zZGhs9HXC6/d73ex8sgZ7zsw5kow6qdj0QDTqzKmde0UJV
 1MTsA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8937496d9f667f8f524f73bab80dd7e711973a1c..34b7a28d38dcc4293457a87b34dbeaf538d89de9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2534,7 +2534,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2547,6 +2547,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2655,11 +2656,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;

-- 
2.51.0



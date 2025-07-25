Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E467C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHOk-0002qk-BB; Fri, 25 Jul 2025 08:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOg-0002lf-Lo
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOe-0008Ly-QQ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753445971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nSdOLBofbaMI4nm2Vl1Ir6bZz6SRg4kCgV4JN9Dx5bo=;
 b=coQZSo/wv2NyWQQZXM9NkKlXfpeu2RK0wxg8m5oymgjRZG14nL2ZUgYM3Zjf4JbY8Oana+
 3cnRFhkgFuwkLrgbcmsIMGZFgdkIeKbW2N68xUC+Sw4pSlHlMUfOEQb4MXL1k13Nc3iNKs
 7HwsR9WvxKvSprDgBifKLpQjMWGhSZ8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-o4cDEcqHOfu5StwnyaApaA-1; Fri, 25 Jul 2025 08:19:30 -0400
X-MC-Unique: o4cDEcqHOfu5StwnyaApaA-1
X-Mimecast-MFC-AGG-ID: o4cDEcqHOfu5StwnyaApaA_1753445969
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-313c3915345so3264326a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753445969; x=1754050769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSdOLBofbaMI4nm2Vl1Ir6bZz6SRg4kCgV4JN9Dx5bo=;
 b=vBZiQsvKdTUQbc8Wrn/h3buEQCuEYbGwGb58a5LZp1oX6L347gs+0b7+yJ4/g6WvRF
 7lwfS6gjHuH+bQOTgVoNP/E5V6j3xYLDfkkfQBExY8g2HrUG4tYa1ipdhx9ErGbq5bKx
 RYlC3P3tJ32AhbCtB8wBtW3SwLE9oBk51sWJWWMBtxQMEJmjpA21V7MQrJfwu3PlBpm9
 iKPePuNeNmRnKdkcFPgOqprwrmoojo+VdOxXNljm7bVlrumBBTV6iUG0cpkvhj3ehuDN
 FmHcTphGQQlLoBCw9G8DzRzxSVWtpMEPJEmZgdXaukGDKj3TdPu1QLF2wDeGkySrPhGN
 piPg==
X-Gm-Message-State: AOJu0YwhRK0t8x1sPrC3SDr2LQBgFql6ky/+hJnK6839KwMxHXH5e36m
 iak2BT+LeUkUa2CN1MwzIL7yhrDXhWcEKNYWaYMjthmvIoBnHqfGmwWNJLW2P4o/FjBE81fTf6y
 BHWi5A/S01znEVzsD9IEH8A/QOC7Kgr/Ncl6l6nDxxS+7MS57v12oLaMX
X-Gm-Gg: ASbGncv3bt4nVr9Ii8JUGE3CNALPDEQrZ5oodc8EN83/68zRHnJLT0zlg7Y7UTV+Qjn
 xY5RgqcUiKmRzs0vzsdMEjaCC4L/Dnk93eQJgp+9Pj9p3sXflsbFPaIzT44wCBYJ8h3v7DWbOUi
 TfpUkR0VnIAsmp0C9Wk7Vt1/YuffZHRuzQkD5t2d+Ef92HXUhu/wHqkjsNPbLos6927amCxcQxn
 FUjzckeo4Id7Z/Rpzt1NepTWlhE04R/12L3BV3jygigEgbDb2HCEyX59PnMh6OP9PlIsqEgAbSG
 db/oJv40wzfj21jT5Ws3PK07rN0jYXoenXmvH16MJ5IAiJxkOUFoOg==
X-Received: by 2002:a17:90b:2dc6:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31e778f7b83mr2854678a91.17.1753445969261; 
 Fri, 25 Jul 2025 05:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWWG8q6k/Edi3H5TiO96jTiMc9voUOIudslGWUe2Gy/J31lHGvSMlsU/jDJXAGjjaGf3bcJA==
X-Received: by 2002:a17:90b:2dc6:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31e778f7b83mr2854602a91.17.1753445968799; 
 Fri, 25 Jul 2025 05:19:28 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:19:28 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:42 +0530
Subject: [PATCH v7 03/24] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-3-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; i=armenon@redhat.com;
 h=from:subject:message-id; bh=xnCl1fpSvmju98xAm/G0jLUaLzXtEPwt2s1ve1LBQ4k=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmfYpRrGdaqVVBvIC804rHF51UcHZpnDqkuzKxsVLd
 yz46xvYUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCLZ7gz/0wW/8d1996BZjvFN
 /sKEZ5HOeXmPV8YYGx8/ly8S0X/6MyPDHp8i32crjLtnJ8z9Xi9/Lbd824qUFJ3MdYdf+krM21n
 ABAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ab947620f724874f325fb9fb59bef50b7c16fb51..842ff3dc6d5ccb05f7d33cef9f7319b141419501 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,35 +2814,44 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream, magic: %x != %x",
+                   v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp,
+                   "SaveVM v2 format is obsolete and no longer supported, "
+                   "file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION_COMPAT);
+
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream version, "
+                   "file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing, %x != %x",
+                       v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 NULL);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -3119,7 +3128,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, NULL);
     if (ret) {
         return ret;
     }

-- 
2.50.0



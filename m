Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB64CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rps-0002l3-NX; Tue, 30 Sep 2025 00:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rpl-0002M5-Rz
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RpY-0002Es-F8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759205948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NThS9p8Yxa6txtHjPyeBwK9TVtucKcFlqXV7HSt75VY=;
 b=BSgMLMkEr5JFX+eaiGCsgu5H+z0SCpKbS5K2iev+neZW6kpfcWe+FjfUz89xsVDoYLvodA
 CUSawX7d8gYv7e4r2Y1kRqKIZV59H+i9v67G9xjOZYknHwo192fGnnejCxA/ZOlBezt9Zn
 AVq6xszOlzc66kpd/sptJOiVaiYv/LQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-E2e6BfI5OjGqAbS9_EIRwQ-1; Tue, 30 Sep 2025 00:19:06 -0400
X-MC-Unique: E2e6BfI5OjGqAbS9_EIRwQ-1
X-Mimecast-MFC-AGG-ID: E2e6BfI5OjGqAbS9_EIRwQ_1759205945
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-77f5e6a324fso9843873b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205945; x=1759810745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NThS9p8Yxa6txtHjPyeBwK9TVtucKcFlqXV7HSt75VY=;
 b=n/Tdu69B9zICTaBksRglJuRntCBKy95HFFJYnUpgFlXeYDWipytoj7sFZEP5Ln/mQ/
 BAnNoHg6WjZXjaDeepuTYVweQvdFMqm06hKa80k8UC9kzfZsLt1gsP9L9oLEBL/iqzcD
 I/EBcFCgs3q8cdFBwjfkEl/Hx7SRHWKVHUTsAdcQooKkz3yjQLHMsFxnytzjBdFIS2bj
 QVLBTH7APoeDa3rcEpfTacoqWAfDCQr3l4oAJ7j1QlefNnHcFe/dlL8AvF80A/SKmQqL
 6b+JbvlxhzHVX0pVTm0IOxSKSRTnRFJwU/XfDCRlj0+h2pCVpTDZycRHaY0CrXB6hJVl
 iD5Q==
X-Gm-Message-State: AOJu0YyizDmffz6Zen6iRbvB2oDK16V0QGZTicnj+3A6HgLIDakxk3wt
 GUBCoep2xGMD4/Kx/jq6ZKOLXq4WeoXCFug2WRZxxZwgNCfHBqKodGmTqXcXTW0she1YP9VHDWt
 uFsJPmdQ9UrddCvMfnRmW1+39tD7PILPv6piuiZejEUP4kXn9Lw/TIJnG
X-Gm-Gg: ASbGncstBJZRQLYbIUrwXahJKKnhPdz1Bn0uQYv2gv56cPxBUF8qWMFstNojJZLGaKl
 ObuathtEfdVtBBTYg1cnmRKPXgAP8XM4+/i4OgCfhRvjUJ0GgwaEtMbM70rO10v5ATh4HH9hulT
 QURjwSoPFfoClcIdOoCIlPQQ3Bc9Kn0tG7u6ID5zwnNbjSTCoc200IEIJGBpczxpsCEl4JRjgJT
 lImQhLazHH9v1EG/CitLiDgzM7T8U+7SAh9QzYCTiUAKcdKpDLVcxusXIIHYHxnwUr+FEvHXUAd
 VgUgfLb6/gKMw0Qc5XVWv9LLrEHoRDLyaleHc9SNENxCw7u6BXOnvLcYxA==
X-Received: by 2002:a05:6a20:978a:b0:2f3:f59b:3ae6 with SMTP id
 adf61e73a8af0-2f3f59b5a21mr12533731637.11.1759205945339; 
 Mon, 29 Sep 2025 21:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENtJPD3sP4ShVqM1/dlbFYmx4yuSlvkDfviMywGaP2L6LHiCJQyhgS1z+ZJjqjBRbKLGxJUw==
X-Received: by 2002:a05:6a20:978a:b0:2f3:f59b:3ae6 with SMTP id
 adf61e73a8af0-2f3f59b5a21mr12533706637.11.1759205944996; 
 Mon, 29 Sep 2025 21:19:04 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:19:04 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:12 +0530
Subject: [PATCH v15 03/26] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-3-84afd3af1e47@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=armenon@redhat.com;
 h=from:subject:message-id; bh=3I3c3pC0yMjf/OLnEpjrmFgFajONKNqF/dblrBG68V4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKAH9EI2qe4zevUXnw6vmfd+y7PmGRx4xSxYvZdxc9
 WpFiv7ujlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABPp0GFkuPJX9/XliqzAxvAp
 k9/WcWvd8ar6NfNoz9lpN3f3JW9cdJiR4eVVC2X2c8lbFuvO7FzyaN30aYez0z5cLLDgvN92ZMZ
 bVj4A
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 55c99e0902dcee5c4a5a974891cec9f079146bf5..8ac3d338148fcfabe652082ba6f3f805d22fcb28 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,38 +2814,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
-    Error *local_err = NULL;
 
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
+                   "SaveVM v2 format is obsolete and no longer supported");
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
-                                 &local_err);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
-            error_report_err(local_err);
             return ret;
         }
     }
@@ -3121,8 +3126,9 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 

-- 
2.51.0



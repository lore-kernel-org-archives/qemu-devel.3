Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665F0C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzcv-00075f-5b; Wed, 16 Jul 2025 06:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzc7-0006CD-5d
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzc5-0000Dk-AR
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAAn8p8gxY87pkvl7mytiCpjUT1424U2xaE6IZz2+tc=;
 b=cKWzUcJ1TU2U2v9DOl6angT/jj+4XbWW57RFY+DnBjvnfrYs6uppVsTOK6DNROa4VYgQt/
 v49s29BPTqbZ1YbC7R/2XLq4u5SUF1PV4Crgdjhc9A1nWHV86XcjkZTQxsGTShgXdoz2AB
 g/3hiaXIqDdPlZcVJnQ56fiOfRIgDVU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-31jKZAv8MEiIQ1Dgq5C_VQ-1; Wed, 16 Jul 2025 06:43:47 -0400
X-MC-Unique: 31jKZAv8MEiIQ1Dgq5C_VQ-1
X-Mimecast-MFC-AGG-ID: 31jKZAv8MEiIQ1Dgq5C_VQ_1752662626
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235e7550f7bso64684785ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662626; x=1753267426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAAn8p8gxY87pkvl7mytiCpjUT1424U2xaE6IZz2+tc=;
 b=Cg7UB+3hfhwq59smY4PyP2nv7iyFmaTIjREIctbp+2+3PUDytQCgjCNa/nzZt9PMXN
 xFhGEhyAZYN0UOI/Act2ph2CudA9rln8lJTPDNN/8eL3o72pLi/GDDK1q9StEnA/Pclb
 QaTqHXHFYjnpAp1DaHEtKfHW0cpAjCfshD0miTIMzeTxAbR3BT2KTU/8HgTr8nhKBqcO
 nOdWvpx26bMm4mu7ZRxMVXt9B4NJaShiXeJ+AQPSu7Oh1i8Mo8NCtle29RhvqfeVkAHy
 QhYcFHLyF8mNknTNfxeIE6mXGlb7wSJr1PRC60qSv/hCI78kdcsYWyefongRqf+Zkxzg
 sing==
X-Gm-Message-State: AOJu0Yxar2W/kxBX0XlMHTJIL8JS8Dzcp0t/dg5B9NWbwR3D3USg2WH6
 /6F8bujpz1LHjBlRSo5p+KTBaU+7nr/c9xcbgQeJXA0FXd7zvc5Ox0brXES6eLnpTDYL3n8DoLF
 l580NG2aNIi5W3LVOXdcfc82+RM8v5fm+64ZK5CZ2ZJQPSGLYxXBY4ZSa
X-Gm-Gg: ASbGncvoYZfEC0EGjGmUxjLjWEXVVfdkbgcOtvLutHOeAkB/ydQgp8ZCKPTPyxm3nxl
 eSfR7IeecFIN4l+rj/6HrvVlnIzzfLqsrjxIIx4cbtShT87bxgT/iWa5LqRz4eLVyQAq9ShaSsT
 kvIO33uTg4xLy8qGlFfJOV+Sl1C2hYxWWqbiUlpFCjFF1bqIpJQvmsOPegsngo9jsOz33fyHaK/
 di4Tyk9UzHdGW2Hem61eotCQCoDXORkMsweg5CGKzUzIrUbUSIgO37o/eQ0io2rZHubFM9iW9VT
 Wvh1zn4xuhtc4oLPvDGFX0kJwaxxPU1ATGpK0Sjl56xylYV+nw==
X-Received: by 2002:a17:902:f651:b0:235:f3df:bc26 with SMTP id
 d9443c01a7336-23e24ebf5a1mr34316465ad.3.1752662626277; 
 Wed, 16 Jul 2025 03:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLGzI0/YnmFzP7Wp3mMRoV3x9IBEPnt8njjzqtQ1jZyss5ZU7c+pFcFmTFqTjXgqyG4TjuCw==
X-Received: by 2002:a17:902:f651:b0:235:f3df:bc26 with SMTP id
 d9443c01a7336-23e24ebf5a1mr34315975ad.3.1752662625867; 
 Wed, 16 Jul 2025 03:43:45 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:43:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:53 +0530
Subject: [PATCH v4 03/23] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-3-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=armenon@redhat.com;
 h=from:subject:message-id; bh=xt53pEr1ggy03OrfBWGIIyKPwsWGunsZ/7AAWO8gTog=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k51zx0E9AdHPE1a+2JqyfTdbwv5VjjJ7FwmETQkOt
 DumWzapo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwEQetDD8D/zlm9vw9YHg1Syn
 JosvMpOjtX62ypb/jJHfZ/Y5pvpENSPDMge+5wEaAmKn/s+5t1uEb36Iper1f5N+Z39KvG1aWLa
 IBQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ab947620f724874f325fb9fb59bef50b7c16fb51..3ccbc724eb808db09b77088a858ecc7f06b21155 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,35 +2814,42 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
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
+        error_setg(errp, "Not a migration stream, "
+                   "magic: %x != %x", v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp, "SaveVM v2 format is obsolete and don't "
+                   "work anymore, file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION_COMPAT);
+
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream "
+                   "version, file version %x != %x", v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing,"
+                       "%x != %x", v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 NULL);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -3119,7 +3126,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, NULL);
     if (ret) {
         return ret;
     }

-- 
2.50.0



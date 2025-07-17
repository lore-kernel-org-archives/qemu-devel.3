Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35251C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCj2-0000GE-Co; Wed, 16 Jul 2025 20:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgK-0004Lj-AQ
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgH-00057J-E1
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgO7zWmS2mad1LAC+VDbczyzpEeF7OhFfACO/B0QFSc=;
 b=KBvCX4IGxTEISuduEBsuJDeWIPPiGl5VTZeFaYAoz2wkuOQMFarze/1gmlLgItyt46XM01
 cbus0oyaVEp0S5Ge4wVH9+G/y4+C7KI7NwVTqV/oyRFSq3i/AdU9WyMXKDPf/Uzm7vEGWO
 6+xjwZwP/bpBjqoFGChAsQ44NJrKOgE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-q9L7BB6oO2qtORIlaOzlAg-1; Wed, 16 Jul 2025 20:40:57 -0400
X-MC-Unique: q9L7BB6oO2qtORIlaOzlAg-1
X-Mimecast-MFC-AGG-ID: q9L7BB6oO2qtORIlaOzlAg_1752712856
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-311ae2b6647so437222a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712856; x=1753317656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgO7zWmS2mad1LAC+VDbczyzpEeF7OhFfACO/B0QFSc=;
 b=rShuQZeCSI1CNfnvpkYNxJqeM75nCAOKfHXWONIfG2AcfnUXq4IAtIkS9PQnFWfLP8
 UfBCQV8a8hGX2zVBV/XWeMNtK1PZQLi5Gd85Rk8ctasipMeCuhMzUwhvwEj7AKdFQlCc
 f7lv9nEuaqi9pZeygDM0XQWMOhd3BBSMEoJPKo64IoLQsueMdA5Y/Y0In+Lb9dC6vi8O
 gd9PT7rmvRPbygykIC3qcCGmXno8sna+IFfJmANyf2FLcxg97a349Y2BNGBXS1teWutT
 AxueaTLszy2c7/MWn/kCMXOW/S07PCMNK5XWUOD8KjboEPs7TIJ6XqBDUL5WePlHX/Z9
 XfWA==
X-Gm-Message-State: AOJu0YwCTKJ6Ws8Prt9jgpLpkUbQ0+50bc/7YldRHx34ztw7XiK9raCW
 TLxbY8CgTHsZmMC+6VCGeuyNpiPndWElqjMQVSIdSl3rfU92iNUSnmZLslBkNI7abQYU2ZcaL5P
 3Lo6zF0av8q6wmE7L2mIWgiiIbOw5oPUPJ+B0W/nleJQ0keQw2QYZ6j+Izy67SmalMyU=
X-Gm-Gg: ASbGnctVt+2hy370DGI7mo6oUhFQcQk+MQsc7wveQBacKkFeuYKPuHtF6chLKZyPumr
 I04orHcGYLoKp0NZDmq+oPIkykXMTSW7ovv/Xc9X5O9XItNlGOZKEWNan0q82Uwvmh9Wir8uacw
 exrCi0nS9OVCVeWcbrjTf3VuXOro2oHQ9007CtY5NI6ddS8PUaE5HzdmGHUyUbCZRObLKMC9rey
 lqDypfZOYEp/Kgn/cLfdrluGbbocq1l70QlG/o5nVzxQ0zFIdJAMJLpkVv3o4Q+CR5UKJAeOKkw
 9FyGdEPWJ2MNmg5M+fR8X4r4n29jGe2RDxonKt/E2bOiVmmXvApv
X-Received: by 2002:a17:90b:5587:b0:311:c596:5c6f with SMTP id
 98e67ed59e1d1-31c9e7596edmr8092740a91.17.1752712856063; 
 Wed, 16 Jul 2025 17:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJWfaEIBJrrkBktHUzi6no3I5kzqqHpnPcoukb2qlZDTEQb3saP52NyLBAV/bDZgA9XH49eQ==
X-Received: by 2002:a17:90b:5587:b0:311:c596:5c6f with SMTP id
 98e67ed59e1d1-31c9e7596edmr8092693a91.17.1752712855546; 
 Wed, 16 Jul 2025 17:40:55 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:40:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:36 +0530
Subject: [PATCH v5 13/23] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-13-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236; i=armenon@redhat.com;
 h=from:subject:message-id; bh=elWoGicsrQ1vrc7DXwImjeDd+wLVc/6RTeaJIRDgHBY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFmyJ/ySuR6QZsz4wzDwU3iJQkcLW1xs1IXvYqRmla0
 fJv9b86SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATCTmFcNfuUn/Bb2iTx27npb5
 +sJL3yW/eDZ3PLT4ISikx78ivve7JsP/vAcHtiwK71/qO4Xnit80a5YD1wzVlglPFd5iGS4R+qy
 CCQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
It is ensured that loadvm_postcopy_ram_handle_discard() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 509b71dc2666617ee3e7b707f46187ee5287d201..6f181c381dc6ecd996a1f8dbc25cceead7ebe014 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1996,7 +1996,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
  * There can be 0..many of these messages, each encoding multiple pages.
  */
 static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
-                                              uint16_t len)
+                                              uint16_t len, Error **errp)
 {
     int tmp;
     char ramid[256];
@@ -2009,6 +2009,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         /* 1st discard */
         tmp = postcopy_ram_prepare_discard(mis);
         if (tmp) {
+            error_setg(errp, "Failed to prepare for RAM discard: %d", tmp);
             return tmp;
         }
         break;
@@ -2018,8 +2019,8 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         break;
 
     default:
-        error_report("CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
-                     ps);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD in wrong "
+                   "postcopy state (%d)", ps);
         return -1;
     }
     /* We're expecting a
@@ -2028,29 +2029,30 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
      *    then at least 1 16 byte chunk
     */
     if (len < (1 + 1 + 1 + 1 + 2 * 8)) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
         return -1;
     }
 
     tmp = qemu_get_byte(mis->from_src_file);
     if (tmp != postcopy_ram_discard_version) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid version (%d)", tmp);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid version (%d)", tmp);
         return -1;
     }
 
     if (!qemu_get_counted_string(mis->from_src_file, ramid)) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID");
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD Failed to read "
+                   "RAMBlock ID");
         return -1;
     }
     tmp = qemu_get_byte(mis->from_src_file);
     if (tmp != 0) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
         return -1;
     }
 
     len -= 3 + strlen(ramid);
     if (len % 16) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
         return -1;
     }
     trace_loadvm_postcopy_ram_handle_discard_header(ramid, len);
@@ -2062,6 +2064,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         len -= 16;
         int ret = ram_discard_range(ramid, start_addr, block_length);
         if (ret) {
+            error_setg(errp, "Failed to discard RAM range %s: %d", ramid, ret);
             return ret;
         }
     }
@@ -2627,12 +2630,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        ret = loadvm_postcopy_ram_handle_discard(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_ram_handle_discard(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_RESUME:
         ret = loadvm_postcopy_handle_resume(mis);

-- 
2.50.0



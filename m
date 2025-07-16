Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1BAC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzdi-00005K-If; Wed, 16 Jul 2025 06:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdX-0008G5-6N
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdR-0000eW-Hm
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvyYpq9paFbRSHEAzpHUGCfYqPBFUVZxfNQh6SNxafE=;
 b=embbyUg1g3ix//KUDnIdysgomvAUCs+3yMtzgdXEk7iP5xjoA7dZcyk5k2wMLLBgqVTsVb
 LPwD0sSwoFrE8jvwoFN4DvlwU0hqNnufBD2ETWBlU9fUm0DEPnU1WgxF+oI+zP3iGyvUT0
 kf4yMXDiUy/Wi6kDo7Q50sXNtvNXL3s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-3Wl5XDVKNImFdFbKNH6Eng-1; Wed, 16 Jul 2025 06:45:10 -0400
X-MC-Unique: 3Wl5XDVKNImFdFbKNH6Eng-1
X-Mimecast-MFC-AGG-ID: 3Wl5XDVKNImFdFbKNH6Eng_1752662709
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2382607509fso38561665ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662709; x=1753267509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvyYpq9paFbRSHEAzpHUGCfYqPBFUVZxfNQh6SNxafE=;
 b=md0UfbIGKcz9tC+QobmT8blbzScim97Kij51x5BUYKR/7a+Vcvm5S+1ZYyT6+IXquL
 /5TfPvKmEbMwAzSMpnohw9eZhPl7UYrIZFjGil3zWOA8oHrPFGUa78N2uALWay4MFyBQ
 TpPTbNuLtYLD1dWHoxQTE7YgIUlFQSl5mBJ8CUxihqUPSHi55qINnfaPz4ZXTzYsO9hS
 lvH/OcpoSrcARSuUCrV1SqVg2yndRbYKWjNNUEZr8PhebYJnfa7NYM3KJEqKTGKYS0OL
 rUN2E5mJdHaMDu1cVbH7aq4fglkk5rE6econbppM82yDpgThtbwGjL7vCySQb+nE+IA9
 Tgnw==
X-Gm-Message-State: AOJu0YyGLhyaDSO7rOS2SdfyLgCDPt4gDMdBkVsB9OgbjQfYEtUiiDKN
 IkQs4VW4sb/1ivBIolD6QVH+vvPXpuBvYdHSBRqOGqCuzxCsV9+vBTGyFlQMZHEIGGWnCRh5YAH
 wwNdJi1+wfO4sG6AAoM4WSqh2/aaYUD/AK7zREeXHs2kGZDD2eqtdzhsJ
X-Gm-Gg: ASbGncu1hspjl4jowW8ebsG4CkseIlRNU1DW/l/dLNPUJ9PV7LwkIbTkvSstCZMokUP
 hviAe8bFAGyWPFXD0gbDMXzNznEpd21pvtyFrXtT9speyI0wskZGknA6K0m+XIvNIzUwttfm4a0
 8L4MdcNnapx8gDJnB2eMDxCT4qQhXdKOUrqZzflNVQ5ZlqJ4WeYX+RuH0wkx7UHq3VVHc4t6Xsi
 tayFeT5V6JTeL4oMHd8/PVxe1aigZxAFQUw96bzySuQw3VUbjvDTE+W4KFABPa5gNuevT2HFrsi
 WdZ3wbMGltVM15raeq1NE/LCbKi89pbuAXHoubvtuRpvwHZQtQ==
X-Received: by 2002:a17:903:908:b0:234:d7b2:2aa9 with SMTP id
 d9443c01a7336-23e24f4a94amr36179295ad.29.1752662709372; 
 Wed, 16 Jul 2025 03:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyFVElchnE356aMDgibEtIvcJiOjdFoh9Oc7178iDjoLPKG7Ct+A0mLHeDeJIJcP03Z8Skfg==
X-Received: by 2002:a17:903:908:b0:234:d7b2:2aa9 with SMTP id
 d9443c01a7336-23e24f4a94amr36178895ad.29.1752662708911; 
 Wed, 16 Jul 2025 03:45:08 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:08 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:03 +0530
Subject: [PATCH v4 13/23] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-13-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236; i=armenon@redhat.com;
 h=from:subject:message-id; bh=Ra+8kdatdmKEnRnAk6rCW3gE9dPy8Sy2kq1igPeI1z4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k/225MSMkyWf23Lmzz16POjOatMznzhkon5PMXyYP
 MOy+YVsRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIlc283IcFZ35qkbscdfqd9c
 Jm7i+ZL5zpUt/28+fnNq+URdlymfdOYyMnwOmc7dmC/G6L9eZRdz2ZSFIUff+Ww3CuDjmGB5r2C
 fEwMA
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
index d1e596045fe9b90f1037e14f84c92cc649cf8008..9843b359c2968098bef3c7c3ac336a5cfffb9917 100644
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
@@ -2629,12 +2632,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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



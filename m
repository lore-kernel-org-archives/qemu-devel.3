Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2576C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHQj-0000Lv-Me; Fri, 25 Jul 2025 08:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQQ-000895-K3
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQO-0000Ty-8i
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1L2xitBzHugvS2d1TalLr5EffVYW9N0qTIFQEVsgtw=;
 b=LZg61whCkmDE6bPYandNDtDAbpNds4OrFKgFAFIL3P6EqFpxRHqO06SaXnX2oNWrTEwwDE
 nV+huX3hU5z79hnjqM2B9yuxnqAZ7Oul6d5cPMkzkIs95bKaQST3iUTpvpTOVEu9tzy7LV
 VmfsnXq4p2co94FLJTE1pklrwxIWOsc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-sERwjNULNMeW-fC2ZXGaZw-1; Fri, 25 Jul 2025 08:21:16 -0400
X-MC-Unique: sERwjNULNMeW-fC2ZXGaZw-1
X-Mimecast-MFC-AGG-ID: sERwjNULNMeW-fC2ZXGaZw_1753446075
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31366819969so1919269a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446075; x=1754050875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1L2xitBzHugvS2d1TalLr5EffVYW9N0qTIFQEVsgtw=;
 b=Pn6wWGHFpsvlLLY6O3O3SOLw4PKQ97lnwac6pr82lCHCxxe+gLucvP00qRrbIz3t0k
 pXmOZ9BArATjprv4+CMeCY6Rp1suz/befBTFJYQ00e+EH25K2UlRVT4xw+PyZ7i8PhKm
 5//fULVUI0PQJpmjKelYxyWjusdRzKzPPvtJVQ4dBFKq5VHWDG3iIao8vyEVvJt21TBY
 zmK5byW8JJeaMfbSzi0dIZMuYXeAj+aUcAMO+sPectq21m065TghQbWsPBek1FBRzVpe
 UM/xV5CIZc+Q9HR10bX1DWWzq7he4fkPcDVSm01qSuVF4tT3p//ZUa+Ucd/3cAMghCxS
 Kg7Q==
X-Gm-Message-State: AOJu0YzA1sgp5+ChmIEt598WeT49iBvSnWT+JYa7M7eftTeGTdCWoxbC
 3jixzNZ8LTTi8+s9iAx0lIlk/nN6oYs7KzfgjavHT7b/AFfsdBUtCPXZYFRjnYDYp3yZmg7hTkX
 H14ZfpYqNKxx3Ua6jipsklpOJvtdb2Rll+NECChE2hwZ8bNi898L89KWo
X-Gm-Gg: ASbGncv1U8JeZm9Yu7P70EFPMzYBNYOXThTRD/esKar4Vi80Dl3HoqUgf4gmub+5+pQ
 DTq10FZcbe7o4r+EbdqlCuDFhThUvhPqvFtzklt+XauTl0AI6YsSr/kKXN9jt3uxFdpdCwo9P7m
 WtqGQj+d8zA6Mq6GLjqMXkWQJfTgIlksK6p5XY39HxwrxxcqYQVaoHBI8ZfBitB6eaPvJH4E2lv
 7zSPhbKBbP+Gvhck1luNhWFyjXZ3XxsSMaKMDyafiMSOfb8WJ+71hhpAOjZYdj69ATPpqRfmEBF
 tndxRfyUr2tBtWK1vCgTPdBPXYJKfcJzqCjedeks6PmusQP+QRIKig==
X-Received: by 2002:a17:90b:58cb:b0:31e:3bbc:e9e6 with SMTP id
 98e67ed59e1d1-31e77af21f8mr2634882a91.19.1753446074986; 
 Fri, 25 Jul 2025 05:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4j1CnWqLudV4HCNXfdvb1sITQOkjExdF9CPFycW6joMyLjv2onSiT4WMLqaBO1/5PYsDn3w==
X-Received: by 2002:a17:90b:58cb:b0:31e:3bbc:e9e6 with SMTP id
 98e67ed59e1d1-31e77af21f8mr2634840a91.19.1753446074547; 
 Fri, 25 Jul 2025 05:21:14 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:21:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:54 +0530
Subject: [PATCH v7 15/24] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-15-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220; i=armenon@redhat.com;
 h=from:subject:message-id; bh=C+vdubXRnrbkI7Qsy3gZjlVALa25hRwp5cPyH/OtSlg=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmU5q4NMZ7x372Fjvf5r+11MzTZ1btKDmwG6FpD0Fp
 7yE97/oKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBF3Dob/FY/lp7jeEHsZv/F9
 FUvLw1tuqhErDN9m73z/J+y0hsn3HYwMj0Pme69ZK/To0cGys9I9lj9ENRl/PP18+lLt9xPuH/6
 9ZAAA
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
It is ensured that loadvm_postcopy_ram_handle_discard() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3a1d218901472ff2d3de8a9a26b80fa8453c27de..7ecaea90d245627c19722a234b78bc1383368bfd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2004,7 +2004,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
  * There can be 0..many of these messages, each encoding multiple pages.
  */
 static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
-                                              uint16_t len)
+                                              uint16_t len, Error **errp)
 {
     int tmp;
     char ramid[256];
@@ -2017,6 +2017,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         /* 1st discard */
         tmp = postcopy_ram_prepare_discard(mis);
         if (tmp) {
+            error_setg(errp, "Failed to prepare for RAM discard: %d", tmp);
             return tmp;
         }
         break;
@@ -2026,8 +2027,9 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         break;
 
     default:
-        error_report("CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
-                     ps);
+        error_setg(errp,
+                   "CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
+                   ps);
         return -1;
     }
     /* We're expecting a
@@ -2036,29 +2038,30 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
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
+        error_setg(errp,
+                   "CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID");
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
@@ -2070,6 +2073,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         len -= 16;
         int ret = ram_discard_range(ramid, start_addr, block_length);
         if (ret) {
+            error_setg(errp, "Failed to discard RAM range %s: %d", ramid, ret);
             return ret;
         }
     }
@@ -2629,11 +2633,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        ret = loadvm_postcopy_ram_handle_discard(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_ram_handle_discard(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_RESUME:
         loadvm_postcopy_handle_resume(mis);

-- 
2.50.0



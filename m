Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE90C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udon7-0000Bi-Iy; Mon, 21 Jul 2025 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoka-0002Hy-I1
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udok3-00014L-KC
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rWgZekE9P/3ziG+RiG2hpPU1qFiLS5Bi7zv2TJ7d3w=;
 b=Xoyv2yVtFw8yvkMlYEbGvC5cMk2t3/nHLDD+d3JYyRlLi/ZSK2AwyjLxRSNDvvOOxMnLay
 UqFR6WZJ88DVcJXPRJ5IcnQ/UQe9wcF5gp/e7wR4xco52ZbNuvEvaVA/EqBWEpriHbUIKZ
 6ah099q92rK7vlr/NnEjyW2kfGQ8CaA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Fv9WlApZOH2LfjOs7aXduA-1; Mon, 21 Jul 2025 07:31:32 -0400
X-MC-Unique: Fv9WlApZOH2LfjOs7aXduA-1
X-Mimecast-MFC-AGG-ID: Fv9WlApZOH2LfjOs7aXduA_1753097491
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2355651d204so36915735ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097491; x=1753702291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rWgZekE9P/3ziG+RiG2hpPU1qFiLS5Bi7zv2TJ7d3w=;
 b=hRnYqJOMaOQOC8XG30LO19F3qm9HpysduwVIslMKnG5UlPHzasw4Ka1c+2s82+AaC5
 CJQxrC2gOuAkbOh+vD5IdqBRauQ90FC0UNzPDZTG/hg4HhZmtaQ/YGNdKJoZunCWuVNO
 EHbE+uUDY6Ty7dHjiiB+ji9rn94jVabn/dp+XXb0NDv81inEqad04UDJSRFUJ5CAJyr0
 JFbusENpXSlvg/4wsFGMGyMreJbuRODCOST+NbHQOkdCz1uyd0SMrEGxACvZg9HUAf/d
 mKqEU6k1jTcOhb1/z/DXtylNVtZqpJOjVNRMj1y5D/cofO//RPKmHaO9qA8nIpVa/D2N
 6nTw==
X-Gm-Message-State: AOJu0Ywe/uqhF118aqwDlUIyiUpdMrIgDzfgGIZbsExG+4k/A8bcGriZ
 +0n7v+qlDoEtALijpgoqBvy73Y14qvG09jkNV44XPcw3XZj7Cih8Jzt6yNtMePybqqEdoc8b5Iz
 /hyWkLg+3RZaUhI37w6p+IV4PE9xfdgA6k15gCkJgn4kuaF9I+Qc1EtBLB0adyj3IFW4=
X-Gm-Gg: ASbGnctkrT35XKiyx0/fgKT+s/G/3/jvUJIIFurdXzqGU53E4b0+EaUfc8L/KJRq9SU
 S6z+MgyBrqJy8Tv95Omi8UVLLizTTT4H4P+oA2UoskAUFbEbpM4cIh5WvMEZsBF0AkZWsZCb/Dz
 H8mGVQgMI/luRirNXhbLljpCICPRPdO+j0Ps6TVrtVg/hWHIT3CZAbloWWr4ujU7ehrWIXu0nZY
 0Zv1XEk5teOjCFEf/FAZBJ65J/LafusHoOF7+TpguzFZBv8xXbcTVWfwWM7xI4yGbWEuGaYX3cO
 qhK4kB0bQDlaHJqVmCGRcGD/n/bs7PCLsiWnSUEyuJPn3a3pGd7h
X-Received: by 2002:a17:903:b8d:b0:234:986c:66bf with SMTP id
 d9443c01a7336-23e24ec7396mr259909755ad.11.1753097491166; 
 Mon, 21 Jul 2025 04:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+QoW6Q54ReVxycAZ5mn6A4ZByG8DrYGxfw5a4vjJUCtWPBl+dCeQWdCchSCbshKrzv95y3w==
X-Received: by 2002:a17:903:b8d:b0:234:986c:66bf with SMTP id
 d9443c01a7336-23e24ec7396mr259909355ad.11.1753097490737; 
 Mon, 21 Jul 2025 04:31:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:31:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:19 +0530
Subject: [PATCH v6 14/24] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-14-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
 h=from:subject:message-id; bh=GTdxve+ao/QNKIL21QQ7e2lxPTjzHDIxSagvmpEMyv0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqS1zOLTVU+eO8Ghmi29wCbv1ZKgwAY3z3kvTYXSJ
 29lst/aUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCL3oxj+ZyqF3U2e5brsaezs
 CRbzlhfd7GXdLtI5STryrcuMVoupvxj+6XZMPXs8sVfi5NnLPxw0Zi+rVXe6t8kwSlCs/+LGZpf
 /HAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
index 856ec984e1ab09f5fddfd30eeb59e73a4c981697..e472f79d5d5c4fb4410a28cbf43c298be028f4b4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2002,7 +2002,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
  * There can be 0..many of these messages, each encoding multiple pages.
  */
 static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
-                                              uint16_t len)
+                                              uint16_t len, Error **errp)
 {
     int tmp;
     char ramid[256];
@@ -2015,6 +2015,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         /* 1st discard */
         tmp = postcopy_ram_prepare_discard(mis);
         if (tmp) {
+            error_setg(errp, "Failed to prepare for RAM discard: %d", tmp);
             return tmp;
         }
         break;
@@ -2024,8 +2025,8 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         break;
 
     default:
-        error_report("CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
-                     ps);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD in wrong "
+                   "postcopy state (%d)", ps);
         return -1;
     }
     /* We're expecting a
@@ -2034,29 +2035,30 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
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
@@ -2068,6 +2070,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
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



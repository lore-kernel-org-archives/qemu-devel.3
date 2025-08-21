Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F77CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0zK-0002Ld-Mf; Thu, 21 Aug 2025 04:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0y3-0007Oi-4Z
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0xp-0001ao-GC
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJlG6eaVi9W+kzO8rXIp8Lrphbsej0OBLy0MdGC0lwk=;
 b=f0hi0gkex1j5gvm9/au5gQIgsJWEMWBzLXJBMktaXc6kfPDIcD0KIja8PaZ7DZNvfaM2jT
 Ndr/xli/GTjr3kXwFj8gLAgRl6tPZN2CtCqsDO/bIcZL46QbbSuPjbAXiMiST89Au6Arxl
 OwJE4fCKlStHfizD2uCwvypaMjQk0N4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-vvSRXQbkNEqFD0D2R9Pouw-1; Thu, 21 Aug 2025 04:47:57 -0400
X-MC-Unique: vvSRXQbkNEqFD0D2R9Pouw-1
X-Mimecast-MFC-AGG-ID: vvSRXQbkNEqFD0D2R9Pouw_1755766076
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-244581c62faso10768785ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766076; x=1756370876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJlG6eaVi9W+kzO8rXIp8Lrphbsej0OBLy0MdGC0lwk=;
 b=GT6SBRqZaxsQbtV6nd0FUePaZpaWZACC6KOdR8zF3hTFbo//JcMThXrdnohP0ahrMt
 EQcAeInrjK97A9DSAii+lKETQ/8JugILsLp10MbhLRZESruIRU+T7gCeftA/INjtASEE
 7GUXWPUgTDS5q+fSDA6FCFSu33V0F4IbnyoeaKLs3WGf8wodZwhcReq54Vsz0IyBDOrm
 4Kgx+cLWtTiNmb/wJ5DotyKJYUWVFRXWce6UILbkTQADx/gWVjiGKwsteVDMtdCToA9W
 wuciNfm16c9nN4pxSJacU3OfKyGok1sPmE3PG3HION3hzUs0pfyGCqDaCo6KHJ9Sj/bf
 RbVA==
X-Gm-Message-State: AOJu0YyqSt+BHGyx1vadPZPVQISQzXJMCQ3HLvLfKuFmmdr2vhjZCAuF
 zV1zMSxgrhC4LjDGdpwWAroTnsA4l9q2QxmYPI6+YfIoNIa8x3YZizfFvrrku6kj7HCAuflSHyS
 7TfKi3u/TfEebdlq3yExG165kSckDTpryquqg/qnhWwv+3EKEHlyVmpuR
X-Gm-Gg: ASbGncueHHgVwHJhSmnEDK4sornKNPuAkszR9D8gHkUvDB6sxt+TPtSohIDMYpGaq3a
 RG/um4akBnexU6BUbb8K0rKfio0gyVfvOU1DILOufk3gc1EuJH1QWKF/04NPkuTtrizDnWUEWs0
 TntfOTgVIR4pHCAwBRzOpxbPG2nPKMGSBdGEOO2OFaH0k3LtiwvTsXvOMZiAchl7PLv1Jo2Es9D
 rqJZvHDL8pqGaKQgYWFFfSj0HsHG0t4yaCB2CIYo3HYFy92Vcb2LHjTQS8BMCc/zYS4yMtUkS7N
 HhiHydibDgI/GyIUrEa0p8KEUVZ65dJH34PqFwIexALzeN0K+9jQ
X-Received: by 2002:a17:902:f705:b0:246:163b:3bc6 with SMTP id
 d9443c01a7336-246163b3fcdmr6882015ad.49.1755766076536; 
 Thu, 21 Aug 2025 01:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWAsEqhujn6Bk0t/fZD02dptuBuAc11oIHOx21SZ6Lc2e943pi5zoWyzVfCCacGKB+jK+GyQ==
X-Received: by 2002:a17:902:f705:b0:246:163b:3bc6 with SMTP id
 d9443c01a7336-246163b3fcdmr6881685ad.49.1755766076133; 
 Thu, 21 Aug 2025 01:47:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:47:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:13 +0530
Subject: [PATCH v12 19/27] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-19-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; i=armenon@redhat.com;
 h=from:subject:message-id; bh=BqA2d6fUfxPl55xxwpfeFmITzSTIT5PTLX/2vaSWHXY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayOymx03KftR+aNSeU/+uWKzop2vF+3xOZJHdxsJXvX
 K9n73+ro5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwERK+Bn+WZgW2qrOTnpWc+to
 oz1PyUTTg31qK9484dN6ur6QheEtKyNDT9C+dy0zA3YZZXFcvDbr39Ir67umWP/9Fzlt/Q8uo1u
 rWQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c38646d5c3d75c64712561984f6b1df92ad55feb..359264cb639605a3f63a2b022c57afd511c47a05 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2476,32 +2476,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
  * len (1 byte) + ramblock_name (<255 bytes)
  */
 static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
-                                     uint16_t len)
+                                     uint16_t len, Error **errp)
 {
     QEMUFile *file = mis->from_src_file;
     RAMBlock *rb;
     char block_name[256];
     size_t cnt;
+    int ret;
 
     cnt = qemu_get_counted_string(file, block_name);
     if (!cnt) {
-        error_report("%s: failed to read block name", __func__);
+        error_setg(errp, "failed to read block name");
         return -EINVAL;
     }
 
     /* Validate before using the data */
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    ret = qemu_file_get_error(file);
+    if (ret < 0) {
+        error_setg(errp, "loadvm failed: stream error: %d", ret);
+        return ret;
     }
 
     if (len != cnt + 1) {
-        error_report("%s: invalid payload length (%d)", __func__, len);
+        error_setg(errp, "invalid payload length (%d)", len);
         return -EINVAL;
     }
 
     rb = qemu_ram_block_by_name(block_name);
     if (!rb) {
-        error_report("%s: block '%s' not found", __func__, block_name);
+        error_setg(errp, "block '%s' not found", block_name);
         return -EINVAL;
     }
 
@@ -2640,11 +2643,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return 0;
 
     case MIG_CMD_RECV_BITMAP:
-        ret = loadvm_handle_recv_bitmap(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
         ret = loadvm_process_enable_colo(mis);

-- 
2.50.1



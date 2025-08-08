Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF340C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMq-0004QM-7w; Fri, 08 Aug 2025 03:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMF-0001Kh-3t
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHM9-0007WA-43
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eu+DxJs1BSeNduampGqfs17K2lrTwCheyveRHInPudo=;
 b=BkWm/qLCY6Dvr+e2E4pxphv+PFiRGTjh2ctAgdiaUvsTH2ntVOl1BaLP1OXjaya8kQRMOQ
 GMEBVBt3DDGeTc4xTh+gLEZSHLxfb1ayKbPI0t8XTEm+UdQ57O+LdvOS7Nmnp56sWGIWgD
 vVAuYNIMtKXeTSt+qRsXMOhWSKudWWE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-dkRJw5ZMMZ2yKXRY0VBm2Q-1; Fri, 08 Aug 2025 03:17:31 -0400
X-MC-Unique: dkRJw5ZMMZ2yKXRY0VBm2Q-1
X-Mimecast-MFC-AGG-ID: dkRJw5ZMMZ2yKXRY0VBm2Q_1754637450
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23ff6e5c131so15400065ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637450; x=1755242250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eu+DxJs1BSeNduampGqfs17K2lrTwCheyveRHInPudo=;
 b=s9jZ+RE3n5ppeplzvatzZycWwG+zXPSgNImi8x7KJ4y99TEE9cmGuD2h7BcJW36emz
 ZrImRBQYxkQSOie21ZH/wp28mTb4p+F0rzD9GB+p8241WtCmtva3pdD7mGf7g3GyE5jk
 7AN0YYCg3tJ/y8Mu2HLVR30fj/I9UDxfb119LnYN1Q6ADpEp5rbpJu49rG5HYTwRH9v1
 VDO66x325MF8B6sRMIZWI0JWHZVmIJdjlNp9sHgxhAV4RDyX50n/gBBt8xyBzipZkxfT
 rj+0d/NrqpUV5vBQsyZUkaejDDZV6OuvZsP+JEXJ6hmdzTc+rsTzzImAPhDmgRXYY3D4
 qEpg==
X-Gm-Message-State: AOJu0YzRUIllSfm7vrCoanUkEMTYyjDCahZEXAPHJ8q/Ts3+ksOtXs8Y
 6FKmZMyWSe3B3KvH4q7Teo7KqhNpvp9LCk7L8gFcvATCpoNfaMtrX3b/a+POf9QJ4GMsgFtv9sn
 +nrZMkgVSaOkOLHxdmraEbfmewELxSNB4EBxU2ZIX40vK2E5udgde6s6o
X-Gm-Gg: ASbGncuev75mqtyeqEWKRp1MvellNfeYPnwhRr7HfcoPQEKXPfdzrQQiEd2X1uVIB9h
 KIZVPmT29UMTc/Ad65ZQqcpBql56NtyGOX/njtvlO4UfoGEiEJW1CsRDg/ANKIrzoV50L8BmQIj
 A7PTnuDTv8Ch7ltsJS8+vvsDLlgzsC6NJXfKqTLe+KYBXeOqLxXUd27eIVKx824k4BjD0nDHY2a
 7lo9iPhoyYbomhoJrBp8V+cQQWCC1yo8akSvhXSF0lX6a2cWdQ1YaFUwAXn1Y0Qr1QgRvSugCie
 VRpLjAFe0Us3Vv+GjZOCUjtd9bUbllt+zG/2fLaKX+f6GCk7ZWorww==
X-Received: by 2002:a17:903:1a90:b0:240:4d19:8797 with SMTP id
 d9443c01a7336-242c20074b1mr34129865ad.22.1754637450392; 
 Fri, 08 Aug 2025 00:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGemC7iQ7O0BrvbpGtL+M+66HUW48UKdhlQ+z2m4fnJaJjeKXbJtFEcXXamDc9KeqN9hMMfrw==
X-Received: by 2002:a17:903:1a90:b0:240:4d19:8797 with SMTP id
 d9443c01a7336-242c20074b1mr34129305ad.22.1754637450032; 
 Fri, 08 Aug 2025 00:17:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:17:29 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:45 +0530
Subject: [PATCH v10 19/27] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-19-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614; i=armenon@redhat.com;
 h=from:subject:message-id; bh=74qopHTRjtnmkfH588NqXXJeVZqDEAzpYH9EdbLScjc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxdeSN1lEZ+yo4n/nG5M6T7h6rsBOPq/pwX0fmo3tD
 blUPm3uKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBG56ww/Gact2F0zOetr4QyP
 VxOFH7uGCIkLVSgL6D03XrXi4nr3A4wMfyp8VjreUNGpvHFFp2vRXaksEz9nxhDzWx7PPfd79wU
 wAAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 9098c4bd3394d7b9ed77e20afbb26fd9c9be6550..a7aede1b3df9164e322e68f3889df7c4166876f5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2480,32 +2480,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
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
+        error_setg(errp, "failed to read block name: %s", block_name);
         return -EINVAL;
     }
 
     /* Validate before using the data */
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    ret = qemu_file_get_error(file);
+    if (ret < 0) {
+        error_setg(errp, "migration stream has error: %d", ret);
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
 
@@ -2642,11 +2645,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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



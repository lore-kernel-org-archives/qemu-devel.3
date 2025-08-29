Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD4FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNfG-00069F-82; Sat, 30 Aug 2025 11:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5N8-0006KQ-Nv
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5N6-0005BL-Pg
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756498012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZ5qpT0ubEUqCdewMRwilIH2qM78jxpQ70y0QUZWscE=;
 b=W4x9QCsn5XwTYT+bGmfgkTAD6TiHRhYA2u9aiHjV6a/p9PVZ7LGjtS45zjwt/OTS8QGe+0
 pVKekiK23O/FOmHuTgKodHEWQjgxTCBCu4aWHJ8fQRBJReBYjmAaA53HDPVLoSZax/Jtvp
 5d6bikVunADPtHEV6r85p04uo7/bI3c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-NbF0hpLrN4Sj8d1mxoCNDQ-1; Fri, 29 Aug 2025 16:06:50 -0400
X-MC-Unique: NbF0hpLrN4Sj8d1mxoCNDQ-1
X-Mimecast-MFC-AGG-ID: NbF0hpLrN4Sj8d1mxoCNDQ_1756498010
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b471737e673so3580097a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756498010; x=1757102810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZ5qpT0ubEUqCdewMRwilIH2qM78jxpQ70y0QUZWscE=;
 b=TNZNR5FFxRPPAJm6/1ZRWJqAYVOCkVXhqvDAPCzRL2JjQeaACVPP/0m5F8jPL+cUlj
 kh6DgAoSvxybhjdth3RAc8a83YomHBfNXaqsQXpA3r/McrlzNZnNQfP9gN8baugMtI31
 OR+3tC1ToWAvyJ3VzTPVOV7DtxWKWOf4C3EjQ0CbRMbGoorjpen4psoJj36qaavczSLK
 +ssHrRYdQSxPsjn6xq9IOvXwoMX7+5zI1gKhsPyXFCK5PULZyb5WrOG+pW6KdlRrUm9S
 EyWFcCNxbaHke5a1LwEJVLjMg8FHjaEoE0qxiutRDfU/6XaknjJxbBJicAMLlH/xAqWb
 YlQQ==
X-Gm-Message-State: AOJu0YyeJrWmjv8VS9Llg8H0ZFD6vxrSSvu1JCKKP5IAJn13ogw1YvtO
 oDWeJYDu8XLbbUbj3ac50DH/jgXzpgbFvALLx6zdsDTGZjZ2mhJocC8iAOW8kR2nkTW/e9Pfio5
 ev/k0YbO9wloihWBb1ZYYxKqAVRZPt6tIOKcOQHox7XDCaSceZun3HbTZ
X-Gm-Gg: ASbGncsQO7p3Xpx+k+Wmq6gDFTu8MnKmwY7hyCn6pLwq4fW37pPbGzge2CxHTeQNz8o
 d3qrsWacQq509J9KDXFHo/CFTKz8I7zXkzia642PcABRlFCAWzk68a1agAyMOkSOr+ZHBhgTZqN
 nIHP3aEJcYhepZZTdq3V1kZAM3Aj7nL3Hi1rA/Mgsk+/0JDKmx/OikojMYDP4ss/JrmZuroJOfS
 iHnKrDIfMHRivTKlGV9sF8hFkk+CI54JXUr3VVSLfNuUId45VMEpH3w120Hg+jD1Pes+O/OTgCF
 9QcKTw0f6EkMQOS0LcS+Zf7Cy6XKT2sjKpnAY9900HWw9yWe1nTTow==
X-Received: by 2002:a05:6a20:bf29:b0:243:9c68:a031 with SMTP id
 adf61e73a8af0-2439c68a272mr14163550637.57.1756498009691; 
 Fri, 29 Aug 2025 13:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzxD8C1zYL0rbc7Yjbu3zMPRGvor1m5j0HTq3pLV9i0V3YW5hxnfaaHWO++/fBbgZAw5zcaQ==
X-Received: by 2002:a05:6a20:bf29:b0:243:9c68:a031 with SMTP id
 adf61e73a8af0-2439c68a272mr14163511637.57.1756498009263; 
 Fri, 29 Aug 2025 13:06:49 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:06:49 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:59 +0530
Subject: [PATCH v13 19/27] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-19-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645; i=armenon@redhat.com;
 h=from:subject:message-id; bh=sWsUM8lShaPXtDP2lf9BQ1xaS+5SyRjp1vtDn8Aau4A=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdt+Pv6RD2HUU3ftefjr82CNNWTIz+IWJ/Me/TReDS
 s7cFTvZUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCKukowMV35y8u88fI9Nx9jg
 +suWmSeP7HBtu+jzXeepyoZDFzX73jL8zzitMeFzda0/U3L17Lq9dZunTvvD9SmAR6L5u0Xc7E2
 7+QE=
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 01cc186b9e0324053e804c4fedebee02d8df4052..13a809564aebf6346228f46fd60f611ba6104bea 100644
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
2.51.0



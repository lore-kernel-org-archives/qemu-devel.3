Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091AEC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udolQ-0004Z2-72; Mon, 21 Jul 2025 07:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojO-00019e-2C
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojM-0000yw-0v
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULs+Y7dE9uSVpJOMyTHhkJaujP5KmYFZNLz5yJwY4k4=;
 b=C2rtPUI4sa0vydi0pDZwTaBIWHUC21jLPYi2FA4oYGj/Zo5ecoue6CzmKDqUniRL37BHmy
 xU1bCJkwvElsEYDVMwhGuM6CKvR4s6YxdxWxmIubGtIGvweZPr+iTzfpLeyodOSo1E2Ukm
 CPRUm5gHgsjYK3a943PClvGCXka9Z6E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-8OI3XtHDOXusXc6a1PG_AA-1; Mon, 21 Jul 2025 07:30:49 -0400
X-MC-Unique: 8OI3XtHDOXusXc6a1PG_AA-1
X-Mimecast-MFC-AGG-ID: 8OI3XtHDOXusXc6a1PG_AA_1753097449
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235f6b829cfso32916705ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097449; x=1753702249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULs+Y7dE9uSVpJOMyTHhkJaujP5KmYFZNLz5yJwY4k4=;
 b=Dk9EUK9JEvJoVf8gmbthdyzIF1P78BwGh7iBzCW5kZQXMe9c/fc4zGFXKVFfE1JP5u
 tIKstjZhRt5WXrAvLVQUiQXNvXWdeOD4TEHK5bx3oyYgs2xpiq2XkwTVyzNUCPvUnTFV
 ZE1we+RIsP3qj9KEr1/Z51dzCiqYnDK5XQoZiaeBYT18V0JDaxGZcyxd6ad7av8xRsDy
 PbIsc2Ih1F6Z8YrUxzYXtmKwT1tC35+rsbZ2DCRy8QLLOfuNDp5n/Dx/CeKwvVoMsQf5
 UlyAawXkUblAyEbJ7qLclM88K2gRrzfhXsLiw+A3FW2diwDsAb1WGYljzNuxp56/EzSt
 d6kQ==
X-Gm-Message-State: AOJu0Yy/O1b1J+Xm5E3WrVq+iSlHuMc8hCt8OEy+q6SMf8Tj9ZZI9Cas
 zwnSajUvmpm2TV7VAApe9ytfb43TYM4l8Vm1IO0VDfi3+jqfvw6LvsDgICaAG0wHp/Bz70+J1AR
 F4Vp3kJ9dBsl0vEdZqpFk38SrpzxhFQnwn/E44QcdI01d0ROuBXM70Dxh
X-Gm-Gg: ASbGnctIQK2EwFTQIRkUg6EFz0c/vj7E3HuA7i0J/M/9Ny3pqFQS6icMjsL39mDZSEg
 AIQM74O/Td5JmVkOZQU56r3TcxlnfeUYYSZB3IW7+EJn/9IuP57x+CurUIa/UFWt5sWPZC7ju6E
 xqSmbllEFxCqAVbulYh1VQe1GkJ3BP5h/u02pIcGNaOTTH2l1HJ5IUpr1hBpfRNJEsWm0AITKk/
 DRoXwkJd/zzFetTEsi9Ag3vSNYPBXUTnDOf0JnZXxzn58mSh+tGhhd5wVo4FXVtpRopZHjvGQww
 Z15aoL+nTumnXUTK+wi1zfBRPlJQuGjQUX+Oj9EhKEzID5muIUAM
X-Received: by 2002:a17:903:2342:b0:237:c8de:f289 with SMTP id
 d9443c01a7336-23e2575f9c4mr256223715ad.36.1753097448803; 
 Mon, 21 Jul 2025 04:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnUGAkFGsp2EOCjWjjIvprvVlNXuEYnLBTcIiUbCZMWBnBVTk/lPJy1ZCdodOJoiYYA4vHWQ==
X-Received: by 2002:a17:903:2342:b0:237:c8de:f289 with SMTP id
 d9443c01a7336-23e2575f9c4mr256223275ad.36.1753097448333; 
 Mon, 21 Jul 2025 04:30:48 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:30:47 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:14 +0530
Subject: [PATCH v6 09/24] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-9-fef740e15e17@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; i=armenon@redhat.com;
 h=from:subject:message-id; bh=2Pni/uIRYnrVWEWOd4Mq+ZjAN8oGU8Y1RFtsZkJix3k=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adykTvesvLP0V8ulbOujrf4WFupLJZQpPc2h37eaWe/
 MuaZCzZUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCLiPxgZtv7s/Tc58PmcxxsU
 zwSwBShYuwpubn28qnhXyw71xe9zUxkZPjv+rWdtVXI9W6bf7FfXlJXhZt4v7xkxKTh735zG3lA
 uAA==
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
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d8feb9e1599d019636cd400ee7ebe594df27bd1d..3ade91d2f757f94bc6c0242a38c6e750a9252f96 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2405,7 +2405,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2415,7 +2415,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2426,8 +2426,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
                           length);
     if (ret != length) {
         object_unref(OBJECT(bioc));
-        error_report("CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
-                     ret, length);
+        error_setg(errp, "CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
+                   ret, length);
         return (ret < 0) ? ret : -EAGAIN;
     }
     bioc->usage += length;
@@ -2457,6 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2612,12 +2615,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.50.0



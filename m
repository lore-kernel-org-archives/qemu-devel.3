Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A318CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNcJ-0007Mw-N9; Sat, 30 Aug 2025 11:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5KI-00057P-HS
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5KD-0004e5-HC
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfMeHNkHXITJfT3smIrT5NGNTBXHlf78w/tF67kcbe4=;
 b=RTjV1jP4bsvVmjbBOsawct+qIzT0N2Qdd/6uWafvrtTVxmfiI25FY02bc4d/L6+HU77Ljc
 Bqx4gfBGDV2rvD+/2EIDRZXt8jANP1HphYpSAExaU0VBAlRbD8bdPUpQGbaPfIGgnC5Pku
 QKug7ZTeiVSt4IaaGmm9RrLCkCnmxBc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-9-lBHKbWPy6pJvqzwnYtMQ-1; Fri, 29 Aug 2025 16:03:50 -0400
X-MC-Unique: 9-lBHKbWPy6pJvqzwnYtMQ-1
X-Mimecast-MFC-AGG-ID: 9-lBHKbWPy6pJvqzwnYtMQ_1756497830
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4cf03610fdso1736725a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497830; x=1757102630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfMeHNkHXITJfT3smIrT5NGNTBXHlf78w/tF67kcbe4=;
 b=iX9+YaDJCsbeq8G67+CpNHVM+xxOgEEQnK8VjFnPvpDfsnfdclkX2VfAbnsNSAQE+C
 logVYwotlUf4PiOUWUJUIPmV5zME+M6p7Cc81LW6JNtaRh0Tuld30CRaWNJpW1NkoP30
 kP2oGTonZvM+uup+kRJNiA/mGRt4MtwYHRxt8ARepa3ezaG6oex20CmINC8kebI1ZOx5
 +evQbPaKTK5TFtMefoPP7cLEd0HqGNDojP6CITxJunr3xOWfGzkJxTAmJi7slgmkEyUi
 0UP3wSV2ui+Jkw6TQ9CiqxCFBTj9pJ92JruPJrp4z0jqr70exmMBuhE4+6f2Ac5H4ccy
 4H/Q==
X-Gm-Message-State: AOJu0YyaKHKBhJanIb/ieKuqr8lYtTKgib+GMCq5FpRl3tN+GUq7DA39
 WqWINmTDM/cC5Fm7y/Sft5gjar/DC7hcqUrzbXyWmC+Sx8bQjNK/VP2JWiVpXZC5SWuyLUf1Zb+
 hR23Y+Z7DzpRDTk4i73V+Aqw4AtVcywkEAzFO4ven4Ih1ITMKXCQx88Rm
X-Gm-Gg: ASbGncuNy1rXES3A2jlb2J9FXTgg0UlTuuZJU7lEt6HV18n9OBWCR8UqVjYeybY/GGl
 aUZOTe6kVy6ixF0JhF5AEydp9ZBdh2+JHR0cZMWmxI8Q/Z+FHOBUJFasSxO9AuHgItZPg5wouci
 cuiwN1RBuXqak4aOiOg/T4i7cu8b2NrWcYs/s6K5STvqS2UtFlm2xhc02uqgWYhpmPikAhVvKTN
 D/skvSToEDdeZnFrf9iiareAWl9+WMImfbdyW5cuUSCP73yzbVi0sPDBHbAh718zBbGGXP00aYr
 61r3U7ZHOyWwYN9VBbkk6EHquWVY7YXoewXjTcVTL7cS7xMrdre5wQ==
X-Received: by 2002:a17:902:e842:b0:248:a054:e1cc with SMTP id
 d9443c01a7336-248a054e4f0mr164100335ad.18.1756497829566; 
 Fri, 29 Aug 2025 13:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/u/2jQwqQMHkTeHCVnTsAKIIwK2w9E+j8uY7H6sTVbbry8MjhrOJE4nCLVjcKS+L+NI4+wA==
X-Received: by 2002:a17:902:e842:b0:248:a054:e1cc with SMTP id
 d9443c01a7336-248a054e4f0mr164099935ad.18.1756497829169; 
 Fri, 29 Aug 2025 13:03:49 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:03:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:46 +0530
Subject: [PATCH v13 06/27] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-6-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=armenon@redhat.com;
 h=from:subject:message-id; bh=EGno3AsWvaj5rUCkbXjfvd8MsWC3MPQGycacGbWUg0A=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdp9nvTF3VV8Hyj24yL31mmrxv8kB0xbxTbfL/jh14
 d4Cr7bHHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACay/hMjw+GlG05Mbp+lzaBY
 +/4U7zxzHS4W7rRwUVGnfl3xLNMZ4Qz/M1rVWdd5PpH4eFDlrNorDjYfq7e5LZmuij+FE0VnPK3
 gBAA=
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
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0e9935aea3e1a214cfa0ddd0e30fa5cf925373e3..de5671ffd1cd06e728227a3056c3f895d3a6e6f3 100644
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
@@ -2620,11 +2623,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.51.0



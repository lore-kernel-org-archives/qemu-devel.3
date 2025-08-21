Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B661CA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0v4-00027P-Mx; Thu, 21 Aug 2025 04:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0um-0001rx-CS
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0ue-0000lt-9j
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7iTfHVGJDaEcSWrya/nyT1s5hPEETT0CP1J6s30gGQ=;
 b=GgjtDak71JNqhqUe63PSqgBdE8jLn28vwXPUibJv8S7Q2Mz/5UNweegXeL3lI1N0F+hMve
 kc7RlxMEgbiCAsm69cPLNt+8VRHhERGPwyW2jTX/evZtMh63mj6RYCMsjuJMyHc5oZRLD+
 jPJ5buF2nP0B9TSlvrzcksLMrC04NpA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-KIjWW035OGy1kXrFSAmz6A-1; Thu, 21 Aug 2025 04:44:44 -0400
X-MC-Unique: KIjWW035OGy1kXrFSAmz6A-1
X-Mimecast-MFC-AGG-ID: KIjWW035OGy1kXrFSAmz6A_1755765883
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458264c5aso9046555ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765883; x=1756370683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7iTfHVGJDaEcSWrya/nyT1s5hPEETT0CP1J6s30gGQ=;
 b=qajRhorU/IYzF+IsWIxcJTA7PvpzITaDY0vYyGB3oNWjZafBnPfd9HVeizANheoxfe
 AfkixkoJKNPnF64neDVDN7wIIhUnC3qJ78eZaUI6FJOvUu9VhlhJi4ovhURCe6mfrwi2
 uMjcW0Yj4s49wenfd1hR9LM0obJmH0sSGCnQCsqvD/imiWykH4hsD7gf3dr0THz09a9H
 f1KVHhwoRQcv+qqVihHxKQyivk1ItJ9TN5l5Vq7kWCnjOd370pdhAwj+c+ATB1xtoDGp
 xjG+SoCy/mX02DyIAMwr8UoVDgWSgQr2wS0v7fhLOm4KJuJKTzDZuOTZ4pXxhtfKbMGT
 AdPQ==
X-Gm-Message-State: AOJu0YyVdNaVVZry1M7NTok2UErvKyrUVXWhcGVBvkV8fZTAaWFNyBVe
 Nlshz5pQWOegRyA6VRPOuywtSXHwCvvzkBzbrtGDL3daQEGuUdqjoYrOtbctzYf+CeUAzU1EfrS
 PpqdYmn+wEq8erwPk45qI3fTnVyOPhGf3xgUX+uVwtKseju2HPZwFKr39
X-Gm-Gg: ASbGnctu9UAkvG2xNI41IVK8TkDvhqZvUhYUFGuGuEl0f2DW6DRGsKjhhLD11sekFam
 oQic2AG4XXnuflTB6wPtQr+ogtWB8suLILjf1h8/DIQqYK6SxzgaRFAS3UfQ1OezTpg5Tpevv5x
 GfoQF5dsgxSgVRZilzTyU6y/pfb5ZS1ERQjS2i2/CUrtBVF74jBfrwVJ3n1oqv/dDA2GQILdSaQ
 +5zkx+BCmUWsjqaWDfX1/VM/0ADa0hEwBTtTu4xPg6VRyudoY6t4lvfXn5BIip0WYCXPBtVNs1s
 MB9zJLLdLoo6Dz7AKfmH7LcI+zWYOnqx+MQ94rcDL3noyXKEverv
X-Received: by 2002:a17:903:1a24:b0:242:9bcb:7b92 with SMTP id
 d9443c01a7336-245ff87a5ebmr26638555ad.54.1755765883009; 
 Thu, 21 Aug 2025 01:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFStQTlaaoicYkqGJbefEsZxZ9nIteP85mlkQ0IGut6EHjveiAum6G4huOe2z4wcQA3hjHWVw==
X-Received: by 2002:a17:903:1a24:b0:242:9bcb:7b92 with SMTP id
 d9443c01a7336-245ff87a5ebmr26638105ad.54.1755765882528; 
 Thu, 21 Aug 2025 01:44:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:44:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:13:55 +0530
Subject: [PATCH v12 01/27] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-1-72b803e707dc@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=armenon@redhat.com;
 h=from:subject:message-id; bh=zWzM78aLbi7nFxbtpZpOjHo1cDhL45adV1Aq58qBguI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO0lugQ52t6Y0pchazP9ryp4b6beg1Y7ryIxnstt6E
 zQm72bqKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJGdgYwM5+5XiEoUuqzN2ZLE
 Ebhn6q6nV/Y9WCrWwO14a5t0yZOrbxkZri2bprNWl+OWzj47oXaTMIfe8jcny66uv73mY2WUylJ
 ONgA=
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
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
It is ensured that vmstate_subsection_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using warn_report_err().
This is removed in the subsequent patches in this series,
when we are actually able to propagate the error to the calling
function using errp.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..3d9f284700368e2fd573d5d77b7f7ab88008cc91 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque);
+                                   void *opaque, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -136,6 +136,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 {
     const VMStateField *field = vmsd->fields;
     int ret = 0;
+    Error *local_err = NULL;
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
@@ -225,9 +226,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque);
+    ret = vmstate_subsection_load(f, vmsd, opaque, &local_err);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
+        warn_report_err(local_err);
         return ret;
     }
     if (vmsd->post_load) {
@@ -566,7 +568,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 }
 
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque)
+                                   void *opaque, Error **errp)
 {
     trace_vmstate_subsection_load(vmsd->name);
 
@@ -598,6 +600,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
+                       idstr, vmsd->name);
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +612,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
+            error_setg(errp,
+                       "Loading VM subsection '%s' in '%s' failed: %d",
+                       idstr, vmsd->name, ret);
             return ret;
         }
     }

-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D95C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udojG-0000iM-DE; Mon, 21 Jul 2025 07:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoij-00089T-0n
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoig-0000pw-C0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erPSngrV+xtbEZfOSah76RZLYMZWqq7amM76/7QMxPc=;
 b=MwdxL2fygvKsh2PenZU8x6CXDVq1quVnlG36+VCHiBFaTlr8Z4CEKuVj85vSV25E0CP8DC
 WvtZp1NwDUyKSWJ013vG1jkJ+r0AqtOhWGYE1RrVsY8dw9sX1bCPCtCg7WehXT1JeDIsw7
 fg98XpLDJVUZedhH8QvRzOFJBqUOlkk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-4aqNTfwQPbuOHQK3zQ5w1A-1; Mon, 21 Jul 2025 07:30:08 -0400
X-MC-Unique: 4aqNTfwQPbuOHQK3zQ5w1A-1
X-Mimecast-MFC-AGG-ID: 4aqNTfwQPbuOHQK3zQ5w1A_1753097407
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2349fe994a9so34084065ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097407; x=1753702207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erPSngrV+xtbEZfOSah76RZLYMZWqq7amM76/7QMxPc=;
 b=glbWZHS48F+9AEo0DcOKWn2/eMEMUQEDspaY4B1GSO7lCSvJC8wnEUBfCc+DjTqET6
 Ig8Oc/KtMAyrOYB8mdtXnzlJ80blrdjbZC1o6hqYBAdEBv0ho/Lv7InEbwz1fbjMEyX4
 8eNGLSjl+i4Sc9Fe0oU+RQQaxPEnCZgkKUHma7EYlUsYCwswnDCEV57V8F5YVZKeE985
 NW6K1khFCHhDdj2q4eGzcfRI77wWg7/KBpAFxPBudzMMLPJD3tLcnPLsLUSOG0jxM1DI
 DQU3Lmg6huO2lKdp3sX4X/ukqwKhydjDn4Yd1v9QF7DCWQQY2bu9eJnaJLQzY64FcLe3
 SIvg==
X-Gm-Message-State: AOJu0YzrfwCNhRqCMtTyCRYvaWUEPaVbx7/RWMRWYbb+9zcBWC8gpEAF
 Ejfaw6H9yPI3qg8CQfT1lUgCZ7EE+WR5FN6UM1vp8+omaO+xc1SCQYI6MS49BPm+uhTR7dGAGAp
 gq6hAWMwXnWVNeQqF1MvJg6KumRZM60AN0gU8odmFkwG/wUcdhuzbdsdVWqJDOrk3D7Q=
X-Gm-Gg: ASbGncu35OXLFVByLt5x7QWXQsadj/0ORd3ILxdINine8G7L/hsFYHSqwgs4SwRWuC8
 I6AUlsvlhsL+Pfj9rrA3f3SH+c1Apv0SWReRPxie5zoEMFWzQRhUmp4SLDmNzwmpsVbFeq9Q1mG
 DXZLmpVrtzCxeA0JjeGCh312JVE4nzq7nZPQj8Mek4j3drbiC70/3M6OJA7szFFQZE34LsocQbK
 4uHN7KOsDrdpePiYlqS2RW6NyHNy5YgaLPGfvAWTQQwtvrCtzUhuWs/TEzAavM2ZFt8gmVcIYLa
 LRd00tnreDrZKHwAr1Sv5scu22+OPCJbu0PXbd84ixiQN7A8tzMx
X-Received: by 2002:a17:903:2f8e:b0:236:9d66:ff24 with SMTP id
 d9443c01a7336-23e25686c7bmr283731225ad.8.1753097406682; 
 Mon, 21 Jul 2025 04:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELRnmwjQwofZJ4CILwDpzoT5g//UOuvLo0NpF8BlyOfbgtBbBg0qVuDuJhPm3lWOt6k2PhVA==
X-Received: by 2002:a17:903:2f8e:b0:236:9d66:ff24 with SMTP id
 d9443c01a7336-23e25686c7bmr283730525ad.8.1753097406196; 
 Mon, 21 Jul 2025 04:30:06 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:30:05 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:09 +0530
Subject: [PATCH v6 04/24] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-4-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320; i=armenon@redhat.com;
 h=from:subject:message-id; bh=27HRfn83Fmg1nqxsGO+BhMcsqEtkZnO4tA3f19HmYOA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adykSNJ2tm/Qu3y2tVTgzu3hHbmBTZfLOsLq24ucbw3
 4qZy6U6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATETflZFh7h+f96saFz17/fyo
 7ldnloc6wf2zEr97uPqJVyhXbxbNZGR4eJNt8amVGX7Kn0s2XVweflHa/OI0OYu/xUFphxwOMgt
 yAwA=
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
It is ensured that vmstate_load() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 162fb05933fae5993eeef107811f97cb08726ac3..5fe896545a5407393b1bc5126ee977f11b1fc626 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
 {
+    int ret;
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
-        return se->ops->load_state(f, se->opaque, se->load_version_id);
+        ret = se->ops->load_state(f, se->opaque, se->load_version_id);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load version_id: '%d' of VM, "
+                       "ret: '%d'", se->load_version_id, ret);
+        }
+        return ret;
     }
     return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              NULL);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2741,7 +2747,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
@@ -2794,7 +2800,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);

-- 
2.50.0



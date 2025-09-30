Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F24CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RqU-0003Nt-4G; Tue, 30 Sep 2025 00:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rq5-00038X-L8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rpo-0002IW-Sg
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759205962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jM2VhyG2FV3PKKXcchKf9vwQ8iUBDFHItrh+fmk6FLA=;
 b=gpl71OP29iRgMPsW517YgAVKclCWDD2NRXGUf6EMZ7lYnphWIEx4hxhv12arM7VvE7Ipda
 Djvg9NViFRfVHHUVGfYOHrwDmxeXUQ2eLwsphPHjxC0WiziciVQC9g0TJcT4QrDCy8S2Fn
 Nz/NfmXDc6Bch0h/gqhpop64+ufLqgU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-9fqqKOJIP8qDtaIYnXyS4w-1; Tue, 30 Sep 2025 00:19:16 -0400
X-MC-Unique: 9fqqKOJIP8qDtaIYnXyS4w-1
X-Mimecast-MFC-AGG-ID: 9fqqKOJIP8qDtaIYnXyS4w_1759205956
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b56ae0c8226so3773543a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205956; x=1759810756;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jM2VhyG2FV3PKKXcchKf9vwQ8iUBDFHItrh+fmk6FLA=;
 b=SRzAIb8AcT63GAmhCS4QPM7VayaEXfwwZGcqehGMiOTDVVkl1UBnV4O+wk9xGwq6wM
 ZUk1XS5/C3zLthok+bgc7wz5CotGPY3cczcN8SO28U97d34/Dr/dBC90vEsKrNr9I3aP
 15tI4SI62tkEV1sueRH259iz1CX5kd/YxL2gBICIHuBwWBArVANzeDItFcuGLWhnOf73
 RF1n+zMXXl0IVjPpzzkos1EKs3yLyqKTPIYdEYG+YXWMCGq9M3B4WvHU+w7VJr7d+Rzt
 kn8KjBm2zZv+pqLTshzZlccmoTvsL6FQoU/qZ1OfNiiwMGPCrSm7j9RWoSkNKWuhCatd
 nSDg==
X-Gm-Message-State: AOJu0Yw7G0+ysQ9dSIsbL6RxpvwcNF32UXu0YzVLSr2+HMcrz+UbhyO5
 kOyXhjK/VqCKl1xfxNUcTa4pmfBC4z5CUQT3PXU7harz/v+8z7o9RtloGTqfYm8RsedwwWK2ERE
 C4IwdhHWQDiXKw/u7w+5/GAVBr6t3Ds9rsYZoebE1n/UyEx+g0TFrzO8D
X-Gm-Gg: ASbGncvOGFlKEUoSwqFAKG/J96Ien+dD/T2/rjI2GlLp3q6Qyq0kZAHFcdGzw4cbbmk
 eKiV10cTst0nf2yK56gCIUlH5EaIxmcGioDlNtWXXxxxoW74OATet7zKDjSG/hJcA4zF1jbs1dm
 XvDQyu3oiV0GLoxJi3pGYC2V6d1cvB+lvIrW5A47eK3IqFV409SfkioIThKF5fiCe1zkCnMXGos
 ZQLJY8vjeWey98n3cUfDX/PpEfnEnx0TswcpELQmquV/JAu+B1+B9Wkda4QMhocZ2vdpNL6FOzZ
 v65RO//kQ1FSmCtpAam+qwyj6P+b3R6CnkRKWKVEA/lYNZtli/i0wdCyDA==
X-Received: by 2002:a05:6a20:a109:b0:2ba:103:aa3b with SMTP id
 adf61e73a8af0-2e7d37f2d69mr22136960637.53.1759205955712; 
 Mon, 29 Sep 2025 21:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGltTIw+AbTjlRZ8dEuTQ0/x47A+yqez3Oe0h5ZH47nJdXK0rPsaSn8gJsr7hrkecyxjx7yVg==
X-Received: by 2002:a05:6a20:a109:b0:2ba:103:aa3b with SMTP id
 adf61e73a8af0-2e7d37f2d69mr22136914637.53.1759205955284; 
 Mon, 29 Sep 2025 21:19:15 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:19:15 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:13 +0530
Subject: [PATCH v15 04/26] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-4-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=armenon@redhat.com;
 h=from:subject:message-id; bh=4kjr8/txz7/2hWzdbDOiBhOpx1AokrJKgZYjx74DLDA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKIHCbUmJ3DIfv/yZeHiLVlF6jnDJXI9jflte/K79f
 Ud8Jcf2jlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABO5lsjI0COo/u2TyI5f/w8s
 fqt6P1+t83RC81K9F7tPm5UxmbX83sXIsPj2QQaW/FnxVVYbg+0NDz4z4Xoys+L1TY2YY+H9LR1
 TuAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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
It is ensured that vmstate_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series
when we are actually able to propagate the error to the calling
function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8ac3d338148fcfabe652082ba6f3f805d22fcb28..fffea57cd962800abb6d9abfcbeb908fcb2c9d95 100644
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
+            error_setg(errp, "Failed to load vmstate version_id: %d, ret: %d",
+                       se->load_version_id, ret);
+        }
+        return ret;
     }
     return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              &error_fatal);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2692,6 +2698,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     SaveStateEntry *se;
     char idstr[256];
     int ret;
+    Error *local_err = NULL;
 
     /* Read section start */
     section_id = qemu_get_be32(f);
@@ -2741,10 +2748,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &local_err);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
+        error_report_err(local_err);
         return ret;
     }
 
@@ -2769,6 +2777,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
+    Error *local_err = NULL;
 
     section_id = qemu_get_be32(f);
 
@@ -2794,10 +2803,9 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &local_err);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
+        error_report_err(local_err);
         return ret;
     }
 

-- 
2.51.0



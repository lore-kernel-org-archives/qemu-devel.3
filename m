Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C2AC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzdp-0000PP-Dw; Wed, 16 Jul 2025 06:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzbr-0005Vb-Ji
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzbp-0000Ag-Gr
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXyUbQoBNcXsENFuDMuS7Qrxn0mugpdK4PrcpSGb/kQ=;
 b=gg4Cf932c7rxonzVq4xMZqAKfff9phjU9ZtcP/K1vyWSoFaKk7JjVp8uh4Nel+2wiaPeMN
 I5fGzlhRUFhNkuWn8m8j5baL4V4NWX2VIT/EhO8RAv8Al41jJsgk9aFom3B+Gw3nW1NR1s
 1Nn7mWybacXAgIH1gDdKxM7KNa9lMtw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-kOQeiuJKOYyWPEoe0Z14wg-1; Wed, 16 Jul 2025 06:43:30 -0400
X-MC-Unique: kOQeiuJKOYyWPEoe0Z14wg-1
X-Mimecast-MFC-AGG-ID: kOQeiuJKOYyWPEoe0Z14wg_1752662610
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-237e6963f70so99671495ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662609; x=1753267409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXyUbQoBNcXsENFuDMuS7Qrxn0mugpdK4PrcpSGb/kQ=;
 b=rkuiee6wkgGVeLJa8/isXKasmHCpUapmYHQY7JPf+gFh4lAoC3c/bQC8rJq/yud8EO
 9cbSRgr4CBUf84Y3qoX5nqFUdiMijxwLgYzmx0Jskc+y5+vC8odRLzjetajehZh39coF
 uie/iKNJnYXc+Q8EAfNfeTPphOX6QJrL0uX9p8MTBa5NUhY7IMr6Rh1X5paWYCQ7shII
 Gdv7mVuK32EN+sSSI/Z5b4R1f8NqJkJ/I+vcDAj2c0B2z08aBYdHHf0QERZcLtoXZKJz
 Ozac8THlKYzgWuhzWI7sH6fr4CmHUL96Qa73SiOq3PPcIhxb9zGsQrJ+QhWxTAlIW4Dv
 YlvQ==
X-Gm-Message-State: AOJu0YyKfCsBnFVs/4HlW0Fux4atzedAi4hpxKEr8PybDL1EKmI5MQys
 Tnbqp+3iktBSV0ZWIhuTC49cWZBCGeYnvQPyPPlkITr0M9nx+Qdp8+JXXaeBg/kTLJr1To53BVX
 usiOWaDqahsmANTitCzQ/4b3Yn0WXXvFTsYyfq71uWXIKAXN26K5eOz+A
X-Gm-Gg: ASbGncsdkrc6PzxwMHAZiA88mzVsm9JDUwHBRubCaF6/EH2lT7c+gJNk8Z99R0pt0JT
 s2+q0GZflDOsMx8Wxy09xGG6zs/tJFmSnVVTc41CYPwquoZWHgBvCsPkpbBa3ZsGNou1UH8soxh
 zeB+IMusByjW54d19M3IWkS2fp0R/RNJT+dUZXU0Db5tY++pRedMUdvofqZzgr25xV1NHqi6lIs
 LoeDIggFRRlaX8/UvUaWg1tBIsQA6vUBfUkNq/RcfvPL8cqW0kIdyfq9Bw4K9eRo3jPQwAIaLgy
 fWyvRHdze4p2jlf6GoEQkRKnkihNATSwu4+fmISv0zMRhk9+/g==
X-Received: by 2002:a17:903:3c6c:b0:236:8db5:7e50 with SMTP id
 d9443c01a7336-23e24ec0c69mr32511125ad.9.1752662609683; 
 Wed, 16 Jul 2025 03:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Kr/WxxvO9UOB4i4FzRT4JuFOgDcldqrB9xk5tH4hEYmo1oALevjE+glwF5rTgagwctXodA==
X-Received: by 2002:a17:903:3c6c:b0:236:8db5:7e50 with SMTP id
 d9443c01a7336-23e24ec0c69mr32510655ad.9.1752662609314; 
 Wed, 16 Jul 2025 03:43:29 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:43:29 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:51 +0530
Subject: [PATCH v4 01/23] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-1-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=armenon@redhat.com;
 h=from:subject:message-id; bh=PPQSg2D/z7rxR30HP+zMBBa7rifIbjqJASAnbuzYPXw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k12ZhvTrX7adKbdFkoIOVwuqbb2woXL61EscOy/XT
 f93/2RyRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgImURjMyLFZf5phrs/v7/qAk
 k2x5B+mwgze+XWs6vG7F7pqMxjP+YQz/K8+9P3dyj9tGBbfjyf8TNh0+VnGk3ifodPD6FNYNyix
 iLAA=
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
It is ensured that vmstate_subsection_load() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..526668a020562f303d2ddf030b1c8466659b67be 100644
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
@@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque);
+    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
         return ret;
@@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 }
 
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque)
+                                   void *opaque, Error **errp)
 {
     trace_vmstate_subsection_load(vmsd->name);
 
@@ -598,6 +598,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection does not exist");
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +609,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
+            error_setg(errp, "Loading VM subsection failed : %d", ret);
             return ret;
         }
     }

-- 
2.50.0



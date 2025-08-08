Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40E8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHJa-0005rF-Vi; Fri, 08 Aug 2025 03:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHJZ-0005qh-Ah
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHJV-0006wW-Vq
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myWD06jsCLFFdkskRIGu45nxHZFfAn2DedxWxJSi+cs=;
 b=NaMmp9Jyq1F2ZZbXQpvQxXIWTXBanOFWWpld+/bHw4Np2AyKgy+PWQ2+Wj0RiU6STRKHc0
 P8+2Nm+cljyLoHtCmaVXz3mvNIdEwk51uS212hsVkeMuWVIKRNIjDeQx7OfiyiMjauXzH4
 pOxXzhcon2fj3y7Jtu+Cy5+ehsjkPk8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-fLicQrxbP3GP5walT2p5vw-1; Fri, 08 Aug 2025 03:14:50 -0400
X-MC-Unique: fLicQrxbP3GP5walT2p5vw-1
X-Mimecast-MFC-AGG-ID: fLicQrxbP3GP5walT2p5vw_1754637290
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23fed1492f6so30402895ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637289; x=1755242089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myWD06jsCLFFdkskRIGu45nxHZFfAn2DedxWxJSi+cs=;
 b=fwAOVt3WJ5/1ljXUvRfwdKWTzyUCexPrfdS/C1TgZd2ptw2eVox6N3gwhxkr7Z1mIY
 GNFQmIrsRkfcX1EBsvIi/NauZvk9/isaLjFurbyRgNErg1G3U8Xsj8iRtiW292pCh+gy
 0MVTvTg4OElbzPpVfjiKNUIvu6+6Q+pOwBbYVlnPctHVybP7TNs526cXv0uAUSzKH8Ej
 3NOJ6Ey4P2pJtt2ljisLriuXOpichGfUOMFUTJ3hLnvzBaSo3wdaBzJ+0IfmL4qaiSxw
 VeOlx0m+8vp7DrV2j50rTrKROA5T1c33KOwKCgRM7bLkWYvzCelYo4IK18jc2X+AELmi
 WCLw==
X-Gm-Message-State: AOJu0YysYHu82sw7uEQ/Y+JSk+kksIjzOLyCRhPUgL0qNzj2xo1a7y8b
 wlM4P6GbJuI7jA8MNLVjKLMFbBEr7kqJh5mv/lE9Smt+c4BKqWHlmCfOKHT1qkuflWH3r0pi225
 1PWDN5RLNjBnOmDqzKoVAZd2Z3YASEcsIatcInIJ01g90QSpRsipRDo47
X-Gm-Gg: ASbGncv64Jl1uOxKFCOHcm7hFB63tzipRjm7tt3MLmn8a4IN8Ez4oLpAtCKdIlYl4N0
 H80JqSXl22JQJnGspbGtawFwibNbLc6bG0Ub8CR9sTS5oKUaW4owUfgzMqI2IvOOZt4kM3qoSYl
 l5BouWKB37ZUVyvGgRWF5QyfdL06yzKgZpcTMQZQAKXBQWVyBgOLeh3k3krMrwH1kqyYgl95MTf
 u6doJG8ka6WMR1Uh8MQIm1x6TzJoayQFbixFvnHXdFvNtKvPtF5lS2F+FfRw00bEuyz/RAiU6LH
 knhvi4t96MQpL3sJzMfgLfEsMs53zfxKYf7UL7vAzhK2C6vzE2Zh7g==
X-Received: by 2002:a17:902:f70f:b0:234:d292:be95 with SMTP id
 d9443c01a7336-242c22ca48dmr31117135ad.42.1754637289524; 
 Fri, 08 Aug 2025 00:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeJMd3PvBhPzLg2uCRjsODuHg/G4TBg8rkZ/sLSLJtjNMGBAE9O6fvwHpk1lN6N6DvN4AFcA==
X-Received: by 2002:a17:902:f70f:b0:234:d292:be95 with SMTP id
 d9443c01a7336-242c22ca48dmr31116565ad.42.1754637289157; 
 Fri, 08 Aug 2025 00:14:49 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:14:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:27 +0530
Subject: [PATCH v10 01/27] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-1-3e81a1d419b2@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2863; i=armenon@redhat.com;
 h=from:subject:message-id; bh=GsjRQXNLq9FEI3O2ShgB5NgQyEbEgPJj+oic+AMrPlc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVeETUIyq76JqZqqeR3tz01Zad684biq3+G+YpPrr
 5MmGKzrKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBGXz4wMrf93Xqn8J640V0t+
 y1Ff17bpy4+z6YrNTgl2bIrXfLpoJ8M/M9WI3Iny9+b5SQpaums7JNjIJK/58mfRLO0FrGovXnY
 yAgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
It is ensured that vmstate_subsection_load() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..f01bb5fe17aa1c9e16c3964836904a95e5892670 100644
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
+    ret = vmstate_subsection_load(f, vmsd, opaque, &error_warn);
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
 
@@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
+                       idstr, vmsd->name);
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
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



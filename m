Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10534CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGUp-0003aA-1o; Thu, 18 Sep 2025 11:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGUn-0003Yc-IK
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGUk-0002cf-GB
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFESQmOnhzZW2+hXaXl8rxhwnVtiVIyzJTwYSrM4JVM=;
 b=CW7lBAIVuiB75vz825pYz+K0IqMpNSEA8anmSK4tOLBP20B/9ze0pWIjDnaH1Nc2aj5w+q
 TU9oH8s/nCNUiOQxTcVC2t2KHIpY7IDxNQYyrq72DV5UYu3uo7Cbx93j5A39AMs0gS+CKo
 LXKw9sY2zhagDyywYtFO70LgyWJqXqE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-HJTdgG_dNRq16clKTNWcsA-1; Thu, 18 Sep 2025 11:24:22 -0400
X-MC-Unique: HJTdgG_dNRq16clKTNWcsA-1
X-Mimecast-MFC-AGG-ID: HJTdgG_dNRq16clKTNWcsA_1758209061
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-77422201fd8so1228932b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209061; x=1758813861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFESQmOnhzZW2+hXaXl8rxhwnVtiVIyzJTwYSrM4JVM=;
 b=jvDbWHpeHYVxK/+I8wRkYMbHUL52bWUBY8d6MAJPO8rTcPxiEiVhZ++C/g+IqxZgc+
 IGpsKr6W1+qC6jKeDt87YwxU/FeK6xmIqqFv3SFD3HvYXuNPiEzJs+uQjG+GKr49ZifD
 KtIFba4ITxuEQRek1OqARTOB+JaPsPssyvc2yqfqIT1LKw6ydzvwGAvkkljWxhv1Ao71
 ywNfKBafA+RwxKqAkp1Xc8SYfYwopEsZsU7Vq8UaaKE1/AjXLarrG5ugedQAZVKiydv3
 0NkdjS8IsZGXFdsbzs+ywK1gcaqi+zloX9pPG5zVDzec4u4r7upou/9+ELWoFCzL312G
 8Phg==
X-Gm-Message-State: AOJu0YxYwcOOgFOwCATRxNnE7zRswUa9xQZcMRCwozWKxFnnkDRS4EB6
 B9z1Urrzv4zOZ383y3nMJWuBd70uoEr0o9WL6F149aFKTp8S7NBf+lUMs4v2+njZ5Rfnj0wEuCe
 8i9KPjYmTHe1bE9z8BvYNmiNVMu/ZR7pd29c7ir8YDegfhfUJ9EzTh/oQ
X-Gm-Gg: ASbGncsFUq/jDhr4ryHh72E+nbr+8/lsHfvcXVN4bx62obY+7mFA8H8MqGwa7P0sKLR
 Bjhi769JAhby1k9iCYzguy+uDohBxFTNXKh/sC/XnIsEL3mFq14EdOerSqZ8d9Z6nNltCSL+Drd
 cvWoiwOn1UU341IVxz6E/kP3DVhzPk+D3sajTtYczeIdKLgaK0X00wgy2eQxDIVb5HHtGVJyZvN
 kaJfglts5nLBC6Jjbcc1Y0mcJYR3EblCRH/O0PsC3oWwLsjxRDoJINOyuEaOVFRe26F4qD8PuKN
 ebCVEK0XCQzq4sF32cPqM/GmPGh8RoYsusD8OQahHCnm1CEBRh7S0Q==
X-Received: by 2002:a05:6a20:914a:b0:252:2bfe:b65a with SMTP id
 adf61e73a8af0-27a91197b56mr8094346637.7.1758209060940; 
 Thu, 18 Sep 2025 08:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGolnpvDNp6OiuqBqa/oKTvoWxO1Stfdk0DbqSDPcJZmrdDAwmEQLXP1c6dzN2ZUlCbhn9blQ==
X-Received: by 2002:a05:6a20:914a:b0:252:2bfe:b65a with SMTP id
 adf61e73a8af0-27a91197b56mr8094280637.7.1758209060495; 
 Thu, 18 Sep 2025 08:24:20 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:24:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:21 +0530
Subject: [PATCH v14 04/27] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-4-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264; i=armenon@redhat.com;
 h=from:subject:message-id; bh=XNWOL0PRpe00C/2zRFfhJytxVRezN65+i4XThQwPhbg=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e/P1vrw+z4W1bsW5u7L+3OL1KvzrtySJxbtfvfUL
 egcT59KRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgInYcjIy/MiP+vqwwPDnRN3J
 pa8rzp2Os73WxqYr//LXjQ2Ht740u8nwP+vnj1WWnhss90mGMsRGebvVn3y985UJ70Kx5/qRX8s
 YeQE=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
It is ensured that vmstate_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series
when we are actually able to propagate the error to the calling
function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0c445a957fc99f826e6753ed3795bcdd51f1e3f5..40dae406db22dc9ddbff2f5ada92a32626b58e3b 100644
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



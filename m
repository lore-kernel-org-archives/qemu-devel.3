Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E709C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udoiW-0007Uw-9m; Mon, 21 Jul 2025 07:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoiM-00079A-4D
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoiJ-0000c8-JB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1dASEeWrCEZwvHQ4T9aLbTxxgvNH9Q7yhnVZ/B2DMA=;
 b=WLyIFaRGNxH8ZJ5MKcS019ykxWAbWpzFeq8pN3dqMriY9N4eAJBaZAWqrKRz3rpM/HIvoh
 1ocvSk7KDsYm4gOL7zauNIOu13jki74+MfPX4RbTWf2kj7DCGlJ5XEgU8KG7/ZptFJBLKc
 fWRwsN0JlfVrNJ2TEXZ4AmxPsiziZaY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Oaj9DN4FNIqLyEQIk0HWUQ-1; Mon, 21 Jul 2025 07:29:42 -0400
X-MC-Unique: Oaj9DN4FNIqLyEQIk0HWUQ-1
X-Mimecast-MFC-AGG-ID: Oaj9DN4FNIqLyEQIk0HWUQ_1753097380
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-311d670ad35so4001714a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097380; x=1753702180;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1dASEeWrCEZwvHQ4T9aLbTxxgvNH9Q7yhnVZ/B2DMA=;
 b=jrGd29UXGd/g3RL6NkiUexhDRuaoJmW1PqBxLhsJGRtvLC8CV+MGsJY3S2PWUqkjSY
 xrAU25q+EcEVrRa9gMD9/0F03G4KK3twhpPgd+uYKrbEzb11m7W0L6ODaq6phlDIXKEn
 gSqn8noEAZeol/1fH4athbFICzELsVX1P0o/1pZs2LAjwZiybwZiPZg595820OMqtYDm
 K4eV2k2vgr8Ku/zjqhy0vmHzXnrA7f8FHiluZEO0D5n/d0+IRzUtfiRW7M1IT9ed2g3S
 7GACxXbLsl8C9j2YDow1ZRWRmfkVhsqAQdM1OtB1zo0zzczMak7iBgS27npelm4yaWZ7
 sknQ==
X-Gm-Message-State: AOJu0Yzm7yH+0tDGBgUQvPNyTEeMqkO3PiN09bNKxLhMX2otcgpBPVtJ
 tAtnrObLaORqIY8qf6vSuVKpBgpZ0J61jkaMGRKQMGHtGA6da2okYhtnaM/TUYTabg8bRuXM8yc
 AKhTF+gPvjXcaAmSWDk5DhQMw4+A8x9XQZ4u5yIBG/H+ULyBhg9OkzAO+
X-Gm-Gg: ASbGnctplG30G9H3xxh7Kdkn0Cxpon9/D3vwF+i5JTlkY3Fum/M40+o9LQxH3iNO5Bm
 jlBtipo0y5bITR2doXV3ewTreL7HuEYWL2s45fUaK6xpgYrjtoQ3zdDZ53FsIISqm/M4WToWIT9
 ylZb2uCoRqjeRc2qrPuUrddWJZJfdZlLRAo5JCrgW+ol5V7WAZnghjBUhTyEqlqd12pMGF37fZC
 IapzmPiJbWOINrMWrXa4mFCURTlV7yIyKv4kSFhNhVfsZIUK8rrBuIWbtna91kej8BTgo7qgLfu
 KAr3E7BA7a+AXn9BOEApoFQwHX6TQ9k65wAtPSzgZajHdcqua7zx
X-Received: by 2002:a17:903:2f8e:b0:234:9375:e081 with SMTP id
 d9443c01a7336-23e25767f37mr269959595ad.42.1753097380330; 
 Mon, 21 Jul 2025 04:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlkPn/gasKJQe471b5nyW5EjwcauE0hvTzQcpM+/dXrtFYrbNxS+RqT4rC8qtIX78PLrtZXQ==
X-Received: by 2002:a17:903:2f8e:b0:234:9375:e081 with SMTP id
 d9443c01a7336-23e25767f37mr269958995ad.42.1753097379924; 
 Mon, 21 Jul 2025 04:29:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:29:39 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:06 +0530
Subject: [PATCH v6 01/24] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-1-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=armenon@redhat.com;
 h=from:subject:message-id; bh=4WErO7dMVZHGEkDnopfSuR9L68ClWeetF5ffMWP273A=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyoSTiyyubFzX+J7vgrPY9n2FjHxvZi1tOX+/xJxFj
 HNN0+u1HaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACbiHM7wh3+C4Fa7Pxc3SCw/
 GSG1+ILVcu3/0Svapqvo9U9X+XGhehrDP/WOM72fdRtk78klWL11O+z/c+HcnRqnrsyZFeX5bmX
 gBmYA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
 migration/vmstate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..129b19d7603a0ddf8ab6e946e41c1c4d773d1fa8 100644
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
 
@@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection '%s'  in '%s' does not exist",
+                       idstr, vmsd->name);
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +610,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
+            error_setg(errp, "Loading VM subsection '%s' in '%s' failed : %d",
+                       idstr, vmsd->name, ret);
             return ret;
         }
     }

-- 
2.50.0



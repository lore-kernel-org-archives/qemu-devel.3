Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE7EC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMOW-0004ZH-PT; Tue, 05 Aug 2025 14:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOR-0004Qg-2C
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOL-0003w4-5Z
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0vnTfKN9mBALXRRApHAiAVJB0IOhWo5vRzGufEarfA=;
 b=TTlDMDkpXIjyLL7NZRqOJt73jukb3AxhZqbP3sNURFJ1LBVxUiQYky8iAwETgzIKw3S7i7
 +ULBfWWlrP4P/82Xxq67L1MvS+Yfnql9TcgdVGAkH0xYUwsX+MSv2A4H8QdK0AisiBbT0K
 eWp8el7B3rXNKaHyXRX/XV/ZLd8ejdI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-UJi6KkJDNRSpV7VDr77nqg-1; Tue, 05 Aug 2025 14:28:00 -0400
X-MC-Unique: UJi6KkJDNRSpV7VDr77nqg-1
X-Mimecast-MFC-AGG-ID: UJi6KkJDNRSpV7VDr77nqg_1754418480
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-237e6963f70so113499855ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418479; x=1755023279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0vnTfKN9mBALXRRApHAiAVJB0IOhWo5vRzGufEarfA=;
 b=bWWlZ333FG+rVTtNd1t4jhgUdnLrKReK+qqu/IhZ4Y8mvMi0MuqVTHQrmORmBLX5zm
 57weB1NcNd/7NdkBxMHfu2x48nvvdX1v7DAY4vc+oBNdk4LRthg3FmBHKuywql1LhYs2
 X79eahqvWx88fEyprP1bLK1uZxtYFVL+lHwwBBTZLWzIqJUgGNREAQDSosu7may1uUyN
 b5g7BMQywicH9Pd8ZXE0T88tia666EvLjwZ+uvKq2KLS851hwmzmx6tjXOcewb3HyCgw
 fiob8bvi5pOZwwhaQ/SOcAih75kfbaeg7l6zS9IFfCOj0PC1cjqV11CstNhLK4Xffw/o
 pQ/w==
X-Gm-Message-State: AOJu0YyU0qpM7W7crMX+0/IkUw+kK3TH6R4kNsTADtzkc7omLGRbOmr3
 /gnkuHkRSWCMBgDXJHd1mTRUuy6wJsQvVk7vTKSF3f9HKMwpYNnHl8ieL+5WUlS+zXptMlijmUZ
 Rq6z8nH4Z0VCiENTwmksXG2TuAW7HKYt3MLSn7DjlPPvyPA1KwUr4XpIt
X-Gm-Gg: ASbGnctsD3LsKs+NOex08ag/Cv5+Y5oUhPLob1R1hZCtucvxIztL8BrkfN6pK43HcfZ
 m+ZpCcN38du65soVrHBZvTM1CkwSsmS+zzgRVvLMr3uazOLU5hWY9n+kRxXqxXQy+RC7Li4yqIl
 hryk7FHCo01lfEp/xH0jCQXM7kjGj++2OXVBverObuWWcRMXux8mj0X+P5CfPKIi5+2vCg2mfvW
 HXfVSoXGIjloex2gGYVVAP3BIlM7FlX6kJGUB8EpfW6kS5qbd7GEIcW9ppJovqKHL3iMYPhwjay
 0DKNmixia/0t/wiHiNo/Bab2F/HHS326Empu9jl5hh9WsuA35g==
X-Received: by 2002:a17:903:1a67:b0:240:3c51:105e with SMTP id
 d9443c01a7336-2429f4244dfmr1185495ad.20.1754418479553; 
 Tue, 05 Aug 2025 11:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIBw4vzY7D+2+/eTVlZj1upcSX7s58MyZoUa1g6By8dGQlkSGH4M1dmhPwF6szIPAFtuHfSA==
X-Received: by 2002:a17:903:1a67:b0:240:3c51:105e with SMTP id
 d9443c01a7336-2429f4244dfmr1185145ad.20.1754418479143; 
 Tue, 05 Aug 2025 11:27:59 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:27:58 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:08 +0530
Subject: [PATCH v9 01/27] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-1-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=armenon@redhat.com;
 h=from:subject:message-id; bh=/d4LLrpkwsmF//iBVP7+yiCjwa/n/EC+2GmDagzVr08=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX+le768bTiuVxnGf0N77VK5xcnF2oIvCL7vpU8pC+
 XdMTizvKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJEPEQz/jBp5t1ap1ipJth82
 vP8sLMJdiTuJ59w1CxXtRHaOeUp7GBk61vHI62zQrPSzUZ2+dMs/t4+ay2Vcux/oc53IlsxVfMA
 LAA==
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..24451b054c11dfca2d76e24b053d604bb7184e1c 100644
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



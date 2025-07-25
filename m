Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A6DC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHOc-0002OA-RN; Fri, 25 Jul 2025 08:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOS-0001rd-UD
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOM-0008H2-W4
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753445953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YClqxQljy3nk1vTGNWJSGDC+1mX40b0oiiphoWw1wA8=;
 b=HIC5hL69viL5SenogoJKZsPlXtB76YHeZ4HkSWm3aULKBcQWwF47x8pJAPLtQbrqTjs7KZ
 ebS1vuzNVIuYxd1tERg4L0VayPoAZMAS7hl4d3nmcVF2qANgYPZo54p9GsYGhYuXgwHo/w
 k7jxEC3M49HQRSeZbYMtgAAps2oZUVA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-uIhVbllmMI6mq_OqeHo-Gw-1; Fri, 25 Jul 2025 08:19:12 -0400
X-MC-Unique: uIhVbllmMI6mq_OqeHo-Gw-1
X-Mimecast-MFC-AGG-ID: uIhVbllmMI6mq_OqeHo-Gw_1753445952
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-315af0857f2so1928682a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753445951; x=1754050751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YClqxQljy3nk1vTGNWJSGDC+1mX40b0oiiphoWw1wA8=;
 b=phJUkgxpmRj5rYnSx9sOwsJ8e9gCmUaGtgjZQa9NUGRhjCIMvHst7HDrpge2bGNlDl
 gAMQHCq8+nvrw7j0os0TLyZ4hth1KmHxwxlXULkQKjjg6D1UQ6yN0oZoG6c2WkNrGTaP
 5F3e0t2fXjydFVLW0SqgJCcg6LEa1CKbe5Lj+nv76VRZv5sDVXc6XxoWU4nsiiwPPGUo
 KdC8CnNvVeAUEmW/FVhaVUoRnKeHmQZK0lbQq+/T1MMqJ25MD7zovzb08gU1RiFPUMv4
 DJ2/GA9fRnaS2SQ9NRUpvf1NDD5VFfNUaEu8f4ZG7Xv9WgLVnnrvsfTRdnzYiW8/CBzB
 6rnQ==
X-Gm-Message-State: AOJu0YwXh71H4XnU1SKPmQTyy44w8fR0pAAERTwuGhd1pyznkuyAgMJW
 CzgIsaDOMzSPzCTqRTetplBhdTxGDyuR423spwMtYfv8ai9SnM6xRTvXA1J2kinzVB7APZ/iReW
 wv+unn2mHzxAulaf7VM8nj9aZNLS/LmQp676gCvuWTX+GmiNmmt1tQFXx
X-Gm-Gg: ASbGnctyfvoVnvajlFYqeKLG7OHpgcNLVZGbLqGjlTUuOHc/UIJ0ELWzro15zQZgc24
 v9JKXoqIrMRp8K9IAEwF7/kmQnTdXb4Y1bUD4Kx4rp0d0B+LDUB3drbxW9nCJA0RqWIiEu/33bS
 UMzZfGzgMrDeYsBnkH3rLXvd3pOB9bbaP+LcsGo2Xxgzs558SGtEtiFFH9PKCtB+huw7qOvuRNg
 X30OFhFo9hizzmO5EPn4r15oPZ47kztdiQdeA+2ol+GCNRhylXOak7Y9pmZY+CnGDHC3jjl3u4T
 Z6SrN+Bwe+YE+3n8KJCPn6xAa95jMbkdZMVddC9Te1hlbVK8pkxTNw==
X-Received: by 2002:a17:90b:3c05:b0:311:df4b:4b82 with SMTP id
 98e67ed59e1d1-31e7783b435mr2584284a91.4.1753445951477; 
 Fri, 25 Jul 2025 05:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/w2Tx+vCDA95ZOC59U52Wg15dLMZkq+en+dD6jEXzk8kW6UbOcMISBK9gclcAgib0gX/VGQ==
X-Received: by 2002:a17:90b:3c05:b0:311:df4b:4b82 with SMTP id
 98e67ed59e1d1-31e7783b435mr2584231a91.4.1753445950917; 
 Fri, 25 Jul 2025 05:19:10 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:19:10 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:40 +0530
Subject: [PATCH v7 01/24] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-1-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=armenon@redhat.com;
 h=from:subject:message-id; bh=JGAT1glDLxGdY6DFs4uaRV5zAoh2FZziVpuy5acuyg8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmbYyL5eMnYHR4x/MhS9uf9pzKOqcx/IM/UfTlezY7
 c/0Rk7oKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBGlWkaGTYq319yaIXaHx0vm
 sbGMrJTWDbmN+4+w934WViyb9yv8OyNDw6zyswubfqUeuDhdfCqb78r0cxOrtDmXRwW9zukIUWL
 mAgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
 migration/vmstate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f2747906ddf9aca891b 100644
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
+                       "Loading VM subsection '%s' in '%s' failed : %d",
+                       idstr, vmsd->name, ret);
             return ret;
         }
     }

-- 
2.50.0



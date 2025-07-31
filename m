Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962FAC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU7J-0001gB-Uf; Thu, 31 Jul 2025 10:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTEb-0003lm-94
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTEX-00080b-Qa
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ei7O22C21LACZHTLer3cjrixsRRCYdJO9Tz9R6v8x3w=;
 b=bBmfkaS6ma/9uz7v8XFoup+BbJgnu+u6cTmviWQOHmmETRNl1KLAg1Sh7ZDky2pXApPBWN
 5bVPJCetnKWN8qiHc0baeEwky8cal9fEYnpji+XR1y/3xiAg3M/yWIn+WXAmjMYORB29Ww
 VUb6R48U/2IDPpr/hSkGCDDf1xeKO8Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-7nwNz21NP-CRW-GrhVRQBg-1; Thu, 31 Jul 2025 09:22:05 -0400
X-MC-Unique: 7nwNz21NP-CRW-GrhVRQBg-1
X-Mimecast-MFC-AGG-ID: 7nwNz21NP-CRW-GrhVRQBg_1753968124
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31f729bf733so1426744a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968124; x=1754572924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ei7O22C21LACZHTLer3cjrixsRRCYdJO9Tz9R6v8x3w=;
 b=BJtnB+ENnkmkQsfwQNyJ0COh91BcWfZzzzBpcpL7SIyyXXtySxDt304N2OXGH9ez5Q
 OdPyZZDaLnMT7kww4Gd4Fxe5CAcdaY7ZYWuep/9x7e7tIUxXyfsIZz8gBu+s09Uf2F12
 jAQEMMsMEIDTyXANGy+65tyDRBKLjH9uGHORXzks5HzaHJWh1J5zo/msgVKUZHg0ajyD
 xQfwJ77xlUeRcLWqhASQ8DXMa3B8zbROyZZNMJeTX+fnknVFD2PyXSKHKu6j5F/j8f0w
 wsFBP4cUMkMoOymoce8+TNCFHS0wPRkF5rRlrO/2vyPgnzvQD+qTjYLdpwt2LyawO+h5
 Uzfg==
X-Gm-Message-State: AOJu0YzS5AxuUDf4QpOp7ASUJEzG1QMZKhn/HvrxD9BPRZ1g4iZ7amLi
 AdX6D9TelKxDz6jHRhhGJGnovQjxbWU17zUJR/Ue9DGHjAK75F0I04+VtJYjS77hMgoGKig0ymV
 zAGosrLot1ICGL0/8OyBO64AiMLXd3WlSYDBmOdWN2J2IKlyKdejsD6IKe/AWDkGSM0nnMxFzPn
 WF1NY/YPKpy0IlB2d1j4X1LeeJqKt1s6xvMVA8YXxAqw==
X-Gm-Gg: ASbGncv4VPsTUrTuLr8rN03lmMkDVndlsEfAp8w1AAxxFeyqmcxpeawUmudWVLXcdVY
 59erJECStsA7la+xgqHnNrCtgmjMEQlKORLYLblRN0yblPqbr5rPrDHqBUBCDGRSYYIlRXbkeSt
 Wme5CbZ10QzJtjtLQs1k0C7sjiL31NMTwK8S6WVbrwBPeGunPnrFhXR5OZFoEWOMrhQTS0j/wpy
 3OKpZFnCOs261bMxw2cL6QHywlbxzxWHBVG0+1pX1T3YzSaF7EJSK4aCrSShcIJzTOuj64xKZsY
 /XrvbHaMIZU3sVnQipc4YKR0U8Veh8hGCfRROgnnfjy99l1nwT1p
X-Received: by 2002:a17:90b:1e0c:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31f5de42527mr10512066a91.17.1753968123979; 
 Thu, 31 Jul 2025 06:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdnpvsG5sciOioCa3Zl7Yf9PEr1vJZXa4pY4At0Fb/GSRRkpeTsE9rTC+SgmbMpWMpzKx7Mg==
X-Received: by 2002:a17:90b:1e0c:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31f5de42527mr10511969a91.17.1753968123048; 
 Thu, 31 Jul 2025 06:22:03 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:22:02 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:41 +0530
Subject: [PATCH v8 01/27] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-1-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=armenon@redhat.com;
 h=from:subject:message-id; bh=kid0bXOsRop3xBGRskDAknpISUXylOTFB1pNzk2GZhw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37pM72qH9b58o1OepOho12Z3OmPh+ga11+o7Hpdzay
 6bseLawo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwEQuRzP8lXipN/Fpn3yRwQsh
 5r3GHc3Pd0tmrS+Q2aa1h7X0iVbHOUaGi57HWAMc8608ig40nF7NNPnOrIuPfMs3uGa737z0vqq
 DHQA=
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
2.50.0



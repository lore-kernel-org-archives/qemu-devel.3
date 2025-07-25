Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858CFC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHPB-0003yK-NT; Fri, 25 Jul 2025 08:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOs-0003GG-4a
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOn-0008Oh-Pe
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753445980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3Awn+NwWRVG7jYVn7MPY5UYQyt9ZrEMXBbDp2gmRGA=;
 b=jUgUf574Sxbnd6y22Uy2OJuj5UpAagkxrG+WKHNbfoKMj+KqXVJL+i0TPbBAXNwPUj9Y5S
 4yE3Ok72m/1fsL4IdxQ8plTH2I0obS85SBCUOaJSotuDIuJtdF7Q8ivcYGS7rWiiXBJSYp
 DqfjXeogNS/alj6Q/IG5zPX1bScPhtY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-A6N1C5zdNDmRSoI4g86DaQ-1; Fri, 25 Jul 2025 08:19:39 -0400
X-MC-Unique: A6N1C5zdNDmRSoI4g86DaQ-1
X-Mimecast-MFC-AGG-ID: A6N1C5zdNDmRSoI4g86DaQ_1753445978
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so3295804a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753445978; x=1754050778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3Awn+NwWRVG7jYVn7MPY5UYQyt9ZrEMXBbDp2gmRGA=;
 b=lRZp5ZzVXXUzB9KAQQYTO+WWrJBobPi2Zt4+3USQiufMKAN6fQoxoJoN+JmjRllZkV
 AhxYQssqWJ0KN4N2q90Y1TGUzFlLOgWTn7i08yGZ/ihz46C27P3igPkJgTz5S/a+xgLx
 uWfkKSzfd/chLRQRc6PpMBgJyiROyT3Co4+fEIrhi4coSh/svfg85CYGChGUepFkbZ40
 t0PvdcIEIZKTFwPu7rqpoAMNKffq7m/xVqcRd/yVUcriunoDlY8IbBAiptuK/J1SKZ6+
 aKJYnLvfuUACXo7bFMhunAwgW7iKsm+42ZWEwidRvPA1lCWnPoMzBrauU6M/yZ7CgR4/
 9V2g==
X-Gm-Message-State: AOJu0Ywdf9powlyXbfffK3Qp7D4d6vXt/p01hP7qlY0FAl1fkCTgozVS
 XawGvXdSCwN2Cn7JBk9FuZldA3Mf/uNZLBChtU4TOleMzHLr1vk8yQAduuR5XTlD1RWCQIGnH7/
 1Og/7ZvwuqhHmRHTqOqH9IfnJMBQ+AqKol3jxMUFQpqbbdYzUhlEdBsRM
X-Gm-Gg: ASbGncv0N1wylGBtiGHcWEshtrMkjxPFdhaS4S7pRFYvCL6nh+tkGVDbPrV9elFfLWB
 PRhEby9UDIHqylw0o5R1UkSHCKQeZ07udlLdl7p5Mb7Hpxexa/kMkqzpobPnkCeA292zb76zoaN
 WHYOX34yzUzczw3dk/u/oEooWg3W2gJlbc1tEe6Pbn13IaltzpcJl1VdcpYmJ0A4OicqdDB1yzp
 s01kSwwqo1sMSI3PhUYvA6KEwegzKtYVTnP7oVKk2iObSFbwgd4HvVj7VXqovaGwpvMztRMg8hG
 oMllvwC1OT+spZbFEtQF9ESmCO3MJOaqKoHGkFlOb2+Ure7EudR4iw==
X-Received: by 2002:a17:90b:5310:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-31e77b1f2d9mr2872281a91.33.1753445978028; 
 Fri, 25 Jul 2025 05:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx0HOk0mQW3qbPb+3CM5rdrsy9rJTY6bNPtNw4qrhW9+tDmRL65EGE90yiSea7oYE3Mt6NuA==
X-Received: by 2002:a17:90b:5310:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-31e77b1f2d9mr2872207a91.33.1753445977502; 
 Fri, 25 Jul 2025 05:19:37 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:19:37 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:43 +0530
Subject: [PATCH v7 04/24] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-4-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=armenon@redhat.com;
 h=from:subject:message-id; bh=rSq8XlbxIP2TL+IIxg8guvnfFFsgOaQYboopFmhHT2o=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmfb6OOaKCUfSeVqKJmefM55inyxZWK/e+qp3n/Tmq
 i25yjc7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATEQvlZGh64F6xJ6Yk6FT/wlw
 ck96MTNSks9rOffXe4dOKp/dfsCMkZGh9eQZBeOZEwynnZXfmxsxd232xrvNRn/4fquxd3s8/XG
 SEQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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
index 842ff3dc6d5ccb05f7d33cef9f7319b141419501..736410be867a29efa24d749528c9bc203a3e8131 100644
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
+            error_setg(errp, "Failed to load VM version_id: '%d', ret: '%d'",
+                       se->load_version_id, ret);
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB7FC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCfR-0003Oh-Nt; Wed, 16 Jul 2025 20:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCf4-0003M2-RT
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCf2-0004da-P5
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6idEMhh83uqC5z427pjdZmOU5UfrJ0zUiwqia8wpnxM=;
 b=hOreipnS0HSYEONSaSMVWHy3LD2kE41uBLL/0ukUEyZJAlYe6HrAWoqyUYjvDJpubZszLr
 wvBevDPRbBHSVEx+ycsbQF4cbFMSiPplZoBOCPF6AbxPVOJDplO0xiwGFmLObRK9SpsIQ1
 Jvq8j9p+xTdqjGWNB/ciU8kSAGJVHB4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-c6MIHDofOyyAk5_DwFDD0A-1; Wed, 16 Jul 2025 20:39:42 -0400
X-MC-Unique: c6MIHDofOyyAk5_DwFDD0A-1
X-Mimecast-MFC-AGG-ID: c6MIHDofOyyAk5_DwFDD0A_1752712782
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3122368d82bso556162a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712781; x=1753317581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6idEMhh83uqC5z427pjdZmOU5UfrJ0zUiwqia8wpnxM=;
 b=NHJaC8JkMvCbn/mr+FzPjshTYEpxcNEFgAg+uZbPDb4roY5pWzxKGxkZskquITB3so
 5vOYyYNsAoL1CPPVM67AEvl5bE5OVRZWMH7Y0kRRvsKwO9FvffvCPMTE6DMkjK3MLINz
 9o4uyP3kQRw6e3hrsedIKV20Kevx4qosskp8QiozhW4ntxX7J2ghthIiOHeSlE7loztG
 H6RqdSjHLSZtLJ6SoxmtEJPt6g1k+Bx+0qh/Gxm8dxKtGekkrQgqxDvYS3iKeJiucs9B
 ynMRGrQaiWXXapiq6tV2MIMX2+/CD2KSaZrjygNwOdXlFajlQQSWPZPFJl0DzpGLUF2u
 RaYw==
X-Gm-Message-State: AOJu0YxgRzv/XBbFTbi7jHpJ9BaQynrNS6p3OSDWiZGRpF/CGu5JYnMH
 ex5yw+5nyisyIgsRw0XRac52GrqRnmZhwq/B0TdMV2r1Z6cye6Iaaahg+28/+JWGgtLjyvQtZfk
 pcA77cTQncFIDRPcfTkd72/BstuR6GQ4TxoXAQaQ/+ruv1xtHZcOriOIg
X-Gm-Gg: ASbGncv1uLiSMwLKPKKMUhAoIRbM7JgaKpaK3/Y0xpt/MqhJZMFrhTUv6TZKlHzkIPU
 i8mCb94GhWhMVUl5soQrwQChejbnbrDrwjjoWSGvf4l/xzik2VyMr6krds6mm0n8NeDSgNzV33r
 GcdgiwC9LkFtXr9tBGy/H3xwHQOMuf8YjmgxB8S+IIvNJHHFRp6FSH93RNU/6rk8c9oLg5INqRl
 wBWeAh60KQlMbWQu000zQXbvjd9zUZIDRRFJNWdnFPd20BS791KuA24iiarTnyUc0j1fm0st7z8
 tIhudknvssQmd675aSjY6KPbibyqN+8TuhMTwCUGUEeA/vlYfRHO
X-Received: by 2002:a17:90b:4fca:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-31c9f48a301mr6610754a91.35.1752712781593; 
 Wed, 16 Jul 2025 17:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm44/XlUnExWB7VZSfuCnSkl/KDOGoVsa6zbio5hhb6kL3krG0P2MSeTCiHW1oWwzABDeqXQ==
X-Received: by 2002:a17:90b:4fca:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-31c9f48a301mr6610721a91.35.1752712781210; 
 Wed, 16 Jul 2025 17:39:41 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:39:40 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:27 +0530
Subject: [PATCH v5 04/23] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-4-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=armenon@redhat.com;
 h=from:subject:message-id; bh=ipdA30K0WlD1GlemlwMPQb7dvJDBNmh94bTKeAzukGY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm5y3bkRmz9esLdFOnZU3Vt5ZJ6U/q/llqsDdiv2TM
 i5xLPncUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCJOXowME24czjfmcVr6oNVx
 9zpBg2255+5u6ee7X1PP6uwh9jXiHMN/ryUFhatn3rnBNKHlpuiLK/7XOxqu5N/Xia285ecyoS6
 KHwA=
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
 migration/savevm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3ccbc724eb808db09b77088a858ecc7f06b21155..1c1a46e4a01f812b559c451d278916426aa1cf40 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -963,14 +963,14 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
 {
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
         return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
     return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              NULL);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2741,7 +2741,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
@@ -2794,7 +2794,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, NULL);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);

-- 
2.50.0



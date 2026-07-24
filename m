Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD88C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFaO-0006v1-HB; Fri, 24 Jul 2026 09:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFaE-0006qA-KQ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFaC-0003Iu-UU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=FYF+BHzatNj4VDz/AEhP3zZClolFFtxwJ2La99QqSZU=;
 b=FYciGUKw0mIqhnv3SRvhY0rJ2t1F3KcBLpSpqegsJUkN4dD5p0NDoWumlMuhlMeAakinYf
 Ch1m9MU2JOPsF4Dw6nZRVsNz0CBQiX3DaEZk6hiFk+uIKxRqzimKGqXy2n3AWXe55xSY3f
 rnh8I2PMr2ezp+IHH55Ri2zxKWXApHg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-L8PqMfX2MZuvYW15fhwK0g-1; Fri, 24 Jul 2026 09:04:54 -0400
X-MC-Unique: L8PqMfX2MZuvYW15fhwK0g-1
X-Mimecast-MFC-AGG-ID: L8PqMfX2MZuvYW15fhwK0g_1784898293
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4956c1655c3so2805845e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898293; x=1785503093; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FYF+BHzatNj4VDz/AEhP3zZClolFFtxwJ2La99QqSZU=;
 b=OSlNZ6qp3FM2/tgl2SA1iIHYiZB9Sf7qHVF+Zvds5YbnOeVjFmDPJ+q4ZwrNIWQnPS
 M4BYBdv2x9vWIJkRkH3IG+1xaJCDPjAXsfIVLENLLOjbHb9wNb3qgdrHrbOoYxG+boET
 PUaPXst+AhBIvqWJnMftuuUhdTTpKZQ6xT3INEV/biovD9bkzjFaBXkDyR7i1umAkgWG
 1yMYHUSqCG1OXXWCfSmgpx2PWWSYwRlnN9X0Li/6U5jSH5OCRW8WKh3YlUhK5XC8QWuU
 44rwgUalwHQSHac60EnGlWP0rhm8tMN+hSSG2gI9oVPUftGSJ19955MziHfrYXJPtXAn
 RhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898293; x=1785503093;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FYF+BHzatNj4VDz/AEhP3zZClolFFtxwJ2La99QqSZU=;
 b=EeD6Ny6KJBV6D2flfZQ177FPxrROFnrv/NmZuI6iDpb9Dj5TNkKi0hxbkHRv3h+phf
 4VKk++Z3xd4um8SOaoS+mhgxIxIlWpyxikx4bQXeCPPh59nPKdhNroj9NvbXKpJh056j
 F9lxTIUilJlnZfrdSDlFkGpj/Zu9/EwzaOkRfD7IfaUbPdJ7xIw33Z+y7OsAVxC9jx4o
 RwTlFFnf+h6g2Tt6T2bxnuMenlilCtedRljgmQlz68uimp4x+C2ljbLmbzdlmmfiMgL2
 PIlOJU+o22+UZ/ARXGECYSjwewE4vcjhifEjE7keRhLj7qoHDc190/O1qb52CQbIEMKw
 4FIw==
X-Gm-Message-State: AOJu0Yz3Ecs4ezojhdOwNaRIPDWGtl+b96cWqc4+2Trto5vHSI9eXZSL
 c1y2Um1doddKxsGYGTjUOwkuu3aPuXbBH4LzCWc8F82mCaIeKn1wT3UZ24OsJKPJprE3CQGaHNA
 rBprbCBlgpIzsAfKJqaocI3q21nx+ZvO0hhQmlKZTHnzq2fvG+VOZ9R0nv9Qf2jduhs3RROdplv
 Di5CTFYT6ADyZpsBTbiSpLAs3Z7mjdupJFsQ==
X-Gm-Gg: AR+sD12i56+mV5T7BT0aXLLmnO2V1EzK5RtbPma3LrvCiNu5KzyUXrkTqaewTiDYaUH
 xTbia91qB9QPCH6miL/cQl2/1F7qADsUIznPebxqsKncpM1NbSHReWxQPJIhfn9uAernEZXCYy5
 5Yq/Km5K2UqCwNLpaKrp95lcd4zqmoico985E97hFCfXRfULpBtNhUpX5CBahQZxbjcvME3fClw
 oax/DN54342cIWwBaP4ZPbEoAG6Ld6p7TAAROvFk3UVEi9DKQzRDPHLEOkkArciAetVm0zNyzHx
 N9cyWkuqpVgcQeLZo05dryIFsZoNgCwppO9+yOJpspXgjR6LUkn+bk+9gZm7y/qDiSFXRZBX/nQ
 p6+74oAIqAvFn0te9zq+0Ww==
X-Received: by 2002:a05:600c:5250:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49573cb9159mr85283635e9.7.1784898293104; 
 Fri, 24 Jul 2026 06:04:53 -0700 (PDT)
X-Received: by 2002:a05:600c:5250:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49573cb9159mr85282855e9.7.1784898292321; 
 Fri, 24 Jul 2026 06:04:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af885b5sm67757575e9.11.2026.07.24.06.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:04:51 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:04:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/3] scsi: handle NULL from load_request on migration
Message-ID: <3777347521a12252e228e4a6243c75250bf76626.1784898250.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On migration, scsi does not check for NULL from load_request, and just
does a NULL deref if that fails.

spapr_vscsi already returns NULL on failure, and follow up
patches will add more.

Fail migration gracefully instead.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3888
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/scsi-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index deb43d5560..fa7ac415e4 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1922,6 +1922,10 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
         req->retry = (sbyte == 1);
         if (bus->info->load_request) {
             req->hba_private = bus->info->load_request(f, req);
+            if (!req->hba_private && qemu_file_get_error(f)) {
+                scsi_req_unref(req);
+                return -1;
+            }
         }
         if (req->ops->load_request) {
             req->ops->load_request(f, req);
-- 
MST



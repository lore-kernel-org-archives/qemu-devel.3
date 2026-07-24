Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF15C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEDj-0004sJ-Vc; Fri, 24 Jul 2026 07:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEDh-0004rS-LN
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEDg-0004sW-4R
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784893055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIpJs5HX0XPg5xMjpFNNY3ZAGpxgVVt0qdvab1b9cC8=;
 b=MDq8IioMg4UPrdVCzBT1PFyxnDZr65vY0zSXlisiCGWCgNFcWkAx7JCPHsgXJ1y2X0meRU
 YlHnW2ctowk6G5E51IlEoUNZeGnQsdNrW9B39ECKr2w2z7/kNp2+0oSyGDKnC695IpdNmh
 fuvT6icCHpIDaTSF60HkSYA/gZwibts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-tO7k27GXNUq5wLXA6KG7mg-1; Fri, 24 Jul 2026 07:37:33 -0400
X-MC-Unique: tO7k27GXNUq5wLXA6KG7mg-1
X-Mimecast-MFC-AGG-ID: tO7k27GXNUq5wLXA6KG7mg_1784893052
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49554715277so3519045e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784893052; x=1785497852; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YIpJs5HX0XPg5xMjpFNNY3ZAGpxgVVt0qdvab1b9cC8=;
 b=c6UL+jiaeeSwSVTg5VXr98QDEYEPNkhV78OiqQ4bwKJ6vjqrXfE3nQOawSSL9lUm6K
 gubc2kZFqmAQyK5pIncYgx57PJqiGXVekTkQi68rVdVBoI0UFc1Bv14puNTrXUgCT3+c
 C01Z0kblNJryZFwUYsYrx00p04Tt/esnX7yP35fu6+upbxZNpFFVSZeyM0Ya8DHe2wB0
 C0uxSvs/rTFnuGi7O6SH8xrGP47iUIDHRoBSEs3DKQgaFHEqSobJm2kJoWRnFCh2APW5
 Pdm0XynUtIz/lhBQnox9Ql9vf2mh3XtFwOCz7SoKRgeHa3oweC89JiYbU1nP0z2yACQN
 7u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784893052; x=1785497852;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YIpJs5HX0XPg5xMjpFNNY3ZAGpxgVVt0qdvab1b9cC8=;
 b=kho7MhrAhdNVHYSiJfCZUusC4LwNPGBNh1xw5vhVciw1JFL46SWaVE4mKb6sDUrnNQ
 9o+KkqpQayN6rVMvFma7nwMi8HHSDuiPI7shmNZ2YilCBzc/sgigNUDdk4QoKpQ/pthZ
 haMFkrFIeRnUXPXB5PRpfCsKPD/PvsgmxWkMZIvBMR5WX/IRRSIBEdbdXoT8X3v6DSW2
 xNRF481YR4V+fB+Lz41N/J+QOMiqD7BonEm8Q/uuVhU+FlCrTNqch0xYyhzng6QOnFJD
 Lk+fJPrD763MFe6WSEmZL/A90DTEv6ECoES6pVLNLA9fRlsfX/MqtXqc5HZRt/nvt+bD
 5Vfg==
X-Gm-Message-State: AOJu0YzGDVtuKuEJJk3eLET2Ssl9EA0/qGhAlql+mFeQ50HTGkArxiyA
 310qyqSWyfWQgTx73ip2eQmp7h1GDCPj+OJz0AUBjsb6aJz9ir6/+88BzkuavfzPm67t5+U9jSx
 KSj3pYHo9sg/vqsTO4INEppBlBNkita338a/EbG/pIcUH+ROLkbuNavGghmjb9OSWVPI4kFPtrc
 MGbdrP8UF0cSJRpVY2TprHm/rnntV0W9VFbg==
X-Gm-Gg: AR+sD11oreS64/aKwF75h+gSzGatAJcFHk9A46WiTl9faK4PTsMkpfXBLe2j4U49VIv
 gGQ1IsYBhW/pEn84sDCHt4lHUTQxUrqgplVyL1BaVHLQg4oCnxSPArqXdwTRrs0rY/jtWYtLmam
 kD5Ry5NT0h3CJ3NamnovzEzj7Xon9wV+yAhcr6CwXE0hyAy4PAw8bUDTjsG3WqO29sHJ9L7DwSX
 XPozr2VQbJRhBp3IuboktPmhXDleKF+oBq13gMc7N+8fOY4xHJ8ZBJf9XI7oVPeOMGWuwuuLQtD
 IVck28JxscsnxAen243RTsP2Tia8fHObuNBUZfA1OXWVF0AS3cBk8US1Ys60OI1hv9flPgXpYsd
 K1vp6pWV+ykN991KYaDDXHg==
X-Received: by 2002:a05:600c:630d:b0:495:64c6:84e9 with SMTP id
 5b1f17b1804b1-49573c6a190mr86102055e9.0.1784893052088; 
 Fri, 24 Jul 2026 04:37:32 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:495:64c6:84e9 with SMTP id
 5b1f17b1804b1-49573c6a190mr86101305e9.0.1784893051360; 
 Fri, 24 Jul 2026 04:37:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af914a9sm68337085e9.15.2026.07.24.04.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:37:30 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:37:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] libvhost-user: fix heap overflow in
 vu_check_queue_inflights
Message-ID: <e2315efc526c0ee918485df4be69e2b26e8b7a73.1784892981.git.mst@redhat.com>
References: <8133770c75c9907578dd551f4d468140a0a75cd2.1784892981.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8133770c75c9907578dd551f4d468140a0a75cd2.1784892981.git.mst@redhat.com>
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

vu_check_queue_inflights counts inflight descriptors using inflight == 1
but copies entries using inflight != 0. If the inflight field contains
an unexpected non-0/1 value, the function copies more entries than it
allocates and overflows the heap buffer.

Stop the copy pass once resubmit_num reaches the counted inuse value.
Note: the value is not guest-accessible so not a security vulnerability.

Fixes: CVE-2026-63110
Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3974
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index c1c13dbc90..a74d814bb4 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1408,6 +1408,13 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
 
         for (i = 0; i < vq->inflight->desc_num; i++) {
             if (vq->inflight->desc[i].inflight) {
+                /*
+                 * We earlier counted exactly vq->inuse in flight -
+                 * what is going on?
+                 */
+                if (vq->resubmit_num >= vq->inuse) {
+                    return -1;
+                }
                 vq->resubmit_list[vq->resubmit_num].index = i;
                 vq->resubmit_list[vq->resubmit_num].counter =
                                         vq->inflight->desc[i].counter;
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4315C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pu-0007jx-LH; Sun, 26 Jul 2026 17:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pq-0007bV-JG
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pp-0004J8-1S
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dNXNbWqWgFZ0JwC6UP3sqK22FEv12Nb98AKuyHM4oK0=;
 b=blWYuX1WqUDiOz1afVK4mLy9qzZ1lOjOgeCK64Y3+WD3qwmu6QAAZVLk95azlKj1u9knyc
 behNVrv1zNW87SYhp02MAbMXmCnDRCeQ07cSuFgj9LZVtDfE4mArFVoHFe7OkUBzdHci3Q
 r668TwA7EkHt9yfFgGk3CKbfQe466nI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-hipPcTTgOpmNUtYB6dG2kQ-1; Sun, 26 Jul 2026 17:29:43 -0400
X-MC-Unique: hipPcTTgOpmNUtYB6dG2kQ-1
X-Mimecast-MFC-AGG-ID: hipPcTTgOpmNUtYB6dG2kQ_1785101382
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4729d2a64efso1757163f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101382; x=1785706182; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dNXNbWqWgFZ0JwC6UP3sqK22FEv12Nb98AKuyHM4oK0=;
 b=mcyrQCXFyfESemHCiJWkWnh4VfmYZgeF6ro61sQxlcym95Pf3oMDOiQ7MCK1nMeCaq
 jBsAUcz0cdGeGwPumaQnpkld8/zS91vYBsp8d8N9EXtPDnzLteX5BuhKtwgK6ChZbgnf
 D++Kaa+kp0t8KOQ6SxfVdbkEZg7Zbk/hLVm6kf1cHU2bk3VwTrVIk3tz6t/bqApXVlXW
 Spq0zK/czr+aOsbWUECRRNXVyp5zaawxsYgXfzyDK2HOKJ4pufa0a3VPo6gM7SXdRdtw
 q1BCv2H7eH5pMqIRDf9qD8AqW4MbDsDcpA95eX4lc4d9RW71MN/o9v9Mu7lP7m6ynX7e
 DoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101382; x=1785706182;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dNXNbWqWgFZ0JwC6UP3sqK22FEv12Nb98AKuyHM4oK0=;
 b=EvB17Ay5vkpgZXdClCu73A7k9Q/SfzGy0r4+HfmGiSZSi9loBa5t4COhRXYuaZKaZU
 QrP6NhNOBHKYY3O+Pa8H59ktT4ibwrpY2Dd/5+1iVsV2RNr/M13DIxvRqLdKj/jAiXZT
 V09+d/Z4Y2+rzooeHKVFm2UXoXnKmp3YkelPLKPpDj9DLkWaUj6ntkkrnGWilpliEd+5
 Aq6gr+GLQC3ppc2H5ShEM/X57M7kQzAo6o8Nd2qWx2stUbAgjGNfdNpfHIupKV/sn/q9
 +aIJnR5XTcs1FlH525RVdUn0FNETjiYmnZ5Xph2chnMDtv6giF1RfGxBmF6J+bzTajTf
 S3zQ==
X-Gm-Message-State: AOJu0YxuRAgVykGcwDRcGoRcSPu/jzvi5YbvzpLPrt6eWSJLno7o2dir
 KZrfjoOjwEwhx6wgtZm05x3iGRaFyFb8M5PD+Keh+MzJK5faKGsC+DzIx7VdslqNuoho3NmcRba
 HlvrKar91nAsrdA9+AzkPwvShwEe+0CdAv0eJw9W3ewzxbmXYnGqjvQIiED6ywLkBj2TJyRlgod
 +ii61o1n10yTAB1YJ0Me0/v+iWybP5//TSUQ==
X-Gm-Gg: AR+sD1281vO/jJ8iIciy+MwXxHn2m2q5GTzZlSe9+1BIuIGKYfpjHAqEr1ScOafV5kz
 kwFPufwlcQ7PyyL1k4KlELEytGPMzvgrhkeibsqRdh5cXIwBW0Pf8jIIvJxAm9UfAHbzdpq/2PJ
 tMLNP0idMNT5aIhWv7E4sFTy7u4JPrCTev1h81VZYX47ueBW2t+f738ccBiiigW+jCwepjYct/S
 F7ce1FyO+FJZvIhfgldY0ZFTLXu3Ig2Hb/0Z56IUhkm3Ua2SHwZzSLGEa4eS2g7vVRQnBlKabfu
 LJsgTLISdvNnYrYNfGcgoA0MZI77IwbPM+AtL8uIgHSlvxALKWHjhO8No+KKULrEfHveXoNB6up
 qK1iH7kcvsTUaUTNkQBUBAQ==
X-Received: by 2002:a05:6000:25f1:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-47f9fc9568fmr7765252f8f.8.1785101381650; 
 Sun, 26 Jul 2026 14:29:41 -0700 (PDT)
X-Received: by 2002:a05:6000:25f1:b0:475:da0e:744d with SMTP id
 ffacd0b85a97d-47f9fc9568fmr7765239f8f.8.1785101381081; 
 Sun, 26 Jul 2026 14:29:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm41970429f8f.22.2026.07.26.14.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:40 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 16/30] libvhost-user: fix heap overflow in
 vu_check_queue_inflights
Message-ID: <f843cf0faab6ea8f023086f5d2c37090beeacbe1.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
Message-Id: <e2315efc526c0ee918485df4be69e2b26e8b7a73.1784892981.git.mst@redhat.com>
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



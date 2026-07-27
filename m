Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B162CC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQs8-0000D1-KQ; Mon, 27 Jul 2026 15:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQs6-0000Cc-UU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQs5-0000bL-9k
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzIhIizbscnBAXah3/DIwmRrBhiJpf/g3B5e2RRu1OM=;
 b=WmiYFQlZOBCiqsr7yyOBT+uxFlh51vKTh+vRsMfXuTWX8rsjcesXB4JIzEQFlHyWZEGuKs
 wR3ynkjeFpMx+18P1pZ1XtKCQ1zdRrmenm4XG+W1GhBkyFRTXst5XbcTJC/b4XFMiqXRVl
 XOOH1dKl1YFqEuAUQiyX0+Ox4fdUu7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-4A9rwxc9OJSQlpV8GVoMIw-1; Mon, 27 Jul 2026 15:20:15 -0400
X-MC-Unique: 4A9rwxc9OJSQlpV8GVoMIw-1
X-Mimecast-MFC-AGG-ID: 4A9rwxc9OJSQlpV8GVoMIw_1785180014
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso2197412f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180014; x=1785784814; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KzIhIizbscnBAXah3/DIwmRrBhiJpf/g3B5e2RRu1OM=;
 b=MG347BwLc3QFkiCAiVCSaoSLuKDBPzOM5B8Fe7cXjNOMl3jc6PvbgR3VBW1ulbv6yn
 1t2Igo7OmKDdOGC5k0LhgepXkv7Tz8pYSSyfVUnCXPY+WKJfMNU3d+hp7oFPsTSYDaLV
 PfDb3Nt5Tu+4vlcALuxmt6K7dBtdn15p4U2CTPEaHPLoPU9nFAO1Swm2ql+t/5QtGu6w
 jp9KfA2HOUckGds+kkHUrY56iLaNhn50YjlhM+vJRMbhsmOwwrXULqfpNF1BD/eVeL65
 mf25ZgxBiHf81ZZ8EDfS8eTPgLtiIRsu3GrqbfufsuTAK3kRpI6Bru4SmehhqCznitQk
 lVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180014; x=1785784814;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KzIhIizbscnBAXah3/DIwmRrBhiJpf/g3B5e2RRu1OM=;
 b=Ruvh5+C4F4Kkdkrq9qrcHJY/8xHbMaRULzVUZ/Pu5DeJHvQwjnchbHWCRdzAmWj4es
 uuRnXGGdDAdBPX7lOjYZ+keSoZIQWcZjKfbyWcDoQwY1l6naSP4SN1MOX6Fm5sP+PnhZ
 CgGax1dWSPWg/MfS8fzPCyZbBwJCvGbE8BrvyLH3KT8dkT/GokL6wAWrvKyP2I/5Idpy
 D8wDQWU+hE3WvR3t5bx5bhGp72ls4i5yGf/2asZIMMiL9itltEictKUzgo5Luy+l4sxv
 J+MgdUTHv0RchQqCnhjo0Pmc/BxAQkQfRzQDneK5K3sys77CMO8u5Ac2mS1XhCqHua6M
 lG9g==
X-Gm-Message-State: AOJu0YxEWqYHXEpddZClAXQhTEZSrouCaPA+R6MPfqaZsrwnkZUBIeci
 xSN2b8pPJyXY259vyvoUjQFJogPETO7bnPTgt2jazNr8s4+UZmlg+fCYoWeOCtFE+u47Oj2flr8
 FVzmTilNpHUnXZKzBh5ufbmifY6gfFFXwFXL24FrxJhllWzddd3m5foaz+2LNdXAnNj/tBZIN/u
 3jMAjH6SX/KBu7js4JxCfmAWgaJiB/X+ViKw==
X-Gm-Gg: AR+sD10cO0jRCTPo7uaIa1wRBfcvJUJRveYb2Yg4onqtfxwhEVPcKPugF6SYfltNcOY
 cB+1V3rRlID/6wGeuHHwGKFXW1W7ksnyKbVLJCpFST3682/xvbWqHp0/TSf5FSnxZoCd68yqul3
 FRaDYFsGWI554Cm6SLR/i2JNPm6Z+72N9qvAwoMib6gJ2eBmMiUFzOfMHo1MIFM+PmRzBoaWhmD
 glH45xzk82KHzRzMxAeMIzs96Iyqp2cJDPhcYHd+nE6sXmtdtdrxo/sr13YpLcpLZcmicSo4GgE
 qAxiLxWf/3huuKAO48i45uH+x4/rt3xyeMaPnn+vnsoQQKWwdmfTkmjhIfIbuTHtTNCBPGKpTkc
 JagwMEqg6lNnNpiBqx6Qm8A==
X-Received: by 2002:a05:6000:2503:b0:47f:8abb:7476 with SMTP id
 ffacd0b85a97d-47f9fc9006dmr13219152f8f.19.1785180013526; 
 Mon, 27 Jul 2026 12:20:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2503:b0:47f:8abb:7476 with SMTP id
 ffacd0b85a97d-47f9fc9006dmr13219106f8f.19.1785180012866; 
 Mon, 27 Jul 2026 12:20:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm50258932f8f.22.2026.07.27.12.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:12 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, BB CC <wywwzjj@gmail.com>
Subject: [PULL v2 16/30] libvhost-user: fix heap overflow in
 vu_check_queue_inflights
Message-ID: <b9d248dfaca5e31377ea4f7204aae788a050bafd.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
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
Reported-by: BB CC <wywwzjj@gmail.com>
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



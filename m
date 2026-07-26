Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07671C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QT-0000hA-MB; Sun, 26 Jul 2026 17:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QK-0008Uq-H1
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QI-0004bf-Jo
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBygUpJElSVx6Rgzwy2yFble0yG7EiQvnumyCQNrnmk=;
 b=DALG58ynfx8uqy95x+HBoquIzfhecDSDJbNboc/XGJ/PCZ9uOZIyUTA8S1KSMowNJf8aVj
 17VSmYV7s452Zaq4BTfxhTnihX+TlNJnK6F/q4iWDCSPiFgny0chkx78/l3UEnyvPORKh+
 EHJSsTbNNlm8CSqP9Jh/w0Jo0EWHMTk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-wEnsU6wWNUaNqgPBnK1ZuQ-1; Sun, 26 Jul 2026 17:30:12 -0400
X-MC-Unique: wEnsU6wWNUaNqgPBnK1ZuQ-1
X-Mimecast-MFC-AGG-ID: wEnsU6wWNUaNqgPBnK1ZuQ_1785101411
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f8f8fde2dso1411539f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101411; x=1785706211; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cBygUpJElSVx6Rgzwy2yFble0yG7EiQvnumyCQNrnmk=;
 b=VO7EFSVF6wOpKMc80wcMG3+Fzf/GKOpzACKAvamrO0QzmwKSM+R7w1uvILwn191m/Y
 6kdYs8f/gTjJ865jtZEX66TpuQfivWvIngXJtdtWyq2Pyf6zoDpHH37yoO/hFGRvn324
 KSgafqW2QoEQRdMMHP6t7WBSDpHuHdPTOkbVP/4A/6swi7xCS2+wOqhoqtamcFZL0z84
 n3yUet1vDbE7xRd3wHm4adrGWR/Iw0Vs0ILiayMreKtm3VTzLR5nFCufIaTlyfzYP2m4
 iWIiPoR1a1Z25uonQsHK7DsefVKlZFJ3X2Xa1SWw55tOzu1R+yHkC8EsUBf6NoYpTKyn
 vbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101411; x=1785706211;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cBygUpJElSVx6Rgzwy2yFble0yG7EiQvnumyCQNrnmk=;
 b=UiGFCPI8xmRoRiM2t4UdjGBi7Wvtzp8GQn5wJ6TqaW5hMB/UEZCX0YnfMLwEj+axif
 4D7Tdm8mDbri/XqS9SwBMkNm5kpI6ZSSkD11QDfzKeFCumFoq7ldCrYPwg/5I0J5a7y8
 oZw+brupD8muHzqkzhJo6qn2zQI335WblAeHAN0q6zbEPMm7WB3z7JERkLuITDzhUCeA
 wGuOy2XTV1ofoqkzMqeBn/hJLfWceNGnEsr1J1ZNWFkpx/f5NAOCxRKy3ihxROTydUxu
 mRUQ7YDO+y1kZJsF5EG/5Wjg4zEG3SP6cDyBdzkh/WZZvUYVAai/flgdA21Z9EJaQucI
 zGrA==
X-Gm-Message-State: AOJu0YzX6JlN9ldNa+tS/x+zmYZnkwQe1FMamKumT0xX6kL0KplWLix8
 xR/VZLE5S80Yl0b+5iMWvDjJHAhhjSvC9wfolheh8IG0/PAAHKZGiiFFhXOQHPbs+S8Wl1LiMHa
 jDXVNpklTxJj9P1temGoeweamC7WEVv/SdR62IlOMXKUUH0Ze5LegMnBG0YO6k1SCd/9WcxCtmy
 +q2yyEy1nbSy3jkgdfNKOYwyhnZUqLa3sFGQ==
X-Gm-Gg: AR+sD13V+WfAJ8nCfV35Qpvx1V6Hcea3QpX3gDLxSRzTX99d5KD93EYSDNnOtimQ6b3
 1MMudnOx5+toyoT56v+2OLql43ej0I76H1mcgEOVwCF5bYs5MWfOGF0yWGvIgPHEosdS3yfcAhj
 s89kQMqKZ/FOcpaFJItaZcdDElt4BsJYwamejQusQn0UxPq7iX9byko7VjpDkXIvSn4IaYdtAsJ
 kShl/yAw/Qs05+WmL3EGet/+PxzoLDgs+dGlkeFzAm7lDPYnVh5mzmjs14+r3VaO5bNkJXMZl2F
 i0IHwg2bdErFeVbZklddwwo1mcGCL5gO7SqKZ0Y0jm52VlCBo0lbx1NBvK9f7ZCpugIlkeVqXKV
 XxkcWXwq2UJ2c9rBtSM5gAw==
X-Received: by 2002:a05:6000:4025:b0:47f:756f:9a8f with SMTP id
 ffacd0b85a97d-47f9fc95ef5mr7969906f8f.26.1785101411016; 
 Sun, 26 Jul 2026 14:30:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4025:b0:47f:756f:9a8f with SMTP id
 ffacd0b85a97d-47f9fc95ef5mr7969870f8f.26.1785101410511; 
 Sun, 26 Jul 2026 14:30:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a64dsm46688983f8f.1.2026.07.26.14.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:30:10 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:30:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 alxndr@bu.edu, Jason Wang <jasowangio@gmail.com>
Subject: [PULL 28/30] hw/net/virtio-net: Protect from DMA re-entrancy bugs
Message-ID: <025b8841f731776bbc8278a552a412f8244f835e.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

This update was missing in CVE-2024-3446 fix.

Fixes: CVE-2026-66022
Cc: qemu-stable@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: alxndr@bu.edu
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4073
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260723233555.2970619-1-lvivier@redhat.com>
---
 hw/net/virtio-net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7e0c984ec6..814b99a43d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3009,8 +3009,9 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
         n->vqs[index].tx_vq =
             virtio_add_queue(vdev, n->net_conf.tx_queue_size,
                              virtio_net_handle_tx_bh);
-        n->vqs[index].tx_bh = qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
-                                                  &DEVICE(vdev)->mem_reentrancy_guard);
+        n->vqs[index].tx_bh = virtio_bh_new_guarded(DEVICE(vdev),
+                                                    virtio_net_tx_bh,
+                                                    &n->vqs[index]);
     }
 
     n->vqs[index].tx_waiting = 0;
-- 
MST



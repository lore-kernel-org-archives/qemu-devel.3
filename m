Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19590C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXT-0002Py-1A; Sun, 28 Apr 2024 03:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXR-0002Pn-O3
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXO-0005QD-QL
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so3459663b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287684; x=1714892484;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v3er1ckfxS8VJoewK2JALUlU7LYlW6SDdjuripGnWgk=;
 b=QECzFaI9pvLNDq2kMMMVc2Qfze5mr7QJQIRrjelmKlaM5y7ZfhfNuhAmsjbl447ujv
 thVJUz18C+J2Ooue3gmC/5nGTLzHHdOj4et9CpOxdsDuD+lZAnzn5M68lW24DdtkH5tV
 0i5q9l2F/oS0kjLjjJspUjpq28nYvCyeLo4Q+Q4HnHHefOxo2ev19l7JguUcM6W864ta
 +yaY+CisPkQ1Tgn640XbVehkguEjeHe/uK4YH5odziYRPwlyVlYYx8dbkCU1bqNuxKLq
 0QnuGLq4BYv/DzLreI1fegBtPL43ffIrH4zsbu/GS5YzVhsfl4OHtdupILEsHe6Md6aS
 xrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287684; x=1714892484;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3er1ckfxS8VJoewK2JALUlU7LYlW6SDdjuripGnWgk=;
 b=cKZ0G0YbgoebNEvjAkffVmkTlkIB3kTON/2XIHqVh/BG/2PyR/Bzd433p43NFZobIi
 M0zroXp6hx+J8N3nMQhdFtSOaF1m95x0vlBz7M0pEVenCrswtTIxja3irf8kxNCnC2ew
 q1Y68kVAdlb9V07glOABXmUweC6imyH09eBhciiry7yd84WTnakuIwyJb2yGHqzfge7d
 6SS3cmUfP5Wb29IIr2e2VPoOj59PEcfZQComZ+5xCxUJBWJKwA+hZFxxWaBijbnJQvwH
 8tSVuQ3AL8W9bc4ShNWv4pZCV2BWXC+t0rYE6I/+7YUHlGyCB8Vq8bI/Bux9h/XXSPUq
 UKdw==
X-Gm-Message-State: AOJu0YwDiOIcrZ9Sedks4oO079j4C+3grPZQcum7VWobR3VNSbXO42gq
 bHrcvKPtdFJ5KwiejT7JrUr+/cYVz/OmrNfN2si6cxVPWGbN3mi/+vqGP8A3vMs=
X-Google-Smtp-Source: AGHT+IH23zJvVziOL2/KsibP+yls3DC3PsDPV1iogytnu1XdVUSiiLRQIP7FXxfBL6lYKqwxqeVNVw==
X-Received: by 2002:a05:6a20:ce43:b0:1ad:a8d:dc59 with SMTP id
 id3-20020a056a20ce4300b001ad0a8ddc59mr7615920pzb.26.1714287684431; 
 Sun, 28 Apr 2024 00:01:24 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 r8-20020a63fc48000000b005dbd0facb4dsm16781015pgk.61.2024.04.28.00.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:51 +0900
Subject: [PATCH v10 08/18] virtio-net: Add only one queue pair when realizing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-8-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Multiqueue usage is not negotiated yet when realizing. If more than
one queue is added and the guest never requests to enable multiqueue,
the extra queues will not be deleted when unrealizing and leak.

Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8ede38aadbbe..e33bdbfd84a5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3759,9 +3759,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                     n->net_conf.tx_queue_size);
 
-    for (i = 0; i < n->max_queue_pairs; i++) {
-        virtio_net_add_queue(n, i);
-    }
+    virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);

-- 
2.44.0



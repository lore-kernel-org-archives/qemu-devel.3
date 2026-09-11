Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6623AC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAo-00053t-4G; Fri, 11 Sep 2026 05:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9t-0003hU-B8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9r-0008FG-O3
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbPme7j4pWLTyo9RI68qo6cFhFds/zr08zUNXOqMtd4=;
 b=QTut/jPiGbSDplD84UoanbfMgQtnCZI2FnButRK3KFcyoyPCFi4b+TjGknecnc7VkrjH/I
 liQL6Mj8miG6D4YtDbGHQ/UhJ+qK6UPrmHSHVNa+DYmptE/yuWjUf90iV6eJkixwsiRZHj
 5+IAWmeGrd3MdiFfx3k//O9zry3CdSk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-flFIr1MxOv-COMjpBoyNbA-1; Fri, 11 Sep 2026 05:02:53 -0400
X-MC-Unique: flFIr1MxOv-COMjpBoyNbA-1
X-Mimecast-MFC-AGG-ID: flFIr1MxOv-COMjpBoyNbA_1789117372
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso3441185e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117372; x=1789722172; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sbPme7j4pWLTyo9RI68qo6cFhFds/zr08zUNXOqMtd4=;
 b=WWMt+RJC8t+zqzLmVo9Aw4nzVgefrvljkLRQZqEkBbzG8TzXAjV+46oQs8MngrUrWN
 5JY38eUKJJmyl4BZKW+TlgvvMvjVZifdkaIToPpulg9VT14HptI0wpx6Mtx6TAKW6rWS
 FqaF2MXLpkL/E3bZ8rEOZPZCvYlyAc5mClFITlhxWEdj8IuAqiBGHmwRSJOcLgap8HbL
 dPiqBxEYbEWTO4IDuarlZo3Mvw170+/1vM5Xzj6NXUMEzdOBykJNAFBY4s/JvnFGe0Xk
 abmGYurJVtEtL5aDo7uTlLGj/0AYqiquKrDD1mtzUabmEaqM70K6RApOKkLRQ+LomvFf
 0gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117372; x=1789722172;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sbPme7j4pWLTyo9RI68qo6cFhFds/zr08zUNXOqMtd4=;
 b=ZyEsFvDwagxOqcIPdhbNvE/oX682Gwd0cEOCMLlGgFrpKkdztPGsFSqeSUSEUEokqS
 rMeefoRMTtkj7a6+3bgu9GfmGiXpBySw9B5xQ3/0gTIW7uCTRwBXsvkIWRzxqnGkzMVC
 XA5JtPjXG6OO/P1C+5C4mfeXtEDOlH8Z7a8yBmz3wUlpGsNTCmiNfso+LpusXwg7058r
 zMjc++z9q+DlCjBHM0m89HA3QIioFXcoFhFFVZCNFF1bf8elOX3mt4UUkdPMARpSC2sI
 L140SfnN9eZQvc9EOnshuOFNIUV+RJA0lnQtHXvNe7vPpRi4FjNl8B28bmJ5oK6upOWa
 qVYQ==
X-Gm-Message-State: AFuF++nOIS4+RevXzfEAPsZI54D8wWLjoultduFGoqCiSCSlkwDiQU0z
 BNfBJ/Cr+bD60AAvvyZHz4gVBww2yemFWpcu9EmhQCN/o5w5TRZ9ykrcJW7hsnRP61LNWX9BCJL
 fIIojAOVsFxs0gSLhz3CcO5GSQYAiGFuV9dmc8/WKYHGWlzWbKEVfn+Xnh04hW+7d+MBzdC9ZKU
 8RHeHpRoeiK91BtgizML+4opzYLCkf8avYuQ==
X-Gm-Gg: AYBFou1cJsioMHIG/sTDybA29n3gxN/eXP0yBip6t2CwGKaeYSuUGYkx8QwQUnpHIHw
 LMpYbuVWddGRG3lu78n4Yx2JzI4llxm9DpfnU2UnDgDjXIvG68vog9fr0pxn5VSKsnbSXFAnUrq
 F064ZkJtHCU8kIS6xKgYKEIqtPJg3JBmsojzQgfSXgL6zTvaCaw+WSzSmkvwqVfXffMFoTrTLD5
 1PxFoqJeQMwEtulinjyfns2R45D1ALP4nFOM1mVlqJbpxhzglBAPMvrjnF2a0bb6PzOUeyF5/IB
 rULCDDETRyrWQn3FMW/ZoclHgYfpoOQOnp5F6lsJO8nk+eHnk4FsxDFImTTWBK+5ndXg6LXlNTH
 PpkEdPkI8QvAxk1TeKSrl1Io=
X-Received: by 2002:a05:600c:4584:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49e60f5afbcmr39265245e9.3.1789117372222; 
 Fri, 11 Sep 2026 02:02:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4584:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49e60f5afbcmr39264755e9.3.1789117371609; 
 Fri, 11 Sep 2026 02:02:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bfc1sm162330005e9.4.2026.09.11.02.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:51 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Yuri Benditovich <ybendito@redhat.com>, Sven <bestswngs@gmail.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 38/75] hw/net/virtio-net: strip trailing padding when
 caching RSC segment
Message-ID: <9ca7b8261eee82551674614ca09ef2cc0b8faf72.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When an RSC candidate packet has trailing padding bytes beyond the
declared IP payload, virtio_net_rsc_cache_buf() copies the full wire
size into the coalescing buffer and sets seg->size to that value.
The bounds check in virtio_net_rsc_coalesce_data() uses the IP
length field (o_ip_len) which does not include the padding, so the
check can pass while the subsequent memmove() overflows the buffer.

Fix this by computing the actual IP packet size from the IP header
and using it for both the memcpy and seg->size, so that seg->size
stays in sync with the IP length field. virtio_net_rsc_sanity_check4/6()
guarantees that ip_size <= size.

Fixes: CVE-2026-66900
Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: qemu-stable@nongnu.org
Cc: Yuri Benditovich <ybendito@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3879
Reported-by: Sven <bestswngs@gmail.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260728082311.4179910-1-lvivier@redhat.com>
---
 hw/net/virtio-net.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f3f375e1b2..23c26aa08c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2200,13 +2200,31 @@ static void virtio_net_rsc_cache_buf(VirtioNetRscChain *chain,
 {
     uint16_t hdr_len;
     VirtioNetRscSeg *seg;
+    size_t ip_size;
 
     hdr_len = chain->n->guest_hdr_len;
+
+    /*
+     * Strip any trailing padding beyond the IP payload so that seg->size
+     * stays in sync with the IP length field used by the bounds check in
+     * virtio_net_rsc_coalesce_data(). virtio_net_rsc_sanity_check4/6()
+     * guarantees that ip_size <= size.
+     */
+    ip_size = hdr_len + sizeof(struct eth_header);
+    if (chain->proto == ETH_P_IP) {
+        struct ip_header *ip = (struct ip_header *)(buf + ip_size);
+        ip_size += htons(ip->ip_len);
+    } else {
+        struct ip6_header *ip6 = (struct ip6_header *)(buf + ip_size);
+        ip_size += sizeof(struct ip6_header)
+                   + htons(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
+    }
+
     seg = g_new(VirtioNetRscSeg, 1);
     seg->buf = g_malloc(hdr_len + sizeof(struct eth_header)
         + sizeof(struct ip6_header) + VIRTIO_NET_MAX_TCP_PAYLOAD);
-    memcpy(seg->buf, buf, size);
-    seg->size = size;
+    memcpy(seg->buf, buf, ip_size);
+    seg->size = ip_size;
     seg->packets = 1;
     seg->dup_ack = 0;
     seg->is_coalesced = 0;
-- 
MST



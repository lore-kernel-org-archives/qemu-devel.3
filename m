Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8084DC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PM-0007NM-6E; Sun, 26 Jul 2026 17:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PJ-0007Mg-RI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PI-0004De-AU
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9eTAz9p9JyHr+wbU67/OgvCnUZjEWeCXUaq3sQQxms=;
 b=PljD7L0ML/ZFUOC1ZsdAnvF3zMsp1tPmQthHHFXZQ+pDmjl5nIjhohaAEYoakviJfOkdAb
 2Et1qQ5hTV+agas4rg6Gt8RmNZzcB2jb4qZkj2ZV1zXcHC7XLOtRypX7RU6N0GRPQFmCOI
 K0THKQXm1ICqiLGODOlD0Or5IZbTaWs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-Vxd21hM-MWKfsCe4RoBRNQ-1; Sun, 26 Jul 2026 17:29:09 -0400
X-MC-Unique: Vxd21hM-MWKfsCe4RoBRNQ-1
X-Mimecast-MFC-AGG-ID: Vxd21hM-MWKfsCe4RoBRNQ_1785101348
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f7700ffdeso780842f8f.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101348; x=1785706148; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F9eTAz9p9JyHr+wbU67/OgvCnUZjEWeCXUaq3sQQxms=;
 b=GrBFDAiPmAtwr+0diII5ptVu2dZEzKuY5Qkpf08YNc0JC3hv+MvPqpRR01cZ4XRIl9
 kJw6jiCOKVNG/kYbGKDfTFqI3WEZiGW/BrdjcMi7SXF35/8RZOqfLqATH58VDfuF06tj
 xzL1ezxqRxkmk3W9X9rfjFNYCk57x6MlO+p2eT+gHoVhZJcq/OrDQt1LAqy+cEDgIgRD
 Yo4Z3JuiqqJHdRqkSbXbqqMeAtmx6ZDY359Fr1VezfeerjB8gCZzPYTEYW35WxlaaHvc
 vd6XHKFD1OjTsTSS4UQ/d2z8d34XIdUTyZlSWjS6asjXTY9cxWe+IO/XbP4gN7pmoMoa
 IYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101348; x=1785706148;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F9eTAz9p9JyHr+wbU67/OgvCnUZjEWeCXUaq3sQQxms=;
 b=WNN+C3mTKzJTGWVlzvk9xf7IELIbzWMqJ3S6aLSxYqojPKldpd/nYr+aw5TmvnMQ21
 +7wWqGKh4QRIC6WUTKqYQWhAN43yfzkC7fNCnmyA6c1XMM4pokrzsM+130PhQmmryLNl
 OPQVcTQX0Z7i22bzWiIafU/UyoQ8xv0hOGeFEldZn/L8XqlmXP7/ZTxacqaHodtptinI
 kTxAxPZp5XN8VnWn30BWi32lbUqiXA6fBfSQOHhH0lLP6ZujkqFEH9/hJXUqiCAg9Gdr
 HfRTP3zf0eaYM7s7AtMz32LY40HZaZmnwAw0gmOvL+17wuvjb9YUWDjMOzWqh52MhdW0
 Echw==
X-Gm-Message-State: AOJu0YzJzFarqZrSR2WJ1Llo6wt5YAhKjVQBMeNuMi9IW/M+gi05NMMf
 0y2nT0SsAXRKFgVP6vFz75SNo1Qqta4AivKEnfg0Q2MPSD0lLhXHTKrrYDvCKl2Xdf1sZQaJr+F
 BE2d2cQv48Ff3p6H3txUS/qdlYTFQM7Qc1+pIFP2g2VdUUOisxvdxloQb5XsEGEbBVIw1OGqDGg
 HqVd775bguttk7xspmK+LAOKZNz47pdX5mPw==
X-Gm-Gg: AR+sD11E/ZOrhgil2oklUEnBdaGILiN0oiQZz/2Yf31T58YW1/YMkx78ny5q6VrloAV
 feVqApmS0SxqYmqvP316tYgyyNWjFNqlMi+So+S7eybboKrKmWON7mdgdas4VwGAMWhJqbw2WsQ
 jOrhKzlUbgcFonP1HM+7n6UQicFDSIGPRNLBQ8Xvdzigoxtd61Y9kQWh7zQDXqD6lyLnPXuo3Mt
 WO37kEwAwJHOz/17Qrbf61nOzIQnJoXznOOm+ZFSX2lYpOMdokBqdaDtqAly0m7CZKckl5X5Dan
 dp+HqwavHgxEZ1Y7u85nPxW960l/QMr4R9ErqSy0ofQ7ihvSDuWEtgPGKhJ26k9+eu4APHjYPDZ
 NxjZTFOiv/NdQftpLnS/6tA==
X-Received: by 2002:a05:6000:2005:b0:47f:776f:3838 with SMTP id
 ffacd0b85a97d-47f9fc89ab8mr7071907f8f.6.1785101348177; 
 Sun, 26 Jul 2026 14:29:08 -0700 (PDT)
X-Received: by 2002:a05:6000:2005:b0:47f:776f:3838 with SMTP id
 ffacd0b85a97d-47f9fc89ab8mr7071892f8f.6.1785101347634; 
 Sun, 26 Jul 2026 14:29:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm42025934f8f.33.2026.07.26.14.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:06 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Yuri Benditovich <ybendito@redhat.com>, Wei Xu <wexu@redhat.com>
Subject: [PULL 02/30] virtio-net: fix OOB read in RSC receive path
Message-ID: <8c416ce5d0121cd0f9032ec416eb5c829dde207a.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The RSC receive path parses incoming frames at guest_hdr_len byte
offsets, but the backend buffer contains only host_hdr_len bytes of vnet
header. If the lengths differ, RSC would read at the wrong offset and
cause an OOB read.

This is no longer possible after the previous patch, but the assumption
seem fragile. Along the defense in depth lines, let's validate.  To
ensure we are not breaking any valid setups by mistake, warn and fall
back to the normal receive path when host_hdr_len != guest_hdr_len.

Fixes: CVE-2026-63321
Fixes: 2974e916df ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Wei Xu <wexu@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <f261dcd535edc890f8636d8ae5ac1007bc32b8b4.1784891251.git.mst@redhat.com>
---
 hw/net/virtio-net.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb290..2761644dfd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2674,6 +2674,13 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     if ((n->rsc4_enabled || n->rsc6_enabled)) {
+        /* this never happens with existing backends, but just in case. */
+        if (n->host_hdr_len != n->guest_hdr_len) {
+            warn_report_once("virtio-net: host_hdr_len %zu != guest_hdr_len %zu, "
+                             "skipping RSC",
+                             n->host_hdr_len, n->guest_hdr_len);
+            return virtio_net_do_receive(nc, buf, size);
+        }
         return virtio_net_rsc_receive(nc, buf, size);
     } else {
         return virtio_net_do_receive(nc, buf, size);
-- 
MST



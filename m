Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D33C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBV-0008SR-SJ; Fri, 11 Sep 2026 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xB7-0006z7-Sb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xB2-0008S9-4V
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzJidFmu3cCZ/gNI5oejlvZ2j1X9hxYd2KmntrLLK2Q=;
 b=KSbnWpUvkE84TrlbzRLL+SpkWaj6YEg+XcDn9SCXOq2FucutYc3cfKtJKsf72Kq3B/SV7X
 F9KlTg6hF/qj32CFAdt/rl85IEU11fX+vBnIL17WGJutUw8FIBjsi/wDgKQvH3ygB5qrtP
 uGF2xiMjo/gcL7uGR2L7CCJofMdbdCA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-BBQeC5pzOy2N6e3MKmY8HQ-1; Fri, 11 Sep 2026 05:04:05 -0400
X-MC-Unique: BBQeC5pzOy2N6e3MKmY8HQ-1
X-Mimecast-MFC-AGG-ID: BBQeC5pzOy2N6e3MKmY8HQ_1789117444
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so6764805e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117444; x=1789722244; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzJidFmu3cCZ/gNI5oejlvZ2j1X9hxYd2KmntrLLK2Q=;
 b=s2YppWhfpKIgyoxauYNkqOxRXj+c29fKWUUTCqu+qtPZXKylGPqBXSOXD/8xAQqfUd
 FfDnh5/KNwVH193w7tNDNrRUuxR4uj6xcK0VEwv3cSX7YgCRxXVvZz2VQWONg3m90XcL
 J5iSiLFLmMxjUtjZW3G+A02mutVurvyD6eeXw8p2U4QdCHuU/6nYwq7hJZKEL33QtjPn
 WoXkUDBtQ2grngAVF2Qf2eqnQWpZsl7ZKvipqBpBKBucjm5uYyyn4PY7QmfBs7ERDz66
 0iL+Skfief8sNHfdYz4Jt0tbmLCzbF/YKM8Rq9RSNjcFedSJJndMJyac+nn9GQLy6tUQ
 dz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117444; x=1789722244;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzJidFmu3cCZ/gNI5oejlvZ2j1X9hxYd2KmntrLLK2Q=;
 b=K+8VpKobV+ism0t1SFOMQlc5V6e7u/5ruKxzgHWHBRaW0LbbnJZNAnlHyfxHtJcjTT
 nstX8o9RmcTd1dzt/kbz1omE0nPbVooLVfZdrgxF7YvAPzeepqc5etcP3EUgvl6GJgMc
 hMA/Rtq9ihQlAD8WKtoBqt7oIhyMCpeg3cm9anmRyIy6WJVGbXfZ7qucVZkpenJoiY4K
 5eA1wyges54jUi6fctZ+8WV+DOZD2pXuqXgaKH+vGOWGxdMNcwIFpTb5txwoCCO8FmaI
 wFNCLeTAQBW9m5B9R46Ne35wSRpbX7o2Nshe4jg0s9iada1L/uwS1qsyP9ZAPnGAWFHX
 4Ihw==
X-Gm-Message-State: AFuF++kVGFBjEnQdBQR2BaTWUI8wMXF86UhciNSPC2NmgPQ9QAqVIneA
 pafW4eUJEOLmH2ynnKNtFdABkzexGoavAip/NYCA29B+wdBBXP+jx+xkKdnGISLaGNbfx6uwcre
 xrK1kGfStFYxGqCZZUxlEfEZntWzx73hOavk+yOX+IW1bsThUxVIxWe9Ph/rm00DN7FWR47aoX2
 gOCJ00X0OwKtSxNBCiFPwQG7YsbAfTa8w4xQ==
X-Gm-Gg: AYBFou0VuQ5jbnC5/ayOtlPYi1LlGIdf1kEvek0SA8/6b6SN1mwWD/7rwPcsf3qsGxw
 hxbfQthuSuEijAEk91iJXRecA+LM7qyhCpyIyMEY9aXRIrP3F0CiSa5TQsM4qC9YOdzn5lhA+q7
 t3LGDaag3QC0GvV/bVBkc7AmuMx5bmYF8NBG09OdWpMgV1oBmDdm0t4lYVQZ0qTLfwgMEcVKyOx
 yNrKIzsy+jhBUJv16fQv2WqsvVSBkeAYy7vX7z+AVdji6dxd9cQ3AMk7XbUDShWqwaW9ssDhLy3
 Hn45ShRpES0LdQGx/991SIoyW14HhO2Ek2JDbq7l50kH/kQ1PdxhwMdL11lH3n4ThjqaYMXA3hy
 U/uM3tx/J9b93J4XPeB3MOKQ=
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49e6198865dmr42375245e9.8.1789117443825; 
 Fri, 11 Sep 2026 02:04:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49e6198865dmr42374315e9.8.1789117443205; 
 Fri, 11 Sep 2026 02:04:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm134916805e9.2.2026.09.11.02.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:02 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PULL v2 67/75] virtio-net: validate IHL in
 virtio_net_rsc_extract_unit4 before use
Message-ID: <8649730874bde0412e3c531e5fad43dde96bab08.1789117222.git.mst@redhat.com>
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

virtio_net_rsc_extract_unit4() uses the IPv4 IHL nibble from the
wire to compute the TCP header offset, but the caller's length
check only guarantees space for a minimum 20-byte IP header. A
crafted IHL of 15 causes a read 32 bytes past a 66-byte buffer
when the frame was parked in net/queue.c's exact-size allocation.

virtio_net_rsc_sanity_check4() rejects IHL != 5 on the next line,
but runs after the OOB read already happened.

Validate IHL before using it as an offset. Since
virtio_net_rsc_sanity_check4() only accepts IHL == 5 anyway, reject
anything else early and let the caller fall through to the bypass
path.

Fixes: 2974e916df ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4166
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 986ceff514..19f453fb7d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2104,6 +2104,14 @@ static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
     unit->ip = (void *)ip;
     ip_hdrlen = (ip->ip_ver_len & 0xF) << 2;
     unit->ip_plen = &ip->ip_len;
+
+    if (ip_hdrlen != sizeof(struct ip_header)) {
+        unit->tcp = NULL;
+        unit->tcp_hdrlen = 0;
+        unit->payload = 0;
+        return;
+    }
+
     unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip) + ip_hdrlen);
     unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
     unit->payload = read_unit_ip_len(unit) - ip_hdrlen - unit->tcp_hdrlen;
-- 
MST



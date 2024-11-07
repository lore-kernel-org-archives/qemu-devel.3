Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BF2D43379
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95Qj-0007z1-Ff; Thu, 07 Nov 2024 11:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Qf-0007xg-UQ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t95Qc-00049A-9w
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso9905195e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730997132; x=1731601932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WMn0gaL6wgiSUyaLJnx1vDmLwUkpAicF45c17E4Yr8=;
 b=OPQLQaPE6OvhLw/xhCv8puflQ5mxywR1+3LnApsO6r3duRmoh6MNmSN7GdSLhwbZUQ
 wiBUHMEIbkjPFzl2aC2nGOZKGJeF8/UQUm/fU59Wx4SRrJkIOhguOdNjEkCE6FrIRuPE
 rqDrA0GpBtXR1DnZZbTW6etCWbBOuB+zkFDHBo2at6309bJVqpwIn7xine1wdklccNs6
 F2i3iFG/56oDeCOptGxQtFFAf05mNWP58uUlHxmfKtiRcNKGLBijrREX5/JowwN2ZS4q
 BGxkKuIkWOXSiv3DUn7lF050GHEPYSubdozs4DKoVObcd1aKY+ETZmD/IyTHgw1femV6
 BIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730997132; x=1731601932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WMn0gaL6wgiSUyaLJnx1vDmLwUkpAicF45c17E4Yr8=;
 b=Q8GzOZydVGI4qntVDe1yrrO62Rp4UtXq5N+oHvSbn3h/FvCt40rymrKUZZdfmkLSdI
 OopKpqDIF0YxOOa6Q07tTooipu+HRi0fXZCbketu5XZg13bHnKdRbjuSVwHGaBqPbN1j
 cAm9tGfSXQoTOjJtRJl1taKcEKh/dAwB1+MqLpLW0s3jiSmi+224Ckjv0HdFYeZsPGX9
 KqA+CIRoL76EPh4uLZw2xp6A43cf/5jrN6ch6IVvgM1utlCe45fR0B+EMJ94qVpjkdFr
 +eMz8QI63DenSdZQES/gMCWvBtF/DB8yOHrLPYB3XADNYTtuvUwLQHqDSI06inrAZWRB
 xP5Q==
X-Gm-Message-State: AOJu0Yw15HKzquGj8RjztOswt9U5m37m5IhwN3prtf840DeC6aV8VHH4
 lcHA4wkEtLoOUmgcHkFmw2MMUNeI4VDtA+nnP2EigwBfgkZ26tJVLjiRpBUd7PLea6Q2kATFwgg
 r
X-Google-Smtp-Source: AGHT+IH4oIePH81+EzzXucdNZidk5sBsfDPXspJVpqIOwT0Apq6CtsLWJd49iLNraCW0Xng6Q6ZTew==
X-Received: by 2002:a05:600c:281:b0:431:3933:1d30 with SMTP id
 5b1f17b1804b1-431a0c3b8f4mr374746315e9.5.1730997132619; 
 Thu, 07 Nov 2024 08:32:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea587sm2185161f8f.78.2024.11.07.08.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 08:32:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 1/2] hw/net/virtio-net.c: Don't assume IP length field is
 aligned
Date: Thu,  7 Nov 2024 16:32:09 +0000
Message-Id: <20241107163210.3620697-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107163210.3620697-1-peter.maydell@linaro.org>
References: <20241107163210.3620697-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In virtio-net.c we assume that the IP length field in the packet is
aligned, and we copy its address into a uint16_t* in the
VirtioNetRscUnit struct which we then dereference later.  This isn't
a safe assumption; it will also result in compilation failures if we
mark the ip_header struct as QEMU_PACKED because the compiler will
not let you take the address of an unaligned struct field.

Make the ip_plen field in VirtioNetRscUnit a void*, and make all the
places where we read or write through that pointer instead use some
new accessor functions read_unit_ip_len() and write_unit_ip_len()
which account for the pointer being potentially unaligned and also do
the network-byte-order conversion we were previously using htons() to
perform.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/virtio/virtio-net.h |  2 +-
 hw/net/virtio-net.c            | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 060c23c04d2..b9ea9e824e3 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -102,7 +102,7 @@ typedef struct VirtioNetRscStat {
 /* Rsc unit general info used to checking if can coalescing */
 typedef struct VirtioNetRscUnit {
     void *ip;   /* ip header */
-    uint16_t *ip_plen;      /* data len pointer in ip header field */
+    void *ip_plen; /* pointer to unaligned uint16_t data len in ip header */
     struct tcp_header *tcp; /* tcp header */
     uint16_t tcp_hdrlen;    /* tcp header len */
     uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f2104ed364a..11cf462180d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2049,6 +2049,21 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
     return virtio_net_receive_rcu(nc, buf, size, false);
 }
 
+/*
+ * Accessors to read and write the IP packet data length field. This
+ * is a potentially unaligned network-byte-order 16 bit unsigned integer
+ * pointed to by unit->ip_len.
+ */
+static uint16_t read_unit_ip_len(VirtioNetRscUnit *unit)
+{
+    return ldl_be_p(unit->ip_plen);
+}
+
+static void write_unit_ip_len(VirtioNetRscUnit *unit, uint16_t l)
+{
+    stl_be_p(unit->ip_plen, l);
+}
+
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
                                          const uint8_t *buf,
                                          VirtioNetRscUnit *unit)
@@ -2063,7 +2078,7 @@ static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
     unit->ip_plen = &ip->ip_len;
     unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip) + ip_hdrlen);
     unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
-    unit->payload = htons(*unit->ip_plen) - ip_hdrlen - unit->tcp_hdrlen;
+    unit->payload = read_unit_ip_len(unit) - ip_hdrlen - unit->tcp_hdrlen;
 }
 
 static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
@@ -2082,7 +2097,7 @@ static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
 
     /* There is a difference between payload length in ipv4 and v6,
        ip header is excluded in ipv6 */
-    unit->payload = htons(*unit->ip_plen) - unit->tcp_hdrlen;
+    unit->payload = read_unit_ip_len(unit) - unit->tcp_hdrlen;
 }
 
 static size_t virtio_net_rsc_drain_seg(VirtioNetRscChain *chain,
@@ -2231,7 +2246,7 @@ static int32_t virtio_net_rsc_coalesce_data(VirtioNetRscChain *chain,
     VirtioNetRscUnit *o_unit;
 
     o_unit = &seg->unit;
-    o_ip_len = htons(*o_unit->ip_plen);
+    o_ip_len = read_unit_ip_len(o_unit);
     nseq = htonl(n_unit->tcp->th_seq);
     oseq = htonl(o_unit->tcp->th_seq);
 
@@ -2267,7 +2282,7 @@ coalesce:
         o_unit->payload += n_unit->payload; /* update new data len */
 
         /* update field in ip header */
-        *o_unit->ip_plen = htons(o_ip_len + n_unit->payload);
+        write_unit_ip_len(o_unit, o_ip_len + n_unit->payload);
 
         /* Bring 'PUSH' big, the whql test guide says 'PUSH' can be coalesced
            for windows guest, while this may change the behavior for linux
-- 
2.34.1



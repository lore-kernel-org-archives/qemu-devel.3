Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A954D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1BO-0005Cd-Ee; Mon, 18 Nov 2024 07:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1B2-0004XT-S3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1Ah-0005Rf-70
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:19 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3823194a879so1563296f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934080; x=1732538880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4ERK3ElD4P8I6nFF+NaMJMN4ukbGaWKpf0tkMteE1E=;
 b=uCGhJvQJ8NsMdpwTKTXLIJAG+S9b3WJJfpPvg2ZTPvL6qOaOmRneJAcwnIoRax1X1d
 6glAE1TgSHhPRskIq4lpF3O+ZswWdRi0i1MvvA4erpfsVdxJhA+2DIAnPiCV4Qwp/RyC
 TPziHyLhMG+lu5ZW0/951zYsYPFGxgMqL5D4NV5bAnZMZ96tC60qAXg/oCP0+Zl+VPPH
 qbvlL8oZ2AxkMlQ594q0sqY72iNht16ruxwbURT1obhTfZPc646MO6RGyqw38VT07yME
 cHOCvU2PHzUoVbB2rbcmrltjy8XMRG+xbuDogm6jfGJ959rNx8tyeFGpEUFM4A7uZWC2
 MaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934080; x=1732538880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4ERK3ElD4P8I6nFF+NaMJMN4ukbGaWKpf0tkMteE1E=;
 b=wXqRTAMpjIU/oHei0hbsZ8tUf8GCMVcr5GER0TqGZ5yzwOrcsBQBu8fw8kKfn4yhfv
 4RQ9Tn3rFwNBEk+DyUPyJ9PnrCxPaos9I1LigjUEKDvIpPz0XOAfTl8u2RqBWbxM7rro
 tNGSbpbKmk8jaeY7xzrroh/FzckzuhVz1E85QQ209LwC/pVtGL1JAslCEma4mtNBAJOk
 A2qTWdMZmjTzRr48V8tvnjW7CTAYJjcWO4ZoTCfZyMXFgk8kqTFdjlcmadePTjV/2+lP
 DcZH6p5p723oR4fcn66A3TQIvrQ0Qv3F1Mt1HIGqLioJR0O41EIJAv6czIn6CEQnepWx
 QJDQ==
X-Gm-Message-State: AOJu0YzVLbcKSww7cmuGGzbMzJ6FwfhTiVhI2/ycJd7jjgzAzmekD3K4
 34CAOTxfWtH4X6/60i9k717m9c1LPz7I/NfW4Ipl57KsxkYyyfXaz/EBkTF8OIdS3ZHtU47YTkk
 c
X-Google-Smtp-Source: AGHT+IGDo9Z850DXH8dv/QoH1s3wkaezvP+GTpZf2e8NqZYZktsOkQw0d2uqhbjTIgvkgPiZAq492Q==
X-Received: by 2002:a05:6000:2a8:b0:382:372a:5718 with SMTP id
 ffacd0b85a97d-382372a5a17mr5566122f8f.26.1731934079649; 
 Mon, 18 Nov 2024 04:47:59 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38244ff1ca3sm3810943f8f.26.2024.11.18.04.47.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/15] hw/net/virtio-net.c: Don't assume IP length field is
 aligned
Date: Mon, 18 Nov 2024 13:46:40 +0100
Message-ID: <20241118124643.6958-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241114141619.806652-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-net.h |  2 +-
 hw/net/virtio-net.c            | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 060c23c04d..b9ea9e824e 100644
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
index f2104ed364..75b4a28fb3 100644
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
+    return lduw_be_p(unit->ip_plen);
+}
+
+static void write_unit_ip_len(VirtioNetRscUnit *unit, uint16_t l)
+{
+    stw_be_p(unit->ip_plen, l);
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
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD7CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFypg-0004Dn-RE; Mon, 03 Nov 2025 12:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypc-0004Cq-Vy
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:05 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypV-0005on-BJ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:04 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47719ad0c7dso41241195e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 09:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762192734; x=1762797534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6+tSAlBBhmUzcNnrU8mm+VkZrQc/Wwdex2Ja9d6no4=;
 b=kEuGYOG/2celvnpd/nijbBqxvdBWTyWNd5G8fcbYcqqbGMV7S+y/0B/OBaXASlX5ej
 8NoMXjF483A1XtkaDfE2oO9YW111uMNCBtfrq9hb/zHe/3aRrea/kwdm/y09cD/aRoTt
 g34nr0cMpEwy+ccZdgn9aGEd51MryRDr2K0oiw0WksANMAmBG8n0YJL4IjYLY63VDYoc
 l7AgE3eRuD8vHf0iSW7Ji9MmkM9uE+bDSae8s05XUqVA/rsLbWFYP3SKvaBfyOn1G4I3
 3wO3QTl9RMYBliXTuAL09fT4L+7rUoAbxJrwscs047giP4ESSxFMkiFmWk3F2XU9qPSQ
 491w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762192734; x=1762797534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6+tSAlBBhmUzcNnrU8mm+VkZrQc/Wwdex2Ja9d6no4=;
 b=efD9jyS+aBJbAIDqMcH/4Q1hbOHixGyX8EpHdFLZuFQnSPrCAv1GpBINzNAXs5uPtc
 jiv652mCIaCREjamLZXrvH78pJCh5xIquudhREQTeUhhiKkNyPbrf2jaTRY/QuEq23n3
 18vR2W6H3y9QumlBcYPcW7/LY9nC2ZZ/iLHIwI2JEy58BLBx5GwBRxVhDIlv7dnCJITv
 oXr+wMwlZNiEXGloZj8rnGpCyuoKLanTHS/ukADKNTyNe7dovdUyq2Acv+58BmJTwWHh
 p06PGP0iX7z2MSwhSP+7jCFGFqFsj+1CvOX2SDL1z1JqPtDfg3PCMG0TN+lvQp7NHOwD
 nZWA==
X-Gm-Message-State: AOJu0YwQJ0JGOJsqN6i6SxaGlw+lE6DvoNnMxt/gXCrdBtkmeb0s02KW
 WNRbWoSWyTZZQtXqANAVLAIpblcPlt10xex1YcBfPtMwMblsW4hFhKIEDyW/VPfDTlj9MyFGWIr
 fXT8n
X-Gm-Gg: ASbGnctTsTDRAHDix45KoKIKfigHb0BUuXCmY4sDSs76hF9rltJwNt++vBDc3egZJr7
 U5KfuC62r/XG8EbEhMC6cQs3qtu+07SHvOPwmbzyrvAyiZkPdP9sDsC5lWLXQUE/rszI1DyiRLh
 eOzJAQw5BiWLxw7iWoBzkejye2jTqRGi4xewGuY9eQ33PY2pg7Wtr6ZWNaQD+RqDC1VtxSNElmk
 y1rjKXDqRNtbOt4Cu2AJkdK1cjgAhAddF0HHOpK22f8lkXi1N0kgHPZ65LIrgTSZ8NYkiYJcHob
 u19Rq2R+LdyTsU5zI5XalP2P5xPaMm31heC+2Y1vDkgMJrr6FNyy8zDdGJF60DOhlMjKsCrDLHP
 nQVYeSiFM36FGYf5bCrDacFLT9yXL4xeYNS7LYKClkuFjgisyQrhlrRgJ4bwRjFCW0mu9N1ecHN
 2r7IzRLA==
X-Google-Smtp-Source: AGHT+IERC3ziLkDXGhIESG9a/RrpnBC8KlT8KLcWHxApw3ejgbAAyk7qGZZRE6L2CSEexITNrOkYUQ==
X-Received: by 2002:a05:600c:1c1d:b0:46d:cfc9:1d0f with SMTP id
 5b1f17b1804b1-4773086e04fmr150301325e9.19.1762192734134; 
 Mon, 03 Nov 2025 09:58:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c569390sm165120595e9.16.2025.11.03.09.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 09:58:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/3] hw/net/e1000e_core: Don't advance desc_offset for NULL
 buffer RX descriptors
Date: Mon,  3 Nov 2025 17:58:49 +0000
Message-ID: <20251103175851.428816-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103175851.428816-1-peter.maydell@linaro.org>
References: <20251103175851.428816-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In e1000e_write_packet_to_guest() we don't write data for RX descriptors
where the buffer address is NULL (as required by the i82574 datasheet
section 7.1.7.2). However, when we do this we still update desc_offset
by the amount of data we would have written to the RX descriptor if
it had a valid buffer pointer, resulting in our dropping that data
entirely. The data sheet is not 100% clear on the subject, but this
seems unlikely to be the correct behaviour.

Rearrange the null-descriptor logic so that we don't treat these
do-nothing descriptors as if we'd really written the data.

This both fixes a bug and also is a prerequisite to cleaning up
the size calculation logic in the next patch.

(Cc to stable largely because it will be needed for the next patch,
which fixes a more serious bug.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/e1000e_core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 8fef598b498..ba77cb6011f 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1481,7 +1481,6 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     PCIDevice *d = core->owner;
     dma_addr_t base;
     union e1000_rx_desc_union desc;
-    size_t desc_size;
     size_t desc_offset = 0;
     size_t iov_ofs = 0;
 
@@ -1500,12 +1499,6 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         E1000EBAState bastate = { { 0 } };
         bool is_last = false;
 
-        desc_size = total_size - desc_offset;
-
-        if (desc_size > core->rx_desc_buf_size) {
-            desc_size = core->rx_desc_buf_size;
-        }
-
         if (e1000e_ring_empty(core, rxi)) {
             return;
         }
@@ -1519,6 +1512,12 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         e1000e_read_rx_descr(core, &desc, ba);
 
         if (ba[0]) {
+            size_t desc_size = total_size - desc_offset;
+
+            if (desc_size > core->rx_desc_buf_size) {
+                desc_size = core->rx_desc_buf_size;
+            }
+
             if (desc_offset < size) {
                 static const uint32_t fcs_pad;
                 size_t iov_copy;
@@ -1582,13 +1581,13 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                           (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
                 }
             }
+            desc_offset += desc_size;
+            if (desc_offset >= total_size) {
+                is_last = true;
+            }
         } else { /* as per intel docs; skip descriptors with null buf addr */
             trace_e1000e_rx_null_descriptor();
         }
-        desc_offset += desc_size;
-        if (desc_offset >= total_size) {
-            is_last = true;
-        }
 
         e1000e_write_rx_descr(core, &desc, is_last ? core->rx_pkt : NULL,
                            rss_info, do_ps ? ps_hdr_len : 0, &bastate.written);
-- 
2.43.0



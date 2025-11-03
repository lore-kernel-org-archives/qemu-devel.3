Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E01CCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFypm-0004Ez-L3; Mon, 03 Nov 2025 12:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypi-0004Ea-Nj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypX-0005q9-LO
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:09 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47754547a38so1856055e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 09:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762192736; x=1762797536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9gyhGaFcOpFheLwvmsYNqB/i/gJ7jSn4QomhlYUHX8=;
 b=Bv+QgYiz+AGtl3vPQOdbFunf4v6quH5eLmWAbkFo3sha+ZaKZ6h4PWgMmvy2uL59tx
 8Xo9W/Yf20OQC8246FPXmvBctq0Z+ZWxKjRQUcQ+HtZkHWW3KYET5sZwFLw6p4t5piOz
 rku0+p9v+zarNlzqZm9GoM1IdzNFlC8k7vfCMfSv+Uf2QwJ2qp5CNaLN0bfgCLIE/M3T
 dZd2FVpHeaXk70dugSfQCbpqHpc44FGyJopLbJAA4/WuVGPIXe9z5MnzIRFdhRZhcmLy
 UVYkv0LEKAgdDoDMKgQe+cImxtcuG/KdX+TE5LvATx4T36NPeNX/bqdkXnNh4vpRqJto
 zJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762192736; x=1762797536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9gyhGaFcOpFheLwvmsYNqB/i/gJ7jSn4QomhlYUHX8=;
 b=Tzl37RAhH9pV7fNM43bMOF7uWafsMcUMYJYT5eOd4oN9QIilrKI2ZJZM+yxiBFsxce
 1fKhmSCylH35iRzkbuP2545Hr1zJx2/ojXVGbGQHD+bciKbVFFhSoJp202los2tc8pC8
 0qV8LOC3IV4CIMb5URZy/IktsszT21bBSgXF8ocHbk3giEubtogh7WpdCReZGq/C4LUq
 8qQCpBcVF5XkIEdrK3J2n8UzY3iNOn3I54bCNjMgDSGLWLyCnTChW3P8282SQpaukyNI
 VXReiDtQ90kKlVvnqXQFmxkBruFcNAzXNctSoiU13EGi/XFTZJfZUtHknqTdQxkr+H+U
 37wA==
X-Gm-Message-State: AOJu0Yz1cx1lZikj2xNs9gSiOL3Jd9WdWbWuoOjh5h728Klw46MllWRq
 5uMUSmzs1josDKzmxAvnOnsZwvmzhr7wgCVWfi1sSgl1na5cEoFJp9RWF+2kyNxB0bMM+1xhAsN
 C7VDp
X-Gm-Gg: ASbGncuFeErJh3Cu/2jdr+lSPOIguAoMVE+tvgAVT/StAmQi8UmYzrgDe8ehREkfW9u
 QdlyCOE9Rr0MOX7hUeOELb/BiuQaIGvD4NhsxkvtOI0LeTlV3TScJ0xJY479fXRLLRVaHdFkOpM
 Gwncld87g5kCpO86KxPmbzwf69/01ks40JW91Qo8kQ+vsIRB5UbXJJoNTFQ95um/nXNSBrye0RD
 9L2lbVjOivFmRaSTEja3J3m9dwBzBSbEiWUKdjxEK0yKofMWoWN91MyJf9iD2bq6Ojx1f3Yk66v
 jioUlbTzSjlyCdf+oTXfmv582YbKGcyMrJltVcW+JKeqibQc88Ar+CM8GjGqsLKK+taROYrz9HH
 /IVZQnC034Iv8tAwufdY8xb9+u9xDhIldxlBUCb/Ae7leFMOkjqbGXNL5ZEFCWESC1mVq2RmeH1
 cgLIu86FVhlIvMv1Qa
X-Google-Smtp-Source: AGHT+IFtHGumGI6g43UFHtI30foS2yDahFefYvYoXHKIufBGfcVebwq+KQkLmn+aSZVyBKiDFSEx4Q==
X-Received: by 2002:a05:600c:524f:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-477308b6117mr131275485e9.21.1762192736138; 
 Mon, 03 Nov 2025 09:58:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c569390sm165120595e9.16.2025.11.03.09.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 09:58:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/3] hw/net/e1000e_core: Adjust
 e1000e_write_payload_frag_to_rx_buffers() assert
Date: Mon,  3 Nov 2025 17:58:51 +0000
Message-ID: <20251103175851.428816-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103175851.428816-1-peter.maydell@linaro.org>
References: <20251103175851.428816-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

An assertion in e1000e_write_payload_frag_to_rx_buffers() attempts to
guard against the calling code accidentally trying to write too much
data to a single RX descriptor, such that the E1000EBAState::cur_idx
indexes off the end of the EB1000BAState::written[] array.

Unfortunately it is overzealous: it asserts that cur_idx is in
range after it has been incremented. This will fire incorrectly
for the case where the guest configures four buffers and exactly
enough bytes are written to fill all four of them.

The only places where we use cur_idx and index in to the written[]
array are the functions e1000e_write_hdr_frag_to_rx_buffers() and
e1000e_write_payload_frag_to_rx_buffers(), so we can rewrite this to
assert before doing the array dereference, rather than asserting
after updating cur_idx.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is just moving the assert to the top, but the patch is
a little more than that to satisfy our "declarations at top
of block" rule.

I haven't seen this assert trip because of this problem (the issue
537 test case does not rely on it), so this is just a "seen on code
inspection" change.
---
 hw/net/e1000e_core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 471c3ed20b8..46e156a5ddc 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1392,10 +1392,13 @@ e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
                                         dma_addr_t data_len)
 {
     while (data_len > 0) {
-        uint32_t cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
-        uint32_t cur_buf_bytes_left = cur_buf_len -
-                                      bastate->written[bastate->cur_idx];
-        uint32_t bytes_to_write = MIN(data_len, cur_buf_bytes_left);
+        uint32_t cur_buf_len, cur_buf_bytes_left, bytes_to_write;
+
+        assert(bastate->cur_idx < MAX_PS_BUFFERS);
+
+        cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
+        cur_buf_bytes_left = cur_buf_len - bastate->written[bastate->cur_idx];
+        bytes_to_write = MIN(data_len, cur_buf_bytes_left);
 
         trace_e1000e_rx_desc_buff_write(bastate->cur_idx,
                                         ba[bastate->cur_idx],
@@ -1414,8 +1417,6 @@ e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
         if (bastate->written[bastate->cur_idx] == cur_buf_len) {
             bastate->cur_idx++;
         }
-
-        assert(bastate->cur_idx < MAX_PS_BUFFERS);
     }
 }
 
-- 
2.43.0



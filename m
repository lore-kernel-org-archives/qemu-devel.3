Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96952FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkl-00008j-RZ; Wed, 22 Apr 2026 16:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkg-00085q-Er
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkd-00026D-Mr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d70c30767so4016959f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888045; x=1777492845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hxNi4JN98tt5e1ONBCu5TVVdM5dmYGM9ic2cl2eBqJs=;
 b=wwxtV9gz9631h7fYhIykh52WD8NR5Ljrox9O8vJG3QIveBgJ4ky8c+wwfURJfU1BYw
 LFGwxN+NBCtbgG2DFh2/fdCu53cmI6yECI0fSCkxW7QPI/K0B9zer0FQLAsBDlMLgEic
 LSysLIglxQd7KDeTRkt35SeiAe519FZ1oLb0jXiGQuyVjjWTloxoN3ZrSIFFRmexkchH
 MxHqZbUppFxSxlaI9oWMMe5/oh5xs/YvA9459PnRw6OdlJQr+oLzu4R0sVr2C048QPEK
 JSCRKRo8LZgPSdbbeq8JvWrZj9XwkUZ7sQnR/XQ1zkuaTH03P9v9QG5VGq7++yGcJLpG
 tSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888045; x=1777492845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hxNi4JN98tt5e1ONBCu5TVVdM5dmYGM9ic2cl2eBqJs=;
 b=HCaviQJz8Eok4yd0iVhBS/Y5yCg9KXZFcyOBehIrqnKsjAAT8eIa2QiuXwmetATPYG
 op+qCOBD6zFqUoJb5H1DtUytnv+kcngPRANXTjphImD597WpDfzJM0MBqQabVeM2i9Xu
 uQHl36uXUMb0GC0EIxY1HwO1E0ib7Vu4ot1/aj3kmQmODoP/R5CvpZoTszgQVDATvKi1
 F3etkrRfGrG4ukIgTZjeXKeDahyPtqAYi6Ro2Mt4xLBJO1P8k9qpe0CcwJOwYWi47m2r
 DB7+OA9d8/NKpecxR+j9Gi27M3CXGnTSRzfzyMdT5SzFF62lxVsjW+AMZGoaFjAsjvmP
 oiKQ==
X-Gm-Message-State: AOJu0YxaOlBlSk2YMKtwXAJoMULDC4fsYKD5V3cMiFwVmp6FvqvkYAym
 v+zmOTwxKNHMwxvbvZI5N8PlE7sdGMKxNfm71boaXs2PHqDoVT/Af4tL1/NtjbC9gEctehyRRgp
 qKrASgJw=
X-Gm-Gg: AeBDievwUswVj0WHoA5sHWrqzW9zhbP1YxDKGjys98ri3RBId1nmHJBGttpffKCZV61
 7uZuRM0s5jk9PZVkXQbfe05F/vVjVnoJsBNCVjQo2TPhi8vB72ga8TCbYxkmfv2cjhcC3+47fdz
 /tlbbFcs5MiC+ePqHU6mQHUhoGznRQbDSAQekUbEZ8WAiPhPKaD5Ml13J4pGHJesQiAyYgSwv0b
 6PzXlivjZrY+nbqKgF9lddAfppVPyEDaz3JBJUsGZt8G5cLMbIj/xml9By4NlbtHZA+E++LjP4S
 QdzOg1JPE4fYug7vnvBEZmQahb02WBHrBlqwDNs1BVF9G88T044sZj+Vdy4GrjwxIcdvMMt6OIt
 /vQAalpNC9nDwLI8N63TN8fHy8euCm+bGwmhNKtZVb+i9XtRs9KF7cOM6cURXBOG6/gRsOJtLF6
 C2E92IWfsjzOar/dsqu3Wm09BJtbP8DZ5PIDO0NGUoZgS3sDY3WFhWMpOPYpdC3X2DxpBw3zTdW
 vk6QbS2ems=
X-Received: by 2002:a5d:5d83:0:b0:43c:fc5c:aa08 with SMTP id
 ffacd0b85a97d-43fe4034413mr37230280f8f.8.1776888045536; 
 Wed, 22 Apr 2026 13:00:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0d51sm47845624f8f.10.2026.04.22.13.00.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/48] hw/hyperv: Replace legacy ld_phys() -> address_space_ld()
Date: Wed, 22 Apr 2026 21:57:23 +0200
Message-ID: <20260422195746.88865-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Prefer the address_space_ld/st API over the legacy ld/st_phys()
because it allow checking for bus access fault, which shouldn't
happen here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Message-ID: <20260319082954.65069-1-philmd@linaro.org>
---
 hw/hyperv/hyperv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index a42c2850e35..a19f330e192 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -709,13 +709,16 @@ uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
     EventFlagHandler *handler;
 
     if (unlikely(!fast)) {
+        MemTxResult result;
         hwaddr addr = param;
 
         if (addr & (__alignof__(addr) - 1)) {
             return HV_STATUS_INVALID_ALIGNMENT;
         }
 
-        param = ldq_phys(&address_space_memory, addr);
+        param = address_space_ldq_le(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &result);
+        assert(result == MEMTX_OK);
     }
 
     /*
-- 
2.53.0



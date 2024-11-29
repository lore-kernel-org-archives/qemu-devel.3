Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FE0D6EBF7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGy44-0002Qu-TF; Fri, 29 Nov 2024 05:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGy43-0002Qj-Nc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:17:31 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGy42-0002j8-6Y
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:17:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a1639637so15842175e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732875448; x=1733480248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnmzBmtiMniQtfyoIrkF0lH5OiNVvtRvyQ3ryvXvacc=;
 b=UgjQDgat4fAFvvD2Me/MxnAd+TGjEB9BqQAwEKugzHNy9BFe+VBuO7TeCCf+R9vono
 uocMVV2K0SmTeLOoZ4ae9r05a3hMw5IRIx8cbYcZxGSIQ02ZTSDGnU7H7TYm27iWr4ey
 sVyIFN4SgItl5O8nH2Aj1vkvfYjzMT2dstc2g22UKgUmIOTHDMJS+yBekuwdK9oZi4LL
 RTWMjvBYc+pBJhCEp21xIU+o1Os1cFTI4JwBH7g/1fTuZzCLOoyc4oKS+Zk+eebSt/Bs
 KxpHfd3CoQMrmZZCZkZRH6vsCBX1GQMJbNRi9KmfiPSDuIHs4FXVNdb56sLg1ztFBfgz
 3wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732875448; x=1733480248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnmzBmtiMniQtfyoIrkF0lH5OiNVvtRvyQ3ryvXvacc=;
 b=XKEN4mC1czs+l9foh031EAmEDZAL/zp5UQgg+Qtu6lD0EeWg5qhzFsa7f2CtqUNRgk
 H79vo2Nr9gcUFn3INJQHMiQFi/83246G0ZGKMAZJDg/7RBO03qoly5jZLc4GP3jaKTnd
 iqbhnJqgIoYlpWkHvpZNIWD70DH+Te+6E0cYyFi4MGRgajTc26yjkMpSsdhH0z82r3Gr
 nEcMKOFf37FBxKFVM+QZRldbY+05boszlGOYRwLXicLYMkpr8+unrIZUh6d58zopyOKn
 DzwDNmYRjfUVoSJTWkbG9ymi4thtJ3u9/RvcVhNELzGaa4Ko/B5ylkSrCbhh/64h0Ozh
 XyIA==
X-Gm-Message-State: AOJu0Yw2r+Fws7mBSTXHH3JJaI/qcjamfvzABeCK6VPzRoAmeyW9dw8S
 Rkc1Zgqj/tR7ORZ9xgKplzTiw8tl5gD0stlxEz03WVAjJnKaPSnQJPV8Qr1ZZ58Wb5RmYRa/HuL
 X
X-Gm-Gg: ASbGncut+lM+Dn41owKrEL1Jkekcy4z0+exZpoo6MMFraXSuzGYIWgX7+tFW+8MYIPw
 p5PLHbSclXF0gDbcZ/kFIjZXkZAzoWpskvpT3tKVlLD1EtVQnWwU0ktdV5VbDWVESdzsLwgDe2m
 IQcTAzkXfG8UJB4ASKI5lHrjXTJgl9PVJglTIJTOQSVTLgd+iLPBXKVq2vEpyXATHFQY4Sn8gz8
 zQzSEs5ouLrJK5GiRfkDoq3+yGgfE7MmJc5yeXnQ8mntS1LgaIiV3dJO/b5Dg327rxK57yTxAzL
 3hRusU1XTBq1xcalnQ6U60Xacz0ziQ==
X-Google-Smtp-Source: AGHT+IEfTQvmFx1GOTIKVO20DuuNjHGtof+FCxhyKH//IdyJZckcg1519tYSXiJAt+2UH0ZeA0XQCg==
X-Received: by 2002:a05:600c:1e88:b0:434:a5d1:9905 with SMTP id
 5b1f17b1804b1-434a9de439bmr86903045e9.26.1732875448052; 
 Fri, 29 Nov 2024 02:17:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bec1sm49095455e9.5.2024.11.29.02.17.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 02:17:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset 'big_endian_fb'
 in vga_common_reset()
Date: Fri, 29 Nov 2024 11:17:20 +0100
Message-ID: <20241129101721.17836-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129101721.17836-1-philmd@linaro.org>
References: <20241129101721.17836-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The 'pci-vga' device allow setting a 'big-endian-framebuffer'
property since commit 3c2784fc864 ("vga: Expose framebuffer
byteorder as a QOM property"). Similarly, the 'virtio-vga'
device since commit 8be61ce2ce3 ("virtio-vga: implement
big-endian-framebuffer property").

Both call vga_common_reset() in their reset handler, respectively
pci_secondary_vga_reset() and virtio_vga_base_reset_hold(), which
reset 'big_endian_fb', overwritting the property. This is not
correct: the hardware is expected to keep its configured
endianness during resets.

Move 'big_endian_fb' assignment from vga_common_reset() to
vga_common_init() which is called once when the common VGA state
is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 892fedc8dce..b074b58c90d 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1873,7 +1873,6 @@ void vga_common_reset(VGACommonState *s)
     s->cursor_start = 0;
     s->cursor_end = 0;
     s->cursor_offset = 0;
-    s->big_endian_fb = s->default_endian_fb;
     memset(s->invalidated_y_table, '\0', sizeof(s->invalidated_y_table));
     memset(s->last_palette, '\0', sizeof(s->last_palette));
     memset(s->last_ch_attr, '\0', sizeof(s->last_ch_attr));
@@ -2266,6 +2265,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
      * all target endian dependencies from this file.
      */
     s->default_endian_fb = target_words_bigendian();
+    s->big_endian_fb = s->default_endian_fb;
 
     vga_dirty_log_start(s);
 
-- 
2.45.2



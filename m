Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51CEE64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8s-0000n8-B3; Tue, 03 Dec 2024 06:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8q-0000k3-ND
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8p-0000bC-8a
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:32 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso50350465e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225549; x=1733830349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8t8QZY/FN9UNn+m+6+g6e/VW+X5qrUlO0/BnLyYU4FA=;
 b=TUh0Qxu+rCrm1E9zC/MBR5dQxsKbjavqPE1wneuyH1/q3rqK2CMtZAQH+C0YfC0KTI
 Z7/KvltAxNegvhDoqZ1CCpRC0JtjdTawrjWQSFWDnEb5Jfa6WM1opB/It24yHQMQEJt3
 YJ2XAEFElSLwwl1V0kjdmNOpmd8fpzgwAw9UsV2TF1l0UyxNE5m2xPcn0onyROylBzTE
 lW792qqMedKZwce6b7ErFNKGQB2mnob7mbT0eIW8GDHLbD2JqHeehkRD6uiLj6w749zY
 85kNZ3xjz0YdtKTQAEEwlhf5anKpw9Y7XmPQbMpJq0S5yBX4NR0uax1q+IF91lkws9OU
 H0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225549; x=1733830349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8t8QZY/FN9UNn+m+6+g6e/VW+X5qrUlO0/BnLyYU4FA=;
 b=DLpNeUh+GxdxjNCS7HED2QYliuhz8Wp3Eq3nqDZ81gCRvj9nB2CMuYVMeRX3PespDn
 calIjYCHWHOd20HBpxDXSuyv9PE/MQVO45UMuY5IR9xTZXcvlIEr7rXnRBQAwsMqIcsK
 UVI7Ibn+PG1nT4WCm5+42SwUM6hhEiP8sMv8qOH7yKrR+U1SGc/YoWW860ZcR4rCpSYB
 sARdbak6cHCaxZLNuEGi5qpkz/prw6+GvRTwMBTjg+UCXlevdvgZVMhY1jbgX3fOpPuv
 KnTxbx5dYKQMaIqFvS1HLm4JMu1321L8FdRkPt16RVYEcrwzJzIcWlYUvU8K/PHnpKdQ
 M+ZA==
X-Gm-Message-State: AOJu0YwPiTTTV2HcTqMR2KG3L8F59xso4n9ZVr754uBT0FKTUlbrqW8f
 GzlHXNgepODJ8LOtpqOp4+jkRciSEdaBRODoJbmU9dg/4EDZGROMF6DJVhm18Uwd5b3MVTSToN+
 attA=
X-Gm-Gg: ASbGncshBcd6KD/kN03KIhLSyeNqbTh7DWidkXENFK+1IwEfZ2SQaBSsYucuNR4qyQ5
 9Z09JqSBURWPhv627qfs3uPBQA6wwBGoOJ4SDH5N7eOukpjJV7RwTqzypuW04xBoZYFLNJNvjM2
 Egmn/fw9t8pUXWqLX5eMWquGdygK8mhq7mcqoJW+XcgwKytySDL3meVWgRUkiiewI8d/5eUliqK
 qJQwpJvGdn4j+aohJDyXJmm4hUHmEhRLhP2o6DlK16j3c1H4MwTI+a9LBThD3xwSGL0sYiO
X-Google-Smtp-Source: AGHT+IEXhija/FXz5kQkbIYBE2R+tXlZVLZnef+JOQudtrUlkuWBlAsRqr1KI9Ue2Pj6rUfS4dI+Bg==
X-Received: by 2002:a05:600c:220b:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-434d1116ebbmr17064875e9.24.1733225549547; 
 Tue, 03 Dec 2024 03:32:29 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e13e8eadsm11039936f8f.28.2024.12.03.03.32.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PULL 09/13] hw/display/vga: Do not reset 'big_endian_fb' in
 vga_common_reset()
Date: Tue,  3 Dec 2024 12:31:36 +0100
Message-ID: <20241203113140.63513-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20241129101721.17836-2-philmd@linaro.org>
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



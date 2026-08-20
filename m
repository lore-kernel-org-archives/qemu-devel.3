Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B380C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zE-0000Xk-7W; Thu, 20 Aug 2026 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zC-0000W8-6g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3z9-000598-8T
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so20176555e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787236994; x=1787841794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F31PMa12IiO/re93aMILk1LSzM11AyPxrVTqJ97tIV0=;
 b=ciky6r4NCbxwxxi9fj3TMBAhY+8zf1gFG2tNgbpoxuepEwM10c5UsivlqX5qslAVek
 Hb+UqEakbGBA2H0UowHkQEnNyXwfOBab3xpQ81oz1RqT/7WC0TJJnjME1BAfZvCFaYbn
 9rWEJwzL85y4ufOkcDr9PbLyh5P7DBSu378XhnnfaIkjfrpYaL4vxxkTLfEXUprNLkrr
 e1oh89v4+OKGq07QFvTxF62wZkmqVikIVfCT4uJlJk/lv/JPQCUXU2or1GLEnRgmXEVu
 oz7IRZWpfnvJmOjP5rMXMjpJ1NYDCEHcpWxqE0l5UotbHyh1K7duePR3C9RK7ykYtKs0
 xTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787236994; x=1787841794;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F31PMa12IiO/re93aMILk1LSzM11AyPxrVTqJ97tIV0=;
 b=Rqq7cj98fhPb+VGTh/Ep4Ry8rvegqWT3oreQKmfdzza7MipCSYIDqdw3nzEhADEYyL
 dnUud0BAzJL1jR1wUk2L8xTHLy8A8VZg6RNVQdk9EStU+JrQF/dRtKaBy60EKqgiBXF3
 mf90hehGewqFfK3gz6+tUJqsdvzNYmVufZ4wgrPALsWXjwwrGNGJ/vZ5FCzf42fZsPt7
 ZGDFPmS1+mVEhfuAOGZ6SA5wAzWZad0m0SLIaXy+N4n2cKShRdV6Fkef4XK2DrZQghJm
 2dISO8sNqwhTbSHdxWtWnigibdV2+6KzxT8xsaInRkF7hR+1u4mAgWhVbuUGafED+C9n
 Ej0w==
X-Gm-Message-State: AOJu0YxCIRsbQqm0co9oXBaSuz73xaNVRWKgsGAKpz503b/d8n/kPnUh
 iA6XhWtzDhmWq6nBSa07madh7K2u/+tRGK8pzNlVD75CJs8yg3RcULPTCPo42DAw6gEi42QGXMd
 7m8xV
X-Gm-Gg: AR+sD11DgXFN09ihFnbhlnHCTnL+u/h0mQ9u3q0F2tp9zFu92M5pl+BM1Fv/JOUQl6t
 rvmYWJxZPulQgy/pB6x2UM8AU0e254xoAGSvGdhJABHx09ZmYAB8IS3A+sWI+PFk2hd6eX97Wp2
 nFvlyR68BsSMlxNcxDfCYLG9M7jQw8fRMJk46MdKFd0GFHa5fs86XUTe4OEVtSUoHOGSLyCyAf6
 xL6zbos6W1HbytU03q3gO4ifMWPK+tvjtZSskZC1LGM9tU6TsSA4L2vXEjnd+uIZohRA5vTXxWG
 bjg4qrRs0aAFlJli6NizlaywnGdA4V949NB/jQjXsX3xv0niwAUah43LyxC6f6F49lnlIL9jlf1
 oRQnu0T5dbzkGRnkCujHAGmnhTxbt0xOn22igrvz1XH/z43+uMi1gunXMsznAkSkmpOJBaVn5AS
 Wq+jTm8AfJzSsWbTSP/Isn4DVwFw1mJ5a6/AsI9aiF5lt9Dwlud934AhXnSA==
X-Received: by 2002:a05:600c:c168:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-499aa17d30cmr252497595e9.7.1787236993755; 
 Thu, 20 Aug 2026 07:43:13 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:13 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 01/11] hw/ide: reject an out-of-range PIO transfer window on
 load
Date: Thu, 20 Aug 2026 16:42:59 +0200
Message-ID: <20260820144309.835173-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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

From: Denis V. Lunev <den@openvz.org>

ide_drive_pio_post_load() validates end_transfer_fn_idx but takes
cur_io_buffer_offset and cur_io_buffer_len straight from the migration
stream, so data_ptr and data_end can be placed anywhere within +-2GB of
the 131076-byte io_buffer allocation. Both fields are signed 32-bit.

The subsection loader consumes every subsection present in the stream
without consulting needed(), so a crafted stream can inject
ide_drive/pio_state for a drive that was never in a DRQ state. Once
data_end is out of bounds, ide_data_writew() only compares the guest's
pointer against that same bogus data_end, and the resumed guest turns a
repeated outw to the data port into a controlled 16-bit heap write.
end_transfer_fn_idx picks the direction, so the read side of the same
code path leaks host heap instead.

Validate the window against io_buffer_total_len and fail the load. The
subtraction form avoids overflowing the addition.

Reported-by: XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4179
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3738
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 8190549ee8..0dca2b5c52 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2898,6 +2898,12 @@ static int ide_drive_pio_post_load(void *opaque, int version_id)
     if (s->end_transfer_fn_idx >= ARRAY_SIZE(transfer_end_table)) {
         return -EINVAL;
     }
+    if (s->cur_io_buffer_offset < 0 || s->cur_io_buffer_len < 0 ||
+        s->cur_io_buffer_offset > s->io_buffer_total_len ||
+        s->cur_io_buffer_len >
+            s->io_buffer_total_len - s->cur_io_buffer_offset) {
+        return -EINVAL;
+    }
     s->end_transfer_func = transfer_end_table[s->end_transfer_fn_idx];
     s->data_ptr = s->io_buffer + s->cur_io_buffer_offset;
     s->data_end = s->data_ptr + s->cur_io_buffer_len;
-- 
2.53.0



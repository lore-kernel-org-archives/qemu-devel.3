Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0596FD116E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 01:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOQwJ-0005qB-E7; Wed, 26 Nov 2025 20:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1vOQwH-0005pB-SO
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 20:36:53 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1vOQwG-0003sK-D6
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 20:36:53 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-29806bd47b5so2069105ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 17:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764207410; x=1764812210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YTrJ4dest3PTIWRkTrI30rtYRdWW+ShxdHGiIrKEsfk=;
 b=Ev7AgKnAt/BW/lZytqnz9owGwXN2cDPH9qsXrlOoCm8VJkgCzjZ7VeKxHNwA8KvV1R
 n/Pbehd6Hbo7znTjyPn63HwybcUywHdqMYiZj6erNBZFKX8a1NOYD8bbaQRCkIOnLAol
 QJwnJfD+tSh7sI1WVEiU6xyyiG5+ROUP30d5gTvSuYyQZMRMSblvBDFag5FsnDTg2eGH
 /TeAjHiOoSR27v8TRZoV+hjexHiGdoIiMvXhd9uqbPdFgBzK2dnZqlIKLyS7rq2wREtc
 x1wNKDuvJ8ujWrKqGSr1GhflwIJt2n8Jj+9qJk/uAfyQlSyf/Kb6WTMnBwrL+Qs+gpxb
 S1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764207410; x=1764812210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTrJ4dest3PTIWRkTrI30rtYRdWW+ShxdHGiIrKEsfk=;
 b=dhfGNzlCVfBUZAvYWBMR9oEozCRyDBa6W/irVV9jpqMn6BkGTamlekQnj6hmsgRW8T
 IO1QT0MeJ6QCQ4TT9D+nMORdrjMWwMa37o1qru6jL0cDPtawuj9F4dA9AkPU5Rv6kQJY
 1yHAzwkrbKkNot7Nt5BN15tfGOAo3LDZD7rhfSYsD7hmP/SK8lLYaw1KDDFvhSNj5JDR
 wAvHpj1J3S1fPX7uABIMGFqmeTn3tQn52D/uwp0T9vPyQM7Ydq4QzIdaOC1TdjDdAg+u
 Fs2bjcNVVRpaw6KfRVoHa70hvMYVweB3VwhjZOAQ74Z0/od0X+n8RPrC2DSv+OrOugaY
 2qpA==
X-Gm-Message-State: AOJu0YzbGewKgFxm+YPfGoTlfgGwEILtWzg5MChHhc1LunX1WAYCc6Ju
 7sLl+vuMsS8nY4FVhKHssdS7ORbXhoWKSGHdusWDR0KmzcJhrsMEP7hYMA61Nw==
X-Gm-Gg: ASbGncuF4pO7myymrm5or2D0hQ/nrZZlhf8o+B6bVII/l5nPW3Rpa67suL1m8OKMXm6
 zeEMgd9TiEz109ze+iQ5/pzelbs0nCogttXBQJIYLBZWY6i2nbMmmTtMq9savUMvYSTfTsuOiLz
 KVlOXKGWFJgreL1s9QtZ262zgCUe7OUaUs9VUnCPg5/3R+mVxrRQymJVKzvgGJpuDPw0B0ql6Q4
 kRMsJ/Jqb4r3x+4zkj6GBVrXLxdE4S5mxlefn5QfLtjPx7ySlwPUyPohKTafzF/jY0rFWbzPAFN
 R8FBC+eUbSi4lPhxtmWA/Sx4tW4dI55D+ya0ZdoOQpdavGch3JvmjdFSPwqJXw2zMwMcgBe2ke7
 aj0KaD4ysM5aCW+lgq6EbDoG4RE3poEifP9DG2Fwb10M8Qob/NZKFTp2OELMoYysllfI7pjxQjp
 2gTzoAZ5j+KHIOOGQVjlAdHasj4qc9ic1Ik/1o9KIGQiQ=
X-Google-Smtp-Source: AGHT+IEOk2xsFMoPXMQ0dslnaM9XlrHi2U2VOlLsDmplB16w7c+3/QxNmiqDI1ah5HzTRiPllJaXSA==
X-Received: by 2002:a17:902:f707:b0:292:fc65:3584 with SMTP id
 d9443c01a7336-29b6c6a667amr232360385ad.50.1764207409611; 
 Wed, 26 Nov 2025 17:36:49 -0800 (PST)
Received: from localhost.localdomain ([202.131.248.108])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b25e32csm209773185ad.53.2025.11.26.17.36.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 17:36:49 -0800 (PST)
From: heropd <munkhuu0825@gmail.com>
To: qemu-devel@nongnu.org
Cc: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Subject: [PATCH] htif: reject invalid signature ranges (end <= begin)
Date: Thu, 27 Nov 2025 09:36:21 +0800
Message-ID: <20251127013621.66082-1-munkhuu0825@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Prevents huge allocations and crashes caused by malformed HTIF signature
addresses.
Fixes: link to issue #3205
---
 hw/char/riscv_htif.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index a78ea9b01c..aa205c84c0 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -170,6 +170,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                  * begin/end_signature symbols exist.
                  */
                 if (sig_file && begin_sig_addr && end_sig_addr) {
+                    if (end_sig_addr <= begin_sig_addr) {
+                        error_report("Invalid HTIF signature range: begin=0x%llx end=0x%llx",
+                                    begin_sig_addr, end_sig_addr);
+                        return;
+                    }
                     uint64_t sig_len = end_sig_addr - begin_sig_addr;
                     char *sig_data = g_malloc(sig_len);
                     dma_memory_read(&address_space_memory, begin_sig_addr,
-- 
2.50.1 (Apple Git-155)



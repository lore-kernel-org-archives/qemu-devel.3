Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9754CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaAd-000508-S0; Wed, 22 Oct 2025 10:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaAR-0004qd-00
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:50:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaAO-0007dq-9D
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:50:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso4429485f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761144617; x=1761749417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3aV7y4YcVZL2/9uqMu4LmeCtyRFSnBcj1NtFojSaAQ=;
 b=F5BGJxY6PIsVk2xqL3PaMVH5zoEIeUyuULxKfjUXLNW5/4v9gfdbtO7Zmh4RuM2S2L
 PmBvq7LVgAqen7k/YmN2Maei/yVGEM+dQyl1oH4yXGkBsyD27o8aEmZ52hc3LS3iUkGs
 Q3kfSsYJDjvK/VtsBwuoeb6UV1IVkVmrds1HQdgjIAdCTCuCKR0NWy13DnYwwTtaozZW
 4rjwTBm4ol8zdtQnkWmE3OGQ3M8qksxzz+xOjz3S3frJ8jKTPLpGfCYyQq/Lp3v1AVMT
 eUajx0Rlti/iLc29NNxnjV5YJp7/I5LB6xx3YZOmfF1L77BDcu7Lsbq1R4GDeDNx1Kcp
 k1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144617; x=1761749417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3aV7y4YcVZL2/9uqMu4LmeCtyRFSnBcj1NtFojSaAQ=;
 b=G0rRDe/IRAxgIkAhs3o51UiXdhXSDbjH1ol8p3trpKr+PZlm4X1vrPLAbXmtzjXDQd
 XVZSuX9xdbf+uj6WjfZ201VXeq1O3r6e+0ckk0RtyX6k/dVZk9Uar52sCXp10ZNXBftZ
 DnJHiY4f1HPgjktjMK/YP/EUosnZQqxSF1xCDGGGY868d9Q0JyxA4b2olAzaqVd9rudb
 u674ukImc+f9fudnm9h7q7d4T35YqO0s1p5BELOIhGnc/8tKSYUW8P6F5p4jGvUO0cHJ
 6mRJ0jVW8IjmvHuDREDHvxbCfkEWZztRD5pSCMUt46K9Uv6sHORGaO0EfB7YGLxLZlGl
 CzGA==
X-Gm-Message-State: AOJu0Yw0ThmV7m02Legk4BdD0zesuU/5xO5GoLmtSZWB/CCbnonuoo8m
 9wlQnFIncUSjpq9X78bvxO6jtjPKB15peZIV/KSE1hsLLI6+GgB0FHcPHvgyMj8eCeAUPh9eG+5
 /kw1QaHw=
X-Gm-Gg: ASbGncsOj4TcaG1LKjGxocsAkItiTloLMoU3L7EZHzSnXf5rtjlQYbCazznNpCiHjy0
 MBF0Zcrpj+DZ6qNZus8K9rSvfHsynM5kYXBrfe6QnYv1xtQ2iUZ23a1eBmGJadq17SHdpZbvfiF
 Y8+JSjyK9I+QmNMNWfBY1aGERTWPvEYYYl0FNMrkMnGWkS8TI/twtCWDMGxo8iXtDh7Mo+YmdmO
 TpNxAVJHlUowzchcmbV2VYMdPpxmqWPcVj7LSb9wyO+9+pPTlrLrUlvpLnvH0u5lOsX+xF8wd68
 vIDG5e8waEpJhx8MOJvjjG5ifdILEsVqK1l6G5NRlkz+rq40exqLGO8wJBShI9SoHjgeAlu7rR6
 URbRl2CFYiGM1SnxOdREao4p4jquvNCRvVUij0jKkXTp8lUOmT39YgDS9NMneRXig2pyhCC9CRY
 rC7QlyA3cW1AQJWEI+bbn507J0D9tLv+YkAwsNq0KPbyZe9tpuig==
X-Google-Smtp-Source: AGHT+IFtC5ILdVfHZKF11kQmvgILa+PVC90qpZm8g7o2bLT5cY+aJy/iQu3+iXKd2by/EoBpYA6vAg==
X-Received: by 2002:a05:6000:4b08:b0:427:526:16a3 with SMTP id
 ffacd0b85a97d-4270526183emr17023075f8f.29.1761144617270; 
 Wed, 22 Oct 2025 07:50:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d4b923sm37094015e9.14.2025.10.22.07.50.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:50:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] chardev/char-hub: Retry when qemu_chr_fe_write() can not
 write
Date: Wed, 22 Oct 2025 16:49:01 +0200
Message-ID: <20251022144903.74612-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022144903.74612-1-philmd@linaro.org>
References: <20251022144903.74612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

When qemu_chr_fe_write() can not write to a backend and there
is no error, it might return '0' to let the caller retry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index d0967c22336..4bbde9fb033 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -65,7 +65,7 @@ static int hub_chr_write(Chardev *chr, const uint8_t *buf, int len)
             continue;
         }
         r = qemu_chr_fe_write(&d->backends[i].fe, buf, len);
-        if (r < 0) {
+        if (r <= 0) {
             if (errno == EAGAIN) {
                 /* Set index and expect to be called soon on watch wake up */
                 d->be_eagain_ind = i;
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D072DFDEE27
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxTN-0001fR-Vj; Thu, 23 Apr 2026 13:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSm-00013d-5y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSg-0005W5-8b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so32292605e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963812; x=1777568612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd00qZcL8QVm2gA5t6jS3nvHyVAnt2EjJSsPobGZzWM=;
 b=ws26ag0U9xuE4Qh+ouOUQiLgaTM0WT44guZ+IUvbWUbmM0dMPu1P6hXNw7SzZmoSgo
 bkw8fFnC39V4QpUhYBax+FeD2zpfL1+x1uVvZnSFVwDwpPO42sjR07s4yVAykkEKCVQJ
 yXJvfxxWz1o1lKeMz5CK0JfwAbwMJLTWWq3+SXW/Pznvf4xgUhog+0ZHx6xltoGW3Bi5
 vKqNgXa1zFzuItY9pq7fwx1nIzRIWeikwOaZAfOrOuLshqdL3DTat6VbCCD4fXDVKjQn
 duCT050Ujg00fyRphoW5gyDxOSLc0I0GBjkQiPZNsPJyEJfzv25Shq3AzuSQK8mfUxKY
 /6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963812; x=1777568612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hd00qZcL8QVm2gA5t6jS3nvHyVAnt2EjJSsPobGZzWM=;
 b=f8Vi0HDCkOcC1KGDvuVbyqTYG3vXx0cL5U/C7huzSts7vE9KxX5xEyyRCgf+navAD+
 8Xx49O7/GELWxeCZ6dLoUqRsgcOyKaUZgiV9FHsCrTFuBtF5IZLsEpU72pW5gsIKyQjl
 AlGf2KxmozRiTy2Ztghs7gCAyPud0tx0vMft8kLf3W36ZcUXEMLLphLzEHghL6pO1SXe
 3DRB0Vfoqy9hhQKnRabcuca9khrwIedhWFoIxegsq5WqtdygJBcibwY2YUnYk+5a834b
 DxIwZf1XB5MQnrO+Sr0+oka9NFhaDHBshBRT175Q8ej+oBz1J21LfTWiUIoylgVLU46+
 fFmQ==
X-Gm-Message-State: AOJu0Yyy3qqcs1dQe7iUN6aiTNdnCZL6j1CIGew/e6ayae57039/Xaar
 aox4CBLokopoq6ecirVFoZERf3MWfTNb1gUn/1Mr+E/DsyFR2LQzwin8iCihadMBNo52NO9W2xC
 JfRgrT70=
X-Gm-Gg: AeBDieuZCW5kx6WpbMHp06quDHQsZPeRTJIi5zr7ggsqcr2q+SLxwjbUnpjdwYUjDA/
 nODCeD6vvaitruyCJj0DEGI0c/R6xvjSrAGeqlXSEKqjdmRMEkjgD7OVUK1szsHe4AbL+1IWBgb
 TPxAmtdUB0i55/NU+Q6XlVmED8BNOd2y+z1xD/RntKUzw0E5gkg610sOBgf+MNdXFdZUaykgMVF
 GpUHD3ce5rZ+IV1d7ydSdFwtPqR+xQHPNmNjanS+jYG2zqEX/61xg20y71E9swwCvBpfrWCeREt
 hW6o/inKZPS/UJPKXl4EdqOI4m+3boRW95v5hBnbGTz7V7vYAjQpZcWCJbkKLZHqSp9k9WZDukd
 YbwKv5WnKJrRWbTVfonyZD00kLKx1hCp6JIHUot5YhXS7Oavx3cVMnF2o9yjvkVeI6GMayb7uz0
 JWzwz0THHabh1t8nqEDPBROL6x42KY7BWzXUEKsFGABUaRakJ1nfoySIuBzrxb9mn2KjQxigXFb
 GROklSFPpw=
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488fb8859ddmr367972995e9.2.1776963812496; 
 Thu, 23 Apr 2026 10:03:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d525sm51858649f8f.31.2026.04.23.10.03.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:03:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 08/16] accel/hvf: Enforce host alignment when calling
 hv_vm_protect()
Date: Thu, 23 Apr 2026 19:02:20 +0200
Message-ID: <20260423170229.64655-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 5f357c6d198..82cb3717750 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -56,6 +56,8 @@ static void do_hv_vm_protect(hwaddr start, size_t size,
     intptr_t page_mask = qemu_real_host_page_mask();
     hv_return_t ret;
 
+    start &= qemu_real_host_page_mask();
+    size = REAL_HOST_PAGE_ALIGN(size);
     trace_hvf_vm_protect(start, size, flags,
                          flags & HV_MEMORY_READ  ? 'R' : '-',
                          flags & HV_MEMORY_WRITE ? 'W' : '-',
-- 
2.53.0



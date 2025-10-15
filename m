Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FF4CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95kw-0007em-5N; Wed, 15 Oct 2025 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ks-0007eX-Lg
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95kp-0005Tu-AW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710683a644so7587575e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551055; x=1761155855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V994PTOYXfSbgqk3wPN+Ltq5BghnfXGjVQUSgxw4NwA=;
 b=PfK6n5cC7kfZ8L7hzCOB0k3Ql7/r43r2LdAnjYwGiueL1UntaJvckXeBw99fybVWqw
 5R1juUH8yOHsGiYK55eXu6r9PbibEPk74nXHMbHPteg5LUIL9v1H3DWJLV0LrSp7QGQ3
 cs4SpZ5yplgNfTIAnKxEeYdob20JMtFxegn8ZTYH4/sAbzkzQRN9cPWid92i2LV3UWeJ
 P4EXLkX4Qt2SCyUETOaNvsHm0V8shpExEtkRPu1loJp8IFAduv1FJ4jCx1TT/THU1XI5
 9Ne69qIbHMJ9cUz/fHdh00e8r0smxbwR0gdyjTwi4VlVHBfNL44rUhHT6QB8JNT6ndk7
 978g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551055; x=1761155855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V994PTOYXfSbgqk3wPN+Ltq5BghnfXGjVQUSgxw4NwA=;
 b=lF4GqNGpxX2xc0K8H2LIBSbWLxxJwInaL0kYUrWMdDl1U/TxuWRqhEZvXHzp1atyWO
 hBUfOilCyaJiwXc+jiuaFHkrLt2tH6Os3LEL/FqTkZW4C0KUH42Jr1Tmj143GyyZC6gG
 OPnZ/LG9dcf7EXSosZNsO4pNhw1XiRWhbfTsm45TQp94chGTvCSV6A9L6i+x8/qZrYQe
 M6K84xkTgG9ijt4cGWpz2jlyMl+yMkVVz/LNQzWKiyLhVv6uvfFMUJdicfJzap2K5obv
 s8aEAEtHq8YiPEMKyZprQKDRBAuq/vh+fMXnNdK8DDOVue3Dvkq3A44Of1TJSY6iXGIN
 QFkA==
X-Gm-Message-State: AOJu0YzO1/+swQjzbvzvv039Z0rACENwGJ9zVaAsygSAW6NvJQWQwlFq
 CVyRzFT+haMVadB8PSekLGcitsHqvwSg7wY39n9OzGhw3/CA0bWhgyhflVmj5S84BxBXb7NeYNX
 HEuDMS2j7bw==
X-Gm-Gg: ASbGnctK91aqka25imeVCGG7sFZr90RI2yKQrswzXyhfgrl2TA8++iK4O/9YqJnHUfR
 4xPnRWx3nvoErHv4JRoQ3uSRZ7yCHHsaWmUozxIMmOyidF5W0/SOnMm8FyCFuPl0Lds4LCGP2xL
 ZdX9nX6EGkfdW4HLAVK2w/6Ccyg+/VJS/U6xaidFr9GPsd2/KORuHrOdduZHBp1dJJvJb4aKCVT
 yQTZ1SBQM6ojqIB+J+oGk7NjUV0oQ4OKUvluKzWOdgECinteMpEEpvAzkndmCm4qJEQ9Bht2Yzx
 ShYfvEnLGm+LzgIS1OQDVVsBIYTtaEC9oVUyfTIMJOmxSud0CTtPQQJkWlE0lHOmEg526PJwuQJ
 Qz3d3p4YKrmnlmDgOj1NFoBYtY7UMWzDPtemPxr98mK6dapl0dyF1kvioHrTdPnNjEqNv+EfYYs
 iUfLf9TL87gxpvpccpQS8=
X-Google-Smtp-Source: AGHT+IHgD0ggpcN351iqvcfnspHVYiaOHvOLpFhBdxDsMBlyEHJ7wRaPvmsI+ac1ILSh1cG8D1+zKQ==
X-Received: by 2002:a05:600c:4f95:b0:46e:6339:79c5 with SMTP id
 5b1f17b1804b1-47109a227b8mr9955865e9.5.1760551054798; 
 Wed, 15 Oct 2025 10:57:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101be0c5bsm60632615e9.1.2025.10.15.10.57.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/7] target/microblaze: Remove target_ulong use in
 gen_goto_tb()
Date: Wed, 15 Oct 2025 19:57:13 +0200
Message-ID: <20251015175717.93945-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175717.93945-1-philmd@linaro.org>
References: <20251015175717.93945-1-philmd@linaro.org>
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3dd74b021e8..b93a40fedbc 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -116,8 +116,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
     gen_raise_exception_sync(dc, EXCP_HW_EXCP);
 }
 
-static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
         tcg_gen_goto_tb(tb_slot_idx);
-- 
2.51.0



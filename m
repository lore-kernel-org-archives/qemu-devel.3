Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F62E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzW-0000Nq-ES; Fri, 10 Jan 2025 08:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz7-0008OH-MY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:36 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz5-0005di-1J
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:33 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so3206444a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515409; x=1737120209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpICeKmMeYnALi5nXUee1KCr49oIbU3BKgAvEP82Pcw=;
 b=eQwrmj4gTbyyB6buPpOKgfgCETpZ+9WATWHjGtPMfRkK2vj6qzfRXjZAj4oC472cU9
 IXf+5HTplMQMkT3PeC//DvRpgeSQ1b38Oq2P2BQhVdhdRl/iROr3KLINkPRbpX1txayR
 qkfx+35iA+ujN16rIlg43QhM1QSMczYLvcgwORaMn9tthNnFyGVy6za4iHfKZ9eDlBYl
 e3nmAvniYgmAjZuUckmQL5h0yoZ9cEtfMvPGCNxnNXOygkVjUD4K5FeIvOaNgrxaKRug
 zIjGKo/bgbusQC6STgLkRKzJqasHODVm7uJK6ZGp/0vo8ezTog7DVyl9dsec7dIDgp+3
 uCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515409; x=1737120209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpICeKmMeYnALi5nXUee1KCr49oIbU3BKgAvEP82Pcw=;
 b=RfOUnmOcQD7mokOhch1Ll4kdOmlPxXkqTOCF5ySZsYGHFnygnfHrfewAwKqc7ARwju
 aeRzMgbV9VBMe8oOnWjjzLosg30w20Qqgh/Uv8m5gSXlV4Y6oOueqIPb0THwQJh2bgbM
 ysMJzb8dUw3FwnEh0GLEqsQni6PpYX+QUQDrg3Rn2ymp8FEC9oT9LEhLlrC1opThGD3G
 64Y1Kd1I2Qxf1egqE1j9nQJUtOj8gReH1eQo2ijuZRPu6VkA+6Ks9LmUy3E2IsmfFD/M
 odkE7H8RxpWK1JusuYtYgxvMPSgOnTrKxaByHgCfXOq9+v3vDFoJWOqLtruT+khwuPye
 38GA==
X-Gm-Message-State: AOJu0Yx9SJh4LsH4EyHzrLU/Xyjnf7F2o180NG6Oguv9v5wuDK+pDFYB
 +uOoLVjbfBiAsjuMN/WPfLjZB2Dw4Ct0zJ0Y3jknVpeiJQkwRAxmUlMEqUCNfeo=
X-Gm-Gg: ASbGncvTvLQERQUInlwvncgVQL/h3mX9SDvq9ccQUt39j66fB0gBglu5snPDPA/nl5M
 YgjJqgQIoxehxcvyTkNdBd0VN47F0n2Nj/pf4v0bn3mq50KVxNvQ1OhMM52KD+NI1RhS+yYB8Wx
 gnQiHjQqbUGImeG02wFxW6NJ40Qd5Psba4AuQlLMhR9oynQQJJtj+qS129UGU6v/DPh68P9pE2g
 mEQfidBL4/yloTNzkJHXklkMT7Y7HfqHVGXUZfy2Qat467+6PMg4Bw=
X-Google-Smtp-Source: AGHT+IGaDXQeiRr/23scJQTyk7g9DEZIVkR+IxpcHwMfXLAysMQZbQvm+ibsQDgDIjiL5Gz4lb6A5A==
X-Received: by 2002:a05:6402:3888:b0:5d1:2377:5afc with SMTP id
 4fb4d7f45d1cf-5d972dfb38amr9630561a12.3.1736515409327; 
 Fri, 10 Jan 2025 05:23:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9904a55f9sm1594282a12.81.2025.01.10.05.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F0885F8C8;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 16/32] tests/qtest: remove clock_steps from virtio tests
Date: Fri, 10 Jan 2025 13:17:38 +0000
Message-Id: <20250110131754.2769814-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

In the qtest environment time will not step forward if the system is
paused (timers disabled) or we have no timer events to fire. As a
result VirtIO events are responded to directly and we don't need to
step time forward.

We still do timeout processing to handle the fact the target QEMU may
not be ready to respond right away. This will usually be due to a slow
CI system or if QEMU is running under something like rr.

Future qtest patches will assert that time actually changes when a
step is requested.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-17-alex.bennee@linaro.org>

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index a21b6eee9c..2e7979652f 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -170,7 +170,6 @@ void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();
 
     for (;;) {
-        qtest_clock_step(qts, 100);
         if (d->bus->get_queue_isr_status(d, vq)) {
             return;
         }
@@ -192,7 +191,6 @@ uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
     uint8_t val;
 
     while ((val = qtest_readb(qts, addr)) == 0xff) {
-        qtest_clock_step(qts, 100);
         g_assert(!d->bus->get_queue_isr_status(d, vq));
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
@@ -219,14 +217,12 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
     for (;;) {
         uint32_t got_desc_idx;
 
-        qtest_clock_step(qts, 100);
 
         if (d->bus->get_queue_isr_status(d, vq) &&
             qvirtqueue_get_buf(qts, vq, &got_desc_idx, len)) {
             g_assert_cmpint(got_desc_idx, ==, desc_idx);
             return;
         }
-
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
 }
-- 
2.39.5



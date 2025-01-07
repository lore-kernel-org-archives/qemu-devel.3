Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D65E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCqK-0006Og-88; Tue, 07 Jan 2025 11:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCpR-00050p-HJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:18 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoX-0005ud-3H
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:17 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so178688605e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268739; x=1736873539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpM6m6rbJjz/cMmDUZY1x5tfWrWucIQIPNslhUNIhio=;
 b=Obyxev90yOp9K+tU0BuHp0J2Bi7Xdo/iGYIsGbOxbAHYRlQQ13BYRCC9lnjKBUQFsu
 OK9jVd/RMJdEOZ4MPqqfNQdKjNnivgIgzYzFnJ9qp9sBVxoV5y15fgzBpkDECHFw8pJF
 SU5JmtOneGiNbmoncsJyPWzbj1fu4zs8Ra/GgPsyOPuGFixvlXUFAiYUJgPQ3bfUTtPp
 UF3es1sbfwBgQfDIcZqjovAAlD+HOS4/iq4bf9nyeoD/UB+kNQWVyXwtff7qhVvv7AJH
 3Y7pEFaHfRLcGoXqo9IjG6Q8yWM6+7lq8L2cjRp1Tkx1KltSJjuR65HmqoOUZBbXL7at
 cVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268739; x=1736873539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpM6m6rbJjz/cMmDUZY1x5tfWrWucIQIPNslhUNIhio=;
 b=e9hgZfr59yWQ97wkCWWJHJ28HcnDdfpAUzZwQuGNHmCMy4x566ZhOHrwxEP5Hu9M4m
 dowMtcvKLLCDxnmOWQUFLQMk7Aw9LvPsXFu5ze7YLlL1YsfQdFt/lHbYFg7zEk3H2Vs2
 fpvrUXhaMKk56uEbj3VddVaWxZaQhmZtIBEaF0EVb7DlIyI1tmQwj1Klib5SCkVZfQht
 QaL+cKlXK4UJpERvFHw9N6JUYdl6/5hUI8UCm4pUAnOsdsoG0JH/LodbJ4YhjiBpc/sj
 im28cDEkyT7WWihxfhZyeqcgA0T2edBA0zzquvc992skuwNtHV7fc1vOdc8AmdgHIA5M
 rw8w==
X-Gm-Message-State: AOJu0YwN0RQ0gbQD6gpV48za6keazWPaPq3BqgZcUlOdMCNHFPLfZ/hF
 9Lfk4AA5j6+PCOWIkHDzBYGZD4iX0t7W6nWJYbMExBh+7zREcD5xQcRWfSFz4Ew=
X-Gm-Gg: ASbGncsGk7siAvsK7B0W6stfrJ9jLgTPMGViOO1wIz8DXTdRYr7w8BJfBuf6NU5Wp61
 VDODBUSVHQrl0/3heoTsCljirLw/U96P0CzVoEqnJSknDMfueIMHY80vc6cOHO9ehKNjqZ6tFtE
 sJlPV1Via1X/GLa8YybfIgT2ZHWY8fJ3B8TdvCpvo5xGvAYyqRgI9+9TNm0UmQfq5tM1uidjmI6
 5BceH/r8yN+xLUEKYsDvD9Xl/17pAYJUkpi/+P4bVP16Evwtur+vpU=
X-Google-Smtp-Source: AGHT+IF0523KCs134XApVCOqRgsloHn+KhIomI1XUbcSYKL4dgq8EZTCG5gtyABiAk7cB+ZJNxv4hw==
X-Received: by 2002:a05:600c:1388:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-436686440abmr513224965e9.11.1736268739582; 
 Tue, 07 Jan 2025 08:52:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847263sm50585906f8f.50.2025.01.07.08.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 78EC65FBC2;
 Tue,  7 Jan 2025 16:52:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 16/29] tests/qtest: remove clock_steps from virtio tests
Date: Tue,  7 Jan 2025 16:51:54 +0000
Message-Id: <20250107165208.743958-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - s/with/when/
  - drop clock_step entirely
---
 tests/qtest/libqos/virtio.c | 4 ----
 1 file changed, 4 deletions(-)

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



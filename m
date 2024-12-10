Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95682E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL7C5-0004ev-MQ; Tue, 10 Dec 2024 15:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL7Bp-0003o4-TH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:50:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL7Bm-00036l-Sa
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:50:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434fe0a8cceso19789305e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863837; x=1734468637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zpB1ID89GrvPttzETXvX6+8YD37TqJ7koaKt36/QMg=;
 b=atDuuNMGw6vq7t5gLgia0E0cUJd+hSFGhK/BKG1EroUKmOaotw6WG9uCJ5kZQTTx7N
 a+4d0w3E5H6UyMSLJBWM+kLodNVG3uTAPdXIf+avvGpx6OFoDWsnLCrzxOu41c59joGa
 jRZ1Tpge+Wql03Cun6r3bOMRCoKTZjGtdH2+4+14yqjmZJqnqnuTyst9kWV3iFWI7bsH
 0c73oSw7S+hARwd9sgMEqfJoZJ9fnrmtFtMONuIqn1ywDUNaVyN45Z3V0Gwll5NgbAlM
 3bcQuTfGSrCCsaa6FxNQ1Lf6Os2z6RzrDm3orZg6E31j7RdnoeF4T8XL0Szj2v6t44Zj
 L92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863837; x=1734468637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zpB1ID89GrvPttzETXvX6+8YD37TqJ7koaKt36/QMg=;
 b=nFkTSPYQMvzd0J1/wTZqKOjK7O5M5e65zdK7qAUWBgPw9JlcE33z9QO5RflUN6Vb0+
 gShCpsi0So2ETeP7GGI3Z4+NaX/SwiPQjM3DYZlp1gCYTiHSBj/CH08l/clEJe7IqcSO
 5i9YtoLXZuopTAVN17p8lmgOpBI9q/6G81MnIf00elZaZROXj1UQvr3EXJVtAbNMGR0O
 LqswRu5v7jOOxYc/n681TL41nAimTrM9Ze/+uwZwF118LPjgJ2+imPopah9lS1LXbevq
 Xf2GrGoS4ECUZbalZFHtRl4/nhhZsyMO3XUY88YI/jIaTHjr/97GmS3x8r6CUmUbfft0
 K5nQ==
X-Gm-Message-State: AOJu0YyQvCtN45gariCILQ/BZU5MmdyiLt5besL8g29WFhs065YQ4/np
 GxeCAs7bsHhk1KWodIT3wLcg7rvi1RfHspw69tehiV4fncmgzi6jw2ttdGi/FPQ=
X-Gm-Gg: ASbGncuOWSQZsEevLy0qEgh2c/gjTI4jsc0PCaQpgjrjv3bum99uAXMWFnDkNlKggY1
 wa2bOtGlKPSKht1BBohrzMXYN6c/HLrr+qpX1bvf9SKAN5iDTir+d4fo+hbSiZaQvWhfeTBxGmZ
 +GPbXv9QvEuEL125kZQ98DHNf9H5h2/zqYKtNbeaD0AuDE4E7C6j+A97zGh0UGIi+CRXGlW8mx7
 Z3Je5XEaytJCGS9pPo5pYpZDcYI67aveFcAjN7XVPy8sOxubsmW
X-Google-Smtp-Source: AGHT+IEwLqWJ5FbO12N2AO5J5hliFT2FMAnni7lLNghg6dFlG3oHZgSdmMmwQaHxoewRItVbW8ROvw==
X-Received: by 2002:a05:600c:3151:b0:435:1b:65ee with SMTP id
 5b1f17b1804b1-4361c42c81fmr1674215e9.24.1733863837032; 
 Tue, 10 Dec 2024 12:50:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434ef283e87sm127814445e9.39.2024.12.10.12.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:50:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2146604EC;
 Tue, 10 Dec 2024 20:43:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 17/20] tests/qtest: move clock_steps to after checks
Date: Tue, 10 Dec 2024 20:43:46 +0000
Message-Id: <20241210204349.723590-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
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

Potentially the clock_step calls could be removed all together but as
we may implement async behaviour later lets just move them to after
the principle check for now.

Future qtest patches will assert that time actually changes with a
step is requested.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/libqos/virtio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index a21b6eee9c..64682e66b8 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -170,10 +170,10 @@ void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();
 
     for (;;) {
-        qtest_clock_step(qts, 100);
         if (d->bus->get_queue_isr_status(d, vq)) {
             return;
         }
+        qtest_clock_step(qts, 100);
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
 }
@@ -192,8 +192,8 @@ uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
     uint8_t val;
 
     while ((val = qtest_readb(qts, addr)) == 0xff) {
-        qtest_clock_step(qts, 100);
         g_assert(!d->bus->get_queue_isr_status(d, vq));
+        qtest_clock_step(qts, 100);
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
     return val;
@@ -219,7 +219,6 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
     for (;;) {
         uint32_t got_desc_idx;
 
-        qtest_clock_step(qts, 100);
 
         if (d->bus->get_queue_isr_status(d, vq) &&
             qvirtqueue_get_buf(qts, vq, &got_desc_idx, len)) {
@@ -227,6 +226,7 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
             return;
         }
 
+        qtest_clock_step(qts, 100);
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
 }
-- 
2.39.5



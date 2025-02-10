Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1C6C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSR-0007ww-Id; Mon, 10 Feb 2025 11:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR1-00047H-76
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:00 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWQy-0001UJ-TN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:14:58 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab7d7f0a2cfso27744466b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204093; x=1739808893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s99h8qs7nLU97pBsNxE2tPpHIjsUUYJGtsusMGsaa/8=;
 b=BD5ea4PI8Dt8AolnwvtAaw0bICWxlybaFw2E+QaBGaaudQqwguh0lIY8LgUHYYC3WL
 jBgJgV/RW5V/GQ31KCJWxOlzQLJw9Djo3bVSIDo6a0O3qvvvFFnQSuwxUl9YY3etlqD4
 7yEX3gNn+/vc88cc8mRpGmUYLgdTmC7nKcr0yuc5wC+P1l+x4yg+fOvdP/tNwvIM1h68
 7Nhjr0ESMyZRyVVHRragmY+mg1G6JnCkxtAKg8Zvc7AyIYfoonsXluTrv7aAlTSB9tuw
 SNUM6/+ZETXSe5gwSEWvPe+kKKRtdIFRxqy3nPISP8FXlTHGW319Npsg2J/ACXoZeUEa
 TxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204093; x=1739808893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s99h8qs7nLU97pBsNxE2tPpHIjsUUYJGtsusMGsaa/8=;
 b=GjdnYWDFdDi1WeBWDX1Gub/XJc332b7NER9peO0RbMSHMjXIfuYvoSPafnL9JpE89A
 ueIFEvULkkcUURQxSRDfG9+EGqwKuPSsaTVWY+MBaEcN/mU6N9CW6qcar+q/4GYxTVoP
 pFh1+N/SwKSffjBK3n/PQoxyLPWMESPWf7eAiYMF/1SX8pymPxZoIBlqpDai+/XbJACT
 1CYc35uadDTr5rqYLUZaEToCUo50dBboy7lywhXbmki85Bc2GpDreYM8riKGAiQC3R7l
 Cs6zzrRriVcWhxZsU+VuAtqCvXmj+0r/Ql4CbS8WMfq/+g08a/aI56nmrEr4/OKs1X2x
 Tbbg==
X-Gm-Message-State: AOJu0YxYbz7g/d7Hl1wr8uAnoknRxlT/zNPuZ6239V6831p00T/6Wx9B
 YNhXBt3mDYalSRYCE9V2kmK3b99yB0ymm8zM0g/9Kfj4TS7wwqPWZfaO5gsuipU=
X-Gm-Gg: ASbGncue7z5rStU94NPMVqicPWDzio+p+JZx3p2kADUwj4xdpZhb+kSjYV6eaMsPKl/
 wy2oVzg3K6YVDKhOXpN6lwvxxmkLHY5olFvULbJocv5xW4gsjAUXfMxYR9rpteGxOq1e3P1y0ev
 qR0p8M1DKQNHid7RqHtox1eugmqxoCiK8w6uxnGvAZCkAwUIX82pvj9Dt3lh0hPzkH6ubNZbn++
 J5cVb+CSzpsr/1vBcpWCZeI7+K/WSoQuyS1mSllBIS70ENDjFXQhoNOGTw1GbM/579pzXJc/e9a
 ph7KMtdee+pJIBJXnw==
X-Google-Smtp-Source: AGHT+IFGJNL4/5aTq82tA2me+RItBC0qU0FUHs3T7zfmGdcDVC5cUol9Gi0CWxTbattkKHqVAxrH6w==
X-Received: by 2002:a17:906:7310:b0:ab7:6c4e:8e52 with SMTP id
 a640c23a62f3a-ab789a9bd9bmr1690898666b.5.1739204093237; 
 Mon, 10 Feb 2025 08:14:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d6acd8f1sm35552466b.50.2025.02.10.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F38575F9FA;
 Mon, 10 Feb 2025 16:14:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 02/17] tests/qtest: don't attempt to clock_step while waiting
 for virtio ISR
Date: Mon, 10 Feb 2025 16:14:36 +0000
Message-Id: <20250210161451.3273284-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This replicates the changes from 92cb8f8bf6 (tests/qtest: remove
clock_steps from virtio tests) as there are no timers in the virtio
code. We still busy wait and timeout though.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-3-alex.bennee@linaro.org>

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 18d118866f..4e67fcbd5d 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -173,13 +173,11 @@ static bool get_config_isr_status(QVirtioDevice *d)
 
 static void wait_config_isr_status(QVirtioDevice *d, gint64 timeout_us)
 {
-    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     gint64 start_time = g_get_monotonic_time();
 
-    do {
+    while (!get_config_isr_status(d)) {
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
-        qtest_clock_step(dev->pdev->bus->qts, 100);
-    } while (!get_config_isr_status(d));
+    }
 }
 
 static void queue_select(QVirtioDevice *d, uint16_t index)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 485b8f6b7e..002bf8b8c2 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -171,13 +171,11 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 static void qvirtio_pci_wait_config_isr_status(QVirtioDevice *d,
                                                gint64 timeout_us)
 {
-    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     gint64 start_time = g_get_monotonic_time();
 
-    do {
+    while (!qvirtio_pci_get_config_isr_status(d)) {
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
-        qtest_clock_step(dev->pdev->bus->qts, 100);
-    } while (!qvirtio_pci_get_config_isr_status(d));
+    }
 }
 
 static void qvirtio_pci_queue_select(QVirtioDevice *d, uint16_t index)
-- 
2.39.5



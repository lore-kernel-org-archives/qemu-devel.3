Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C8C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQL3-0008Uh-MX; Fri, 07 Feb 2025 10:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKE-000848-5k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:27 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQK6-0003xs-JU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:25 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5de4c7720bcso1090651a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942277; x=1739547077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UFLMzp9qGvO/TMJfobXhH747ty7fBk8K8S5c0aFteA=;
 b=kOljxhz4VbNtfTFeYvbgwiMvzXMLiNtH7LM/Z2jQ14plEOuRY6r56EMcP7x94Opf7Z
 3kJLTkaFcddZBZ+KJ+ZYY6WTZ4y3AAnHyUO5tSUyi/c89VfTdlnoJy8EOfHMRPuRjZhz
 1JOKaoK5fcDPW9+jMtbbvCeiBVs2oMiiKIfQhfUaWSt0Gl8sLKSLmBwJhPcZqpg58unX
 w3g0YFRa1HS641Sk/bE9y/5nRTfD2bkjJSFc504R4CZ5Ach+MmAw5S0+FxxNLcISwCqd
 9es6bEe31v/qRyJM6Jcx+2GzLtQGLthTLaiYVnTL2Q5ejGOSrOAJgJwgYo5WDRRceeCe
 TqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942277; x=1739547077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UFLMzp9qGvO/TMJfobXhH747ty7fBk8K8S5c0aFteA=;
 b=ifVa0h0kX2rXkygCs69fj+wBTG5wqe2yQQubFt7qVTn1v924b06iYia/bp6ApF2yAB
 Maw84vmxPucy7erB3wq6SqyOnNFxBeCxmAv3wIVEfNR/x5A8eV+qXXY9qp5mH0WA5P9x
 NkenWQStaYejFzJlfefluH02J3iKMUJecsG8NkNZ8KIyDywC96VLzDFlnSO2oQBShqIy
 StQMjI1HofwLTvww9AlD/OvL9p6Q0lZsLrglEMMEHRhNh8Y+2N7cdXLjRugYSEGCjy9Y
 5vdCKPQhOtdWVcZ7j9qqxsKj/50RnpKNkLJbeovUpnnkApo96hvmAYf5IM2+57Cmg9ND
 B7cA==
X-Gm-Message-State: AOJu0YyBMpvuFuu5PNa/Kqinb4SV7q9eHhXpppYd4e2/EIU96as86/yp
 ynDXwCf1DjF7nyl2/eAa+mAjl6nV3vz6ir0rG1Teu0MhNLJ6m5zHA8VDVz99UO8=
X-Gm-Gg: ASbGncvtmUMJzZvqoxaSLhLDpgTunZyH70muTgXkQOuV1pJx8fCKO8IRWbyDWJzJhvI
 L31oFnX2n/Tk8XRJk+Zm2JSvmq47cUEpTwVy5He9p798pWBqqkvXmhm4w/n4D7RCPC1nihf0xPO
 /SRLq6HxX5njJS9PnZ0B/20+2budSj5M8lCorXgNoweC8I880f1mR1qpDMhsdoZklj0Sgk/3vk+
 EjvZst5zv4GEDsH5EovysARDHI89k3KQ3W5argCj4EewVnWPrCVwXfjk9kVGTJy4Do07OXo81ey
 bW9Z0CCHimghlmUn/A==
X-Google-Smtp-Source: AGHT+IG8ZPiaiwh2i6Ruqhu1oc0MU7xyIwgymiNV7MhsYENzi9yUszwe87chpu9OFUlczf0Fx0mLcA==
X-Received: by 2002:a05:6402:51cf:b0:5dc:57a5:c414 with SMTP id
 4fb4d7f45d1cf-5de45088202mr4207907a12.30.1738942276558; 
 Fri, 07 Feb 2025 07:31:16 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de52712538sm325379a12.49.2025.02.07.07.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 924C95FA60;
 Fri,  7 Feb 2025 15:31:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 02/17] tests/qtest: don't attempt to clock_step while
 waiting for virtio ISR
Date: Fri,  7 Feb 2025 15:30:57 +0000
Message-Id: <20250207153112.3939799-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

This replicates the changes from 92cb8f8bf6 (tests/qtest: remove
clock_steps from virtio tests) as there are no timers in the virtio
code. We still busy wait and timeout though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix trailing space
---
 tests/qtest/libqos/virtio-pci-modern.c | 6 ++----
 tests/qtest/libqos/virtio-pci.c        | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

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



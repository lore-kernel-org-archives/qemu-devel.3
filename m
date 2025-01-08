Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05066E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV4v-0007i1-Sc; Wed, 08 Jan 2025 07:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUup-0000yk-12
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:12:09 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuU-0007KE-Af
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:12:02 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so263659466b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338269; x=1736943069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxu1yP/3MOgwjpgDAIBsvk/bOf2PZatULABlCnbMhrc=;
 b=uXYrHaVuiyTCf3oipIVMdLiNKXOw81kHVnb03ZUa1bsp7/gCt5YEDKn9Ce+KJmSSfd
 bckxVBdwyDvxSAneAJUKowTmJh63J2xoae7x4HZsmJwR2tkjCdDPyZbf1IbYM9iuSPEO
 fEsy2+8HsPb4BY8iCj8w7vqhEjlW3TFiGnsQRVfXiiL7PKQWTG2MDZCuOx1f59nrlqLT
 QAohDGU8vfQGIw4Fab6sbLNDevvd/jgVc2/ir6hjSyX323XPZWCm89MTVxHGlpekGqbH
 xzIRtKuNuQ0aOHCtfxh5SMBe23vLpWCfZopWYqfx70hHve0CB7dBW58EuI+Ugq7g0qcf
 Uqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338269; x=1736943069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxu1yP/3MOgwjpgDAIBsvk/bOf2PZatULABlCnbMhrc=;
 b=rjGg8Ej6Zk3ch+k9eyusRgXNQGEO5F1B7IAvZ6C1n8AnVsrWKBapCgolqtyDrUnIZ9
 IsVEttLfB9lKfR4tNF9plCulZ1wEhtVxaHVKNqVMiDXtWWKarkSHFQx7KQ+fJVaiZ1md
 0ssvanspAtV2aZ0Ta1kj30zRScyjmPEea5EE89KYNbtHRkXBNfl7YiSp9HE997oRThGB
 V03PqUGrZ4+sRMJwXokMLVJffWLVr/XpxbhVpeIGMvOy9kt6Lma5it/p5va1cNjhy8x4
 PY3CSG2R4nijqZYebj75+Z34E/Ahxw7wvfJh3TRhjvJeln4WJCt192Tvc3msKU18sFm3
 IQ2A==
X-Gm-Message-State: AOJu0Yyg2TKfrRAd77WsK84iItEOinbtJmo6iFqV0DW3ZMbvmZpnk8XT
 cAQozGpuswXxW+8AReg9Oy0EqcoQbo06cGrcBzbvqT+BU9PXPcBeO0R3ky+73Jc=
X-Gm-Gg: ASbGncsAkVIGPxFhrUlQnJx9qmH/msZ+16jlhkNC/345ebfOah96QaEHOvrjC8MEMk1
 VyeUwNn+o0uB1Pgprxzo1D3Dc3Pgs8hUDfcjqiVq4zJaTUU+5sOoXM3f0zQWVZa9F3DvuBwOAwh
 IW9t5Qrh4k+luMO1Yild9Bk21eRstVnlokUGirz4b//B9eaWih5hSIPlpC0GQK7SIQwT5Yqu5ky
 +WiKTWkIL5nx6XSXaV2XltBJstVHJahWa1Unswk1x7eVXvB94r4nsA=
X-Google-Smtp-Source: AGHT+IHjVhKDvYB92TptJyiNzvtHDI/2+YFtePwjSaHBWxD9Swwu+umeStu2yG6dTxlTmD5CunfoHQ==
X-Received: by 2002:a17:907:7f1e:b0:aa6:7091:1e91 with SMTP id
 a640c23a62f3a-ab2ab66cf8cmr195583566b.11.1736338266193; 
 Wed, 08 Jan 2025 04:11:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aae8be914f5sm2279652066b.180.2025.01.08.04.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:11:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2764C5FB53;
 Wed,  8 Jan 2025 12:10:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 16/32] tests/qtest: remove clock_steps from virtio tests
Date: Wed,  8 Jan 2025 12:10:38 +0000
Message-Id: <20250108121054.1126164-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>

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



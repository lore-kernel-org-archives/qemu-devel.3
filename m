Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A11E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwsb-0003Bh-NI; Wed, 18 Dec 2024 11:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwsY-0002wK-UB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:26:31 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwsS-0007qD-9M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:26:30 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa66c1345caso242702166b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734539183; x=1735143983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpM6m6rbJjz/cMmDUZY1x5tfWrWucIQIPNslhUNIhio=;
 b=TrxUhxUpsPk5jmnO61aIMx17VcbPXyVhtpinRZbwkJyyNXMZfbleBUzc16OE5xpmoW
 ie+6gSodM4fn9nu3ilVePh+WekbjeZOXMBpdxVLk3vjW1h7WNGOfoqR0CVsk6PrdGqkm
 9H5KO5A0Ww2PLRWuZEWR6myseAUv6lAA09D/vZvPbgOOlr67iNpCTWhHBmpFJ+8qdJV/
 jsWq1WM/p9mDkIPA94PZPBE92RjFQfal+PhFGEfo6+NfxAtc1OssIPyp3iY2GbvsqzQL
 5m4Xxe/sn+/oyqR/0XMk7MdUGK3c2Lr/MBZh2WQFWsSXu52E6RnEaT3krzgf+Jd66skp
 oLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734539183; x=1735143983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpM6m6rbJjz/cMmDUZY1x5tfWrWucIQIPNslhUNIhio=;
 b=L3hvGIBUUrfHBHOChWfYxSlagid/zhDoYb+uSg61Qm2nzHnDNIrHfZeWx240ozA3nQ
 i+sFQonR40dnFm+8Ng2actyGJ+dyIAZEVqZy4Cg7Zk4xl6H4acdcZyftr0cYIoTskaCx
 RyXynle0FioYr/RjVLlsOErozqOc0YbavD5JVs6Hd8QN/z8C77B17YRamWbHKKoaTCWb
 Mx9SPDV47Xa6w4nUdXdsi1Irsa0rAwfdCjB1Iic66y4DlaOvo0upIESJ3W5Up4RFXKzc
 Q1z95ckICmmLgth6qlZBleetj/mRQs7C+DULeKNmzzaLGq35JBz+tL8ljod8Y/djp1Fp
 Y24w==
X-Gm-Message-State: AOJu0YyWGQO6RP09muXOPmaaZcJAALJUBABWvDTMsS4EydkzgwrjqdoU
 j2So4XXES269RFcUNpg2mDaWPZnxUtdvyFfLlB+1mKfOvtrbUKaznIN++1e/qho=
X-Gm-Gg: ASbGncu79exLXCNUUdKvsUEUHdnIWu1HRhxS666f/UYten0sPibOdZDLc4wjZ68DBry
 OklXZBbcTblkPI05cP5LxxJGyqcKJ0g+tZxk04DiSmn0SDdwZpHXPVRNSrqUW1qYW8ZpOz5rr2X
 uSy4XkLDK5br3BNI0SWrxmHcuFtyYEnDnrSWfdaoSgLxJVS2+KVb5/JweUFBHGOAVm2u5AEciu7
 46RGa/n5me1+JeSDucVXpNCnLzRI6kdyivUeqZabytPBZWLs+93qtU=
X-Google-Smtp-Source: AGHT+IFapxkwVsPLPzFoFbqL+z/NDXwozy+vqNy1gcAdFchAqxOSbjpZ0BB+/d4JmJ7opndBPVhTSg==
X-Received: by 2002:a17:907:7e8d:b0:aa6:9624:78fd with SMTP id
 a640c23a62f3a-aabf48f99f7mr304528966b.48.1734539182644; 
 Wed, 18 Dec 2024 08:26:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab960062d3sm573350166b.16.2024.12.18.08.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:26:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C1EAE603E4;
 Wed, 18 Dec 2024 16:21:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 17/27] tests/qtest: remove clock_steps from virtio tests
Date: Wed, 18 Dec 2024 16:20:53 +0000
Message-Id: <20241218162104.3493551-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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



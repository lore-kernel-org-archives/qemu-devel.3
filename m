Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD51C3ABA5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7s-0004O0-N6; Thu, 01 May 2025 23:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7n-0004Cy-5y
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7l-0001Hs-Ey
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so1889997b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156700; x=1746761500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVk6lML4TjYWh+nQHo5STeX9xY8bJ23/rh4J7vefY5w=;
 b=YeuP4jFTO8+yZrDmuBuZR1z8/G4GmpBlVqkKwUONsagYeE6NOXr9xoyEv6tcxZZ0RV
 42ZLeCFO3jVs/p36+2frNUedtW/UWNo2/RiIAuZ8OH30gIiY5wooVvmmdZa56oCxThkw
 aSnR+4S5/xLBgX2l0auKgivGqYJx8mDDw/OfagNzyAVkliJPY/HPGZ8Cw+l/cPAUIzvd
 M8iBV4LJywzMWTjdN07NqsOV7EcbLlDbL/QIiEYzjTJRHOM1dDHesi7iXdg9+YctTqb4
 VDyvZA012YPmZVThXWMBcbgESTDxEyztRtYsykBB3SInXyLLcA7fxC0UojNY64xxXCKR
 y77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156700; x=1746761500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FVk6lML4TjYWh+nQHo5STeX9xY8bJ23/rh4J7vefY5w=;
 b=HsnVc7ovHUy0JorvcpvQbVFp5acKiQQOXj/utugqse9M9fT9mhZfebnVIx39K6YqdD
 rAGtV2nLAIedg+asuKNAxR0Btn/yYUCXqHVAqDDt17zJGL6ho5RK6+2N65OPEUbgsdrP
 AYyZ1cd62Jh6PAMAO82DaX08rnfxAK28685dsTdYeLT2EhHfmna/sGMXssr/IJyj0tnu
 0PON9bi78zPIHkTRP2E5u7Vg2FkkRDCm5c20v57n6LCnh65ttXNoLQJNLpDAn2Jdpg1g
 Ge2HApZmTaAbCXRv0VsDZbbBWDCvfFVKV3k8i/+x+yQX0dPvib1RHAlKPTDOXwTqoLNr
 r0rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnEoZ7HjphRIUiiCj0Hekwd6zRdemr2wnWBPedl734K3C/F8ir6Dq44vmhUJznHvwwNWRV2yRql/fG@nongnu.org
X-Gm-Message-State: AOJu0Yxl4cY0mV7qFFe03hxq8d1USiTgIJSbxxpPeDrQ1kaK7clRePB2
 QUBuMT6EbBIqdzpbIOGtDnHDlkOyTo9XTYRwYnFKK/S3QduM5WG7Uu0+9Q==
X-Gm-Gg: ASbGncvIchMx1lftGcgW1CY/Hu7lwwdWY5tEM5+Jrpvdv4f/TBEuGr1ns2cErU+6Yl1
 Gvdt/WGr14VHzrACOhE4UfC/Kv8tYk8KcgbicsKkZ8Do9+SE4m0EPOC5QD536bryJYhggR70qdG
 B8rVWPpKfg/3ZRicZBH61KfVk9aECWLKb7UybtWDdU0mxywyS1UduFlJN5pnU94hXSYljSICO5W
 gnIFPFApIrINyzYUbT8LdP5ogj3jiW5+L7rf5Kc0sQ0ByIU1ER0WeXihqrkZBYURb1ynmeuqn6Z
 7p7VB478hioXHDP3tqJtqHO3lbAr5fZZXy7SQ8EcWHvR
X-Google-Smtp-Source: AGHT+IHmkld8D+py6gnmKdOe8zpsSxUl8v4sfSXMbFeBb5+OGdlFT8qR9UTXUdsALUZUottTZYiNvA==
X-Received: by 2002:a05:6a00:2985:b0:739:4a30:b902 with SMTP id
 d2e1a72fcca58-740588fa8acmr1844283b3a.2.1746156700004; 
 Thu, 01 May 2025 20:31:40 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 08/22] tests/qtest/usb-hcd-xhci: Deliver msix interrupts
Date: Fri,  2 May 2025 13:30:32 +1000
Message-ID: <20250502033047.102465-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

msix
---
 tests/qtest/usb-hcd-xhci-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 7f801f8f1a0..2eecc8d9f26 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -48,6 +48,8 @@ typedef struct XHCIQState {
     QPCIBar bar;
     uint64_t barsize;
     uint32_t fingerprint;
+    uint64_t guest_msix_addr;
+    uint32_t msix_data;
 
     /* In-memory arrays */
     uint64_t dc_base_array;
@@ -279,7 +281,8 @@ static void xhci_db_writel(XHCIQState *s, uint32_t db, uint32_t value)
 
 static bool xhci_test_isr(XHCIQState *s)
 {
-    return xhci_op_readl(s, XHCI_OPER_REG_USBSTS) & XHCI_USBSTS_EINT;
+    return qpci_msix_test_interrupt(s->dev, 0,
+                                    s->guest_msix_addr, s->msix_data);
 }
 
 static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
@@ -298,6 +301,9 @@ static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
         qtest_clock_step(s->parent->qts, 10000);
     }
 
+    value = xhci_op_readl(s, XHCI_OPER_REG_USBSTS);
+    g_assert(value & XHCI_USBSTS_EINT);
+
     /* With MSI-X enabled, IMAN IP is cleared after raising the interrupt */
     value = xhci_intr_readl(s, 0, XHCI_INTR_REG_IMAN);
     g_assert(!(value & XHCI_IMAN_IP));
@@ -395,7 +401,12 @@ static void xhci_enable_device(XHCIQState *s)
     uint32_t value;
     int i;
 
+    s->guest_msix_addr = xhci_guest_zalloc(s, 4);
+    s->msix_data = 0x1234abcd;
+
     qpci_msix_enable(s->dev);
+    qpci_msix_set_entry(s->dev, 0, s->guest_msix_addr, s->msix_data);
+    qpci_msix_set_masked(s->dev, 0, false);
 
     hcsparams1 = xhci_cap_readl(s, XHCI_HCCAP_REG_HCSPARAMS1);
     s->maxports = (hcsparams1 >> 24) & 0xff;
@@ -640,6 +651,7 @@ static void xhci_disable_device(XHCIQState *s)
     guest_free(&s->parent->alloc, s->command_ring.addr);
     guest_free(&s->parent->alloc, s->event_ring_seg);
     guest_free(&s->parent->alloc, s->dc_base_array);
+    guest_free(&s->parent->alloc, s->guest_msix_addr);
 }
 
 struct QEMU_PACKED usb_msd_cbw {
-- 
2.47.1



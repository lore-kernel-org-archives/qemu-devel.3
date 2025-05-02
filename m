Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B30C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7p-0004Hn-UR; Thu, 01 May 2025 23:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7i-0004Bm-58
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:38 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7g-0001Gz-D0
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:37 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so1048739a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156695; x=1746761495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXIXb2faI/v+5BbstE/05iPFk2Qe+qxfYczW0aTjP9Y=;
 b=aUYea3c8I2dlaw39LJVDwNep4VuRVixYeAeN5FZPxgME7TCKIWQpRkQsgT1fw2UMtP
 8eyZ8ThpNRsZd9t/NAgXDOexQA1lHYtkRxVmM6YunAYbQz0uSHwR8lT/CB06YKQpfaIW
 iPvIiAk1MdCvCBCAwbs058GYFw5HHyUKMIcKAUHlIB16xPCjecUa0TgLnY6UR7NKJI4A
 18+WCMrWMKJEi00Ddj1hA5MdyINb+68LuIWahYpYLxb9e9oGFAxvJhx8mlzRGtztAbME
 dhanSqwiT4ut9oUOlyBEZjCtoUKRnNqelyznhUf9g1Bj/AuNXmCNoaH2QjNWjeH6D10j
 K5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156695; x=1746761495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXIXb2faI/v+5BbstE/05iPFk2Qe+qxfYczW0aTjP9Y=;
 b=w889a/ddBbsr/y+3/Ny+rDzeyy0r6x+F2E1swLi5zplQ4hhf7tmKDHQtdgcL/mcY+0
 Ac9AgO7ZNYVN07zKU/laUS0nTMJK52Hq+JjA9++ue9RlIDs688duRq7Zpqw24Cv2nhst
 NfcS8VvtfsSw5v/IuiItLL+B4gOn/qrNKQbLnarVXrsNX73oXBU7NTw7XHxIS/Javs/E
 cVDxecxwrab2zOX9RAFMLAWdRzDoSaLdnbGiOYZpJnpqGPJ/ZcGENV3bopnNgDTW2/81
 8iO825KMMYjQUMeXkxe9bVsr/EVaTZIq3YLipAb7/JraWnA/ik5pVnzvGPL8V3grjdmM
 F9Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYcB7iht7D+gvt75Z0uZ+RYI8mVLPTlmg2uFBeAz8pDnsLWtiv0/uh3qYuMyOcanU2rOrYJ0597rtG@nongnu.org
X-Gm-Message-State: AOJu0YyrJUTZwb1FO8j6sApWVOqNVG2UKbr/15rsvGS+49cU/mYWHOwl
 6J5nHp539CH+SeOqosgk93OjB5WPgYERi0qzZKfTQ2EiUbhQGi6h4l5AQg==
X-Gm-Gg: ASbGncsjZzZNAz2J3/apR/sKwnz76nOl8iAQk54n5OCGgjQd/faUqJK0wZ9OdGZro2C
 LqWbglVY6UyBLIzJsKom4yk6GUV+cQcDDAbgpgO+9ZFqbpBYq0ieY3rG3GKAxjzxrGkeoA7BFjs
 Hfg1yHCXqFAMu81P2sWvceyBjSuP3JMUStnqFpLiZ9EahlEmKM7Y5a6bURrCKn2YJauKkfKknDc
 428QEHwMiB3ks0HG0TdsFo6FBS8G44BcvEC0aAG12RAubWqh0x0UDygICHkxjxeRqf+xMNomIbO
 Mg7NuD52R9UPW5EM53rP1De2PmXp1p5BQHGQOSkVdCm2
X-Google-Smtp-Source: AGHT+IFMvZiat9mUCjLF9UHdmV1Sn32nq0nesXM7wpVe+pH6U9hM/8LS/AZv6WtZTpqJyqkQ5PXafA==
X-Received: by 2002:a05:6a20:9e4a:b0:1fd:e9c8:cf3b with SMTP id
 adf61e73a8af0-20cdfcfc857mr2128966637.30.1746156694811; 
 Thu, 01 May 2025 20:31:34 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:34 -0700 (PDT)
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
Subject: [PATCH v4 07/22] tests/qtest/xhci: add a test for TR NOOP commands
Date: Fri,  2 May 2025 13:30:31 +1000
Message-ID: <20250502033047.102465-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

Run some TR NOOP commands through the transfer ring.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 39c5c36e940..7f801f8f1a0 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -753,9 +753,29 @@ static ssize_t xhci_submit_scsi_cmd(XHCIQState *s,
 
 static void xhci_test_msd(XHCIQState *s)
 {
+    XHCITRB trb;
+    uint64_t tag;
     uint8_t scsi_cmd[16];
     g_autofree void *mem = g_malloc0(0x1000); /* buffer for writing to guest */
 
+    /* Issue a transfer ring ep 2 noop */
+    memset(&trb, 0, TRB_SIZE);
+    trb.control |= TR_NOOP << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    tag = submit_tr_trb(s, s->slotid, 2, &trb);
+    wait_event_trb(s, &trb);
+    g_assert_cmphex(trb.parameter, ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+
+    /* Issue a transfer ring ep 3 noop */
+    memset(&trb, 0, TRB_SIZE);
+    trb.control |= TR_NOOP << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    tag = submit_tr_trb(s, s->slotid, 3, &trb);
+    wait_event_trb(s, &trb);
+    g_assert_cmphex(trb.parameter, ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+
     /* Clear SENSE data */
     memset(scsi_cmd, 0, sizeof(scsi_cmd));
     scsi_cmd[0] = INQUIRY;
@@ -821,6 +841,22 @@ static void test_xhci_stress_rings(const void *arg)
         g_assert_cmpint(TRB_TYPE(trb), ==, ER_COMMAND_COMPLETE);
     }
 
+    if (qtest_has_device("usb-storage")) {
+        xhci_enable_slot(s);
+
+        /* Wrap the transfer ring a few times */
+        for (i = 0; i < 100; i++) {
+            /* Issue a transfer ring ep 0 noop */
+            memset(&trb, 0, TRB_SIZE);
+            trb.control |= TR_NOOP << TRB_TYPE_SHIFT;
+            trb.control |= TRB_TR_IOC;
+            tag = submit_tr_trb(s, s->slotid, 0, &trb);
+            wait_event_trb(s, &trb);
+            g_assert_cmphex(trb.parameter, ==, tag);
+            g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+        }
+    }
+
     xhci_disable_device(s);
     xhci_shutdown(s);
 }
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD21CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298B-00075X-0Y; Fri, 26 Sep 2025 10:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2987-000759-NB
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:08:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2983-0005cm-Di
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:08:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46de78b595dso11289375e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895727; x=1759500527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O0aztZbkfa2XWgDl+0nqPzT+Opjm3fDCBodAYyqxJuM=;
 b=h6/cnikYDVk/HouLB0M7A31FUOr5JmwWw0HMf6LWixfcKLSHanPo9LJ7VEGOVqPJWk
 dNqicBlBlo07rDDlrkELzTNsfVf0Mxka2q3DAXZdzfiYYQtpg684DtL3nP/Q3XwJndHs
 5T/rzkneh4B6CLKhkhz67MlydePd+4LK69nW5E1PIuvXiy+lAOKrgelVGWq2u7T5WwnP
 iMDZu6lLwADuOkH5AfJrXFGis6L5wDuHLvQsPIqsIov7UgoHJn2U3cHIwAMtJZgAOIxQ
 jsJ8y05ru/je7sLrLUTsEpt/QghYNfpDYcYUdCYZgpRzE4ZDslb+X2DLQrhPCJ9euvA4
 bi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895727; x=1759500527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0aztZbkfa2XWgDl+0nqPzT+Opjm3fDCBodAYyqxJuM=;
 b=N6nt484eKUWc8hrXhlF+l79MPWrfkPfva2zXJceO0SD58c1bnr/Hb8E4bp+u0+JdNh
 wp4HJfLBsASKyUN4OwFynJuOoCcEzSZb8VegVJIy2z7qg6XWYQBIrBB7Bitay5Mi2D22
 GVofE3H67OFWR0vVXuJ7NBY2ZEqd39DQtf6R1C9U5/vMfg1kkVwVMXlpz9lYNxeJaJYm
 NDgpqlpVug9mgLxFG+tdMZRg/DBTo3oz9eRi5UCnMANYOZ51rMG5zZca202B7jpUwRAH
 ejwjwFO6gFSNDxqPEKgmIm/QD/8O9rcEfir3oZGFxghXXhZPYuHkZUKnmVVpRq2wTS3r
 vcBQ==
X-Gm-Message-State: AOJu0YxMzhIWiOqWfIUNlrsRqfsAuqOwVcgE37xRb0cJ/PcaGNLN/deK
 97br4ovIM9EjLO03w0KZcqC9HivckrlKgGKmNmCDx0k0uno5sMQbnyUyI5kJfYPI+5/7GqhfWh7
 K1JHx
X-Gm-Gg: ASbGncukGS8CEyrVoYAvS7QHWx/r5KKmYwbj+XA4ku7mpZheqQqAX51AkkBXzCLUpL/
 M5BYc6MJmw9DyoZtrLwUpq4ZSAJXbBiKNh29KNA0p4xxUnxtbyO4n6GyiyNih7SE37VmFrFnvQY
 GF+vRCTwLRigSy2P9sawzgVuaSg0RtLzPvyDd0GzEVL7THipQxiJ6mTxFt1cR3YUl5Q+DpIaHFZ
 FDgBVS8SLEAKhpE1BGBfmrT+tQtRi+TKzsbMXB2jfL6RGu8nSzPClCvVbg9sDexPv9wC5hAI97H
 PCekEZLP5RAMyT4wkxJMkLShQKu/gCq3aMSvLtsHRBy41OOnSbvVbvkZ0BrXBXfNuo8hM9oKGYK
 o6zcUGJ701pPrBxSr60uKS1wXkcmY
X-Google-Smtp-Source: AGHT+IHKSXMU5p1TR23tcydVkuuHAEnSkW6JQbS94rsxPN0KsST6Xewp0WR5dCjBXoWaDDF0mrM9Hw==
X-Received: by 2002:a05:600c:1508:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-46e329b62bcmr51689685e9.12.1758895727402; 
 Fri, 26 Sep 2025 07:08:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/44] hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
Date: Fri, 26 Sep 2025 15:08:01 +0100
Message-ID: <20250926140844.1493020-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

If the guest feeds invalid data to the UHCI controller, we
can assert:
qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.

(see issue 2548 for the repro case).  This happens because the guest
attempts USB_TOKEN_SETUP to an endpoint other than 0, which is not
valid.  The controller code doesn't catch this guest error, so
instead we hit the assertion in the USB core code.

Catch the case of SETUP to non-zero endpoint, and treat it as a fatal
error in the TD, in the same way we do for an invalid PID value in
the TD.

This is the UHCI equivalent of the same bug in OHCI that we fixed in
commit 3c3c233677 ("hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or
OUT").

This bug has been tracked as CVE-2024-8354.

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2548
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/hcd-uhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 4822c704f69..e207d0587a1 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -735,6 +735,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
     bool spd;
     bool queuing = (q != NULL);
     uint8_t pid = td->token & 0xff;
+    uint8_t ep_id = (td->token >> 15) & 0xf;
     UHCIAsync *async;
 
     async = uhci_async_find_td(s, td_addr);
@@ -778,9 +779,14 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
 
     switch (pid) {
     case USB_TOKEN_OUT:
-    case USB_TOKEN_SETUP:
     case USB_TOKEN_IN:
         break;
+    case USB_TOKEN_SETUP:
+        /* SETUP is only valid to endpoint 0 */
+        if (ep_id == 0) {
+            break;
+        }
+        /* fallthrough */
     default:
         /* invalid pid : frame interrupted */
         s->status |= UHCI_STS_HCPERR;
@@ -829,7 +835,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
             return uhci_handle_td_error(s, td, td_addr, USB_RET_NODEV,
                                         int_mask);
         }
-        ep = usb_ep_get(dev, pid, (td->token >> 15) & 0xf);
+        ep = usb_ep_get(dev, pid, ep_id);
         q = uhci_queue_new(s, qh_addr, td, ep);
     }
     async = uhci_async_alloc(q, td_addr);
-- 
2.43.0



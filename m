Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895D3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 19:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKMmw-0005LG-Jz; Sun, 08 Dec 2024 14:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmn-0005JN-Kf
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:49 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMml-0001W4-Mh
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:45 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa5ec8d6f64so419952366b.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733685462; x=1734290262;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acRq5wtuEZY6qfWLgIt8kj488PEzJr2oq6KQkbWz1tc=;
 b=S+wy0mgvIYaKjcW+j+MllyZmeGgpkZ0Y04Png2xNe2EC6rBlFk09lB14hw40EvV0Ps
 NhIz00gKoVeLwo4HRRnk63G0MPjVSOc/mdOtcDeHcCXJZJyr6K/c8UQZdV+CryABZuM6
 oN6e6xemcpNIAutEnL6IrGGQYcPeVpMxRZBtKzVc7Mz4+4MYcEiohmq57VK13E9NbRlS
 MV6TxoVu69hP+ciYy1nDnbrhKxY/sqsLZV8GhDMwWBPUqsQn5dx5K0UIjsSxN2K4Ffrx
 +RqZde41T4oma+V/a3gptBgpfDdNnUNU/dMG55K/w+XuhP7RG0Z4gMAbWlVMagcTyDN6
 Oopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733685462; x=1734290262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acRq5wtuEZY6qfWLgIt8kj488PEzJr2oq6KQkbWz1tc=;
 b=DhQlHFAJPKfsIsgS+fP5UdPJPTqPFmvYtbu3hSuC9d2ldmPST1Vu2qUhwe+pwAUay0
 +GFzqJcyTOvLXCC/Q5xo4BLf2I8ZTpS6yFt3XbdCkc1fKHrgNw38OzOG3OaOtq1J0PYW
 jIQDNjPmaEQJCrVcIPqW7VOZ/FXruZ5Q0ICm7U8+JaNOpTdfsW24S8D5+O1z+L3qIiBt
 0mU1BOk9voSV/97e8Sg5eqUrt2xKlLoXeRJK6LGhLRcF9rJjY1tT/6aQJif9Rw7EWxKC
 r5Mc2tYM48iwKgvZbU34smwEEue8Ngu78tGqcf4LzK2xdLwNkLnNpw7UrXZSq5eZaMq/
 62AQ==
X-Gm-Message-State: AOJu0YyjHQFlJ3RZRhwvRPWa6cqkyGfaaY2WHDkA+sDMYrF9nMNgPItH
 gkaWA02aC9iH3mIvKmVh3yzgtqMBQNbIy9PW+4rvDE2nV0ZVJKvqe29wz0XMG7hxcJLPhmpbPsX
 I7g==
X-Gm-Gg: ASbGncucUnU+cSZ7TJx9vfQ8KDmpoHuiV43tbJ4mE4UBPtg4r7aO1VIBd3JRBFpqsV0
 yDCJRAVFYodqNaCvgF1lTTwuMkBvpvb/yAZymTAYSEld5HyPgYIdse0/2XptcpYRZbLBTU2MHA0
 Qlu8jy5lNw+e7DD/cucNt8PuzEJ0m4dwIaoChs18r8WFU+1/9C6BAq0n3LirfDk4yrbucQxS8O6
 /xK84qWmCVl7WrwmSHM8a/WNgT5SqSfKlNo3uanvlyUx8oY2VRz76apoVkIkIsj1wBYW/B9mQJg
 9NbSslI4ohdhjP1l6yXiQSOKN4GC+w==
X-Google-Smtp-Source: AGHT+IGiIKJIihXmyHTChh917c1Js0pVeG9Vf7NWwWydHbDw8oXp8Wa42Js7HH3AC2SINkgrEZoLzQ==
X-Received: by 2002:a05:6402:2806:b0:5d0:c7a7:ac13 with SMTP id
 4fb4d7f45d1cf-5d3be744ef2mr28005883a12.34.1733685462163; 
 Sun, 08 Dec 2024 11:17:42 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa665119a06sm240350866b.121.2024.12.08.11.17.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 11:17:41 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 3/6] hw/usb/hcd-xhci-pci: Use event ring 0 if mapping
 unsupported.
Date: Sun,  8 Dec 2024 20:16:43 +0100
Message-Id: <20241208191646.64857-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241208191646.64857-1-phil@philjordan.eu>
References: <20241208191646.64857-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62a;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The XHCI specification, section 4.17.1 specifies that "If Interrupter
Mapping is not supported, the Interrupter Target field shall be
ignored by the xHC and all Events targeted at Interrupter 0."

QEMU's XHCI device has so far not specially addressed this case,
so we add a check to xhci_event() to redirect to event ring and
interrupt 0 if mapping is disabled.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/hcd-xhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d85adaca0dc..5fb140c2382 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -644,6 +644,10 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     dma_addr_t erdp;
     unsigned int dp_idx;
 
+    if (xhci->numintrs == 1) {
+        v = 0;
+    }
+
     if (v >= xhci->numintrs) {
         DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci->numintrs);
         return;
-- 
2.39.5 (Apple Git-154)



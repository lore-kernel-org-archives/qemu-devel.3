Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FF2E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Bn-0001q9-QG; Fri, 13 Dec 2024 11:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BV-0001hL-N6
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:35 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BR-0006ey-Gq
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:31 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso305031966b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734105987; x=1734710787;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acRq5wtuEZY6qfWLgIt8kj488PEzJr2oq6KQkbWz1tc=;
 b=Juo99WLdbB8NPlYsW98ipotd+LJLFeeEphSmCnUdikcz2DP8qBI2jBEQUClMT0510M
 kPvPpZiKjz+g1eegTcymCjfy/hA5p2IoWErd3QYo1kR9jnOlQopUlzWCQYtOOFwtCNrN
 ky7A11Sv8q108zRQtBfFFlu9o5F7hRMboYltOwat3+fqJ4UTFmdaaAxoLnF3buLm4bzk
 1hJMAldgVTBLOLDsoNNWIiPFBT7YaSe5ZhV+z83rBLKhcKIX/PbQph6ow3LvC9jeSYr8
 9UabU7IHr57k2ETWvR9oXTdU9SmMF2PmpKJZslsAeyRwUs7BecAC+yzTiX0UF735gMu7
 LbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734105987; x=1734710787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acRq5wtuEZY6qfWLgIt8kj488PEzJr2oq6KQkbWz1tc=;
 b=dh73de4NDKLh/jd0rpbXtRSXR1IEeLNeXVB3jEZFRj0ZqfHwmz5uOvyYcJOI9sRDo9
 aHLwtQYgApCMaHcHy5eBmrxEwx62gGNK5UP0nHzIWWGkWyqoivvh7+POwbeN++FHZlo/
 iLnHVnERlOCi5CUBrkc5LqnYyY8rXuahZ0eEHAnpP/mpCpCTmVAVIk8tNsWOsIV7bjDt
 pjzf1uOFLukrcZSpMeUBhXDq4OHBrlkwxwz/x9juElPJG8gMCpSIoVzx14o1k1T2AlIl
 CRtSf0rQxq/ni2qkzABo7YPedR365uDJ0h/Kt/Zdp+VBR+kgWWA1lf+qmU7+TPe+Gieg
 LMIw==
X-Gm-Message-State: AOJu0Ywg+9vAMFUGe4asq/aYm0p1n6fqBwF0Riq9/Ejn+HLqkC3jHajm
 u/LD1MWTO4JHJBqsDsZ2e0MVQGj/1SNx+tAA6EL0G2TfnK+0MQdn0Ejt2J1TwG/g0Sk6pf8vXVB
 /zg==
X-Gm-Gg: ASbGnctCd3Bj1ePgEfLNQyXePs+zlzd997qwBH+aAAC4OR6IVJKfCOHTmoyx/ROPI3H
 qY9wZRY7XeKQX2gOz+eFT51qszyDmoXLxHsHR85W4w9E7cQ5WrB743yi8U3HH62xgRbP4Mfj1cP
 D+0JhBYb1KuPAb2R93ttpIrOYR5L6n7gP3i1GXZUq1W8NUkdijsQcQMaCxzeX5prMdC38W4I+Rm
 qcoB2rVbAwYMQ/W4GCoGHn8KUMvuDwR8OQRqdBfBHmNyFpa5vLbUmlajqqRs7JHO+FmIeSIGRRD
 jHlkIfwfA1BA/LJIuvTAgHI5QX7CYP5o
X-Google-Smtp-Source: AGHT+IFISrcJgZSd7pbDNX+2Mk3hdeXSTSjPHDrcG41VfJMZ3t6J5GTJ5qNn7x2NoGV4TUZER6HYIg==
X-Received: by 2002:a17:906:7314:b0:aa6:74a9:ce6e with SMTP id
 a640c23a62f3a-aab77909d56mr332290666b.16.1734105986885; 
 Fri, 13 Dec 2024 08:06:26 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667843413sm916683166b.24.2024.12.13.08.06.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 08:06:26 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 3/6] hw/usb/hcd-xhci-pci: Use event ring 0 if mapping
 unsupported
Date: Fri, 13 Dec 2024 17:06:16 +0100
Message-Id: <20241213160619.66509-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213160619.66509-1-phil@philjordan.eu>
References: <20241213160619.66509-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::635;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x635.google.com
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



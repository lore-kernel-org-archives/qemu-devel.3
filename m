Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C670BC44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhaY-0005K0-SI; Fri, 17 Jul 2026 08:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkhaT-0005JI-FN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:22:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkhaQ-0007Mt-Fs
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:22:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so33356175e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784290956; x=1784895756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zn/oF8I0qP8woHgvtOSZi9v3SKEQ1Sw4jXa2A75xaNg=;
 b=iqC4fqyZMuz9tnWpsBFkgZZYdMckuMhRE0Hb4tNVlLRgF994aYBBO4PRnBq/0X4mMZ
 BHa7okAmBvn3E6Ozwem2co3iUr/D5HnKwOhFN+4dcpjKnoWJRhnKvn3scgpohaciOcyz
 mwAahLGLRJKmcb54/+R4g1w7rOuxKVkYGunZp/P2sb1caJZaWmeWMPmXO7/cDTqkP44x
 brGrqX6OqNO0/ULzqQYrHxdVROBiC8zlzeHecwBXTa4tMbzgQg/DVzgNrTaM8kifXOvQ
 DVJ62QZDu7f3TJgKi9iHMS8RyH+rD1xclZoQohjSK4PS84sK+XBNqMLkLiPn5aVTfeux
 jPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290956; x=1784895756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zn/oF8I0qP8woHgvtOSZi9v3SKEQ1Sw4jXa2A75xaNg=;
 b=OgP69q6NeZlFJvkUuBk/gruuA9XCIJb1Wp3IPqsJWDpfhuOkxW2j8R9MhkL137uKUP
 4upKBv2VMrzVsX9OvcelwE8ybj3CwlJ5akm25Ak31oH7TgH0118hxREvLIizDt7CbEqK
 nyKQhKFqVMEC/N5enmhQmuZiXbb26nLYckErHPmuZtYCDWw+irlbGY1FH9upUV1zzeYh
 y6IfTCJBNmay8Yie5gb8sNlmqkDhJ5VwbqLoADVcGZW85MywBnW8yVKioqbUS4rL0kwA
 Rx/octZK4ECdprw49c6B2JYfGTL03pZhY3zZDeICyU5qhSGljUydxGdtLonQIluFfkbM
 4QCg==
X-Gm-Message-State: AOJu0YxGHPvT3DhhnQLDknzIkYV/viudAzJOXAHHqHLlxGCuKv9dWySi
 hJxW6LZEVeVjeLzFPprYLsjkMP/VM35zV2j3s7LekJvfd+vbYN9tvwUJNLFG7KGD3+dSlMWdgQq
 AZ0g2GGw=
X-Gm-Gg: AfdE7ckBwexH2WGL7R3mQls4wEZolD0jHBoCeGwFoyxOVv/qNQd/pvQMa8FcJeMexVh
 srFL+uAfKWAFkhSyDN5gY3tnbqzE4Lu0v0mOjqwK0EOVleoz7VHU9iWOEqW4CipO6eFSaaesWl1
 FXAossdkA2bi8BdqyfAylSngzTYvebchbX9tI6jryijFnwOGurgMos7Zr3r8wnrSUGzTynXun/p
 jUuwYBNccNvwwp7disEhWKUqnxbRjc8WyesQDydcl6baKHBVm8iO2Y8I4bR7i8boRH211iJNTf1
 Dytdq24qfepKL50Z6mZ8lo7jKAVsM24snqzd6N2Qq2yV2AC+hZ5jH9lYSwERvLCYQYQbBycqBpo
 uFQDNASrvJAwU5o44I/r50P9pBfZx5Hbi6CKBXC4EWmrdKVAyY6sh3wyfnGmilxun748=
X-Received: by 2002:a05:600c:4584:b0:493:f5bf:4da4 with SMTP id
 5b1f17b1804b1-4954a50e970mr26596925e9.28.1784290956130; 
 Fri, 17 Jul 2026 05:22:36 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:819a:eb1f:262d:7641])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2f210csm48055935e9.15.2026.07.17.05.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:22:35 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 0/2] vfio/pci: reject invalid PCI_INTERRUPT_PIN values
Date: Fri, 17 Jul 2026 14:22:28 +0200
Message-ID: <20260717122232.468955-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715191735.2454719-1-den@openvz.org>
References: <20260715191735.2454719-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qemu-kvm aborts a few seconds after starting a VM with a
passed-through GPU whose PCI_INTERRUPT_PIN comes back as an
out-of-range value: vfio_intx_enable() only guards against pin == 0
and stores vdev->intx.pin = pin - 1 with no upper-bound check. That
value reaches pci_irq_handler()'s
assert(0 <= irq_num && irq_num < PCI_NUM_PINS) via
pci_irq_deassert() -> pci_set_irq(), aborting the whole process
instead of just failing the device.

v1 -> v2:
* original submission was wrongly ported patch from downstream. Fixed
* added checks for narrowed values

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alex Williamson <alex@shazbot.org>
CC: "Cédric Le Goater" <clg@redhat.com>

Denis V. Lunev (2):
  vfio/pci: don't narrow a failed config read to a plausible value
  vfio/pci: reject invalid PCI_INTERRUPT_PIN values

 hw/vfio/pci.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

-- 
2.53.0



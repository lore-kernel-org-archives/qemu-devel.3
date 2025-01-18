Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4282FC02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 08:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ3yb-0004CQ-B3; Sat, 18 Jan 2025 03:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ3yY-0004C7-Sb
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 03:14:38 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ3yW-0001OG-UK
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 03:14:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21bc1512a63so57607025ad.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 00:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737188075; x=1737792875;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q40Fy4uVj3RIXnxroUnCjm5TIDMHT+mIMjUjOLQYcc4=;
 b=UsXTaKB/fDd8yUluONZjVwVEN2PW0I/PCu4t5R58FIlCXxUAkdQcxvSL84BZwDvyU9
 VSZOib0a28Gucmu++Qr/9grFgqb4DiNQV3kr5+ko9ixEWK+tRB4CMFep78yTQXJ5wyJF
 MfiqFMwBYiR5NL38x/sI7FuuyfBhp3DP2j1wDY4r+B1GOUvzzLDtMC/PC0cM4heJJwRU
 W9Zy5NOR0wG/QdIzHj0md697LB6kcdgSzazGUI1CmSaDXVBd+/r45SGE2Z+vsvplQF6Z
 0LUZFCLkswb+HGoS2b0OBkuxMnaAXHBWixjP17dA1MBm1LXpDglLFUyi8Tt1J5glmExz
 s6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737188075; x=1737792875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q40Fy4uVj3RIXnxroUnCjm5TIDMHT+mIMjUjOLQYcc4=;
 b=or+TSQCrgXcowANCBG89D2RyeZiDiBXtcWaBg6w/UB6xWiADapmc3nZNx/JRHrW5h8
 LjO3zcJ8hDd3WS36VWdWBywhnLahErF+HaTnkY0cVNkLRJYS5YQz0EAZux/+FiI/DAwD
 CDJl3QB+AZvcyoDtQqXkCMziMrJ+cxtU7MKZzuoXkicRb6LTR+I2tfPYRrPPSa5cvYWU
 3NCT+TcsUXvpoDXEB9iqqosu4i5bTduDllE8UVijU2V2uiu4OjnHJ2ay12h0/BLDHbID
 aOEbxFnktfqRTP3tInCJx+IxqLkT4ZQASgc4zWnjmBa01RNwa2PschmWTXhpR9xNL4Wi
 iMRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmaUs6jCEq8112Ie8oB8bnjhfbtHW9coJB+ncD8XSljb0/xEqltyzvaEfJQ0P4f81lNpw3HWjv5GtL@nongnu.org
X-Gm-Message-State: AOJu0YxSt06QjB6nC+9KZNkspI8+CTOhBKQ7fUjeWEzyb39itDlsx5O7
 Xawcsfo1x47cTEGhxmtB92CjSYkxiTAKG/KcnPW9Ek4ZewiU+SZRZN1M8j2LdEY=
X-Gm-Gg: ASbGnctsbKGcXUuw+Eoi9X0Ks2+IVhB5QXC/iS3MdLC9Kq75l+ZAezWtfyZdWxc9bMt
 UPL6zlW5bWVHIHPTdYaqJIDCqVd1zqUHrSuvXgtWOjspJa2BQM85dJI7i7dqwmOuI5IiKanxUYt
 ZQnX1MisTmMrWJqAxh1eRmcQ8d1tPUwJql9198vOqJCYS/um/lYKspKO8OjOFa40ZSw6cSGmKlY
 3wAhdN+3Iz4V4kVIBYTrwXXw2w+Ix5ltu5z1ZQ1aD0mskdov0iEk1LerOpyogcPNntZ4iqyqk7i
 zp8=
X-Google-Smtp-Source: AGHT+IG99sHgD5g27rpEc6AeeBNslp2wkG+U41Z2wHQp8rgulVbAwfc/2GoRl7u6mYl/8gHgpU90HQ==
X-Received: by 2002:a17:902:ce8c:b0:21a:8839:4f4d with SMTP id
 d9443c01a7336-21c3553afa6mr64845885ad.6.1737188075063; 
 Sat, 18 Jan 2025 00:14:35 -0800 (PST)
Received: from [10.4.77.142] ([118.103.63.134])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea05bdsm27290595ad.30.2025.01.18.00.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 00:14:34 -0800 (PST)
Message-ID: <0f1eab33-b5ef-49d5-801e-e579010db784@daynix.com>
Date: Sat, 18 Jan 2025 17:14:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] qtest/e1000e|igb: assert irqs are clear before
 triggering an irq
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
 <20250117170306.403075-4-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250117170306.403075-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/18 2:02, Nicholas Piggin wrote:
> Assert there is no existing irq raised that would lead to a false
> positive interrupt test.
> 
> e1000e has to disable interrupt throttling for this test, because
> it can cause delayed superfluous interrupts which trip the assertions.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/e1000e.h |  1 +
>   tests/qtest/e1000e-test.c   | 10 ++++++++++
>   tests/qtest/igb-test.c      |  6 ++++++
>   tests/qtest/libqos/e1000e.c |  9 ++++++++-
>   4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
> index 30643c80949..7154aec0339 100644
> --- a/tests/qtest/libqos/e1000e.h
> +++ b/tests/qtest/libqos/e1000e.h
> @@ -54,6 +54,7 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
>       return qpci_io_readl(&d_pci->pci_dev, d_pci->mac_regs, reg);
>   }
>   
> +bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id);

I would rather name it e1000e_pending_isr.
We may have seen an interrupt in the past but it may no longer be pending.

>   void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
>   void e1000e_tx_ring_push(QE1000E *d, void *descr);
>   void e1000e_rx_ring_push(QE1000E *d, void *descr);
> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> index 746d26cfb67..9ab81ecff5b 100644
> --- a/tests/qtest/e1000e-test.c
> +++ b/tests/qtest/e1000e-test.c
> @@ -61,6 +61,9 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
>                                      E1000_TXD_DTYP_D   |
>                                      sizeof(buffer));
>   
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));
> +
>       /* Put descriptor to the ring */
>       e1000e_tx_ring_push(d, &descr);
>   
> @@ -105,6 +108,9 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
>       char buffer[64];
>       int ret;
>   
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));
> +
>       /* Send a dummy packet to device's socket*/
>       ret = iov_send(test_sockets[0], iov, 2, 0, sizeof(len) + sizeof(packet));
>       g_assert_cmpint(ret, == , sizeof(packet) + sizeof(len));
> @@ -188,6 +194,10 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
>           return;
>       }
>   
> +    /* Clear EITR because buggy QEMU throttle timer causes superfluous irqs */
> +    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 0);
> +    e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0);
> +
>       for (i = 0; i < iterations; i++) {
>           e1000e_send_verify(d, data, alloc);
>           e1000e_receive_verify(d, data, alloc);
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index cf8b4131cf2..1bbb4bea4c1 100644
> --- a/tests/qtest/igb-test.c
> +++ b/tests/qtest/igb-test.c
> @@ -64,6 +64,9 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
>                                             E1000_TXD_DTYP_D   |
>                                             sizeof(buffer));
>   
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));
> +
>       /* Put descriptor to the ring */
>       e1000e_tx_ring_push(d, &descr);
>   
> @@ -119,6 +122,9 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
>       memset(&descr, 0, sizeof(descr));
>       descr.read.pkt_addr = cpu_to_le64(data);
>   
> +    /* Ensure the interrupt has not been taken already */
> +    g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));
> +
>       /* Put descriptor to the ring */
>       e1000e_rx_ring_push(d, &descr);
>   
> diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
> index 925654c7fd4..4e4c387b0bf 100644
> --- a/tests/qtest/libqos/e1000e.c
> +++ b/tests/qtest/libqos/e1000e.c
> @@ -77,13 +77,20 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
>       g_free(dev);
>   }
>   
> +bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id)
> +{
> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> +
> +    return qpci_msix_pending(&d_pci->pci_dev, msg_id);
> +}
> +
>   void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)
>   {
>       QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
>       guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
>   
>       do {
> -        if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
> +        if (e1000e_seen_isr(d, msg_id)) {
>               return;
>           }
>           qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);



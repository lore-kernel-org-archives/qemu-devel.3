Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305A1E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCOX-0006Hl-KR; Thu, 19 Dec 2024 04:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOCOP-0006Gr-Fn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:00:31 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOCON-0002oB-6Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:00:25 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-801986033f9so279746a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1734598820; x=1735203620;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wJnDTOKA6yiB6oazr/dHrKj1TdkoOOygvY0tH/YOv20=;
 b=s+mQUVvvhyvcdelDE4xgcNyyLlbBOhQNTxfVmMFaEZEd9PnnmBYtlfKzx12roVFoZq
 rYUscxsS8E/I9sLsotTSJx3iaHFMDYFv/sgITTyMEWhQS7RW0Pum2L5IN4EWl3wraIVM
 GR4kS3pKOgFNLqOc/gx96f9fl2yIEQY+lJRHF9hGylp3u0k29ma4uxo+5lJftiwxM/kK
 hjcMhVK8zB6nAe+w7UBlbqrmCj4KenRqXk0j8IQPKkIZ5YA0NhyaF9gOxWL9M5wJMqHS
 sdmkwcz/4LsyMOgJHfts8Ih0fjKEw44RDqUQrBm3/p5ueS8WFCStdWs4Uv8hIhJxfZhT
 FgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734598820; x=1735203620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJnDTOKA6yiB6oazr/dHrKj1TdkoOOygvY0tH/YOv20=;
 b=R+wGGjaQHMNJ+aQzAlMSReXUyCoyhOZSIDZNc8gyafZj2cVKZQDuoZ5iBpTEj/Hn3o
 Z0i3zapA207BxsmCrEa1nU4patjGBTu9UBr9UTV8BoJAiD6SVV3N9TeJGdJlhNvWyFoL
 Lth3Gpx8nT5Ev/NWCXBzPHu9K0z+B4aMtgoav9GnHLcrV5+Ar86nL7qz3IFumlMqTCs6
 Ynk6AJcFMtCkON5MojCP4dRhQWCNIw7uZlykiLZN23cVi9hoAT/ls5sMC6TzR2b00JSv
 d/RfG9IypCOQGzw4+z5js/ID/W4uHUuF51v0vUpk/X6sshR7dCcWufq9YuqAQZZhfHCt
 2QNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDeRTbwx2RJ/8AvUGLOb+k5tad4+hw74CrugAP1HEMc7EcD7d3eP89nEvSpU/IH2uFGPdlKPPaymKo@nongnu.org
X-Gm-Message-State: AOJu0Yxfx4g5gC9BZONVrJO6FHV3DJEOlqLJqjjbwXSr+KZ5oEQW8mrd
 ipNcCgbiqaGyyWAmkcxxcAhL/By2ecWE+itsNEoypxXsNXZcWpZMeQcOCnIojmc=
X-Gm-Gg: ASbGncvO7xtE4UWjqUDUL5u6ID6kquw/uD6aeU3WO2AjjDU2fpUIlKTpSdnRmLKZZwc
 3DjGVSOjZh9YhrY+gG3tXL7jNN+RP0KL4JO3S5OX4WnmhfC67zHr57zkqpvJpCC4HH4H1+dDu1I
 vwS9HKyV0XByXvRIFYcu+xO1okXsSb1li6blYpngxU5GD2Gi8mqPAf0bJ10Roo3qNTfQ1kovcLy
 YuPABZX0rZYvhikQ2BT/Kj5nDdrMtK5b5myU/hA+OiKeLJ8GAEXW+wG++QsqnRu/K8=
X-Google-Smtp-Source: AGHT+IH9WRNDwiBwQFaFxBPbLWFNzJTp+A6NZnA7LDgmJPB9miaXhsQDsv66/zHAcHIAUcmnKvxXlg==
X-Received: by 2002:a17:90b:4d0e:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2f2e91efb96mr8128604a91.11.1734598819808; 
 Thu, 19 Dec 2024 01:00:19 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4478accb3sm842799a91.51.2024.12.19.01.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:00:19 -0800 (PST)
Message-ID: <1b6ed10c-7dc7-4e27-9f84-d89c6c0adf55@daynix.com>
Date: Thu, 19 Dec 2024 18:00:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] qtest/e1000e|igb: Clear interrupt-cause bits after irq
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
 <20241218074232.1784427-5-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241218074232.1784427-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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

On 2024/12/18 16:42, Nicholas Piggin wrote:
> The e1000e and igb tests do not clear the ICR/EICR cause bits (or
> set auto-clear) on seeing queue interrupts, which inhibits the
> triggering of a new interrupt.
> 
> Fix this by clearing the cause bits, and verify that the expected
> cause bit was set.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/e1000e-test.c | 8 ++++++--
>   tests/qtest/igb-test.c    | 8 ++++++--
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> index de9738fdb74..a69759da70e 100644
> --- a/tests/qtest/e1000e-test.c
> +++ b/tests/qtest/e1000e-test.c
> @@ -64,8 +64,10 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
>       /* Put descriptor to the ring */
>       e1000e_tx_ring_push(d, &descr);
>   
> -    /* Wait for TX WB interrupt */
> +    /* Wait for TX WB interrupt (this clears the MSIX PBA) */

It doesn't clear the MSI-X PBA unless the next patch is applied. This 
comment change should be moved to that patch.

>       e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
> +    /* Read ICR which clears it ready for next interrupt, assert TXQ0 cause */

I suggest the following to make this comment clearer:
Read ICR to make it ready for next interrupt, assert TXQ0 cause

> +    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_TXQ0);
>   
>       /* Check DD bit */
>       g_assert_cmphex(le32_to_cpu(descr.upper.data) & E1000_TXD_STAT_DD, ==,
> @@ -115,8 +117,10 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
>       /* Put descriptor to the ring */
>       e1000e_rx_ring_push(d, &descr);
>   
> -    /* Wait for TX WB interrupt */
> +    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
>       e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
> +    /* Read ICR which clears it ready for next interrupt, assert RXQ0 cause */
> +    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_RXQ0);
>   
>       /* Check DD bit */
>       g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index 3d397ea6973..2f22c4fb208 100644
> --- a/tests/qtest/igb-test.c
> +++ b/tests/qtest/igb-test.c
> @@ -67,8 +67,10 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
>       /* Put descriptor to the ring */
>       e1000e_tx_ring_push(d, &descr);
>   
> -    /* Wait for TX WB interrupt */
> +    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
>       e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
> +    /* Read EICR which clears it ready for next interrupt, assert TXQ0 cause */
> +    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_TX0_MSG_ID));
>   
>       /* Check DD bit */
>       g_assert_cmphex(le32_to_cpu(descr.wb.status) & E1000_TXD_STAT_DD, ==,
> @@ -118,8 +120,10 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
>       /* Put descriptor to the ring */
>       e1000e_rx_ring_push(d, &descr);
>   
> -    /* Wait for TX WB interrupt */
> +    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
>       e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
> +    /* Read EICR which clears it ready for next interrupt, assert RXQ0 cause */
> +    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_RX0_MSG_ID));
>   
>       /* Check DD bit */
>       g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &



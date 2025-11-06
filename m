Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378CCCCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxuy-0001gD-0n; Thu, 06 Nov 2025 06:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxuv-0001fj-AS
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:12:38 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxut-0000p0-Oq
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:12:37 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so1127365d50.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762427554; x=1763032354; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2V9ZKnnQa5SNJF/xNxgi6Hz+kQSqDEZ/9H/JW4v3EM=;
 b=etg2pHF9ks5XhHEhOUJg3laZ5OTq7xY67RHi+7IYODfmV42tDa/Sjzgy97EI0na/2Q
 XmYr1Kes0UFUk5QjMz6lbXMRyKZIxsw9FQYYM92jgRcn8/ckz7htcMI1/uwcEjY/w86q
 AaDbc8YppuGsVBKCqmKlcDXNwDwJ+jLq1npYNgG68NNlM4OpY++vVOTBB5qIO5k3F5Bt
 cJaNECsN3ynRXW5Hq28uNWkkRr4UnC1OcnkxRL72/VTO5sbNQBPiD73GZY0BBMQxEQli
 e2JwJrB9kDeWHqadhgMUR/2gjexokdujfTgVed/7lLBjETCCyg29PMCcJBgIY9T3RPYY
 Mr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762427554; x=1763032354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2V9ZKnnQa5SNJF/xNxgi6Hz+kQSqDEZ/9H/JW4v3EM=;
 b=ECNmKxwoswfG5hy5cZPQkoiD048sUq5eYwVA1+5lQrden12tETSXObgS6bKgRM9nUq
 UHSCe/ewgJds7+uN2yeSHCxe12pAkThFvNMFz7ewB+DgXB/nTnlypuxkPMd6JFILghJ2
 OqN1YW7kh4nlVZV8zNpHAX5et1RCqPDiTBy8O84VnM7Ae3HqCK02US0Ccoc/zqEyQN6T
 Hpe6q50MlkU73qL5963/yiOQ2BJJu4TfQIMNwFxAR0Oo6augsPOhnFi8aCLIOIJORBrh
 TTB02q70sCyjSB4RW/hkog5Et6bSlsBIF/e7eNKX5ylxAJWj3S79dbTi2c91o3bRqukW
 icjA==
X-Gm-Message-State: AOJu0YxbHkg5a4dcGPXJ8LgSJrFDQVFcNt1S6sjnyjVqXXNUGtQ0u58b
 OZYXqkeOxecoCLEJp4Eu7m7Xbb7uIChhDH54sYskFAZmRcvZOKDIBFX95n1Qk/H8RRlXA92ky4n
 3B0UCm4jWEK+MEad11g9UG7ydhiyTsVb/HnWG3BoCQw==
X-Gm-Gg: ASbGncv2u8snV3lZiL+QTRxBwDGC7su09N+JKt6Jcqr3RfPUl7gJbgZLHNQG5s1CjbY
 E9btoG2kx+Hm12jEKynCaz0/AEof2ax0UnMBo+rN4rrOaw04mp3PRn1E2SRszh4pVNb/KbjtTL9
 hCXjRrLvP4/ro4QnyD5ViKPH0Qngjwa/HN8LSULJ3q5tNGVxSjPuyz2sprMrsp1/Mzrrie4XXc3
 vitkIw4b1gilhiwmrv4QTRptQIOLv42io6IIJv1OIFJKFXex24pU50g+pL8cg==
X-Google-Smtp-Source: AGHT+IGRSOktNKq/ych4G45TnciGUI7BdT7Rsy4PyMdPlRP+SJkn3W1rQhGDxOHGbegrnJA5UXumlBZIcUzDvmuusIg=
X-Received: by 2002:a05:690e:2588:b0:63f:c019:23bc with SMTP id
 956f58d0204a3-640b54a5e75mr1842377d50.27.1762427554564; Thu, 06 Nov 2025
 03:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20251104152204.6261-1-deller@kernel.org>
 <20251104152204.6261-4-deller@kernel.org>
In-Reply-To: <20251104152204.6261-4-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 11:12:23 +0000
X-Gm-Features: AWmQ_blPpX2BRJSZgeh-kJLWG5H2n2H4T3KFB5BG8BybvQuSQ1Y6FZh7jII3iyU
Message-ID: <CAFEAcA-TqB=ePZv1LT22TRiH4JC9i4zkEjwYHrMS-EdYVDfd2A@mail.gmail.com>
Subject: Re: [PULL v2 3/3] i82596: Implement enhanced TX/RX with packet
 queuing and filtering
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Jason Wang <jasowang@redhat.com>, 
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 4 Nov 2025 at 15:22, <deller@kernel.org> wrote:
>
> From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
>
> In this patch I have added the following:
> - Rewrote transmit path with CSMA/CD collision handling and retry logic
> - Implemented flexible TX buffer descriptor (TBD) chain processing
> - Rewrote receive path with packet filtering and monitor mode support
> - Added RX packet queue for handling resource exhaustion
> - Implemented queue flush timer and management
> - Added RX state machine with proper state transitions
> - Implemented packet filtering (unicast, broadcast, multicast, promiscuous)
> - Added SCB RU_START enhancement to find usable RFDs
> - Implemented dump command support
> - Added bus throttle timer loading (LOAD_THROTTLE/LOAD_START commands)
> - Enhanced signal_ca with proper initialization sequence
> - Finally, adding self-test functionality
>
> Note:
> With this patch, and the previous ones in the patch series, we are able
> to achive proper 82596 NIC emulation.

Hi; Coverity notices a logic error in this function
(CID 1642873):

> +static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
> +                                      size_t size, bool from_queue)
> +{

In this loop, I cut out the insides of some of the if() blocks
to make the structure clearer:

> +    do {
> +        if (simplified_mode && I596_LOOPBACK) {
              [...]
>          } else {
> -            s->scb_status &= ~SCB_STATUS_CX;
               [...]
> +            if (bytes_copied < payload_size) {
                   [...]
> +                }
> +            }
>          }
> -        update_scb_status(s);
> +        break;

This "break" is at the top level inside the do {} loop,
so it unconditionally exits it.

>
> -        /* Interrupt after doing cmd? */
> -        if (cmd & CMD_INTR) {
> -            s->send_irq = 1;
> +    } while (bytes_copied < payload_size);

So having a while() condition here is dead code, because
execution always stops at the "break" on the first
iteration, and doesn't reach the condition check.

Should the 'break' have been inside an if() somewhere?

thanks
-- PMM


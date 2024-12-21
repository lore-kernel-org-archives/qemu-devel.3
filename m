Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE7E77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 04:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOr4k-0003QA-FW; Fri, 20 Dec 2024 23:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOr4j-0003Pz-4k
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 23:26:49 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOr4g-0003pn-QD
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 23:26:48 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21619108a6bso22179185ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 20:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1734755204; x=1735360004;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Xmp3eo6KcM7GBgSZe+eneQ5dUGMyAKZK5zwfjvxUxU=;
 b=UkTjeAR/35CYuyrEWq1tqUEJ/6I+DfSQ88kbq5laUwgCkmUXGzCihhA/9aeQ85jcgr
 wC/INDoYC0iQvQ6lYTXBC3XmLfKdXjsmyzVbe0gFg3dDemmKqWGJbHV9z13ILnkhP/sF
 AXfU6LvjQTxGGKrort/UihRvB+A01oAMeC8Sc9MZhV54bAGj5KZ5/wTRn5AJX7vB47hT
 Wm04YPsgOu5Q8ZNkBfbBJrXHX4T2ZpVS3OrE1saAmhTkPdkzHeBAB3fggfkQTGB7de+z
 rW/qxzfPx2ayfoj5Q0xz4w2DemWa8j6uL8pZsn9kp1P9l44V/n+C31Y62SPnbcDsixtx
 a7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734755204; x=1735360004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Xmp3eo6KcM7GBgSZe+eneQ5dUGMyAKZK5zwfjvxUxU=;
 b=LbAF9xFPONW8H5DMJwJxoahMpnaQNsZGSEei8yPvwDNYeQFM1OTJr64D1uVBuZd9WU
 mgGe0lhtOh0kLOr6FMfRG52EU2muWA8pLMZF64l9AUn3htXGEYhzK62+9awiRySoo18n
 3janQYYAFmHdwDjk25/pYgBSRZK1C+8e07o0IG230oyaaaF0cqpnltJENLq99D1yc44g
 J3M0b6yO1xP99v/iJw96xz7ChH7jo1INaBdX0D4LuItdWriDbITHP48UguKjuUuZ0ofS
 cHQsNBF4txr0M7VJtufIQyhCtkKJlohTWIT/6EYdR+eDo3+2yeNkG4qPiD7/cGnAf+ua
 cRJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlrSnDZFwod3nLnEt0IxTa9/vjTmZK4mkeZrnelBifnySoTHqlqa2qhYZECu+jUl9+fxWc0ZYGEu1H@nongnu.org
X-Gm-Message-State: AOJu0YzWIFn982o8/Cjjb6M4O1OQK3mCqqX1y/zxJffbm2DtlaEeLATW
 DTHX/0FtGKQMjljfuFLV6hFyWln3FWCFDOSFwnydTEQ3vS/ddBQMZMR9JdBrtr8=
X-Gm-Gg: ASbGnct5Jx96QfET6PiAeaoY3LV0HV8dM9K48akqJ78Sze6AFBouvMQSRY+VrtslujY
 Q9Kn9AOThzYCycCqhDPfeTD4FbADNJvxO5oDAkAMcfj/yUItjeFb4UxcsT87Pb6lIO+s007RbbA
 LxIcEgE1mI2QoF5nQ5zGLwV6lhF76rcdWXizsVRFNJTsTWbMNSnb6djm22L697TrpVI7je7V9xe
 kXRFEctvH4BnHJo/qoqUiOeyfL3W6YC2N55/Hmm34PDVhBHVOVLJ/9bH6OIirXI/bLP+A==
X-Google-Smtp-Source: AGHT+IGz4CMGQNS5QqeGW8NPbhjXgnAACSHE3mns3sATZSeUvstB99p8aiuHOSVyYeaSA1tzCje4gw==
X-Received: by 2002:a17:902:c943:b0:216:6901:d588 with SMTP id
 d9443c01a7336-219e6e9d949mr81510715ad.15.1734755203866; 
 Fri, 20 Dec 2024 20:26:43 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9716b3sm36761265ad.90.2024.12.20.20.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 20:26:43 -0800 (PST)
Message-ID: <c88dd8a9-bf21-4950-a91d-37fe18516ba5@daynix.com>
Date: Sat, 21 Dec 2024 13:26:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qtest/e1000e|igb: Fix msix to re-trigger interrupts
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
 <20241218074232.1784427-6-npiggin@gmail.com>
 <ceadd6b1-c9d8-4531-a901-ef7a57e3d304@daynix.com>
 <D6H34WA2W76T.2ADM8CT9LAZEH@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <D6H34WA2W76T.2ADM8CT9LAZEH@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

On 2024/12/21 13:14, Nicholas Piggin wrote:
> On Thu Dec 19, 2024 at 6:53 PM AEST, Akihiko Odaki wrote:
>> On 2024/12/18 16:42, Nicholas Piggin wrote:
>>> The e1000e and igb tests don't clear the msix pending bit after waiting
>>> for it, as it is masked so the irq doesn't get sent. Failing to clear
>>> the pending interrupt means all subsequent waits for that interrupt
>>> after the first do not actually wait for an interrupt genreated by the
>>> device.
>>>
>>> This affects the multiple_transfers tests, they never actually verify
>>> more than one interrupt is generated. So for those tests, enable the
>>> msix vectors for the queue interrupts so they are delivered and the
>>> pending bit is cleared.
>>>
>>> Add assertions to ensure the masked pending tests are not used to test
>>> an interrupt multiple times.
>>>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    tests/qtest/libqos/e1000e.h |   8 +++
>>>    tests/qtest/e1000e-test.c   |   2 +
>>>    tests/qtest/igb-test.c      |   2 +
>>>    tests/qtest/libqos/e1000e.c | 113 +++++++++++++++++++++++++++++++++++-
>>>    4 files changed, 122 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
>>> index 30643c80949..6cc1a9732b1 100644
>>> --- a/tests/qtest/libqos/e1000e.h
>>> +++ b/tests/qtest/libqos/e1000e.h
>>> @@ -25,6 +25,9 @@
>>>    #define E1000E_RX0_MSG_ID           (0)
>>>    #define E1000E_TX0_MSG_ID           (1)
>>>    
>>> +#define E1000E_RX0_MSIX_DATA        (0x12345678)
>>> +#define E1000E_TX0_MSIX_DATA        (0xabcdef00)
>>> +
>>>    #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
>>>    
>>>    typedef struct QE1000E QE1000E;
>>> @@ -40,6 +43,10 @@ struct QE1000E_PCI {
>>>        QPCIDevice pci_dev;
>>>        QPCIBar mac_regs;
>>>        QE1000E e1000e;
>>> +    uint64_t msix_rx0_addr;
>>> +    uint64_t msix_tx0_addr;
>>   > +    bool msix_found_rx0_pending;> +    bool msix_found_tx0_pending;
>>
>> I prefer having an enum that contains E1000E_RX0_MSG_ID,
>> E1000E_TX0_MSG_ID, and "E1000E_RX0_MSG_MAX" or something similar. These
>> values can be used to create and index an array containing both rx and
>> tx, which will save redundant comparisons with E1000E_RX0_MSG_ID and
>> E1000E_RX0_MSG_ID.
> 
> Okay I'll see how that looks.
> 
>>
>>>    };
>>>    
>>>    static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, uint32_t val)
>>> @@ -57,5 +64,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
>>>    void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
>>>    void e1000e_tx_ring_push(QE1000E *d, void *descr);
>>>    void e1000e_rx_ring_push(QE1000E *d, void *descr);
>>> +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocator *alloc);
>>>    
>>>    #endif
>>> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
>>> index a69759da70e..4921a141ffe 100644
>>> --- a/tests/qtest/e1000e-test.c
>>> +++ b/tests/qtest/e1000e-test.c
>>> @@ -185,6 +185,8 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
>>>            return;
>>>        }
>>>    
>>> +    /* Triggering msix interrupts multiple times so must enable vectors */
>>> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
>>>        for (i = 0; i < iterations; i++) {
>>>            e1000e_send_verify(d, data, alloc);
>>>            e1000e_receive_verify(d, data, alloc);
>>> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
>>> index 2f22c4fb208..06082cbe7ff 100644
>>> --- a/tests/qtest/igb-test.c
>>> +++ b/tests/qtest/igb-test.c
>>> @@ -188,6 +188,8 @@ static void test_igb_multiple_transfers(void *obj, void *data,
>>>            return;
>>>        }
>>>    
>>> +    /* Triggering msix interrupts multiple times so must enable vectors */
>>> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
>>>        for (i = 0; i < iterations; i++) {
>>>            igb_send_verify(d, data, alloc);
>>>            igb_receive_verify(d, data, alloc);
>>> diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
>>> index 925654c7fd4..7b7e811bce7 100644
>>> --- a/tests/qtest/libqos/e1000e.c
>>> +++ b/tests/qtest/libqos/e1000e.c
>>> @@ -19,6 +19,7 @@
>>>    #include "qemu/osdep.h"
>>>    #include "hw/net/e1000_regs.h"
>>>    #include "hw/pci/pci_ids.h"
>>> +#include "hw/pci/pci_regs.h"
>>>    #include "../libqtest.h"
>>>    #include "pci-pc.h"
>>>    #include "qemu/sockets.h"
>>> @@ -77,16 +78,77 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
>>>        g_free(dev);
>>>    }
>>>    
>>> +static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
>>> +                                 uint64_t guest_msix_addr,
>>> +                                 uint32_t msix_data)
>>> +{
>>> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
>>> +    QPCIDevice *pci_dev = &d_pci->pci_dev;
>>> +
>>> +    if (msg_id == E1000E_RX0_MSG_ID) {
>>> +        g_assert(!d_pci->msix_found_rx0_pending);
>>> +    } else if (msg_id == E1000E_TX0_MSG_ID) {
>>> +        g_assert(!d_pci->msix_found_tx0_pending);
>>> +    } else {
>>> +        /* Must enable MSI-X vector to test multiple messages */
>>> +        g_assert_not_reached();
>>> +    }
>>
>> This assertions are somewhat tricky. If there is something that sets the
>> Pending Bit and we are not aware of it, d_pci->msix_found_rx0_pending
>> and d_pci->msix_found_tx0_pending will be left cleared and assertions
>> will not fire.
>>
>> I think asserting that the message is not masked is easier and less
>> error-prone.
> 
> I don't understand what you mean. I allow the masked case
> to be used, but only for 1 irq. It is only the multiple case
> where we unmask.
> 
> If you do not expect the irq to be raised, then you should
> add an assert for !e1000e_test_msix_irq().

For example, think of the case where E1000E_RX0_MSG_ID is accidentally 
fired due to a bug in the emulation or test code. This interrupt is 
unintentional, so there is no corresponding call of 
e1000e_test_msix_irq(). This interrupt is followed by an operation that 
is intended to fire E1000E_RX0_MSG_ID and this is expected to be 
confirmed with e1000e_test_msix_irq().

In this case, e1000e_test_msix_irq() will not properly ensure the 
presence of the latter interrupt because the Pending Bit is set by the 
earlier one. g_assert(!d_pci->msix_found_rx0_pending) is intended to 
detect the Pending Bit set earlier, but it is ineffective in this case 
because e1000e_test_msix_irq() is not called for the earlier interrupt 
and d_pci->msix_found_rx0_pending is not set. In this sense, this 
assertion is incomplete.

Instead of having such assertions, we can unmask MSI-X vectors when 
testing interrupts. I also expect there will be less amount of code in 
this way because it will save the msix_found_rx0_pending and 
msix_found_tx0_pending flags and corresponding assertions.

Regards,
Akihiko Odaki


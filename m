Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD70E77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 09:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOvkm-0006U7-FR; Sat, 21 Dec 2024 04:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOvkl-0006Tt-1G
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 04:26:31 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOvki-0004uk-R6
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 04:26:30 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2161eb95317so26273775ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1734773187; x=1735377987;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxwW8xn/ATbUosV3FR7da4FU6GwDEhP1ZPSYI+WI1JE=;
 b=Ea/0hB7TbUQtig51kE7ok9kra/CTNBV951Ql3hvnqKh1qTvqwqPWVjIEnU1SvFnB2R
 u5PF1ylM8027bHPG4/dm/sfV55wG1EouzAZBIe30HilmIVqOjvA3eMG8K7y7KxZT4aU4
 cxgq3Cy19WIyUJr9mru/NGZINZ0HjSlgsMK2jZyBCkXaE2e0V5vG6YboVy1eAfnHZ9wX
 OcVBRqFBirWsg27qTbV3c+fsRUma/SQeTZDlm0HZklVxTL5dY+HqrqPRAw7tt3fgbZck
 aXjFk0kweAlJmkHMGyxduGJyRMs8VHaEvWBnrqdZDl7QJfVLuGNly4mxW5L+XupFUZ26
 AzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734773187; x=1735377987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxwW8xn/ATbUosV3FR7da4FU6GwDEhP1ZPSYI+WI1JE=;
 b=nem7B+9BMskZ78uP93JtxU0jN+ukMUlHh22PC55f/t/p7NArgFClh7ZQfga70DEc0R
 I7zKIK9lX5TFUJgcqi1X3Q4s8Rp06xVQGf1ggikZPCil2OzMvkpdewg731PCSNjz2IRS
 jrJ/wd2pwi+NVGXPIXo0bbyWhsJbgmxYKpcH1iNrd1wpoXhuiI4K7J6oY0oRuvoGL+Mu
 Y3G5oKkU9014o2bv+77dBBi97cG9ggee3YcstAGyV8WDh0T5IQDFNRtx/QIG7Zp1FKUW
 XSq3Kx5QxAwMjvENzQul+MO1ArDEnN6OwsRb+PTgWKh55vEitouEoFofSilUoPtXZ+7d
 7pRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXcx9mbCTAAZS4eFDyweLk3/a3uei2mO5BhM+ox9GMwUhAdZi6V09BmGN5fjC37yO0LM8O2G15xA1m@nongnu.org
X-Gm-Message-State: AOJu0Yz/j++JVwSFy3XjrRBb/tzcqhaFNK/ldfmj/EUJaEWv+sP5yi2n
 dMxMMzrXYo8K+1Ky6UbvrUV/YExx8FYaL+tax70iSOzPxWAMO7Kwo5+K38+6qPw=
X-Gm-Gg: ASbGnctA/PxKNNClFle2NNV8iJtqpl0qsfIrdRPe4zy9TuqnJlI9aFukk8jRGzXcngT
 FF+aeXzaacCYyDQI0qfzYuXhUCrNrcFRKIYdaet8IQawwbHlwnqETNbR7HUfZ/36oi7tCBBls4F
 RhtA52bl5ZnO6Ge2wQFy4nX/Jap7QLJTRkQSWTqYtYw8IDi79QXFIyBe8rVFIeFSOfDxk0Ac1rJ
 JbuUi002DbBvM37lH16P8Yx3jAA1Mkvjn9jFC6/gIson1+IFF6qM0gllLnbhca3otGMiQ==
X-Google-Smtp-Source: AGHT+IG1A4VS95Jk2+YpBjK1PReUnCKVwhNk1lbQqRqLpszJvBLQCPs3ro/ly/Y7F5qIp6rUZGP75g==
X-Received: by 2002:a17:903:186:b0:216:7ee9:2235 with SMTP id
 d9443c01a7336-219e6f14499mr71823495ad.43.1734773186967; 
 Sat, 21 Dec 2024 01:26:26 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca023a3sm40900705ad.250.2024.12.21.01.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 01:26:26 -0800 (PST)
Message-ID: <9ac25c75-f681-4537-9ed8-248340f2e677@daynix.com>
Date: Sat, 21 Dec 2024 18:26:23 +0900
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
 <c88dd8a9-bf21-4950-a91d-37fe18516ba5@daynix.com>
 <D6H864XV1LS0.1UMX4CPO9AT5T@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <D6H864XV1LS0.1UMX4CPO9AT5T@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2024/12/21 17:11, Nicholas Piggin wrote:
> On Sat Dec 21, 2024 at 2:26 PM AEST, Akihiko Odaki wrote:
>> On 2024/12/21 13:14, Nicholas Piggin wrote:
>>> On Thu Dec 19, 2024 at 6:53 PM AEST, Akihiko Odaki wrote:
>>>> On 2024/12/18 16:42, Nicholas Piggin wrote:
>>>>> The e1000e and igb tests don't clear the msix pending bit after waiting
>>>>> for it, as it is masked so the irq doesn't get sent. Failing to clear
>>>>> the pending interrupt means all subsequent waits for that interrupt
>>>>> after the first do not actually wait for an interrupt genreated by the
>>>>> device.
>>>>>
>>>>> This affects the multiple_transfers tests, they never actually verify
>>>>> more than one interrupt is generated. So for those tests, enable the
>>>>> msix vectors for the queue interrupts so they are delivered and the
>>>>> pending bit is cleared.
>>>>>
>>>>> Add assertions to ensure the masked pending tests are not used to test
>>>>> an interrupt multiple times.
>>>>>
>>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>> ---
>>>>>     tests/qtest/libqos/e1000e.h |   8 +++
>>>>>     tests/qtest/e1000e-test.c   |   2 +
>>>>>     tests/qtest/igb-test.c      |   2 +
>>>>>     tests/qtest/libqos/e1000e.c | 113 +++++++++++++++++++++++++++++++++++-
>>>>>     4 files changed, 122 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
>>>>> index 30643c80949..6cc1a9732b1 100644
>>>>> --- a/tests/qtest/libqos/e1000e.h
>>>>> +++ b/tests/qtest/libqos/e1000e.h
>>>>> @@ -25,6 +25,9 @@
>>>>>     #define E1000E_RX0_MSG_ID           (0)
>>>>>     #define E1000E_TX0_MSG_ID           (1)
>>>>>     
>>>>> +#define E1000E_RX0_MSIX_DATA        (0x12345678)
>>>>> +#define E1000E_TX0_MSIX_DATA        (0xabcdef00)
>>>>> +
>>>>>     #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
>>>>>     
>>>>>     typedef struct QE1000E QE1000E;
>>>>> @@ -40,6 +43,10 @@ struct QE1000E_PCI {
>>>>>         QPCIDevice pci_dev;
>>>>>         QPCIBar mac_regs;
>>>>>         QE1000E e1000e;
>>>>> +    uint64_t msix_rx0_addr;
>>>>> +    uint64_t msix_tx0_addr;
>>>>    > +    bool msix_found_rx0_pending;> +    bool msix_found_tx0_pending;
>>>>
>>>> I prefer having an enum that contains E1000E_RX0_MSG_ID,
>>>> E1000E_TX0_MSG_ID, and "E1000E_RX0_MSG_MAX" or something similar. These
>>>> values can be used to create and index an array containing both rx and
>>>> tx, which will save redundant comparisons with E1000E_RX0_MSG_ID and
>>>> E1000E_RX0_MSG_ID.
>>>
>>> Okay I'll see how that looks.
>>>
>>>>
>>>>>     };
>>>>>     
>>>>>     static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, uint32_t val)
>>>>> @@ -57,5 +64,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
>>>>>     void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
>>>>>     void e1000e_tx_ring_push(QE1000E *d, void *descr);
>>>>>     void e1000e_rx_ring_push(QE1000E *d, void *descr);
>>>>> +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocator *alloc);
>>>>>     
>>>>>     #endif
>>>>> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
>>>>> index a69759da70e..4921a141ffe 100644
>>>>> --- a/tests/qtest/e1000e-test.c
>>>>> +++ b/tests/qtest/e1000e-test.c
>>>>> @@ -185,6 +185,8 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
>>>>>             return;
>>>>>         }
>>>>>     
>>>>> +    /* Triggering msix interrupts multiple times so must enable vectors */
>>>>> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
>>>>>         for (i = 0; i < iterations; i++) {
>>>>>             e1000e_send_verify(d, data, alloc);
>>>>>             e1000e_receive_verify(d, data, alloc);
>>>>> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
>>>>> index 2f22c4fb208..06082cbe7ff 100644
>>>>> --- a/tests/qtest/igb-test.c
>>>>> +++ b/tests/qtest/igb-test.c
>>>>> @@ -188,6 +188,8 @@ static void test_igb_multiple_transfers(void *obj, void *data,
>>>>>             return;
>>>>>         }
>>>>>     
>>>>> +    /* Triggering msix interrupts multiple times so must enable vectors */
>>>>> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
>>>>>         for (i = 0; i < iterations; i++) {
>>>>>             igb_send_verify(d, data, alloc);
>>>>>             igb_receive_verify(d, data, alloc);
>>>>> diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
>>>>> index 925654c7fd4..7b7e811bce7 100644
>>>>> --- a/tests/qtest/libqos/e1000e.c
>>>>> +++ b/tests/qtest/libqos/e1000e.c
>>>>> @@ -19,6 +19,7 @@
>>>>>     #include "qemu/osdep.h"
>>>>>     #include "hw/net/e1000_regs.h"
>>>>>     #include "hw/pci/pci_ids.h"
>>>>> +#include "hw/pci/pci_regs.h"
>>>>>     #include "../libqtest.h"
>>>>>     #include "pci-pc.h"
>>>>>     #include "qemu/sockets.h"
>>>>> @@ -77,16 +78,77 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
>>>>>         g_free(dev);
>>>>>     }
>>>>>     
>>>>> +static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
>>>>> +                                 uint64_t guest_msix_addr,
>>>>> +                                 uint32_t msix_data)
>>>>> +{
>>>>> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
>>>>> +    QPCIDevice *pci_dev = &d_pci->pci_dev;
>>>>> +
>>>>> +    if (msg_id == E1000E_RX0_MSG_ID) {
>>>>> +        g_assert(!d_pci->msix_found_rx0_pending);
>>>>> +    } else if (msg_id == E1000E_TX0_MSG_ID) {
>>>>> +        g_assert(!d_pci->msix_found_tx0_pending);
>>>>> +    } else {
>>>>> +        /* Must enable MSI-X vector to test multiple messages */
>>>>> +        g_assert_not_reached();
>>>>> +    }
>>>>
>>>> This assertions are somewhat tricky. If there is something that sets the
>>>> Pending Bit and we are not aware of it, d_pci->msix_found_rx0_pending
>>>> and d_pci->msix_found_tx0_pending will be left cleared and assertions
>>>> will not fire.
>>>>
>>>> I think asserting that the message is not masked is easier and less
>>>> error-prone.
>>>
>>> I don't understand what you mean. I allow the masked case
>>> to be used, but only for 1 irq. It is only the multiple case
>>> where we unmask.
>>>
>>> If you do not expect the irq to be raised, then you should
>>> add an assert for !e1000e_test_msix_irq().
>>
>> For example, think of the case where E1000E_RX0_MSG_ID is accidentally
>> fired due to a bug in the emulation or test code. This interrupt is
>> unintentional, so there is no corresponding call of
>> e1000e_test_msix_irq(). This interrupt is followed by an operation that
>> is intended to fire E1000E_RX0_MSG_ID and this is expected to be
>> confirmed with e1000e_test_msix_irq().
>>
>> In this case, e1000e_test_msix_irq() will not properly ensure the
>> presence of the latter interrupt because the Pending Bit is set by the
>> earlier one. g_assert(!d_pci->msix_found_rx0_pending) is intended to
>> detect the Pending Bit set earlier, but it is ineffective in this case
>> because e1000e_test_msix_irq() is not called for the earlier interrupt
>> and d_pci->msix_found_rx0_pending is not set. In this sense, this
>> assertion is incomplete.
> 
> I think this scenario can not be detected even if we unmask, because
> we can never distinguish the unintended interrupt from the intended
> one.
> 
> The test case will always have to assert(!e1000e_tests_msix_irq())
> before deliberately raising an interrupt if it wanted to be sure there
> are no earlier unintended ones.
> 
>> Instead of having such assertions, we can unmask MSI-X vectors when
>> testing interrupts. I also expect there will be less amount of code in
>> this way because it will save the msix_found_rx0_pending and
>> msix_found_tx0_pending flags and corresponding assertions.
> 
> We could always unmask, yes it would be less code. I just thought it
> was neat to be able to test both paths. But that might be better left
> to a msix specific test.

Indeed, I also think the code testing the masked case should be 
separated from e1000e_test_msix_irq(). Such a test will not need the 
msix_found_tx0_pending and msix_found_tx0_pending flags as it is obvious 
that MSI-X is masked.

Regards,
Akihiko Odaki


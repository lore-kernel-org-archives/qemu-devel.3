Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E03FEC11A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 22:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w59mN-0006uL-9D; Tue, 24 Mar 2026 17:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w59mL-0006u7-Lh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 17:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w59mK-00024s-0t
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 17:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774389550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RgHvNiD185xEqpGUSswTduE5j/Q3ciaSSr2eF4yqY3w=;
 b=LizSD9X7mC3XOrjT+whVc79kUBq6zfFVfhpbpkyDYgeE4fkoz7uEnGOtFKXAAU7EIzbThf
 MnfbTjO4luKLDph1nfYr4xtt9Qwa/lLYvSD8eIXlKt9Hz2A5eEP0Npe30jyQyN9n5HGNX6
 SVaS3i30Ir9Ah0HYwxAcwmqvfTtKi14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-HyP2pkg7P7iAIr9hRvjyuQ-1; Tue, 24 Mar 2026 17:59:08 -0400
X-MC-Unique: HyP2pkg7P7iAIr9hRvjyuQ-1
X-Mimecast-MFC-AGG-ID: HyP2pkg7P7iAIr9hRvjyuQ_1774389547
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b41d45be4so210800f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774389547; x=1774994347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RgHvNiD185xEqpGUSswTduE5j/Q3ciaSSr2eF4yqY3w=;
 b=l93d5usCgHCrEtW6opvmTZNCjlKUcMSVx9gvn1oRwgDb2zWMkSrcK0cmZ5Zi83Dnjd
 309Nzn3nVPRY21WlZrIDlYRkO2ejZ7dRpLOKTZjUHdZoy/rIJOIeHpRnAq2bd3aFZNtK
 mvYV4adG+ncHFZdTOLO1Qopf4Wd2oY0UPL3BvilW/GBTmWcJKSpDnVl4+NlZ8dotuhpn
 FhW2COOT4pPYk+2wY7NO7mFDrJercsDUjsfpertYz0DF2zvC/UH0OO6COybW5tLZpCC5
 WjwKgg/VbFddBFtMe41sg9fJneF8weAP1+Q0Fg6zRHF83XjlSQ3LxQeoCgDJ4yrY6vtE
 oePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774389547; x=1774994347;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgHvNiD185xEqpGUSswTduE5j/Q3ciaSSr2eF4yqY3w=;
 b=QAo0lHipAr6rT1AcC+BM3r2GEQLvuVQBa1kX7dP9dU6MIxzvaN0yeAst4VYkpffgms
 7Zbk96qb9RljMUjInAoJvX4KaZoxPssDmDWh9amBEuTOJz7L/O8TcyGUhTo7hiGtOaep
 Z2fruf+NTXSdCBZZj1rfOucQbuBAB7AtlrjEISBUojmk2FAKGV35fje1pncDTBM5FKUm
 /m7QXo0Vo96g5XBoPrieNu+zPmH0/MttaDQ6TxyxfSAsZo3GuNFdvmBOAcKd/eh6sffl
 F+faGZ6LgouEBpPurPwUl8t9YmFJWuqW6HQAAbKEffCYwxjkusK1wEHdIvd8pljVoMFp
 MaKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVgyWrqZ+0Ptjjhpsu21d8LoJMfgRSLFTQOem2g6jJxax5cju+rK2bCJFtPvNOdhBFywYzlMCoIeva@nongnu.org
X-Gm-Message-State: AOJu0YwDJWoQFZBenIYRdul0xMnxv4DwTw2J7JnojqT5NzXcESdSwq2m
 MJM1mHVbCTrYj11smF9V97cC//lBwF0wIRpVPLFGSFxcAxzcsJ6RlrdvJk3bi1UZe6cY8Omz4bo
 H/JHzykllYU8JrTYieNnex30B/Cs1HxVWot69Nh8vXvBv/A+TdtOw9zDVbqXzSi59
X-Gm-Gg: ATEYQzwUYmeTQXPyRaX+F3KTQ/Fs+Q4GxDDPPpWJSbkVa/jehCESINBSfPNCEflTkUy
 Eqvlqo88GQPxcZZPaDL5BbBvMa2NfUGNJdGXKiSkUzOk0xO5HKffMHDoFJ7blE0VONw+C/joPHJ
 8q/sGmm5iTZUUGvj8BRbBnoreihJMECVn/5J9XLipX0OdAzFDtAu90CD6Fbbq4Qq5zYjQQHB0Te
 9UvDAnnMw9rnI77MJl9qPXYBwblHyLLNQwuONYF4/bBbHjWBu5XZ7ZgHQ7vJ4sH56Jb/0R4/uDz
 aPYZm1ocfv/KBtaHTW0IH1uTOVBWi3wWvV9qsYqFIQh3y86OsqyhYXT9RuHHz0WEPbky5lkfdOu
 nRFi1fpIIP85l3rd5aYcGCDnt0UcdkKaaTCQMGq8M3WrWvg+eL11KxyMf0F9e
X-Received: by 2002:a05:6000:280d:b0:437:7300:eb1c with SMTP id
 ffacd0b85a97d-43b805b1c82mr5155335f8f.26.1774389546769; 
 Tue, 24 Mar 2026 14:59:06 -0700 (PDT)
X-Received: by 2002:a05:6000:280d:b0:437:7300:eb1c with SMTP id
 ffacd0b85a97d-43b805b1c82mr5155319f8f.26.1774389546305; 
 Tue, 24 Mar 2026 14:59:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd0dcsm40599133f8f.11.2026.03.24.14.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 14:59:05 -0700 (PDT)
Message-ID: <a5dead7f-719a-4398-a0c0-a42bb5b53664@redhat.com>
Date: Tue, 24 Mar 2026 22:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/27] hw/net/ftgmac100: Improve DMA error handling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260323165218.96607-1-philmd@linaro.org>
 <20260323165218.96607-26-philmd@linaro.org>
 <37e7a5da-9fa5-4602-97f4-d3190f638b01@redhat.com>
 <e5d54af3-e3c7-453c-b087-d0699d5241e2@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e5d54af3-e3c7-453c-b087-d0699d5241e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/24/26 20:21, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> On 24/3/26 09:03, Cédric Le Goater wrote:
>> Hello,
>>
>> On 3/23/26 17:52, Philippe Mathieu-Daudé wrote:
>>> From: Cédric Le Goater <clg@redhat.com>
>>>
>>> Currently, DMA memory operation errors in the ftgmac100 model are not
>>> all tested and this can lead to a guest-triggerable denial of service
>>> as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.
>>>
>>> To fix this, check the return value of ftgmac100_write_bd() in the TX
>>> path and exit the TX loop on error to prevent further processing. In
>>> the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
>>> flag as appropriate.
>>>
>>> The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
>>> AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
>>> Nevertheless, since it is supported by the Linux driver and it should
>>> be safe to use in the QEMU implementation across all SoCs.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
>>
>>
>> Philippe,
>>
>> You can certainly apply the fixes, but I don't see any email from you
>> about it. However, I indicated that I was applying it to aspeed-next
>> as part of this series:
>>
>>    https://lore.kernel.org/qemu-devel/20260323125545.577653-1- clg@redhat.com/
>>
>> There is reason for it. The SMC patch is required to fix issue 3335.
>> The patch should say so, I agree. My bad.
>>
>> I see that some VFIO patches are also included. I appreciate your help,
>> but please contact the maintainers before, I believe I am responsive
>> enough to requests ? I will rework the aspeed PR I had prepared
>> and update the VFIO tree.
> 
> I understood your aspeed-next branch was for the first queue to apply
> after 11.0, not for fixes before, and this one felt worthwhile fix.
> Indeed I should have replied to the patch with that justification
> and you'd have cleared any doubts. I apologize for having stepped over
> your maintenance area. This shouldn't reproduce.

I am sure it will :) No harm done. Just some slight frustration
on my side.

Cheers,

C.



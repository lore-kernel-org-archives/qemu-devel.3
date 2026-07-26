Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216EAC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 09:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnuyq-0002Y7-KA; Sun, 26 Jul 2026 05:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wnuyg-0002WR-ST
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 05:17:00 -0400
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wnuye-0005Pk-49
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 05:16:57 -0400
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf49dc298bso19722525ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785057414; x=1785662214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EAE+jyqEL9oR8OfraxbI5YKeewSRrwjZxO3fH6CCJTg=;
 b=U/vmM34ZB/45PegzugXLV38uP2PLeGwAR2Y6CMSWqUg82+EbLt/Kcr2pY+iyHnCWNU
 Izxuq+ilNu2tjhNfG3pYpioUCdSapydBPDZmkkkd9Ug9zv2jSvu0F1UTiL+kh0PT/pXb
 BJKAEz1icVqzuywqxCm+pQHiZWha6GxUBuZ6W+U6cshJk3m0TEsu2OJEJCILasBuXbrq
 SQJTDjmAVrHM68ZpE34aALbj4E3ZE8HsGrVUDXjHNRWZgD1D7440iK0rYDaspCOCxrH0
 k6MpLlbrveGHcV0ndQfDgwrv+tOi1hOU7UgV05uwoTI8QtcH8ZRKnNj1gyCYmm4zCwRA
 yBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785057414; x=1785662214;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAE+jyqEL9oR8OfraxbI5YKeewSRrwjZxO3fH6CCJTg=;
 b=UoHC1PWXOY5X9IoApXm3KN8igEh9a3nRcbDi3xkevzS/wRLS7TegLhq/rZn/jI1QNA
 wqbUSzum3HNmswnMtFinh9Vo8hUTifbG6wnkJu45JxTHRf/yT1SrYVJ93iDI+305gQsh
 JY21YvMSx57/Xqfhg8DY2Dd8SJNtjeIU6vl1ggrM3mNx2icxjd8yQj18Jduyhf6ZlAgq
 g38mnyFW9p8SZ3IKIZt9HRzd8g6J6bTqu5GNkZ4Og0h+UOT+UFW++n54HIwUXrAmOMQd
 6Qz2NP8gyADntp6yCWwiYvpD1it2OpMa4JP4PvAX2qI1pEG3Q9fiFoc+fRpgDQfk5uy3
 Q6Zg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPvmrDruBKxYhOKc1cVJrwZfgNLmQDl7zLJgVcyDvdwaBs5G0tAm1+qpa8GmLCcedvzaoN1glJa1MV@nongnu.org
X-Gm-Message-State: AOJu0Yzfqvqgo2mk+E/WhWWjBzr/PSncGcoHutvuEK7kwyOviDgQWV/N
 ouiF5ykGIrh/O8bJzvjh5Tr4hnTheEqU+B6sBqZ5pcf7XpBLyVhvyrU=
X-Gm-Gg: AR+sD13ZY873MczSJmVdO31oEQSz2CCkxK1AnyKwxvwTpTPehKwoelhMcv2vwYNgmwx
 +aNIRoI2J9sevjEGqYgOn2npJmETY3bHct2gltWGdwm6E3Xzr2aNSGdatdmjyUQ5ujilPsq11Cn
 wxuoSi4h2cY7dY+3+7UKN4cURl+2dOsflGzfYs6RnjPkA9qyJ6pCFf18H2RgSGoQTisbHOKnQGu
 9rQLVofUFefps5ek+kIrg1Mz40FpBeuGud9dKp4VmwWpVBJPpuyvk8U2/v2aKOvH1ncO86mOMq4
 D5ZYJctR0e1BmxLEyjzbZbQTZDFPM4icw6+hUiBrB4Qn8gazGBQQOaWeovNsRSeyNa+sHqPEcY9
 zjmO3ts6z2GR2e15Nr/thu7yKBppa2VnNESYhea5eZnFkdEFnKAlCOWz9QKh6Vq8oDeG5IEPCLQ
 Fc/F+fYQrPBigTBdeA0h0H3N7xV4QYYKR1wPmCnLSOkIGB6GBkmI8yXwmKGw==
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1b:d0b3 with SMTP id
 adf61e73a8af0-3c67e026f9dmr4396021637.62.1785057414063; 
 Sun, 26 Jul 2026 02:16:54 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:38f6:5714:f0df:99c3?
 ([2408:820c:8ffa:c0f0:38f6:5714:f0df:99c3])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc415eafsm19055702eec.7.2026.07.26.02.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 02:16:53 -0700 (PDT)
Message-ID: <5bb70c1f-d4c7-4361-b93c-acd2d0616b2e@gmail.com>
Date: Sun, 26 Jul 2026 17:16:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] xen/igd: get PCH info from host sysfs
To: Chuck Zmudzinski <brchuckz@netscape.net>,
 Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20260709183517.25866-1-brchuckz@aol.com>
 <20260709183517.25866-2-brchuckz@aol.com>
 <5cb8d286-f013-4400-aef4-baddaa775995@gmail.com>
 <dda25bc4-6d3c-4f36-94e0-ffdc8b9bc81d@netscape.net>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <dda25bc4-6d3c-4f36-94e0-ffdc8b9bc81d@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::a;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x0a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



On 2026-07-25 12:19, Chuck Zmudzinski wrote:
> On 7/23/2026 9:09 AM, Tomita Moeko wrote:
>>> ...
>>> Also, use errp in xen_igd_passthrough_isa_bridge_create
>>> to set errors from xen_pt_get_host_pch_info.
>>>
>>> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
>>> ---
>>> Changes in v2:
>>>   - call error_setg* after closing files instead of before closing
>>>     files
>>>   - in last line of commit message change "to propagate errors" to
>>>     "to set errors"
>>>   - add stable to Cc list
>>>
>>> Changes in v3:
>>>   - whitespace fix at line 380 of xen_pt_graphics.c
>>>   - fix Cc address for qemu-stable
>>>
>>>  hw/xen/xen_pt.c          |  2 +-
>>>  hw/xen/xen_pt_graphics.c | 82 ++++++++++++++++++++++++++++++++++++++--
>>>  include/hw/xen/xen_igd.h |  3 +-
>>>  3 files changed, 82 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
>>> index 0fe9c0a..474606e 100644
>>> --- a/hw/xen/xen_pt.c
>>> +++ b/hw/xen/xen_pt.c
>>> @@ -867,7 +867,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
>>>          }
>>>  
>>>          /* Register ISA bridge for passthrough GFX. */
>>> -        xen_igd_passthrough_isa_bridge_create(s, &s->real_device);
>>> +        xen_igd_passthrough_isa_bridge_create(s, &s->real_device, errp);
>>
>> The `errp` need to be handled here if any error occurs.
> 
> Do you mean calling it like this as a supported way to handle an error:
> 
>     xen_igd_passthrough_isa_bridge_create(s, &s->real_device, &error_fatal);
> 
> IIUC, that would cause Qemu to exit(1) here if there was any error.
>
> I didn't do that because I thought if there was an error one of the
> parents (pci or qdev) would handle the error appropriately since we
> are passing 'errp' from xen_pt_realize which I think comes from pci
> and qdev, but maybe not. I have not tested how an error is handled
> with this version of the patch and I am certainly no expert in how
> error handling should be done here, so thanks for alerting me to this
> question.
> 
> I have also seen in the Qemu source the use of local_err and maybe
> using &error_fatal is something like using a local_err instead of the
> errp from xen_pt_realize.
>
> I will accept any suggestions from more knowledgeable people about
> how best to handle the errors here. I can also do some tests by
> faking an error here and make sure the the error does get handled.
> I do think if the LPC bridge creation fails it should be a fatal error
> and if am reading the current code we have correctly, we currently
> just print a message to stderr if bridge creation fails without doing
> anything about that error. I also think maybe if for some reason we
> can't get a revision number for the LPC bridge, maybe that should
> not be a fatal error.

Here I mean, since you've changed the function to use errp, then it should be
handled as other function calls in xen_pt_realize() like

    xen_igd_passthrough_isa_bridge_create(s, &s->real_device, errp);
    if (errp) {
        xen_host_pci_device_put(&s->real_device);  // cleanup
        return;
    }

The realized function is called in device_set_realized() with

    dc->realize(dev, &local_err);
    if (local_err != NULL) {
        goto fail;
    }
    
In your code, if any error occurs, though it contiunes, it would be still
treated as a failure. I'm not sure if this failure would have any impact
to further steps in xen_pt_realize(), but since it ultimately fails, fail
fast is always preferred.

If you think the error can be ignored, then keep using current fprintf()
or error_report() would be the best choice.

Thanks,
Moeko

> I will make sure the next version of the patch will not be posted until
> I have verified the errors are handled appropriately.
> 
> Cheers,
> 
> Chuck



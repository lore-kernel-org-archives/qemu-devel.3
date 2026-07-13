Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A05AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDHG-0001uO-7q; Mon, 13 Jul 2026 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDH9-0001r6-4Q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDH7-0003hJ-DY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783936112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pRZT4NuvWIAeHFE2GhlNeOk0wqZ0JLM90ntjUcxEA1w=;
 b=HHPtb4rYMcFC4Zxrv8qApCrNMcb7bUmfAO2gLZ8R7j3+LsSjlPh6zw+tsmTUdKfM+GKIlD
 Rfk9X+LX1/6mdkW2uptcFgSabGDHwJWoa8oROuCrrOkTAFMNDdU4E/rG9LzC8aHIcbLSs4
 5EbCsgFMt/7CcKPGwWzruIsphNHMpDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-RtLFQLwvOc26yejeev8EPg-1; Mon, 13 Jul 2026 05:48:30 -0400
X-MC-Unique: RtLFQLwvOc26yejeev8EPg-1
X-Mimecast-MFC-AGG-ID: RtLFQLwvOc26yejeev8EPg_1783936109
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493e9ea2c77so23347705e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783936109; x=1784540909; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pRZT4NuvWIAeHFE2GhlNeOk0wqZ0JLM90ntjUcxEA1w=;
 b=FvcVBdCqSOd2v066hGQli1+ppc6JBQZqGcMxuhZI9+hsJdZukCWP0KaZBP1s2i7pvk
 2RL6e8MMxC1ZcsXY2C5ZHLa1Y83Ike2QAt2oqctSmhL8EFLaY/zst59rmD20qTdt9e+D
 +OeEJkdf8P3zjRVArpBoVd+nsG0AGSXx/azlZRm9ZRvOIqJA1F4+aDuWUQ9Wa/4PxEJW
 XgbdtGYeyX6p7+y0vuCyYFmTOxkUXYyLHkQRFdYQz9zTEeRn1FX2Bc41xdZnjyvSFVsx
 P+1HUlJEuGt4arShSHFbzOwr4A2iALgul1pdTxOyQa8ayR/8JkkMgS7FnvAEQWP4PG20
 FJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936109; x=1784540909;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pRZT4NuvWIAeHFE2GhlNeOk0wqZ0JLM90ntjUcxEA1w=;
 b=ILz0PbMbrMBV/crFLv8RurpLwMMnMk5sVZPxaz4ilhBK2Qf9plT+xEXYpjxIn0O0z+
 CN9btin9xK7fx/j6KqbWMGyFxHrF6HzzObjR0F5Xtz8TVsCs/eL0/j+1GOCsX1TqO6o4
 hriIvJJYpxmprtzupv2LFMxCppqH7EjkdOfmDBhbf85+x1L6UPgIy5VGKA+djZlaNhnh
 9n7s42F0gvpvyk6Q9+MpY+qEGfyLuAqRSICrdCxTTuA4OLDD3AA50uf1NN0MWZnrTXVm
 tpD9SpygabIVslreNfVzCbslKu8V9IkPgB9GIfKKkSGtvfNjLWJvJZaWnRumOKhF8CBI
 WTWQ==
X-Gm-Message-State: AOJu0YxObhHFIj/7UVJX5M5rKLSY/mLIuwwzqZzQ/zzIPwOogkxKJODB
 /z4D0BN5osc+4Z0FUEK5XknGWjNzq6LAbUPL//CarOOQEqcgwWH4ALxc0eJ8tPhAwDJazc7Zbgw
 zD8AQsSs2amY9/4/Z8CGyrhcjifmKWHBfgUh2a7jFISpQcrNxB8BvzyOaLhZ2463a
X-Gm-Gg: AfdE7clPSZbzZa+b90uLEaL70Ogk/Yt8G9x5yYVgju3uW0C5x/lZV1oAMkVawvKAks3
 gQA+OTNtRt6cKq8muvpf+nHmHwXoYZNr7nKu7SutS6rXXs6AVCX0pfylw/4sMyA8WI1in0YOJ9G
 iUiWoU2niW7svOGUUw0AlIvbZVUZJDeA1GioTmsq1yqLmm2xt5QyO6hHzZxHfCqYdZXplBlb9Zf
 Gb6ONSglI4aByKGYKSDTNL/KuXL8rtFewWJa8Nj50pNKfbTcd4skmydcIyoU0cxHdf/Q8NPagnL
 WhoY4N7l/Ao15sV+hJZblQ/kyNFYV50XkYg7pzgdSzYL6s5539amV0SH4jr+p1QN8ENpkjVhIRW
 AwCp5Me6BmzyYkTVm8ypP5kSecaxNOvUeV3YoaJjTBb6xnYOPcw==
X-Received: by 2002:a05:600c:8285:b0:492:41c9:886b with SMTP id
 5b1f17b1804b1-493f87e5a53mr87224045e9.14.1783936109494; 
 Mon, 13 Jul 2026 02:48:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8285:b0:492:41c9:886b with SMTP id
 5b1f17b1804b1-493f87e5a53mr87223775e9.14.1783936109070; 
 Mon, 13 Jul 2026 02:48:29 -0700 (PDT)
Received: from ?IPV6:2a01:599:b03:293:fac1:f1ba:b82b:441e?
 ([2a01:599:b03:293:fac1:f1ba:b82b:441e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e736sm88781849f8f.7.2026.07.13.02.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 02:48:28 -0700 (PDT)
Message-ID: <a150ed2f-fa0c-402c-a574-8f8a604a839d@redhat.com>
Date: Mon, 13 Jul 2026 11:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/usb/hcd-xhci: Turn guest-triggerable abort() into
 qemu_log_mask()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260710144327.600572-1-thuth@redhat.com>
 <CAFEAcA_aoctX5Cj9dUHSrt_MyzcSfN+bxHxzo+kip88Z-V0YKg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_aoctX5Cj9dUHSrt_MyzcSfN+bxHxzo+kip88Z-V0YKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/07/2026 17.35, Peter Maydell wrote:
> On Fri, 10 Jul 2026 at 15:44, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The FIXME macros in xhci_alloc_device_streams() can be triggered
>> by a (malicious) guest. Since the macro also contains an abort()
>> statement, this terminates QEMU. Turn the FIXME statements into
>> a qemu_log_mask() instead to avoid that a guest can shoot itself
>> this way.
>>
>> Reported-by: Feifan Qian <bea1e@proton.me>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3784
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/usb/hcd-xhci.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index 2cdab3ba0e4..002f801348f 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -965,11 +965,13 @@ static TRBCCode xhci_alloc_device_streams(XHCIState *xhci, unsigned int slotid,
>>            * together and make an usb_device_alloc_streams call per group.
>>            */
>>           if (epctxs[i]->nr_pstreams != req_nr_streams) {
>> -            FIXME("guest streams config not identical for all eps");
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "guest streams config not identical for all eps\n");
>>               return CC_RESOURCE_ERROR;
>>           }
>>           if (eps[i]->max_streams != dev_max_streams) {
>> -            FIXME("device streams config not identical for all eps");
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "device streams config not identical for all eps\n");
>>               return CC_RESOURCE_ERROR;
> 
> I get the impression from the comment that these cases are not
> guest errors, but unimplemented QEMU support for a corner case
> of the spec, so should be LOG_UNIMP. I had a quick look through
> the XHCI spec, and it seems to define the streams handling
> purely as a per-endpoint thing, making it valid for a device
> to have multiple endpoints with different max streams settings.
> It's just that it doesn't happen in practice so we haven't
> implemented the "group identical endpoints and call
> usb_device_alloc_streams for each group" solution the comment
> sketches out.
> 
> Incidentally, there is just one remaining use of the FIXME macro
> in this file: the "unhandled USB_RET_*" default case in
> xhci_try_complete_packet(). I think we could (as a separate patch)
> replace that with g_assert_not_reached(), because the function
> handles all the USB_RET_* values except for USB_RET_ADD_TO_QUEUE and
> USB_RET_REMOVE_FROM_QUEUE, which are both internal return
> values for when an async packet needs to be queued or dequeued,
> and which (I believe) shouldn't still be the status by the time we
> get to this function.
> 
> There's also one raw printf that should be a LOG_UNIMP:
>          fprintf(stderr, "xhci: FIXME: secondary streams not implemented yet");
Thanks, Peter, these are good suggestions, I'll send a v3 and patches for 
the other things that you've spotted.

  Thomas



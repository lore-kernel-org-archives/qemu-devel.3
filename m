Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38283C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCPS-0000ah-V6; Fri, 10 Jul 2026 10:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wiCPI-0000aA-LI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wiCPF-0004x4-P3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783694443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0V4nuntP4ZVVntCf4uXAKMupjDf67pXY9SlJjDoZw2M=;
 b=TVz3xCTCtOn5Vzg8wbEwBpU8B5dpfdhGO1p4s7eB8LX1UuY/0qcvE71SN0q9vDn2jFubh6
 N/KQ0nzHcrx90uVF7mD4pXBzaZKCk7AmesT5NVCXhgPSD1+XmdQRJ/LK7bv1GtMLhKxOKX
 DdpKujNXk6e69+SW/XYeEn+BY786xDs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-EDIL_8uCOP-xMxvk9_lgNw-1; Fri, 10 Jul 2026 10:40:39 -0400
X-MC-Unique: EDIL_8uCOP-xMxvk9_lgNw-1
X-Mimecast-MFC-AGG-ID: EDIL_8uCOP-xMxvk9_lgNw_1783694439
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso4878765e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783694438; x=1784299238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0V4nuntP4ZVVntCf4uXAKMupjDf67pXY9SlJjDoZw2M=;
 b=HWhMV0ZemalJoiCspcHoidC1BQpOhm+hyGSWVQONpUjMFK6LIiv9zpynhWPPf2aXNg
 mGKx28CM1ex892fXzsqcLvhsI9v5XHt7On3iNvdMawDJifVs0ylL/P2Yd+kI/An44y7R
 isVr5JotrswgKyug00zesaOiCvQ4Ot8AwxxU1J2TPoVOfq32499aZWToOJVdqzLKrv9F
 SzYWZ7nB9G0JOILZbLSVUzex+HXZehTgp0XZMsIbiGqi8ysVPxz4kslKThqsJnYzlXyJ
 kvQQK9U8hXSIZ4GSiQUlTIZblYckKGgfw7FR5iLImv/3Pf9q75L1lPei24EQevD0BnEo
 2Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783694438; x=1784299238;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0V4nuntP4ZVVntCf4uXAKMupjDf67pXY9SlJjDoZw2M=;
 b=Mi1SGFhDittHzc3PR7scPqBofzwvoxN9uoQz/CnOanZI6n8aNK6FtSROdX9MfhlZed
 tTQKqn78OSQOxXlBdjsgP2+ioyK/9aaU8m2mi9pb6OxZGlm94NC5bPG7h6hWjBzFWFE2
 kwjkXyIA/zhk38QSOnbbjR0p5mZ541C/pjyOfd6zWND/0WsBBIf+f+/cMXl37e4YyVeO
 jbUD5nuXElAKtGR/WJrXYObCs79U36+eMFoOZDawKPq92MWywYr14/+aOyp7frt/q9ty
 njEKBnnO5ktRNCDytGW+o4Xltwv2YDF+HUIl1V5mnjblpCBuPS8KxADAjQh88zjrUHu7
 uZDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLnZ9B04g4+ghK5K/Dvjs6ipfSDbEtOVvlDlET+E65dvFZMeZkujj3zn2sCP5GhywuD8U6BA75PJEH@nongnu.org
X-Gm-Message-State: AOJu0YxYgmIhfFBSgP159saIgtv4SphCV36u6FpAgfzLXpHWemBi81oe
 RWIVbmNkkVI10ep+hu58ZbNfH7gQ3s+alMg0yB5hNIZjBmbA7yWmALF9Xsp4kezONxeq254LjCv
 sgM18hZHwnmTURwrEvdkqDCnPUolQezF64rWgOha5Sq1dQLMW1AYhbVur
X-Gm-Gg: AfdE7clRMbR3CwzsHuvjAnAmKg4jTVRtxyzF1XPLjPQ+JCkPcp0vQb+zvXuXIx36I8Z
 N6o5KRWmhzIffC5OaYrTTuOIgzm1dZVHzUKAPusBf+jHROBDeCSHOsL124Gp8QdW3GAOuZrb33b
 pTLH+z3CXPulsAiAhKSGA4ZZ2haYq8rL/U//qE0/XzZF78bR7n9Mgx2neE3jttA5SzBauxSkuZA
 fBcB4qRIpEXd1azpIN0+5xSWCyXhQv8ENf90CITy+/zaz69FLn+fI3VAVUlBFMR1sh7yRcOdUYs
 nwAdQRibWzEfRF/IdQ+gyavF2njB/8LnG13jtJHp5UDnHPjfe2PVNmbXhfbwogBTyvd6yEpNVYk
 mZazgg4yq
X-Received: by 2002:a05:600c:528e:b0:492:4363:e7eb with SMTP id
 5b1f17b1804b1-493e68f03damr123524865e9.32.1783694438524; 
 Fri, 10 Jul 2026 07:40:38 -0700 (PDT)
X-Received: by 2002:a05:600c:528e:b0:492:4363:e7eb with SMTP id
 5b1f17b1804b1-493e68f03damr123524505e9.32.1783694438127; 
 Fri, 10 Jul 2026 07:40:38 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6e8844sm158570905e9.10.2026.07.10.07.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 07:40:37 -0700 (PDT)
Message-ID: <ff2c039d-c5e3-4d49-add1-242135679958@redhat.com>
Date: Fri, 10 Jul 2026 16:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-xhci: Turn guest-triggerable abort() into
 qemu_log_mask()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260710142727.592667-1-thuth@redhat.com>
 <98470e76-bd6a-4a01-af1d-6f03ac9fcdbe@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <98470e76-bd6a-4a01-af1d-6f03ac9fcdbe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/07/2026 16.36, Philippe Mathieu-Daudé wrote:
> On 10/7/26 16:27, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The FIXME macros in xhci_alloc_device_streams() can be triggered
>> by a (malicious) guest. Since the macro also contains an abort()
>> statement, this terminates QEMU. Turn the FIXME statements into
>> a qemu_log_mask() instead to avoid that a guest can shoot itself
>> this way.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3784
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/usb/hcd-xhci.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index 2cdab3ba0e4..9ff50d0b7f9 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -965,11 +965,13 @@ static TRBCCode xhci_alloc_device_streams(XHCIState 
>> *xhci, unsigned int slotid,
>>            * together and make an usb_device_alloc_streams call per group.
>>            */
>>           if (epctxs[i]->nr_pstreams != req_nr_streams) {
>> -            FIXME("guest streams config not identical for all eps");
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "guest streams config not identical for all eps");
> 
> With trailing \n:

D'oh! Thanks!

I just noticed that I also forgot to add a "Reported-by" line to the 
description. I'll send a v2...

> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Thanks!

  Thomas



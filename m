Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F65FF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJt5z-0003EA-JW; Mon, 04 May 2026 09:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJt5x-0003D5-Fj
 for qemu-devel@nongnu.org; Mon, 04 May 2026 09:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJt5v-0001AE-EZ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 09:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777900338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mkA8xPgK3fBNtILTmFFJzACoGTv7z8Bj8WR9cXSIViI=;
 b=SMv7n3t9LtTYZ4RjZ17+qOXx73/d4qcy4JfQg8rH4ZFnbe21P4gOfJCN2kxJYLtkcoJ53p
 1fjX1/U2iaKHqKe9RZa/IyErEENuZcNtD7DGEfP9W56ukmcvreaCPc3H8hofDTPOnHn2zG
 6glq1vuMUTseqNuvycAtVn9PnbsXGIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-mQQF5_IjO3OXdX6FAMFltw-1; Mon, 04 May 2026 09:12:16 -0400
X-MC-Unique: mQQF5_IjO3OXdX6FAMFltw-1
X-Mimecast-MFC-AGG-ID: mQQF5_IjO3OXdX6FAMFltw_1777900335
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a55ecc32cso37987215e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777900335; x=1778505135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mkA8xPgK3fBNtILTmFFJzACoGTv7z8Bj8WR9cXSIViI=;
 b=KuJyXIHRvJJAXImII5XgmyLbXzx1PZs8APxOiD/KiflDrlfNgj8kMvE6gqWbW7+TgF
 ow4Tez9kOUYNiii550Bre8Qu/aOEdGT/Z/zg00VQogWAs7oHt3sbSNRpmNwTvbCZxMDy
 I2E/bKlPicGy2aOhblnoLMKORBLmTo94rSuA+o9eMzpjOjci9VwVcQYfQxBW/T4/bvIs
 oGGz8d5KgAJX333+AkBlHVYThuYabTtQPxMUBjm/6J1z5oYm4bJL3QBD3bwDFBIJ1axv
 b3P00MI+hMr1LqZyRF40E8iH0jZ2MAmxkIyK63Dc/kRY7DPwikqhiXvTSOznTRn9xWE8
 3MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777900335; x=1778505135;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkA8xPgK3fBNtILTmFFJzACoGTv7z8Bj8WR9cXSIViI=;
 b=QS2akrYgO/bFB4HW7/AzxJViedvtRWDxnhRM+DpxKYjdtG5kazRKhtQBojw9Ure7VW
 4b+DvqS5Yk4tBZm4bH/MSMfEOTnU4le/1knbr+PNlutAYEyikSKoDJwqiFaFuTQt4l5A
 QYq0JNKg5+JFvDzcw+91CblyRy1eN8RBt7iIaCkIC8Oh4abRWlaHegsKAWpPK21SHjc2
 jepN0OuzesSMD4VvxDoDrOPDlsjwBMyokBt36gayPOc0Bdhp15QBWR1pR5OdMXa/Doc/
 5Pueg7sQVx0K1ycbqXjNAmotlwjraI8j/hFna2TSs3INjxUsg+RCs825POZlKvQMKe5F
 SDIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eq1oxFWMdGgFDgN/x/MOaTSVyS9HTEVQaxVOLeoHm+8Nc++UtkV1NA6KCPqimlS4EI1u18TeCC3Tj@nongnu.org
X-Gm-Message-State: AOJu0YzMvKrMMfuGrv4nMYaFqsGiMLpZmlUSt0pRbROfzsQk/08dpFbM
 M5o4lQWzH4BdfiQLGhu2MTfpk01pNqufhbsa0+irO2t5yYETKbwYdjyfJWXUHLqvsv9Di/1XnWg
 Ovds8fe0eA2Tt3992LvshUz2ssZIIzMlq/q05M0GZv30JSDY7RRf6z4QT
X-Gm-Gg: AeBDievcCJpVRNt5gPKXN5QyIucHa5zHjWxhjSnnqSRy5eWMWt9eH0ggs1NcvR46A5W
 D2bnY0QR9IwPYztcMzIO1HDF40F7AwyDfo5s3W+6aczjimUz7uxy9NhjiOLS1k9bFv9zm/nR7Qi
 NH+qZZLN6S2oVXUUpFcz8nHLXmsyB/YBmDkdP+pd/01xfKT8eUnODbDXd3YUYQuZXG8dU37lhnn
 B2YrLyL+jzSvmJqCY/NXtXYFSlI7G9oZDRSWgLfGn8GC1/phu1SSlKSVM+AYxiGsj06Hy/IMxNm
 HPgStCjQCqg4q7S3ORC+ADbYeqwkJX8jxggsfDXm0qVhYsq4HHSwi0+Av4umCpjLXUIgyACHokO
 rUSjD/m0V9Z62RVmvpwojXaz/hq2v5aCHo+j7IYnQWu1tvAUqJIqRk5xbWgggEohkElVwCXs=
X-Received: by 2002:a05:600c:4450:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-48a98639086mr142212985e9.9.1777900335086; 
 Mon, 04 May 2026 06:12:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4450:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-48a98639086mr142212105e9.9.1777900334512; 
 Mon, 04 May 2026 06:12:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a98b768fdsm25227505f8f.33.2026.05.04.06.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 06:12:13 -0700 (PDT)
Message-ID: <1ed28a9f-ad15-4109-88f8-e7657fe33235@redhat.com>
Date: Mon, 4 May 2026 15:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, "peterx@redhat.com"
 <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <20260504025342.1452605-9-jamin_lin@aspeedtech.com>
 <67a45038-e4bb-48f8-af08-af0d5c308ece@linaro.org>
 <e45a4765-0c3d-4fc0-8080-cdad5f877a92@redhat.com>
 <d9c8bf73-70f3-4bb3-b1cc-0f64f1ee5bc2@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d9c8bf73-70f3-4bb3-b1cc-0f64f1ee5bc2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/4/26 14:42, Philippe Mathieu-Daudé wrote:
> On 4/5/26 14:17, Cédric Le Goater wrote:
>> On 5/4/26 13:18, Philippe Mathieu-Daudé wrote:
>>> On 4/5/26 04:53, Jamin Lin wrote:
>>>> When 64-bit addressing is supported, the Linux EHCI driver programs the
>>>> segment register to zero. See ehci_run function:
>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci- hcd.c
>>>>
>>>> The driver comment also notes that descriptor structures allocated from
>>>> the DMA pool use segment zero semantics.
>>>>
>>>> Descriptor memory is allocated using the DMA API. The platform driver
>>>> configures a 64-bit DMA mask so memory can be allocated above 4GB.
>>>> See ehci_platform_probe function:
>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci- platform.c
>>>>
>>>> On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.
>>>> As a result, descriptor addresses constructed directly from the guest
>>>> EHCI registers do not match the actual system address used by the
>>>> controller when fetching queue heads (QH) and queue element transfer
>>>> descriptors (qTD).
>>>>
>>>> Add a ctrldssegment-default property so platforms can provide a
>>>> descriptor address offset when constructing descriptor addresses.
>>>> This allows systems where DRAM resides above 4GB to access EHCI
>>>> descriptors correctly.
>>>>
>>>> The default value is zero, so existing machines are not affected.
>>>>
>>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>   hw/usb/hcd-ehci.h | 5 ++++-
>>>>   hw/usb/hcd-ehci.c | 1 +
>>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
>>>> index 8e6a8cdfb0..3d57e1de5f 100644
>>>> --- a/hw/usb/hcd-ehci.h
>>>> +++ b/hw/usb/hcd-ehci.h
>>>> @@ -264,6 +264,7 @@ struct EHCIState {
>>>>       uint32_t maxframes;
>>>>       bool migrate_fetch_addr_64bit;
>>>>       bool caps_64bit_addr;
>>>> +    uint32_t ctrldssegment_default;
>>>>       /*
>>>>        *  EHCI spec version 1.0 Section 2.3
>>>> @@ -322,7 +323,9 @@ struct EHCIState {
>>>>       DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
>>>>                        ehci.migrate_fetch_addr_64bit, true), \
>>>>       DEFINE_PROP_BOOL("caps-64bit-addr", _state, \
>>>> -                     ehci.caps_64bit_addr, false)
>>>> +                     ehci.caps_64bit_addr, false), \
>>>> +    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \
>>>> +                       ehci.ctrldssegment_default, 0)
>>>
>>> ctrl-ds-segment-default and ctrl_ds_segment_default?
>>>
>>> Otherwise,
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>
>> yeah. I agree. That's the general pattern for property names.
> 
> I don't get the '-default' suffix. Alternatives:
> 
> dram-segment-base-addr or even x-dram-segment-base-addr 

What ever makes sense. EHCI specs have :

   CTRLDSSEGMENT  4G Segment Selector

The purpose of the "ctrldssegment-default" property is to force
a default value of the CTRLDSSEGMENT register for the ast2700.

Jamin, how are we sure the DMAs are allocated in this 4G segment ?
because RAM covers 8G :

       0000000400000000-00000005ffffffff (prio 0, ram): ram


> since I still believe this is a AST2700 issue, likely not mapping 
> RAM appropriately.

Other controllers would be impacted no ?
Linux (upstream) forces the CTRLDSSEGMENT value :

	/*
	 * hcc_params controls whether ehci->regs->segment must (!!!)
	 * be used; it constrains QH/ITD/SITD and QTD locations.
	 * dma_pool consistent memory always uses segment zero.
	 * streaming mappings for I/O buffers, like dma_map_single(),
	 * can return segments above 4GB, if the device allows.
	 *
	 * NOTE:  the dma mask is visible through dev->dma_mask, so
	 * drivers can pass this info along ... like NETIF_F_HIGHDMA,
	 * Scsi_Host.highmem_io, and so forth.  It's readonly to all
	 * host side drivers though.
	 */
	hcc_params = ehci_readl(ehci, &ehci->caps->hcc_params);
	if (HCC_64BIT_ADDR(hcc_params)) {
		ehci_writel(ehci, 0, &ehci->regs->segment);       <------- here
#if 0
// this is deeply broken on almost all architectures
		if (!dma_set_mask(hcd->self.controller, DMA_BIT_MASK(64)))
			ehci_info(ehci, "enabled 64bit DMA\n");
#endif
	}


C.



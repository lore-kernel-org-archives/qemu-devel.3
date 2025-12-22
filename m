Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A5CE6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 08:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXb6U-0005hH-7n; Mon, 22 Dec 2025 03:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vXb6R-0005gq-Qm
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 03:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vXb6Q-0003TZ-29
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 03:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766391433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xY28O+YYGl8at648EVdr5VQmmnxCuVd/eHbLEkV/yrQ=;
 b=DfuPJa5VJmT8A78Ak1US3Vzd4t15IgCNsgs8FZTRcMoZO0Rei1TEiERWFzuF3TuBE0WviT
 pJrUCZ+/5ItV76DjC/j1Xt480ipeb3i2n7UciEOPpjqshhCVL1OFbaWqh3otvCrQiN1Pyh
 5ru3SvhtQyd5hyqfJbi79VbwxwRRWPo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ehUkznj7MiC4zUB-dASfsA-1; Mon, 22 Dec 2025 03:17:09 -0500
X-MC-Unique: ehUkznj7MiC4zUB-dASfsA-1
X-Mimecast-MFC-AGG-ID: ehUkznj7MiC4zUB-dASfsA_1766391428
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779981523fso45150215e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766391428; x=1766996228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xY28O+YYGl8at648EVdr5VQmmnxCuVd/eHbLEkV/yrQ=;
 b=mcSsKbyCthwc+PjEU1GWzsz2pCaaUSt698gTXEv8kzQiQsL19TUufMFZbrh7misGlV
 wB5mHXNVIHEv+1RNgnOM7AzY/zjZdfHPCv77wS0uwucezNmggt1YddHUNZH1LTfidsQ1
 SlHduO0LqoRA26swrL7dzyj1OfAI+/VwNht22FqWuPdIy04JH4eN4l2QFqj+xhr1UQ/w
 fbL2E6u8QJmruD4JSgm5fDBcSMhEKwCtLz5ALwDBORB/GRuca0jtiBD7sFAhQNJhQMie
 VSEeFkLMrmBlYexljCVOdHzYfKnSI704OZlQcnzrflZbHQvEUFqQyvs7JXcQ+c6k0ydu
 OGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391428; x=1766996228;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY28O+YYGl8at648EVdr5VQmmnxCuVd/eHbLEkV/yrQ=;
 b=Srecx0KtkPctLHAE09o4K+JqLIOPq7PKgvi+HFKHM28zVGx5Ok4Ovi0uRtSCIFdQXT
 VW2TZNsoc+qBPpfsZ8JjzzZP2xfRM37xzbrEOZq+0hrHNnLn/87sRwuPZgAE0F2MY6WS
 KcrI1AQkZuhxXcWoYIomgN1z6nZyKO6m5cYQ71WD+55ZVlCFnpwUzhZskl8JfP/Qwkjb
 BVdYwtG+DYougD1hm/3KupCvCnb2Nt95dpuX24Hp7iES/JEhjBX6OJuh21kvelUFMkd4
 Sw6gqG8JN2IAgTW7YhRWtR2DSRwZbPPEr0opWGbnbclrGW64K/Lz/G0iDTY3r+bDAvL7
 1mHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtSyOehAWyNBjWQSKL9ngQGBHz2C8UFDMKnO0kVCmRSoTleJQwjPEGYzBFKyWKaiVPYheEO8ACyNji@nongnu.org
X-Gm-Message-State: AOJu0YxUlr8a2AY7LJa1F1ynZYVLsROlJ8XTucHa4es+WzP6xSorUWWn
 9ypsloy+FCVce6paUqW8WCZs+XoWCLVqMOVnQoEslXDJDN8Ju2Z+Gel7mKA5H6LZTGpXgHOW9+8
 bSA9vXV2BHED0+uPwjUnGHQaYs7XWYtTHHIqWY69y05RtLmXIpiJeo5Zx
X-Gm-Gg: AY/fxX5GLfM6I+l3e4A5UslTdoUETXvjQI5fv66DRfhTpfclFhPoQnD/UEi628KWvqK
 PNJqaSZrh/F0agvmq76iZ9GcxjGZMmdL4p4G+OHm+DQcs4/QDquRNWy5y8ODvx+jYs0H5HtYYey
 IanDdAH+fCW0nociQmEe5ogr3TQqea7aR5EsciAZxF7Y8Ld88k/V/GhTcKE4lOxQhnIo26AqVL1
 YIHjaR3WjtA04sk6NdxjsAbG72kLnru0P5Ojk5Hzsrqg8dAaf8sz91ad50/A08y5YVBY7vk0/9N
 CvAJmkPObxrW2PgwTAmZNF4Vz/YZuVuV+QC7LQEQrvhF5n+JpqcYya0m1uX7gjw83Ki3KVlwvjr
 qlOOBT6H5Xy+2MQpXAxEapcl9+3tseF2l9DKHuUG6BvLFJA==
X-Received: by 2002:a05:600c:620f:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-47d195a73cfmr103644785e9.17.1766391428093; 
 Mon, 22 Dec 2025 00:17:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpMwKhcYioUCfDafM/JdSSGU/LAqJesYG0lBSSva8dTcF4tnSBJ5S1ypDiakcWIM+u1f9eAw==
X-Received: by 2002:a05:600c:620f:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-47d195a73cfmr103644495e9.17.1766391427683; 
 Mon, 22 Dec 2025 00:17:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm230486025e9.8.2025.12.22.00.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 00:17:06 -0800 (PST)
Message-ID: <e219df64-1712-4ace-8358-d825de26fc1a@redhat.com>
Date: Mon, 22 Dec 2025 09:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
To: Farhan Ali <alifm@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
 <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
 <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
 <970d3a1a-408f-4bf3-b6da-784f8e6bd66a@redhat.com>
 <f23ec136-5b6f-45b2-a6f1-1668e58a4030@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <f23ec136-5b6f-45b2-a6f1-1668e58a4030@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Farhan,

On 12/19/25 18:30, Farhan Ali wrote:
> 
> On 12/19/2025 8:30 AM, Cédric Le Goater wrote:
>> On 12/19/25 17:21, Philippe Mathieu-Daudé wrote:
>>> On 19/12/25 15:51, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>> On 12/17/25 19:42, Farhan Ali wrote:
>>>>> The VFIO pread/pwrite functions use little-endian data format.
>>>>> When enabling the Bus Master bit, the value must be correctly converted
>>>>> from the CPU's native endianess to little-endian format.
>>>>
>>>> How did you find the issue ?
>>>
>>> I presumed using VFIO on s390x hosts...
>>
>> yes. I have been using a nvme drive for over 2y in an s390x VM and never
>> saw any issue.
>>
>> C.
>>
> Hi Cedric,
> 
> I have recently been experimenting with QEMU NVMe userspace driver and PCI instructions from userspace [1]. On some of our test systems I noticed the driver being hung. After some investigation we realized it was due to this issue.

Do you think you could provide a test case for it ?

Also, I think the LE conversion should be done in routines
qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config().

Thanks,

C.


> 
> [1] https://lore.kernel.org/all/20250430185012.2303-1-alifm@linux.ibm.com/
> 
> Thanks
> 
> Farhan
> 
> 
>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>> ---
>>>>>   util/vfio-helpers.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>>>>> index fdff042ab4..3c8284284f 100644
>>>>> --- a/util/vfio-helpers.c
>>>>> +++ b/util/vfio-helpers.c
>>>>> @@ -443,7 +443,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>>>>>       if (ret) {
>>>>>           goto fail;
>>>>>       }
>>>>> -    pci_cmd |= PCI_COMMAND_MASTER;
>>>>> +    pci_cmd = cpu_to_le16(le16_to_cpu(pci_cmd) | PCI_COMMAND_MASTER);
>>>>>       ret = qemu_vfio_pci_write_config(s, &pci_cmd, sizeof(pci_cmd), PCI_COMMAND);
>>>>>       if (ret) {
>>>>>           goto fail;
>>>>
>>>>
>>>>
>>>
>>
>>
> 



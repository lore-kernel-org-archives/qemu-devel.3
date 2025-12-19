Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8671D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdNl-0002LG-8K; Fri, 19 Dec 2025 11:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWdNg-0002Kw-Ui
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:31:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWdNd-00080c-EP
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766161858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xGTD/g5VFIzqhVI/xe/BuA8Ye56bTqcTfptsl4HHXnw=;
 b=M/mlTdk7hSbYPm9Stf2F5EG5XM6TVgourMqfLQ8YKUaP/8zuU4ljKlZJqIVXL2mKC89X0C
 unjNAAmklX4naHoXAYjBI34GWhP+sZLNpS7tD7m7LewprzlE5wvMuC3NSb9PnVvbwqL92L
 FfxRiiEemg6xAJB6qSw1obKfmEyNFFQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-DxXZtmE4MJeJ6Hc5X0LKiA-1; Fri, 19 Dec 2025 11:30:57 -0500
X-MC-Unique: DxXZtmE4MJeJ6Hc5X0LKiA-1
X-Mimecast-MFC-AGG-ID: DxXZtmE4MJeJ6Hc5X0LKiA_1766161856
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779b432aecso10083595e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766161856; x=1766766656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xGTD/g5VFIzqhVI/xe/BuA8Ye56bTqcTfptsl4HHXnw=;
 b=grHBJ13/5qKV35O+9H3NxxuJEWvKp+0X1NwwEViQDwvSNJLXMs8nSCi1/yonUs10cH
 QIx6ufVqap58aV5bc0oHgF7mLX/625UDgibGtOiy3X2XeZDLBEXOLO3S1Rv8U2YDTOmz
 +qZVRtWJ7DD8ZoWEIytU3q8gyE9t7zWltptUynf/pllweTzFmZey8hUCoheRbO9VKXFN
 aGewM1a/LK4D1V4GcfmrT/62vKoK3gXb4+HCh+9BpJkLOY1frdgmgrQCHMR7c2SCUkCX
 K8Xinq1+TwFuv92VqxP499mjDKecO9gs16ulaGpARXEEKQL2JJ91Cog52zi/mjgAGGsX
 UAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161856; x=1766766656;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGTD/g5VFIzqhVI/xe/BuA8Ye56bTqcTfptsl4HHXnw=;
 b=uyOlNRmBXuLleGWA3+Jj+OGE6r/CQWg7wMsD7aYkXnHWblDmJ/viL17x0nj4SzWkmJ
 uvj6eFEealwYvOd4eq4uMjK4zzkXRs//fPN02uEy5X4I7Sge3RW+wsNrACsi4oqFbcfK
 4hc97BZeYct3VO8LT8Qy6d+r5YXwmAyD1fJSgrfHf3W+A58P8PaC+A1+pu+okcpnJnQg
 Q0Tiau/PoEd/Hb1hDETmbGOx3PQ3ba0l76NClMdrwg0vktaqMo+wYMN4Kr8Zz/84rNCZ
 /g67+8WBE9gfmCKkj8ffzobmc3FjiNG5xBR0JU4885S0XSTOUWy63fd5uVcEskM7fXHG
 pHkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ0bZJoHAYzJeJYZY1BTHO4SHJl6t2PL/B01YidsYJdl05m/Rlmwr38bECrIv/W/ZhMz9EBpzY/Q/h@nongnu.org
X-Gm-Message-State: AOJu0YwA7VOIUxjg7J/YOXaU/+txDXk2BrYk2fQ46UwoGwNcY7grMKDd
 YnOPZ8AWcMOry7ZQWLZLOwLcNpT3liGP9HwYCKwIzqS/sIMaoW6Xt2eb7p9mQeMWf0G7Yt0Ok5p
 2tXm6tmZ71WQ2KCI6Cu+p1+w3W+pvvy3BdLB6rduOqeeU+2DVZ+qSzORg
X-Gm-Gg: AY/fxX41tnJtb77Zrpno2T5K/cNj+ROR3i11hbtSI6IY+Kfk8LRARHcRIPUncmVQUEE
 pckbQv7s7Rmwy6UqnuHoTINFTAHaTXKCaioYaMeWMMb7vCbUhMcwtnCqUt7rdRfV8PM1HKQTdrg
 FcIs/nclipQUdVA6MJ1BsVzIkYmEtKYWAppJyi95VKbSKi8QpFwkYbJjL9SSgQieuIDPUexeMCU
 AcaiHpM9hIWVcIWdrkIb8LrpXPtqRHdnZFavQBdtkNXK7Oxga76ddeQHSNJMDjCN5G5cSyN8qyQ
 QdES28q7/bfpQNIvvzpgak6EnK6qK4QDIsZV0n/AjoHvUdwN5rbGKdLfOCaYau9MFRAbiZL5PVI
 SRP972VaeANOnIklQxYQib68E8aoQZN1KSeQYViyb9avnuOuz
X-Received: by 2002:a05:600c:1d1d:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-47d19538d98mr31350475e9.2.1766161856017; 
 Fri, 19 Dec 2025 08:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrLqIeUhPmb3nqJujk9tChPtpsWHuTe0IsZAUKflrpI8mkOhSUa8I6McB+pK5xBbHGXjWepA==
X-Received: by 2002:a05:600c:1d1d:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-47d19538d98mr31350255e9.2.1766161855570; 
 Fri, 19 Dec 2025 08:30:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm5869097f8f.32.2025.12.19.08.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 08:30:55 -0800 (PST)
Message-ID: <970d3a1a-408f-4bf3-b6da-784f8e6bd66a@redhat.com>
Date: Fri, 19 Dec 2025 17:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
 <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
 <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0c3e13e1-0aeb-47f9-9c44-5af8f3f47055@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/19/25 17:21, Philippe Mathieu-Daudé wrote:
> On 19/12/25 15:51, Cédric Le Goater wrote:
>> Hello,
>>
>> On 12/17/25 19:42, Farhan Ali wrote:
>>> The VFIO pread/pwrite functions use little-endian data format.
>>> When enabling the Bus Master bit, the value must be correctly converted
>>> from the CPU's native endianess to little-endian format.
>>
>> How did you find the issue ?
> 
> I presumed using VFIO on s390x hosts...

yes. I have been using a nvme drive for over 2y in an s390x VM and never
saw any issue.

C.

> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   util/vfio-helpers.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>>> index fdff042ab4..3c8284284f 100644
>>> --- a/util/vfio-helpers.c
>>> +++ b/util/vfio-helpers.c
>>> @@ -443,7 +443,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>>>       if (ret) {
>>>           goto fail;
>>>       }
>>> -    pci_cmd |= PCI_COMMAND_MASTER;
>>> +    pci_cmd = cpu_to_le16(le16_to_cpu(pci_cmd) | PCI_COMMAND_MASTER);
>>>       ret = qemu_vfio_pci_write_config(s, &pci_cmd, sizeof(pci_cmd), PCI_COMMAND);
>>>       if (ret) {
>>>           goto fail;
>>
>>
>>
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD7BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ7X-0001Vy-Ho; Tue, 15 Jul 2025 02:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubZ6g-0000r2-5i
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubZ6c-0000aO-2b
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752560729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yR/K0TjaSYqVLdfMq4Fj7MwBfiK3n2HzM07tqV/zxL4=;
 b=BpjbEV7LR1RE46bI4qpIvU0x8C+A4gNnn+JpYCYH07alWlCo9kVQd3IlgKkOSvXf04/gjl
 IkYSeWOVP7+/QVWRAXLeJfr+AD+no39FizRZQPnBUJrgjg/PzQZVURkXT7NnM6HvKYa1+g
 MX1IjpDQsERYqjoBeD2tj1pJrEoePao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-1qpO3bRINdyvNNsOKv6j3w-1; Tue, 15 Jul 2025 02:25:27 -0400
X-MC-Unique: 1qpO3bRINdyvNNsOKv6j3w-1
X-Mimecast-MFC-AGG-ID: 1qpO3bRINdyvNNsOKv6j3w_1752560727
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so1894052f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560726; x=1753165526;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yR/K0TjaSYqVLdfMq4Fj7MwBfiK3n2HzM07tqV/zxL4=;
 b=KO3/bOPsa0IVESLh8xoy4yVxDEJ71GdTw3Cu4ie7VBSd2JTQN3zoff71f+PkQOdfzX
 2kNtazD1c+bH4CLIJCQcVfugtFwI2WWbQ6V6utbN4rRB3+qjE/4EaKVGs3yihpWrdEWJ
 B0TkKP8wMNumD9Vqb2oSWRMGwC5YDxa0Co0J1nudwAgDSxvZSjXNn0xRdEmjbcU3EI56
 OMV6DsUGBvltn3ediMpdfLDSoZdpxEFL+p+D4oRyt1xvnRvxNuD1JDnuZPpD5g1njICA
 Mf7+FjtguOH1w76HV1LvKmHQfJ+h3TRWoUUGFPLuCj0wKgX0k3qjFc0WdD2Yio5GjOKJ
 t1JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6LekysFDtoXKKZI22BpSwxuhbOjZZgfIbiPb/fLfzRHg7AccaejALihtaPQo9e+wAhZHB7EwA4MXm@nongnu.org
X-Gm-Message-State: AOJu0YzaYPM8LNTHcFSdnjT/YBUtomDjkEj7hggzTDDK3MdKiwgj9v0o
 zP6vrUPHcc65bstPRWUohtdcdegFI3nMM5nJnsxsXQXgWphtQh6YZQ1prCVzogByZ9YtpwcGtbU
 dcyTGlcwTxW5zhuytftNpap43AUC4QRMHADbpB/yy/IGLh6k+mh7/q7Hl
X-Gm-Gg: ASbGncsFcEZNemcoU+k3lSn6Ie8NU5+IrCQ/IddOAO/Z3VimTmuTPuBk0ezQQ4J0bu9
 PMbaKZTfkcqMjHLblxcBo5PV/YdodgT9F44m5JCu/2ub4/s2FRpkKEOCjQAglZ6iDrMnzJMTIyO
 315klCcfJRqcOAsVGJIlwNKZ3aaFGyJAwpvi43v3GNp78eANaBPl6QBV+LZ/bI0ud9WNy/wajZ2
 QmeKjFwfM0Bh3UAq1YaerGhVYzLU78IC900ll28Bz+bRY8Jwvj6Wi6ZQEEpm+HCupsy1gpiAky3
 G73Pj6l63sU2chM+ublw7pjbnCOdc4VGZWTD1aaEcnnPDqKG3UYGykh6eGiLjv+Lil8oRCfZbN4
 =
X-Received: by 2002:a5d:6f01:0:b0:3b6:463:d85d with SMTP id
 ffacd0b85a97d-3b60463d8eemr5033537f8f.11.1752560726550; 
 Mon, 14 Jul 2025 23:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7pnWKKZo0XadlBciO2eczrCLrFIuhvCJ/23pHyIOKKp4B+rQ6Zsf/3vS4w8T4o9bvmoYKNA==
X-Received: by 2002:a5d:6f01:0:b0:3b6:463:d85d with SMTP id
 ffacd0b85a97d-3b60463d8eemr5033514f8f.11.1752560726173; 
 Mon, 14 Jul 2025 23:25:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2710bsm14213882f8f.99.2025.07.14.23.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:25:25 -0700 (PDT)
Message-ID: <ef3f739d-5cda-4078-a5eb-ca6632d5e92e@redhat.com>
Date: Tue, 15 Jul 2025 08:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio, migration: save device parent pci config
To: Huaitong Han <oenhan@gmail.com>, mst@redhat.com
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huguanshen Chen <chenhgs@chinatelecom.cn>,
 Heng Zhang <zhangh121@chinatelecom.cn>, Huaitong Han
 <hanht2@chinatelecom.cn>, "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Levon <john.levon@nutanix.com>
References: <20250605083338.1845911-1-chenhgs@chinatelecom.cn>
 <238cce11-3050-4ec8-acbd-b1605f9dc4a1@tls.msk.ru>
 <CAAuJbe+dNpdA62CjfQfGq0Ph72w+Nooyax=WdRuYCRTPRngvxg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAAuJbe+dNpdA62CjfQfGq0Ph72w+Nooyax=WdRuYCRTPRngvxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/14/25 04:37, Huaitong Han wrote:
> Hi, mst, clg
> 
> Any comments?


Since this seems to be a GIC issue on the aarch64 virt platform, you
should cc: the virt-arm people for more insights.

Also, the vfio-user devices have been merged very recently, ~1w ago,
and, AFAICT, migration is not supported. Are you testing against the
master QEMU branch ? Adding John in cc: nevertheless.

Thanks,

C.



> Thanks.
> Huaitong Han
> 
> Michael Tokarev <mjt@tls.msk.ru> 于2025年7月13日周日 17:12写道：
> 
>>
>> Ping?  Has this been forgotten?
>>
>> Thanks,
>>
>> /mjt
>>
>> On 05.06.2025 11:33, oenhan@gmail.com wrote:
>>> From: Huguanshen Chen <chenhgs@chinatelecom.cn>
>>>
>>> On arm64 virtualization platform, vfio-user devices lose their interrupts after
>>> migration to the destination. This issue occurs because qemu fails to deliver
>>> the msi device id to the vGIC. The error device id is calculated based on the
>>> device's parent bus, so it is essential to save the parent pci config to
>>> prevent this issue.
>>>
>>> Backtrace:
>>> QEMU:
>>>    #0 qdev_get_parent_bus
>>>    #1 pci_dev_bus_num
>>>    #2 pci_req_id_cache_extract
>>>    #3 pci_requester_id
>>>    #4 kvm_irqchip_update_msi_route delivers 0(error id) to vGIC
>>>
>>> KVM:
>>>    #0 find_its_device returns error
>>>    #1 find_ite
>>>    #2 vgic_its_resolve_lpi
>>>    #3 vgic_its_trigger_msi
>>>    #4 vgic_its_inject_msi
>>>    #5 kvm_set_msi
>>>    #6 kvm_send_userspace_msi
>>>
>>> Reported-by: Heng Zhang <zhangh121@chinatelecom.cn>
>>> Signed-off-by: Huguanshen Chen <chenhgs@chinatelecom.cn>
>>> Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>>> ---
>>>    hw/vfio/pci.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index a1bfdfe375..442113d0b7 100644
>> ...
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6E8EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1cV-0000Oo-RE; Tue, 10 Sep 2024 10:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1so1cT-0000GR-Vv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1so1cR-0007QW-Dn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725977602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzK11lTRQC1eOkHo1A3ckmXjHg6S0e3e4rncnZvUvhc=;
 b=WnsltzYXJQKkUEqRVOkQmI6qoF/35NLC+FbvnnpNym4FEQeDYqdpSturBjDCn48YFxEYKX
 PcN1sLE13PLASM7zOiS5dDE+wQWJ3vYxcY3Ov8YXwdDRJi2yNlj/8CM9kA2oCbbl4EzzZ2
 YG/6yWSDydriCEBLhD+UCPfPb0vOmvM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-NOvrfsktMZGk3OfggO2nqA-1; Tue, 10 Sep 2024 10:13:19 -0400
X-MC-Unique: NOvrfsktMZGk3OfggO2nqA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6bf6bcee8ccso92121816d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977599; x=1726582399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tzK11lTRQC1eOkHo1A3ckmXjHg6S0e3e4rncnZvUvhc=;
 b=VD/e9ax4wscoGjfevt4i38lTXB6LQBDUHqbkM+Dylw+Frf7LKJ0NvUYif/03UA59Q4
 7jP229E6RmCVfgzDFYBGp8c9D/YgfDTCXtxZgUxtGZQ3dlsXpyc5XUbw/tOjCzPhoygn
 Tiukbl0293f0RRxrDqnzfj5qjgoPlC9EJiJsqilUxx4BKmQZwW9sbq6lHuqJOc5brkej
 Fy16DO+a9GyRvDsAcqgBp4+fRlZ4zX0B0NC6Vcoar5ASCJnfvp2ecCJgeG3hYOfoEaPc
 i0nKqGTJacF2CU5hn05hKp9Xcsng/N2rx1KZ4dCM6OQwfAs1uv+9r89tyrk/SMTfKyOX
 vTIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBlf+BuDGdaqQTeX4J6i0yRgkmOUL9wr0+EnCiSogLnSu5lD/8ziny07VLbMQzwZAQRECxS6y7K3lc@nongnu.org
X-Gm-Message-State: AOJu0YxGr6BaIubLqgNegIy4Pe5QhuqALAZ25JogG9N8St2nuRvvFx+c
 S5YAd+iWWb5Nz9INvLI4O9EGoG7O7ZkZNR+SHwelm2v46Ryjgnl0kJlQe2UOCindWNKG+jg6XS1
 r6pPYpu0HDyNRedOD92duVDY7qel1SHG9PPXno8blPNZ1j6UWEsz0
X-Received: by 2002:a05:620a:29d1:b0:7a7:dfd9:4b9a with SMTP id
 af79cd13be357-7a9a38ebbfbmr1811993185a.49.1725977599261; 
 Tue, 10 Sep 2024 07:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh9yh1cOtrk8EBUYhkDnZo8q5xuEenjXB/ARTirhC75gw+5T4TTmY8dHiV2Bd03rwu3QV6jA==
X-Received: by 2002:a05:620a:29d1:b0:7a7:dfd9:4b9a with SMTP id
 af79cd13be357-7a9a38ebbfbmr1811989185a.49.1725977598872; 
 Tue, 10 Sep 2024 07:13:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a038e9sm309840985a.98.2024.09.10.07.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:13:18 -0700 (PDT)
Message-ID: <6aeaa38c-22b9-4598-b07e-7adaee187562@redhat.com>
Date: Tue, 10 Sep 2024 16:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
 <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
 <20240910093440-mutt-send-email-mst@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240910093440-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/10/24 15:34, Michael S. Tsirkin wrote:
> On Tue, Sep 10, 2024 at 03:21:54PM +0200, Cédric Le Goater wrote:
>> On 9/10/24 11:33, Akihiko Odaki wrote:
>>> On 2024/09/10 18:21, Michael S. Tsirkin wrote:
>>>> On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
>>>>> Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>>>>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
>>>>>
>>>>> I submitted a RFC series[1] to add support for SR-IOV emulation to
>>>>> virtio-net-pci. During the development of the series, I fixed some
>>>>> trivial bugs and made improvements that I think are independently
>>>>> useful. This series extracts those fixes and improvements from the RFC
>>>>> series.
>>>>>
>>>>> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>
>>>> I don't think Cédric's issues have been addressed, am I wrong?
>>>> Cédric, what is your take?
>>>
>>> I put the URI to Cédric's report here:
>>> https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com
>>>
>>> This issue was dealt with patch "s390x/pci: Check for multifunction after device realization". I found that s390x on QEMU does not support multifunction and SR-IOV devices accidentally circumvent this restriction, which means igb was never supposed to work with s390x. The patch prevents adding SR-IOV devices to s390x to ensure the restriction is properly enforced.
>>
>> yes, indeed and it seems to fix :
>>
>>    6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
>>
>> I will update patch 4.
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>> That said, the igb device worked perfectly fine under the s390x machine.
> 
> And it works for you after this patchset, yes?

ah no, IGB is not an available device for the s390x machine anymore :

   qemu-system-s390x: -device igb,netdev=net1,mac=C0:FF:EE:00:00:13: multifunction not supported in s390

This is what commit 57da367b9ec4 ("s390x/pci: forbid multifunction
pci device") initially required (and later broken by 6069bcdeacee).
So I guess we are fine with the expected behavior.

Thanks,

C.



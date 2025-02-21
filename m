Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BBEC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlONq-0003hC-BW; Fri, 21 Feb 2025 03:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tlONk-0003ge-SZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tlONj-0008LR-7T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740126453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SRWdYgAXyJyt3FGRAZDYtHDuQXhYodufiq1Xxhy7cbk=;
 b=fgSm78OCNrYO54rxeKh+7S9vCJ9CKJXC+gZ7cFGn3jZ5RnZ1HKL0sUzXOhTFz5nD2MeXJ9
 M89e/X8Og7IYb5zbGkX8oImyh+e9cCrIaHzTI4maXfcqCfnYbDosV9Cbc6irakHMg51DHC
 4FDY+I5qn5BTrj96wbVK3xHzwpEyfXU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-r54EPOEcPf-pldOnNqsCNg-1; Fri, 21 Feb 2025 03:26:26 -0500
X-MC-Unique: r54EPOEcPf-pldOnNqsCNg-1
X-Mimecast-MFC-AGG-ID: r54EPOEcPf-pldOnNqsCNg_1740126385
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947979ce8so8496045e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 00:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740126385; x=1740731185;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SRWdYgAXyJyt3FGRAZDYtHDuQXhYodufiq1Xxhy7cbk=;
 b=JRqGHGWV/2X3jFhrMa6DpbmID5hix0KJ+xSSQSTF0sL5pE0FFfPOaVVaqaHiR6/Lzs
 gLyWAVfkv/D/S9QENfB1aMJKpMsolEEMRk6pL4/4K4Wj5kCv54YsGzPuxhuusQXW/cgo
 k7OtWe6mvAzlJ6gzLdslGnjWGRDQSXAH/NtrQMqJiKnOQ3Iam+MdklhXNPQosjwY1cDi
 sy3Ci+pCVJnBJE2rxC8SOwp/4qU3Pw5QY0GAWNYThp/k99KRBspyqpSQVOIglBdJFGyW
 s1rOSP+N4jqIkGtSMqXgfJ1Ds1Y7L9Yi0xb3KUNb70aLedXSmXnHTs7wDTU045I4yT53
 kWyw==
X-Gm-Message-State: AOJu0Yz8x/6kTwh61kpamoG/i8IQoiVXo178njLMXQ2oiWiuDGYir3n4
 ZKxiySfQDMBTqB/Jnx/L3BBOijpDCDPxhXxbwxO/2uBwrWCp7iVg8rmTXBaVoxdq4/P9AtCYNnj
 6VgnxGNh0vG3wmY9uevjYG3cTXHy6c+y/ckSK/W7uaCpAc3tnRFzJ
X-Gm-Gg: ASbGncvGrqp7irM5RRH7BaNXidVUeiRmLc3wmHd/Sv4jZxE2bwfNR0VsqVUNc8xWAOw
 /3n/HH09sBX5K38O0BiwgM05zpZtJaKsFNxEC5qkoLgu3BYRMIo72ELOi1sA/phKTobWH0hoM8r
 DnoHWYTbFK5AFxMZBjCL1BQgUWoQ7SyUl4RV8y4CTvLeZsZyh+AuTdOMJcQsNdkwc1Kn74y2WR5
 IAnWdqNWYbrFKr+tL8ahvrjaoZRQqKRvFYw3LKMS76vPsw6SzOJjUPezW1DXioKFTJUNTGHrxT+
 7+d9/X7pXaUOJYs69lRTDqz5oeVo2l2gEzRDhyZR9UW6nf2TebgCdE3tbLMc7zmFfO6NrdWiMi+
 U6neNJstQjF0Rp2jhwhS2vuu4I2UjveeZ7fRtdIUxaLI=
X-Received: by 2002:a05:600c:3b08:b0:439:90f5:3942 with SMTP id
 5b1f17b1804b1-439ae221b60mr14525495e9.25.1740126385097; 
 Fri, 21 Feb 2025 00:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9//j6Nzi+TTK8G5Fsd9fLATdHqo2vvuTpKpfUUYn9j/DXGkKqnAn7pRHmpkB8S0bHeFXcBA==
X-Received: by 2002:a05:600c:3b08:b0:439:90f5:3942 with SMTP id
 5b1f17b1804b1-439ae221b60mr14525255e9.25.1740126384744; 
 Fri, 21 Feb 2025 00:26:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1700:305a:4df7:c043:7a59?
 (p200300cbc7141700305a4df7c0437a59.dip0.t-ipconnect.de.
 [2003:cb:c714:1700:305a:4df7:c043:7a59])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0367577sm9902655e9.25.2025.02.21.00.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 00:26:23 -0800 (PST)
Message-ID: <e42e5f91-a9ab-4686-a638-ac334c629a6c@redhat.com>
Date: Fri, 21 Feb 2025 09:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] s390x: support virtio-mem-pci
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>, Mario Casquero <mcasquer@redhat.com>
References: <20250128185705.1609038-1-david@redhat.com>
 <20250220182351-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250220182351-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

On 21.02.25 00:24, Michael S. Tsirkin wrote:
> On Tue, Jan 28, 2025 at 07:57:03PM +0100, David Hildenbrand wrote:
>> This is based-on [1], which adds MSI-X support to virtio-balloon-pci,
>> but can be applied independently.
>>
>> Turns out it is fairly easy to get virtio-mem-pci running on s390x. We
>> only have to add MSI-X support to virtio-mem-pci, and wire-up the
>> (un)plugging in the machine.
>>
>> Tried some simple stuff (hotplug/hotunplug/resize/reboot), and all seems
>> to be working as expected.
>>
>> The kernel in the VM needs both, CONFIG_VIRTIO_PCI and CONFIG_VIRTIO_MEM
>> for it to work.
>>
>> [1] https://lkml.kernel.org/r/20250115161425.246348-1-arbab@linux.ibm.com
> 
> 
> Fails CI:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/9202574981

Hm, I thought the CI was happy when Thomas sent it upstream.

CRITICAL: log: qemu-system-i386: -device virtio-mem-pci: can't apply 
global virtio-mem-pci.vectors=0: Property 'virtio-mem-pci.vectors' not found

And the same for the virtio-balloon devices with a similar change.

Trying to run one offending cmdline on current upstream:

./qemu-system-i386 -display none -vga none -S -machine 
pc-q35-8.0,accel=tcg -device virtio-mem-pci
qemu-system-i386: -device virtio-mem-pci: the configuration is not 
prepared for memory devices (e.g., for memory hotplug), consider 
specifying the maxmem option


So I am not sure what is happening here? Is some commit in the pipeline 
breaking this?

-- 
Cheers,

David / dhildenb



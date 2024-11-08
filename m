Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F37ED5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Q6w-0000Nu-4E; Fri, 08 Nov 2024 09:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9Q6t-0000N2-P8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9Q6q-0003lc-Sl
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731076629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D90rxuTQoodTtp+EQ91wnBr+8RrRHJZz44XTslpdL+I=;
 b=Jye+TFyX0qG6s5GqfmRT1HcHg4rm4HVrokz07BF9yi476097hO/wbDFAui7++zRcBbsxeF
 LN2fjWoCLFTu/Fz1YpaKTU4fJxfJiYAMWhCRZPuhN3UCfIGIpVxWOqSEVjtZiKhBO40/Qv
 rgUUykTTySmwFj3AMOSyN37JMkmgwbs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-qs46ks5APku8VYQgphU7VQ-1; Fri, 08 Nov 2024 09:37:08 -0500
X-MC-Unique: qs46ks5APku8VYQgphU7VQ-1
X-Mimecast-MFC-AGG-ID: qs46ks5APku8VYQgphU7VQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-460b35f8214so31250891cf.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731076628; x=1731681428;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D90rxuTQoodTtp+EQ91wnBr+8RrRHJZz44XTslpdL+I=;
 b=MuP3hyiDlpqdQJkMMAs3yFDcOxfLJGy/T0xiNHZIDXR1FZVyJ79pcLP249+2ugIr7n
 PpqPAuEs9dM4bH/iVLscfzAdp7bvC4dZ8xGzy/5Af6aU9Wbj0P2w1WwI7SZ88Id2aIrW
 pqicHx0ry06MD16fNzpHbjXenYp4pxRjuCXMT2GyCoZZkqmsywTMP357bGtg0k75QqmA
 xi4BcE/BYS29v+E1IF2PRMNJ/UsZZ1QSBD6slcb+469X71IixMnylULkCC3VB+VHyXJ5
 9PRvM4nI6Dq+ttXJf/nkN9mh3DW1gJio+A3EZBPEzPUfTx5yyL2yn3popCzAXv6CqDTQ
 LneA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtIPguSmkWJ6YS96Fymt0BiRbzD5mvPjXzclEu0j/ZC35eU/3AKKr3axNEVRoRzZQQc07hQSXMcYoT@nongnu.org
X-Gm-Message-State: AOJu0Yy5D1Ntv9NEWaUZBe+1RPmR1n5Ep5sXQlCIl9BUYkH9Tu3bXAEu
 zhjgWQk7TbeUnTx1bRbCaQw9KY1geciKBspN8T4gDG0hWwEezc5W5nzE1b8vemmg6gCpfkCxuoR
 dJhQUe6NlnoNnuHyWZHye/3KcZ4Ioo02tlPu6zY8KH4/4wX2Imx/1
X-Received: by 2002:a05:622a:6206:b0:460:ae4b:ed02 with SMTP id
 d75a77b69052e-4630933af36mr41362381cf.16.1731076627851; 
 Fri, 08 Nov 2024 06:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf/rb0QOAXBBVbSUZ0/6AyVz1XrR1Lmdo6+uohDkGe9fg962VrXEGraZS0Bpas6utO567hdg==
X-Received: by 2002:a05:622a:6206:b0:460:ae4b:ed02 with SMTP id
 d75a77b69052e-4630933af36mr41362001cf.16.1731076627418; 
 Fri, 08 Nov 2024 06:37:07 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff41d802sm20823841cf.28.2024.11.08.06.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 06:37:07 -0800 (PST)
Message-ID: <592e9413-f2cf-4e84-b594-4017ca8d60e1@redhat.com>
Date: Fri, 8 Nov 2024 15:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] s390x: Add Full Boot Order Support
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel@nongnu.org
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <7800f880-d362-40b6-aaef-2085dcb78ad0@redhat.com>
 <c5bff27a-0aae-4356-9403-89d126426610@linux.ibm.com>
 <6d6466b5-1d6c-49b3-abb0-f268aa617c6a@redhat.com>
 <af01b629-7df1-4f55-9b18-3f3bc1d393c9@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <af01b629-7df1-4f55-9b18-3f3bc1d393c9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 07/11/2024 21.42, Jared Rossi wrote:
> 
> 
> On 11/6/24 6:10 AM, Thomas Huth wrote:
>> On 05/11/2024 17.42, Jared Rossi wrote:
>>> Hi Thomas, Sebastian,
>>>
>>> It looks like this is simply caused by the "is_cdrom" value only ever 
>>> being set
>>> to true.  I think it is a one-line fix that just makes sure to initialize 
>>> the
>>> value to false each time we try a new device:
>>>
>>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>>> index a4d1c05aac..3fdba0bedc 100644
>>> --- a/pc-bios/s390-ccw/main.c
>>> +++ b/pc-bios/s390-ccw/main.c
>>> @@ -214,6 +214,7 @@ static void boot_setup(void)
>>>   static bool find_boot_device(void)
>>>   {
>>>       VDev *vdev = virtio_get_device();
>>> +    vdev->is_cdrom = false;
>>>       bool found = false;
>>>
>>>       switch (iplb.pbt) {
>>>
>>> I tested it with the two scenarios you mention and with the existing qtests,
>>> and it seems to work correctly now.
>>
>> Agreed, this seems to fix the issue when all devices are properly marked 
>> with bootindex properties. But it still persists in case the BIOS has to 
>> scan for the boot device, e.g.:
>>
>> qemu-system-s390x -accel kvm -m 2G -nographic \
>>  -drive if=none,id=d1,file=/tmp/bad.dat,format=raw,media=cdrom \
>>  -device virtio-scsi -device scsi-cd,drive=d1 \
>>  -drive if=none,id=d2,file=good.qcow2 -device virtio-blk,drive=d2
>>
>> Isn't there a better place to set the is_cdrom variable?
>>
>>  Thomas
>>
> 
> Hi Thomas,
> 
> What I found is that the original issue with clearing the "is_cdrom" value is
> just as easily fixed for both indexed devices and probed devices by moving
> where "is_cdrom" is set to false:
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a4d1c05aac..7509755e36 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -242,6 +242,7 @@ static bool find_boot_device(void)
>   static int virtio_setup(void)
>   {
>       VDev *vdev = virtio_get_device();
> +    vdev->is_cdrom = false;
>       int ret;

That looks like a good spot, indeed! Could you please send it as a proper 
patch (i.e. with a Signed-off-by line)? I think that would still be a good 
fix for QEMU 9.2.

> Unfortunately when verifying the fix I found another unrelated issue with
> probing, which is that only the first device attached to the scsi controller
> will be found.  This is because virtio_scsi_setup() itself contains a probing
> loop to find a LUN when none is specified, and, unsurprisingly, it returns
> the first thing it finds attached to the controller.  As a result, the main
> device probing loop will move on after trying only one LUN per controller.
> 
> Fixing this won't be a simple one-liner because it will require implementation
> of nested probing for scsi devices, such that all LUNS on the controller are
> probed before moving to the next device.

Ok, maybe that change will be too big for QEMU 9.2 anyway (we're in freeze 
now), so it's ok to include this later, I think.

And in case you're interested (it's maybe not so important since it's rather 
unlikely that the users will do this), there is another issue when trying to 
boot from multiple network devices where the first one has a DHCP server but 
no bootfile:

qemu-system-s390x -nographic -accel kvm -m 2G -netdev user,id=n1 \
  -device virtio-net-ccw,netdev=n1,bootindex=1 \
  -netdev user,id=n2,tftp=/boot,bootfile=vmlinuz \
  -device virtio-net-ccw,netdev=n2,bootindex=2 -d guest_errors

The firmware seems to panic while trying to request DHCP information from 
the second boot device.

  Thomas



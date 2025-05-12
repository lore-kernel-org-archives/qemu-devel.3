Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA83C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESkB-0005WC-43; Mon, 12 May 2025 08:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uESk9-0005Vl-N9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uESk7-0006Mp-4V
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747054727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nM98FbfVfhRUb+CPai3Ww1cSP1t8RxNywjF/o33H0ZM=;
 b=HBG0AO5T8s8fI3gYYvQSp63XeYaGlLgs77AAA32OuBDCQydfb8nmUrJuiyvOd6+mMpMWIy
 23S4BypvMMjLsz87BaIovy+/B9WxfRmfTYnN8UiMJcAKQ77HzakUCFVU119gDEXuZhSzaL
 BtSF4dZ6ScKOvwOLbvaqvXyR1JlT33I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-izQhE5QtMhSMLBDMlxV7uA-1; Mon, 12 May 2025 08:58:45 -0400
X-MC-Unique: izQhE5QtMhSMLBDMlxV7uA-1
X-Mimecast-MFC-AGG-ID: izQhE5QtMhSMLBDMlxV7uA_1747054725
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so1066033f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747054724; x=1747659524;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nM98FbfVfhRUb+CPai3Ww1cSP1t8RxNywjF/o33H0ZM=;
 b=gv3FTIZxccxpqkCCs2fn5lFpY5LgWYg76CBL4H1Qqz2pIwhVSKCKeJmyZCty/sJmyU
 3fCKrzrBIG2wWYE5MG/h5XCDmsaoh2dGySWZzfEY6JCH9wfpoLGgKh3pVPSwfgS2HvW8
 FgqhQ0/51Hpiti+o/LEgpPDxg+TSVu7cAQsWLijuxYLQuP8pRJjZq31kwNKtLfOc2AfQ
 MwJMJLdx+mQ6IlRUddF0bfZKKkLjD6W8tXF180MwtZe5ZObLhmbfeD1h2StJWsJ/AU4y
 q/cB1Mshrm89ImNyDtvPCmtdFA+3C9G/QJsLr759LiQ8sqj++6TqdfmiM5LPDeXrm33z
 uDGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXWs3Bsn5PVqn8I9RufxLDPCbj2Mk/9HoMNZm4dH5Ncsem86BpbT9KllKH5h+xQY0uJ8eVxMeySN6g@nongnu.org
X-Gm-Message-State: AOJu0YwcQp+SAIpu9+fp0gRTTyAanEOp+fgSNkNeJqQEmM2L6ess7gBL
 yormW+n78BAEs8UFi9w4/kMnLRnhuUFtVK3LoRBS2WWuvUGWGJ9OX+Re6uJk7HtL66N5rHLPuRE
 FU0AQCCy9MiprFqGF+8h7oQSsFc6RPP524ot/4jMXACDvjr6S5M6yMYP1xUXl
X-Gm-Gg: ASbGncv2RwriH4dF7yRZy/1ZnnWormtbEflXY/XqGF97veHgsrFzAKIIMq7pyRhS+sY
 ElQCByoV3csxX4n9P8rk87Ap6Xk6InlVQU+sRlf2+NTkEwOheJ2qcHOk9pZBLQ0WN22PFIZz8oM
 ouW2MzicID9gl5M1g2iR2sr0XJjC7+Ibiv6wG7hZlUOtik2vOFVUwxmCqElruZPte4RsSB69XYn
 Hc1CPOQF+9Xo7N2/pLoo4g2B8kwkCxw27mT7ERzAwOAyFRGiAogGukrsJ1uN7ZfuYHnYNOlNjvH
 1ytfSxOXxZiBh35mp7EJn32eRSewIzWSwFzx5CJDlZAMHq3KlgJ+
X-Received: by 2002:a05:6000:3101:b0:3a0:b53a:7b3b with SMTP id
 ffacd0b85a97d-3a1f646d9a0mr8973656f8f.12.1747054724685; 
 Mon, 12 May 2025 05:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSXCewcuBb1hmWOuIw8I0ssj04ABCFQOOJaSTK94gVMCQa5K+cfJCFA0VXk/KzoXG4Qoz+vQ==
X-Received: by 2002:a05:6000:3101:b0:3a0:b53a:7b3b with SMTP id
 ffacd0b85a97d-3a1f646d9a0mr8973640f8f.12.1747054724372; 
 Mon, 12 May 2025 05:58:44 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c5a4sm12317668f8f.81.2025.05.12.05.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:58:43 -0700 (PDT)
Message-ID: <8ef01b37-bd99-4bc5-997e-df197f7f7c3f@redhat.com>
Date: Mon, 12 May 2025 14:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add PCI hotplug test for aarch64
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org
References: <20250509232156.106465-1-gustavo.romero@linaro.org>
 <80e7eacc-0b71-4e1c-981e-607a4ce8a7bd@redhat.com>
 <e25812d6-cc1d-4727-b24e-208dbbe54afa@linaro.org>
 <b3c9413d-971e-4ac9-8314-93b88b349495@redhat.com>
 <d6cf5356-4cac-448c-9078-f5bbe5d2de84@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
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
In-Reply-To: <d6cf5356-4cac-448c-9078-f5bbe5d2de84@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/05/2025 14.46, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 5/12/25 09:37, Thomas Huth wrote:
>> On 12/05/2025 14.08, Gustavo Romero wrote:
>>> Hi Thomas,
>>>
>>> Thanks for the review.
>>>
>>> On 5/12/25 04:59, Thomas Huth wrote:
>>>>   Hi!
>>>>
>>>> On 10/05/2025 01.19, Gustavo Romero wrote:
>>>>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>>>>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>>>>> native controller and does not support ACPI-based hotplugging. However,
>>>>> since support is planned, this test sets 'acpi=force' and specifies an
>>>>> EDK2 firmware image in advance. This is harmless and prepares for future
>>>>> ACPI support.
>>>>>
>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>> ---
>>>>>   tests/functional/meson.build                 |  1 +
>>>>>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>>>>>   2 files changed, 74 insertions(+)
>>>>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>>>
>>>> Could you also add the test file to one of the sections in the 
>>>> MAINTAINERS file, please?
>>>
>>> Any idea under which section I should add this test?
>>>
>>> Currently, it's only TCG, but in the future probably there will be
>>> 1) a variant with --enable-kvm option and 2) it will have a variant
>>> with ACPI enabled. Hence, currently it doesn't seem to fit neither
>>> under "PCI" nor under "ARM ACPI Subsystem", I think I can create a
>>> section tho? Maybe "ARM PCI Hotplug"? Could you please advise?
>>
>> A separate section likely only makes sense if there are other files that 
>> you could add there. Otherwise, simply add it to the arm "Virt" machine 
>> section?
> 
> hm but in this case wouldn't I be kind "forcing" Peter to maintain
> this test? And, otoh, if I add me to "Virt" section then I'm saying that
> I'll maintain all the other tests as well?

Ok, in that case a separate section makes sense ... Peter, do you have any 
preferences?

  Thomas



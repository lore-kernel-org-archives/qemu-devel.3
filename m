Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B8DC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5NE-0005mo-GM; Thu, 06 Feb 2025 12:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tg5N9-0005mO-4Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:09:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tg5N6-0003qw-35
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738861738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BG53nlMU04NGKq+xa3R9304BpAVaRsdp8Zom4aGenhA=;
 b=dINn+58O/ntLqUWpdDPa8VS7o/UHaosFfTmTpbv/G4GjUEJb+Vo/0Dnd6xszxzTn1IFb+2
 4Mv1B/fbJunI7+81yF9tRUOPeVxZb4Xwj7T2xPVFJj465efpJi2rOSHR/lJIoAyG3ORNoK
 VDe6R8pl5yYxohTYIsdhMvke1AXHIxo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-npUaUyvuMFC1EboKMe0z-g-1; Thu, 06 Feb 2025 12:08:57 -0500
X-MC-Unique: npUaUyvuMFC1EboKMe0z-g-1
X-Mimecast-MFC-AGG-ID: npUaUyvuMFC1EboKMe0z-g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436289a570eso10153025e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738861736; x=1739466536;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BG53nlMU04NGKq+xa3R9304BpAVaRsdp8Zom4aGenhA=;
 b=fR7D+n+ixnn0vvg5XZgXvhUrMBVy3qXSBu+XePgv1zka7In/NitYvH6TUvRQpmFHoY
 v4QvXK6uCn7gzjZRJPX/ozp6LwYZYCz0ytr4wOCVxQBmT0BMO6dq/9NhZlEjThTs7gQL
 34K7yn4cwKRTTRhCxRAGRy1WlMMa/L1m/vqQWeW661GbloBcPDIEzbaxPBIKIOhMah88
 c0FRKdeCoHsXzUfyR39C5I3e5bs1vJG3N5D+sQIx0JesWjMGBJ1MMdZU28wlHJc+nXd9
 Msosen4ZnzpwxFsDWzagPGgnsuB/6mYQuLvxk42oCRs/mpVUMj4PPBgp0+Ye2Eo5tlkJ
 YVGQ==
X-Gm-Message-State: AOJu0YzoQbQgE7kKCYlst32s0ooMhLF3Wb9omcpYKNZVV1rVh4b7PJby
 ZSDIkF+qa06vn+U0Ck3EJyh8iH22ksTjcU2N6dxPPpBdKARYe+yyXd4FWpGl2tOzFGWO8Xr4UqU
 D4xx1FCUdewvWC2HxtY/kZjYFERkzZEbOBP9oDL+cw1bJVQsYkXVX
X-Gm-Gg: ASbGnct7L/3JrzkWmtX6yHvQIQw1dWfJivwGqlPEke7/9tCArkc7QbmdKVB8FrjCxfZ
 qdEFMofJtrRuveH9LLuYysRzo+dZCc0pYbD7uvdw4+1HDG2fCae9TJA+qDKIrTNoTaJxrPmu3wc
 k3A34dVoR37hn5Km9q9fxuvAlCEx1WGGg6HgEcBhYS8pmnqwQKujRJqBqipEhbY9xJH68IrNgVI
 re+j5UQD/8j+hBj5YBKn97uA3hXd0JcZLg6cKIUvvJgQEK1iF7rzt323V3cCA/Bv2cpD2G8MMjL
 mOs0PGMYB8urD+hdJ4EMaOn/ME1waJk73MIF
X-Received: by 2002:a05:600c:83c8:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-439249a7ad8mr2053625e9.23.1738861735782; 
 Thu, 06 Feb 2025 09:08:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpYci+cvj2Nq+DwHELaIblVcZ2g4fu1z0D+h4Nm0jfvtP/mj6qGOLNXCNMl25aIk2t51kJoA==
X-Received: by 2002:a05:600c:83c8:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-439249a7ad8mr2052965e9.23.1738861735332; 
 Thu, 06 Feb 2025 09:08:55 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1ddaesm2177603f8f.85.2025.02.06.09.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 09:08:53 -0800 (PST)
Message-ID: <ece11f17-af70-4c17-9444-78de29405671@redhat.com>
Date: Thu, 6 Feb 2025 18:08:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
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
In-Reply-To: <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 06/02/2025 16.04, Philippe Mathieu-Daudé wrote:
> On 6/2/25 15:31, Daniel P. Berrangé wrote:
>> On Thu, Feb 06, 2025 at 02:53:58PM +0100, Philippe Mathieu-Daudé wrote:
>>> Hi Daniel,
>>>
>>> On 6/2/25 14:20, Daniel P. Berrangé wrote:
>>>> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
>>>>> Introduce an abstract machine parent class which defines
>>>>> the 'little_endian' property. Duplicate the current machine,
>>>>> which endian is tied to the binary endianness, to one big
>>>>> endian and a little endian machine; updating the machine
>>>>> description. Keep the current default machine for each binary.
>>>>>
>>>>> 'petalogix-s3adsp1800' machine is aliased as:
>>>>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>>>>> - 'petalogix-s3adsp1800-le' on little-endian one.
>>>>
>>>> Does it makes sense to expose these as different machine types ?
>>>>
>>>> If all the HW is identical in both cases, it feels like the
>>>> endianness could just be a bool property of the machine type,
>>>> rather than a new machine type.
>>>
>>> Our test suites expect "qemu-system-foo -M bar" to work out of
>>> the box, we can not have non-default properties.
>>>
>>> (This is related to the raspberry pi discussion in
>>> https://lore.kernel.org/qemu-devel/20250204002240.97830-1- 
>>> philmd@linaro.org/).
>>>
>>> My plan is to deprecate 'petalogix-s3adsp1800', so once we
>>> remove it we can merge both qemu-system-microblaze and
>>> qemu-system-microblazeel into a single binary.
>>>
>>> If you don't want to add more machines, what should be the
>>> endianness of the 'petalogix-s3adsp1800' machine in a binary
>>> with no particular endianness? Either we add for explicit
>>> endianness (fixing test suites) or we add one machine for
>>> each endianness; I fail to see other options not too
>>> confusing for our users.
>>
>> We would pick an arbitrary endianness of our choosing
>> I guess. How does this work in physical machines ? Is
>> the choice of endianess a firmware setting, or a choice
>> by the vendor when manufacturing in some way ?
> 
> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
> (wired to a CPU pin which is sampled once at cold reset).

If it's a jumper on the board instead of two separate boards, then I think 
this is a good indication that this should only be a machine property, and 
not two separate boards?

 > My worry is about how to not break what distros currently ship.

So once the two binaries got unified, maybe we could still add a hook 
somewhere that checks argv[0] and sets the endianess property according to 
the name of the binary, so users can still use a symlink to force the 
opposite behavior?

Anyway, you likely don't have to solve this problem right in this series 
here already, we can think of this later when one of the binaries gets 
marked as deprecated. So for this series here, I'd suggest to go ahead 
without adding the -le and -be machine types and only use a property first, 
then tackle the remaining questions later...?

  Thomas



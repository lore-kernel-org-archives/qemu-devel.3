Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94624CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWE9-0001uO-Vn; Mon, 25 Aug 2025 08:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqWDl-0001pG-Fi
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqWDi-0002WH-5d
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756124558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4+svR04L0NmtAAK+IW3f3RxiqUVja2hT5b4er5Qg2Q=;
 b=FfmNEzsGOBWHf1rnNY87A4jRvx5aLjjnNLRQb0wmIInZHtv49rwmuXN4sRUe/L5nj0ihxI
 XCD38oskD3EcLmFLm5Q1OPMU7zkHayQjB8IRDOAtYCC1LJPQMdC2npGFI6QbRg/ej09awW
 YF8LJFFmOCKvPWObbfgnjGNPSuguJSA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-_GmHanBDMI2pMNy6rY3JoQ-1; Mon, 25 Aug 2025 08:22:36 -0400
X-MC-Unique: _GmHanBDMI2pMNy6rY3JoQ-1
X-Mimecast-MFC-AGG-ID: _GmHanBDMI2pMNy6rY3JoQ_1756124556
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e86f8f27e1so1172248685a.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 05:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756124556; x=1756729356;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S4+svR04L0NmtAAK+IW3f3RxiqUVja2hT5b4er5Qg2Q=;
 b=DpZlCSiTB7OmziDNl7trXTdfpAQeMsGuJlpOTF3+Llv/uGEql/8W1Bw9w1sQ9oT4fb
 dEbdrrqZwNB4ffWTMcMWiDak8WIy0w94zds8XneATCUqnO721rCj3phUlnUsJHoa0Bvo
 ur2BVMCnyiKLdr9+uqFmdMBQ6P2rJFaaYH1V/FLiU3McUjpAPOt6w65AjSjNCLvnGIN2
 /Cz4+t8HwwybhAT75P8HC5FlFqI4FHgQeK1CQjqNw51qCypYg7o0vzW7UOfL7G9DE7i+
 ykyhrhF/DNymO6fW0bDNppnGp5qwgU8P0x+3DLGiMD92kzQOaWv5g1Fq8e9S3A4kJDbf
 wg5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Vfh3ObcC9d2ay+J1ZzrdOIrs6q/gc4b8Abe/BW9J2BhMSDOEW+Wr/3zjb4Mn2R/9Dn5AjzyAF5YT@nongnu.org
X-Gm-Message-State: AOJu0YzDaWEbbZ8K6HIkern96uIYgatwhwr33JMuQfzRW4NCx4S3++N3
 00Q4AUN462tO/UFrtjzUCUd/EOVm9PzvTiUr7vLtJx9+YP2j96BmX9zsZ0D6qE8pVpsxpr7S+kP
 wkVVTK8+WHhkMQG9cF1tjgKNqcuBIFc5uz3y5FMroqXIXYHF+ivM4A4pi
X-Gm-Gg: ASbGncu3b6yVdPp2GXQxgIje8Hs7Bim3SL92+n9cKdego7n0vbnCVlnNHWfe1T1rWEv
 xKoVuwsusgdrXUq7in6DQzWZ5suU/9DJ7HTyBpq3VX6V7zWe+JWhswqyLqwbcvm0D0BhbnpZruv
 Nm3hGO4SNdqFZrypXGzEvwKWQbr3/ZZo2wJUsViayP/Wnm5zhU6+j8oSy+I5MTsdz1ZeqpWgN47
 gQLjsJzBlMCTgP62PQU5e25L7VSFIKXRN7muIYEYMtwuohGGKHeugjcnf8pAk9goimmWKnAJSFt
 faUWXR5rhSUMCtTPOWguIvZAO/gp3jeAop0rNpxqy4n1bmNv5dn7BYqRKLk1lIoQiIshlHCAECm
 1oJg=
X-Received: by 2002:a05:620a:1a10:b0:7e6:38a8:bbd1 with SMTP id
 af79cd13be357-7ea11514301mr1276638585a.2.1756124555960; 
 Mon, 25 Aug 2025 05:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBZOdCrkjkh5UcnbVw+lrMtDaRFdnfh+Nkizrp1sIt7j74FxSqOnm6zIs9LjVl/XMalNqeIg==
X-Received: by 2002:a05:620a:1a10:b0:7e6:38a8:bbd1 with SMTP id
 af79cd13be357-7ea11514301mr1276634385a.2.1756124555375; 
 Mon, 25 Aug 2025 05:22:35 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7eeb4bc9c65sm312051285a.9.2025.08.25.05.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 05:22:35 -0700 (PDT)
Message-ID: <fd6f2788-b1a8-41af-88b5-9eb2ebdfd9d8@redhat.com>
Date: Mon, 25 Aug 2025 14:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
 <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
 <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
 <0b6d96c7-b28f-42c0-93db-579d80f0298b@linux.ibm.com>
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
In-Reply-To: <0b6d96c7-b28f-42c0-93db-579d80f0298b@linux.ibm.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/08/2025 14.08, Harsh Prateek Bora wrote:
> 
> 
> On 8/25/25 17:28, Thomas Huth wrote:
>> On 25/08/2025 13.46, Harsh Prateek Bora wrote:
>>> Hi Thomas,
>>>
>>> On 8/25/25 17:04, Thomas Huth wrote:
>>>> On 25/08/2025 13.24, Harsh Prateek Bora wrote:
>>>>> Hi Glenn,
>>>>>
>>>>> This seems significant work. Thanks for upstreaming.
>>>>>
>>>>> On 8/20/25 02:58, Glenn Miles wrote:
>>>>>> Adds the IBM PPE42 family of processors supporting the
>>>>>
>>>>> family of 32-bit processors ?
>>>>>
>>>>>> PPE42, PPE42X and PPE42XM processor versions.  These
>>>>>> processors are used as embedded processors in the IBM
>>>>>> Power9, Power10 and Power12 processors for various
>>>>>> tasks.  It is basically a stripped down version of the
>>>>>> IBM PowerPC 405 processor, with some added instructions
>>>>>> for handling 64-bit loads and stores.
>>>>>>
>>>>>> For more information on the PPE 42 processor please visit:
>>>>>>
>>>>>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>>>>>
>>>>>> Supports PPE42 SPR's (Including the MSR) and  Exceptions.
>>>>>>
>>>>>> Does not yet support new PPE42 instructions and does not
>>>>>> prevent access to some invalid instructions and registers
>>>>>> (currently allows for access to invalid GPR's and CR fields).
>>>>>>
>>>>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>>>>> ---
>>>>>>   target/ppc/cpu-models.c      |   7 +
>>>>>>   target/ppc/cpu-models.h      |   4 +
>>>>>>   target/ppc/cpu.h             |  66 +++++++-
>>>>>>   target/ppc/cpu_init.c        | 286 ++++++++++++++++++++++++++++++-----
>>>>>>   target/ppc/excp_helper.c     | 171 +++++++++++++++++++++
>>>>>>   target/ppc/helper_regs.c     |  28 +++-
>>>>>>   target/ppc/tcg-excp_helper.c |  12 ++
>>>>>>   target/ppc/translate.c       |   6 +-
>>>>>>   8 files changed, 535 insertions(+), 45 deletions(-)
>>>>>>
>>>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>>>>> index ea86ea202a..09f73e23a8 100644
>>>>>> --- a/target/ppc/cpu-models.c
>>>>>> +++ b/target/ppc/cpu-models.c
>>>>>> @@ -116,6 +116,13 @@
>>>>>>                   NULL)
>>>>>>       POWERPC_DEF("x2vp20", CPU_POWERPC_X2VP20,                 405,
>>>>>>                   NULL)
>>>>>> +    /* PPE42 Embedded 
>>>>>> Controllers                                            */
>>>>>> +    POWERPC_DEF("PPE42",         CPU_POWERPC_PPE42, ppe42,
>>>>>> +                "Generic PPE 42")
>>>>>> +    POWERPC_DEF("PPE42X",        CPU_POWERPC_PPE42X, ppe42x,
>>>>>> +                "Generic PPE 42X")
>>>>>> +    POWERPC_DEF("PPE42XM",       CPU_POWERPC_PPE42XM, ppe42xm,
>>>>>> +                "Generic PPE 42XM")
>>>>>
>>>>> Can all the PPE42 specific code be conditionally compiled only for
>>>>> !TARGET_PPC64 (and !CONFIG_USER_ONLY wherever possible)?
>>>>> Not only to reduce the bloating size of respective binaries, but also to
>>>>> avoid some code being added to hot path routines like 
>>>>> hreg_compute_hflags_value().
>>>>
>>>> qemu-system-ppc64 is a superset of qemu-system-ppc, and there are even 
>>>> efforts to unify all system functionality into a singly binary, so 
>>>> excluding a 32-bit feature from qemu-system-ppc64 sounds like a step 
>>>> into the wrong direction to me right now...?
>>>
>>> We do have existing code getting conditionally compiled for TARGET_PPC64
>>> which I guess gets enabled with:
>>>   --configure target-list=<ppc64|ppc>-softmmu
>>> I understand the efforts are towards having a single binary to support
>>> both, but what gets built-in is still decided with configure choice?
>>>
>>> Please correct/clarify with above understanding.
>>
>> As I said, qemu-system-ppc64 is currently a full superset of qemu-system- 
>> ppc. The ppc64 binary contains all the 32-bit code, you can perfectly run 
>> a "g3beige" or "bamboo" machine with qemu-system-ppc64, too. By disabling 
>> the ppe42 code in the ppc64 binary, this would now introduce an execption 
>> to that unwritten rule, so I'd expect that we'd not rather want to do this 
>> now.
> 
> My understanding is that above holds true only for default builds which
> builds all targets. We certainly do not build 32 bit ppc code when using
> --configure target-list=ppc64-softmmu. (we have ppc-softmmu for 32 bit though)

Just give it a try:

  ./configure --target-list=ppc64-softmmu --disable-docs
  make -j$(nproc)
  ./qemu-system-ppc64 -M g3beige

... works perfectly fine for me.

AFAIK we don't have a switch to disable 32-bit code in the ppc64 binary.

  Thomas



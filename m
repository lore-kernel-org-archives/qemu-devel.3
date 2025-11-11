Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD85CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIk69-00088e-UY; Tue, 11 Nov 2025 03:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIk68-000878-8g
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIk66-0001dz-4x
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762851089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LeDDi3bip7TKweRgmN+2pXA3bXVsyJSBQ/WpY3R+cP4=;
 b=T/UVjP8HMhqGMotdUH7HMEtPBNVJjjdw4//sWokaRgGy2sEkiCn6UkJvftfTvDisKXtU9n
 KstU8of2uzdyiy6er/42M5kSCKFlji6OwEYEUNlSPam1qQxn/zVZCKFf4lsTXGbqDhD+VF
 xKIgyKEDO4ifdjPJUwGDbTPa7HXHxB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526--pnrYK5tNaKjAkt_4iok8w-1; Tue, 11 Nov 2025 03:51:28 -0500
X-MC-Unique: -pnrYK5tNaKjAkt_4iok8w-1
X-Mimecast-MFC-AGG-ID: -pnrYK5tNaKjAkt_4iok8w_1762851087
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477771366cbso13436865e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 00:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762851087; x=1763455887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LeDDi3bip7TKweRgmN+2pXA3bXVsyJSBQ/WpY3R+cP4=;
 b=rnQlB7ILM1Bih2etmcJGEPb5iHMGXZ+OR4T9EoaefNOapB4LWoP2PQu/3Ww/PzlDtp
 iQCNCdOw+45wqBiQPMs5WsP2N0bNpqotFf2CVNWzzEEMZzl8oAtsjGiAr6bE8JLUb9Zc
 BCk0BQPAmkUM1c07US1wTmGMc+D822igpR7yjV50TSlAofrpwp3LpUYAaotH/2crrREE
 2a4ec2kwfs30UJfypArUaeA8L6XhGk364PwXBYisCSVekXJeqHKi6ekRyujU85sqaAGL
 VNyDAbIGlrE2rFiNWZAUqkVQpZsf275R164T+iOLRpFytuKE06EpGDH0nlPzq8JUQ+S2
 l6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762851087; x=1763455887;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeDDi3bip7TKweRgmN+2pXA3bXVsyJSBQ/WpY3R+cP4=;
 b=KAtJktbJMadhqQ4UiYHzZYj/PW61raFJBFWSjk3k58FRG8qj5k3F3+RX+iq4IcO3jP
 JymhKI4Ak7APgLgv4lCxGw1FqV/BXU11ZH77E9TCi0407d9QPjucL0kcnBAFf6VZBgo2
 go3pVi6oPAemC4J6POb7NapzZQ3ztq5LeTI2pJTulgikhUtvg54dw4yArvprUjFFT7lC
 Ws+5ahSF9m4kXOXTJ0WqvvxnAmjUqKod1zgPgISmiMfUtU0do78RLYDxULX6Q5YMVIa3
 fhHdvfcO7pJG/72AN0c/q+g0wCReKLu8RVkU0SES28oVPRyReoYFeLwqQqrVLcQhsr9b
 FEjg==
X-Gm-Message-State: AOJu0YwYdgPjzZMdoy0oDfXcmnUWDeHVMOxjthGUb0jRpQXg2fOYVBsw
 eoVSBGCgjGndydMNx8nIBQDzCdbCGbqvm7PHHfq4fRWVQKEqqfkBwQOkjFowELqba+nlrNpyFvY
 nIeHB8xkUNILljCO1qP4GFBx0uj0T4VOO5pdX3Az+Gh2Dl+vVHl84+OiD
X-Gm-Gg: ASbGncs51ZTgVAGpPxLaId5/B8FYEg1F9FRsxlXhvkKrmrHQClIRIGMW5WRntdxVZo8
 5/I/gomWjrT+yx+OqqGXe84PRVq7PBkZPyvEhXuN4TfQ7I/MaABRpS9la66hwDnD/81GltbrxLg
 9VCkHE0pV0/jGZbTN0qm/pHgstN+JhnimUfVhfRLkz1maeu2jOtlD/W8eGr1+szxO98n6kZLC6a
 Jke8OzVPgXVfL5qrdbOTWQMx408Ib1yn9Tk1EU/RCHuETyaR0rnPabG/7uDhHK9r1ksm4hnw8S6
 kN6LKF2fINqkM8Mw1mWz4FrrHC7pKRUNHpQ0NsGX1S+cQTQ9PDaHJm+EtET9FQqN0m5uOr0=
X-Received: by 2002:a05:600c:1553:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-47773233f22mr80128235e9.14.1762851086589; 
 Tue, 11 Nov 2025 00:51:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/AySR41nBH+XK4sTOmb7m18C7EJROvcNK++DKH3+pZoNuDipHOTEmEsjaphoNOYmOScRrxg==
X-Received: by 2002:a05:600c:1553:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-47773233f22mr80128015e9.14.1762851086075; 
 Tue, 11 Nov 2025 00:51:26 -0800 (PST)
Received: from [192.168.0.7] ([47.64.113.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bd084d4sm307958625e9.14.2025.11.11.00.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 00:51:25 -0800 (PST)
Message-ID: <d5990a22-76dc-4c20-ba38-6179899a3f42@redhat.com>
Date: Tue, 11 Nov 2025 09:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <2347cd4a-dc40-410a-89f0-9c7b261cff29@linux.ibm.com>
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
In-Reply-To: <2347cd4a-dc40-410a-89f0-9c7b261cff29@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/11/2025 09.43, Christian Borntraeger wrote:
> Am 29.04.25 um 07:20 schrieb Nicholas Miehlbradt:
>> The reset performed by subcode 3 of the diag308 instruction specifies
>> that system memory should be reset. This patch implements that
>> behaviour.
>>
>> Introduce S390_RESET_REIPL_CLEAR to differentiate between subcode 3 and
>> subcode 4 resets.
>>
>> When doing a clear reset, discard the ramblock containing the system
>> ram.
>>
>> Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.h             | 1 +
>>   hw/s390x/s390-virtio-ccw.c | 6 ++++++
>>   target/s390x/diag.c        | 3 +--
>>   target/s390x/kvm/kvm.c     | 6 +++++-
>>   4 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index cb55101f06..9c38946363 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -38,6 +38,7 @@ enum s390_reset {
>>       /* default is a reset not triggered by a CPU e.g. issued by QMP */
>>       S390_RESET_EXTERNAL = 0,
>>       S390_RESET_REIPL,
>> +    S390_RESET_REIPL_CLEAR,
>>       S390_RESET_MODIFIED_CLEAR,
>>       S390_RESET_LOAD_NORMAL,
>>       S390_RESET_PV,
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 94edd42dd2..bc07158b16 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -455,6 +455,7 @@ static void s390_machine_reset(MachineState *machine, 
>> ResetType type)
>>       enum s390_reset reset_type;
>>       CPUState *cs, *t;
>>       S390CPU *cpu;
>> +    RAMBlock *rb = machine->ram->ram_block;
>>       /*
>>        * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
>> @@ -479,6 +480,7 @@ static void s390_machine_reset(MachineState *machine, 
>> ResetType type)
>>       switch (reset_type) {
>>       case S390_RESET_EXTERNAL:
>>       case S390_RESET_REIPL:
>> +    case S390_RESET_REIPL_CLEAR:
>>           /*
>>            * Reset the subsystem which includes a AP reset. If a PV
>>            * guest had APQNs attached the AP reset is a prerequisite to
>> @@ -489,6 +491,10 @@ static void s390_machine_reset(MachineState *machine, 
>> ResetType type)
>>               s390_machine_unprotect(ms);
>>           }
>> +        if (reset_type == S390_RESET_REIPL_CLEAR) {
>> +            ram_block_discard_range(rb, 0 , qemu_ram_get_used_length(rb));
>> +        }
>> +
>>           /*
>>            * Device reset includes CPU clear resets so this has to be
>>            * done AFTER the unprotect call above.
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index da44b0133e..cff9fbc4b0 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -105,8 +105,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, 
>> uint64_t r3, uintptr_t ra)
>>           s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
>>           break;      case DIAG308_LOAD_CLEAR:
>> -        /* Well we still lack the clearing bit... */
>> -        s390_ipl_reset_request(cs, S390_RESET_REIPL);
>> +        s390_ipl_reset_request(cs, S390_RESET_REIPL_CLEAR);
>>           break;
>>       case DIAG308_SET:
>>       case DIAG308_PV_SET:
>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>> index b9f1422197..f2d5f7ddc0 100644
>> --- a/target/s390x/kvm/kvm.c
>> +++ b/target/s390x/kvm/kvm.c
>> @@ -1915,7 +1915,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct 
>> kvm_run *run)
>>               ret = handle_intercept(cpu);
>>               break;
>>           case KVM_EXIT_S390_RESET:
>> -            s390_ipl_reset_request(cs, S390_RESET_REIPL);
>> +            if (run->s390_reset_flags & KVM_S390_RESET_CLEAR) {
>> +                s390_ipl_reset_request(cs, S390_RESET_REIPL_CLEAR);
>> +            } else {
>> +                s390_ipl_reset_request(cs, S390_RESET_REIPL);
>> +            }
>>               break;
>>           case KVM_EXIT_S390_TSCH:
>>               ret = handle_tsch(cpu);
> 
> 
> 
> Do I see that right that this patch never made it into qemu master? IIRC 
> Matt has clarified all concerns?

I was hoping to see a reply from David that he's fine with the patch now... 
David?

  Thomas



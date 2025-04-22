Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6598C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FGE-0005bR-FH; Tue, 22 Apr 2025 11:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7FGC-0005Zo-NW
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7FG9-0007Ir-Gt
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745334603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/nbIa040A8xza9H3Pnbs8b0YdIX8O/u3eKJFV6DWU9s=;
 b=geTYoSFhz7tGumwTQ8Grc7iqEy57lz6o846ycPOTwAU3MiqSQOyxe3BnERwxOX1//IsrKo
 pBtJxaMdUHeAVLIe8LvbVcsohZudkoLzkMa5WL/m3LlLTFa1Ca8++mwBchs+8rouX3v31y
 ScT5u9yhngGIptwu5Dbuwnb4jMmmlhM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-F73MoE83PrGrcvxSDPNj2Q-1; Tue, 22 Apr 2025 11:10:02 -0400
X-MC-Unique: F73MoE83PrGrcvxSDPNj2Q-1
X-Mimecast-MFC-AGG-ID: F73MoE83PrGrcvxSDPNj2Q_1745334601
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39131851046so1540496f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745334601; x=1745939401;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/nbIa040A8xza9H3Pnbs8b0YdIX8O/u3eKJFV6DWU9s=;
 b=sniwYg+IiTkwCufeaPb6tHXLq2sAkw5+DKz7WQl1aDGKvFLj6j1zYoqG2cQ1MA8LRx
 a0pUG+XdJaHhV4kaRYeCwrNztdBU6SJGL1z2gzKuHLSwq00eHRU0KVxcK61HjxiP2if4
 p0heNgk4qNVFUFXB1ZsB9sd4wPP+8O/ByedzpOHXUake38U/kqlgc0vyV9XqN4tXyj4u
 X0p8s1RQOgug/BKj0aBrSLa8cbdYhXfh13Uajdz0yDThZG7QkfHu3M2TO2GFE8EPfcQS
 CSaQPDn2t/fl7ouueMQyxCsbc15V4GT2RY6kbWcpH6gME0KPkNKeKAWal4La+f8VKC8R
 T2eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWicBxroCf3TOIgAVG+jWZAcqKs1tPzdoj2g1U5aOFoM970xr5cQxr7NDmjNqe7sSnyyRYyq0FWpE+O@nongnu.org
X-Gm-Message-State: AOJu0YwG7E92bYGy+le6vKTQbhcdqFm7jm0YmLJ7JNt5OzStYdOv2YCx
 CUT7KKlTPFji8B3hx4Y5PZ6cqEsyDNP1bk70qVHD8qhlqYsv9/0caham1v7LvMgYNnp9qimzB1q
 HhfUamRwDTysjBELoUWrj5lnKkwE+uXmiSYJfGOSYusS7VDgDYaFF
X-Gm-Gg: ASbGncsR9cnvlU3wppiZtjmooLvpAntAnq2icYVm8mzGDvrEBZ1NYfp3pJNaNfEgWk/
 6pIMe7qETx/DgBMNMA2PJggtYy3PwWhAPOOB4GPt1Jk8MYwDolYbgcFMsvwyo9G0cztSb9aX6mg
 HMtyZZOnn1R38A8UtFKNOLSYz8VnE5kawEMb+xU2R4U1Ir7M1Grcn4mDVWYfcwcAOigOMBadzDQ
 VVssh2x2LO7YV36n0fMzAxwASj9cnJqjhuvYIiO4Opw3yUJp2XgHQ22VO7u8qMJvbrrC9NXH0S+
 0obWt48VL0kA3dTIIBu0kuzmSSyrd0ixMv5+xLb8r+216A==
X-Received: by 2002:a5d:59ab:0:b0:391:2ab1:d4c2 with SMTP id
 ffacd0b85a97d-39efbacdb68mr11492789f8f.37.1745334600885; 
 Tue, 22 Apr 2025 08:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYzoB44/wkgg6eXkwvpiAH/WnzIbL/Iu1GnN3GA5lnm6z75aGFlS9zlDp6kjwwBMTsuAOaVw==
X-Received: by 2002:a5d:59ab:0:b0:391:2ab1:d4c2 with SMTP id
 ffacd0b85a97d-39efbacdb68mr11492755f8f.37.1745334600475; 
 Tue, 22 Apr 2025 08:10:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4330bfsm15511894f8f.23.2025.04.22.08.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:10:00 -0700 (PDT)
Message-ID: <5a526ecf-d62d-46c8-9881-fdec381693e3@redhat.com>
Date: Tue, 22 Apr 2025 17:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] target/s390x: Return UVC cmd code, RC and RRC
 value when DIAG 308 Subcode 10 fails to enter secure mode
To: Janosch Frank <frankja@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>, 
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>
References: <20250417123756.729132-1-ggala@linux.ibm.com>
 <20250417123756.729132-4-ggala@linux.ibm.com>
 <7d812276-9f93-4fbd-90d4-b5d1cdd8c63b@linux.ibm.com>
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
In-Reply-To: <7d812276-9f93-4fbd-90d4-b5d1cdd8c63b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On 22/04/2025 15.17, Janosch Frank wrote:
> On 4/17/25 2:37 PM, Gautam Gala wrote:
>> Extend DIAG308 subcode 10 to return the UVC RC, RRC and command code
>> in bit positions 32-47, 16-31, and 0-15 of register R1 + 1 if the
>> function does not complete successfully (in addition to the
>> previously returned diag response code in bit position 47-63).
>>
>> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
>> ---
> 
> [...]
> 
>> +void s390_pv_inject_reset_error(CPUState *cs,
>> +                                struct S390PVResponse pv_resp)
>>   {
>>       int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
>>       CPUS390XState *env = &S390_CPU(cs)->env;
>> +    union {
>> +        struct {
>> +            uint16_t pv_cmd;
>> +            uint16_t pv_rrc;
>> +            uint16_t pv_rc;
>> +            uint16_t diag_rc;
>> +        };
>> +        uint64_t regs;
>> +    } resp = {.pv_cmd = pv_resp.cmd,
>> +              .pv_rrc = pv_resp.rrc,
>> +              .pv_rc = pv_resp.rc,
>> +              .diag_rc = DIAG_308_RC_INVAL_FOR_PV};
>> +
> 
> @Thomas: Is the formatting of the assignments correct or should there be no 
> assignment on lines containing "{}"?
> 
> Checkpatch is happy, though personally I find it hard to read.

I think I'd rather have the ".pv_cmd = ..." start on the next line.

  Thanks
   Thomas




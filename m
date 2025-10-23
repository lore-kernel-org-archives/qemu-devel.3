Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7840CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwd0-0001mc-63; Thu, 23 Oct 2025 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBwck-0001jM-0L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBwcb-0004l8-H6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761230935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xIZbzuPyXsQk+DSfgxPKW+WhINXBYB2iVplxqca4bOo=;
 b=RssdcaNYFmIZKTSroguaUGTWY2Uok7B/AnaOOa7Hl//H9PyQ15FH93ojd7oI9C7ojIqdiR
 qnDCg1qNqzPGFHzqltarun+o+gKk3Z4ZO4fPcURuVwUGvx7/HXBCsPh43ZlOX0Eu913J/Z
 wjVKVDG8hswAklekWsPhxx31BQDYB/w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-qGlo2hI0P-CTMms0hvdv-w-1; Thu, 23 Oct 2025 10:48:53 -0400
X-MC-Unique: qGlo2hI0P-CTMms0hvdv-w-1
X-Mimecast-MFC-AGG-ID: qGlo2hI0P-CTMms0hvdv-w_1761230932
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475c422fd70so5458675e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761230932; x=1761835732;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xIZbzuPyXsQk+DSfgxPKW+WhINXBYB2iVplxqca4bOo=;
 b=nXDOJhLwfRxweljiGOIlD9KcMA+mVATkCOLZ6tov72uuoBz5NyHn89M7RkGV0a5hA5
 ZTw7oSsBJ8SvxUQs+cO1HiyoQuKeD6Rywu07BV56phqgljcWusKFB0SDQ7UPLYvFuGsE
 9uaDF8qdjTlFwMhlqENlTzJix5qHSkXH9+RZoGqeVSUtjiZsC0ee/pIm9y2vtAoRa9B9
 hKhFc5Gy8metFpiQc+z5cUbfQncHIxAoC0IrATnxpB1c2+LZyBzy0kUMEX5AaAci1/h5
 ZbBMQpD/29+i8yGWABx5IIcqDYHIEt4n1Uq3z3wfrfTZ/NaOnZjuqmyN+b3d4zlkmR/0
 45mA==
X-Gm-Message-State: AOJu0YwLK0Olc+52OIOqe0vbIa8T1nUJ5AtIVHjReTkMZy3020C+q2bJ
 5Bou67EeyBRLA1KQVOe9Bp4vzu46GdCocCp9Yt5x7qKBhQMxrK0FjoLhHVBooB7nsFJajPWh8Ni
 ttCe2msXipwetTdZQx2+Wf4vU+dEQ+hkcyUJMdIWYSm6OaOulRaOjpAJb
X-Gm-Gg: ASbGnct9f7ZnXV/YhWY0lUEldpYJFVE+rpFMht/hfUVYbYCkSKGmO9Bd2uebSZjuYLN
 q7xcbokHokW23KcIGA8DuQCPn2y4C64hX7TH6UO5kOd/IoS3m/ms9wFsdY7waMy00Fd6mTVInd1
 WC91IVHTkt+7/dnkGSCInvQ3sKOfkwN/pjTL863t1aOFACeg7Qi1cZ5sUb5Oy52WPWoxzzA1Rjn
 o8oLJQyEsoB4x+tqhlBmL6PjkG9PVPHC6mrv2eU/4PGTSu/q7vFZ8OaxS8TNpRbdF3/9/4UAOnW
 xVcm3myaxxWqJz8Rq2J/N3mty8GTdnxXe+F/oAfuOjW27MPSUIji9W0wACZUsBdR+og/lw3THtW
 ApbMtQF/RLIjcMR7M3TPNLsHTK8uEbszls0akXOk=
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id
 5b1f17b1804b1-471179123admr181520815e9.21.1761230931564; 
 Thu, 23 Oct 2025 07:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW9eh5+/EefrBy60U73dSkST28Xwf8yCXVCrricVgM5n5Q1HoYcrXYV5OSgafXjPwmKdFzig==
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id
 5b1f17b1804b1-471179123admr181520515e9.21.1761230931058; 
 Thu, 23 Oct 2025 07:48:51 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf15498sm49528075e9.12.2025.10.23.07.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:48:50 -0700 (PDT)
Message-ID: <61c3cd65-5451-412c-8291-3b00d17047d9@redhat.com>
Date: Thu, 23 Oct 2025 16:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Remove the unusable e200 CPUs
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251017144504.563594-1-thuth@redhat.com>
 <ff63dc6b-42c7-44f8-b0d0-268d3745a88f@linux.ibm.com>
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
In-Reply-To: <ff63dc6b-42c7-44f8-b0d0-268d3745a88f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 23/10/2025 12.07, Harsh Prateek Bora wrote:
> Hi Thomas,
> I am seeing below CI failure with this patch:
> 
> In file included from ../target/ppc/cpu_init.c:46:
> In function ‘register_BookE206_sprs’,
>      inlined from ‘init_proc_e500’ at ../target/ppc/cpu_init.c:2910:5:
> ../target/ppc/spr_common.h:57:5: error: array subscript 3 is outside array 
> bounds of ‘uint32_t[2]’ {aka ‘unsigned int[2]’} [-Werror=array-bounds=]
>     57 |     _spr_register(env, num, name,              \
>        | 
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     58 |                   USR_ARG(uea_read) USR_ARG(uea_write)              \
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     59 |                   SYS_ARG(oea_read) SYS_ARG(oea_write)              \
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     60 |                   SYS_ARG(hea_read) SYS_ARG(hea_write)              \
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     61 |                   KVM_ARG(one_reg_id) initial_value)
>        |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/ppc/spr_common.h:66:5: note: in expansion of macro 
> ‘spr_register_kvm_hv’
>     66 |     spr_register_kvm_hv(env, num, name, uea_read, uea_write, 
> oea_read,       \
>        |     ^~~~~~~~~~~~~~~~~~~
> ../target/ppc/spr_common.h:77:5: note: in expansion of macro ‘spr_register_kvm’
>     77 |     spr_register_kvm(env, num, name, uea_read, uea_write, 
>               \
>        |     ^~~~~~~~~~~~~~~~
> ../target/ppc/cpu_init.c:894:9: note: in expansion of macro ‘spr_register’
>    894 |         spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
>        |         ^~~~~~~~~~~~
> ../target/ppc/cpu_init.c: In function ‘init_proc_e500’:
> ../target/ppc/cpu_init.c:2809:14: note: at offset 12 into object ‘tlbncfg’ 
> of size 8
>   2809 |     uint32_t tlbncfg[2];
>        |              ^~~~~~~
> In function ‘register_BookE206_sprs’,
>      inlined from ‘init_proc_e500’ at ../target/ppc/cpu_init.c:2910:5:
> ../target/ppc/spr_common.h:57:5: error: array subscript 2 is outside array 
> bounds of ‘uint32_t[2]’ {aka ‘unsigned int[2]’} [-Werror=array-bounds=]
>     57 |     _spr_register(env, num, name,              \
>        | 
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     58 |                   USR_ARG(uea_read) USR_ARG(uea_write)              \
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     59 |                   SYS_ARG(oea_read) SYS_ARG(oea_write)              \
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     60 |                   SYS_ARG(hea_read) SYS_ARG(hea_write)              \
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     61 |                   KVM_ARG(one_reg_id) initial_value)
>        |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/ppc/spr_common.h:66:5: note: in expansion of macro 
> ‘spr_register_kvm_hv’
>     66 |     spr_register_kvm_hv(env, num, name, uea_read, uea_write, 
> oea_read,       \
>        |     ^~~~~~~~~~~~~~~~~~~
> ../target/ppc/spr_common.h:77:5: note: in expansion of macro ‘spr_register_kvm’
>     77 |     spr_register_kvm(env, num, name, uea_read, uea_write, 
>               \
>        |     ^~~~~~~~~~~~~~~~
> ../target/ppc/cpu_init.c:900:9: note: in expansion of macro ‘spr_register’
>    900 |         spr_register(env, SPR_BOOKE_TLB2CFG, "TLB2CFG",
>        |         ^~~~~~~~~~~~
> ../target/ppc/cpu_init.c: In function ‘init_proc_e500’:
> ../target/ppc/cpu_init.c:2809:14: note: at offset 8 into object ‘tlbncfg’ of 
> size 8
>   2809 |     uint32_t tlbncfg[2];
>        |              ^~~~~~~
> cc1: all warnings being treated as errors
> [1374/1838] Compiling C object libqemu-ppc-softmmu.a.p/target_ppc_gdbstub.c.o
> [1375/1838] Compiling C object libqemu-ppc-softmmu.a.p/target_ppc_cpu- 
> models.c.o
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:168: run-ninja] Error 1
> Cleaning up project directory and file based variables
> 00:00
> ERROR: Job failed: exit code 1
> 
> Kindly take a look.

Drat, I think I likely only tested it in a build folder where I had run 
configure with --disable-werror earlier, that's why I didn't notice. Sorry 
for that. I'll try to come up with a fix and send a v2 when it's ready.

  Thomas



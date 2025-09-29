Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2250CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Dy0-0000CA-Gu; Mon, 29 Sep 2025 09:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Dxw-0000BV-1w
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Dxj-0000YR-Rh
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759152627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B3VqoqtRVvSRBtsjz80NI7VbQOTlekqwcEaT7aog+ps=;
 b=MdADUt2x5PkdQvpeayMWCEplzS4H6uvTkp2747IHS1ml+mq/1nDDXafhQ8JHjPe69pZah/
 8N2GpLiPhbLvSwl9M3o4nhdJDtpgO8dTQ/G0N4LDCOe6LCUfJUbBuVjXKW7j/zl7Q1qzJX
 detxcXNEWIF6sYaf6+7Bs9boSPW5gWQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-jxt0rijoM8-cvRjpXIskqQ-1; Mon, 29 Sep 2025 09:30:24 -0400
X-MC-Unique: jxt0rijoM8-cvRjpXIskqQ-1
X-Mimecast-MFC-AGG-ID: jxt0rijoM8-cvRjpXIskqQ_1759152623
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso2344985f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 06:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759152623; x=1759757423;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3VqoqtRVvSRBtsjz80NI7VbQOTlekqwcEaT7aog+ps=;
 b=NLhka2KdDr+1CIxQi0drdswKMN/m2NQ+FZbXZe/VqdhQsqfJlCh0wRV4ufbWCEauG8
 IJSRh/uPQLhQezA1ccyM8wo2HhKE5HYiuPoWZ1t9IJI1S5c4NA7fcE7PQGGJfBgxrqHx
 D6wk9BBiH2WflRcDfZovgRoYFRMfBlcAreiOHgp1QbEk0ifZEE2qFxl9r/MEzT4tDaln
 rfZKUM/UEH0ATGz7WbZUtGCRj8FfwiDaeMCoRplif/crWnTetEu4vlgEKjS5tubcOTlD
 pwktWyp4PBGkb8V084RukDHGTDGWClivfJNKOZOV9EdUM4wB5xBz3qMwHhJ2cfOB+zog
 LBVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbBDEkT0GSOLuA6KK5Hx7GUkvDkzRz8bXa2Ekcy0LOWEmKyOlMjimVNL+opZ62wjcbNaFMljBbrGn3@nongnu.org
X-Gm-Message-State: AOJu0YxvqYTmZeXiwdkA3VNopI9s5Hj3uRGY7N1nFaBacQJ50uTGfB7A
 CUVtqg58srxxJ8p8PZ8B4qF/uLRYpo0muFbYmIZ3/3hOLmaYoIctDDT38azWUhuyX0sSwjVE8Kr
 A/JNuMr+UEKp0dNjwDgKcCzzQV78e81p85wfqQqkfTCOyEOovFuOJ/3zf
X-Gm-Gg: ASbGncsIUtpujyZvoXn7iTbrESDucvlwdxSHUKng9Ru2Ke/48iE5OwW4pNCxUQuv7ot
 e4c+JkOnFTDaqz+LfuEUzk1vEtyFoLKMfDkq9SUsaiSwEp3i6kLydLutstlS2i2XzBAySLphz1B
 S2Hz2FCEqupAhVh7oagozHF2Zg/an5tS3esGG2gr88kGO4t9E+N5H9yOoIkyLs/9zv3E2eo4HyQ
 67GitWFfayRfyA7wO5pp866K+5RK4F9FK7tD1Fj5A9K4lObH6wmQBmQ9O2gkhpb+Lktqey4QVQd
 xVltNZzq+zjnfdyY3Q1hs9g1NCGb3uokmuzmLI0LG9wawzqJROpzsDLLQuvg6XHmPOqg17lZdt1
 dJVGJLw==
X-Received: by 2002:a05:6000:2301:b0:3e9:54d1:e708 with SMTP id
 ffacd0b85a97d-424119ce8e9mr559443f8f.20.1759152623371; 
 Mon, 29 Sep 2025 06:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETzU8hV29f1UVPhK4fyktO1v3OCVMdBBLCDwWoZSQ9Gbzjd3dQh2GDWkCB3zLrXNbTQnAfag==
X-Received: by 2002:a05:6000:2301:b0:3e9:54d1:e708 with SMTP id
 ffacd0b85a97d-424119ce8e9mr559392f8f.20.1759152622779; 
 Mon, 29 Sep 2025 06:30:22 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921f4esm18347839f8f.44.2025.09.29.06.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 06:30:22 -0700 (PDT)
Message-ID: <e5faaffd-fb58-4002-817f-ff9e787e8272@redhat.com>
Date: Mon, 29 Sep 2025 15:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/28] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, borntraeger@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-22-zycai@linux.ibm.com>
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
In-Reply-To: <20250917232131.495848-22-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
> 
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
> 
> When the secure IPL code loading attributes facility (SCLAF) is installed,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
> 
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
> 
> When SCLAF is installed, its content must be evaluated during secure IPL.
> However, a missing SCLAB will not be reported in audit mode. The SCALB
> checking will be skipped in this case.
> 
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
> 
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 8eab19cb09..cd798c1198 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -202,6 +202,12 @@ static bool secure_ipl_supported(void)
>           return false;
>       }
>   
> +    if (!sclp_is_sclaf_on()) {
> +        puts("Secure IPL Code Loading Attributes Facility is not supported by" \

No need for the backslash here.

> +             " the hypervisor!");
> +        return false;
> +    }
> +
>       return true;
>   }
>   
> @@ -214,6 +220,393 @@ static void init_lists(IplDeviceComponentList *comps, IplSignatureCertificateLis
>       certs->ipl_info_header.len = sizeof(certs->ipl_info_header);
>   }
>   
> +static bool is_comp_overlap(SecureIplCompAddrRange *comp_addr_range, int addr_range_index,

I'd suggest to move the second parameter to a separate line, to keep the 
line length below 80 columns.

> +                            uint64_t start_addr, uint64_t end_addr)
> +{
> +    /* neither a signed nor an unsigned component can overlap with a signed component */
> +    for (int i = 0; i < addr_range_index; i++) {
> +        if ((comp_addr_range[i].start_addr <= end_addr &&
> +            start_addr <= comp_addr_range[i].end_addr) &&
> +            comp_addr_range[i].is_signed) {
> +            return true;
> +       }
> +    }
> +
> +    return false;
> +}
> +
> +static void comp_addr_range_add(SecureIplCompAddrRange *comp_addr_range,
> +                                int addr_range_index, bool is_signed,
> +                                uint64_t start_addr, uint64_t end_addr)
> +{
> +    if (addr_range_index > MAX_CERTIFICATES - 1) {

That error goes completely unnoticed. Should there be a log / warning here?

> +        return;
> +    }
> +
> +    comp_addr_range[addr_range_index].is_signed = is_signed;
> +    comp_addr_range[addr_range_index].start_addr = start_addr;
> +    comp_addr_range[addr_range_index].end_addr = end_addr;
> +}
> +
> +static void check_unsigned_addr(uint64_t load_addr, IplDeviceComponentList *comps,
> +                                int comp_index)
> +{
> +    uint32_t flag;
> +    const char *msg;
> +    bool valid;
> +
> +    valid = validate_unsigned_addr(load_addr);
> +    if (!valid) {
> +        flag = S390_IPL_COMPONENT_CEI_INVALID_UNSIGNED_ADDR;
> +        msg = "Load address is less than 0x2000";
> +        set_cei_with_log(comps, comp_index, flag, msg);

I'd maybe rather pass the string directly as parameter, without the detour 
through the "msg" variable.

> +    }
> +}
> +
> +static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
> +                               int *addr_range_index,
> +                               uint64_t start_addr, uint64_t end_addr, bool is_signed)
> +{
> +    bool overlap;
> +
> +    overlap = is_comp_overlap(comp_addr_range, *addr_range_index,
> +                              start_addr, end_addr);
> +    if (!overlap) {
> +        comp_addr_range_add(comp_addr_range, *addr_range_index, is_signed,
> +                            start_addr, end_addr);
> +        *addr_range_index += 1;
> +    } else {
> +        zipl_secure_handle("Component addresses overlap");
> +    }
> +}
> +
> +static bool check_sclab_presence(uint8_t *sclab_magic,
> +                                 IplDeviceComponentList *comps, int comp_index)
> +{
> +    if (!validate_sclab_magic(sclab_magic)) {
> +        comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
> +
> +        /* a missing SCLAB will not be reported in audit mode */
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void check_sclab_length(uint16_t sclab_len,
> +                               IplDeviceComponentList *comps, int comp_index)
> +{
> +    const char *msg;
> +    uint32_t flag;
> +    bool valid;
> +
> +    valid = validate_sclab_length(sclab_len);
> +    if (!valid) {
> +        flag = S390_IPL_COMPONENT_CEI_INVALID_SCLAB_LEN |
> +               S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
> +        msg = "Invalid SCLAB length";
> +        set_cei_with_log(comps, comp_index, flag, msg);

Again, pass string directly, without msg variable?

> +    }
> +}
> +
> +static void check_sclab_format(uint8_t sclab_format,
> +                               IplDeviceComponentList *comps, int comp_index)
> +{
> +    const char *msg;
> +    uint32_t flag;
> +    bool valid;
> +
> +    valid = validate_sclab_format(sclab_format);
> +    if (!valid) {
> +        flag = S390_IPL_COMPONENT_CEI_INVALID_SCLAB_FORMAT;
> +        msg = "Format-0 SCLAB is not being use";
> +        set_cei_with_log(comps, comp_index, flag, msg);

dito

> +    }
> +}
> +
> +static void check_sclab_opsw(SecureCodeLoadingAttributesBlock *sclab,
> +                             SecureIplSclabInfo *sclab_info,
> +                             IplDeviceComponentList *comps, int comp_index)
> +{
> +    const char *msg;
> +    uint32_t flag;
> +    bool is_opsw_set;
> +    bool valid;
> +
> +    is_opsw_set = is_sclab_flag_set(sclab->flags, S390_SECURE_IPL_SCLAB_FLAG_OPSW);
> +    if (!is_opsw_set) {
> +        valid = validate_sclab_opsw_zero(sclab->load_psw);
> +        if (!valid) {
> +            flag = S390_IPL_COMPONENT_CEI_SCLAB_LOAD_PSW_NOT_ZERO;
> +            msg = "Load PSW is not zero when Override PSW bit is zero";
> +            set_cei_with_log(comps, comp_index, flag, msg);
> +        }
> +    } else {
> +        /* OPSW = 1 indicating global SCLAB */
> +        valid = validate_sclab_opsw_one(sclab->flags);
> +        if (!valid) {
> +            flag = S390_IPL_COMPONENT_CEI_SCLAB_OLA_NOT_ONE;
> +            msg = "Override Load Address bit is not set to one in the global SCLAB";
> +            set_cei_with_log(comps, comp_index, flag, msg);

Is it ok here to continue with the code below, even if it was not valid? Or 
should there be a return statement here?

> +        }
> +
> +        sclab_info->global_count += 1;
> +        if (sclab_info->global_count == 1) {
> +            sclab_info->load_psw = sclab->load_psw;
> +            sclab_info->flags = sclab->flags;
> +        }
> +    }
> +}
> +
> +static void check_sclab_ola(SecureCodeLoadingAttributesBlock *sclab,
> +                            uint64_t load_addr, IplDeviceComponentList *comps,
> +                            int comp_index)
> +{
> +    const char *msg;
> +    uint32_t flag;
> +    bool is_ola_set;
> +    bool valid;
> +
> +    is_ola_set = is_sclab_flag_set(sclab->flags, S390_SECURE_IPL_SCLAB_FLAG_OLA);
> +    if (!is_ola_set) {
> +        valid = validate_sclab_ola_zero(sclab->load_addr);
> +        if (!(valid)) {

No need for the inner braces here.

> +            flag = S390_IPL_COMPONENT_CEI_SCLAB_LOAD_ADDR_NOT_ZERO;
> +            msg = "Load Address is not zero when Override Load Address bit is zero";
> +            set_cei_with_log(comps, comp_index, flag, msg);
> +        }
> +
> +    } else {
> +        valid = validate_sclab_ola_one(sclab->load_addr, load_addr);
> +        if (!valid) {
> +            flag = S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_ADDR;
> +            msg = "Load Address does not match with component load address";
> +            set_cei_with_log(comps, comp_index, flag, msg);
> +        }
> +    }
> +}
> +
> +static void check_sclab_nuc(uint16_t sclab_flags, IplDeviceComponentList *comps,
> +                            int comp_index)
> +{
> +    const char *msg;
> +    uint32_t flag;
> +    bool is_nuc_set;
> +    bool is_global_sclab;
> +
> +    is_nuc_set = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_NUC);
> +    is_global_sclab = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_OPSW);
> +    if (is_nuc_set && !is_global_sclab) {
> +        flag = S390_IPL_COMPONENT_CEI_NUC_NOT_IN_GLOBAL_SCLA;
> +        msg = "No Unsigned Components bit is set, but not in the global SCLAB";
> +        set_cei_with_log(comps, comp_index, flag, msg);
> +    }
> +}
> +
> +static void check_sclab_sc(uint16_t sclab_flags, IplDeviceComponentList *comps,
> +                           int comp_index)
> +{
> +    const char *msg;
> +    uint32_t flag;
> +    bool is_sc_set;
> +    bool is_global_sclab;
> +
> +    is_sc_set = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_SC);
> +    is_global_sclab = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_OPSW);
> +    if (is_sc_set && !is_global_sclab) {
> +        flag = S390_IPL_COMPONENT_CEI_SC_NOT_IN_GLOBAL_SCLAB;
> +        msg = "Single Component bit is set, but not in the global SCLAB";
> +        set_cei_with_log(comps, comp_index, flag, msg);
> +    }
> +}
> +
> +static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRange *comp_addr_range,
> +                         int range_index)
> +{
> +    uint32_t addr = psw & 0x3FFFFFFF;

Shouldn't that be 0x7fffffff instead?

> +    /* PSW points within a signed binary code component */
> +    for (int i = 0; i < range_index; i++) {
> +        if (comp_addr_range[i].is_signed &&
> +            addr >= comp_addr_range[i].start_addr &&
> +            addr <= comp_addr_range[i].end_addr) {

is it still OK if the address points to the end_addr? Or should that be 
end_addr - 2 instead (since an opcode has at least two bytes)?

> +            return true;
> +       }
> +    }
> +
> +    return false;
> +}
...
>   
> +static inline bool is_sclab_flag_set(uint16_t sclab_flags, uint16_t flag)
> +{
> +    return (sclab_flags & flag) != 0;
> +}
> +
> +static inline bool validate_unsigned_addr(uint64_t comp_load_addr)
> +{
> +    /* usigned load address must be greater than or equal to 0x2000 */
> +    return comp_load_addr >= 0x2000;
> +}
> +
> +static inline bool validate_sclab_magic(uint8_t *sclab_magic)
> +{
> +    /* identifies the presence of SCLAB */
> +    return magic_match(sclab_magic, ZIPL_MAGIC);
> +}
> +
> +static inline bool validate_sclab_length(uint16_t sclab_len)
> +{
> +    /* minimum SCLAB length is 32 bytes */
> +    return sclab_len >= 32;
> +}
> +
> +static inline bool validate_sclab_format(uint8_t sclab_format)
> +{
> +    /* SCLAB format must set to zero, indicating a format-0 SCLAB being used */
> +    return sclab_format == 0;
> +}
> +
> +static inline bool validate_sclab_ola_zero(uint64_t sclab_load_addr)
> +{
> +    /* Load address field in SCLAB must contain zeros */
> +    return sclab_load_addr == 0;
> +}
> +
> +static inline bool validate_sclab_ola_one(uint64_t sclab_load_addr,
> +                                          uint64_t comp_load_addr)
> +{
> +   /* Load address field must match storage address of the component */
> +   return sclab_load_addr == comp_load_addr;
> +}
> +
> +static inline bool validate_sclab_opsw_zero(uint64_t sclab_load_psw)
> +{
> +    /* Load PSW field in SCLAB must contain zeros */
> +    return sclab_load_psw == 0;
> +}
>
> +static inline bool validate_sclab_opsw_one(uint16_t sclab_flags)
> +{
> +   /* OLA must set to one */
> +   return is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_OLA);
> +}
> +
> +static inline bool validate_lpsw(uint64_t sclab_load_psw, uint64_t comp_load_psw)
> +{
> +    /* compare load PSW with the PSW specified in component */
> +    return sclab_load_psw == comp_load_psw;
> +}

Most of these inline functions just compare something with 0 or other values 
here, and you only use them in one spot of the code ... So you need 5 lines 
of code for something that could be done in two lines of code at the calling 
sites instead, i.e. this looks like unnecessary code to me. Please inline 
the comparisons (together with the comment that you've got here) in the 
calling sites to get rid of this code bloat.

  Thanks,
   Thomas



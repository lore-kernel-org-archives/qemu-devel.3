Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8475CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KNl-00064c-Sz; Thu, 16 Oct 2025 05:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KNk-00064N-H2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KNd-00021i-EM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760607277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wjo9tJC7WDlQMs+Wn6lV/c+5ExuHfNrq7AArbOtReJ4=;
 b=fLZHGFuB3NITlipqtj1v9mYeZDW3Xg7VNgt2X94xAWtBOUswuUL0GYmKFlq7DCHKUCOu6/
 gvcomJdyFB+mIDJdnvHTdXrJysuYaBmTxuE4y485cWi52KZee6AEBleU1IsZ5+vhUKlpIz
 2SAf8HfZFELgENJMV4rNr2BndMtHLtY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-OBQVSsNiP2KkxEIJnEKYzg-1; Thu, 16 Oct 2025 05:34:36 -0400
X-MC-Unique: OBQVSsNiP2KkxEIJnEKYzg-1
X-Mimecast-MFC-AGG-ID: OBQVSsNiP2KkxEIJnEKYzg_1760607274
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee12ab7f33so211063f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760607274; x=1761212074;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wjo9tJC7WDlQMs+Wn6lV/c+5ExuHfNrq7AArbOtReJ4=;
 b=kIzOGj8bYDTuHxEprbQW3CIndZoNdKfSGHCUrCkL26U3DSerOBKloh8Cvx0+DPPhEl
 FihB7Mw89kpzi4ywW3oVZdUOqEIl8hnmqtbkG8QbZD1CS48JlPNZ5204Jtoh9WCEZcLL
 7wpfJTeMeCAXn6H2xb2C1w9T3FlnZxCfZCq4P5jRVC5xlDXYiGfaUovH9ta1jikkFLsK
 uaWdajsx1nfhmDZDqAP+0ENhybpx1UVhqweTTvOfKeYCiNziOmrJq3YTOweAeLtG0M17
 fD7AsxQmTEw9Am4tLMyZRELDoL6ZMJQRl419qdt4uqnFRMy8SjENX4FBlTxaOQ4hDsxW
 xU/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYzeBqZoMe6MpthYXm3uPFVF2MBd6NwVu25jgqZpwmVqnMoYGg+1OS5zvE3mfK3kO0m4mdqX1fHlve@nongnu.org
X-Gm-Message-State: AOJu0YysHxRX5dgE0LAkeVVCQay9p4Ylc6Zb0EJVcjgpvJQvTM6sqsDr
 45lxp55CB+v/7PB5Xow4xi+OaQCWUxHX6UM7FwwbVBmzG1N2+ebE6gDDUul52g2LziVmaSQPYcE
 wMNzAdNkWqiFWtE/22tqXwM6KTTWYVjNiLknFYUTR2VgzZPWxzOIJvRaGtPa1ap8p
X-Gm-Gg: ASbGncsubl/LEIivO5/RZyAsgauHjE72TW2fmeQKM58ktyCs2ssP1GY3DXgu2Z+4Zam
 r/xnQyy4YA9OBr8ngXgv6fKfRMrupM4OZsg86RVdgGFp6f2YbRfL3rbKXvZC8AacQboXKi+K246
 urU2uVbGaN0G0sgSKgpjo0f/aAWEk2aZdtnaJup7uA/tjgIOvUbNXfeI7b6Bcx0uMvAl9LxC3BC
 MYUU542msT4zX1wMVnHXOAy3+yC23AxpSpMl8+QMKBBKomBneZmuSG1wOHrrRQR4BwOpBaaNa5M
 MT3QlfaiZwDVwo7t97fkAg9XLvPqbzSH/UyL4tyGDVSWJLb9nw76E8RDrmncbyzt5uVgUfGpK7q
 A7Dvz5Rh2ICxTLv/OmID8aY7srtDtDcpZGiAFWEt4
X-Received: by 2002:a05:6000:250a:b0:402:a740:1edd with SMTP id
 ffacd0b85a97d-4266e7dfeb4mr22980277f8f.39.1760607274196; 
 Thu, 16 Oct 2025 02:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRqWBc/vOkmEMoBEOQWQr+32gCnBDvvrhBvqWsKtSVpGrOHyxCFS7+cxKh2Ai2DWBkv+K9RQ==
X-Received: by 2002:a05:6000:250a:b0:402:a740:1edd with SMTP id
 ffacd0b85a97d-4266e7dfeb4mr22980251f8f.39.1760607273767; 
 Thu, 16 Oct 2025 02:34:33 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1284sm33320693f8f.45.2025.10.16.02.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 02:34:33 -0700 (PDT)
Message-ID: <4fd19e9b-2a91-4a55-880e-ddd9826fbf29@redhat.com>
Date: Thu, 16 Oct 2025 11:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/s390x/mmu_helper: Simplify
 s390_cpu_virt_mem_rw() logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20251008141410.99865-1-philmd@linaro.org>
 <20251008141410.99865-2-philmd@linaro.org>
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
In-Reply-To: <20251008141410.99865-2-philmd@linaro.org>
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

On 08/10/2025 16.14, Philippe Mathieu-Daudé wrote:
> In order to simplify the next commit, move the
> trigger_access_exception() call after the address_space_rw()
> calls. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/mmu_helper.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 487c41bf933..22d3d4a97df 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -541,9 +541,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>       pages = g_malloc(nr_pages * sizeof(*pages));
>   
>       ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
> -    if (ret) {
> -        trigger_access_exception(&cpu->env, ret, tec);
> -    } else if (hostbuf != NULL) {
> +    if (ret == 0 && hostbuf != NULL) {
>           AddressSpace *as = CPU(cpu)->as;
>   
>           /* Copy data by stepping through the area page by page */
> @@ -556,6 +554,9 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>               len -= currlen;
>           }
>       }
> +    if (ret) {
> +        trigger_access_exception(&cpu->env, ret, tec);
> +    }
>   
>       g_free(pages);
>       return ret;

Reviewed-by: Thomas Huth <thuth@redhat.com>



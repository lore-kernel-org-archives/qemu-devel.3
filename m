Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC2CCCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6TSG-0003LJ-FD; Wed, 08 Oct 2025 08:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6TSE-0003Kj-8W
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6TS2-0007dz-4U
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759927160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xJ3bC2XNpdwps5TKScSgQfzcmo3SBfvH58vfrMb+ORc=;
 b=A1RJepOdWorqE7o9bUiBmkBKjn6qJBSRa8vO2D2IWzJfolvqKLWHlLMAktWd/mTkstuJ4O
 ZWT9aDgl+moNgq5b3ttOTB86JtKBin9MvHgJq5nL9bXt1Y9PrACh+RThL7SS3pulhwPNVq
 UScEI2Ts6LURbOPmdeyH59qcC+Vsn8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-hoTRYN_WNjGjRyVOIBys7Q-1; Wed, 08 Oct 2025 08:39:19 -0400
X-MC-Unique: hoTRYN_WNjGjRyVOIBys7Q-1
X-Mimecast-MFC-AGG-ID: hoTRYN_WNjGjRyVOIBys7Q_1759927158
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e32eb4798so41347765e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 05:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759927158; x=1760531958;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xJ3bC2XNpdwps5TKScSgQfzcmo3SBfvH58vfrMb+ORc=;
 b=gSYKcEeltiFT08S9lcWq4fCAY3iqgpH1lxqhwZitLpqxaJjrnPbSCf3jMNTgx9+Esl
 iRYLCr0BsB2RmEl9Sr7up+3mrq212rEGWYeOqn11nZSUz9J1mpQoDur66u0j/WpWcjS4
 xq9mL132R7iWrjZiZkyqPd/AykcFlbEk15ks0FSOOH2LV9OonyJR6hD1wOLmC+nUe9jk
 P3aDOiLjNs8iazBGcO0GSuJ3YZcr1rGQ6rHAR8vQrL/rq//sAosHCDO6ROK+8jGLRW+4
 mw/vz0+Y/PbPCUEkhQd+JMrSOmVjanc6jdYu+XVARwK52oOhICG4gfq8o/g+PnICpjVF
 d+zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8DXFGfxUeugC9DG7BzlPLXTgGaAPIZGkUAhfdHIsr/aRvIe69zwWAr0mZB2wgYRzBFnSkxtBvKlKO@nongnu.org
X-Gm-Message-State: AOJu0Yz3e+7rTPQlrNdsjONHIskEwtulfdDXwXh1nwy8rjuEexmAU5wy
 HkYseHQ5KNNSM0NXUc3/WyRjz9ma/EkPeZH0zVDYzqDXGhi4UDmjMtw5ZXcPHvqLWfR9UE3Yx+B
 vWCyvmSXvPzm28orvbdgl+RsMGwHm+r6ow3WouvCB3nA1osBUph+DeopZ
X-Gm-Gg: ASbGnctGrLSH9ACxufi4H7WQlKD/dLWH+fakLB+1gu3d0ouLfZjQ+T4IWUC6Pzn64hS
 Dcs6RYyqa4wXoeYAayrLX1ddHc2MvK633pFvr515X/sri8RWSwPGOsw5y/KqZn+Kqo4IVZ0lLXD
 AKcGEJjRQl7XJYscVRkqAJ4uv3taHJib4nc/7awS9had+uPbly5R5fUgompcoI4sOZ64+6y1tW/
 PGkRDlTzSVxcPbAnSJGb4Tc4g6/TNFV88GUY3B7o1yoEzYLWFOYBTi//0Z0KUKQ9O/qe192NuwV
 HUiroxKuYD39B6GU3ksd44f6aHcUwQ1Y1m+HKh2bClI0zKMxtdt969FfkSlFIzEYm9/IJVxd6xW
 Pew9RxNhflA==
X-Received: by 2002:a05:600c:4753:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-46fa9aef36bmr20980805e9.19.1759927157988; 
 Wed, 08 Oct 2025 05:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1Wxty4GaUP6Bt6Lrzwxv/9fBRz8bMzx9ZI+JeNtac8Ggh2Kr+ikPyTsw1Tali9zAf6s9FoQ==
X-Received: by 2002:a05:600c:4753:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-46fa9aef36bmr20980635e9.19.1759927157564; 
 Wed, 08 Oct 2025 05:39:17 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d7f91esm36329445e9.20.2025.10.08.05.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 05:39:17 -0700 (PDT)
Message-ID: <6a0a9fa7-93cd-40bf-b493-c805c5db072a@redhat.com>
Date: Wed, 8 Oct 2025 14:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/mmu_helper: Do not ignore address_space_rw()
 errors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20251007021046.27470-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251007021046.27470-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 07/10/2025 04.10, Philippe Mathieu-Daudé wrote:
> Break the loop and return an error if address_space_rw() ever failed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251007014958.19086-1-philmd@linaro.org>
> ---
>   target/s390x/mmu_helper.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 7bcf1810bca..643141e7847 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -544,12 +544,18 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>           trigger_access_exception(&cpu->env, ret, tec);
>       } else if (hostbuf != NULL) {
>           AddressSpace *as = CPU(cpu)->as;
> +        MemTxResult res;
>   
>           /* Copy data by stepping through the area page by page */
>           for (i = 0; i < nr_pages; i++) {
>               currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
> -            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
> -                             MEMTXATTRS_UNSPECIFIED, hostbuf, currlen, is_write);
> +            res = address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
> +                                   MEMTXATTRS_UNSPECIFIED, hostbuf, currlen,
> +                                   is_write);
> +            if (res != MEMTX_OK) {
> +                ret = 1;

I think you'd need to call trigger_access_exception() here like it is done 
when translate_pages() failed earlier in this function. And I think I'd 
rather use ret = PGM_ADDRESSING in this case.

  Thomas


> +                break;
> +            }
>               laddr += currlen;
>               hostbuf += currlen;
>               len -= currlen;



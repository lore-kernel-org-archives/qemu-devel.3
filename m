Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F85ECCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KPk-0006s9-Q2; Thu, 16 Oct 2025 05:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KPi-0006rd-IQ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KPe-0002Or-W7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760607405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y5NUgVttnBSYtObq9rfGpzdttDAj2KLEewcuySqH4OE=;
 b=UaNdolBsL82leLGEY9arUX6blFGf0j4fCfSvx+wDza/kkWjl+A5v2S9OVdL5OLWGrK5eUE
 MwMy/ZQvLp8a8PwG8I9NVWaiB1MlmRbjz6DspD4691Qz3D4Ww/IHsgB2wrkLaf3s1AIjUi
 G2Qhaq1+sqF7GBjgbDIuddkCKqaK88k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-sSqQeQoGNkePfRxpmZS_Ew-1; Thu, 16 Oct 2025 05:36:44 -0400
X-MC-Unique: sSqQeQoGNkePfRxpmZS_Ew-1
X-Mimecast-MFC-AGG-ID: sSqQeQoGNkePfRxpmZS_Ew_1760607403
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e36686ca1so4024105e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760607402; x=1761212202;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5NUgVttnBSYtObq9rfGpzdttDAj2KLEewcuySqH4OE=;
 b=ABonjYaXolJ4gW/Su0oPkWWegVBoadxMev6aob0hmRWcOqKcQ/dFf0Bm9GliPl0Nhm
 PcpoqO02zy86lCj8tMw2xm1ieNwq1un8wgIa+HuagDHxjPdWeZ/7h90Fwe17kC2nS3kX
 zSgRGqkjWy0YatHLj3vN406/3HUiJu6KzYkG2NFhLW5SmU8rUMx5xOSTnHM5bfkE13ls
 DXOIy6/Qewa+X6TI/Di0fqLVmTuO3QL+GMEwYq80qN07JUCChW7IcYI9aYeqHyRi1pmX
 z4Bxku4KYzpozyxiIxL8wjFJVGQ4EhErN//nosXyCWUEfapLJF4CcdKTqI+JDKo9nrPU
 rFsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbzKuIfnf+Xy7pY2Yn4Xu/mqt7fK4Eb6HacneNvBCXJPP9j2LUJW6x/6ptctpF3uzOtig1+v+3XFcc@nongnu.org
X-Gm-Message-State: AOJu0YxKJ/pEql+HgsFh15qhnTKIF6dWWaYvFAjtx3tUz/MU64BHsP6E
 8vFPUiRjQfQqFdnJKMsqU5RMjcCQQzGNM5EuFg6+4BhquEYUoISExD4m5IYXQwtmeXX3wCdtDS/
 VADSI1VT8lqEoS3T0yCkDW8mnIBhK6eAcW8lmowDAbKwWZXZHLS/GKjOG
X-Gm-Gg: ASbGncsq9iQb1iBw6ZjmJOYK1RwoyMCSc75jD0y8g+HwE884w/xZqee9EfJVOiBNnYN
 N0GMdW2kPzhldDFZnBHvvFx63NfOlE+5MClqW5t1xurxzCJ1Otkpsu1WyZvcwoX7F0OSa/F99bs
 e2hX/uJRMwyyInTlS46+yv9ZKE/IEhfc3fOblzNoXv5KUD8ZDn0UhnNlY/7cUOZLxS0+WIMic+U
 S+UeU1RQF6lg7Hh2dfxqFB5TG4Lz0+JPGQzU1RSxay+VHU4Qo7GT9yINDQyP1e9XbCDQ3WA4ihp
 11yeCi36excF9WsHzN3Txrhfemq6m+VW7tJrhytHHDqweBLG1lazKGOZiJ6GrAzxczJDYNEDTaV
 jm/dMw1TLqAlycOHYmwaV2i6B4HuOUdmskVwBnPtk
X-Received: by 2002:a05:600c:3507:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-471131f8d68mr9793925e9.15.1760607402658; 
 Thu, 16 Oct 2025 02:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmqBpmLB0hMREuc2UmZtVh5CWoZRl+zb2W/RK38q7cYanpvzeD3P4ptHhQZHhb8nAdE4YTQg==
X-Received: by 2002:a05:600c:3507:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-471131f8d68mr9793705e9.15.1760607402227; 
 Thu, 16 Oct 2025 02:36:42 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca4931csm19214515e9.0.2025.10.16.02.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 02:36:41 -0700 (PDT)
Message-ID: <ac6576f8-e33f-4673-96cc-63105ef95a57@redhat.com>
Date: Thu, 16 Oct 2025 11:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/s390x/mmu_helper: Do not ignore
 address_space_rw() errors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20251008141410.99865-1-philmd@linaro.org>
 <20251008141410.99865-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251008141410.99865-3-philmd@linaro.org>
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

On 08/10/2025 16.14, Philippe Mathieu-Daudé wrote:
> If a address_space_rw() call ever fails, break the loop and
> return the PGM_ADDRESSING error (after triggerring an access
> exception).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/mmu_helper.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 22d3d4a97df..3b1e75f7833 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -546,9 +546,15 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>   
>           /* Copy data by stepping through the area page by page */
>           for (i = 0; i < nr_pages; i++) {
> +            MemTxResult res;
> +
>               currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
> -            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
> -                             attrs, hostbuf, currlen, is_write);
> +            res = address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
> +                                   attrs, hostbuf, currlen, is_write);
> +            if (res != MEMTX_OK) {
> +                ret = PGM_ADDRESSING;
> +                break;
> +            }
>               laddr += currlen;
>               hostbuf += currlen;
>               len -= currlen;

Reviewed-by: Thomas Huth <thuth@redhat.com>



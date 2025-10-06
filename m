Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9869ACCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lib-00018q-0u; Mon, 06 Oct 2025 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5liW-00018A-H3
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5liQ-0008Tp-Ro
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759759043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ACLs8rtNblhA4Ow2vHVhcjYUvBix51rFC9EmMAcYghg=;
 b=g5T3vKbGu59aYln2B/x5CS9jYTgF4hoQA5UxKczXTq4ZD9g9ImAlkN++TaZKdYwaHaBfU0
 d3l6L3bB3JWEbksX7ONjsNM07ETEAoo1MEXAKTM+oqEY69wTE6rdCVsOllUSBKOn0bCJrz
 9AAyDqf2i2vDmaSkWRia/g9FT5O5+hQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-2OhP6rbvNKOjQ8DFgYZnGg-1; Mon, 06 Oct 2025 09:57:16 -0400
X-MC-Unique: 2OhP6rbvNKOjQ8DFgYZnGg-1
X-Mimecast-MFC-AGG-ID: 2OhP6rbvNKOjQ8DFgYZnGg_1759759036
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so2531356f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 06:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759759035; x=1760363835;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACLs8rtNblhA4Ow2vHVhcjYUvBix51rFC9EmMAcYghg=;
 b=Y+zi4H+24Uitl4zGvcXMd8sKmhAKzPubanCQ8G7snq3SKD0r5sxKSH8zQDlQvjdh+G
 nRukKQl023/f+zDoFIZplY32tBN9k3if2H8pouJGsIFCqjgNHZdUj3JS/lFNA5vmvXOs
 JyTbqS8ATRHP2tbe5YyHH0QKX8kMd2YDzhLZ9td19l2or8XMEJ/GW/38jrC7O2slfAqf
 aleigxlQLXRjgr7lUH69k/1TtqFaL9IMk661e/pXSjbR4SCwy3Ax87ZHJHiv5hKWSgYj
 ZQarF3s8LrvhteJ+hN1eilBrRYwXyqsVwAHSdVKeN46ESDBXKu+GH4DwaLpUnvH3RcfR
 W8aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Wqs5kd+oEzX7ZlRbATzIUnDJi3TMbO9hKYuiPDmMY8gtFUtPXbm7APfhc/m9OtlJ/Y+5ziMMlqdz@nongnu.org
X-Gm-Message-State: AOJu0Yxljhggw8NyXp7jYL8TTsguYO3ixraHEGvnncHLd6niqeCY7rTX
 nyWFZTBEARfXiGe0bBcBb2ctYTqGVY9jZ0JXRjp6fxrIHDutcbrwsYjK49F4NYGmrh7OztRivZd
 3AC1mTL3REnS+bp4cXBYI1Vn2wU9OqfibE6sVDjbt9QJv8uCcyjGh7cPa
X-Gm-Gg: ASbGncvoOcjceOFDyCJBVtVFtDOepHWzGjk6/8Val2O4BMbpFAfpEtcblhu6xhIflFp
 J/nkq6d12yuLswhBA/hZOuwA79UencuJyw0WVSfSOj3Cu/+7mn+Hi9pl36utqXvJ4M0hxv6i8r3
 +GAdKYnzLUYPM9KBWsEtu+Ezg97RTjzXQK9D75a92bsJzZkfIPKPON9FpsgLg0KPpOrWiwyQsf4
 JKGWq+SqtO7Quh9XRuRc62QuD+Gmsa2ISML4SRqlCz4Mh6JN3pWFF3EAoVrD18yegvHKGlSctoc
 Vg6iEV5o3cSbSLepgG7ngkVbk71yHwL1V3pqNE2ql2ewqdtjsuDz0CkzOPLkiEzC7fhh8MS3lrM
 eQRePAOoR1Q==
X-Received: by 2002:a05:6000:288d:b0:3d1:6d7a:ab24 with SMTP id
 ffacd0b85a97d-4256714bdb4mr6730838f8f.17.1759759035504; 
 Mon, 06 Oct 2025 06:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdZXsENsxk3HFxYR7b20AQtLBPhWPYMNnZEEG8rUd2TJK5akAKvmOGOCmLPCVicUc854nlg==
X-Received: by 2002:a05:6000:288d:b0:3d1:6d7a:ab24 with SMTP id
 ffacd0b85a97d-4256714bdb4mr6730814f8f.17.1759759035024; 
 Mon, 06 Oct 2025 06:57:15 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b7e37sm255950635e9.1.2025.10.06.06.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 06:57:14 -0700 (PDT)
Message-ID: <aed7caad-b980-4040-a8af-e508df8e27be@redhat.com>
Date: Mon, 6 Oct 2025 15:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/s390x: Factor diag_iplb_read() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20251002091132.65703-1-philmd@linaro.org>
 <20251002091132.65703-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251002091132.65703-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

On 02/10/2025 11.11, Philippe Mathieu-Daudé wrote:

This patch is also missing a proper reasoning in the patch description.

  Thomas


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/diag.c | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index ed320fc0c1f..c2fedc55213 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -73,6 +73,24 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>       return 0;
>   }
>   
> +static bool diag_iplb_read(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
> +{
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
> +        if (!iplb_valid_len(iplb)) {
> +            return false;
> +        }
> +        s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
> +    } else {
> +        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        if (!iplb_valid_len(iplb)) {
> +            return false;
> +        }
> +        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> +    }
> +    return true;
> +}
> +
>   static void diag_iplb_write(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
>   {
>       const size_t iplb_len = be32_to_cpu(iplb->len);
> @@ -125,23 +143,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>               return;
>           }
>           iplb = g_new0(IplParameterBlock, 1);
> -        if (!s390_is_pv()) {
> -            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> -        } else {
> -            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
> -        }
>   
> -        if (!iplb_valid_len(iplb)) {
> +        if (!diag_iplb_read(iplb, cpu, addr)) {
>               env->regs[r1 + 1] = DIAG_308_RC_INVALID;
>               goto out;
>           }
>   
> -        if (!s390_is_pv()) {
> -            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> -        } else {
> -            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
> -        }
> -
>           valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
>           if (!valid) {
>               if (subcode == DIAG308_SET && iplb->pbt == S390_IPL_TYPE_QEMU_SCSI) {



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80394FC6175
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spChp-00089c-69; Fri, 13 Sep 2024 16:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spChn-00088f-Tp
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:15:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spChm-0007yi-23
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:15:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso24307395e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726258544; x=1726863344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ohNpXKmFykbqa2AKGrdpmS7ZsES50WYFxWUNwWY/IGs=;
 b=s10Vq+He3YycrX4duie4anvKFqcRd2i7fF8uw0gRlI9lEy0WrNIKlujKlLPRBWO7k2
 J8FKnP2jgvEA5I0b9M4CD/loROnP54KO0TTjJH22Gi7XngYi5PQxfiLaFcYapkhtlB1f
 KDvJ3VG+JN1j7fOr+upwu3PytxckgI6irNBI19aG+DpDAjQxJsnOe9WBGdY7C0qhsODe
 /AEOn8BUd0IRryc9vfVDE0QXbiPgRox9PmwcMNS3zsmgUZ1DzwuqFRDfOh/WKyqdNWZV
 OdsMuABmFlX/BP1Ef35dn3kycETRI+rbn1GzgdOGNTbwHTzlJDfNGb4kUIKjwGlDz+Xf
 5h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726258544; x=1726863344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohNpXKmFykbqa2AKGrdpmS7ZsES50WYFxWUNwWY/IGs=;
 b=RvtK3+C5Tt60Z/Wkqnzagfx/OniVPUODTFwA71XKBoXVhShTz/YfjxtZTQ6LgimHxd
 DxfsYRv5FPZTFJpz7YKmpv1LR5hQBiFXf2X+7BPAnUoGYpdRqLCg9ZUTSJbXZ+hCwzv/
 eAiFKSXIabQCBuhhdbtn+Xc0vt9vs9+u13xBSlG2xjAQ3420ZrerQoCb8FYoqJ3/XNII
 qOSSIK2Mnmj1Tns7iY/M10G7rmk3/v5KKk5+zTT9yk6Dl9OQ1n7qEeFDTQglet0uUXKp
 KIkJI3GcFQ+3qnevK98ckHm4xaxM2PnQF4JLP3eqGTziv5DqCoyH41JMFA17y/pPFHBq
 HHMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo9C5RhlHwhCI+sP4ZfTvnngJswgUh1ExI8FEF17bFha5jRnujqD+NCBjDaVySOHzc7HpD/czhs+XR@nongnu.org
X-Gm-Message-State: AOJu0YwaF4i3SGhsWRMEmFNEHUaLHdPbTnDjw75xc83MeUfOf8VTJKjw
 luwEkmlBqHQkrNMF35REhMm31QFGl7NXuThFskLeJ+3cLP0zfRUZy+DwIIni18Q=
X-Google-Smtp-Source: AGHT+IHZuf/pCVtp4BfnTk7EltV17OJSZyaduvu/nS2BrGN4o8YdNfCEQ8DIJJ/+vbBk87D8DJ8bzA==
X-Received: by 2002:a5d:5681:0:b0:374:c651:4abf with SMTP id
 ffacd0b85a97d-378c2d62070mr4281726f8f.52.1726258544020; 
 Fri, 13 Sep 2024 13:15:44 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800072sm20592f8f.76.2024.09.13.13.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 13:15:42 -0700 (PDT)
Message-ID: <c56f2b0b-3028-4b89-8289-e20519cdcdb7@linaro.org>
Date: Fri, 13 Sep 2024 22:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] tests/tcg: only read/write 64 bit words on 64 bit
 systems
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 devel@lists.libvirt.org, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
 <20240913172655.173873-12-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240913172655.173873-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/9/24 19:26, Alex Bennée wrote:
> While the compilers will generally happily synthesise a 64 bit value
> for you on 32 bit systems it doesn't exercise anything on QEMU. It
> also makes it hard to accurately compare the accesses to test_data
> when instrumenting.
> 
> Message-Id: <20240910140733.4007719-21-alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/multiarch/system/memory.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
> index 8f2371975d..680dd4800b 100644
> --- a/tests/tcg/multiarch/system/memory.c
> +++ b/tests/tcg/multiarch/system/memory.c
> @@ -163,6 +163,7 @@ static void init_test_data_u32(int offset)
>       ml_printf("done %d @ %p\n", i, ptr);
>   }
>   
> +#if __SIZEOF_POINTER__ == 8

 >= ? :)

>   static void init_test_data_u64(int offset)
>   {
>       uint8_t count = 0;
> @@ -187,6 +188,7 @@ static void init_test_data_u64(int offset)
>       }
>       ml_printf("done %d @ %p\n", i, ptr);
>   }
> +#endif
>   
>   static bool read_test_data_u16(int offset)
>   {
> @@ -254,6 +256,7 @@ static bool read_test_data_u32(int offset)
>       return true;
>   }
>   
> +#if __SIZEOF_POINTER__ == 8
>   static bool read_test_data_u64(int offset)
>   {
>       uint64_t word, *ptr = (uint64_t *)&test_data[offset];
> @@ -307,11 +310,16 @@ static bool read_test_data_u64(int offset)
>       ml_printf("done %d @ %p\n", i, ptr);
>       return true;
>   }
> +#endif
>   
>   /* Read the test data and verify at various offsets */
> -read_ufn read_ufns[] = { read_test_data_u16,
> -                         read_test_data_u32,
> -                         read_test_data_u64 };
> +read_ufn read_ufns[] = {
> +    read_test_data_u16,
> +    read_test_data_u32,
> +#if __SIZEOF_POINTER__ == 8
> +    read_test_data_u64
> +#endif
> +};
>   
>   bool do_unsigned_reads(int start_off)
>   {
> @@ -476,10 +484,14 @@ bool do_signed_reads(bool neg_first)
>       return ok;
>   }
>   
> -init_ufn init_ufns[] = { init_test_data_u8,
> -                         init_test_data_u16,
> -                         init_test_data_u32,
> -                         init_test_data_u64 };
> +init_ufn init_ufns[] = {
> +    init_test_data_u8,
> +    init_test_data_u16,
> +    init_test_data_u32,
> +#if __SIZEOF_POINTER__ == 8
> +    init_test_data_u64
> +#endif
> +};
>   
>   int main(void)
>   {



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCB4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KQU-0003DX-Bx; Fri, 25 Apr 2025 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KQR-00039W-Dr
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:53:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KQP-0007nx-31
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:53:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so22270435e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745592787; x=1746197587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dUNdomSLMAMAzzETVkOXhBvDhET6oTmnmbhrlDPxTkc=;
 b=fgvd5pBxYHg8Jl3fiRLumnOxokV5UvbeEthQUdzVRPoTghllNPJgV15leGU7OywQz/
 ECpWWALu+s3GEUfL0CIV+2brhBNbYmZvZqU2S8+qB/4wAOozOtXSuSKZyT7qRo8N+9r2
 LVOS7tw5b7mbmH8AQz1MWAfiHnF4Pwog6S9QEKj5ihIJ/4jtfL5y8lOrL+0LFZSGvpdU
 wAi7cSWLJCd2Tsj1G8lXspQFs71gWobEHclISoFMxOH6qn+O7oRPzLQEPslNBqPecZhK
 PzqvujW7yTJVeXWgCu21pvtS+F2yQeAiwxCrjwTncy82Yj2dVQzMYCuRlN03xCLq5C6U
 blWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745592787; x=1746197587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dUNdomSLMAMAzzETVkOXhBvDhET6oTmnmbhrlDPxTkc=;
 b=pj05WZDbO4nakLCubVaqNHmL7c8LNOpHChX76HuzD1OyB08MKHIYeZ6lMGe9fdhU02
 0Q+9k03PIkYuyvrB2eN/3qBqpjYSHjge6w8yszs72gE2fzxVz+rYpWMgUPx6H5+aod3Z
 NmlqtB4h+Q9RMuZvqIdsR4jBFsQn8pesvdmA1g0g9tYg+IXujQxOygTuSB3LccYG6kRU
 a5ISW+AxFExf0MS5o+mLywZI/ygC2isMgUNjjK5aUn16zyRDvBRyJYCZo5z6rD1R+TNL
 wT0Gl5p/d0gnmR9wdMv5GJhDQflRL3+Dp3B3ULqsNcC2fR+iMhBjPR5ria8L5HU/pVaL
 8z/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyYadRNCkOtkLGWgmmcU0sXv5tSUuFsTHjjUUon0ahzXw/HWUIx56lbh9AHtSIPZLoW4kX8cjysFAp@nongnu.org
X-Gm-Message-State: AOJu0YwMeqYSdaxeMhjoC22n6VlnR632Mx3PX2+tsBDJdza0V1iUBN+d
 Fr/1DdPYxiI/WSAH61msjT81x+BRQ8LEdK4VBEu1B8Cj2x19XRgQpzI5QE6VmruJKxdHdKtex3m
 H
X-Gm-Gg: ASbGncteyqk0D6VtCTnIc7eyrJlWMPSNi0vxmHov1uc5NhsOlE3A5+hIYrT11kgfoWF
 nwZ6OLV5gt55L4gVhqnBDSRPaRSHF6kRHCC/+MUZnkLAs/wJ5O7Kuk+eB5+quQjohjrnry1v23G
 uDM7XvPjk6fLztoXHz0xXVuQrUWTOJh72Pt7/vYKnZZ7RDye//qnGPVaSbrRiLx9t45Soy1LagC
 kGxoH/lL2vS947tuz2w0xENQlJpHjRZZ3YdbK/jQJPSatyETgwwVgodxIOiSwuAFQTEX53FVYKk
 U3iFjfYY/GavvOjW4Lmw9eWHjLkI1EIbxowhdxb+108RjfVBz9ZWiXbm758/kiu2R9MEJvpG/3b
 2FtDGyDyn
X-Google-Smtp-Source: AGHT+IFACxj+c2eF1ItU+T531+Ds66WdauIfs8lhn5+qYkE3vP3oZJahvoUyRmW2pxXeO8K7N7aPdg==
X-Received: by 2002:a05:600c:1547:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-440a65d8d6emr27324645e9.13.1745592787197; 
 Fri, 25 Apr 2025 07:53:07 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5303c15sm27051805e9.11.2025.04.25.07.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 07:53:06 -0700 (PDT)
Message-ID: <5b7afc3e-d5d3-4485-96ab-a1b212644607@linaro.org>
Date: Fri, 25 Apr 2025 16:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] target/arm/helper.c: Fix type conflict of GLib
 function pointers
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <01b21c849b459660453eb905d12ff0da4c65f53c.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <01b21c849b459660453eb905d12ff0da4c65f53c.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Kohei,

On 22/4/25 07:27, Kohei Tokunaga wrote:
> On Emscripten, function pointer casts can result in runtime failures due to
> strict function signature checks. This affects the use of g_list_sort and
> g_slist_sort, which internally perform function pointer casts that are not
> supported by Emscripten. To avoid these issues, g_list_sort_with_data and
> g_slist_sort_with_data should be used instead, as they do not rely on
> function pointer casting.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> V2:
> - Updated the commit message to explicitly explain that function pointer
>    casts are performed internally by GLib.
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index bb445e30cd..05793a6c97 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -220,7 +220,7 @@ static void count_cpreg(gpointer key, gpointer opaque)
>       }
>   }
>   
> -static gint cpreg_key_compare(gconstpointer a, gconstpointer b)
> +static gint cpreg_key_compare(gconstpointer a, gconstpointer b, void *d)

Why not use a gpointer for @d like in other patches?

>   {
>       uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
>       uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
> @@ -244,7 +244,7 @@ void init_cpreg_list(ARMCPU *cpu)
>       int arraylen;
>   
>       keys = g_hash_table_get_keys(cpu->cp_regs);
> -    keys = g_list_sort(keys, cpreg_key_compare);
> +    keys = g_list_sort_with_data(keys, cpreg_key_compare, NULL);
>   
>       cpu->cpreg_array_len = 0;
>   



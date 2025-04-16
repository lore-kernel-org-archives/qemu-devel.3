Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEAAC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4zBn-00076E-VD; Wed, 16 Apr 2025 05:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zBd-00073A-QB
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:36:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zBa-0004FY-Mk
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:36:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4805678f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744796161; x=1745400961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnxaTuzWKbmI0tBX7V/dU39soBvmDZfRJhecr7WdrQ0=;
 b=uE0qutcs6PHIibqwO6kTYdwBKwRS1b1S4ZaB4eagvf8CKvsPTfJ7hORlX/aRxXRJTr
 HBK8fUs/1Xc6gRSVxiaL70r2L5lnu9toc/iEH4LZgo3wiaY5cFeE/HHLY4/Cc/9vhJye
 3lm2x6FYF0xmCTdGANoU5btmleKrySoTW3i73l4/d5QUx/wP7vsGlPr+Cn0OzCUFhiQC
 sFWd4iSMjrU5lD8ytornulmQC3cuXrq/ItBfgBg1CUBbCVbiTkyDnZ0pekPj6JA1O1YU
 z5IQibO2XeZATdAs4ukhe6Je25joppg8FKSyYuBVP6FCy4xCvnRMlzaZH/+YrNCSHHhQ
 x/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744796161; x=1745400961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnxaTuzWKbmI0tBX7V/dU39soBvmDZfRJhecr7WdrQ0=;
 b=M9L6vVzdi6n7Z93AaSF40EK9PWDzKTaXeTitgUHeSdPIMnebBailZHy+IP8uvOWWAz
 5k6ZUqZQCtXdQczVmwxmANkh0y0I/XDSatIfs+p8p8fgYUpfr/Wq9nmtrJ8OHu+ryRCx
 TQw/y7ifJANhdhI3NuEhIWtet5IyRZ/HMROCuqe/4Z+BQCrUHxomLWDvxJAQWJB/VORI
 wtSa0FH5N0H3KF5vHT3b2wuROnPWcdqEUilLoL08E5g7F8zRzK+r5dpDEqYa4RMXlFRJ
 ZXdXRaYWl0+OShtCaWOQHreSNpN2m86G6LomJqlTgWhIBJgYlB4jLIoKwczkcWagKsOM
 0dHQ==
X-Gm-Message-State: AOJu0Yzl1xLYAi17we3SI/39ivDJrBm9mGhqDly4M+0vBVptg8YMX+WG
 kTPffEI/8qYqFzN0dca4H+nS1oo8sG73iPl5QKJk3tdlvXHWGn9ZuMEu0Pr86p4=
X-Gm-Gg: ASbGncsLGph4MjTao3vmYWII9w8Cp2yL3wm86uVzqGGXGa8f0UvA3sRjXTnlPcxe7rt
 JZlHHLt5k88NQ1QUBtwB1ty+nAk5oleRnf47O62ikpnWm8KrHOSiaJocPtRAVMG3j3jIUmaAQ0S
 w+wIeVnjovok+ii0WGC+wC5wIf096hb8A7c52CUCr++ipf/I7h+nEV8Pjo+77Zwm9Ok9OAIFcY1
 UGBadHEPPiVQ96FRpPn/rt5Gmvshtzwg+1d/z7rKHSTkDC+0Vz/ep8rBByMVXVvjmEMd+ZrE9TF
 4MDl/4MgkUYLXoEuf47pBNKuzo7BEe1SpM2oe53A2cxJ5kGhwoZEvq+JhOi7zJjKIdVYFNCCBps
 7cZUw7V+H7c/yyA==
X-Google-Smtp-Source: AGHT+IFhivAOHEHiFLZmy1rwnSXmnOTE6P6GAUFXOKhw/QY3L8LbSgNiBiKnqXUX58O1KMTWuzNArQ==
X-Received: by 2002:a05:6000:1867:b0:38d:dd52:1b5d with SMTP id
 ffacd0b85a97d-39ee5b1307amr1003288f8f.4.1744796160938; 
 Wed, 16 Apr 2025 02:36:00 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b5abc3fsm15676865e9.37.2025.04.16.02.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:36:00 -0700 (PDT)
Message-ID: <3b661309-904f-4670-b5c4-d537a4745c20@linaro.org>
Date: Wed, 16 Apr 2025 11:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] hw/core/loader.c: Fix type conflict of GLib
 function pointers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
 <Z_9qIQhjsI5zOwXA@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z_9qIQhjsI5zOwXA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 16/4/25 10:28, Daniel P. Berrangé wrote:
> On Wed, Apr 16, 2025 at 05:14:06PM +0900, Kohei Tokunaga wrote:
>> On emscripten, function pointer casts can cause function call failure.
>> This commit fixes the function definition to match to the type of the
>> function call using g_list_sort_with_data.
>>
>> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
>> ---
>>   hw/core/loader.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index 2e35f0aa90..93a8b45d28 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -1410,7 +1410,7 @@ typedef struct RomSec {
>>    * work, but this way saves a little work later by avoiding
>>    * dealing with "gaps" of 0 length.
>>    */
>> -static gint sort_secs(gconstpointer a, gconstpointer b)
>> +static gint sort_secs(gconstpointer a, gconstpointer b, gpointer d)
>>   {
>>       RomSec *ra = (RomSec *) a;
>>       RomSec *rb = (RomSec *) b;
>> @@ -1463,7 +1463,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
>>       /* sentinel */
>>       secs = add_romsec_to_list(secs, base + size, 1);
>>   
>> -    secs = g_list_sort(secs, sort_secs);
>> +    secs = g_list_sort_with_data(secs, sort_secs, NULL);
> 
> I don't see what the problem is with the original code.

IIUC the rationale is in patch #10 where Kohei poisons g_list_sort():

   On emscripten, function pointer casts can cause function call
   failure. g_list_sort and g_slist_sort performs this internally
   so can't be used on Emscripten. Instead, g_list_sort_with_data
   and g_slist_sort_with_data should be used.

> 
> The commit message says we have a bad function cast, but the original
> method decl is
> 
>    GList *g_list_sort(GList*list, GCompareFunc compare_func);
> 
> where the callback is
> 
>     typedef gint (*GCompareFunc)(gconstpointer a, gconstpointer b);
> 
> Our code complies with that GCompareFunc signature.
> 
> For comparison the new code uses:
> 
>    GList *g_list_sort_with_data(GList *list, GCompareDataFunc  compare_func, gpointer user_data);
> 
> where the callback is
> 
>    typedef gint (*GCompareDataFunc)(gconstpointer a, gconstpointer b, gpointer user_data);
> 
> which the new code complies with, but it is undesirable since we
> have no use for the data parameter.
> 
> With regards,
> Daniel



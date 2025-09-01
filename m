Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6755CA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut5ij-0005XL-NP; Mon, 01 Sep 2025 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut5ih-0005Pf-R9
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:41:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut5if-0006jn-GD
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:41:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b87bc67a4so11595165e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756737675; x=1757342475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9lTrA3YqOrd5Yin1WTNjJcmVSFDzRrD6u1UwFco2CuI=;
 b=Tr9SNjgFV1ZaC1d7V4kow1zsQlcdKuRVV8wdh1rcHQiQgXfKixzvmVFHtVi5452dOe
 LkJ5z+QPzvMe9qR34TqpEqyAe4pwaiG7kTpblYPOtpCW8q2AM06lzTrYUPY59K290VC4
 3E8PHQdJX/10pLmSwyVwC2P/upHbaocgsfgvu/q+g9/gBSatBR/ix24qK7oTR5HfXN/i
 0QsPRh+BnxCQy7Dhg0eREaTSc4QlYqSoCgdC72c12bamCtQBVeoOJ7qUH1CUFaR1nG+5
 zYY3huQjKj5dxx/NWkHgfJaS3Zpdh5b949V3FJ9Fop0vVwp+eQBTy5NRkQHRptCxmss6
 sE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756737675; x=1757342475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9lTrA3YqOrd5Yin1WTNjJcmVSFDzRrD6u1UwFco2CuI=;
 b=hp0Q/tNcHS9mHOMaf3Mnw542cuSw0TrrEA7V5TNa/DJeEVHUJSwaSizDK6zUFojbvv
 Ci5Af4PjebGy/JRNFfoMn07Z5ImfqiIPgzHfoF2RmTHI+sJnaqIz7cQy/M0gD3O6JoEU
 09fA0vjikO47bzQ/iwojJ1kbECE4+W6UaLdzGXYtoIIJGEXlUhZlA6t0maITP5/dj4hP
 A0WCFI+nAtL+IeI7KgF0qi/oJQhzNUMzOd7Wtc17DJcQMJwusOWEDGBMV++hGSFbl811
 3REBc8ywBXfxX1DJ2BvX3kJyxhhdfJLpG25G2dHUfsaz+/EK+75sTQQ347/B8tHNfKvO
 IPHQ==
X-Gm-Message-State: AOJu0Yw1bf5Cv9pCvoaBVRKo8BCBUT14xlMZp1sQ14vO33N0Cknx5RLe
 1yLq2snN1N+bh57+et0eAjiys91HAkb5ceuUjUGSQcqdmkcTftFA1qy5yvuQv8c4mGk=
X-Gm-Gg: ASbGncvB50YyDs9DFB9HKkVdpJmg4q1cjySNBgEsGfOLQJlz6EhmdiELo3tOnFnOK8o
 eZVq+JbmzdjbcAZBeAJRqFHl4dTrlbFhd7TCc3TwANrPaAWGGigBv0Xx3LX/LFour6r6BAWcIXu
 /yIWU6eHh7YFOH8zfIGzFYgUqIuxmKSTeRyDbpojP+zeY+4mZGNSq/RfWobpV6qcca89l/98vvk
 tp9PU3JdiiF0eaajf1JwS9Mq+lW3GgKbPxuaOv75efOv1pniy1EY2C6JywXpeTcr6dXQzbT+beF
 u5CBUYI5QJTMNEbHeozeymgOyOiby1kYLjL4h2ERN96u7NkUViPaAEuIPFdfv3+FWGQGmeU5rV9
 i8x2b0lLotfS4NaNf2ROmSO1y5WSWb5Ca98yHEfqzinMj+WxwMUvNXFwpfmfSNiF+8Q==
X-Google-Smtp-Source: AGHT+IFk67GFwME04fXeCsSivmJbor7dQb7ZzOmHJQVVsQfuoBd7PdMSWmXA3rJ/br9KB6hGX+FeBQ==
X-Received: by 2002:a05:6000:1ace:b0:3c4:497f:ecd0 with SMTP id
 ffacd0b85a97d-3d1de4ba70dmr5071604f8f.31.1756737674653; 
 Mon, 01 Sep 2025 07:41:14 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9db4sm15711822f8f.47.2025.09.01.07.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 07:41:14 -0700 (PDT)
Message-ID: <7fffe10a-05dc-4e6d-89fd-03d351aac06e@linaro.org>
Date: Mon, 1 Sep 2025 16:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs/devel/style: Mention alloca() family API is
 forbidden
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250901132626.28639-1-philmd@linaro.org>
 <20250901132626.28639-4-philmd@linaro.org>
 <CAAjaMXbDSwXjTFb5nPrK7tWyjbDtxm3mgxOwUK7yMUOG61y6qQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAjaMXbDSwXjTFb5nPrK7tWyjbDtxm3mgxOwUK7yMUOG61y6qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/9/25 16:05, Manos Pitsidianakis wrote:
> On Mon, Sep 1, 2025 at 4:27 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
>>   docs/devel/style.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
>> index d025933808e..941fe14bfd4 100644
>> --- a/docs/devel/style.rst
>> +++ b/docs/devel/style.rst
>> @@ -446,8 +446,8 @@ Low level memory management
>>   ===========================
>>
>>   Use of the ``malloc/free/realloc/calloc/valloc/memalign/posix_memalign``
>> -APIs is not allowed in the QEMU codebase. Instead of these routines,
>> -use the GLib memory allocation routines
>> +or ``alloca/g_alloca/g_newa/g_newa0`` APIs is not allowed in the QEMU codebase.
>> +Instead of these routines, use the GLib memory allocation routines
>>   ``g_malloc/g_malloc0/g_new/g_new0/g_realloc/g_free``
>>   or QEMU's ``qemu_memalign/qemu_blockalign/qemu_vfree`` APIs.
>>
>> --
> 
> If you wanna dust off your perl, you could also add this to checkpatch.pl :)

We expect contributors to test their patches before posting :P
(normally it shouldn't build due to -Walloca in the previous patch)

Thanks!



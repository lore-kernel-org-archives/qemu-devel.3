Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC788CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUAt-0003tv-2l; Mon, 25 Aug 2025 06:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUAq-0003tR-HK
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:11:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUAk-0003ps-8p
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:11:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b0c8867so34116635e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756116687; x=1756721487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bTcIz5ClpdY1o+uTHijMXwTjHRFH+qYjdYf6Hyq9ABE=;
 b=xxwbB1HNAo3AYq2fSxbkZUdvtrQdSQU80zpM2aHwFCqKFD6kiaYukAOxTTKPPYSUlQ
 sbOYETO7hwMPBFo1o7WMsIR8A92hlMgGiieZxB069hYy89w+RiW4glKr/Rq4AyoKs057
 KKqq24KvmCgZDKaNlFYadalOaoAqxy+6j5p1Ci87R0GCbPt65xUgP61SG/DsnHTgdzL8
 Ga6N6u4UUpq6krWUEPX0EWLcD4MVSrNAv5yUhzp+dCuiiV0zbC5tWhvl1Km65P1iff44
 tUtxs47tFZYB7YI3ziB18O/S7iYlLgPg1u9u9mFuC9ll57f6+BCSGo49mjLMCFAwGNoD
 bCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756116687; x=1756721487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bTcIz5ClpdY1o+uTHijMXwTjHRFH+qYjdYf6Hyq9ABE=;
 b=vWp8vcbxKht3y9+fVEsC/ONkVoM9iMzR4u6U+oFnjQ3IgNGJa4P96H1H7aARz4JkBV
 vFvctl/fFx6u3ZkZsUjcfm0YKPAJ4xCNalSsd0Prp4t9CcpoM1v7uM/lm8zJ/ykzLA84
 /lg1eFtRYGwpytdKTgmBXuP51dc+IkIcvXFGvfaSrnj5Ufgqj3buNeJOkIZre5jKDMTp
 tdit7AaLa/3d+H+0JoLeza+M60t6NvNhrwkSVKUJr/D4OTfpqkA8L7Nk8zjdjPmwUead
 flOZqg/Y9G+9bk0mIlSNO2gtylx0hLqkBC7QbWl3HjbbnMtm2zC7sKbN6JNPS2cnXKjp
 OAnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAwfsawNO/jPV/PtU6WludniyqJBM+eqEXawnTG3SgmNA/RysuN0iS87zzQ+p5aNFAdEUhC/zIUxYu@nongnu.org
X-Gm-Message-State: AOJu0Yx9FiSkcpEiWndRxaOYRGNeJcEDhdICxShYlGY40V4WVpd94P4v
 IP0AMtkqi8subqCttCOHn2n1CLUGq4Ttn4UUXiS5dVDWyaWDOJ/XludrnugC23Mrf9g=
X-Gm-Gg: ASbGncu4XDuxgn/BPHnLCNs0UYTLMc+PDBpcrNGvgNsJokroC0APp7/6fZ2OmwJTOSZ
 ZPM7n29VNiRxMNeUxGWucbRGIDMMtugfh+yjuvilv+1qCbmeAraXCWUPNsnjTG09YEWX2xUWmvl
 gc/fltn2oKSJaf9pkly8Il+G1n3P1Vk+k7ygKSP8Y9vdXyAVTYTS/q9AA+wvPKUFYs7+NaK0wI9
 pcJ3MdkRmcE3tiVuLbFTAPmuP+k2f41kxItkK/7NCHS7Ka5g+iaZuTS5dB5NMZ7N3wTu1PuuiTc
 jqLZCC00iPF11XbEvBf+BR0nRE5+bow+bJ4PWqEICVMPhRR897s9Oa6Urw99mbLHpHuloIwZSGI
 RFwqLEgJgP72NvHcIpxkbvU2lUyQLc/4KHDRxc1jAu9WFXq4eTOQxdyp/jKcYEPJNoIVG2bHaZr
 oz
X-Google-Smtp-Source: AGHT+IEU5wj3RWn3gX+XyCFtQEYLE5e30NDI27ADr1f2ucMdh2XkTVmi7b0padE83pVrp+Nk6/Fm1A==
X-Received: by 2002:a05:6000:2288:b0:3b7:8880:181a with SMTP id
 ffacd0b85a97d-3c5dac16ee7mr9589644f8f.13.1756116686652; 
 Mon, 25 Aug 2025 03:11:26 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm102617925e9.24.2025.08.25.03.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 03:11:25 -0700 (PDT)
Message-ID: <a879c454-626b-4194-80f2-229ad60ca971@linaro.org>
Date: Mon, 25 Aug 2025 12:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] target/microblaze: div: Rename and reorder
 function args
To: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@amd.com
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-3-edgar.iglesias@gmail.com>
 <80a82610-0423-4e25-a88a-14c4f7d95ed3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <80a82610-0423-4e25-a88a-14c4f7d95ed3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 25/8/25 01:32, Richard Henderson wrote:
> On 8/25/25 08:27, Edgar E. Iglesias wrote:
>> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>>
>> Rename and reorder function args to better match with spec
>> and pseudo code.
>>
>> No functional change.
>>
>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>> ---
>>   target/microblaze/op_helper.c | 18 +++++++++---------
>>   target/microblaze/translate.c | 12 ++----------
>>   2 files changed, 11 insertions(+), 19 deletions(-)
>>
>> diff --git a/target/microblaze/op_helper.c b/target/microblaze/ 
>> op_helper.c
>> index 470526ee92..092977b3e1 100644
>> --- a/target/microblaze/op_helper.c
>> +++ b/target/microblaze/op_helper.c
>> @@ -69,9 +69,9 @@ void helper_raise_exception(CPUMBState *env, 
>> uint32_t index)
>>       cpu_loop_exit(cs);
>>   }
>> -static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
>> +static bool check_divz(CPUMBState *env, uint32_t divisor, uintptr_t pc)
> 
> The name GETPC notwithstanding, I don't think ra -> pc is a good rename.
> 
> PC often gets confused about whether that's a host or guest value.
> RA (return address) is less so; it gets used often in core tcg.
> 
> If you really don't like RA, then perhaps "retaddr" (also with quite a 
> bit of usage) or "unwind_pc" (no existing usage, but very descriptive).

+1 for 'unwind_pc'.

While thinking more about it, I noticed we don't document the
prototypes in "exec/cpu-common.h". Doing so we could rename
s/pc/unwind_pc/ and document @unwind_pc. Also these helpers
would be better declared in a TCG specific header. Anyway,
note for Richard, orthogonal to this patch ;)



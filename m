Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B512E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQw3z-0004KR-8E; Thu, 26 Dec 2024 17:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQw3y-0004KG-0h
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:10:38 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQw3v-0001DX-IU
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:10:37 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so8371086a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735251034; x=1735855834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UMIV0DsPZUmifgLKouY7ymHAfyf89W0vvVt0rtbhUp4=;
 b=fqWg7x2ZWCuoBfkT/lYTyxp9oWS53yYvsp6QpWo8fl2jm8lj0vuZCbGrL+ENXcMYrv
 dxYI1n/FscZlJsE5DX1k30uI/RW9HrWH4KaxRCRG8si4ZsSnu6Hey5OPbKRmcLwYkAoU
 kUQjhgWfLgpEzmFx5Hvgc3pVdobIjdea3k53319NJpH++s2u6Du6BS4/homobK9si0b8
 QkzNbyKtiIcq1zd4xHPmK8QV1IghM0wdP0D+ZwS8Va0xf2VjMidOZFGNqIdXV1ECtchb
 5uxxKnywPeSpgf9Ot23Qh+QBtqaMdBkbaRO8LhuyJh+Qd1fOANKUdNAx3Bi/eZzlymlT
 1FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735251034; x=1735855834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMIV0DsPZUmifgLKouY7ymHAfyf89W0vvVt0rtbhUp4=;
 b=S5mVFeADjV7i7MMsEcdwAK/iVA6oAQbYEJnkByi2AhDKBkNhytqf5Bn1wjPpsCe0wC
 z01qWo4FLk3XN8bxzb5EU9Ljxp7S4C92vCpzC8b6NcRplJGAHGzzJcaJpBz9aPO8qzEn
 kdM4l6tDLXUAx6Q9zD02EHqGKi/xpQ5KmJ5yKbXgRqapO3jKVXn0zxHvVtlxg/WKh0m7
 huR92KelGrDVuGhqSNTr1cpeg7R6rTFQaEwkM/fRAaLohdcJXMiCas6xYw+a+2Z++lVU
 +D6RMTsovUEMi+qPiYFSakDL9MQLUMTpFWuO019m92OACTBqjilS5JyqcPW1s37vRcp/
 9aTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/ek1/KvhxsrfbAGhnbksVyVLGVhzRwbkh9zU8KejRvMzXA3kuLlv8P24sCZWWt3ibX7pPtqKCsEig@nongnu.org
X-Gm-Message-State: AOJu0Yw3vgGgXmeNsOv2aCoiQqtscJCRjmCXSQ36w+ZhDV0Xaoee/Sqr
 IqMVk9/eOSetWh8srngUcC6enSq8y21h8qe+A5qDwI5plhT9rGj6XIz3NXPW+uQ=
X-Gm-Gg: ASbGncvlo1WFytNdfsEMm5gRa/2Ys8FfGVYVBFI7/JVkWsSEoxC1ZLXf4F2TVJauwGb
 88PSGz3rOhQaRND6cPvCx1PPs4CEQRwTPNzcJDn1Bc4vOCICYwO1uY8PtG1/aAUxB/2fIwkPVW2
 NfRnHibqGLuGSLrF2F6Kl0ce0+3hX2lhqQDcqprqE34c1YaIWQHLIqEzkUanoEbTNrpeVTxTIWD
 WrKtwg2jOev3fYrb0PWwTUh9D4Np3sxYPsYD7Y9rjlV/q62ZiEMrjU27/vA0sKoxH1qypoi24Qn
 gFuMKPNMfYyXElBzLIFsTj9dMNae34aJHZbSo6k=
X-Google-Smtp-Source: AGHT+IG/dJUpVfiK/VmAaNfq+FOQw4opTrCn6DfkPWYfavL2VIjKpsVKQ4cJawewCwgtbOvie2ZnZA==
X-Received: by 2002:a17:90a:d88c:b0:2ee:cddd:2454 with SMTP id
 98e67ed59e1d1-2f452e1cb4bmr38948868a91.15.1735251033897; 
 Thu, 26 Dec 2024 14:10:33 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed52cf9esm17946921a91.8.2024.12.26.14.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:10:33 -0800 (PST)
Message-ID: <4f46c4f3-5230-49c1-b50d-fe9f6889ac15@linaro.org>
Date: Thu, 26 Dec 2024 14:10:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/23] target/loongarch: Scrutinise TCG bitops
 translation for 32 bit build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-12-0414594f8cb5@flygoat.com>
 <f2360c0b-979a-4473-a7b1-96caa54cff27@linaro.org>
 <192abfba-5b21-4223-94a6-673155949662@app.fastmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <192abfba-5b21-4223-94a6-673155949662@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 12/26/24 14:08, Jiaxun Yang wrote:
> 
> 
> 在2024年12月26日十二月 下午9:55，Richard Henderson写道：
> [...]
>> While this allows the code to compile, (1) the functions are unused and
>> (2) they do not
>> compute the required results.  For me, the latter is concerning.
>>
>> I'd suggest moving GEN_FALSE_TRANS out of trans_privileged.c.inc, then
>>
>> #ifdef TARGET_LOONGARCH64
>> // all gen_foo_d
>> TRANS(bytepick_d, 64, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_d)
>> // etc
>> #else
>> GEN_FALSE_TRANS(bytepick_d)
>> // etc
>> #endif
> 
> Thanks for the insight!
> 
> I'm actually thinking about introducing an TRANS64 which resolves to
> GEN_FALSE_TRANS if not on TARGET_LOONGARCH64.

That works too!


r~


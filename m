Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15F1C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgG1-00087j-2Y; Mon, 10 Mar 2025 12:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trgFf-00081l-6x
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:45:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trgFd-0004sW-BP
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:45:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22403cbb47fso85244065ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741625111; x=1742229911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XW82PyhdigA7ILuOWEUx7l4UHVxiWI5g34o7zDetreU=;
 b=EX4+03nGAyEEtmw/383Z6MnAIrpvHapfq+jRyHS+7QjM8X4nynYNdidXytEw8zgKSV
 Vt+kW12r3biM3PNztvmVSUcFgIFnThl2dlJjpxZX3Cn4X+DUcZe8gMTyC1A3M0gFHu/o
 +d6k8uiYB3Rc9FqW9acvg+YEsRSlE4LqI6IQr7KyyuftaVo4GF9LMHacZn2J+3rdax4B
 6yalT3A3f4MObqLz/ZxydMxkVWZfK7qPi0Gr1P4ZYZzxx8h7Z3kLenTB/arbP4Vo/JLX
 pyFlYnB1+CO6WpmONsHfsHrYmNAZ91tGtxfJGBH0ec0SyMQYt+CRuPr0dBfbtHbACkmM
 MnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741625111; x=1742229911;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XW82PyhdigA7ILuOWEUx7l4UHVxiWI5g34o7zDetreU=;
 b=KfOg56QMBKqnd7GLkH2swmm3bBGo9IN2qjqigTYBp10wmL8/q5lRtk2dyrklvltcFj
 UC7amusJc7gtB/V52TlDr4DhAV9PxFzGSypt6eRpc65TNp5Sh2F8w2OIQL/HskqJRhIw
 xEHY7T4Sx6IuiGfCQjaT/yWoLUBAqW50hWAyvMvOrNXq/eS5lCRP0yooH2nh3Biq0oVc
 kQCK8nSMfv6arblTqszucOwUB1KUUm7489a9w8JqE95gXnL1geyIGb8CGufUDP+i1ADX
 m1B3mA9H0SdkkbngdhZ56xsT4K2ISUczSKfVL9c8i9fNFJSXsSHQ1zUC0kWPThbSjijv
 TjQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr7V2D0FBzjrlpTSU/LJ5a1bLv7OUp361kI6A4xvAwpTrcIrlLPygRfAGrU0XlbK1f+Cj2gXZAvQ2V@nongnu.org
X-Gm-Message-State: AOJu0Yz+NRDVZ1L2RO5qriaJIa7H3D4GE0RFf+gdHkuZWzlvNft3TJT4
 TmEKzv2fdzv0iV1BCI95+Hxjrd7ypozIqFOFraPDWK8bMThtw0FKoAnlZUolCcQ=
X-Gm-Gg: ASbGncuoIVOCYfHysVZHhpeOp4uIP7LGiZ5KKkwyAZMfGQL3ETWW5b3edOQFFRzxVZh
 CeNn42b95xqlF2u8XESa5j3k+qa2rKNCO13f2zJDyAW5PldVnwQHn1tAV5+CwvDzQmRXCHdkJkt
 CakbW9tqbBjPxJ05sf8dhJn6IE07+CLa41IZCOy7RKEATcpcgF4WqNmuW1mbpDRidbQpVyJsTnl
 JoXEKVLk7DFOJVbPxW0leG0Ub0EtXf2nvcePX2FW5ZYZWa6WBg5GStHwz1SLhQRZnWk+9BgV88K
 EowaUukths7n8SHQp6qYjyQQRYG9wXGDRe56n9HUdusvIAMK0ICDebXBvTAoXq47Nv2g
X-Google-Smtp-Source: AGHT+IGUdX630rcUfpvwJVHOpWcVv3RlsM5PZSyzr9h7ZA34lGNU+crCGRyuv4ZUDZkLhDMbLGfoxg==
X-Received: by 2002:a17:902:e5d2:b0:224:23ab:b88b with SMTP id
 d9443c01a7336-2242887ecc6mr199933745ad.8.1741625111539; 
 Mon, 10 Mar 2025 09:45:11 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e8532sm80578735ad.56.2025.03.10.09.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:45:11 -0700 (PDT)
Message-ID: <800ac117-20da-40bf-9d00-96432e692ba9@linaro.org>
Date: Mon, 10 Mar 2025 09:45:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] exec/cpu-all.h: we can now remove ld/st macros
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-7-pierrick.bouvier@linaro.org>
 <1ee6764c-5b44-4cd4-8cd9-b0aaaf31f0fb@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1ee6764c-5b44-4cd4-8cd9-b0aaaf31f0fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/10/25 09:39, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> Functions declared in bswap.h will be used instead.
>>
>> At this point, we finished to extract memory API from cpu-all.h, and it
>> can be called from any common or target dependent code.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/cpu-all.h | 25 -------------------------
>>    1 file changed, 25 deletions(-)
> 
> I think this should be squashed with the previous patch.
> 

No specific opinion here.
I'm ok with it, just thought it was more easy to split this, considering 
previous state compiles cleanly as well.

> 
> r~



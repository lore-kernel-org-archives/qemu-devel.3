Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36940CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1X0A-0003eL-3E; Wed, 24 Sep 2025 17:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1X07-0003dx-OC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:26:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Wzz-0006hn-EJ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:26:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-26e68904f0eso3479965ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758749159; x=1759353959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x1OEoNUQljVf/MrsVaQKnTnhbs2FNKF/KpQR23lYfjE=;
 b=V7h0TD56wkFnV/9BaIyk6KZRAS+Ge0frM0XxXMa2SuX6Ux2HjC2BVUFxzTQhd8lCpn
 czgUhdg55TzKzEXdzXaQGmOyCZuZQWTp3lHRR5I8YhTxG9qEDdFbitxzcKHoT5rDKltP
 k4f8hkLnEXhx5bysNKwCy/Nuy8O+d1to8k02HXWD3J+WF9SOt849rR4TXpBObHdva1+1
 qu6MXu9fp/YN4boVHFDbaI8y10N2Hvn+szhdeK1JaOd/t1jt6Mz4kjV0uLlDuXuBf28E
 u+kuOE3r+GAzKg9dTn8/HVENdG/KT9o1eJf0yoEgpzKxrw/jD34HWs/eEYcjCrwTjM3T
 cbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758749159; x=1759353959;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1OEoNUQljVf/MrsVaQKnTnhbs2FNKF/KpQR23lYfjE=;
 b=Ll2687j0q8nicMbFUk7wAi7txi6bYGOvBauRuapph/9TGNHI0C7uyK7BnA0vBPpSfF
 rcajEvxbrz2aa1Om+4wZKJWKBgkynV028fFjAn7Wtb7/xln9csZEZhuvgd7ruGWV4aeE
 OMUhq7WEVp3L73vk3q1WG/WT3dWAK47zpE+hEaF3fQGmLq5wvBYGybU7k8HYm2cnr8tx
 qA6mWV27hVSoF47dmJ/DWMqsQV0e3polHB9Lp35OKLKZ2LKcV60x2n/Kl5vmyBJGIwQ7
 5Xjal4mxQRQBkwlj8B2TXiBpOlJhVIYCPXWhh3rXbMqwKBV4S+Wn3TaLUKplA4n65IGF
 eldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXujeXT9etU/jORn9fdJxshr9RSg07p2hpR1fVeNWXvdgG33yVSoaovn9nnrHBrHHc60Fy003yzLvKD@nongnu.org
X-Gm-Message-State: AOJu0YxvvWH10Oe85Ysa7MzSoPpo6zFXxOaMGpiWoIZU4enbWkNX6uG0
 k/+oY6qr6zQ4DBHOWfxMNHRLTo/rBL64wrvVyv6KduuhiUfFBD7oPxnNgWiU5Qrubns=
X-Gm-Gg: ASbGnctUVeKpAL9pmf1B4hmj4Ea31xv0QJe5kAIjg4RQvirvioWI/Ogla7XgGxDbMYL
 6sEjdpLIYvt6SIQ7CsIt4HBhrGJWi5VYzN0Y3+Dy0aZCy9OtFpl6b6zmkCzVUoBmvDbduCImlJp
 S20e0zH8hs1l+7g22ShK4TeNxGiEjcEgKbQrpg0R9x86pgOsnZ04REWRQqbNADkrZshBs3KehxG
 NRVgVgZ11GJAffbKfeIprtRoFLw6itoiCepBtHxBxWtNSpFNFntGslbFFRpN7L2UmLMZt+n54xe
 12pUlOLecQ3gLpfW6X1IPxAviOjL3qafQrv95ClSOVJ40EcLUj99icGpmSWhgCvwjyASmMRgc22
 Lj2DtozIHMYaQfAkQAtj2aG8VIsTUKa8qQC3hCrYIl4ZbaVQ=
X-Google-Smtp-Source: AGHT+IHbFDrOjWIQ37gGklCImnnJl61Qvgk5wFMt0y9cANpu5GBKWLIWcsHD3ZxHnsWgyitmjyOTZA==
X-Received: by 2002:a17:902:f70b:b0:268:5892:6a2e with SMTP id
 d9443c01a7336-27ed4abbd05mr12114545ad.56.1758749159570; 
 Wed, 24 Sep 2025 14:25:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6882232sm2119215ad.92.2025.09.24.14.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 14:25:59 -0700 (PDT)
Message-ID: <667f6af8-cb22-4cc5-bf07-83efff3f870e@linaro.org>
Date: Wed, 24 Sep 2025 14:25:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/sparc: Relax some decode for v7/v8
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
 <9ef5c891-c31f-476d-b297-ff4262d3b53f@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9ef5c891-c31f-476d-b297-ff4262d3b53f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/24/25 13:25, Michael Tokarev wrote:
> On 05.09.2025 14:51, Richard Henderson wrote:
>> Hi Mark,
>>
>> I noticed a few other places where we probably want to
>> allow unused bits to be set and ignored for pre-v9.
>>
>> Changes for v2:
>>    - Use TRANS() in the STBAR and RDY patches.
>>    - Apply the same relaxation for RDPSR, RDWIM, RDTBR.
>>    - Do not report illegal_instruction when unused bits
>>      are set in the rs2_or_imm field.
>>
>> r~
>>
>>
>> Supercedes: 20250905051936.92815-1-richard.henderson@linaro.org
>>
>> Richard Henderson (7):
>>    target/sparc: Allow TRANS macro with no extra arguments
>>    target/sparc: Loosen decode of STBAR for v8
>>    target/sparc: Loosen decode of RDY for v7
>>    target/sparc: Loosen decode of RDPSR for v7
>>    target/sparc: Loosen decode of RDWIM for v7
>>    target/sparc: Loosen decode of RDTBR for v7
>>    target/sparc: Relax decode of rs2_or_imm for v7
> 
> This might also be good candidate for stable series (10.0 and 10.1
> at least).  Dunno if it is worth the effort though, but the effort
> is minimal so why not.

Yes, since it's easy.  Especially the second patch is needed for Solaris 8.


r~


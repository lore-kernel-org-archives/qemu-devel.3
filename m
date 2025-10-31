Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281D3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 20:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwBI-00058f-QS; Fri, 31 Oct 2025 16:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwBH-00058X-Ep
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:57:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwB9-00077q-3g
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:57:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso2446418f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761944215; x=1762549015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xAbhWGDuNaDxK/d7psHR87cn5bkY8T/raEhekWgcuSQ=;
 b=D7NZ3BsGlSacCenNJenKoSqmEHNopAcr3ApjWVXKUu7VTJuFN9wBHy6E5Csc1U3KX3
 4HawCXVLSzBEMdp9Q8amuiMwl3tcmM5Xei7+yik4yf0CylslCE3tUOH6cZoUKJT1Vbqn
 oWq9Z2IsnTGwFnzSC667rqSPuD4jUBQeboH9lOL25Jv5YeI0R6hG1aP5roJJGeZ8y1XQ
 SNjcJgYv58LTZYPE+neNYZJvStlzw9oVg8njgg3rrXqaPuFD3c71GRhQqNpytLD3wxPS
 iV4qd40dEDKM7Kn9S5cts1AmKZTmGbauJvztkJiQ1AkArggc7EitJpXF35izSSmoRsDN
 10/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761944215; x=1762549015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xAbhWGDuNaDxK/d7psHR87cn5bkY8T/raEhekWgcuSQ=;
 b=chyc8aFSNo3PM+iTHzOQGVteLSZlVjwbXphSJikmiN3288uZREcJVBo44veecVOJu3
 i+nG3n7KYAPflg+BP1uJw8NG0zPkqdTwHoXl4pd5LZpzT4C8/v74MXqBnR9rqn0hA2sj
 g2HMQXHyL8N2K2biKeUFDLykcDRr9stP1elSesbsEVQZCdCxN8trVLUfIn9Q/mxnesUB
 pSHqzpDiU9Djm4IoJNoHJw9I4AdNcuXIASmNVEVIxE8ST46DfazQycuO2BgWoCh+dEOB
 cpXeta2FKMzF2wP0LC/aAAZevvBj9y0XD5sFCv329fGk+97uvhVVF79SOkPQHXXCxo1v
 e1Bg==
X-Gm-Message-State: AOJu0Yxam0JICs5BU2RKAAFB8jfJKyoY44jZ6wWTGxD+GCu8n17JLSa/
 w6CkJg/LkFjLH+9Au8Cbz/AnQgZW0zm29x4HV/9sjUKExSQGztXEF5OXT3LwVsvATRE=
X-Gm-Gg: ASbGnctoun2JDWRsyZ3Qpii9VWxTLsk1Z6flpdr+9EWKlVdGQ2hfU+Fw7+IXmu/gKWr
 ZcCIROMjSvZuLL0v7reO8JvDfKuq1BGzVZ+IK3/6UbXGxr+c+GAvxTsDsK18ExEMIElBysRt3oe
 G1mKHDVL46j2AYOQ5WOiTl8VfLdVA5wo6Q/JspgTg0uAwwXKY5hq8B+kbUEmKxhVFl4vTL/PE08
 Iilx7tAL1hOJQ34a6yD32KG8QP/wI7euWvuaPQ6hLK4sQ46ex/1fdfQPrToYMto5psohfNqPJo+
 tqZ6OoWZJLwMBYQ9kRKioHwWiKwg8mIDOTU4ODGgJyz6SlJlnmJaZ5xRsvFU2CJIubpu1D8Kzb+
 uP8x3ImkSP+HFGQUIRuPabXryrXGPbwLMoGdVNDB5Ht9NsS/ylV3S/qM1Blc7G/SNHN+72KQI/j
 y7meyT/GqCZ7be0Svvnb+EQpaaLBh9eOrXbpajftXaFLFjmiV0wd+U9ji5viu1ZUGU5Q==
X-Google-Smtp-Source: AGHT+IFgKV3H24X+ziKMahgoYJhfflOqecdkx5JEQ350mpACkLpWdgkRc4zSOXemYLVbRU3bT3TXpg==
X-Received: by 2002:a5d:5f50:0:b0:426:f10c:c512 with SMTP id
 ffacd0b85a97d-429bd6a8facmr4671227f8f.43.1761944215136; 
 Fri, 31 Oct 2025 13:56:55 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c54efcbasm1926117f8f.8.2025.10.31.13.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 13:56:54 -0700 (PDT)
Message-ID: <184b9a9f-cfc2-4595-87c4-92e7c2c789e8@linaro.org>
Date: Fri, 31 Oct 2025 21:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031190246.257153-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 31/10/25 20:02, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. qemu_hexdump() wrongly indents ASCII part of the output for
> the list line, it it's not bound to 16-bytes boundary. Let's fix.
> 
> v2: add test
> 
> Vladimir Sementsov-Ogievskiy (2):
>    util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
>    tests/unit: add unit test for qemu_hexdump()

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



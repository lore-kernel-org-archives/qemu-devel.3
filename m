Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA055C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 17:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEALf-0006Qh-R7; Sun, 11 May 2025 13:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEALe-0006QK-6d
 for qemu-devel@nongnu.org; Sun, 11 May 2025 13:20:22 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEALb-0006BN-Ro
 for qemu-devel@nongnu.org; Sun, 11 May 2025 13:20:21 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so2866109a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746984017; x=1747588817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TFhUNIb35hTVnlM4jkZ7y1pSgMonXQDhP/FRTte5SlM=;
 b=JVwaijYe0fIaHttQSILeQ2SDjlux2vqlz910vU2ei6/ooDg+ejYrmw+oSR2ztxpK7L
 iBYGbc1AJkwte78Xp21WUk+w5EVAFwdFC3cwYN/fw5BqozRU3wXzH38WaH8uWQrpgSWa
 cneZ9AWd7XElfhT/suovMdRBtMLkte/ry3KONkKpvZi8WHxM3QHyEAtqxxTZ5iDKEMKe
 Q7x7dYT2whbv8oGhBaZlDhuRn8KgUHdXHa/dKXGuPopsXgrvMlf+Vk5YIkxaxDnpav75
 w5uqG+fM0rseoSsVSxnU251RkSExbx1m8mt0dYA7b3xpbo23eF8lyLIf8aZGHMwoIv0Q
 wXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746984017; x=1747588817;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TFhUNIb35hTVnlM4jkZ7y1pSgMonXQDhP/FRTte5SlM=;
 b=VoKssuDkwwb64m507ulGWwObPpatngOy7yMwwujn9PR8dc82tx0YhRyS2hbT2i1zrh
 Msa+nVSiVZ+rc4xeHJ6AeU97lBs4Ev8wR7lTJo0MvGm//BnQQrJKhWdnjB9jhfRBzbwy
 3PSXejff6x75VyCqxwzojeyiTcX0LGsT5BlyQrQ8hZyQi6tr01AQKXNHuJAga1JB2NMB
 MUDF6iW4kzKBN0S80wEUcRgit/2lBLvYLhX7f7ghCzKmQfoDcUbjJwwac5JwJLoVAZpY
 oBSQsdaMEbhOhpDCFQoRkueyr4cQjH6/nCHEsjvn44+r5efG2tS05xZ6fh+jmmiFiZOy
 dBrw==
X-Gm-Message-State: AOJu0YxeY6VgyV1zDMH3NX+UXqFqy1xY0qiqgaaIbCsUlI0ydMDhBJHF
 KLSiOUjfKHsQ2efFrzMKLqLJWQriGDdQqXX+1TpKluOh+rMyoWskl4I261ZrUVg=
X-Gm-Gg: ASbGncvTnISuyoJ+QmrokM6JN+VNZFVe+rl0XM7SdxaLsLXtdVbvZ5eogT3JWYbouAK
 px+YygQwpiIp3VjQZsGdjrbVssS4jIaINx9IaprcZZIhpsAseIgAcDdge326M5NWGcgVQfaleON
 Uuz0YIds/g4ItnGrg3qDmTsKE8JpT+j2VCiTQRuDGcWtwQGjKHiE47zIPS1sKDQKWp6+MTjL2NJ
 iGoPUt3IHSg7DDbdWQJwfX/ULo2US4BdpWQw8BSxBSHEHiZ14fXSosSuZ9CofH5cCoz2AtSfPEV
 FUkKWCjSLbHDutmOLNK0eSVbwunLL1TVyk3thqsFTCf/wt/0rfp4Ip16WUCwu9vB4Z4qFIIAPkB
 tPihUl5KzXiShd72Cws+v3NhdycSb
X-Google-Smtp-Source: AGHT+IEB2kAj+HAYkguNrRkRUCIsqQoqc3OCOkJjEDruN+KClQXfh+9CsDbrJm6nkb8PWHvUMm8esw==
X-Received: by 2002:a17:903:1904:b0:22e:4d64:821f with SMTP id
 d9443c01a7336-22fc8b56982mr115144645ad.20.1746984016998; 
 Sun, 11 May 2025 10:20:16 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc8298a40sm48514395ad.200.2025.05.11.10.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 May 2025 10:20:16 -0700 (PDT)
Message-ID: <6ee4b563-6fce-4f34-b58b-f0e400a631db@linaro.org>
Date: Sun, 11 May 2025 10:20:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/24] target/m68k: Implement packed decimal real loads
 and stores
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20250507211300.9735-1-richard.henderson@linaro.org>
 <20250507211300.9735-22-richard.henderson@linaro.org>
 <875xi8zalx.fsf@igel.home>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <875xi8zalx.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 5/10/25 09:36, Andreas Schwab wrote:
> On Mai 07 2025, Richard Henderson wrote:
> 
>> +    /* Convert the 3 digit decimal exponent to binary. */
>> +    exp = ((hi >> 24) & 0xf)
>> +        + ((hi >> 20) & 0xf) * 10
>> +        + ((hi >> 16) & 0xf) * 100;
> 
> This is backwards.  An exponent of 123 is stored as 0x01230000, not
> 0x03210000.
> 
>> +    for (int i = 24; exp10; i -= 4, exp10 /= 10) {
>> +        res_hi |= (exp10 % 10) << i;
> 
> Again, this is backwards.  Also, the decimal exponent of an extended
> precision number can be as big as 4951.  From the fpsp040:
> 
> | A15. Convert the exponent to bcd.
> |      As in A14 above, the exp is converted to bcd and the
> |      digits are stored in the final string.
> |
> |      Digits are stored in L_SCR1(a6) on return from BINDEC as:
> |
> |	 32               16 15                0
> |	-----------------------------------------
> |	|  0 | e3 | e2 | e1 | e4 |  X |  X |  X |
> |	-----------------------------------------
> 
> That is, the fourth digit of the exponent is stored in the upper 4 bits
> of the padding (OPERR is set if e4 is non-zero).
> 

Well that's annoying.  There's a mis-print in the m68000pm/ad manual, where it says

   SE SM YY E0 E1 E0 E3 x x D16

I didn't notice E0 listed twice and so thought "0 1 2 3" was the order.

Will fix.


r~


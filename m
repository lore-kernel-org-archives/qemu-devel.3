Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA8F10F92E6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7dKH-0002Nq-RT; Tue, 31 Mar 2026 13:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dKC-0002KI-6S
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:56:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dKA-0001hw-IH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:56:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so2061065f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774979779; x=1775584579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gr2lIIqRlJHu165UF73aSFemXfmSDNRnZalK7wBdGvk=;
 b=CfcdA1DTBDE2rQAn+RsxKb0iXSojelilNP0c17qIJkg055JiROV6OGqZB+ZgQwKefG
 ZQNcOcnkFN/eKTPs0+Y1AdIePBnws4OuEEObw1HHvGmUVP0oP+7IjE35VwzNsthE3kEX
 SGNGP2rREMndbp3ivF1RPvvwA4tt62Xagot9bTD72pTg1vBgF5gN1WcVrajJWc/RvlTR
 4/qIR8T8fKYx1UGGdbrOeOLst++XhVmJ4U5SSu/Wjb+NnOWhDfNLUZG5kkYSx9zPQQms
 y+3h3sf02XXHlVNsWmSeO2NsDfoJ4lDyxw+q5ZEby0/cLrN9D7blCyt7a07OohsakU7d
 dSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774979779; x=1775584579;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gr2lIIqRlJHu165UF73aSFemXfmSDNRnZalK7wBdGvk=;
 b=amw2cZdd2TvGqRDlNXXdUqhpBQHzPriBxc1q4+An5Dx2Vapm4UmXEiQ4+fmNa+yjqx
 ZLT/Z9RfmMqWKQYGpIhej+PfN0wCeMvDNOzrRjdfnDfvv1lqfjZ3m+9lUvQkhEAXWLNw
 jAkQXg9MYBUrJrKtM2W+sNN7rFX0KPfVRNnLNnboFgH3vsMf/FZB0FMnnGcwlJnNQtgw
 EbvVteU5fBtTFPcsBEa3omVu1YRzgkrvmwQKN/oZQTGqsjrcd8iLy6OYnbRkQ2UUG6HU
 XAUkchk1y3O2XihFQcb6WGNYcMdKPGcub7T5f+cGGMGesjwDuJOY6k/YIJq0oYqb9An1
 oRgg==
X-Gm-Message-State: AOJu0YzUeWz+ETFs+7cyuCah4nPTr/LNtgIVVWnERcOIWrRU556eI+uO
 yZT/wQqqkBDYSc2uckAwmJKQwHopOkvlNLfJKdrgf+FNPu1yxapfReqsHO7nBcyWjbU=
X-Gm-Gg: ATEYQzzazlSLix26ILz0xS4wxrXLHZ/mCo4C7H/w6Mo9aftKgE/h0WzgbCCC0v9UcDu
 /jCZZVmU2tMknZufMhTU4+1Mwr58nbFRHSbfsgNfaezRCJ8EXAYinJWydV9rxOLfN+KrEM5z24p
 J1MhIyhOgNMrXFjmW/aaoAb+QLtRd6koZYV5WiflReQy2X9yYesvfxJN38Evdn3EhpL9wec4urh
 kMNqIXn17gYBvH7GpKfbDiz3G69Cg6dIhCCo3p3JyNQv6YHF4ye2EKQawOiJ9pCuDxTaAcoXh4Q
 K1xxyLOaWWGh8lHdIMIGhEVqbqWSb6YyUw6F1mplCMwJ+b+iVpMhoNKDod4z1ftYOyi0fR5BlB9
 a1hmOuhlQ50x0o1yZlr4qItTBYICV9CXU49F5+0ofJE1StGBpx/NxMNom1AC/kxL5JnUCb/XuyB
 JuzcJEC9K27lyrMLgnHdXCZXoqb1clTtMRlFgn9bk7+SHNhEbRik5AUsRfrxpHAQjdFg==
X-Received: by 2002:a05:600c:c10d:b0:486:fab9:a578 with SMTP id
 5b1f17b1804b1-48883575c11mr4415675e9.11.1774979778796; 
 Tue, 31 Mar 2026 10:56:18 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e93c014sm60975925e9.10.2026.03.31.10.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 10:56:18 -0700 (PDT)
Message-ID: <182de182-bb2c-48f0-8a0e-4a8e4f651acb@linaro.org>
Date: Tue, 31 Mar 2026 19:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ati-vga Coverity fixes
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1774904832.git.balaton@eik.bme.hu>
 <1122d60a-c7f9-466d-ab2b-c7bac6c66245@linaro.org>
 <58689216-a72e-de88-de61-cca626e1bde9@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <58689216-a72e-de88-de61-cca626e1bde9@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/3/26 15:45, BALATON Zoltan wrote:
> On Tue, 31 Mar 2026, Philippe Mathieu-Daudé wrote:
>> On 30/3/26 23:09, BALATON Zoltan wrote:
>>> Small patches to address Coverity warnings.
>>>
>>> BALATON Zoltan (2):
>>>    ati-vga: Silence warning about operator precedence
>>>    ati-vga: Add upper limit to x-linear-aper-size property
>>
>> Queued via hw-misc tree, thanks.
> 
> Thanks. Could somebody review the cirrus-vga patch too so it could be 
> picked up?

I skipped them because Gerd left a comment.



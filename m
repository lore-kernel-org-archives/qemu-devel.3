Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD91D711D5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 08:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXbKl-00082y-8M; Mon, 22 Dec 2025 03:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXbKk-00082Q-Bn
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 03:32:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXbKi-0008Mc-2v
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 03:32:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so33511105e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 00:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766392317; x=1766997117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NW1LXDqDE6RXLPwmBGvI8y7XhLrJ5SvFgl9imcgzna8=;
 b=Fqi9/olkHjmzOoq2fTYERaMXvOyXXyFn/ijk5YnRP9Nh/OFYFW4RrkpJORzHbNaJAY
 GqSeUwZGWj/N4q5LYSux7pnzKmOPk/labfouoP56g0peWELbUisbXRuczNcGI1oDwjJN
 Xs229DhN/69ZqrX+kqqdThsry6m4wPxP07UzCoEsqsV1geK4YyN1nF9qmYu70bmCs5jv
 UWSKiK0hRvmyQHDSHEVnwbdHwkrUatDkmZ+gghuvECo9mVB79NYNC+UmJll0t8Bkz47J
 iNbH7IF9L2D1f5eYuPDSH/7Q/SO9Td+cdoIXlDe6mErr5WCnhNUZ9blyO++o4F/ZE9sy
 2Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766392317; x=1766997117;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NW1LXDqDE6RXLPwmBGvI8y7XhLrJ5SvFgl9imcgzna8=;
 b=NIqQAxRkLOjAoJMuuVKAknAl//AXG9j9FRjDLcETwL3oxagEhqstj7jDTO2XsJf6C6
 z6rJCG3xG9yIPoP6tcHl/ruPLRkaX2Uxop6CHZVf1uH7PqAWUo0qIJOsDJ50Rv+UujtC
 zk/ersxwa6Gn2Qj/ghqeXebHW7yJ+HvGZxO1fgT/+VxES6MZGNVNZfiQPDk3Jv2umZ+u
 L+govwyNqJZHHAZxjZ4JKBgOL9viUCeSG+lgM5Myr9dd/IHhPhYL/fL2JtpEcFTp0FwT
 TjK8fZhU6u3Afy6hDJDRq+BQAzZIuLQQefQh5mjToZBBdAfZ4PpDo8zjUjWaiFbjjN33
 UE3Q==
X-Gm-Message-State: AOJu0YyAkEOfwtkKmhp2hA5DOq63PqUXnBd4HVRdpFu7OF8D5e5scZDF
 aZyz278WUlYaO0l9OeOSOUS3vR2PRKWDys3WnFGrjtOpO+TB6qXeulVP5WTtIcEE2ObieZ4atVz
 qfWsu26s=
X-Gm-Gg: AY/fxX4nya7TIhTowyj8aw7DfkLyQpvrALm4w7epwWghaJ3dGzwCEKflNXWzFaNmf0H
 AH5Cce9aA/oBgd794YlsWPlrMNEkp6rx6hAhRz3Mo+5VT1RqFZSt0aEKZliau0w6NaJR2n59jlg
 ZROKuzGKU1QDyuT5L7skcUX4s3U5xNCsqcZuNTzZES63eUStE0HPO60ZLngWIVvOxBcK+bYusQR
 pMcFRbmrenHwD4mJ2MyVToS7tdzADMxSu4hS5HEUB3cNSUzc3u1h9dJebaP845RC9OB6iVHr864
 2EeksVAbVlnHjjdA9W7yHc9iSsOwctJI+sONY/YlQyva5Qk0snhz3wqFrZBrena4+eTbfVSHo7T
 m5BXOG0SE0Rih6J7CtBZezGtpUEQ1zMJko3ATt6kttoHXV7EdKIWi0B9+r4IyKsqdFjddfhEfRW
 7X/eU3HBOnJ3jRUH8Va8Nmh9kSj6iUhrw1cCtIwwWweEGVfocVR+AHVw==
X-Google-Smtp-Source: AGHT+IGatM3E257yOyJTFpQLNMHF9NxMA0hGGz5BLTAsvqXiwRWDYKM14/mEufGYbSB6yeeK4KvW5g==
X-Received: by 2002:a05:6000:1845:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4324e4c737bmr8892456f8f.6.1766392317059; 
 Mon, 22 Dec 2025 00:31:57 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2253csm21043693f8f.14.2025.12.22.00.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 00:31:56 -0800 (PST)
Message-ID: <91068c0f-f392-4a40-8274-d951f290e928@linaro.org>
Date: Mon, 22 Dec 2025 09:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] target/sparc: Use address_space_ld/st[n]_be() in
 ld/st_asi helpers
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
 <20251219163650.74303-4-philmd@linaro.org>
 <a8b08de4-5bd6-46b0-9f4a-99bff5667106@linaro.org>
Content-Language: en-US
In-Reply-To: <a8b08de4-5bd6-46b0-9f4a-99bff5667106@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 21/12/25 12:11, Philippe Mathieu-Daudé wrote:
> On 19/12/25 17:36, Philippe Mathieu-Daudé wrote:
>> Do not open-code address_space_{ld,st}n(), use it passing
>> the access size as argument. Directly expand to the big-endian
>> variant (with the '_be' suffix) since we only build the SPARC
>> targets as big-endian.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/sparc/ldst_helper.c | 42 ++++----------------------------------
>>   1 file changed, 4 insertions(+), 38 deletions(-)
>>
>> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
>> index a87a0b3eee0..e9139814c26 100644
>> --- a/target/sparc/ldst_helper.c
>> +++ b/target/sparc/ldst_helper.c
>> @@ -701,25 +701,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, 
>> target_ulong addr,
>>           MemTxResult result;
>>           hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 
>> 32);
>> -        switch (size) {
>> -        case 1:
>> -            ret = address_space_ldub(cs->as, access_addr,
>> -                                     MEMTXATTRS_UNSPECIFIED, &result);
>> -            break;
>> -        case 2:
>> -            ret = address_space_lduw(cs->as, access_addr,
>> -                                     MEMTXATTRS_UNSPECIFIED, &result);
>> -            break;
>> -        default:
> 
> Unfortunately I missed this 'default' case (which I don't understand),
> so this patch is not a faithful API conversion, thus incorrect.
> 
>> -        case 4:
>> -            ret = address_space_ldl(cs->as, access_addr,
>> -                                    MEMTXATTRS_UNSPECIFIED, &result);
>> -            break;
>> -        case 8:
>> -            ret = address_space_ldq(cs->as, access_addr,
>> -                                    MEMTXATTRS_UNSPECIFIED, &result);
>> -            break;
>> -        }
>> +        ret = address_space_ldn_be(cs->as, access_addr, size,
>> +                                   MEMTXATTRS_UNSPECIFIED, &result);

I just inverted size <-> access_addr :) The default case shouldn't be
reachable IMHO.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC57CA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFRmB-0001Fb-TY; Sat, 10 Oct 2026 03:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRm8-0001EN-Uj
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:45:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRm6-0004rs-8G
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:45:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so410800f8f.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 00:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791618344; x=1792223144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6rEbUZT8JrIgjKe9a62xSWCSsdjW4XckhpXsYtq7+MU=;
 b=h1gM6/ESiDKbG3Z5HZtz3Ig2gmpRW284aDnLGTRWozvU3Gf88GVcnBICcWAlthRAAk
 lLJazlCwJVwzJtDcKW3Uy2abYlmUJINsS5bHzFiYAXUvEiLn216OHT0qA/zRCqEBl5Zp
 j8Sv0c+UXS0hfiYOw4XndxxiGOfj966cizJrepiZgDMAAK6MnWFgQCNihB5fD/HMAZJW
 JUNrljmAPzQA/eIJGXPaaRkqqBYcRGygEhKFXyRudLQLYy2PTqZ5zjg0//2P4mTmMxdt
 J077tUSp9q/cdPJnGEOlr0ClJO/2wYoJ5FE1fL0UVij+rgwssBh6SwW7by951A0MuqV4
 Lr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791618344; x=1792223144;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6rEbUZT8JrIgjKe9a62xSWCSsdjW4XckhpXsYtq7+MU=;
 b=t8DrPtWw5X0eRV8tErVcAW45vvJ4FglbxpytlI0YjrsBa8azcA1TvdvQ8ERNDn7oDn
 +A3Q6Nxqzh67ZZM90QhgxP1SO8Dl8an7MnLW1wBT0T/wGUwa285lgOxzmKow3UPu2QOV
 kP8BYD3qx9eQnh5+U3vqg4VqxKvEmy3qnHyx8JLRvpFbQzPyEagUrC7WcmZi4bjDT0Ns
 O+wPKl+d1sgzEva96gdsmdSDlCzajhSumXuuvF53VRrQN4xRqoTM/u6DIh7iUZhahA4X
 9VpxYxT19GIqykLOhfCGd6Qb3JEj79EyD9HyfWyEj4e3eptsX3AA+N2cV+kDPbgLrCCR
 wHLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPIwwlzv8cKiSJ0g5acLapu2eHzrcB8l/GRA1zqjPihM+jayNKeItf1vacipaJ+2YooquCgXvdYKv+@nongnu.org
X-Gm-Message-State: AFq9FYKX55Apz7S1UVbh9wPQT73Bf3mANBwL5mdf9k9j+vTu0QjVEty4
 2EWf0i48I+LbJRljbuEo8sMFp1dKSbiz/lINZwS3GZUhF812gVyGMvk1Pn4kZl7dEfc=
X-Gm-Gg: AYBFou1IqO7OvrdasfEPZLE9TAZ2pn2uYY7DHXgW9rGYAp8i2R087tZnDRJvKp0d52I
 fnWct8nbiTUocpnZotZaKNp56w8cEVw6Jkl6ldfKnJFAqRN0Ckphg6lU7tht00ZoyCE+WxBh6FC
 KMShtKv6bDgPf25BiZTdjUvNGQjnychIQoDgJyXuIYEHHwhpcrMEbfVQdPv2SxTAmMVQmt3ZmM5
 At2tSf1LGDSz/nh7rbRsIMPPA0wyib19s1tDcxWYIwZhS0qh6Tzdg/rwvKA9zfdhr4KMqNkPybX
 Ki+e0bgJq+xD3FSebwJoJwTkJ/Jc1Y3VNwGLkpdzm7ipLNKYAO9hr8GibYcVofWcUx7oTsPLVwE
 abXV7+ev1lBY4IMDldBjXGVHKpWGVTBy59W964OOV87NmDxYWiM6kKhlRr56q9VJTjFBRisgXfx
 YV5qT5WhIVT9OQTqLKbT4C27fEqO4JC+M/H3VtNtpirRvVwGo9su6iKSYMxZkF23R+N58dgqyAn
 GxRsXdBX0GJsjZRcO+oPcoHSTVtEpqiwpVA10ajS++F7LTu+iUzJ6E=
X-Received: by 2002:a05:600c:4ecb:b0:4a1:6916:798 with SMTP id
 5b1f17b1804b1-4a18e4a3f69mr77392505e9.14.1791618343890; 
 Sat, 10 Oct 2026 00:45:43 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:a2d3:66fa:95e6:7d81?
 ([2a00:1e:e082:2901:a2d3:66fa:95e6:7d81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9462ebcsm8451254f8f.8.2026.10.10.00.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 00:45:42 -0700 (PDT)
Message-ID: <f8ea6e43-2e6e-48b7-a61c-d9ec2200872c@linaro.org>
Date: Sat, 10 Oct 2026 09:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tcg: namespace target helper symbols for combined
 builds
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260930073935.712-1-luoyonggang@gmail.com>
 <20260930073935.712-5-luoyonggang@gmail.com>
 <374ba010-b530-4310-b20f-65ada56cda6b@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <374ba010-b530-4310-b20f-65ada56cda6b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

On 10/1/26 18:51, Pierrick Bouvier wrote:
> On 9/30/2026 12:39 AM, Yonggang Luo wrote:
>> Use target-specific assembler names and helper metadata for TCG helpers
>> when multiple targets share a binary. The generated prototype maps the
>> generic C helper name to a target-specific linker symbol, for example:
>>
>>      helper_raise_exception
>>          __asm__("helper_i386_raise_exception")
>>
>> This lets target helper definitions keep generic C names while avoiding
>> linker symbol collisions between targets.
>>
> Hi Richard, do you have an opinion on this patch?
> 
> We are trying to see if we do renaming per helper, or if we introduce a
> "generic" way to deal with it. I don't have a strong opinion, renaming
> things or adding more macros and build system soup are both ok on my
> side, so direction would depend on your culinary taste.
I think the general direction is good.  Perhaps the specifics need 
adjustment.  In particular, using __asm__ to rename symbols is suspect 
and likely non-portable to non-ELF hosts like Darwin and Windows.


r~


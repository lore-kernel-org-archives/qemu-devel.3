Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD1DC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDv8-0002ZJ-Os; Mon, 31 Mar 2025 08:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDv5-0002Yp-CJ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:07:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDv3-0003Ie-HR
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:07:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so3259754f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743422827; x=1744027627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YU2OLsvo/qtutzo+RPIOTWZ+6IuK1AZJ5y8/j1H11I=;
 b=nGYuB0p2+IqyiBJRBIyK39gdyP00vvLEEmE8+5HUHJG5puUpClSHYnWAFs6PO82nhm
 CZP4p01f8vHt7fb/PeqvRJtwKIMRf41rMvQZOyl2vrFH2XoFGEY6j2XFLEfJWaamwzA4
 HDrR3tQEHnNTEIRu119dZEbncZ2GukcQ/+7J1vvmyFg5wN4aPxfqp5zeG0oA/ls+8wGf
 Mh82xyB3E5swfxt8cC6I92kmqzITwOH//XfgN/e0HjUt2cUT+JVVhX0tDVtVzYct3WMW
 zL5YFLvCkqU6H3CqPXxfgRM6Zjf01Amx8X8Dsae61SyifC7E9utXexitWeouMku0jnEg
 +YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422827; x=1744027627;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0YU2OLsvo/qtutzo+RPIOTWZ+6IuK1AZJ5y8/j1H11I=;
 b=F7C27hTgvr4SIjMZqmfHvHa4vK/msyY16zWNB8QrIh6zP5tCasjLi7Jfj7J6QcpbnD
 RB7zPJcxcqmLF1+as9WiLOX0HvgXpGMh1GsSim831rhyJPMEGxzj0vNdelpSaCBBOx98
 4DBnHwSzXpuqNy9mrHsnAsGqhzGBsrUy3fE7q4+L229iFAmVymGwnvv3i4a1NBhNHuVf
 tOn28H2i50qTsXQtRT1wuCfQd0CLbe1UJ8efSOA669P9EvA0xnxlgUcv45OL2eaS7Dli
 VRDHWuYyNQ9bf+zE0K/bnNpsYiRGBNkBfTL3fuy67sAkNfWwQtD9DZ6pzSmBooO3Hu/w
 LcWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc87/kc61TvaK5SmhYRPZ3IU2lBwX7K9t7hh66P5pkkbqLzUjxqOEUGEtsFKfNuFwGBFpkWGpaQb5v@nongnu.org
X-Gm-Message-State: AOJu0YwM+kvMT6yimGqp2UU0kkKAIn3eDnclMFyGNexw+zQRTvIDhu5g
 cDaVBXDPVolEtSzo5yl8DhSxVKIwlFqVocqoLQeCA7Kqv8rHdt1eSAqW8wNiM7Jibt0QzDhRAmJ
 b
X-Gm-Gg: ASbGnctJDlgw69/P7cd8oT1vY4VS9NFrjYaYsTIeFg/ahCXWn2KTw4Msrd47gIAgZT3
 z52vgqrZvnqg6a9buWow1ZWiLbaeTNMfIN29HjVm5vOrc4cjNXjAgTj0KxxtC+tY5kaqOdJrMPc
 ppSlSTQmMB/wED7s2H0NspPiQVJ1ovxXE/o6tES2PY+erzPeTF+nK+ZT23AvdV7qOKnJOf6BKEG
 rO3tNBIxwszeY29TL/S5vJr+ejASp1PXrWqYZsnMS0OrAiS6JmE0rqbyCMZbs+PmNUohnG3JQyU
 L9CeGFAuXQDs99ZIldEEzDIYiHNLmfR0Ha/rGsZ5/kL2SZFOkhO5HzVGtYl5UNAF5jcOcFV0d3H
 8na+M+AYa9DSS
X-Google-Smtp-Source: AGHT+IE5jw0q4rvHJsWNjdlUZ1QE2yQ1oPtKw8EiQfms8LhxbxOAAlzK1GrEwsUtEdav8eqYimEqxQ==
X-Received: by 2002:a5d:5982:0:b0:390:e9b5:d69c with SMTP id
 ffacd0b85a97d-39c120e3873mr7349636f8f.25.1743422827529; 
 Mon, 31 Mar 2025 05:07:07 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d914f1561sm79866055e9.1.2025.03.31.05.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 05:07:07 -0700 (PDT)
Message-ID: <430d8a07-903d-4fc5-b8e3-04946b2e26d0@linaro.org>
Date: Mon, 31 Mar 2025 14:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: Mark the "mipssim" machine as deprecated
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU devel <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20250121103655.1285596-1-thuth@redhat.com>
 <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
 <f96de148-67e2-41ab-ad5e-23d68af25f85@app.fastmail.com>
 <bfe9e233-bcaa-4c27-9c8b-7540dc2795ef@linaro.org>
Content-Language: en-US
In-Reply-To: <bfe9e233-bcaa-4c27-9c8b-7540dc2795ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 31/3/25 14:03, Philippe Mathieu-Daudé wrote:
> On 21/1/25 13:09, Jiaxun Yang wrote:
>> 在2025年1月21日一月 下午12:07，Jiaxun Yang写道：
>>> 在2025年1月21日一月 上午10:36，Thomas Huth写道：
>>>> We are not aware of anybody still using this machine, support for it
>>>> has been withdrawn from the Linux kernel (i.e. there also won't be
>>>> any future development anymore), and we are not aware of any binaries
>>>> online that could be used for regression testing to avoid that the
>>>> machine bitrots ... thus let's mark it as deprecated now.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   If anybody is still using this machine, please speak up now!
>>>
>>>
>>> FYI I'm using it to run MIPS AVP (Architecture Verification Programs)
>>> time by time to check TCG's compliance.
>>>
>>> It is a proprietary software so unfortunately no binary available
>>> to public :-(
>>>
>>> AVP has two supported platforms, the first is plain old MIPSSIM
>>> here, the second is OVPSim MIPS, which is compatible with my previous
>>> MIPS virt machine effort.
>>>
>>> Maybe I should bring MIPSSIM work back?
>>                          ^ Oops I meant MIPS VIRT.
> 
> IIRC I didn't finished to review the previous version?
> 
> Is it this series?
> https://lore.kernel.org/qemu-devel/20221124212916.723490-1- 
> jiaxun.yang@flygoat.com/

As the 'MIPS VirtIO Machine' looks quite easy, I can see it being
merged within 2 releases, so it seems safe to deprecate the MipsSim
one meanwhile.


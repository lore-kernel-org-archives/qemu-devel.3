Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CD2C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGE3-0006L5-Aw; Tue, 08 Jul 2025 17:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uZEnf-0001tj-N0
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:20:24 -0400
Received: from mail-oa1-x44.google.com ([2001:4860:4864:20::44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uZEnd-00071B-8o
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:20:22 -0400
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so3475864fac.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752006019; x=1752610819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/srP03LadnBtI40xfonlgq/Oc6u38UMF8cqS7IASvek=;
 b=e6rf4dVPqN7VwCtRdqcJpngia6J1Ql2XdUA619BcqzC1nhG21mrPNRsr2/i8Yv1dPQ
 C2KZJ6TuNAtGT6SGsKiNiegNbZWpq2G9kKS31stct1LPMCvd0cIXnHkobjJwU3PEQ8fe
 8J8HZzWfC+VGGnX3S030G9cLc76cw2Xbp4VMoeCpKxPJAZ9eRcA46QHnnW8cDNCmwbUA
 hy4n7GXOKlT9Y2HtjL+dHbyR24MQEqd00lg7WcM/MJamksGuuc9Qysj2nd0Yvz0sEolV
 iz0iTuZE8dFsduNyxt5O5UnkN0wyJ2nQUZCt0pD/70E1jFRdTAFmevfvQqNUpyaL9w/q
 9xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752006019; x=1752610819;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/srP03LadnBtI40xfonlgq/Oc6u38UMF8cqS7IASvek=;
 b=ix6w8yqSFsBJadpGQSlLerzcAaB+3WwttTzRmQra1chu/Z57q52GbzgY5KGxi6OH/V
 utpdcwHPBCMXHvKc5N7FR8JUyICam42/+sOHhd7mg6vkOSMl5tXteGag/FdDuZncn/6S
 nkUdWxu69HwBPtcGNqzRqMwrjfKrrUPAphrXeCbokCnCl0dAVpuCDzVCCYUZrz5I4QZC
 r7eEJvC3heavze0EcWynIQlhNb0Zwpx8BDCqDiVauYZvTH0px3ZBW084jiOpaqKzZ6cT
 /H6X2rGS+g9d9ingbmBNqTq/rfs85zTC+3sbFNxST+cS+6lDg+OOUYjXSgDOBtD8CV0x
 jpOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpFNyC4ufCshoJT0d1YXfouAEQBv3tGFFzuBZ5vL/LLq/nmN4hwIkv/LDd1BVeNienIYw3crtiC5RS@nongnu.org
X-Gm-Message-State: AOJu0YwUIkDjcJ6pgXDVcB6HkyORHulzcMCVEDroq0IhOgZcxFwmOkeL
 P5ODa0x8TTxKc/dU816Jf+XBQTTCnE37GPLBnow/AyhQ9AZvOXqEr+P3pRWx8Zsf
X-Gm-Gg: ASbGncviURURYtGjr/IwrNMnOEewJF9JTptjgwFp9CXwlHzEwpkNdSDNVNcy60rTCel
 4DfaN7Gk4lbIHeKPezDjV1UR1eYJjjFbde3Ojztqy98NIJAY1gluAu/mkJUOQI4oCjaw10VORIW
 EhwdcNbvf6s1OEQwFZ6amS3KHST4526h+e3qRcltdtR/oP1n3xJ6RxEIBXy2SVF26XKm13A6nfo
 YTbr+Kn1Ip2x9FD7gqxDVyAAMSaCEFrixICC3YbDdZid14B7xYhL5yRDUxbwsDP6TaCH9DD95y7
 ddKoSv9rLPuvuHDpTqbm8GGVCIp1nmpC7x0HN/cNGZhANb9YuhR3Q40nq4vGIcw=
X-Google-Smtp-Source: AGHT+IG/SELCDXZeuQ9nTgkibSV9YUOxZ6Pqs2uIX6UZSBNOD0d0xG5Amafa730Ca9YbsfNrRjeBGA==
X-Received: by 2002:a17:90b:3903:b0:313:5d2f:5505 with SMTP id
 98e67ed59e1d1-31aadd9ce71mr27358016a91.16.1751986137936; 
 Tue, 08 Jul 2025 07:48:57 -0700 (PDT)
Received: from [10.2.0.2] ([89.187.185.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8434ec91sm112279855ad.64.2025.07.08.07.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 07:48:57 -0700 (PDT)
Message-ID: <82da22d3-110b-4d6c-a6df-3fe589147e7e@gmail.com>
Date: Tue, 8 Jul 2025 09:48:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yodel.eldar@gmail.com, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, laurent@vivier.eu
Subject: Re: [PATCH v2 0/2] target/alpha: Add TCG plugin register tracking
 support
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250630164124.26315-1-yodel.eldar@gmail.com>
 <87ldozunj2.fsf@draig.linaro.org>
Content-Language: en-US
From: Yodel Eldar <yodel.eldar@gmail.com>
Autocrypt: addr=yodel.eldar@gmail.com; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 N1lvZGVsIEVsZGFyIChZb2RlbCBPcGVuUEdQIGtleSkgPHlvZGVsLmVsZGFyQGdtYWlsLmNv
 bT7ClgQTFggAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBNPNGM1AbbuKZqn435Xu
 T7c2ZU2sBQJnI9xJBQkB6nhTAAoJEJXuT7c2ZU2sSQABANuu74MJKexa8V8kVNLhw68loN4x
 2ZbojcfUOWd8Pf5HAQDn1XxmQFPMIUYahlXMMrwRyQE1m6HjtrolOELICzwxDM44BGcal3YS
 CisGAQQBl1UBBQEBB0Ao8jLdb8MoWybV77fXOiqY5jSmrPy+MgzzjrAzqURjZAMBCAfCfgQY
 FggAJgIbDBYhBNPNGM1AbbuKZqn435XuT7c2ZU2sBQJnI9wMBQkB6ngWAAoJEJXuT7c2ZU2s
 BlUA/0ZfDDmzKdC1khPMaRIv/gWedFd5Z8jWqh0rswF2LyeNAQD6PjBgliBhL1xTto+juM1b
 jctqRusjtyMyzG8/ps2iDQ==
In-Reply-To: <87ldozunj2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::44;
 envelope-from=yodel.eldar@gmail.com; helo=mail-oa1-x44.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Jul 2025 17:35:27 -0400
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



On 7/8/25 2:53 AM, Alex Bennée wrote:
> Yodel Eldar <yodel.eldar@gmail.com> writes:
> 
>> This patch adds TCG plugin register tracking support for the Alpha
>> target and resolves gitlab issue #2569:
>>
>>    https://gitlab.com/qemu-project/qemu/-/issues/2569
>>
>> As mentioned in the bug report by Alex Bennée, the register list is
>> built using the target's corresponding GDB XML feature file, but the
>> Alpha target does not have one. The second patch introduces the missing
>> feature file and the necessary plumbing for it.
> 
> Queued to plugins/next, thanks.

Excellent, thanks for the update!


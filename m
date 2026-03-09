Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36484F3C266
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzb12-0001cR-8X; Mon, 09 Mar 2026 09:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzb0z-0001cA-DD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:51:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzb0x-0006i1-GE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:51:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-485409ab264so2784645e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773064277; x=1773669077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jRsJIPcAQjznj9SNGnhxzXMw6IqKxWI5j3VMPdgvF3w=;
 b=Q/2E2nPP/qHutyes6SLphsynqeFK0lV/OPoP8yhnknHjZ8KWeAi2Ft+2WoeIMcV921
 QXYcgXORXt+NIpxn7DlN23qmRMpTGBYJOpHheULlVDdbW/+w4CCvEQ8TgKV+RGX8avLz
 ZT7ypca0BCmbXCAMntCaT26tUS4j5Oji7LYAAKZvMRFgtA6HLpZll9yGtTEmXdrYIFb0
 IBiQb1OTvd9SxmFVLP9aM70G55OEUzwjGYN7CQNxVvYODpGyDF2EXwga3FIh7Wa66H4c
 a1glVhX71vPa5NANnpsQd/45ULm7rJ5H+Im2vBhI8TCLOIfordXdZngEhZJ0Tljgy0ji
 fjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773064277; x=1773669077;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jRsJIPcAQjznj9SNGnhxzXMw6IqKxWI5j3VMPdgvF3w=;
 b=pH7F8foFOb7j3nEC7apWCK4mQp2L1YwZi7nVpvSEaat50aDmNGUoUpnhrr/lEYQRIH
 OaaAEClxrK1aWYuHKF/x2pA48fx4KoCXSOIW08OuBWKoolLDTm5TxbWtSXQHA/m+sBnn
 iirgFNel/c9YsbpYubfj31+jxQ9xHgo57qOBM1oFyPq9b3BD6CzFbaBkgsZEK+QaKGll
 xD+UVduFgNfSo4tS0k+X7vA6ClUX7Kbq7YooHf12OJUpcCPT+aBWTVpCPspArv3IdoOx
 irVa9/6Odq9GZpGqEbpCexahk2nqH5c2C7uZ4nu2PNWIOCbJ+KPJnQUT9PQGMNsCgQ2l
 fFuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi1XZyDXsFh0wXxhZIXmJdFthP89KFQZ7G3XY+fHOAh1V1oOHngcS1RT9nhEkXhuHrSPGWGgeWJVep@nongnu.org
X-Gm-Message-State: AOJu0YxD9UqF9eqxv4tmNGHMt/zLaGo3ivz7Pv6zDtsCop5kiXOg2BzQ
 YJm7Tb64MGkge+KNJwtxAVul1VKCy5FT+Q7C6KEmzIE9zWRnGc3KkVFdYD/4TcXHkTs=
X-Gm-Gg: ATEYQzzzVpyGhev8vvr9+vwvL+0Xr0Y4TZKygqaG7b1FNejVvSVWbU6vkEE90/i7C09
 QSC+00A5nInrqcRFoyuohw4lOFoUc/5kn/iW4VZOzYawWQIyYkZFmURqC/YH6WZ3AmTbbvpI7Cc
 Nx/mrMNZvkdf971I3ecOJVaK5hK87eBL5UvQkmv/tY0z6alhHyFu/39b7JlpKzJPjZuANyD+ljP
 BXAUbXYanCdm+VFq3V9vmNPgWsJ0yi99OpEkp4IJTJSME4xOK+9N2PGD1ZPTjvVjZpZYxPyp5cB
 7FEtO5OJV84bxcaHuLNQEJL3ggTY7/RKlBQ4IOrKd3GWmUf2JafMhccrHgQBFNTr7bBxDyMWhGQ
 p/LAamDStByw6D2n24oGx7eZap76x2I2ediXTBf5v2ASNRpIMf8+DMaoDi6Yn07FAHqmOgVD2Qr
 cf34Vw0oB3/L+xCsK4Zrd28BSRCQT2YSosC8O+Aau8AMVrqE/NdzkdTZLV40tSAn1+PPHTshI=
X-Received: by 2002:a05:600c:19c9:b0:485:3b33:f4b6 with SMTP id
 5b1f17b1804b1-4853b33f723mr55311615e9.0.1773064277330; 
 Mon, 09 Mar 2026 06:51:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237dcf04sm134276675e9.1.2026.03.09.06.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 06:51:16 -0700 (PDT)
Message-ID: <303bc39e-9fca-4173-be6a-f748d29ba7dc@linaro.org>
Date: Mon, 9 Mar 2026 14:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] For next patches
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20260308172936.2835-1-deller@kernel.org>
 <e389e2d6-2376-46f0-ba48-e38f39d07f20@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e389e2d6-2376-46f0-ba48-e38f39d07f20@gmx.de>
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

On 9/3/26 14:44, Helge Deller wrote:
> On 3/8/26 18:29, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> The following changes since commit 
>> 900682c57287ea308850af4490339455512e92e7:
>>
>>    Merge tag 'pull-target-arm-20260306-2' of https://gitlab.com/pm215/ 
>> qemu into staging (2026-03-06 15:58:24 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/hdeller/qemu-hppa.git tags/for-next-pull-request
>>
>> for you to fetch changes up to 9e8501ba72d5136ee5e6622f8863ce8ea252c29a:
>>
>>    linux-user: Improve formatting for mremap() (2026-03-07 22:58:27 
>> +0100)
>>
>> ----------------------------------------------------------------
>> linux-user and hppa patches
>>
>> Two patches which prevent memleaks when using Diva PCI
>> cards on the parisc architecture.
>> All other patches are for linux-user emulation.
> 
> Please ignore this pull request.
> 
> The two patches for Diva cards have already been merged via the "misc- 
> hw" pull request.

My bad, I didn't noticed your PR while I was preparing mine.

> I'll send a new pull request, which will include the "linux-user" 
> patches only.

No need, git-merge should figure the commits are identical and proceed
as usual.


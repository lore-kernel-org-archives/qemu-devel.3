Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B0D65553
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 06:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGXse-0000qi-UF; Thu, 28 Nov 2024 01:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tGXsc-0000qF-JL
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 01:19:58 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tGXsZ-0004F4-Re
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 01:19:57 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7252f48acf2so373026b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 22:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1732774792; x=1733379592;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ustl/oHEJAHix7s5U2EiLiN0GkSFJzc5OICssttx0U=;
 b=zb3R0W7hORcsSrREDmdcXrULnRmIcB/yDvUOOYax99dAoyq2K75qrGjisaP9W1Qn/A
 bnUwdKcpAR9IuqcBeEKz9KQT4z5W0fMDGORY5popGKlXkmmBwXITNSLcPC49/j76GGtU
 143hPvRYjvf6Oe4M/tkHO/Y5mHal/qP+U04E4OHbRJhlKMo00EVe/TrKUk6TGL0F3nSn
 BeMOBk6kv3biG8dIbcdnOn1FwrM+Mx9OwPzZXba0AfIYVTv0gazT9keACirCEzNV0oyR
 pCDcDciDl9AtOpi6XkTmstxrksxtypWt+H6jKW+v3MLYVHrIezaCFuiVeoExBKcnwLq1
 6dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732774792; x=1733379592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ustl/oHEJAHix7s5U2EiLiN0GkSFJzc5OICssttx0U=;
 b=K1u3RLMApaLmpfo4WR4xPtC/631BvcZWbLauQiZLqqeYZjg9N2mY2dh0nGBd3Bt+Qk
 DeWtUvaw4g8gaotW6aGkcgCl4t5AqS8V89h4k2STENvagXxsW7yeNHioeomMvkVjraDo
 oqWQl6wqlJMRCe4XWIpKWB5N2FUXd+x1oodDzgFP6EtwvOpRpA3xzDQD0PCw+uLQea2C
 CcOGOoqGZD/vVopkcoFOUbhWKKpA8+TZdzTAMdvqxvx6npzGzBY6cLBUm0s9MfCjUYrV
 li5ujFqa9SsBHjjn7KFC8aTF166gEnvC8zth4BTflQXSWoKs7OP7cLfWqrD77heqs+w2
 XysQ==
X-Gm-Message-State: AOJu0Yy1AL63MBnt0q1cw/wZB4pYz0qiYYWbbuCrRwKhCW9mpdGMVjNk
 QoXEv7UM+8QYygQHSq7D8xaVgnkJ7XCup+Jn8xjUAn8OsckayVN3it+U/IhBRAM=
X-Gm-Gg: ASbGnctml3BCz3DXuazVjkgLkhDkuKd5tt8Uov9rJmseOpxhN0Whd1I5ypKITs5gd3S
 PaNYwyFbJDy62yRrhVNTDsk2R4+Xm3HulrHmZep9c19CMfos16NzFQj9LYnfDJudFA306m+3AeQ
 8K7YY3jEryEsafBoEHnwmfeKCYKDdn/N91Zv86bBljMFBvMLftFw6Un2NADPiGPrGReaaAB2cMy
 AFB4inK8zDi3PkMX/+DzD47CaD3bEyMpXgFUdT2u9FkyQR/cAcfUFgEGoTiM98WVhVQrEaWv9g=
X-Google-Smtp-Source: AGHT+IEMdlyOmMEp30Vf/CuuK2xvP8WSab0S53c8jrEhfh4/0dhtd4kaheJnn9Gxp+HKScl5f16flQ==
X-Received: by 2002:a17:902:e843:b0:20e:95c9:4ed5 with SMTP id
 d9443c01a7336-2150108ca27mr88113975ad.7.1732774791975; 
 Wed, 27 Nov 2024 22:19:51 -0800 (PST)
Received: from [10.16.166.2] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2152191afe9sm5793825ad.106.2024.11.27.22.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 22:19:51 -0800 (PST)
Message-ID: <1499e05e-acf6-4e4f-8929-e8bec5b92fac@igel.co.jp>
Date: Thu, 28 Nov 2024 15:19:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] support unaligned access to xHCI Capability
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, qemu-block@nongnu.org, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, farosas@suse.de,
 lvivier@redhat.com
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
 <CAFEAcA8oDPD7xdhMC__Rp3WOzSdm9CnSHw-bepvQnxK3BMzVOg@mail.gmail.com>
Content-Language: en-US
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <CAFEAcA8oDPD7xdhMC__Rp3WOzSdm9CnSHw-bepvQnxK3BMzVOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi, thank you for your comment.

On 2024/11/27 20:23, Peter Maydell wrote:
> On Wed, 27 Nov 2024 at 04:34, Tomoyuki HIROSE
> <tomoyuki.hirose@igel.co.jp> wrote:
>> I would be happy to receive your comments.
>> ping.
> Hi; this one is on my to-review list (along, sadly, with 23 other
> series); I had a quick look a while back and it seemed good
> (the testing support you've added looks great), but I need
> to sit down and review the implementation more carefully.
>
> The one concern I did have was the big long list of macro
> invocations in the memaccess-testdev device. I wonder if it
> would be more readable and more compact to fill in MemoryRegionOps
> structs at runtime using loops in C code, rather than trying to do
> it all at compile time with macros ?

I also want to do as you say. But I don't know how to generate
MemoryRegionOps structs at runtime. We need to set read/write function
to each structs, but I don't know a simple method how to generate a
function at runtime. Sorry for my lack C knowledge. Do you know about
any method how to generate a function at runtime in C ?

> thanks
> -- PMM
Thanks,
Hirose


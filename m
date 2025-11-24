Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31920CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 07:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQqq-0003sL-B1; Mon, 24 Nov 2025 02:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNQqm-0003ql-L2
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:19:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNQqk-000596-7C
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:19:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so20348445e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 23:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763968740; x=1764573540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WM/DNkVe3am1IpF+FY2NqyPcEJzE5w22abNO+mgeN5I=;
 b=M7dNqRXXGqSdD0GLc3r4cnGQjdNhvUuIeqvAZvJfQcyERbb7WfNUTAdYk8yIyfKff7
 bS8gBrpfzyQMza1rnThL/ZPn2kuHtMkZl0lsODbbfAYgGUnFPK9beE9w3BA6zzPVPf9f
 8uNPT3MtqpTOecvq4XJfKSDZYqOmAZDgzy+EVU8xFTQEveCXtugk4WxgA3dk7XR4JRq3
 Yd936DHod20uQlP98luFcbXZO2vGkcjU1f3Ip7kBZqhK8pt3Y/WPlvHzD0xUGQF/zPNf
 JnbXZJZIx0B6iRu81eNhBBA/1n4qpa+QpdhMmrLQaHkUjbtDgdijKB8wsA5QKUzru/uL
 BrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763968740; x=1764573540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WM/DNkVe3am1IpF+FY2NqyPcEJzE5w22abNO+mgeN5I=;
 b=jvOQMkRcOaI8QZa8HJvWqoa0ZHOipdE105RdGpWR4RWHCZUzSm6NWqT7Wu95h8/Xbl
 snzA/4V8w2LY767+KFuGvAtYPYqgLDPY6o6jOiLycQ2b0HHW1Ih8TT/6IIAh4lqGBu50
 ep7qMidlot6EGXB0P4zqnxZ6KBxCioU1PjMfuE2ghMeCJ0QYIgVWccpvXjDD2JWFO1Rd
 FXIpXT6yDGPMtB8AgDYMeehPBUFIpcWWN6xrG40OTQtdyDq70OFF1AY0akuI978NQEbe
 eHc7P7u2CIs5apKHvXS2IqNMxuJH9nw1g0k54vP38QtJUZYTz5321ftiC3duiOcEjNb4
 C5gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV18GgyNjzxeiyeSfp/vvtc1dj85BR8v2Zzsf5zZKG1fSGgHRx73DqR5fO3p221IwLHmZqJngOvsId+@nongnu.org
X-Gm-Message-State: AOJu0YzgjG4f90x7FTc+cY1PZv7cgcL50SjPZyc+GyPxVeo5U5oo0tls
 N/mjRNUt4pErF25LNkg7zWZ7/27jeVMQxUKPeoKctMXDJT/6vh9qUftk6SsY6CV6Y4k=
X-Gm-Gg: ASbGnctdwDXdubEKkgpuqlhwx3QVXS5m/RFr9WyNPOO/UObtoMaw24Ebf6sR9mdx/4h
 76h9b6ruu++OwiXGYpo1GI1YSYtir286ZMGy8z6N28SmybyK3+aG4J9KH/fscNh5BKatEH9K7l7
 ZdlLr62JoOTGfTzNDIbMft9gAggW1PA4+JGvvemy0qr+DEbUOUgXJidp+bQ5us1kACublFcxCVE
 MTR566uNAEj15uIL2PNt6gaUx2/KDIz8tzT8wjJg4/602LueTlQwVAM3/Li5SIwncqIUjhRrEoG
 GJN9qLidbTm9g+yPY52MNohDf+WNwN22tlA01/a9pIH1VFmLsDs0RQ15kh9caWGPH89vDhzQOwj
 d0C+tXhq5hSD50R5q6DhwSXz4ThbeJoGPTXokFjf4ygnw5Jd6llEwLdxTz8eYJcXfg/gQQvYIZ7
 TtwKhZCuK2i/DkUvk6VbaqXr7hsaxFu79iGIaL5HTh52DbPA/QeDnKPg==
X-Google-Smtp-Source: AGHT+IFO0t8BmtPY/xuV/JGLpiJNpL51oEWVVnQ3GkfUtWuVJzNTytYmmBvZh2ap26JCOWbUvRmHEA==
X-Received: by 2002:a05:600c:4591:b0:477:7925:f7f3 with SMTP id
 5b1f17b1804b1-477c10e1cacmr97593335e9.14.1763968740227; 
 Sun, 23 Nov 2025 23:19:00 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477c0d85360sm173323955e9.15.2025.11.23.23.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 23:18:59 -0800 (PST)
Message-ID: <351ebd4d-8ec6-43fe-b308-a0e54801a33b@linaro.org>
Date: Mon, 24 Nov 2025 08:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-system-sh4eb build has something hinky in the ethernet
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Landley <rob@landley.net>, 
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Thorsten Glaser <tg@debian.org>, Michael Tokarev <mjt@tls.msk.ru>,
 security@debian.org,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 debian-ports@lists.debian.org
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
 <CAMuHMdXZNroJF=s8gXj_vguGPGjUvgLu7w2PZxQg9tcHtSkNyg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMuHMdXZNroJF=s8gXj_vguGPGjUvgLu7w2PZxQg9tcHtSkNyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 1/9/25 09:47, Geert Uytterhoeven wrote:

> On Sun, 24 Aug 2025 at 20:40, Rob Landley <rob@landley.net> wrote:
>> Anyway, this works fine on little endian, but the qemu-system-sh4eb
>> build has something hinky in the ethernet, I haven't tackled it myself
>> because I don't know whether the device emulation or the driver is
>> what's missing an endian swap. (I don't want to fix it the "wrong way",
> 
> That is using sh_eth, right?
> 
> Last time I tried booting a big-endian ARM kernel on R-Car M2-W,
> the Linux kernel booted fine, except for Ethernet.  So sh_eth is definitely
> not big-endian clean.

qemu-system-sh4{eb} only emulates the R2D+ board, which AFAIK
provides ethernet via a RTL8139 over PCI. While old, RTL8139
is very tested and expected to have endianness well handled.

> 
> [*] I didn't have a big-endian userspace.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 



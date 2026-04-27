Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03121FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHJnv-0004fX-Ga; Mon, 27 Apr 2026 07:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHJnt-0004ej-H9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:07:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHJnr-0002Sh-VN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:07:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d75312379so7250048f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777288022; x=1777892822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QO+YMX5ksgG5zht7IUY/nYqzuFqNiuOUp+FXTuB0MzQ=;
 b=IC/3EoktDZ/lG1RDzPJy8omVpwigzEv55hd2KHqMuuItcuv0m2gP/t5Ao+0zOC5g8Z
 VoBhQgmjF4AgvUwpe+EDbBx4IF2/IhAsVWlcOT+S15MyCG+ieonwyGce/GUwPKaUkZuL
 SE28h2ar4I+IZmLclKwUJwEfRAUpfPW0PtGDXRuzU1rl3KtM288Bypxb25M1LdY3v2oP
 vJ2YhN8ymJmbHQPD9xIfG8rmtJC72lgpN0enN1O8U3Nguo534H5a9/eJSohnDmc6tA7K
 EhhGrvnPNJGVvRDJ57cvNr4TpQQQsXydaHFGz7FxxtznNWHXjVzd/l+L4Akqv0Sf2j9R
 v4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777288022; x=1777892822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QO+YMX5ksgG5zht7IUY/nYqzuFqNiuOUp+FXTuB0MzQ=;
 b=Q6T6I8C3dFuvnhi42PFc6ls1+F8cKxWISy6oHaUxZnW4Toi1jmIsxb9y9JiGbCJgHE
 t3P1PWLlpHFfWq7ATazcAUEv4xJbY9MV07WCafeRbwZk4J4HzMCAz6wdncLbYHwVHXul
 mVszHgjo8X/3+m64cPjUJdSQFdw9bu/wsxtpfcbJnHewnsa36HdDKnR7a4syiTClIiPf
 EAl8yu9KEmkAG6JiBubfHeFGLWFRnc7MPX7hNhY2SctdEQZDx2cFUv1npdFDb12llWmM
 WZC26P+KzhbXzc5wJfWbqxZhY3raqnmvb/WVwn7wyIEwuq4Fk5F4qTz3HitiTQWz2DsJ
 TOUA==
X-Gm-Message-State: AOJu0Yx7UGJthYg2hycl0NakaWrmKXLDl0wyUeILDEIRJ/rgWDuacWqs
 Tdzsij0ZY0BkP30RzLLWaUCp4LgEY7Czvcg2fKf0Y/O/lgW9nzwgG4EmxFev0K0fChM=
X-Gm-Gg: AeBDievNe0uZzZmFuQsR3JA7cmqmoeyLDSDneeCQXtVCWFMPWUhVW6boTOG1q8IgOVC
 inw00tY5K/rP+WH1i5qhewaeCX69flIndmIhTfsVlvRWY5q4cOZ0lzLULl/qskezNvPjEGKtXlv
 JCHjvvQreOdjtkLhWXJyd72m5QV76GairybAXhROsxrQEhU9GsQgjn9LQTDhcjkRKzn26jZJhzg
 7HK/DhfRWT0d/AxHKVz16JDNk/+deR3N1L5wh6/KEVSLHyTKut8exhnKWWRPXMQhBqBppuXOLzW
 GOszuaWNaXjeBXnKezg09BLW0hWVTyaz/WvakJVdwNsKkVUycKQWxrkNjjSSRkPLOrrTy70PP8z
 Rd6oTH0mAn53wAa5BjvEp078ZNsPDswGv57ulO+AhlLty0W1o06esFqKjryNLI7TcYOkFpE/cSj
 tRzWRYl6Qy1yUj1GROGAXO1pbJjMYjoF7L+CfYIGnL52R5Z3CAHvvbccTIk3RPJMTi6DyoVHZvN
 /7Q
X-Received: by 2002:a05:6000:4550:b0:441:37b5:d788 with SMTP id
 ffacd0b85a97d-44137b5d7c1mr9028199f8f.8.1777288022206; 
 Mon, 27 Apr 2026 04:07:02 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412e36ff8bsm30877308f8f.26.2026.04.27.04.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 04:07:01 -0700 (PDT)
Message-ID: <9a0a42c7-a36f-48d1-9eb1-008d2565c342@linaro.org>
Date: Mon, 27 Apr 2026 13:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/raspi4b: NOP all DTB nodes when removing
 unimplemented devices
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20260420162114.308519-1-osama.abdelkader@gmail.com>
 <CAFEAcA_29onASJ7bOs6jFbM9Mmj_X-SrJ85hSWxCOa-4WbFA8g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_29onASJ7bOs6jFbM9Mmj_X-SrJ85hSWxCOa-4WbFA8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 27/4/26 11:53, Peter Maydell wrote:
> On Mon, 20 Apr 2026 at 17:21, Osama Abdelkader
> <osama.abdelkader@gmail.com> wrote:
>>
>> fdt_node_offset_by_compatible(fdt, -1, compat) only finds the first match.
>> If the blob has more than one node with the same compatible string, extra
>> nodes will remain active. using the same loop as imx8mp-evk.c
>>
>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>> ---
> 
> I wondered about whether it would be worth abstracting this
> out into a helper function, but it looks like at the moment
> only this raspi code and the imx8mp-evk do this. If we get
> more places we want this we might do that, but not worth
> it for two.

IIRC you were first against the approach of "use a real world
dtb and patch it", recommending to "generate a dtb with what
we emulate"; and we merged that as 'temporary kludge until we
properly emulate the missing device'.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDAFCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGdtA-0006EG-N9; Tue, 13 Oct 2026 10:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGdt8-0006E0-EV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:53:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGdt6-0006VS-LY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:53:58 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c4649b3aaso1939058f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791903234; x=1792508034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g1ziTgQfJ6evq09KF+QC8/1SKU7c/zq2avmXKsEZLSQ=;
 b=ZEI5W/ziaKf6J1jMFcNW99+QsFUURj4jtHR3ILDLEZwfj7bl8CfKA/BWM7B13EYP+8
 4Doq13zk8OFEXF4UsmB45wmwVOAC2TKA6olWbWjG7rModBz9JteUPe/438ShC7kC8/uO
 mBaeGjAvhGgYoSJZfw0plnWCe5JHN0+WNpdQ1WL3G42mSBgEtxCzhaR5n9Ss/n4vMDY2
 6qx2rMpDGGFAv/Xo7QvCVbKAKKnI5Wd3mIhEIbOxm01eJ7raxzno9TABW5d1OhMu9CQ6
 yCKjEsQnTkJ7Z5PtNd8XWukdxRn8jTvtkwoidXteNUWMFTszfSc8QB3gRc1ELknwJ66l
 vuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791903234; x=1792508034;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g1ziTgQfJ6evq09KF+QC8/1SKU7c/zq2avmXKsEZLSQ=;
 b=PS/4pinXqhCthoimK/LXLMG77k5qoAoh+XGCADnS4ufy/Gv6lD3zFsayyl7SF1SCtR
 a2kaA0jCqX/LcW3B6qXgUEHOQPAVbGP6vEKQUZ2sQ5mOpfgiaMY0ABDf6mbgkTTaL37/
 jYufXnyf2maQBGsh9CXX8IS8Bp23+7Br46020YSkckt3iq3AS1tTzBPoDPcwpcXvdLdb
 aUKLPZgb+Yf6rOOkVjJc1SruC5N1KAgoG0vVwA2Nfh6iUQLekrTJC1uVvz2PrQkwYsrZ
 gY179iUf95xvoz/Pp7UfD6Md3672yH+9ePAlC4GqtvLf52D3lCYMwZP56lz7QLKuD3D5
 lAhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgBm1aQ+18ycJv0HJoj+I6vjssZ9EGIhFzCX1wYpTai7KRZ7Xi1iu+FXhUK81rzqUFMc/TPqaiCqkH@nongnu.org
X-Gm-Message-State: AFq9FYKPyYa6KSD7W/5fvrUeonmQ3jorAAVM+WK1xUXijH9i81k05F87
 pPs8BrTkHXzW0ud93RrfIhMSCQGEkzjyjv9ctHk72of+zn4JCWoMLRjnab+91tv3Yak=
X-Gm-Gg: AYBFou01ZsfIqFV42sKExWjomp56HfT7aJ5TJNzImSD9lG/pVAqqgjeQp3mTFadBDwm
 sLIG5frKuwhlSThlS/C9K00PGCFcjhPlXr4RCjR1Rd+2TxmF+JUjWrGGkTr3UziavKtlybwge7K
 NcXKWfxK9Az3zY1rCtGju9eHx9EdW1aXR/nwwf6Q2gK1kLcyammi3IcCWFUhONGC38UgUoddSHq
 llb5gq1P2awnFfcZVXAXCMCdQ6c6sk4lM5UO6bsLdfVw4xoibuL1zY8bFYWbPRkenkfNUcoreZB
 Z54x+clep506WCZPEL7KedKaKCDGm93SqH7sM49rQ8L3yIg+uoP9ZVeuEMcGfNvma83aGzH3Xeg
 l3IsdIyfeGcHEnpICM6+kxgrwbcGsXzSgFzKj5H1HroWCJ62Roe7on0Juy1cDcw8chRoy2ncDyQ
 xKEDWKuMOM7ZylIISVUH5yOF+myE1yk7+UI1/cN3SsMk81/6zeVPTi3Feys2TEFwv4oXryudqZu
 pRnX5Gar7fagOV1veWN6JO7YAQvCckreXUfH45Tf4VcK5eaZLXm3SNsZFIO0hJqANKscwo0Dw1W
X-Received: by 2002:adf:ed89:0:b0:48a:f320:dba0 with SMTP id
 ffacd0b85a97d-48dbace9e14mr18852489f8f.45.1791903231666; 
 Tue, 13 Oct 2026 07:53:51 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc506asm5934664f8f.47.2026.10.13.07.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 07:53:50 -0700 (PDT)
Message-ID: <1f1af018-8720-467e-8c8b-b4c19a0b9c5b@linaro.org>
Date: Tue, 13 Oct 2026 16:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common-user: Skip the identity map when qemu is loaded low
To: Rick Richard <rick@sloservers.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 imp@bsdimp.com, kevans@freebsd.org
References: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
 <cfeb85d4-57af-4aa5-a265-a6ac46cf1f22@linaro.org>
 <094898a9-b3fe-43f8-b335-c149ed8b0a96@sloservers.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <094898a9-b3fe-43f8-b335-c149ed8b0a96@sloservers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 10/11/26 08:10, Rick Richard wrote:
>> There should be no need for this at all.  The probe sequence should notice conflicting addresses and adjust.
>>
>> What's your failure case?
>>
>>
>> r~
> 
> You're right about that, but there's a less obvious case that falls
> through the cracks: programs loaded through ld.so. qemu only loads
> ld.so, so that's all the probe sees, and it picks guest_base 0. Then
> ld.so maps the real program at its fixed address, right on top of qemu.
> 
> An easy way to hit it is ldd on FreeBSD. In an aarch64 jail with the
> stock perl package:
> 
>    # ldd /usr/local/bin/perl
>    /usr/local/bin/perl:
>    ld-elf.so.1: /usr/local/bin/perl: mmap of entire address space failed: Cannot allocate memory

Mm, right.

> FreeBSD can't link static PIE, so qemu-*-static is always linked at
> 0x200000.

That's unfortunate.  We could explicitly link somewhere high in the 
address space, perhaps.  E.g.

   -Wl,--image-base,0x80000000000

?


r~


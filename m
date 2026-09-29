Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBB8CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSHo-0001bp-KT; Tue, 29 Sep 2026 03:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBSHl-0001ba-IP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:29:57 -0400
Received: from mail-ej2-x0f.google.com ([2a00:1450:4864:34::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBSHk-0004gl-35
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:29:57 -0400
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2af876539fso420876166b.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790666984; x=1791271784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UMJHGExU7xukH6YJxFgTk4NqLwvBo+DnDXaDfqLDP7s=;
 b=Y8Aju3WNV4N8fjPQaTYva62pJa6npP1dj+0kCZUsDBPGMApncwuUY8rrqZcrKFfky/
 rxIxh6aUn6r8NK1oO2cblGdvxPntstGfD2L3qQKtFCOeM6qct0EHUVUSBpNc+Y2Bt4wc
 lyphX7SJuNykYteIeOUZHoAv6HU0OYKCykazBR51vffgSy954MYz85SrZWLXcMFS7C6l
 OKpiS2lxIiApNAQhzD+/2Qk09CTadJwyPQZ9MxxBCw6SP4f5F3L0XYfALp8xDw4V/7yG
 Qmzj0oW6I7DBYVHulQ9cUs/Q+g1HquBphtMjLd6fEnFNAkcLTcZS4l0mYpIff5NY//Z+
 Ub+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666984; x=1791271784;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UMJHGExU7xukH6YJxFgTk4NqLwvBo+DnDXaDfqLDP7s=;
 b=byjhDwV2ud1kIzeJmmfmBHm13fQ3JWNiE7CFcR+9SXD3t3wTn+dpfee4cWRZi+0uoi
 fdgHH4mBvcwg0Xfc1HxLFXJ8+gIz0IC1bc0Lca17iZn3x8L5kZv4eHaa3OtUkmhsYQhn
 Sd8QpevhxW+TRGyx0i3rGpx6sm65zjXnV83mb167RckF0pHhipz2IPCly1aXpXh8E+TJ
 nGkmRx4c1J9SaltfXvlSkX5/ikpiLRIRJ5bAKMYOaQ3NIlMc1xLVW4/tPaweZ3TMawLV
 wIDS+037IQpNtgM2xid23jPXUwfR5SrB5r++kX4fjPVRgpSYxPJbv8oHa93ePsnC8l8g
 qQXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyb/YiOhZJOSXGF0eoni6PV454RzuEaahV57OW3ZCqvoV9ZNPMqA78jH+e5adrU8TnDy//0V8XQRoV@nongnu.org
X-Gm-Message-State: AFuF++lM+LXZjlY+cYzRgRZq3COh6lQ9ZBGp+72TCYB+gYSmVaYpc73v
 Fj9pFsQYhrtFVjrZ8azSqyWr9t7PMPg4DSndv574/vIhyhGz48hcD2sGPLWZUXnTjDY=
X-Gm-Gg: AYBFou1dnoDmgPr6cSuGvudNhN5rpBRg3pApX2D72QPDQz+E5bDbepo1cLgrxOdgOYQ
 9ZNAkcePb9Lh2Mkf5QiTdibjsq9i74MRrf/rzgAMEd/TcotGd3tmXd+cd4adMLPGe1OEGzhAQAq
 HVJQNpGHcHrE75PXTnzlE6WrkhBo/hgv1nuAidW9s6FAa8HIx6u3POQ/WOGcGf9TdHfKjnhiNRy
 c5EZ5WsA8LMsNI/eEfM/hkGoz/RkzibubSWYh1xvpaUSqGm+qZF8JUs+NHPpO+/5dy0FPeRvn3h
 LKClaEnaaooBMh8INdFgbqGDZhMClp2N0c2J93uZNCD8h2QtiRV/k1mximVqU2FNhT1CPlZdNAZ
 nmvaXl7hzN+P/W+rRYA0+4ZaRKCgmH+5WVGphVpLK+h0f/BUgkEtuFz08R85OnQw9GgsxtdWLXZ
 HSk5wQGc9PuZTE3EuLUVEhFPyizmtYN5XJ6xnzVkqMVIT5/lYGooa0NFhqluPiFW0SChUbNqCbJ
 VARbHro9u/hMEQYW3fN7DwReoJt14C5o765ekijKUBM+yG42mjhgBkunVH/CIcpFnuezg==
X-Received: by 2002:a17:907:3f19:b0:c29:3c21:ee69 with SMTP id
 a640c23a62f3a-c2ae9f3157dmr923075566b.23.1790666984417; 
 Tue, 29 Sep 2026 00:29:44 -0700 (PDT)
Received: from [192.168.1.39]
 (cpc91486-slou5-2-0-cust898.17-4.cable.virginm.net. [82.13.155.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2af4192b8asm532755666b.8.2026.09.29.00.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 00:29:43 -0700 (PDT)
Message-ID: <fd28137b-e3fb-4b28-8c45-b7be735a3487@linaro.org>
Date: Tue, 29 Sep 2026 08:29:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/30] target/i386/tcg: ignore VEX.L for unary scalar
 instructions
To: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
References: <20260928130228.877003-1-pbonzini@redhat.com>
 <20260928130228.877003-7-pbonzini@redhat.com>
 <CAGscdFvd5kzKM4DbkCm3EsBNTr5vmk6nCfQCP=bzTkZn+tcWdA@mail.gmail.com>
 <CABgObfa9ZucyDLFtfv+ShrKNq4uAD8YwUfJe+TYpYR2Rf4J5Lw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfa9ZucyDLFtfv+ShrKNq4uAD8YwUfJe+TYpYR2Rf4J5Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:34::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej2-x0f.google.com
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

On 9/29/26 06:29, Paolo Bonzini wrote:
> 
> 
> Il mar 29 set 2026, 04:22 Andrey Polivoda <apolivodaa433@gmail.com 
> <mailto:apolivodaa433@gmail.com>> ha scritto:
> 
>     Hi Paolo,
> 
>     In its current form, this patch makes VROUNDSS (and possibly other
>     instructions) use 256-bit operand size when VEX.L=1
> 
> 
> Thanks for the test case. I will take a look. The ordering of 
> validate_vex() and decode_op_*() is tricky, I should fix it once and for 
> all...

I take it I should discard this and expect another PR?


r~


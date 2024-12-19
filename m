Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78E7E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJhn-0001go-EJ; Thu, 19 Dec 2024 11:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOJhk-0001cl-V2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOJhj-0000tt-4V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so11181745e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734626929; x=1735231729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ocx7qdl0qz6hEaNGfL041PjZf18c8GiFLa5c3758680=;
 b=olc1AREWkkuKpZ5pMdTfKB7lk2ZsqTe2UTsFxS4H5pLscd/EnPf6NeVImyUXiYQ44I
 gs6mv1Bwx97QKiu6S3hCujNSQYnf9Ccwq2OlLvU8xKA1n0smcLqXiTxhF5W6pPAUajyT
 W+bEXuuVZiS04YO1vDD1OATKGZuPPN0z5qFJbi0TVMor4Yh69cPxH+XOYHGeRLqcZdCT
 i1Ha8Pb95tutc6vCRPZJyTXQ78sG/G6MZW6avT9xtWH43FeiLN/ZBXop8PhthgbtS2rY
 rwAfkrXiWWga5kfxMqWvYke1LyZ9LJz4Fsb9negLK6FVCmp3jjQiXnxYe4TtHWilwhD9
 cWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734626929; x=1735231729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ocx7qdl0qz6hEaNGfL041PjZf18c8GiFLa5c3758680=;
 b=clKk7ki1i0HiG0I1CTvCwJNGNmtQeSBImZy6X2Prz51iKGfxkLuuDJQ8WlLcDGhDIv
 b19f+3Dh0xLG6BXufq62Tpo4Jro/Oml/7P+k2icA6lSp0S0hAeHq0EhOlICoMmBPqWw4
 a4SYmDCI/De43/QcLDGB08crVLNmkMVhNNIJCHAGRgfE6vyJmiLoAFMbgQPWH4hM0rPx
 QZfK0ZKeN/ubYdvqE/1OqR/D4dOE2DPa2L3WWogvEjc7Fu11lOIJqdmDhVnYTC95+aJj
 X1RlOWK3l6RsaZWhg1pCLQRf3uCXDptVqAJpmxS0PoW1kma0l5e6UgJrJR3oXzxdvjON
 6PXQ==
X-Gm-Message-State: AOJu0YyQeUXN+iVDZp1vfwPR6d5ZS+EsKzjQsVY8Gy864PSFA7OHIqPO
 Cb3KJiSEpmcfV0RmSX5ZH4kb++2Zz7i7zs/7a0g6bU1APM/fb1ThpievIIa7D9c=
X-Gm-Gg: ASbGncuHaKoI0awJD963M911qrQ9/959abw6FpSjrnxpWGFoTn6zLWoMNLo53Dqy4nZ
 Ja55CyE3Gbw8x+qhc7dR+YjkyfTKjf0otstABIWfvspYEwJA8KLR8//QGLegOWGEDNs5dy5yYHj
 xv4tZswjcA1Q/9IOTRtlt2bbpxnZLp/kn9MmRXJUQQpyWfyOXGvLPWwZ2VJfmPmuZV3I2Je9Po0
 j09oC+HKI9edHDmmNsjvHmOkFi/LjmMtrOOS8htv7QmYg7W3q7gkHSvSAEMyMAr4/WGMSM=
X-Google-Smtp-Source: AGHT+IGj0+dl3hpqP/svNHShxAMf+modiwUI8vp+t5LRoEvZyg9OmFiQCFC6LF6uIdhQNwOEmiKTcg==
X-Received: by 2002:a05:6000:18a5:b0:388:c61d:43e4 with SMTP id
 ffacd0b85a97d-38a19b34c3cmr3579538f8f.45.1734626929306; 
 Thu, 19 Dec 2024 08:48:49 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm22684365e9.14.2024.12.19.08.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 08:48:48 -0800 (PST)
Message-ID: <2ae4799b-f78d-4fde-becb-9ee7f767e8f1@linaro.org>
Date: Thu, 19 Dec 2024 17:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] hw/misc/vmcoreinfo: Convert from QDev to plain
 Object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
References: <20241219153857.57450-1-philmd@linaro.org>
 <Z2RCaZrwjYSM3NpV@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z2RCaZrwjYSM3NpV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 19/12/24 16:57, Daniel P. Berrangé wrote:
> On Thu, Dec 19, 2024 at 04:38:47PM +0100, Philippe Mathieu-Daudé wrote:
>> No reason for vmcoreinfo to be based on QDev, since it
>> doesn't use any QDev API. Demote to plain Object.
> 
> I'm not especially convinced by that rationale, at least in the short
> term[1].
> 
> As a user of QEMU, I would tend to view -device  as being the way to
> create devices that are visible to the guest, and -object as being
> for dealing with host backends.

Hmm.

> vmcoreinfo is quite an unusal device, in that if only exists as a
> fwcfg field, but that's an internal impl detail from a user's POV,
> and it is still a guest visible device type.
> 
> So while it may not leverage QDev API, I still feel it is more of
> a fit for -device, than -object.  Is there any functional benefit
> to moving it to -object, that outweighs the disruption ?

No.

Patches 1-5 are still useful cleanups although.

> [1] I say "short term", because overall I'm of the opinion that
> -device, -machine, -cpu, -chardev, etc should not exist, and
> -object ought to be made capable of instantiating any type of
> object whatever subclass it might be. I doubt that will change
> any time in the forseeable future though, so it is more of a
> hypothetical point.

Agreed.



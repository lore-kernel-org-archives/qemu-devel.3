Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C321EE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZyn-0003sl-Rc; Thu, 12 Feb 2026 11:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqZyi-0003qI-Qa
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:55:46 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqZyf-0006Sg-GA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:55:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso30648f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770915340; x=1771520140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MXtJ2DprC7k7IvH08sMnquAvKkQNmWqEzT6RShD3v1w=;
 b=xiU/iYX6GiztqfAVl7iK1/QhUQnZaRG3Q0BC04RIm51XkxlqNP/7+pxbFPKnd0m+jl
 3/gYSDzF1HzX9ypwzcPooSJPFY6mF6aERW7U0lCjjoAHSZwpXPA8TPNa343N6lRB1yCt
 J1fTrheMbeoMQRoOm0h9C9fc+FtAaJkhXPcehqk8CYLeWtgCiMeziqgOKdMW9q2EhHsD
 Bz5pc1KjwcIZfqVI+8IbaC8ZcOBwl/L/nuxFu5sxWD5ufuRHA+pKbQSkF8MCDiq5/hgF
 YfVF/aSvm2S0xPie0MaByRLGbJXUZlZ3VQInC9wLIO/PaZjIHnn3KqEdg5MuVsHkt/2z
 BmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770915340; x=1771520140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MXtJ2DprC7k7IvH08sMnquAvKkQNmWqEzT6RShD3v1w=;
 b=QiayiMMFH3YF2RgJRQWrTGLVoZfhYluN/46Y+VP4Lqi7aKQEDGrpTSpha6Uxn8qC0S
 dmOIMSxoD/Lpr4CGcfUS93W8Y36XHIxbVWLo5TeXYi9+lCbG2bY5B+1Tc7CiVn6pC0ge
 D72v1x+euH2trDey2derMo8Q6Nf2Y1x0PlG4R5KEJ92y0qcs7KTrnVGqeAZS0bVdS7D2
 c6CgAoIRy6MoPybXuJvTr8/BluvCdsf3dd3pnh2gJtQQsIiWVUqvaYnJGttjA1a3dK8h
 DTub5n2PmkD6HmkpgyolX6wodBvTU98xg2rgReU2oqApayNSt75ijt0z+MP4YiwR946B
 Roxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS7cWtFweMFbTKKAX94CWEHd2a7mtZeE3MNKek+2j9go8Rxors31T5xb2rw2L2+OTh7EDq7BDPMqkI@nongnu.org
X-Gm-Message-State: AOJu0YzaUdiCSmMNkngmunmsOo46xhZgIm5kYgIdhPY8rtYhDU974cae
 E8fnnYTEvYwlpQL20FZnOjRHvOJhBDujbu0hUNna1Wj4AhKAOZYhNsWCCEyYwvIrXNk=
X-Gm-Gg: AZuq6aKskzn43WrmrIEUWlUgRQcoDolcpUManGyh+FbVn+WGqAsqjGALt+Go4RulVsf
 /2hlARTKWeXLY2Bpa3QCEj+PU4onrZHsE8E9B0i5chDKxcc2aAOgxHR7PKww+eoc0pQ/QG9+1L/
 ptxaV+7WFZ/7A/Y0xBgSWwdmXASk8e0f7md8lj2+BkvJyWAD8bFgVI1vQkPvtp7XrDD3jWt2BDN
 5TG6RodTZEKTJ6WFip5IzP6F8fW3QzqOejCBtP5PTgGoVwE6+qIBu68udQrV5ETLFuM2JZBmn6V
 VDsq8AzWYbDT0Zo2ZjZGdM44Wfa316t745qRYnLsw7Z+1L4yFjh/e865fDQFiFdLHoI7dS2vr1a
 LZX6cU3AVMeiRykF0PDswPAwKIUyj6363KrCY06BuHdVQbCane8GqfNe8WY0BvYDUkgvZ51gXV5
 alHwk5jaMdWSiqBAcWIDOhSQ93BZISx2HB0PnkB0aN+Qr4pFcz30gR2cJXxIjQ0TYqAA==
X-Received: by 2002:a05:6000:400f:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-4378e72c023mr5623912f8f.22.1770915339698; 
 Thu, 12 Feb 2026 08:55:39 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e39c6asm12811055f8f.28.2026.02.12.08.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 08:55:39 -0800 (PST)
Message-ID: <c0b9a373-ee95-43e9-9af4-428f19c54667@linaro.org>
Date: Thu, 12 Feb 2026 17:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/net/rocker: Don't assume h_proto is aligned in
 eth_strip_vlan_ex()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
 <20260212140917.1443253-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212140917.1443253-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 12/2/26 15:09, Peter Maydell wrote:
> In eth_strip_vlan_ex() we take a pointer to the eth_header h_proto
> field into a local uint16_t* variable, and then later in the function
> we dereference that pointer.  This isn't safe, because the eth_header
> struct may not be aligned, and if we mark the struct as QEMU_PACKED
> then gcc will complain about taking the address of a field in a
> packed struct.
> 
> Instead, make the local variable be a void* and use the appropriate
> functions for accessing 16 bits of possibly unaligned data through
> it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   net/eth.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


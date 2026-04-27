Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9916AFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHISu-0008Ls-DB; Mon, 27 Apr 2026 05:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHISr-0008KM-N6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:41:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHISq-0002w8-1A
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:41:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso71209345e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282874; x=1777887674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMNGl9OZtiqbwc4sjQUkQHzrDEnTqiS9nMOn1N2MCuc=;
 b=pSEL0xHYKnxhVMLYakOBNE2W4sIc23q+Y0ArvB0flfDtdmDABBTPdIQ7Y99er2JUUW
 s0TH51DIjsR5h4tbikIzksAg2rnVkJtE+SKeC+X/ftdUAai7g5cT5gtchyJN0cv+nLZC
 NDt34Y7bCMmuoPAN678YBCnUhgSPHR/IPwObt3O5cultViwsW7BpzFthYp3KClGXvEYN
 reNS0KGzFweZPq4ijRavpSxeXkiSqxK11KfrUo6zcvMoM/I5EqgRi+OBAWJ3SyllfzHu
 cZSoTs2eBK+Zm8GpKS/PQkJ0RW60tmcJIl44zheoxVV9Cu2zdRWnvN/nJ84aOIQ26g20
 tPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282874; x=1777887674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMNGl9OZtiqbwc4sjQUkQHzrDEnTqiS9nMOn1N2MCuc=;
 b=ZdedFWvSvLu/IWX3aOmV3wdwa+OoJ8RYw/zC+iG8/Aej2fdp3cHS7+vbW9gBNNxW6/
 T2g7Aiv66iwQ6g5pmP4skbr1b3A/X8dl6th7GrshaYKcs1AImTxeFyHt56oGGHJUD3UU
 BlAYa6+h2fTG8j6/UsX8R6uEOwBjlA/zZHjBQ20y76OIfgF6dufbAe+vahd61q22//Uw
 ySM5C/qnpw0QPwKcK1uEMHKwTZmE3gIZjxD9PLuXPUG1BPr3VoEUNOhb3U+C4NeO0Jum
 5TnUcy3t/2/hlkmVxwUVerHI0xoJSd2qLUzK19BijVoLuof9LQhYa+O/dRj74+tgJ+nV
 dcMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bQ16KuQ8hBqFAwwgiviulJcxbPf2ZgSNGrYZtgMhwFTQ4YnpPpoEiNRRdhb7qUL0xxpCzDRX98kNP@nongnu.org
X-Gm-Message-State: AOJu0Yx7Rwl6yL7/Va38p3uINplMYk4Up3f0V0/MOqhDqBUunWFyglX4
 7iJQG2yPDEAbSTcahwG+aq5vGhU3HCk9tzS2F89ZrgYxcQWfrlkSlFtswkw+Wf/h7qE=
X-Gm-Gg: AeBDiet3FOEsuCCAp/3ItW4vYL4Y7lblefrDuw+NZTHowjmMOYVI/8qGEB3gWwhsgjs
 NcOOHnOFRMzIqH/cXMmN62D3gGYw/nprjmrPDTY3mIHkiCfeiAuTRsrfIBck1hUZmHaMcxKhNEA
 LdfjnIcwhkMPShGgnqMDhXJ6D/qsVh2eRM+5k/qkG9RBt8V5E28qFrPkOls6XaNL59jW4LJC0S/
 uH+YJUbZY+XKTtavV/ES2lwk3csLlsK0O4yy8820Sq5d7JA7FBfBcck5isCCXh3BdilcIk1AZ5f
 lI099fuwab4gfvpEAnYgpbpPQJ0GQ3Dq6EkCZxP9H3pazQL3QLa5xjsc/06VudSSDWeLBuXR7nN
 h7YhSU6E0EZzueenUswu8I1PkO6IQ+tnqUPTgAT/5//lyM5H7lANNB4Xi47g26ykOqw4Rp1HCUl
 F/NLWNDkn07hZx2+wsSBmPHPrDedj03MtTEuIm89rj8TDNTiUGSOaWFGHCqGcLhvak0jiJ/mp6U
 gL2
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488fb765ab5mr601253345e9.14.1777282873900; 
 Mon, 27 Apr 2026 02:41:13 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a06f3sm284555235e9.22.2026.04.27.02.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:41:13 -0700 (PDT)
Message-ID: <cd61f9cc-f17f-4a94-b1ec-9504f6061589@linaro.org>
Date: Mon, 27 Apr 2026 11:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/84] fpu: Drop parts_mul
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_mul at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 26 +++++++++-----------------
>   1 file changed, 9 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


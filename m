Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEACFC9EF6
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 10:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypBm-0001mM-66; Sat, 07 Mar 2026 05:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vypBi-0001m2-C3
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:47:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vypBg-0007ek-U7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:47:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so4773005e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 02:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772880430; x=1773485230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=isdLDJCQVZHXmG7mJNX7dHW/cRzK89xzFUxb0Nd5BDg=;
 b=eo90yycoez7wwE6+qpTaJFxOkzGBKMnJOSwJYjnsAOFM1jT12Qx2QibwM9qKyCvqPs
 WEGavNLjHSAZO4MVrCAUxTFY2XgEy91TNHQR+nU/7hgucd0ULS9ArbCP7oqGQEgX4mvW
 EDUGwvlqfi9+C0GTV6AWi1FDtGwhTqmbcBwX6WfXtNWqLwqmHIvs660HU9mhbtYl0wBC
 K8u/rrCwOFJXvdcrhJ3/jecRhpl2TEQuBtxWH0GPIH/dDY31/VBeAOmRBgnxoUcdiCC1
 VfbKJagaY+yai6KF1XElBGhXyNhhZxCEoqKrP5MNww+ASIIK5foFCPy6wZobosqbfj+Y
 QPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772880430; x=1773485230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isdLDJCQVZHXmG7mJNX7dHW/cRzK89xzFUxb0Nd5BDg=;
 b=fTnrtlJl3mH8zpNvzE1erkD6QEq1L6U7qatQ1k3qUZN7MWiVS2KzAvqRtpkqdnr/w7
 x12FwOP3+qNsDk6F0rUD575X6aytp8RusIDISWhPsAqrQKXlTAG8oLoFuqlmZC5e0Myt
 rojQCPnfanGmhQbQG6mOLeEfbo5y8ZdKAh/23M8IB88go+XVF2/VTSRTW7U/EtMV2wvy
 qXVc7+nZQgTPVNhsSwpLVAWNV1+rYcCNrdLOVi1mkHq8CL/VWF/5Ill2+luHOlMJeFIh
 M31jdcESMtzSJdEGWLU/kDBp+VA90Mg1P7v39mIJya6x/VOXSJECKF2ImGwvCnsRwbJk
 KyRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoZL2n9CQy86vzRDPlEItrQtATGUGWyQ7EQ9NOZxXehnf1vvn6hRY5X2WxmB9cbFZ9XVarrSOI9ZC+@nongnu.org
X-Gm-Message-State: AOJu0YwchtHhm7K6XGXnEQQjg00imTy4x6lwLEvE/wYUXcdQPOpGD+L4
 B5ofE2uwz/QfAEFtOMtZo3tR8FCl4k5+efvoX+FMoUgqNCf6Z4rnC2PTxj1Y/ersLo0=
X-Gm-Gg: ATEYQzxysmLRZRgvOZZbXHYi1+/xxQOBLIiWXOX/z+W82IhbiLawxi7VMYTN85oUxXb
 KqksMo6jX/uXwcCH3HT1L+vI7FvBWSMYTJ3yod0cvdC5HvxRrY0aQfi7mjTKguGwTtAwmWKC2vE
 6FCZoz+pyzRqO1Fw3+Nr6SyY1wsEh8IvwRNHM3gIUBZLILgRnJo/71nH/1etvaRoNCnAtCak/DC
 G8ZnWoB4XVLVAS6vOFRG3e8AGi9O2w1FwEDXdzBgxdlzEBtUTWxQqRDlggAUFaVzoos4TOSUpY0
 hh07Veo01JGXjPogUYTi/b38eX8vl5q1AM1AkgbzxOP0gLN8S7o1gL9PKexXSFK8IGek7U+O9J3
 tgi+Xy3KxSmphglOQ1NmQX086JK8SjBbViZ1s9yrsDJF5dMhsnby9ENABVpN/VwcOLCfT5kb7As
 FkqOMGHqgn3RtNChTl/+4+CnFReDe004VKBKm1CUfYkCH1qIshCubx0oyBXAT9U8pfIQ==
X-Received: by 2002:a05:600c:6090:b0:485:303b:c50a with SMTP id
 5b1f17b1804b1-485303bc6c8mr15476205e9.13.1772880429595; 
 Sat, 07 Mar 2026 02:47:09 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad27dbsm154472845e9.2.2026.03.07.02.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 02:47:08 -0800 (PST)
Message-ID: <10a5c74e-436d-4017-b50a-f3ac3e9d0986@linaro.org>
Date: Sat, 7 Mar 2026 11:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/bbv.c: Check if file is NULL
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/3/26 04:22, Akihiko Odaki wrote:
> The file pointer can be NULL when e.g., opening the file failed.
> vcpu_interval_exec() already implements a NULL-pointer check, but
> plugin_exit() misses it. Handle the condition by adding the missing
> check to plugin_exit().
> 
> Fixes: 0d279bec0f14 ("contrib/plugins: Add a plugin to generate basic block vectors")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   contrib/plugins/bbv.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


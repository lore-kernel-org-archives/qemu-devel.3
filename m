Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0BFE6FE2F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbCr-0007jP-Ln; Fri, 06 Sep 2024 11:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbCp-0007hj-2v
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:03 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbCn-00089l-EF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:02 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d0d82e76aso46127766b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637739; x=1726242539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MxAu4x+k4FD4cpo7duQeRbaaZCQNcHX5481JGrp14OY=;
 b=aA4hmR95VfGR8CLylY131uFV24NUgyTCN4ks5LliX3q0puhl33yj113KY0Nb8Xc5zA
 JQgcStu9ppUfnd3nneFBAVkiyiXHWhqQz4Sbya40YcX2FaNRACcTPVbqsTWtYnKDh6IJ
 Yns3tkoJqk0pw4ha0prrbhA7yYY1EH7MT1an2gc7wg90qQzUizIXETTK22sKbKIEUva8
 41dG5/dLXD+HsP/7e75XsOLdWFRGcz4xntdS2ZMwz753WVmApmkqOnVxiy2GrqHzj29Z
 NQUUPKrfi+8b9NO6UZKtwfPZf5NgpXgRWz9rH2fsa+t5umQlOqaHcNzqDeEYT8vLbwfZ
 Mmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637739; x=1726242539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxAu4x+k4FD4cpo7duQeRbaaZCQNcHX5481JGrp14OY=;
 b=EHLqm/0o4maAMfup+23iNML0aAb+qEh/n6P2YnAg8H9+6sdNwIy+IG2SPA3izuLQRR
 w2Yfs5FGYN4E1nL+Q8x9zVYCfBQjYT5kDUnn+LMSKzQ0lGEdI5o+aXw8vx0Yk8Au9yjB
 Vk+i9RKsLjjsqlmHTDnzIuftdFlQJLdGRe/10vg18BnrPGVxJnOh7Ec+e75FzTrcLgvm
 9QvDiZw5uxkgZs9U5idGa3nKDUtnhleP4QngPo6GlLbZVw1mDO7afb2yy/xZaGYzbqXn
 RMykp4613C6U2NRdxQsl5v1RHnmkA5bqHuhLTGfE507yYUfB1v+A3qNDBLbtDIaLwL6Z
 n8mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5AmcN0BjwCdlUKE/vCjtynmR1YuN3MGmHI7+0Ho2zhAsxEt9oGB/hjDuDBRwOj93tOWIjicO/l9+l@nongnu.org
X-Gm-Message-State: AOJu0YybmN8Ic9WcEppM3g3iUvAwvNIoK6mPPzNWnaHpqCOGzYqlCWaE
 AD6hj4dgXcptVvHRJerqZNrFbcz/zFYQEtiCMvhjTyBDkfU3ladharqlusCs8Cc=
X-Google-Smtp-Source: AGHT+IHT/hoSFIX1Qt4UGJCJkcoIyoz5Jmn0PYCYOGFP2cz26IA5wwYyyMkxWjThMpYyP6pq+Gdu6w==
X-Received: by 2002:a17:907:7d8e:b0:a86:a6ee:7dad with SMTP id
 a640c23a62f3a-a897fa6edabmr1912982066b.52.1725637739162; 
 Fri, 06 Sep 2024 08:48:59 -0700 (PDT)
Received: from [192.168.254.175] (225.13.23.93.rev.sfr.net. [93.23.13.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d0c776239sm45105166b.64.2024.09.06.08.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 08:48:58 -0700 (PDT)
Message-ID: <4fefc5cc-9181-4fdc-92ce-01603f2d4f88@linaro.org>
Date: Fri, 6 Sep 2024 17:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tmp105: OS (one-shot) bit in configuration register
 always returns 0
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240906132912.3826089-1-linux@roeck-us.net>
 <20240906132912.3826089-3-linux@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906132912.3826089-3-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Guenter,

On 6/9/24 15:29, Guenter Roeck wrote:
> Per datasheet, "ONE-SHOT (OS)", the OS bit always returns 0 when reading
> the configuration register.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/sensor/tmp105.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index 77fbf2f8d3..22728798f7 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -133,7 +133,7 @@ static void tmp105_read(TMP105State *s)
>           break;
>   
>       case TMP105_REG_CONFIG:
> -        s->buf[s->len++] = s->config;
> +        s->buf[s->len++] = s->config & 0x7f;

LGTM but I'll post an alternative v2 clearing the bit in
the WRITE path.

>           break;
>   
>       case TMP105_REG_T_LOW:



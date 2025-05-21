Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA00AC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHsIj-0000oh-Ew; Wed, 21 May 2025 18:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsIh-0000oS-1W
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:52:39 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsIf-0008VS-2Z
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:52:38 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so5502026a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867955; x=1748472755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmU26Oa6PRLSvLrU40jiBOoyh8LZIA7Nltq9z3yPoZA=;
 b=Yp8hnXPqHd4dNkMDz4WjbW5wccWnqOKpQxMfZMgLXcYvZsvlGiei9y6zgUW8N5y5yO
 epr7dbjQQnm4km93hycKPNSkDjfatkgcBHr4v2VncWZPGtsfTmIBS/FzB+DL9T6eF/tx
 tUtWBd1OCblpHAEEPXpfINs9WOcdHEqGogTyLF2OKj0neTFZGEMOfHmgthkOVpLltWHe
 GtYYGe4zX/4FD6RcAVR/X4B5dK3/JKuX6qBaTlqa/NrZPan/Rmyeh405tMdKiogQEQBs
 qPtMr6NKD4ci6k39VohRFYbpp5GSfOdbd/leJ9jG3g0cBMoPQRyaefWtx6PyW3V461zK
 P6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867955; x=1748472755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmU26Oa6PRLSvLrU40jiBOoyh8LZIA7Nltq9z3yPoZA=;
 b=OTUUHI3rW0Fi0tVlbqa5J5G2b+ldMJSMxKtOUROFkyKzKjfiY4juaeTisI6aHrgNse
 OJwr7yD2wlVafCwZ5GvYD/qRQSypnwF89aomctfLiOmU8kl54nFiyY2j+ASmAUaGFYiT
 WYhz//VuzKHAgwjXQVFAcFODPfU94/7tM5lmCxWsT5PrC2GjH6t1opP9tccsI3WkRS4I
 qYU/7YLA29RRYp98p8BDyVSsc5EIQ5mqOpujJKBtvEujOZj3GsOUIBSGSSooFpi8Xv+y
 LNZjpxSvz03GTbpj2G3Ovmw118kf7FutkaynxVXIDOH6nqXLfG9Hl1U1vzlfNWX3TgVo
 aP6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+WVWUiDZye1fsdLaZ5+fnPVPrmrK2UATevO8Grz7scnl5wfXfQM3PMkQjC+9Drm5mzcwnjRxV50XF@nongnu.org
X-Gm-Message-State: AOJu0YwLjqIv+NfdsODl/7X3z+vm1pOyzyW+ljfL5foEOuWFMtTBGua4
 /mjVAg6nBzI8iqbSSjlKVuPViWra/vOp+8BZeG+5iDQ33KQY6IhnDFG2vHlAbKNHzoc=
X-Gm-Gg: ASbGnctLI7WtqIrcRvUQsGN3307274LX8O+ioxxqBqkY1jhc59OCHBMS7NTpBYH4X1j
 Up8lNaJu94SvjfoNY6DC8GxjVaKNAzCrue3kgFFae2B8582lYjAg09x/eqKIA5nWgMvhFsLNDWR
 mH6rWAAhqi0xUbS8uLhizyMB2f7vndBoABg4e3V4DCD1e+GfFWUBvDqNCoh4+zr99Md08r85RPv
 EgxVk15dIOP5pUQjcHowMdU5xqKmFOIOJ0ljK6dvRuWAGVxiA0LiKRR7xNIdCFdkJJS7Mu21YNS
 ns+VE/jYYRIg2SZt42eb1Ddqr0q6XxES/e4tpRbDNOS7cMJnUBrr8bQVUOMv+Mea
X-Google-Smtp-Source: AGHT+IEtfjmw2Lg9K1V4ZO264WReWCv/Nfay8rOK6OrRbpRIfsomB0sUyiypQraDC6n2PMFfyec7Bw==
X-Received: by 2002:a17:903:4b4b:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-231d45327d9mr325942475ad.39.1747867955411; 
 Wed, 21 May 2025 15:52:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed5683sm97856185ad.245.2025.05.21.15.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 15:52:35 -0700 (PDT)
Message-ID: <81a337b0-6799-4097-8583-ee83886a81b1@linaro.org>
Date: Wed, 21 May 2025 15:52:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] Add register write API
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-3-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250521094333.4075796-3-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/21/25 2:43 AM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h | 57 +++++++++++++++++++++++++-------------
>   plugins/api.c              | 26 ++++++++++++-----
>   2 files changed, 56 insertions(+), 27 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



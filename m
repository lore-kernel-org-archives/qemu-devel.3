Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA59C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspcf-0000K1-Ck; Thu, 13 Mar 2025 16:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspcb-0000JV-PK
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:57:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspcZ-0005os-Jj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:57:41 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224171d6826so35452135ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899458; x=1742504258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u9QXtXB6VbUcBhlOMxoLdgq6H/h6a8Q+yod+z7qcYQU=;
 b=srj4/4LmU3GByvsNl1dFQun1BYGKIKqqqaIqHUekSyiCyVTaOR4m7PidWDCjVhx/9q
 yrQhq+6nMHQ6Rj84W2s8bZUjG8BIAlB917EIhVT9g+X8rSaXUVr5eVFMPL3TR5hNyW/u
 ig5x+skaH/uDm6l+2sQy2FMHCm+paoKA/+JBb+bWyUjyM1i8drYz5ggxdujmrvWZBHKR
 F8JIaJgmK0LbZ/cg6XHWTDw9KL4aE6jlg1RAP9tezJrm9DVN9/1B7zPlfsG3HizMh/3Z
 S4Aojqm+lInZ/yi5g2wL6kJpajEWZfqNUiRcWu97mbNeHvKi8+eLdKW4RKBH/4aZV9xA
 uUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899458; x=1742504258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u9QXtXB6VbUcBhlOMxoLdgq6H/h6a8Q+yod+z7qcYQU=;
 b=VX0Yvdi1ZoFMYeLieAcIH8Vmhv7wj4zvGn8P8BqFaEUlglMGH83GGN/6BH3IfAtDJn
 FAyFbDsxJthNWhPi8M0uJ8l0lsf6oG+Nba1eYfccrEK4HnYPb6XD2Ykbq1W0PDnLmh02
 o1ZF/jrdi6FauuKJ8qefL8niI6k8UCGKzkSU0V9JcN38xeNfG2zWYGKeO8+PUZwHSLEb
 WOIPPK+4pSVtBDS0+f0QotQaH525FtMGNePGbrfuMdjk1tefpafwNA1KGfWYVtrftbCx
 yvTc5+v8r6jfvWPju/A62shOwkJ3tVebbiESEH4YpWKvCoE43A6gpCcKfyrRJPxfqkOQ
 68IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe+aLwzW+91U8r0RjJtc0E0Yh3PMVtX5yZNE2zsrQonv1guAMK5d16ie75gxNT6CoZ8++e8UwJLc2M@nongnu.org
X-Gm-Message-State: AOJu0Yway/h384jJZH4J/HlGVB+oONNfcz2w11G/N9Hnx4F3lg7pQl94
 fslzkB065zeAG+ql3nFzl9KZOVVq52rrHMOvfgDDPOyS+OorjbR7P/nvqHPUF9Y=
X-Gm-Gg: ASbGncs/Jg85tnsT0/kKCIEjvR20O1x+qsg+Bsy82xGGQuCG2GkX3eGEQety82+OiId
 bYn+wXHnAZ/KDnNa3Q53V1p2/dBf8Z06bgHSJ/WlNlmkS4rr5wc2HHFcDz/9lR2lDS8Cqcw1Zk+
 +hjIOZ5UG3tpMvZOLkS6VqGZF/lO1N0FNTCrYfFVG3HqgpzJghnxAqp3VlzW7EO4eWGA3X+++lb
 LRc3Xyzx164Oj8OT1mqrlAriQF1SYMKmlLXNxLcCv7g4wIMvm/uQTxfO6M1jceLrruYhrYYotIz
 Ew/dLR2/n1GUZlLj000p4UTH7zK6ThqjbkCWlrNQTG22tmRMHaLR518UYQ==
X-Google-Smtp-Source: AGHT+IGO8bL0/HREMbOQf6SPj1oQlc/4XQBeftX27+ql6Duk/ryJVMRm1x3DcpEPjHoncR6jpPzB3g==
X-Received: by 2002:a17:903:1b63:b0:223:fabd:4f76 with SMTP id
 d9443c01a7336-225e0ac54e5mr497115ad.30.1741899457923; 
 Thu, 13 Mar 2025 13:57:37 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a80d6sm17989685ad.87.2025.03.13.13.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:57:37 -0700 (PDT)
Message-ID: <9958d68d-596c-4be2-8fa8-f2932b773616@linaro.org>
Date: Thu, 13 Mar 2025 13:57:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/37] hw/core: Move unconditional files to libsystem_ss, 
 libuser_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-27-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Many of the headers used by these require CONFIG_USER_ONLY.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/core/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index b5a545a0ed..547de6527c 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -26,7 +26,7 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
>   system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
>   system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
>   
> -system_ss.add(files(
> +libsystem_ss.add(files(
>     'cpu-system.c',
>     'fw-path-provider.c',
>     'gpio.c',
> @@ -46,7 +46,7 @@ system_ss.add(files(
>     'vm-change-state-handler.c',
>     'clock-vmstate.c',
>   ))
> -user_ss.add(files(
> +libuser_ss.add(files(
>     'cpu-user.c',
>     'qdev-user.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



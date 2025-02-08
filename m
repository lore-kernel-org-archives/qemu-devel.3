Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F97C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgnuj-0006en-TQ; Sat, 08 Feb 2025 11:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnuY-0006cw-6f
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:42:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnuU-000235-AS
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:42:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-439307d83f0so3009845e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032944; x=1739637744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mqNv7S0RvDecic6Mv+yL2o6y3+g+p/FibkLTtSD0X28=;
 b=FCdhAhftPJMMiL0yXrdC4Ty8ZRerK1CPpTwx51PmBrcaWwUkVRJy28uEdYF9ICwkix
 d/ZUZG2PId3es6Z1Sk6H9vjDH7ohDn9v4Er5diKVjhz69l2JeWoURm0S+G1gtuoJoA+1
 Kms+XAGg5YLZ/a8qKW4jZYSB8wLcIK/6DxfL7RaJbzmlDwDuSOi++x/HXh+R0AekS9MK
 incaoh9rG994USAqf5RKuqxykSbszJMFOz8S8NYZRDgz3vxTg6JeBSSWyIMVRzQQPP4t
 pJM4Lnl6w5A28c9esjL7AWJMWxXNDiiaA6SA1VaPJBVZITnqP4rNWoGj+mXMItPBduN6
 TFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032944; x=1739637744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mqNv7S0RvDecic6Mv+yL2o6y3+g+p/FibkLTtSD0X28=;
 b=IgpbXgP/RxwzgQXQyiIMKwNiCkWUDFUx238Lqp57yG4ZBCQxo6ejKgkIpToMyq2VvW
 WOOVTCw6T3xRIE6NB28Z9Rwp1XeodMN5Scdw1jvVCTOYE/Kc1cnOebGlddxwpNoFE1Lh
 iwNCJRoDSDox/Jvima4zXscqb8Y18LUlHH9oADblLJmnNVB5l61mUAw7CyTc9qhq/5iN
 sJmiWxlNEuAH3ze9ah+RfRHrEGDoCX5SFpqzpxONxhliDcuNaqk23yGRP6DPyja4Vtfx
 0OdvOadVcG5dwdt33/8f4Or82HNELtJCsqJQONZpKn125DUMmvR/F+gthv2QG1++FXKP
 I5nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkTrUjSeuuVJdoh6FiBAg8ePuARxAw9MmJDmDst5guejJ6UX3nKTHIlBNbQ5FunWHrBwWoXdhrrFOQ@nongnu.org
X-Gm-Message-State: AOJu0YzIIe4KsUmV3Lm3YIpmN4O4IrcsAttdug8NEWYynx+cu/xJQ7tO
 C96b1HuaGQxIroizPnBbDwHrBOo9X3tXG+U10eRUrPXT5BtuO8GkROT3HlYg9/33aXuJ1uTIRMd
 Swww=
X-Gm-Gg: ASbGnctKdGAnXxeh0DcSZzxGbHuUUd1wuF7LTYHbWRSMVPGtP/33Mq1Dvn3zLI+Jtmm
 bYak0hdwHgdxnpton4p/iYo7WKiEuC6B0VxQmXroH7WB3jH1514EULE5AD91pRNmr4EueemiQ0g
 rM24vXRid8YZZmJWP4hKSG2PdW0oT2ANcBLLlW1W2MsNiz2QRJJM8tQya9YrtU6WTo+HRXXiHba
 VoKH8L+Y0ir8xhniq7LAb+VLCmWcHWoCLvD3b57VGKJVAk5IE3f6ZzF7O+NIyO0sYqgRRoQmcD+
 MTajL2LwViRVUvk0x555PlHyyxp6wa2uduaMxe9hMn6FCAsIfGThw5H8Nu4=
X-Google-Smtp-Source: AGHT+IEll/R0H9RcE18LU8r0yOcPvttnkPy4j3/jGuBTIp5yzAlRmQCORFFfe0TOIy1kC+T8VvwTxg==
X-Received: by 2002:a5d:420f:0:b0:382:51ae:7569 with SMTP id
 ffacd0b85a97d-38dc9104440mr3945229f8f.18.1739032944212; 
 Sat, 08 Feb 2025 08:42:24 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd36967sm7577510f8f.37.2025.02.08.08.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Feb 2025 08:42:23 -0800 (PST)
Message-ID: <73674902-bfac-45ca-ba63-5aafe66dbc80@linaro.org>
Date: Sat, 8 Feb 2025 17:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] meson: Disallow 64-bit on 32-bit emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250207210655.16717-1-richard.henderson@linaro.org>
 <20250207210655.16717-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207210655.16717-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 7/2/25 22:06, Richard Henderson wrote:
> For system mode, we can rarely support the amount of RAM that
> the guest requires. TCG emulation is restricted to round-robin
> mode, which solves many of the atomicity issues, but not those
> associated with virtio.  In any case, round-robin does nothing
> to help the speed of emulation.
> 
> For user mode, most emulation does not succeed at all.  Most
> of the time we cannot even load 64-bit non-PIE binaries due
> to lack of a 64-bit address space.  Threads are run in
> parallel, not round-robin, which means that atomicity
> is not handled.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



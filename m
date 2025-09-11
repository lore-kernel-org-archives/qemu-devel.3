Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B4ACA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 08:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwd6B-0005vS-A7; Thu, 11 Sep 2025 04:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwd68-0005uw-4v
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:56:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwd65-0005Vw-GT
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:56:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45df656889cso2957935e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 01:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757580960; x=1758185760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ufL5kzR48TLp53LD2iMyxiecCeDSmoGA8NSO3NMuspE=;
 b=LWVV9u5q98nrhCnhqw90yrTH/Hc5qJpNlfQp5+grMwR4o8tQgCm7GsQSmxmP4jID0G
 xRP2s2OajNR0b4Qmp4nt5NKtNw4ta/oaeD7RInq1EGRt0/h3Aj3YS2ctUAQGhdg1efiJ
 bRk12ihCifQI8MhTo489k3TnCm/ta5G07BAno2HPBq5Kxkz94QHoEppIwGIoavULIJSa
 WJAu64cUO3dg4Pa/bSgKfEl3W/FJDWwk6FSpHHMLyTA/Hx1rvefrwNvFzF2nqKOROi5o
 NcUq3Wy30+er7M3L5wIAwd2HDxrnmD2QfXq4YsihjFnQ6qs9Yqr5N2/S9fKh2zyBq6Ih
 N2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757580960; x=1758185760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufL5kzR48TLp53LD2iMyxiecCeDSmoGA8NSO3NMuspE=;
 b=smfgULeatK3pVXXt2iXkH3AXWBw/iJaLZi/DhDPTAx3p8UDKRHHcyTJdwggFypa0HN
 gfAGEOd3JuinLpBRLR8bkJQYlhHlM/KuNUzzIJkUbX0GOpNRq1jTC+rXLHiSUsodN3wf
 qkRNCb7mT1hqslmSzGS3HjFK31naeyvCLujRWhZuqa/eqPms0BCPyUS0AssYjLFgFYn7
 EH11nEAT8SOKtxWY6KQo56Njiv2t5t5cwo858IuqDGja2epG+G9rVZRXvWh4W2n2Q+DT
 HyOOz0KfzQPiuoanb9ly1/e8s/BZO/4eNTVxNyXiK3HFLvQ5rH/N6LGcbsPhOL60r5rX
 yXgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZwNzIJs2+9l8i7FbMY6eD6JClfUd9BRXALSXpygfFWm97FZaIB4cNtbQZYMb8IJnpo7UWkaTrEVMm@nongnu.org
X-Gm-Message-State: AOJu0YxPgJ7zyty0fEKu/+vgMDqgyEVA9S5KkLp5qsl8+Dry4PdOl6bp
 yrtOqcuYbxiOmz9NiV3uH2m+AdP6O7IciuHaxZPzswjqCtye6hbS7Z+wr59jFWF+3KU=
X-Gm-Gg: ASbGnctABNWnoDkbqbsxHVGmjO63xAlmeqDBJ4g13cFvgMWFaFusli+b30kfOFlUHtL
 mHS0610ONuAj55Ni1/l8snJjsINhMVAw7WZRZCDv9nDnMlzIjIdlcR0pUvE2nnyB51P0fptuRqC
 W+bZJvxqZZbqYluwR2g657hhTcjXa7U99jaKXcMFhEMh5zTIg7Rzm7EqAIRHrKLNh3W/wzp/vNz
 kK3+nE2U6ziBCG4qEm4SieJ8ex7SotPN6iREwiow/oHGJ4IVm8mnXf5TUVtMrLzstdY7kyShsnM
 gIJC3O+Uh+jeUUKfFDp+ei/VL1WFAoYA1T9Iq03LOEfV/7dDGCrOe6nxX8DMKS4GDpt4wPWB9xD
 D67AQL6Qyyx0rtwazQ/XEDkp4ugXtbgs+IENnAtiSpSZoStU=
X-Google-Smtp-Source: AGHT+IGNuBr4UL3ohUskIJDofp/ZsQFwxQo+Szt0Ew2m+U0+M+eGzRA+MhLrrUykCfE5I+KupLUaXQ==
X-Received: by 2002:a05:600c:45cd:b0:45c:8e6d:a45f with SMTP id
 5b1f17b1804b1-45ddde868a2mr168413755e9.5.1757580960444; 
 Thu, 11 Sep 2025 01:56:00 -0700 (PDT)
Received: from [10.20.51.75] ([88.149.120.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5a16sm18618855e9.12.2025.09.11.01.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 01:56:00 -0700 (PDT)
Message-ID: <e91895dd-3468-4a9f-8f66-85452143e6e0@linaro.org>
Date: Thu, 11 Sep 2025 08:51:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/20] ui/vnc: remove use of error_printf_unless_qmp()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-10-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> The error_printf_unless_qmp() will print to the monitor if the current
> one is HMP, if it is QMP nothing will be printed, otherwise stderr
> will be used.
> 
> This scenario is easily handled by checking !monitor_cur_is_qmp() and
> then calling the error_printf() function.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   ui/vnc.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


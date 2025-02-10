Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FD8C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWgj-0000RK-Uv; Mon, 10 Feb 2025 11:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWgW-0000OU-1u
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:31:03 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWgT-0004I7-WA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:30:59 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f4a4fbb35so59121305ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205056; x=1739809856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uRZw297lOi4e+9Bab3RSIo8PWSK2aFRQ3o8MfjipIs8=;
 b=Pj5u5ZzIWLbzGzz6qAhGciP8hsWG+fRW2qjFuSsATFVjHb/iEcakAaYMRcpD171Wcw
 R+JxsLGm7KZcQ+8JBEnsnJqKG6afKj86Zn0b1bY41EpkqznQleYxYyBRHSTnhG/I/H5m
 03MiC6k/xfJVusDZ42bu8zqmvlKtXPVy9GNfn/hIWp47lkx6+aA8kFdYEd9DQ/tSIHVG
 kIyTAAsTCx0LxsxYl8HtXvjFFCxesBZczUqKmyGiLoqjvcht8xR9sP+h/JZi6oyTBjdj
 zBQxrmXwf2ZXulgL4RVGfiTNpxqlwzw4JYci9Fc3+TLdNcdz/4Dry/3z+AXhmwhcrj47
 7QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205056; x=1739809856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uRZw297lOi4e+9Bab3RSIo8PWSK2aFRQ3o8MfjipIs8=;
 b=F3LZtLJcS3SfH9cbIvneu0a716TL4Dc5zu4mn2ldrFpzjh2x5n7o2oDFj6F97R1R+P
 1GNilCabJeO2vGYxKvlr/kaTBbFPWoUZowfhhbgvD2vyiV0ovgvd2GY913RaLsH+OM6Y
 Kq4RS04mXaytLnZd8Od3XuH6iWvT/tcPX3WpY2RXpZqhWUdfu4fxJ/o0grK3ZPpa6u/a
 3REhqj4QtP6ayT/GzqD1I8gFfjqpDCpWI9tUkk1vlPANOnG94zhnONDxTb9Q5hzQwBRU
 9bd+vBfUn74uRfOwXdZcnOMKxpI08WBwSE2YilE9CrqQ5iO47Tu5XQLPdereJ8ipy43e
 9+LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN8/ooKuT+n367G8QO7Xtxub/xTUdiO35sck02cuhyFmsNfwM+YA+G0ECchYW2YixzbAdx0McO5fDk@nongnu.org
X-Gm-Message-State: AOJu0Ywf3h+JjzhF/F3TWSphPDbbY5kEmtvzm6/FEooDejLTtGlL4Vps
 GJq1D+PPre/wNlTTEU0CKCCpxaggt1B6FAcPfGkXCUOB/DpDTLb+s6jO6cs1D2A=
X-Gm-Gg: ASbGnctxC7Q2RcwU9EElTc7JkG+4vgA1XzNcPPzbYYSYxKPg6hLYKtDca7aVEtk7Sek
 SJGrkEA+DvuXjEKSBhNHht50sX2sfmO4RBdwxftJ9Q5TSGPO01ulVBeTzwyxT0MPxF5o/5UGKuQ
 dzBuBOqFKeqRqG0/D5Dm04buJrEQweRGlkYJ0ujgWtG5Fjx93gCvMALwCCzNLlnFreJnSWC7VpT
 qh6ZyBpoKMvKx2kCGEGgdBce685b4XUiqrGrzndYpRMwc3KNSYN9hyAMyEosAV6k8x3aAtygaA4
 VGL7yc7JBsFOPdZ/HwF7IyYyHuvP9bjH174YTDxoGEoxglFyCC9vGtY=
X-Google-Smtp-Source: AGHT+IEtz9Be2/Cjap06xFlr8tSZi9X90szF/jfEj6Y+GUZt0SBkWj2Q4SrdqHpJBo77d7h+WAgz9Q==
X-Received: by 2002:a17:902:f68d:b0:21f:97c3:f885 with SMTP id
 d9443c01a7336-21f97c3fa25mr77252415ad.18.1739205056434; 
 Mon, 10 Feb 2025 08:30:56 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3650e63fsm81069205ad.41.2025.02.10.08.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:30:56 -0800 (PST)
Message-ID: <526984ce-6bee-49b5-aebd-0ab4c391efb4@linaro.org>
Date: Mon, 10 Feb 2025 08:30:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] target/xtensa: Finalize config in
 xtensa_register_core()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Make XtensaConfigList::config not const. Only modify
> XtensaConfig within xtensa_register_core(), when the
> class is registered, not when it is initialized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   target/xtensa/cpu.h    | 2 +-
>   target/xtensa/helper.c | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E8EE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKBw-0004mz-9W; Thu, 19 Dec 2024 12:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKBu-0004jB-F9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:20:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKBs-0007F8-Ow
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:20:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso11796955e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628798; x=1735233598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDK9vfiG8Km+OJ6ct7UgwTsWMDBnASNJPKjCnXxZJYc=;
 b=ESHgRhSTQPEKKlInubHvdMr9J2dwge7Dyb3p2OZ7cARUnKXEl2oO2Ops7eNImEHwZb
 Oz4QKVv0yBIme0kMvujc2syONfjV8O8DZM+wLo3CYje4xlYZ3XYkxtWOT3+wxbhyaiua
 QnpwR/3hUQLTZANt4GM4EXMu3ItsokVymagkv8RHT0v/xCapBHraqLnzThG9pxoGUoG/
 AAH+xHkDMV8ELBdPu2OqAbkf9COgE/+bBXfzgJJ1LuY5dhA3JeGzPrHT/RibnTsRLVbx
 nQcG/AYB8VqGr8DDuI+VrITCXCXBSlwvEiy0PnQAaLMl8WgOYc+v6FwwbZ/peIFMZQgu
 0cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628798; x=1735233598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yDK9vfiG8Km+OJ6ct7UgwTsWMDBnASNJPKjCnXxZJYc=;
 b=p+LA4pknUobjjFWI/Qprq0vWuPYMVzzU4dTVdqS7SPSBgAqbfKx+CEnaI8UzcTNmGY
 Uf9ikbze9q5Er8emZIUMAPbvto9nt0+JGLFYH4VMTxBVPiCYFrm1RLh34FjR1zWYpV8D
 CQvVeNafVu7spQ17a9JtqZg0/j3bvNsdI7K+YzZZaezoFrHHceRuz+koM9+xdkDc/7Gw
 qtbPoz+8ld56vtRnnHbluqetl6rXFbb7sO09QM/rMHMPtFbvaUwJRdTpCX+6b+yqxG1J
 B4zwbhq/d0wbSrpysibEFXZ5ZcWgIxSH0Rohi6ZyJT1CR+s2uYJLZcF9HQD2Ur1r9Scd
 wCZg==
X-Gm-Message-State: AOJu0YzO2u2aRvQKV0E2gzS8d/DLWOvkJ+ZZKliqa4DTZgdmdxIj6TSI
 TmFUJgoE5r4gnYL3KhPVAfa8Rzr+OAP7NC28iqkl2V7KIfKoKUIM5kXwWosNoSviKSl3hO1xtLu
 v
X-Gm-Gg: ASbGnct1KWXlxGEZ7SFJKgoSLd0jKrp38W/P1SHcxk6pHwwxrQwIvt3XhKFJgRWUC1E
 5mtCOg98oPEI3QiHTdnjEhpq5/XBtYb6J280emYXjAg/YyTXrEFm0Aih2V7fcB5HNCBn+Wq9BA+
 C3o1piP4fGxp6I0crMBUnVk64UpE1tXzpJQQqEbuVhv8vJB5qrQWrzouMca9apFbPw6tWjkVgns
 vZ4c8fWtjB67ZwGxZvnq8HTk1D4VheZT6L133N2vCmM+/SrAj02GL0QUoIF5H63xdr8W40=
X-Google-Smtp-Source: AGHT+IE4tXweFegvug2jnPyDJ/MoEGONQNYh3x+um9urrO3Ih+3/ta9zXO0jgqWl8AjMJxeffDem4g==
X-Received: by 2002:a05:600c:350b:b0:435:306:e5e0 with SMTP id
 5b1f17b1804b1-436664aba1bmr184035e9.23.1734628798417; 
 Thu, 19 Dec 2024 09:19:58 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc762sm23354185e9.11.2024.12.19.09.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:19:57 -0800 (PST)
Message-ID: <528b49be-2378-4220-9db8-c0aa5c3101e8@linaro.org>
Date: Thu, 19 Dec 2024 18:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Really restrict cpu_io_recompile() to system
 emulation
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241216160514.56630-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216160514.56630-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 16/12/24 17:05, Philippe Mathieu-Daudé wrote:
> Commit 38fc4b11e03 ("accel/tcg: Restrict cpu_io_recompile() to
> system emulation") inadvertently restricted cpu_io_recompile()
> to SoftMMU. Correct to restrict to system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20241212185341.2857-11-philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued.


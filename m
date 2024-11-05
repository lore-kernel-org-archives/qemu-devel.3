Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADD8D2C114
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Ks8-0006O9-Em; Tue, 05 Nov 2024 09:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Ks5-0006NM-Cz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:49:29 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Ks3-0007li-Re
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:49:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so43859955e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730818166; x=1731422966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mX+AUT7H1Epn/JgIn3upkdb4Wok+TH2lCVVC7q4I4BA=;
 b=XesvGVc7KD3Qrc2I3nqRjnhcGo6gH+XPL3rSqDQmm66ADjI48wNE+esrBozK9McjBT
 /mFdOc1s4IO+OEZfner124RszpBYQLO13yybisDnQmSlOBRZrZTc79xkKLOWYw5Z5bLZ
 ph8F498vc8IHdtmhe8Pn3OtUtbZ9IP+r93kz40BmnIl4ke4qwqOwu2Q5wPuglG47dafu
 x2TaqhjycdGYvfmEZkdL1U9Nm/MAszepR372Aw14dmk4HtgPbUvqhb42ZJ+D3iLH0ec0
 h6aw5q8cXuqNTw/aIFzAjcfckRvOxUNZ9DvuJAcScfSCoeCWU9bndpzfU2L3A/uFacbn
 toRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730818166; x=1731422966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mX+AUT7H1Epn/JgIn3upkdb4Wok+TH2lCVVC7q4I4BA=;
 b=IATcpoP5Spxeqaelq0rmbKd7CQ1X9XiAg2M7ExFofGdZ95dWEEQSnTau//PFADE0fx
 tVgMxm9XSA+TqmL6b/jTF1sQ0V4mGcH/GjcnF8IfW7LSV4fFjZY8DcoZxU9J8o96NqBj
 7DtYmAmcEDipwIh7eBV+59gByhzscYJ1N0VBSCqOQv2iyoDr8huvlJ4e4HllWpfPbmov
 Z7r84a5Q4cda/N8HcE7dnGwn9qnVsdqVwx3Je6Mbcyo8Zu3lDxzlsjnuv0TEKuWxgMI9
 EXfLybzajEV4lnVNuc2MznEWZzrMbReAWAO1EvUDDmfJd+AZQDMCA3ukhpDO+nLAOS7H
 3BVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0EXDNMNTanXOqnAcKsmm1v9p6W0tvhFVYyO4+Lp0TXDs2L6sVP3+mNkVrsHbLGJGEvj4azkmx1lOj@nongnu.org
X-Gm-Message-State: AOJu0YwZ/xhfGVf5H+0NdnKCvrTcj4I/Xsnf4TDbfsBRU6KYEyS8Rgau
 iERygy9pNMY8W2oP4NCwri+veqqnm9yTYghchs92vMy36aAEBwO+lZtL5p7/4oc=
X-Google-Smtp-Source: AGHT+IF7NKbu8gC5f/g247NEUMP98IakFzj+CFCmPI9KJHs+3tKFIS/LJcq3J35MuSi/6UUlgK/uLQ==
X-Received: by 2002:a05:600c:354e:b0:431:547e:81d0 with SMTP id
 5b1f17b1804b1-4319ac9ad43mr307257745e9.11.1730818165779; 
 Tue, 05 Nov 2024 06:49:25 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9faesm220732145e9.35.2024.11.05.06.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:49:25 -0800 (PST)
Message-ID: <97f0a5ab-0925-4377-8b86-b76e527c5ee3@linaro.org>
Date: Tue, 5 Nov 2024 14:49:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] osdep: Introduce qemu_kill_thread()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-6-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241024200031.80327-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/24/24 20:59, Ilya Leoshkevich wrote:
> Add a function for sending signals to individual threads. It does not make
> sense on Windows, so do not provide an implementation, so that if someone
> uses it by accident, they will get a linker error.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   include/qemu/osdep.h |  9 +++++++++
>   util/oslib-posix.c   | 15 +++++++++++++++
>   2 files changed, 24 insertions(+)

I am annoyed that musl does not have tgkill in <signal.h>.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


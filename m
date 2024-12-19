Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98543E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOK38-0006Vc-H4; Thu, 19 Dec 2024 12:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK33-0006U1-QZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:10:54 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK30-0005Yj-BO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:10:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so7812175e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628248; x=1735233048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zNAUaumIubqxBdfrkyF32Wb1TIbG3aoZy+rFCJ6ziy0=;
 b=MS1e+wEsjqFErUXS32Mxj0Ygby8VAg2ANYOVrPyEHGeOJfD9kypWOYh3nqh5Ph+b3N
 sI8iSgjFow9Y6imF5jNQ0iLgfI+fV0eKaMK0+Z4ak9ovHaD1dlI7gek/Qx1iEaIoFrp7
 1/a1AWb+WCRh2gZp1icA3Sl3Iz11Y0BsRgCpPSFV8rVnM26T5KS9LPDYQ+jiKvrQ0nJh
 3iukFFwPXfh1GUOPkZpbg0kml6hAgjA6VCswalhkmKLmLB26KSwTD8D0qwyUw0SGxD0z
 RGx7d5o2orIZJmQsJdY+TlgF1ONF+KyGrlNZOkQyMteg7B/1WqebPXd6Hueyh5m+QVbT
 EU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628248; x=1735233048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zNAUaumIubqxBdfrkyF32Wb1TIbG3aoZy+rFCJ6ziy0=;
 b=mu7wp6zsaNpFv3hiHJHz68DrJZtgOkC5d6gzWh5Y4EbuxoOkdm6oN8e6VG3wFpSJdz
 gcPuGJ5ExFN0OM8yvn52bh8LL2PHNHKUjgpaplpJSOS5Viccca2ahP3yY7eTZTWGmcg6
 tmTWgXGrTZzs4NLJBdJB7oh6LZ3co7HJeqv9hz+AfXoGbxUjpPZHhrlHNiIObM/V/r4U
 /tXtlCZA1nNRum4DmqunpmHUSuEOpwwKW38VGAr7tspPNubK46PGrY4q1JSMEILXURh7
 yxHnn+Em0vlmrOzEelrwKWjPLwul4Xzm4P7cvtTC6iRximis2LVGvctyuHMMgMBWQsf+
 CLjA==
X-Gm-Message-State: AOJu0YylO5yXLdum7FAL2CzylGwMXW3sdQ24az0+u8BB9jkSHZvfm7Qp
 vSy4Lkb2Dchdxuo8M4XrP6W4trdJyG0W0AHEo4/fOLf5hdX3tSw7VKq8MxMEIGt0lnFK6tRjXW3
 r
X-Gm-Gg: ASbGnctEgSR4QzchHjB0BKZg7Z6QXsVtBKPdIquralPcM/h3hdMKQK5p4kkVbGnUAam
 YtvqfjZbeB6hDFhWNxGP0knXAafeDxg95z3LtU4SuOiPfV1iQ4k18t2l6G+gh39sucLLRz/esq/
 Fc2UHI6nrSf+Q/KMhxe2nRnMkJj7LoFl44zID989m9pEtMMsIXKaxEPdr0GryeOOiLPiohOa3YF
 a2r2EoWkb5Z8uXtaZJlYvMgM4tOra5fimMQT7hYwiVOvNDDfvFirklgfzaJ7T9eQNZidlA=
X-Google-Smtp-Source: AGHT+IE7A3TvuP1F6qBKDiHnz/A+Cspw/GFXspKzxxjhLPPXnIYdcOY6dc1N38LLKQ5IaMb9uZ3f2Q==
X-Received: by 2002:a05:600c:468e:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-436553f4d28mr70342385e9.24.1734628248469; 
 Thu, 19 Dec 2024 09:10:48 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366121955fsm23516195e9.21.2024.12.19.09.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:10:47 -0800 (PST)
Message-ID: <95423040-a03a-436f-9fb5-2a4b151ca118@linaro.org>
Date: Thu, 19 Dec 2024 18:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] include: Two cleanups around missing 'qemu/atomic.h'
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20241217141326.98947-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241217141326.98947-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/12/24 15:13, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    exec/translation-block: Include missing 'qemu/atomic.h' header
>    qemu/coroutine: Include missing 'qemu/atomic.h' header

Patches queued.



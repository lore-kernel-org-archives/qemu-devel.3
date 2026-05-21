Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D3CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwUf-0006OW-Uo; Thu, 21 May 2026 02:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwUd-0006Lg-CL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:02:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwUb-0006Iu-PC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:02:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso1158625e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779343368; x=1779948168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PnjyTG7/+dcGYmqLHSZ9QuqcFl7rCeFn8lBcTH1ol84=;
 b=zGJ3sof3ImuBsusEE5MYoGIypYOQcC2NwqOczQJTyXb5uJOLFgbPeBSSden5MnI2b0
 TSkBAm4BzXsdlmUWFFHCWp3n9gh2ai5JWT9O4XB8WZ8CvYqz6pGbgf/3qIcLPnk64YQZ
 IaZNfmes1mU2qQsjWjBWl6euGqSCkiDIcErUQSlfc57F9N+uzGrpuxqJnaa5DjzbOA2u
 VA3RqWO12z3h9Dn+zreGey1barYm3gLUMSre3sFO3WPQCXMafzPekKgVQp15yHLDXggi
 xl7Eturlgptw++jUvp0hrB9kyEU2JHdW0xs0mUFxbO1GCVnmbMnuKIwEJC3WHRFRd4tO
 V25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779343368; x=1779948168;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PnjyTG7/+dcGYmqLHSZ9QuqcFl7rCeFn8lBcTH1ol84=;
 b=o+QmdFKJEI1vWJSuKwAWSpHm/Z/n9/SMdWDFkj7ywfT2KNlxDmxcOrWPiIur4VZ7mx
 J/iBmSxlALripKsZWcljaoK9wR3pSC/HCONAisVj/oOPvdH6mcvPf7Ipvh7/njUCNPIJ
 redaej/WlMYzNhgIzhI649/l5fLT/+Uch+wjGyOkhdM1JKWuZdvSrFiTU1IBKOyl6yFX
 UP8tvHFoUfRr2NprhrILICOykb+i9Jtx04KjthM7psGbGr4824Kdzne26NRXydB8mcHW
 TL/KyZwXTYOgKXI5bWUS61goLqKxGYLzkn9Di73MIhJaJRuu0clZcc49Ie/1ME68H9LE
 4W8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ81hnUzVizTIC5swWOP9+D6qdYOD28gbv/HqUhEg0q7SUsmVCLrFGboW6u6LnPrhIvDRBEI3fQQSfAm@nongnu.org
X-Gm-Message-State: AOJu0YzV6VFsulMO1BfXAl3MlD6kfCY1v+LjR+OuRbT3JVLrp4cT11on
 YBRoSASjC21bSKxoSJ9OjW5ZWzjUFSKylM9cTkavn3SHtqSmIuwuncxyres7JdKbuKYThv+G5x2
 H7n8XOdw=
X-Gm-Gg: Acq92OFSSjov7iEDAaZp8DAif3NBgME+Pcgp3EkSSuoDc6mR78Qv/YfeqYfVKL6kHLC
 LgdVHCoOOtGv5B+qVuncWrJt1RPpqeYFqda7/UAnkSf4mqf67DouB5sWHWsqiKEUQVphhgllE/2
 TUhnAdnCneaXPjntzzKtYk7Suq1VFbQok6MGPYmdUcmVpLi3HRM4fXlZUDqyF+Ewtl0slGIQN7P
 5yMBdwemhJHdcotxNiq3J7ELtcGPoEGrPJy/5nY9Cu2SB8xromPWxIACKchHaZ83FPD0ctC/N4z
 1XeM2WP1edKvfITdyHuJKgiaBjLtxHVCMaTDTyYMTHx69USza8oA66BXt14Qfze7nrjPCSFP49o
 iN/II44NJTS4i7W384RGaTHjftbG+fXxYz6GfbyzEIzjrKNYPA6mMrbSckWnUmpHClCKfalupj6
 aLGf8D26JF2BkHE4NJNtoJxfdJGb/ebNhSU21GJjefNu5aT7tm9xLT+wRFJsljnINn1A==
X-Received: by 2002:a05:600c:c086:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-4903605c9afmr12341875e9.13.1779343368002; 
 Wed, 20 May 2026 23:02:48 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c45734sm8474495e9.11.2026.05.20.23.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:02:47 -0700 (PDT)
Message-ID: <4ae2e509-9463-49c0-ab70-2d9095db5f89@linaro.org>
Date: Thu, 21 May 2026 08:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/40] tests/qtest/pnv: drop unnecessary -serial mon:stdio
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-24-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-24-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> The pnv-xive2-test and pnv-host-i2c-test pass "-serial mon:stdio"
> but never use HMP commands. The "mon:" chardev prefix creates an
> HMP monitor mux, which fails when HMP is disabled. Other pnv tests
> (e.g. pnv-spi-seeprom-test) don't specify -serial at all.
> 
> Drop the unnecessary -serial mon:stdio option.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/pnv-host-i2c-test.c | 2 +-
>   tests/qtest/pnv-xive2-test.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


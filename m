Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B984CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 19:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uybFu-0006yf-Ux; Tue, 16 Sep 2025 15:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uybFl-0006u9-Uk
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:22:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uybFk-0003u0-9G
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:22:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2570bf6058aso75899585ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758050530; x=1758655330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z6dSvWjtLk3+vLbrAWn1SkFpp6dw5SSL6pHHH+imY/E=;
 b=OrzDTDv4vf6OHNSDudCvrAAdVC8uIHyfJMYtuXN3r15yROhAe9FWdw14PtbV5ovy60
 uLT+yv1IKTm4iO7F64kTQK6UazUfOdoKcTaJ5XZ2Bbs0xiifFuIE9JFzNI6aNaDh5QSf
 0hmZmJiPZ8A77HxvakcS3ZIZDlCyIUC8TYauU5X6F6CEB0/MjAYol7mw1IoouqVNN41i
 2xrU4hOd9rECsOI9ANwwpolxEjnY7F0UDLIJPVJSLP+Gq0XixjHmIzRHKrks9ZoY86WV
 5b8blO6/ICwzC9Yb9BKXbbWFWG2YAdHkB2ajmg1IdgmnEhtxY2xJccqg6a7kadXhzFMv
 1Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758050530; x=1758655330;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6dSvWjtLk3+vLbrAWn1SkFpp6dw5SSL6pHHH+imY/E=;
 b=UwEh/PEjSdGHtVZ/oqEoBjSI3R3W1UxOBnFaktPbQTnWKkQLNVR/aM4jk4fv8Enmxv
 XeSKsAFr8DiDD+13wW02oFyEwHoMmHvJFyc4HyWSwDhlYrS2CWIfueYE0Q1GUAiouq45
 wgRT52MPUjomJv+5zgArEaPpjzm0996+JD2AXtW9W/nrBrCOW4X2qcagWFqFHvQ8NTLt
 mNoEHAFEes2F86aNyMQS3nJjBXdU5SJHos9XogTU2TjLicabbUZPELlOKo4CXFbI1AUF
 yK/gt1WXSbJIEz8+d1sBjFAneRs5YxEeWh4fZHmjGeyZHs41J3+LKclOgOBQvPhbv7ok
 XimQ==
X-Gm-Message-State: AOJu0Yxxl2RNuuYa/avvcar/A6n/6noCq1juitx7Xmlg8WEVeT6SZZz2
 4iBsEDraQty6UISoPr3d8n+xAtX+gz2x/MG0swPvtQGqkc8OewxAvvnyFqUiR1Vfz6OcCwul7kI
 bK2hu
X-Gm-Gg: ASbGnct8BsIKTJnMtYroUKHPcIOhQUf6Nv0mfl6SeTygFpNnJs3fr4R6eOxyNrk/dWh
 wbLq1NOj0n6/73yaf8JIA1R3XDcFS11R32U+kyV6DKtRj72ta7JDpSbL3CdlXCsTVyGIR9eAmrE
 1LUEpzmBRBshdwk9X6jaDBmpGOpTsN/umyw/uuXqwyVOguRjFhAnzPCk5t14O6SYpVorZVWbxFm
 w1hvfHrMA9BgljO09jDKmUoT1lFdkrBnYCifKvV/8vPN3V30mZS08vYBDh2k6G6mk6YK+2ghF0c
 0+Y1sl8mvhZPPlt2CtA5VOOtq7jsf8YRONc9KceJlSDBfyk2I8kZNjGOm9sokhfFX23ipZRS/wA
 uALC5XiK4x2I0uOBneSesmSmAWMqEDmTvdCom
X-Google-Smtp-Source: AGHT+IGpujGjJUd3VucUt+sCi57vTgHh1GeyUl0i/ghcdYFExDBHbbgmLVCd8aVvpjjs9I5coUCryg==
X-Received: by 2002:a17:903:910:b0:264:ad67:d594 with SMTP id
 d9443c01a7336-264ad67d904mr133389715ad.0.1758050530493; 
 Tue, 16 Sep 2025 12:22:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c36cc6abcsm169617375ad.16.2025.09.16.12.22.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 12:22:10 -0700 (PDT)
Message-ID: <0220e70f-25a2-4152-aa05-d3960485aceb@linaro.org>
Date: Tue, 16 Sep 2025 12:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] Python patches
To: qemu-devel@nongnu.org
References: <20250916162404.9195-1-jsnow@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 9/16/25 09:23, John Snow wrote:
> The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
> 
>    Merge tag 'pull-request-2025-09-09' ofhttps://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jsnow/qemu.git tags/python-pull-request
> 
> for you to fetch changes up to 9a494d83538680651197651031375c2b6fa2490b:
> 
>    iotests/check: always enable all python warnings (2025-09-15 14:36:02 -0400)
> 
> ----------------------------------------------------------------
> Python Pull Request
> 
> Python 3.14 support & synchronize with python-qemu-qmp repo


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


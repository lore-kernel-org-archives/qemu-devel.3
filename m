Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C14ACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlqJ-0006TW-Id; Tue, 28 Oct 2025 11:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDlqE-0006Sc-Vt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:42:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDlqC-0004Ks-8A
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:42:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so36347625e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761666148; x=1762270948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YS9Y5qmew34qYS5ine+hr0eYLyKhE8nsuQjwpiJ6GYo=;
 b=jGZS8hoaXGB2Udjzt1Ld+eSJItt+jhNzVPRo29/kELY8nxKf+63pp5pzGBYDEjmYpP
 sXV0Ni8BzpjaFkrvRJMLr2fFb62RJEZaRCXvP1JfqEn8z3EV5hVYQ4G3vH/iIynVTYaJ
 NZUuzvAUIdatx/XVP1KoQgzTnEiN37UxBvYu54n/Bl466DMdaK8OMoIfN3ycnEY8SzCR
 d/3inGg7xhlRtyRURXwH+CKgeG53sM+mcGGQMIwpLwO5vmuXHfaNSVViw73PYIXciA3B
 McGQN9A90o6TdC9Edj29cnajN8muJx4Qu+wO/AK2JQGRG21VFOHD8rqUUJF4LqpipFmC
 w+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761666148; x=1762270948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YS9Y5qmew34qYS5ine+hr0eYLyKhE8nsuQjwpiJ6GYo=;
 b=HtJ3UwFDemHXggiI/6mOBE1URy+lOfamm/U5dor2jrxaJT/0ExBx1kvXF0do5TypO7
 nXgBJkBHvRwpn8NIbmavAT7KKGEi0dz2d+EYh9bBtjk3BZktuNejUQvpLCWYLWS+pIHl
 sEf/MnaT64SUv+N66SYB+9UAEkotigTXHTv85o+kwx1ouTpNzTSvPObbW861k4CjJURv
 WXldnZ1aMDeJFTZQhTSKumlz4klbnfd/hRal7peN6nHWDo7JqKjxU80r4rf6ysVRx2SN
 UBK7otpQbcGdhCiaZC8qDllW5RHUaih6uUDbAPFcBi12MtWmkyjIct754w4kHB/i6HJY
 vZHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyTrOTtA8zl5vDv/C0anrkQcCZrDD7uup87PLNN1D2qo3Pdou8a+jDdKsCu+odNbReUanp4rxKtSGb@nongnu.org
X-Gm-Message-State: AOJu0YzXQy/I8X/2z04Xm4M3BWOohPk+pUlLd7gxfO/vWb00cMo8wmX+
 ZAuhu9a2+A7xj+CoCbf800UhliaC6yabMgXmGK7pkFW8Tmx78asG9NHEHMeeN8RdXNGsah3X6He
 4sFgw9nU=
X-Gm-Gg: ASbGncsg2zifvsr4yBM++c3GeWT1hP6P+zzsJ1qArp5OITz5fiqWRukAEEIHRVuOQOB
 2GXE9uiEQwcSW6mE1h6/wcirZ75zypM9cExDSRn5VcYOd+2A03v266I3atEo4lPgKtRaz7kEC40
 X9NBNfoxXUl/DH9dRrbOfK67G9cCSFWvV+tHUtpWjjCoN1+lTyNc2J2llo1oBmOdtSaWoGxyGDG
 YmCuXEYzBqfvTs/0OikJ8Cjeov3u7jK6llsz7+BlqQooZwZ3vuWhAjluSgb4xhFs2AjAFZIsXJu
 hBIer0Z32YkEMWqUUjGx+vp4oRYOw+iVy89ybdrTJawlJXTRcmkBpDdnYnUiTDwX7aTRHarFgSs
 6Cry9ObAIXAOQGFT6F82BlokvldRax64RAQCwdlRZvbM4PHhv49r2Nn4e2NXn0Z+MnmrTwZEiyR
 Fhxs8WIugx2wM5y9uKZHDatURmVmygCFZ8+g3CwxTN+BU=
X-Google-Smtp-Source: AGHT+IEX6MopKK3VLbogwq1laE+nEEWu2HQkB7TPMpaXSOrwQrV/pe26Z9m8Oa0zKFjf6swaVb2t8Q==
X-Received: by 2002:a05:600c:3511:b0:476:84e9:b561 with SMTP id
 5b1f17b1804b1-47717e587d1mr42362175e9.32.1761666148156; 
 Tue, 28 Oct 2025 08:42:28 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9d1sm20602362f8f.35.2025.10.28.08.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 08:42:27 -0700 (PDT)
Message-ID: <34db063d-c639-4e5d-aa13-9d428a77670c@linaro.org>
Date: Tue, 28 Oct 2025 16:42:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: permit sendto() with NULL buf and 0 len
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
References: <20251028142001.3011630-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251028142001.3011630-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/10/25 15:20, Peter Maydell wrote:
> If you pass sendto() a NULL buffer, this is usually an error
> (causing an EFAULT return); however if you pass a 0 length then
> we should not try to validate the buffer provided. Instead we
> skip the copying of the user data and possible processing
> through fd_trans_target_to_host_data, and call the host syscall
> with NULL, 0.
> 
> (unlock_user() permits a NULL buffer pointer for "do nothing"
> so we don't need to special case the unlock code.)
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3102
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



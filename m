Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3731EF8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcfi-0001q6-3q; Fri, 17 Apr 2026 02:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcff-0001ny-0Q
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:27:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcfd-0006kD-6M
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:27:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso2348375e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776407229; x=1777012029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZBK7VnQA184JDVn213bMuprP8pWfTARfJ1pC1t6qzk=;
 b=J45i7XewuHsAUzD/id32G5i9GIgxcC4Hj3t2kWvLqGHY3enc1gTxCmNpy7FjwHtf6D
 XybKErk9OW9Ww5OGOYFa3O+eiCFH03FLEcqBAU/8X6RhwA11BjIILDlewgczJujo6IdH
 0hwUA0tF92ovJKQgZrcqxWrVqcOtOjOeH/2WgPk3zXFYGHozisMg1iXDtYTiZnoOU18V
 Xz1Ybs+vJfenTRC++ZFHh68nF6egHaI2gi3+AdMwASPhA08G5F8iGS3CPiRMzZc7hrDh
 4iZDY3SFJEU3n8vXDhy51WFNh26FEEP1uyHA7RKknYFVa9lOoOS1InCu1puP0x4eJKjq
 YTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776407229; x=1777012029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZBK7VnQA184JDVn213bMuprP8pWfTARfJ1pC1t6qzk=;
 b=UE8BmF1ciPPj99UBXekk1nIeW9ahkm0OitNZad6L6B4jmIVWY9IgGnW63A1yGFBbSc
 Kv0ZAasPUm1GChZ0iEGQTexI8ZCWFxL4tKWaEXwxsK6ByFjv/cIHfbdXAnKngGMw/Ter
 t1B+0X4kEa2XxiJmlZQ+HXORYdPtygFaoNx02fG/EedPHxX2jV7XqMiONu5orfcUuiEU
 nmP/kbNZ1S+QHB+BBwMJYvXFqU8j5/EJeFTRnjiV46HiKZNczoNF9wPr48Upu7ff18zq
 5Byqxayo4RmBnHLtDd1IJMmvj7ibheyLNsFyIPVGeJSomIXsZBx7slmcKILvXETheP7v
 jLmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lpqU4JSRYvnfcXsBLIMKQqg+7iHTTWn83I5xaxGbNkMiNa41vv4xeeuGAUggTo5/OsKidCP7A/kd2@nongnu.org
X-Gm-Message-State: AOJu0Ywixk4QT2ATM/vF88sFwjYIZyyQzdju4eHd/DFgX4HqCREYRaey
 3tuFQ3RI9XXFP6lfa1PEGiPWclr1cpyPlZxyH8Pl17Y4qRK82E3SG9lVKAa9strevJk=
X-Gm-Gg: AeBDieue6cBVdapGl8MRTva2jDPM6POW3M1+UfvbFJXDA9Ua6r5thIBd4bmCE438r7u
 chax6W2MCwRV41PLN4gI53Rpyh5jy4JGoZXqR5YcmjJUQ+o9sLbaxw0kxZGWe1dGBOoFbx0TKCb
 qCcEmindZHpmxDYbKf3jBW97Xi/e9v5SAtY/mK5EGXyqog2s+x2AtQqb9RmZWIm0ivljuDAAjit
 gK+91NBepyWka+MW1xrvcpC8AxAv/hTrQGCGA21Tu3uziK8LpNvLIEyb0suxprx3szGc/hB7ruP
 mSg464mjop67OKBzPyCutkc3NNfp10V3vQPbRpwbwgxRfmVEnzy8zyZ5CeA5sNyC3j0LcWKwETd
 fbyDcnJM7sQqJh2NYjgLAS72oQZ6Nz8oRdqm7Wo0ZiSJcuOdp1BtmgmaovKUUZFOg1ZMikBPrah
 96Zxr49u1E7IOPjPiMazULMm9jG2V1+LjvOi9a3K1Ke0RRy86aTmR+zYDDEYzXg+0yLUyNiXXGL
 D5E
X-Received: by 2002:a05:600c:3513:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-488fb77a3a7mr18327335e9.16.1776407229345; 
 Thu, 16 Apr 2026 23:27:09 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm1944840f8f.7.2026.04.16.23.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:27:08 -0700 (PDT)
Message-ID: <1738caec-dfa0-4d88-b7dd-5eabc075f5ef@linaro.org>
Date: Fri, 17 Apr 2026 08:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-17-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-17-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/4/26 03:50, Jamin Lin wrote:
> Add a functional test to verify USB EHCI support on the AST2600
> SDK machine by attaching a USB keyboard device and checking its
> enumeration via lsusb.
> 
> This introduces a helper routine that runs lsusb in the guest
> and validates that the emulated "QEMU USB Keyboard" is detected.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/arm/test_aspeed_ast2600_sdk.py | 7 +++++++
>   1 file changed, 7 insertions(+)

This should be patch #1 :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


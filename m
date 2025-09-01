Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A951CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBRv-0004sW-CY; Mon, 01 Sep 2025 16:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBRm-0004sJ-UX
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:48:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBRl-0003Bg-9W
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:48:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b8b2712d8so17860155e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 13:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756759692; x=1757364492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3vdvUl0MRoYh6CNJF+cLUcCCM1TRYlKexU5CxmDSzLA=;
 b=lLHt992Ew7T2VgIEiDWBhUp7f5Enhk/eKEB/dGFDzcvCnXLX1PEBZMhfupo66C78Re
 msI4JON7R6VtJzSyVtdaIugth5C87IoxxWTcc58iKWygdzWhUkC6PGKhuqj/k/y2Cwz1
 s5WHPRIy69GuMxVSjM2BHG4v9YtCMHGJrWbbXHSe7sQ/wl1eHLQm5EA3ud1F2wGDYlvP
 850Yfr9JWCErhY7Q6y5sN/z7KJ1lGYg8vZfPIElRCi2f7pytRcUR1zXjoCnqwgcrwGrh
 pOs0tzM9pqAB/lIMuNNgpcYIKfMIDIXpUz+SI28aaxKHIi0DJS/n5tm5Xmobojuo2ViP
 SBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756759692; x=1757364492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vdvUl0MRoYh6CNJF+cLUcCCM1TRYlKexU5CxmDSzLA=;
 b=BDdncZ0s1xvze6RFS3N6shvgtl3z8AdQX8ouXTDg4+pUXSODo/S+8KRLyFRmIgNQqv
 p94frMfP+u+L2qgVMLeqv7uIRq24E5rZw0VY42OlhNJTPFCL74e5gNWmp2JO30TO+Bjv
 IVJw+bp85M3Aexy5xnKdCfTNFiUskEkG3XgevNdrjPANiAlBolw5KZZJ1KoWWaNxyOFL
 neOUJNBLyOjJgs3eVt3A68RsKe2jrXcQbprsWUnS8wR/g961oKIYD45k4X2Cu7dS/F90
 X7sGdhYP1SOohg+NlZ/r7PA71n46tQgWpGzIs87m9sgKkutMODI1gFYkZxCEcV7xnXnL
 3Ikg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9KrpXKEaVhFBcJgqCrPstR+/cF+G5nXXJvh5BQlwD1Cc29UUrpopSg7WfYXa3m5+HewmZKHuOxt3C@nongnu.org
X-Gm-Message-State: AOJu0YwBkgqcPeEIOI3+w4J238hQeRHCjo1OQjZEtLax2GFfqo/Fa6lW
 WV2NiT7/3EmdQxhdHw/QSuVQir6ZNPIm/U0qxpO099NgJSAQ2UsRKtjnrZ8U0pk8QcmCPGS2HY5
 oShgN
X-Gm-Gg: ASbGncuWhWrltQokzHRBkHrgr1cpYastrP1HIVfa+9TrqVbh19TMcbdomv17n/sTMUp
 K7w6afKbPZkwqLdV/Kv1sRTkc7FxLAbBXPrUmnAC/h9TcYTCzLotdPKrAAnEyhiL7K5MphWFOy5
 Idu1wbX2OvOxaG1vd95+OUMlNogbT3Oei6lZiPMk9NFqrvvXVbmYaj7bC9BhWgnYJOo2yDEm5F3
 kYVPdrA80bczs/MuO/7y6RHd9QLFi4tBgziudOaXp1dM7DtiDZ4foQ+NHJCw6PMpnk6KGx2m5/b
 sJmm2kG4gVYNU7iAplSm5A9CrzShkZZwT4xju/MtPWPrw+IpvubiXEIHPOJnOogLN0RPsjOgfNi
 Mruabek9QZegKIEJmof5Kkpkl05goOQ4GU1xP1r4SFMerwrBQkPwBty3p2qZzjh16DAyJWbiwS1
 mR
X-Google-Smtp-Source: AGHT+IFmhBUpjsQHxpQEM3umVxEY+dvar3Qp7/hDbDGXRQccdud179UeknYpNm56biGb1k2RQPRNNA==
X-Received: by 2002:a05:600c:4f41:b0:45b:8b34:3482 with SMTP id
 5b1f17b1804b1-45b8b3437c0mr45326765e9.20.1756759691650; 
 Mon, 01 Sep 2025 13:48:11 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6db6sm267321235e9.2.2025.09.01.13.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 13:48:11 -0700 (PDT)
Message-ID: <955a8399-f5ad-4b10-a667-e0f8ea632515@linaro.org>
Date: Mon, 1 Sep 2025 22:48:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/8/25 19:40, Pierrick Bouvier wrote:

> Pierrick Bouvier (2):
>    hw/meson: enter target hw first
>    hw/intc: compile some arm related source once

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



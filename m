Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD3FE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAfn-0005be-VD; Thu, 05 Dec 2024 07:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJAfg-0005Xr-QA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:09:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJAfe-0007Fe-RN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:09:28 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e2c52c21so664096f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733400563; x=1734005363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/CnxoY3fZkVMabjATGXevl4nI5uHUrvbtaUbQpbgk58=;
 b=R6eiIbIzIsaQV12+AkYeIeHC5vouudsVDG5KQcaCY+yPANUwRdOHPJg9WduGP8T2AC
 YngV1EguUsjuRoQFKwGCeggQfGiTO5MFWqaQlBJMucRopCKLquUjMlJazQ0PCvkdnUWG
 eC8re9dtuA1Slo/pHubsDznFUXIuvcubbXQ5rj+nHWb0ANtkOWCQqAHa1OH6qGXunGnP
 08ZUnjncgND4AGrb78RL2zjcecWqghZaiTDGHCXGtc3OrUko/ig851Q8whPH0UAMa8l/
 D7dPj16xUdmvRLv+U0q+IYg9Ak6vHT7I7rfm5nH/2q5owmQJPwTSwiAKgjIcAruGFlgR
 uvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733400563; x=1734005363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/CnxoY3fZkVMabjATGXevl4nI5uHUrvbtaUbQpbgk58=;
 b=P49vQMFxcLOwF4xhKzIXxccwDg95yti/7VUI59sYi4Xheem/9yfFjHtVVUawBIT3G1
 sUSG1ztldgDJCs6YEVi478c0wwqi/j9qk7zd/oSbfa83uw9LnahdvgwvLzTJh8VAzw1u
 A0kQ+cbTNTHAu6uetyba2oBdRjExl4jNs9xHRqQuHuS0pWFHv6Ys91cbPkSEGwZasO8s
 ASr1291ztd4owXhtXhO40Wn0YTLwkjnZZ65Eh5r+ZxW3VUep4/Mppo+zLVQBfWQJWg3Q
 7AlnuDhoLQVZ/ksEjqq0h3fe+kTPs0lXLr7LkoHGQ2aultkXziiPDVbXZqhLzKZ/gIEo
 /tSA==
X-Gm-Message-State: AOJu0YwSgTyhuv97GStqqjZJ7FgdapMe2pjEg9GWKkehl/Cy5DZIiDP1
 WjOSAnpCWcrJgXtMyTaK430sVamk84zGfupIXOhxcjnoJsUg6RuPqhWYeUFZ4xg=
X-Gm-Gg: ASbGncsgFgXL2jfmyQrfAKbMCWtTCuzk5xdnep/95Fesbaq9fpFF8s7J2Xrkelj6VZB
 z7ktGTMhklpuAxC07l7lrbuvfwrpm77gqzi2G1eaf44xC0IAWq0iE7eMaUWZOeMaTaE95Vas3gK
 7Ns8ZJ2TIqycMRSna6OAmAuedt+dDZ/trY7HdHCRxVIffXmUXnltg9Dn4HMY5QootbfJHzlURdj
 U4NhJlaljavt4a055gNHwYftJSObHC0WaSwn5zZedkROWuAfbdQulavuPUeztByu0hrI8Awn465
 abBkGh71yrP1j6zj3Q==
X-Google-Smtp-Source: AGHT+IG/+VO0NJK21+kW9HGEQzX0mzonw+6ThjP6LOE7trDShkBhKwZoIO8ZFP4DP2gHmrIAIQHG4Q==
X-Received: by 2002:a05:6000:18a9:b0:385:f0d4:d5ed with SMTP id
 ffacd0b85a97d-385fd403392mr9133438f8f.22.1733400563375; 
 Thu, 05 Dec 2024 04:09:23 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f4a874dsm1784463f8f.24.2024.12.05.04.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 04:09:22 -0800 (PST)
Message-ID: <bf37233f-48b4-4b54-af23-fea363b5b559@linaro.org>
Date: Thu, 5 Dec 2024 13:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: Rename sysemu/ -> system/
To: Lei Yang <leiyang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241203172445.28576-1-philmd@linaro.org>
 <9e878028-cff8-4fca-960d-d66e68334acc@linaro.org>
 <CAPpAL=yYfhenWbt1Xb31747GWAbXSqzKZ6ur9WuvhbwQp-55oA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAPpAL=yYfhenWbt1Xb31747GWAbXSqzKZ6ur9WuvhbwQp-55oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/12/24 01:58, Lei Yang wrote:
> I tested this patch with virtio-net regression tests, these changes
> are working fine related to the virtio-net part.
> 
> Tested-by: Lei Yang <leiyang@redhat.com>

Thank you!



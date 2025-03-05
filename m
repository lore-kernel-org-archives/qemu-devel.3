Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6ABC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdLI-0004fi-L8; Tue, 04 Mar 2025 20:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdLH-0004fZ-KZ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:14:35 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdLG-0003zI-0K
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:14:35 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso40254835e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137272; x=1741742072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2aD9YXfiTkDVTArNzKKKVaO8P048H4BbRxh+MeuMyoI=;
 b=FkJJtCv2sqPxINa80QSWQkyOFNpoJ+6WnwjrdmbFdWxxQpeERfjUKaqco0HU9FguuI
 0NlPgoH/AYazjyVFc5vPif9hu35hsGhdJRkGSejXKJlNR3kyCY0boSoFWaBMBSh+Oxk7
 UMQ3y45BhrMe7qMNreEaPO0324Wbw+l7lnHSnAxQSL7SqbWklstglHwwR2hKJ1rCAGmb
 TsiGA1P7ID/TUGdak8LKBSAQ+bGP2/Eoezmv4YG0GW76RL/DWROJzJJOqZpo2PmFrNo3
 ZFTtxvJpS5GJgEn00iMkaKXH1EiXvAG6aHR8BLfMTeB4usCpCc4YkQDhVyqsHuPPUXXd
 UgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137272; x=1741742072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2aD9YXfiTkDVTArNzKKKVaO8P048H4BbRxh+MeuMyoI=;
 b=ShkQv7CEAxlALJI27/pTsvdiolB8F7LiWNnqiW5KauKUXXA1/mzOfw9DJpXAjNn8/+
 HIdQ2OXYF6HdgOMfhzF5vBv4zpCbSq2Iu0mPsyzjwDMx1YmHEa8z1JbsrzZI0YrgE1gj
 1hEIbXvkqr3pFX2YFGY2a/ist2AkKUdLkp8cfst4kCBIAQ+xmGSV0VK6VQLul0na3FOZ
 SUXihbJRA/7IR2Sikl2cLHzV1KBCsJXNimtjiBAb+isvhmMbvQFqBFBMz1sLfkud9FiW
 zkkaE4Kyhn11iNLqrwAeqyQ4hvaaxP6sKs0I/r9cBkgOjgyZJjL+uE3he/jpSdL5ZUiB
 iH4g==
X-Gm-Message-State: AOJu0YxiOVPKlFJr1YeqrUJgzYUX02THWOgGaVF/SIZjoxavJt7fllx6
 1O+jaBLHOt88jPou16a+9x9oMt0B0bGUc1+WuSu2TbJnOowPPX1ft9ouVRwTsuM=
X-Gm-Gg: ASbGncveD02xeYjtFGgDmnZ81bElY9IWMU4azwlcEbjhJyHXpkEiqN72sUU9agQOWVB
 oiiNqauDHyoXIyP3NbMGUSRGTwJhyUP4M53U+FywpKC7PsKUnOV8idMxzl4YIwOyCft42Jn5PUI
 kcpAUxTJR37BohQw1x2NnT23OvgGMJYpaE3hdKfEC06GRWOGC+QWSDC1CjppZPtDth9lYGyJjK0
 +bNcrTAgCJ1ShT7cj4zg9v5LphpyzF7dGmcUfmOukSYFE3EZb08AtDOKy837shY9sOxvte839vH
 1VcC8GlSMBm28A0gu+MCUkhSClyXIPnpR9cPfB4IkEp8U+hhymRmilgBKS9PJ64rCNOKR8TDuy1
 H7ri/S5Gon8hr
X-Google-Smtp-Source: AGHT+IEaofpJIJvrhHUPUm3sNEO6uqhfgxE8JxRKKgMXECUtpS4HcFNOJwf/pvAIsiN2VLu66cFQ9g==
X-Received: by 2002:a5d:6486:0:b0:391:a74:d7dc with SMTP id
 ffacd0b85a97d-3911f7ce121mr596832f8f.50.1741137272276; 
 Tue, 04 Mar 2025 17:14:32 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844c0dsm18863437f8f.80.2025.03.04.17.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:14:31 -0800 (PST)
Message-ID: <54249a76-14b8-4588-866a-b59046ffc309@linaro.org>
Date: Wed, 5 Mar 2025 02:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/ufs: Add temperature event support and test cases
To: keosung.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Jinyoung Choi <j-young.choi@samsung.com>
References: <CGME20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
 <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/2/25 07:40, Keoseong Park wrote:

> Keoseong Park (2):
>    hw/ufs: Add temperature event notification support
>    tests/qtest/ufs-test: Add test code for the temperature feature

Series queued, thanks!


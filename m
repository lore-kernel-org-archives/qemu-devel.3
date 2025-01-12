Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6268E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 17:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX1gv-0005uq-Nd; Sun, 12 Jan 2025 12:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX1gu-0005u7-JL
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:24:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX1gs-0007JW-8z
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:24:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso25295985e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736702636; x=1737307436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LVYVb1bxDW+nR29j3HrlxxRk6/o2MQ6s22PJWedoSD0=;
 b=xsX5EGq9IQVTaFrCZu/2aP5D1YcL1W3JGYkqbfZM8XT8+sF25zz62WTvbKSoRyuDa6
 pIWghhTUvSBt14ZA/P9NKYS67DelHbhJE1iyEhwmcZnZ96mHdOIK+6B3L5dsYzXHyfFH
 fVHxnE284psGk8cL2ZAk+7yh8iTfl2kRbNMUT/BzGcMyTwrqIc5Ptf76HN6eig5qM+Cq
 9C6T6RZxoyMu4ORxHWAw2jC8PloAdwGLs6bvJwCMA1/T3nDskgeO8u9EjExpoHNvgIdv
 N8Xe0xx+d08e3/mcuQVlOTwdlv1D1ifsW/4O3ndXhnjteeGt6o+5gnGyxtn4L62WmzU2
 8jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736702636; x=1737307436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LVYVb1bxDW+nR29j3HrlxxRk6/o2MQ6s22PJWedoSD0=;
 b=r5KEeaiAsj/7paA8mYOMWm6wqAOqj5ZhgqUdoxGKhukdE3HKTZcvnlKrLGvrY+7FeJ
 kmlFx1kuONT88SdqPpBeQhmU6wKeT7sdbuOUNDOMCG0GrkjDJ1NnK++wbWPbNtkggX/O
 CC7rZ04xFE2HZxQ9rtb1JEto17dNupf4P2JsePYOcV/4JZQUtxl22tQGipwt3N9ETPEz
 Bw9rQEkWPIpJdl1M/zdrIUqb5iaiRAQ/tfw0h8gVOhLcvsblgRbXD28BWcCG9uIMUTXd
 rXQzi7gmiZ17ABhDSzTUg1iCKkEfdkYz6PoKah/0+1bDiYUFtJfBpsaT0EienAP+zxd5
 Azmw==
X-Gm-Message-State: AOJu0Yz8PWyRTzY6YE4nqvvlzfFSzg6E+cIayY1SfSIof+ZMBA0xG/MQ
 Xhu3tLhISgKbAMHqU9oa433Dd4x5PG9IL/NKoGyjQo7QFnM+jvIeLoU4FAAFHZUxZVoJEB3E0XI
 PPRU=
X-Gm-Gg: ASbGncs1qwnD1NZLqYj6aE8xwj5Pa/T8BtV9zH5j3xLYFdLJnpIgYPwudyFt6TxaoyG
 V4XC0N5Pvq7A0ijgUVVjuNOeA3ui6GETQrzyhopO8JoZm9HBr7bi6hoOS5ZYTA3+0m0uS+7RuHI
 ZHU5isdYGs5PkOUo3CqjqO/txqEzJWa6pXVtdKP/9qZ5cAOY+Td6OwDhKBqRwlqfcnA/mXsp1ng
 B+4YcyNIwmoN83aC6ub40Yo2DEblU1EmdwylPcxPb6ELOoob7/WVSX/O+4xuWV/S3i+Ay4zD8QK
 lLPBXE61CX3g5oQOEEVhSbFh
X-Google-Smtp-Source: AGHT+IG1epZlp7WO4FmlfSixm8bZC0x8uwpyDHw06Jc2zQ0m1ws8B34xBEESxWOGbWW4ESMSGwzVcg==
X-Received: by 2002:a05:600c:198c:b0:435:306:e5dd with SMTP id
 5b1f17b1804b1-436e26f47e0mr143622835e9.22.1736702636043; 
 Sun, 12 Jan 2025 09:23:56 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da6336sm152122675e9.8.2025.01.12.09.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 09:23:55 -0800 (PST)
Message-ID: <f2d4847e-0711-409a-898d-f1fe4977e977@linaro.org>
Date: Sun, 12 Jan 2025 18:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] hw: More QDev cleanups
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org
References: <20240216110313.17039-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 16/2/24 12:02, Philippe Mathieu-Daudé wrote:
> Various QDev cleanups extracted to my "enforce QDev API" branch.
> - When available, instead of plain QOM, use QDev API equivalent
> - Add missing QOM parentship for some obj created with qdev_*new()
> - Prefer object_initialize_child() over object_initialize()
> 
> Philippe Mathieu-Daudé (21):

>    hw: Replace DEVICE(object_new) -> qdev_new()
>    target: Replace DEVICE(object_new) -> qdev_new()

>    hw/usb: Inline usb_try_new()
>    hw/usb: Inline usb_new()

>    hw/net/can/versal: Prefer object_initialize_child over
>      object_initialize

>    hw: Add QOM parentship relation with CPUs

Queuing reviewed patches.


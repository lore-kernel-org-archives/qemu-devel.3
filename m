Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DBDE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKCP-0005EN-Fi; Thu, 19 Dec 2024 12:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKCN-0005Do-QU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:20:31 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKCM-0007TW-F8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:20:31 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so652301f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628829; x=1735233629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQHw6JOz1ZBoe6n33k/yqm0YUYUxKzHtIiO1/LVt4S4=;
 b=SNH/ah/elK/yDiZdtyVM6IXfSq0LvVCDj6+jniUx6pO0a8Vx+AwujU/I4OqsWjsuzH
 EyQnVHCza7FVIGqyZAmAjbmrblAYsnznGxur42EEl0+GdiyjMyPFk6WifJh8w4ZHxNdR
 EyXS93mT4PcMECmR1EsYWILScG0CQB9pqzJHpEK4iMe1WRr1uLA1Q68hxEBg6JuyJi0h
 f2eowvjHx9r3L6mZLrf9C36Rrm5ybJa3hqnkZugb3Wf8BOB/w7mWuq+MJVRSnSLHNCvl
 ePfs4K9l2J0CcDHIqczCBdZSx3Cy/THs/jBQ1U45FGteaoe3/vdMC8N/lZaSxdABs33U
 syLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628829; x=1735233629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQHw6JOz1ZBoe6n33k/yqm0YUYUxKzHtIiO1/LVt4S4=;
 b=Ot2wWjnKOGjOthJZLppd5ic/9LyxtWoXtUsU5E2bnKMwZa13p7Z1u4dZiEZD/PKgfj
 AvvOf+vygZO8g5+OuElLnJkvEoxZxMZj7vMSWQgK+FBYzleLsIme/qhROTMFd1QVLYwP
 yUo2Mw2ei/BM6p+414CLPEA5eoU1K1gSQoeZgzU37KkyqA+OZkYMOnWFJlcN89cL4gHh
 E6gH7MbNVXC7sVWq9Y6fDyXdELjFZfbQ9fqJkqWWOxT3/eYq/TaCblXg3ZFxNDcFkUkd
 MHsGEafHJNkrFhQcbaUUTx20pENr6jUsqCzdVaPB/OpywMUnvtZUlNgBY8FCCfQ+QX6i
 jPJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkjZeANDyo4nCgxs0T94cRLfDeiVS1o82zQdH+0sM5Y/T5TtJoHk2qy+ExbryJgerFzRpF2vsKyhps@nongnu.org
X-Gm-Message-State: AOJu0YzvPZuizWw0QC8gZhZrnZg+6hyjw/ypQ0mxBzDCjF7Wwc9tF32E
 fiH4PZtFMJfmuwPyoUge5u8UXKt2pyJ9kNu6j9s4nqqjn/BF392B7lA9xyoJNEQ=
X-Gm-Gg: ASbGncuFmPiKFQsu8ZUrZ+HPYCYKmRoyb9PfVKOokCVQ47TZexPPcGCXCLada4arMKr
 ayyQheGuRrGQ6GTrmX27vBoUizH9RKc7kYK9ekBKacdKBpBblwBEqiZfAYMJsafoNtNiabD+FTr
 nRJc2BTQbtELXft0Z3HSk/dfbQPnOP/IAVMTe07nB3vPUWZ8xlkinfV0s2DagclcNHrQrGuc4Nk
 BV4qlUube8atsJkuj1xTqCIY0zea8Kpf0PE+jv5+hnG+LpAUSIFVrLANLfLtb3sZ1TfLG4=
X-Google-Smtp-Source: AGHT+IFrZpuxezzBTMG1OdHOgQCP0IksKPFYnc2GrqXhznOHjhwQlBU+V1SkvzStaMVLTsPPHJnN/A==
X-Received: by 2002:a05:6000:144b:b0:386:3684:c97e with SMTP id
 ffacd0b85a97d-388e4d84969mr8041356f8f.23.1734628828911; 
 Thu, 19 Dec 2024 09:20:28 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c833149sm1975637f8f.39.2024.12.19.09.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:20:28 -0800 (PST)
Message-ID: <4ac76c70-c8d8-477b-9586-260a50bc33eb@linaro.org>
Date: Thu, 19 Dec 2024 18:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: remove myself from sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
References: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 18/12/24 13:30, Marcin Juszkiewicz wrote:
> I am ending my time with Linaro and do not have plans to continue
> working on SBSA Reference Platform anymore.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



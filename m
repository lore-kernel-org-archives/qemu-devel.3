Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B548D75BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3Pn-0001i1-A3; Thu, 21 Nov 2024 04:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3Pl-0001eD-7G
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:23:53 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3Pj-0007Fi-QJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:23:52 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso5559185e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732181030; x=1732785830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W1KzjG+5XoeQE5xtE/Df3nR84+ZyGcG+9D+4Gc6sORI=;
 b=LLeuU2QfPDvE5LaqO/Lxx22rpUHQcMXCS/K0AsckzGEG1AtrJl6+MOx3Na5Pj7CYVH
 2+BYZeHamdAXRdNiZAaExYqMSi3hcc32Fy2REEDJMLaxqwKS0dKHUZMOSoe0a/CW8UXr
 Gl/bYEU0U8ztqMSR/N/5zD5QaygMOaLjEYBs14bUOymCoIdJyNliv2NAiBH/o1858Oix
 roA4yRMRCLsJWlT62yVFqJNcwGbhZ7qhJRjWChh0vThETS7PIDxayI69L2N+a9rZVMl5
 M7yJ6H+8es/U1uF+/2Vy0VaB7jgziOkmyKRoiQ7Elmlk11RYMezGqc8+2xc2Ncjw4WBS
 BuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732181030; x=1732785830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W1KzjG+5XoeQE5xtE/Df3nR84+ZyGcG+9D+4Gc6sORI=;
 b=FBu6cSrrGUqmG5bxTVvZ1pgLvFip+GMVqoYlPIRIsujDBd0ZgrxmH9Tyd+QKoJD+/4
 RAZl6S8G1Y1xP+KqiSSMZBHnkkzYaGxWG31Fod6zQq79JKXvV6WbHOXQtljU6GOeeBnI
 2gtZ2bU+dkRs9tv2FKjGh04TNIA+Ggqf7Txr0K16V9fP2yTD8cNy7qsugygAoult/lOW
 k0nvoiKbUpIcj1f9ha8qbbVPK3uaa8dfSTr9l1Q4qdsa0jkPthelB896YI1NEXL8nPOH
 KJux8UvY+0eNiq3a2YcgGNP4DYfhXLlesMFwnYrWmrO5P8Uulk7JprSvtYP8YIWf8nDd
 sRWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXystVeZpEXQNPBB+0sGVJj6sfzz14BFSuVTyYN56AIXtQwZzXzRM8nwXok+qw9a/JeI0ra7q+716NF@nongnu.org
X-Gm-Message-State: AOJu0YxcoHgvoLqGKgTTnF/IKbVKaYUdvwlceXGJ4DNp2cJNVY56i1AS
 2HLSVX40FJd01lmJZOK87aWMc4KCwgSrRU5YnWfpl9vjJEvTkV25pV6mpqz1LCPEdamvr8mrmH5
 N
X-Gm-Gg: ASbGncvqTP4svk9BblIaNFSVA0eAepPNslNMrY45tNm91WftyyOIKbp/1kSUABnmjYs
 AiKPgdTHaSKMfaOQoiEWHl66CS+GOpM4XMcR5Qm2jv7kfXltX0c3wYPd4ake5fJ61uGZUnzOVXf
 zkFU/9MHijQGUrdGCwxFPsEaZu//g8bIWEj1r5Vp17+GFIuvsVwEn0IcQ2XVziL6Xg/JKY1IuwU
 5HE+HlI3c3mQcGMbixQ86hNH22EwLBytaGtkvk4UNyK5Je6ulQopO8tVtlGwD0/haPmuA==
X-Google-Smtp-Source: AGHT+IE8hFuXdXRVTCnAH3tgBV584YanrrpOPyYRhKfYKy3XTFUhqB3zpjVvAqqCc3lT/qxjdJxPjg==
X-Received: by 2002:a05:600c:35ce:b0:431:5f8c:ccbd with SMTP id
 5b1f17b1804b1-433489814afmr52967005e9.4.1732181030195; 
 Thu, 21 Nov 2024 01:23:50 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45f9d99sm49685295e9.13.2024.11.21.01.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:23:49 -0800 (PST)
Message-ID: <d2c28817-adf4-492a-a035-4ef00278c255@linaro.org>
Date: Thu, 21 Nov 2024 10:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] qdev: Add machine_get_container()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-10-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-10-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 20/11/24 22:57, Peter Xu wrote:
> Add a helper to fetch machine containers.  Add some sanity check around.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/hw/qdev-core.h | 10 ++++++++++
>   hw/core/qdev.c         | 17 +++++++++++++++++
>   2 files changed, 27 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



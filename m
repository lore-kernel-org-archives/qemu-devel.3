Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF2CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v12SA-0007Gq-DA; Tue, 23 Sep 2025 08:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v12S5-0007Fa-5n
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:49:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v12S0-0002S7-Kh
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:48:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so4089327f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758631728; x=1759236528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lm0RIuxWrWjgFKSw/2KL2MfW+Vwvpl7lKfmYWVPDu7A=;
 b=BCDdS0J2EitKCesNNzLjFLegy8C4hKbJBqq41a7KUDGbXwvhMyBOjQvtzmONF6khlr
 WVBJajgfAb7cv8MPlRcvTDomA050QYZrifa+p0gM7xvFr64fUn5uFFf/JZ1Gyp/OudTm
 rlFX7ErnUIfam6TMIT4MocZo3hY8jDu5Dnh1OX5q0SlvgIgK/CrZbKouZufc3mDszvf3
 Vmh9o/9zowVSyEclfRniU0Y9OPpilTOp+15f+yzJ7vScqqD/FpE9ZWucqU366z+vwCFw
 yc8PYpXoo0UzMU+3StVV3RHvgREYMJCPEZobq44pBJc/HyJKvRZVwdggHgGjlIM40ERr
 d+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758631728; x=1759236528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lm0RIuxWrWjgFKSw/2KL2MfW+Vwvpl7lKfmYWVPDu7A=;
 b=Hj4yB7Bs6ZN06nAihLU62l2VrwIxCvX+Nf5R+aJ5WjDRUz/NnKKOP8HZZ33D0XdAlT
 1pOL1adbLC0rHoXsT7E/YlMhbiFOuvYk2fIuI1sW01hwP/8vCQLWf4dzRleeWNDb421f
 2l4wBikC/ieKo7PUuxhDBbN2OzVhmncOlRDjBaGWiMZ6IdQEE0rdB5UjgrIvgdpLlhoS
 GHDdAvs5tGyMZknNfx0Jk6Sl0lkeroePlvl7GyYzBSIkFiyghVDU5w07szuX3Q+h7btB
 yJMVoYy9l1M+VIYeyexX1idwqWoMDDx/bLsF0qb6ijfu7WiPA/+hGCZaVlNgzl26Tg1Z
 K+Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjRnXyY0zstAfd5gXKWVBxJfawiy9QPtqtXubL61ZO1RpwosUntirs11AIUaJXmOzvMVV44+igaeTK@nongnu.org
X-Gm-Message-State: AOJu0YydTjjwaadr3wrpDafNivHQWrq1uHuynNvxtvlNemyzzrUrI444
 Qqym/QleRMu9oVVwOTB8ARtAJZyB9FgNjPTdm6GE8aPIG70nNWBK5kTHvIbsfiode8E=
X-Gm-Gg: ASbGnctH28NpayI0bZB6G8gI3jUjlCmS7ddobsCldgQZllVW7YLFTlW+E1rbKMx7GBb
 W25Kis1YcTlMe0u63tsv2YXnBhcwMYSJwdidThnMUP1kf/9ibT4Bz3sbN+v7XZXg299fbBv3r9g
 Vq1xetbqNBrRsKqqF4hIshQ61DLXd0wSOpQ3T8GiGKR2SujcrN/6EXvRV+iijkIn2eKiiln4P8N
 0LAgT92mgACqxSmwF0l7IDhQNsGZG9UbcW/1ffvvxcMocG7lsfb50P1fMQ9xxQZvyrBq7gxK8yT
 dtUo44W7fcbRvl+bejQ7/MXjSQYS4HP7nmyH/R1c16dRT17cuvMKxY/nImeWy6vohKMkxMDzDll
 Jyk1XG732kDb4NdfjO4Z3LG25Apzkpwu08vYbhhUW1QyUTHKa567Qj1QupoP8rg4XMQ==
X-Google-Smtp-Source: AGHT+IF9wgXq4+2DaDjIUrjR18DFC+UouChP0XXZXHpY3SB+c0PNfUpvO/3Tn29J+JeH3Zyp8USJ8g==
X-Received: by 2002:a05:6000:2407:b0:400:1bbb:d279 with SMTP id
 ffacd0b85a97d-405c9446b6fmr2209900f8f.39.1758631727772; 
 Tue, 23 Sep 2025 05:48:47 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f3d73sm23563515f8f.8.2025.09.23.05.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 05:48:47 -0700 (PDT)
Message-ID: <b45e8286-a823-46c0-ab20-7cf26945275a@linaro.org>
Date: Tue, 23 Sep 2025 14:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] monitor: remove redundant
 error_[v]printf_unless_qmp
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-11-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250910180357.320297-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 10/9/25 20:03, Daniel P. Berrangé wrote:
> These functions only had one caller which was easily converted to
> the normal error_printf() function. Remove them as they don't add
> sufficient value.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/monitor/monitor.h |  3 ---
>   monitor/monitor.c         | 24 ------------------------
>   stubs/error-printf.c      |  5 -----
>   3 files changed, 32 deletions(-)

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



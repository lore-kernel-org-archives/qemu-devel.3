Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879B3C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqgk-00013V-Ar; Mon, 04 Aug 2025 04:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqgT-0000xw-7z
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:36:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqgR-0000sP-IW
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:36:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459ddb41539so1442695e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296597; x=1754901397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8yYBAPk6bQrvuenUqrGu8rRzJepTufaLbBnWG4n8ipk=;
 b=bvcEyQgWAuOWTNHIZafI3eidYvC5Yx6aT3FSZehu1u6LTCB203ec/Fi5T0jR1LLipL
 R4yuzW261Qy3m8+lRp/BRz6Eb9dOqCnCqoNruYwVTZT8cgxqkhh99FPYO1g3adCV/aVP
 jra/2BFNSiQ7IyXWfgz0zHuv0D10ldpRf4B32NvjMZ6zGSNBuyQFZegEbSzMNwakC5HC
 vjkCv3oWuIsRZU15j8DmvjJio/LKjoQia23lLrKiN+GpS08MEW/MVKgCIVg9PSjaT9bA
 Txo4PXdMhMc/CYGNx7QeXkWTHgU/twu1LFScqDA+l7hQ42/8WViPE/FDAUUv1XN+M3Ql
 NQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296597; x=1754901397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8yYBAPk6bQrvuenUqrGu8rRzJepTufaLbBnWG4n8ipk=;
 b=aXfyIuAh9GGM7GHq44JSHUem3dom80zsoEG/kytJp34GQ34Hzi64tHC9/DqvFfAy9/
 eoVh7DI94o90TcJQ4cZa07wZtTS4KVofskAOtiUN9uS+uMAtgaZMm/ey1mahtYaoCCw8
 vJQ/ibldyz5i6ryR6RXedwa2kbbQjO55o4GYihvOTTRx1eIDtzrYRow1Yb6/KnKa+7gl
 NEqpyrBdtWlhmiB9qDiclbcg8kUpB+9N5i8uvmMEEkSRIPjKuSB4FwdLv8eczG0Bx+Fy
 bZp7CtJMwZQ0OF7kohscIKPjQgUZD5gfgYdzKYpt8h8oSbiYgIkJEAewknGINfxU6o/D
 iQ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1mYikDSOokE5zwKpjhCcREBL7HVwgOLlkBqWOOjdmQGzTQDm3JGSmtw6N8Nw9ON/LLBjTLRRaB0VZ@nongnu.org
X-Gm-Message-State: AOJu0YxM/rlm2Q2Vy3rpN9s+S9zajBrty0RlPxyGh1rF3tKEad00ydpE
 GOqAnrAiQ6MFF6fmd8mMulayu830CYcH1bGRRwDZ97GG3usQ4lQ/D+nzqoNf0NEohc0=
X-Gm-Gg: ASbGnctMYIb7HW+goyOvQmLG6gX6slMNPdHv3XICYEVKvb3xb+IkDRTrL+fiTvMIo/8
 avrJ+qXlT9YTJuKUtKrXJrAscjoBBq5UPBcOSxXdPUl8A9CWpGRAjtJkejRejY2jYYp60mgzy7a
 E7W+wUBGzDq3fX/iNrU3d1mF/D9wHjLi3WLbZf4exil77joKsuhz5yAZ0S/TiPVD66ei72uDYZX
 DyFRFZm42yVEHqOcLFDokH1KJ2wsOAD5WvoNrRfjaWEJtQ7HeC0uNbW0ZIpW1UhQoqAS7RidY1I
 Kb6m8vvFn/9oDnJmsbkbMR/XEeo4JrJyMDbiQabb44XDtgQ4uPVpEG1T7+I/3btC42bW3eQhsZo
 SH1dlSqaxy2Y65gsELXUIoa3NjBDH8PT4dTfjH1ZoB+sgFD/Tza5Ea6y7cTQe6TuVXaO+PqM=
X-Google-Smtp-Source: AGHT+IHH9PGKxw4U97UM//ZiOa9AL9RdCHlKUT6mQHf4QzekZCoG5SBFxyLQM7vvyaE4a8VqjmiRYg==
X-Received: by 2002:a05:600c:a43:b0:456:1b93:76b with SMTP id
 5b1f17b1804b1-458b69cbdd9mr60330245e9.4.1754296597080; 
 Mon, 04 Aug 2025 01:36:37 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm90288065e9.31.2025.08.04.01.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:36:36 -0700 (PDT)
Message-ID: <843274f3-39f8-4506-8495-6b929cef9430@linaro.org>
Date: Mon, 4 Aug 2025 10:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] tests/functional: Move or1k tests into
 target-specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-16-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-16-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> openrisc tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                                 | 2 +-
>   tests/functional/meson.build                                | 6 +-----
>   tests/functional/or1k/meson.build                           | 6 ++++++
>   .../functional/{test_or1k_replay.py => or1k/test_replay.py} | 0
>   tests/functional/{test_or1k_sim.py => or1k/test_sim.py}     | 0
>   5 files changed, 8 insertions(+), 6 deletions(-)
>   create mode 100644 tests/functional/or1k/meson.build
>   rename tests/functional/{test_or1k_replay.py => or1k/test_replay.py} (100%)
>   rename tests/functional/{test_or1k_sim.py => or1k/test_sim.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



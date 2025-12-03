Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD17D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 02:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQcHW-0002Nf-2X; Tue, 02 Dec 2025 21:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQcHP-0002NG-RP
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 21:07:43 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQcHO-0001iT-B5
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 21:07:43 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-343684a06b2so5860641a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 18:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764727661; x=1765332461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zbVqW3UzFWKzkX443sBxIrFOszeon7IaiPI3rtpUEn8=;
 b=SPwq/ClhI+vJohI551vEv6b09RPl+WXlKJZTKk9Og8thSJRJ8e0jrC5AnXc+/EwnTT
 TN+6Y+ioPulhjmoZrL1ErZ9j8rPwmj7qXWqOOvdJ4f1RYT2FJ6jHOl43ZKZ55WzcQ38t
 +1cMnAOl6HNO5eYyEKooxpx7E/uReGS5e/L4Kd+ZREUSuzC1fTgu6GjmIl50f5e7WgCD
 2nz9NDLSaWgFMk4wZU46GP3qvtvB5H6RDGqUOB8dQgx4nSLroRee2X0w5+r2uGAqN1/E
 mJEZLyODsbNSQKAlXuESlLaFVzbUAv0VjDXs7wu+58FM65Uw0Q8koBxBp/js4qkwycSQ
 9E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764727661; x=1765332461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zbVqW3UzFWKzkX443sBxIrFOszeon7IaiPI3rtpUEn8=;
 b=bu1wIuwX5JEpWlRjCMQZNEvUU3yjENSwsajMnnHRsewYCf4nZ/xcMeYbubmJkbEnPR
 epmPmgdzxoQ9v8m9OvJ99Urf8m3JammS9p84tXesjIfCF0BXNn9Qdn47DfXPELcegB0s
 H5twgHqKGM7nZjg9F2jCcaIKVmWXF/lddeZCUr06ayK7JbnDx0PWMDPd9ywt5llwvuOu
 maU3ro/OizOdDu385cKa/nm+wr151VF60X+BwXs98OQ9FfY8rf3vGa11QKdZg2hAEsWa
 hW1Qw8ewUieOUCwWLDQXjllUwTGAdrcrI7nyMRI90YlFa543X0zoaOTL/b/tKmcMhpQG
 vsMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViKbCNemTg9VkEM7dgSjMn/azDw4KWp3DqqtCe8iXgHKlcVH35bjaxNXudDnPl4ozjXr29fZs5GLgZ@nongnu.org
X-Gm-Message-State: AOJu0YyvbKZDTKhw7sQewP8ZG2xukamS7eRylD/CsKH+4OBW7STgKh59
 HPvhWkkrIsK7FH96htEipigU/ljRTZBX8H92dQzB/LIpYSVwUSc67DWTaZRIxDwDTbM=
X-Gm-Gg: ASbGncuiyok9grehylCVRtpiY4Z0VMfI97ilhCDNzUT7KLWaQMZ+51zyOw3V1vyEq1c
 8GBOfv6TDwMpQDYPayUelbmbjbGVqDH/Dj09R1KDOU7vY8W3IwKPFP1TQ/yShO5kssa6YZ3ORMX
 7ow6YeZzMA993HaUCi8sMFQGNktKDgT4KpPWHlxCytXHanlpfxBkfBBzTKg3tSzVfxGIqdGXCd4
 n57NRlsydxdzM8saBamuMkL9o0tgUTrJJbkZtloiZOCi1S3MIQqND9Fzb8eSYCBFhg631/31ESn
 srQgAgMWR7VQ3vBQr6fuJdqYNHBaYgBrp4HTedhBvvxZ6f4zqwaKI0tN0KCHtv83wu9Vyrt8Yky
 sheSOFQOC6xVGn2ggp8bno+0E2Q13B2/1QGv4CN/Z7MaSeaOxG4bXg66uWBTMhFQNaQxv8T57jJ
 s5SdO1mAo3UnXNBY4OTbc5g3s=
X-Google-Smtp-Source: AGHT+IGNvReAAwPJE6TXIhN7xsQEZqtCMi5IIr0LdAB0fuk9E3VuBWDJFM2Xz7RKxGrPZO7pd5jwQg==
X-Received: by 2002:a17:90b:3b8b:b0:340:2a16:94be with SMTP id
 98e67ed59e1d1-349125ca5cfmr849379a91.4.1764727660496; 
 Tue, 02 Dec 2025 18:07:40 -0800 (PST)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34910b78f3bsm770427a91.2.2025.12.02.18.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 18:07:39 -0800 (PST)
Message-ID: <a61f1778-1323-4d97-aa83-6691704bb90d@linaro.org>
Date: Tue, 2 Dec 2025 18:07:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user: add a plugin API to filter syscalls
Content-Language: en-US
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20251110133442.579086-1-functioner@sjtu.edu.cn>
 <20251110133442.579086-2-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251110133442.579086-2-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 11/10/25 5:34 AM, Ziyang Zhang wrote:
> This commit adds a syscall filter API to the TCG plugin API set.
> Plugins can register a filter callback to QEMU to decide whether
> to intercept a syscall, process it and bypass the QEMU syscall
> handler.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> ---
>   include/qemu/plugin-event.h  |  1 +
>   include/qemu/plugin.h        | 29 +++++++++++++++++++++--------
>   include/qemu/qemu-plugin.h   | 24 ++++++++++++++++++++++++
>   include/user/syscall-trace.h | 17 +++++++++++++++++
>   linux-user/syscall.c         |  7 +++++--
>   plugins/api.c                |  7 +++++++
>   plugins/core.c               | 36 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 111 insertions(+), 10 deletions(-)
>
Looks good to me, and will be useful for syscalls obervation, fuzzing, 
and integrating native libraries through hypercall mechanism.
It's worth merging this.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B220CC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGze-0004tu-Hk; Tue, 23 Jul 2024 10:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWGzW-0004oN-57
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:59:51 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWGzS-0007Pj-6l
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:59:48 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3dae221e42dso2356638b6e.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721746785; x=1722351585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itDshKcnv+H7/nvUttdrnzWez7I19jbHJSDput//668=;
 b=u+Kq8kcGOJqTzJPCbdg0ioZf6O6skRjfpRdrxNU+7z7K00hdt2W0fzISLffMDFY+O2
 LMyyt3i6IA0Ckxigde09da1/G+dzspJKVd5AeiM4HxcgLfv/3bV2AD4I/YuflYFVgy1S
 vFYSwWNJKTeI35cw2ihBF5Xpd35GzzHt6fznIFGhycDwLVnUIn+VUc+LBxBoAevzKFYR
 fikEa9NyFExThaE8VasRYcNLDaLZvFaS3Mo0N0/UsLYaftGHw8MxjY/QgmlLblj8dH7g
 2jFfMBNGI9vnGEyaxfoApa+DVHWOoz54fWL8KHv6GkUTAdcOzpMrRam411pzFBa783xn
 LMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721746785; x=1722351585;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=itDshKcnv+H7/nvUttdrnzWez7I19jbHJSDput//668=;
 b=cG4vXZ1D9HDgUZ+q8207O+finrBJFAoIzKRfCUiyiXXLrqz3iosD7S9xhuDgDuU81o
 KsX2BUUqlTdqqZcngZ1EO3Y9ELOFF1rLFcPDFWaSnsXdrgiD6hE78mkUdJ5HBhHgVboR
 xT0VRaXKuR+GioLivAbNVyAChcCg89Emo2wHyDBT5qQ1I+PRJnQK0ZW3xMDhkZ+DLvsR
 cc9zCmpO3IJuGT9lJaoBHjJXugoER2FJIvRh3+OoDJ1frijc2Q/sc0zE93u841jsImQi
 Ra7d3xT0q+jKkczVlHgv0KVmOcF+FK/CyDU6zAme0JaVcegEv+sG+nNOotgdeUtL1WZ7
 /4mQ==
X-Gm-Message-State: AOJu0YxEkRk+XjuropXAtHaKMQwIpV/entrfiTs/X6rT6lAfjH+9ziK0
 LTD+F+HamQEFnYYmXP9KxS7NqFyxDDbZ9IC8N1BxkRgPCYFx26ynzCgqqAXBIcTN4aJ7fpUt88g
 8CnWg6Q==
X-Google-Smtp-Source: AGHT+IGc4x9NwVI7SJylvMX0V3Lh6q9Fii/6VqLeSKcK1Y8wKPRydYtp5llCZPHMeaj85V64U8zF8g==
X-Received: by 2002:a05:6808:2189:b0:3d9:2d80:2e11 with SMTP id
 5614622812f47-3db06e06323mr50946b6e.40.1721746784607; 
 Tue, 23 Jul 2024 07:59:44 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d270cab28sm3605670b3a.115.2024.07.23.07.59.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 07:59:44 -0700 (PDT)
Message-ID: <5acc33cf-bed6-49a5-9c50-8c6d242b9608@linaro.org>
Date: Wed, 24 Jul 2024 00:59:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240723033451.546151-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 7/23/24 13:34, Richard Henderson wrote:
> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' ofhttps://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240723
> 
> for you to fetch changes up to 3f57638a7eae5b56f65224c680654a2aaaa09379:
> 
>    target/riscv: Simplify probing in vext_ldff (2024-07-23 10:57:42 +1000)
> 
> ----------------------------------------------------------------
> accel/tcg: Export set/clear_helper_retaddr
> target/arm: Use set_helper_retaddr for dc_zva, sve and sme
> target/ppc: Tidy dcbz helpers
> target/ppc: Use set_helper_retaddr for dcbz
> target/s390x: Use set_helper_retaddr in mem_helper.c

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0698D6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgky-0002es-45; Thu, 14 Nov 2024 15:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgkn-0002ck-Vn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:47:50 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgkm-0004wk-HH
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:47:49 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cb47387ceso12652375ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731617264; x=1732222064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TQAffY6Jbc3yb4+aNdQcKrEa6FnLgG8CT4LXibiEXls=;
 b=E9/bUWSryAofzs8kAjJFBqKizENO+7GJE9mHE6hMT0741rQbNi3MLETeWrmjFmuLyz
 FMCvTXkC+ijQyiRmWGRhWdXKQB2iuJaVIaNy4MVzNH2s9+NRon3SivghAVgyiurCAwzm
 ryKVS7cnGn7UOZnDdPL/de2pWuXU93lAr7fmBGvnj7h/PgjhjYA7SOXQMh1pa/WC0P7q
 Bup809msB9EwRk5x+peWZfM4167569L3FFnLH1nisJz5OsCV/PP99FoLiuunW3nIv2DW
 fZKQ7LvQAb7PvTPbjGfQozEhqGxkGBN//8aPhf+r1My8VT1ZNW2T9iyTaeH0NLmFcCOQ
 iOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731617264; x=1732222064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TQAffY6Jbc3yb4+aNdQcKrEa6FnLgG8CT4LXibiEXls=;
 b=Z+yFBWsQDpRCHShaTqWgGTFcdHmN/cK/SheesdqiDc3L7HvPEVaSMOiFxBRLJX/1ow
 sszd9vlAHEpHS6WMKp4LzXOjAqBaRd0lgJFbhxGGXS8HjnIWjcv62cyycjEHa9Obxjpi
 jvPtGrqSYl400JMI/oVIWpVOVgFXEia/19jHbh99Zl7u1mrPEmmVMxsgcQju90ENBx7I
 /uZeLPd0eF3FKBu3+G78L4yoX5C6kkVfQLld6O9XIYX3/u1lO4343CaqIz812EluQW8L
 pH9udd4jn1u4qTMNq/F/+xzXuYm7ABzHY7+t4VsE7soP05AkXJrAYuDd7YcISbOPiOXq
 gu6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlAay0iXCLKfV4yhrN5nmKvQuIcCZ92x16tQLl2UvHWEXYyXWEf4M0HL4xhuiQVuP+FQbEoj0MEot0@nongnu.org
X-Gm-Message-State: AOJu0Yy+NYd7BOHiiZzBchLwfljZSLLXL7WA2shw6JlZyZV4U3cUBbh6
 ZL4geojAMT5YlJ5Dvn4NC64zSHojLsvr8w8IIXQ6Fb2a9lUSe17KPqw3Jr2DSZI=
X-Google-Smtp-Source: AGHT+IHFS/Bm4/pxG4GRtDM6hsm+A2K8VwDnl7hMoSxJRFz1VyyGEhA0kRuDPq8Vmn7VYqOggaB2eQ==
X-Received: by 2002:a17:902:c950:b0:20b:b93f:300a with SMTP id
 d9443c01a7336-211d0d62833mr2748365ad.7.1731617264508; 
 Thu, 14 Nov 2024 12:47:44 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f46843sm463015ad.186.2024.11.14.12.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 12:47:44 -0800 (PST)
Message-ID: <00fa4af8-e9a7-4e9f-8c93-86582739fff0@linaro.org>
Date: Thu, 14 Nov 2024 12:47:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] exec/cpu-common: Move ram_addr_t related methods to
 'exec/ram_addr.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-23-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 11/13/24 17:13, Philippe Mathieu-Daudé wrote:
> Move methods related to the ram_addr_t type to
> the specific "exec/ram_addr.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-common.h        | 56 +-------------------------------
>   include/exec/ram_addr.h          | 56 ++++++++++++++++++++++++++++++++
>   include/exec/translation-block.h |  2 +-
>   3 files changed, 58 insertions(+), 56 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


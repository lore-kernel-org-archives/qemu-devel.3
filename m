Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC91C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiMo3-0005iS-7Q; Sat, 02 Aug 2025 20:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMnw-0005dM-Gn
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:42:25 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiMnv-000654-0d
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:42:24 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-619a8bfef4dso76774eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754181742; x=1754786542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mJFZiTPbpIAODsXhn+Z/mgdZYjZErNd4dde8XFFjNQE=;
 b=pb6j1HHLk/Q2Mb1pRS2T7csiW1l6pFRE5MIe0Xxg4rERsXQfjm7kx5HVGPR3QNcgr/
 cxkZqVXtyKUhbxCSg/uAuPTjHeJe8OKEzAU+f1NBI+/K08B/Gqb5OZmQZ8z4N48U6htQ
 hjMe5ib847TmlFs+oEBZlc6iL6hQpAuctm+XkqhesQ3aL2T94b1NfvTfX6D69RNInAhW
 JXrl33yNNeANuMpvY4Z5YiNwIGhO1Qs+adGUqRbPl0369ykCc3vjQhGDvtIsAd0cn9n2
 w9n+zkjcMjf0k+uXcIPrOLADWH0qs8ZSiWCyeEIIcWun6yBP6N3bZW3qydc/E5G6+CFS
 NjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754181742; x=1754786542;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mJFZiTPbpIAODsXhn+Z/mgdZYjZErNd4dde8XFFjNQE=;
 b=qjNjdnQ7Xswfc4nSi+nRLNJe265D9N7rP69V5P+5o14cgtasDFJ0By7OJjtstnwyrj
 9E1V9yKh4VWAEg/zCqfPvgnHiVzfb2hsg8Wo1g+QOhYpTBAlXAX+o19ibDYYBgrCmDEf
 lVpv94kkfRJuyMNY4+RSVmC+Z+RuzWUikUjPuMXV+yR53fw+Rhsju4gPRx2dCowgmFpR
 XDBEGDCVuHG4ofHqhNF6oDpWfgkABcMzKQAuYcUIZ8VtPKDXNOC43Db+wNiXVFTYEX8t
 oY9VKuvxCx99qoDhWe9JqgE4izCyO32KP61HMfwQ41hxVR3oF3m6EzLBQHkNvcy1szQR
 8S+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrvVC7GNV5TODALayR0XxbhZupns7nzFwNaxzuJ9tL4MPazY9sEetOu3iel11Uwtl7vd+uc52qADav@nongnu.org
X-Gm-Message-State: AOJu0YzcCFaVzz+Yu3NAEmiKu51GHgrADOji16oNdB7XKbf16nwe32k4
 pxxxg79C5NacmlJUpfSnmbfkKBNvXXEe/WenzIWgNHsQ5RwdNndE2zqOTj7lLdJAwkFafnIG/H0
 Q2s5sDX4=
X-Gm-Gg: ASbGnctbFRmyEfCeP52QyuGava6JiTqfyEtLY2m8YPkXf4/UD/XnkzNh3R+WsFS82cM
 eMzvmygY88/sKLoeSyxI3+dknn6tVv2CqgA8NbqLyoOjlc+LYGfLpymYq/b0aOVIjrsu8MzuhNb
 lGkVKvjFriRRDV2sVa2++CmtUXMZTNcOWW+JcTqTBG1ZUIxjXwY1QXonbKfkymLinq2BJNdz5iX
 ZWKuj48uv3ODPvM2Es4WdVFBu+2cpbYyJM76AGN8GcKb27+S2hWZlCeW275CBBXaxs4crlHi+WO
 z3qwC3MqaOHa9rmfe5Ay0eWA69C+gPybgElYjAz+UHTITb9CzLdhKHHMMdxTknTee+53GbfNzVz
 v1wqt/4unOQsJhcnzj/vIuu5bKL8rWD1e+kwwGwTh8ipHCzL8Tn2Yk5MI2yAZsmQc
X-Google-Smtp-Source: AGHT+IFMCEcTRZMFzlkHch+WVETNq26tyUDNNRfYJVI8w3qBCSa+D7zMdM+zIdxgfnFxgL9pWYWc8g==
X-Received: by 2002:a05:6820:290a:b0:615:7c7f:4aa6 with SMTP id
 006d021491bc7-6198f2347b2mr2588763eaf.3.1754181741606; 
 Sat, 02 Aug 2025 17:42:21 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186caae03sm1488781a34.6.2025.08.02.17.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:42:20 -0700 (PDT)
Message-ID: <db57ee8b-3c57-4247-804b-5f78252b5db7@linaro.org>
Date: Sun, 3 Aug 2025 10:42:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] hw, target, accel: whpx: change apic_in_platform
 to kernel_irqchip
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-6-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-6-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> Change terminology to match the KVM one, as APIC is x86-specific.
> 
> Signed-off-by: Mohamed Mediouni<mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-accel-ops.c    |  2 +-
>   accel/whpx/whpx-common.c       |  4 ++--
>   hw/i386/x86-cpu.c              |  4 ++--
>   include/system/whpx-internal.h |  2 +-
>   include/system/whpx.h          |  4 ++--
>   target/i386/cpu-apic.c         |  2 +-
>   target/i386/whpx/whpx-all.c    | 14 +++++++-------
>   7 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


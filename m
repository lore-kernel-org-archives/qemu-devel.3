Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B086C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzrr-0000Dk-LL; Tue, 25 Feb 2025 13:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzrC-0008Ow-RB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:40:48 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzrB-00081O-8m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:40:38 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220d39a5627so92806055ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740508836; x=1741113636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iecd+Lf9+Xb6NF73imYU5tlVpOwTHcPVUlgvAg2DI6M=;
 b=L7XoMpw6It2Hge3i8xAy/71N8ZXWCXBKFfclukQDUXFcxeBggAsyOBl/nzFHrYAeZf
 aBWS+R8vfU6Qv7z2hZNjOr2fnuaYw5KM3Bw3MgNOsZlFaA+ePoJp30JA6UL2Vloe9MxL
 fGtz686EWd0z3gywTcAdxYBZCczRE5GApP7OIyKo1rBB6Jr1/FbX4YSRvG8HW4OtX9a2
 5tT076XW3+NvDNwW11GLNhXFBeIjkDHN9P5UepSGj+DL5sO8VMLsFYSddH6a36UHlfay
 SByJ1a/TBQUM2jXLuwmcxPHlMI8n+X7Ct1Al/s43Yl7rrBwxHmu7V19xM5Jj3xeDABl3
 uD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740508836; x=1741113636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iecd+Lf9+Xb6NF73imYU5tlVpOwTHcPVUlgvAg2DI6M=;
 b=imGOyD6dNg5xma0jta7iWBiroUJ3Hy91WpqqNwS0wJ4llht+NdPrm7ndFzc3D4vRKG
 p8BgnsIfQXSaKO+Ms0+injweH9HFZJE1f0rokxgNSZyfYQePzjRzHIjWumiEpwUkHtK3
 FVw+GIk3CoPOyzXat+ZxpRhoWzAHF5pjxVFryfcEV5Frkuo3pyzepCGyOCV6yHu5w5fp
 Ns2Rx8C5w8mzm3RNVgQsWPaJNVIna+EozUimdAwyar18MYQMiMsxVlgjqhDEgH/QmmYM
 AhPzbNSSquG2x+cOX/tfeY1x00iayLSD7uey88VWCiEEGmWaxzagvoFbL+MgMtj6n8Oa
 fENA==
X-Gm-Message-State: AOJu0YyvCIt7EYU1Gn0w+oj3zJfB7h6Hwdfgj3lkiFT+91QgWU4vWKEx
 R12OUuZDFNIi2zTeFvJGq5eUC/gV8LeE9s4xaDyMdQ8R+11Nd56SoliVPFAb7W1K9wYBNgT8Oq8
 B
X-Gm-Gg: ASbGncsQItXBZkCtwVXAspfpJ5DehcpPtDdE5+e9PH3Oj9N535P4l+L7jjHhSLh8uaq
 2TXNFtklz+qotk2Ni10DKZlSnHwsrfIXqZul9bWtxR36BsQPv3FzNjlfWF53UcmKgW246jomGe3
 HnPPQFXBcxpcAulMZyYT8mkKnkE5bq1/Zs5J1PKrsWPvlMoqlVjb/e9hjk94fbyrKr36R+TudYp
 coOTo78JsUk15HXLvoUgIhEQMGmNBUfOoNla0GcaocvLL7h2xqRpUE15mky/xAhiWiL3qRWDc/i
 OxhCpYcusMCJLZWWv5B+aawJQDEcDlD5y8eR1zHt47DRk7tEkDVuOfiGbiFMFmfMU15dCqkrk4B
 4OCQH5Z4=
X-Google-Smtp-Source: AGHT+IGmvHKVvqBWfUmbXh5HdIxYHLTw5ryqaPUfffUYNyE3rCjRYghQn7b0vQFQB8GSpx2r2WubSA==
X-Received: by 2002:a17:902:d48d:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-221a0025a63mr316235285ad.43.1740508835695; 
 Tue, 25 Feb 2025 10:40:35 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a092f4fsm17584815ad.112.2025.02.25.10.40.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:40:35 -0800 (PST)
Message-ID: <dad41a1c-b48f-403a-9deb-6e8ea0a82e71@linaro.org>
Date: Tue, 25 Feb 2025 10:40:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] plugins/api: split out the vaddr/hwaddr helpers
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> These only work for system-mode and are NOPs for user-mode.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   plugins/api-system.c | 58 ++++++++++++++++++++++++++++++++++++
>   plugins/api-user.c   | 40 +++++++++++++++++++++++++
>   plugins/api.c        | 70 --------------------------------------------
>   plugins/meson.build  |  2 +-
>   4 files changed, 99 insertions(+), 71 deletions(-)
>   create mode 100644 plugins/api-user.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


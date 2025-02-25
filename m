Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B03C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzjQ-0004iY-Mx; Tue, 25 Feb 2025 13:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzjG-0004fw-1u
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:32:29 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzjE-0006JH-1Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:32:25 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220ca204d04so99614285ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740508342; x=1741113142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vhRWUh0pGofobAMYPm71nVFpEapdN6L9dANct1fFmfQ=;
 b=BRlg+VVrJiRi2HFnUNK5S3lzgGrDHeYLcNWqWenTpl4KuCclmo5hAlZvSyq/Js5CrG
 u1tvc6+kMgHVfktDhd7qxyjCOnK7zdhDrF+n5HEpnEoNXE63WROcOCkQh8aDkS4INydf
 pkNPfzvfJ6h4IFevZRJb4TAM074kG/GkjgQ6kxsWjCps2q/leq7cWFeBvZgIIMQ9dT+3
 So5UoQEGY1LwD53uUJJPjYp1Is1sc6aRj0YBFc7DOA7eaSHRxwwBfLYVETMWp8Pxjsbz
 0TC9cMVTD6dXAsNne07pOCd9HPcBB1XwRZnc5zX1VN6ru/xdV+cUbxIMNwbTclQv9SY0
 i0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740508342; x=1741113142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhRWUh0pGofobAMYPm71nVFpEapdN6L9dANct1fFmfQ=;
 b=E/Ym8isRvo+QnRfexY7E72AvOaQk0GZs/nZQ1tXt3J2mthX+WBfM5hzniuwESpWi0r
 LzRFJzcEB6n4ogvcGCFIpUmTTk8x/AXNKHUECOvg1lVcag3rKpbpyxttR4jXRi64gjnD
 ABaEciWSEvhqK37i/+bOGdiQ/iSxb+5F1yyD3Cdv8d3i79HMw1gOOvMF+Tr1/NC9FQIa
 Udvox7j2tU9ahciQpyjrij46wgR3ZTOJUP5drBFeq+bEhiTUKuEErYnUR/0If8saUeFm
 o7E/R6YfYC5EuPtfoD4XlE7CttfLZqwnZXUej8FCejHGLYRqYF51/efohm8/tIgjwXYC
 hPKQ==
X-Gm-Message-State: AOJu0YxuJXWZzIlPI9Eszp+RAAEjVjiFUmxOaVC7nhLVAi/ipotOzr28
 m114y9QHO0dwb6wbcURqy2Auv2aBWclyk9wpV+PKSUKDamAXFKafiZEuWpGz0KxPSpSfl0jmrN+
 g
X-Gm-Gg: ASbGncvkFaqQ4bPRCfeRZHjfAMNW+Bo3s7+yPKWXFMZ3dxnqr27PcRdk0XbJIBjbOGD
 ei+vTbdMXoL/a5qh8gMX7l0qp8mGhEq+sWUxI/1vN/JmoxZ8mDR+9w2cCtoYXhoKwgNBW3KTa51
 CwHQos31pYizf+ZmTeK7nraSab3sUOBZKimuu8ihKkDn5doDFi4JZSPLR18XVmpDWcQnYEuYJF7
 YYy7PJYrfL42xNNq8G4++BxPtrkWGAKTIMIKwYON2ctcRKdvsMYO/OsZo+Aa6rvxrenwP8opJNp
 UG5tCKN0L53TdRgmlHJvRWlhGGBl34bX1Qfj/y2AezcFD/AmdCM4BSeLrSpKJKQCrYcOUPAw/Re
 FZ76EfJE=
X-Google-Smtp-Source: AGHT+IE2ZJ1FWe+eNHM9rLOOMxWSR9zVhE1Ck47x8zOPQ7IV6xjHolVpaI82B3jdlkcneUTTQpVlzQ==
X-Received: by 2002:a17:903:22cd:b0:216:2bd7:1c2f with SMTP id
 d9443c01a7336-2232009991bmr5991185ad.18.1740508341841; 
 Tue, 25 Feb 2025 10:32:21 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a00ab18sm17624765ad.78.2025.02.25.10.32.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:32:21 -0800 (PST)
Message-ID: <5c79e077-138c-4013-bdd6-0719dfe1e26f@linaro.org>
Date: Tue, 25 Feb 2025 10:32:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] plugins/api: split out binary path/start/end/entry
 code
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-8-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-8-alex.bennee@linaro.org>
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

On 2/25/25 03:08, Alex Bennée wrote:
> To move the main api.c to a single build compilation object we need to
> start splitting out user and system specific code. As we need to grob
> around host headers we move these particular helpers into the *-user
> mode directories.
> 
> The binary/start/end/entry helpers are all NOPs for system mode.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   linux-user/plugin-api.c | 43 +++++++++++++++++++++++++++++++++++++++++
>   plugins/api-system.c    | 39 +++++++++++++++++++++++++++++++++++++
>   plugins/api.c           | 43 -----------------------------------------
>   linux-user/meson.build  |  1 +
>   plugins/meson.build     |  2 +-
>   5 files changed, 84 insertions(+), 44 deletions(-)
>   create mode 100644 linux-user/plugin-api.c
>   create mode 100644 plugins/api-system.c

Surely this breaks bsd-user.

Ideally this would go in common-user, but I think you'd need to move structures out of 
{bsd,linux}-user/qemu.h into include/user/.

In the very short term you could put plugin-api.c.inc in common-user, and


#include "qemu.h"
#include "common-user/plugin-api.c.inc"


in both linux-user and bsd-user.


r~


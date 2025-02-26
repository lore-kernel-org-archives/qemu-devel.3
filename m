Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CB9C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnLEC-0008AS-BQ; Wed, 26 Feb 2025 12:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLEA-00088V-6K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:29:46 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLE8-00015D-Js
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:29:45 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e86b92d3b0so786246d6.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740590983; x=1741195783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Y8SQmLgZSE5V6xH1nsqlxFU5e97U09oBmMkfi710iA=;
 b=jSi9ZqwkIl9W8Vr2HPAMpf8OrKnujTKK0U84z/783gDatDsDDZVfhvGoZkZCsDqAyC
 /HvoJrhVsZokJdPbk7hgISJGNAeMJY59xGNaVXqlv9wN7Nr0rxnikAnNaVC1Yb2+SkgL
 ArZSRJYUE11IRFtUthkYlWSlVlkXNO3eV7SV3uW3u1QgtMHQtRtZXCtAN2vEAa23WMFV
 p0r1jrgLQGD6XbLCgyUrP6EPuQzPSySqszm/TWgNtxvDLGZwoH0vUxV/bY965SJM8DiK
 hf3R9ky4EWMu5sFdwWrbjq17q5MW0YkZ6IP9aEZDigp7VX5lDtO+i/BpXHc+FUyFZdtN
 qT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740590983; x=1741195783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Y8SQmLgZSE5V6xH1nsqlxFU5e97U09oBmMkfi710iA=;
 b=lQCu6NIhw+rOXGXJG1v4BtidV3GWr93K225pMqrfMuRGz/AiF+LcUcWtiXzOGRXSCm
 YHkn0dc00Olkpmoe64lPtm4Y+u/+zXKF1vIeXdOMNg7rXOqX+e7NK7KDsZkdgjYt03fN
 mmXRXumrFlJ7/oFpsT7NIzHWD1NkKolnnPCgQ+cAFxZBymBoOpHDxLAULvHwQbhRwrff
 QQe47lNx4K04LG2vbrKTzmiGojqQ/2bStOc+y2Eu2j9ApDz06Lf6967XYPBHT2GYl/xg
 56Pdp8+aP8UHI6nzr1VIQ9R8y3MuVsHZdKykjEd3IqskkvVq2Tt7WF3qjUS+9mDwvvGj
 e/Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQBxgW04EMtIRmy9yNWjt4zT2+sYy21RGVyBpUEDxOzQQCIa8HG2geg+fcmXrP4gvBaSKyr7d9fzRp@nongnu.org
X-Gm-Message-State: AOJu0YwbpRfj1XIC2/wpC1Y+UyLoTjEQU+WswYuTRoaZRo8AvrUqCc67
 d8Cu4REQSwXc8xcrQMD8QB6wbVuIJcsUwPpo2FQnq5W4PhLIGm4oGMr6W2m5sk4=
X-Gm-Gg: ASbGncuFpI6T/TgyCCb58+u7Dh7NZngeCkdTxoYMBXJBGkAp/wiDI14wFsHqTGdVgRG
 nuDJOu9+bTcB5OfNOeO5RS64Tg6+UgpE8EG+cntPc9VkL2PimcW4XSlsveQzgJ81oE44G946G8e
 3neenKBZDvl64T1OIcZPNtm+dnaC/xzNC7KVZ2iNAO8IqdQkzW3FhpEsGZixrT07qLseFUivxUe
 BTTay3EkGHJzdZ+X0VZc5nFJILdMdO1t1IDGRTphIg1YQF/KFMgPTbmDm/T8b6r60iv4d0uxu/A
 uXdR4YgY5XTqed5MGGhvWasTorbY+37CxoLHU8XEKMn3+7Tr
X-Google-Smtp-Source: AGHT+IHoK91KuMDMFNvo6N8qZ9AgYWv4K4G8wk5FcMt/sOmOVj8oHopBsomP7QMgfIu/dNkEB8gq8g==
X-Received: by 2002:a05:6214:416:b0:6e4:4484:f357 with SMTP id
 6a1803df08f44-6e87abaceedmr103962186d6.30.1740590983432; 
 Wed, 26 Feb 2025 09:29:43 -0800 (PST)
Received: from [10.254.143.227] ([172.56.201.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e87b19b1b0sm24817336d6.125.2025.02.26.09.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:29:43 -0800 (PST)
Message-ID: <5560fc23-d99c-4e86-b771-b6beee90a769@linaro.org>
Date: Wed, 26 Feb 2025 09:29:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/25] plugins/api: split out binary path/start/end/entry
 code
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-22-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250226140343.3907080-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf29.google.com
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

On 2/26/25 06:03, Alex Bennée wrote:
> +++ b/linux-user/plugin-api.c
> @@ -0,0 +1,14 @@
> +/*
> + * QEMU Plugin API - linux-user-mode only implementations
> + *
> + * Common user-mode only APIs are in plugins/api-user. These helpers
> + * are only specific to linux-user.
> + *
> + * Copyright (C) 2017, Emilio G. Cota<cota@braap.org>
> + * Copyright (C) 2019-2025, Linaro
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu.h"
> +#include "common-user/plugin-api.c.inc"

Missing osdep.h here -- checkpatch should have complained.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


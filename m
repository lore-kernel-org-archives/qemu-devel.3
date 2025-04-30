Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA7AC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAjS-0001Ci-Fl; Wed, 30 Apr 2025 12:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAjQ-0001AA-1X
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:56:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAjO-0002sR-Fx
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:56:23 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22928d629faso631995ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032181; x=1746636981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v8WZlR/gE4ZkydO1COZ6QNw53IaSCpMyWaFYWU0u17M=;
 b=bX5OKsLw0dlZI3u0/w2ODBdTXcaRGmx8pVOMIzB5DisLMVTVfYMKazT2genwssHYBf
 gZo+LthyzlSm5u7VjDdgP75xD6PXBS6y1q2EiEZqfY5PtsXkpbr6gTdv4zWZVX3kt+lY
 bD4DyEVw7encsWn9N/UnDAoOv3V0/Z6m/NkkQHlaKame32G5fMY2ZQMdsSytfLAqWxyC
 RfOha0pG1kFzpMTteQuCXyLTaj7APvbAt3Xo22ag725rTpTAyW4/vwGmHj3wneGxmeBB
 1ASEiAfie9VTfrYRrnjWXib5xt2kyF/Lam8kMOs94e7iNsSE4tRoE5ATYR9BeSgPJeVb
 2ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032181; x=1746636981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v8WZlR/gE4ZkydO1COZ6QNw53IaSCpMyWaFYWU0u17M=;
 b=pvJWin5QEm0V0Gm6uvtYWEjwBXdffYDwUVEVp2Val+x6eFgYwkQ6NcIqCchPzJdKga
 9bKALrztLEnS9CPnKRIQ3m9U8IYyi+UK4Af+zsid+aZ4AYckIdEtmIfnZ6YCGwzttjz/
 qUA1s+sNUpNdk9RqYPQX7SquFRyjOI/dSRvxpKTPmuvrQ2WU+DXxySk5zJCyi4GhPeNG
 Ee7y9uRQjZJItfdfGiHzEpw2B68rh2XoC+Y4sW6LsUaMieDA+2ZcQLsBymy2ECK9nPfO
 LM42UICieIDZfQRTQWS0FbIlCgVdFF+HeTW8NR61fLH+pwy61zue8KIaUnyLq4h7cTF8
 y/1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtPTHISwXDCrdzgUdEhLddEb2QuUQX6mtpvQqJZm/7gPTkcLoyqb51w+j1DqyXbOTkL/n7QMiN28dF@nongnu.org
X-Gm-Message-State: AOJu0Yx1nXqkMhMKxSOwGDdTkdsAEpmyd5kYYl21cNGZ7ufNKoPrPOgT
 Zf5sGQZU8lJsWDQuNMyCOkzUH467tIQXVr+XVOMB9e5zkbFxCWEu4/3/gqz+xcY=
X-Gm-Gg: ASbGncuik/nlK4V6d0G5PrljOKIM9c7kayas3OUPIcLBiuFEj686Oezp8vCXc9POCpR
 vCgdT9YYx7x2LNwxfhQEVzIBxUi0E7l8eUjEm5RMvHblPkZrti091Y8i8w1MBcORE7Z65PmTzP3
 lHQRpZv6Asxk7WllxcInvyqdyUvJZSViflT28VcjhxSeMnXiCk476a85PEtYJ+jS9xfnQ2gYAS3
 RIgzF34oWy3PKraAHGEoAA6Iqfpz2d4ZFjC8XdoPTcaOpkIRqUttdPbQ4i2yW9Mea0uUR/77xUP
 ft/DvVT/j82EGVxx1qSCkBSi+yt4mlg25aXRSOLr+w3wGZmChugI0w==
X-Google-Smtp-Source: AGHT+IGFT4Z/rWfWLkljVN30pdSfr0/3ueJCV1zl3KB71fXAATJ8QwucyvWCxA4uxosOWv0hrqyvCA==
X-Received: by 2002:a17:902:d506:b0:224:2a6d:55ae with SMTP id
 d9443c01a7336-22df358776bmr72169465ad.48.1746032181076; 
 Wed, 30 Apr 2025 09:56:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34721015sm1897451a91.6.2025.04.30.09.56.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:56:20 -0700 (PDT)
Message-ID: <fb9dad4a-9765-4434-9d35-3b3e39ef3f77@linaro.org>
Date: Wed, 30 Apr 2025 09:56:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] accel/tcg: Use TCGTBCPUState in struct tb_desc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
 <20250430164854.2233995-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430164854.2233995-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/30/25 9:48 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0500EE01FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDmj-0007xC-7e; Tue, 10 Sep 2024 23:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDmh-0007wK-2t
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:12:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDmf-00085P-J9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:12:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so298042b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024363; x=1726629163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kZi6DB5Xp4jUz/2ICU/cAXO1ACDY8ppvpkPWThoq98E=;
 b=z6bFn4D3Om3tAvBrbhYM2NGYxrNm0VmseNTNe+IxPC/JMlLjhUbxD351FDszlfFSMH
 hGSR/z0bfQS++X/9hNbjTit2ujXwwU65LmJN6gzu2PCa+WOsvZNpZZfX0u+1WjFVLl6z
 sDLdMIDmNbpYJD7O4eZSzWv9nsr5S1oOBPgOvMMpn3KO9j9gFgZJeK4coz2S9+6wKiHN
 6RcSdPpL1VQ/kbyI9fQZS5iJS9/FS2tqRxSXRUEalOuEqD+ay0DCxXLDu4Mi3PtC9mJV
 OpVezq2w0bCGZX2nLjW0uiCI21TIZzneKhcG8rMzSQk234JfNriCe9MzWv/AUjhxUIs+
 tbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024363; x=1726629163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZi6DB5Xp4jUz/2ICU/cAXO1ACDY8ppvpkPWThoq98E=;
 b=fJGpEW+subCkyyetvLMdo3OHOcZ5b3b3oMxovgj7hlDFOW7rzsUsMxzUagAYx3ffQh
 HuiBLVde9WilU6paBk8faYXgIslXbqhtmN82eNVhI3KwJ5giaQad6h7lbj5otQCdOZM+
 PULcrNT5I0DxT/rK5gdMCBDVPGrV1rrdOR1GLPA1UvxASNPYYeB05hP8RMZrM0qTEOFh
 SaJ8f7LfhTUlIh9/uxBLBwhSDS88U1JAnOd4AuCB+t34yey71RmX0CpS5YhXI8ICU09P
 mj25P2uK3J4yILu8sIPRpxNdQM8c/QW7ZnUbwACxo8uSDKdE4ZtpkQSzuRyZyQHq06az
 /i5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBqoHERN+Fm0xzSaqrmUs8lfMQUHC74xyQN5u2IWTrQsi1nVqsJo6Uei9DBetuyrMLzLFSDTe54fXS@nongnu.org
X-Gm-Message-State: AOJu0YxAoGuroMC6MyyisJ+QXdR8NdyQTcpwQrgaE4pBOuv6K3uCEKSG
 1cOy/lEi+dfDAEBUIDiny1kfelTELd78C1ZsfNMXlOXWdAyNVbzD0bkql10piOqJv+5VghFDaMH
 w
X-Google-Smtp-Source: AGHT+IFbhwOtXJk/GcjrS6ll8n0f3c+SchSjT5TwAiWz/w6tRmmeSW9J0y0NlwTb7Gs4Rjki/xrwSQ==
X-Received: by 2002:a05:6a20:e687:b0:1cf:38cf:dfb6 with SMTP id
 adf61e73a8af0-1cf5e4d41efmr3875544637.20.1726024363340; 
 Tue, 10 Sep 2024 20:12:43 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71911115a62sm1491107b3a.32.2024.09.10.20.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:12:42 -0700 (PDT)
Message-ID: <a9e9b285-b8a7-4e8d-8926-42834c07e222@linaro.org>
Date: Tue, 10 Sep 2024 20:12:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/39] qobject: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qobject/qlit.c | 2 +-
>   qobject/qnum.c | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> index be8332136c2..a62865b6423 100644
> --- a/qobject/qlit.c
> +++ b/qobject/qlit.c
> @@ -118,7 +118,7 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
>       case QTYPE_QBOOL:
>           return QOBJECT(qbool_from_bool(qlit->value.qbool));
>       default:
> -        assert(0);
> +        g_assert_not_reached();
>       }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


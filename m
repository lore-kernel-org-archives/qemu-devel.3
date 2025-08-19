Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE13CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUL9-0001Zc-KG; Tue, 19 Aug 2025 17:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUL7-0001ZF-QT
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:57:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUL4-0001Zr-Uu
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:57:57 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e2e613e90so4273952b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755640673; x=1756245473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BcgzQMjuwIa3wVycyxfLqfuZ5BwjMPMzKLv3kFMa98w=;
 b=fQ+2hvCD6B03j8OcKZRVrjR7hgKGio8Q8XEsXTEQLB8P1o8ZzvKJ/bv4ftZ4OAQonY
 /W2eCriHPrGlH5IqwpzdN2la3TYOgswgVp7e82cEHw1ZH3CktvvFBeBXwBtrnEiGB8MQ
 A90dyQtsYaGICsel7OaAHF3d/EhZHhAP384xKLqs4ou9IjvI+Ce/MFlUiIwzcdw4xgeV
 ismsB8Wvg6M5Wk3X3Kaqi20JnLFxlm4IA+PsxSnjFEhvLFI76TzDc43tRgysyvBPV8On
 BR/xSd2gQpmiwhRSxZIrHXw6Bj8tlmL7tKh4+CHr2t+7k6mQ5Hh+P1h4iqXoKSBrGZvi
 wJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755640673; x=1756245473;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BcgzQMjuwIa3wVycyxfLqfuZ5BwjMPMzKLv3kFMa98w=;
 b=fsksWPf/oAVqUgC38q4caCV0p47HN5a8A4VAab2MijH8PT/9zFxFiA0mowqVWpimQc
 rsA2+Cil4OSScPKNVJcwRviEF8qOw8430TczvnnFV1MdvLWZ0/cdoOlUDGQ2HpZp4v3J
 uXtCRZHAx3fyGUtFuiO4ysFEKE5p7wiOLX3qmdzZo/7I9RLWQ2z4IHlVFtNz4geJtr5y
 cCvLemCNtdcdVnE5hMJH8gO1LAE8vYWPeKgkPMUvdmgaPMe8X7sikCfrqSldk0dHNg0f
 QFd+8Kt+I5ShizotTdSNoTs/r4qlR8iTZ/HIBY5p8DohzjJvdT67utHHbbZrEcQL6jDu
 yprg==
X-Gm-Message-State: AOJu0YyT+YJAKRTwblPq9QC1ltbR58QMRG6lbaiypcRTMq9Q32+/Eynx
 CVyefsAbU4A5nYBpz4lnAQiH+Ipwvq9nIjk6hCbtE76/NixmO9hs43DYsh/Sa6sEhIgT1TcogGo
 KPwlG+YU=
X-Gm-Gg: ASbGncvtmqhvYp/vTmNRYorzyFQR4CCFO1FoeKDQiBevwAsSOCl4kt+6Nr3KhcXOAGc
 rjAe1Oo1oIFN/jbAfFGD25YDOgORp+BuzRdDCN3FbVWKin8qnYRXnqX9RnyupJXCeSiLK76UO0b
 RD0HKUv/4KQWcNc4HL0eCiPYCl4BBAqfd95pNFQP2sJ1RW5G+rRrMt9ZUi2l74hl0ti4bJuYuqo
 l4y+UgDnDXs0v4AsK4xUVVt+bmoAK+HNJJbCWAmo5vLxb5LpJa4fkj0CLDtO+tvNK9CsSGIjRIS
 Rr+jitM3sS/SMibk/Dt2EDHiLz92bKaC1X473wQMVLaDz7uSr7qHWtGpM6/qiWPcubdXq7sl8Zx
 qFiOzepePbj34d0rgoDpUnjynWOupzE9UZg==
X-Google-Smtp-Source: AGHT+IGHesxQ+3mieBNXvtOvRMcR1Iu9XauJG+TbXYQrEUiPp0xQ6DPNo0GqTgly8ywCDMeGf18HxQ==
X-Received: by 2002:a05:6a00:13a0:b0:76b:d7e7:f1de with SMTP id
 d2e1a72fcca58-76e8dd39cc0mr1015715b3a.17.1755640672651; 
 Tue, 19 Aug 2025 14:57:52 -0700 (PDT)
Received: from [10.0.0.90] ([120.159.20.238]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d4f9bf7sm3410259b3a.61.2025.08.19.14.57.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 14:57:52 -0700 (PDT)
Message-ID: <bc2a7355-355f-4207-a0de-5a7b75fe3da9@linaro.org>
Date: Wed, 20 Aug 2025 07:57:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] util: introduce common helper for error-report &
 log code
To: qemu-devel@nongnu.org
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-8-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250819202708.1185594-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/20/25 06:27, Daniel P. Berrangé wrote:
> +char *qmessage_context(int flags)
> +{
> +    g_autofree char *timestr = NULL;
> +
> +    if ((flags & QMESSAGE_CONTEXT_SKIP_MONITOR) &&
> +        monitor_cur()) {
> +        return g_strdup("");

In the event we want no context, we really should avoid memory allocation too.


> +    }
> +
> +    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
> +        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> +        timestr = g_date_time_format_iso8601(dt);
> +    }
> +
> +    return g_strdup_printf("%s%s",
> +                           timestr ? timestr : "",
> +                           timestr ? " " : "");

g_strdup_printf isn't the nicest string concatenation tool.
And again, there's a no-context path.


r~


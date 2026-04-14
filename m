Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B7F531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRuW-00064n-74; Mon, 13 Apr 2026 20:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRuV-00064Y-9f
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:45:47 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRuT-0006w8-G0
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:45:47 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so3224783a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776127544; x=1776732344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VoCslziiPwaWRtUKpDtrC+VAakxSfNwHcngSk47IUZU=;
 b=nlJ/sPy81UCRUTYlG1xNnzNUbvMziO+iPH0CX1Qh5QVj6Nzbf+l9BIWjtEUnF2jNL+
 driimBkNPsVijXNEbDWPSQNovGyL2rzdsNOe9lDoFPo88TSCw5CDVUjAiNynpiJzrf4W
 R/Tcwpb1XzCEhQ1/ivtbpj3AnRQNQkiBGXaqVqCgB+cPWHnNvMAgH7jTjYL60OcXdwT9
 M+hY15cCEOdIxE7vl099i3iExTZ+SylDhtekJdSHgDxtCZApDYMeccgyau8MCef1XEpo
 eJguzE8s0eFnztscD3nTB0Ec/+GhXOvJoQic9EibBEjCbwvRzzMeoocYEireHRMwoOJJ
 peOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776127544; x=1776732344;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VoCslziiPwaWRtUKpDtrC+VAakxSfNwHcngSk47IUZU=;
 b=NcKrm6ofK4xrhnneTHn5OQyVTFnJZ2YjLuuHoyS3SuSeWvUlnqldZgAQ7Nx2FCEEvU
 sqxBdzj8+2pFVnUnSPpcRHFigccX+hjKbw08cLgTgvX26CRwDCwiGUPbUcGcCqVlgZAf
 MwYiqtOaCTu2Ei8bMn9/tkDjNDRxJjWbH2LkPTn3Aell4gU/mjezdY05O+H4OLrDE+4f
 ylUm7aKtb6uQCgc5Lm/SzBPhTMtJXDIBdqcaU8Dv7R8kB5bxmfG2zPSkE1djF3MYnBBO
 Yf4iK2Ddz4l42SrLy/RYeEzM5YfJiyWH11nEFyxrp9EWWwfF/RFuu3SiaVF4J0yv9h6S
 dqAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vUlwRIZASdnDz3pdcyrL5rLK0fPozrxySsekgtK5xKBNniNxip6n0HC+O9WQPa6Js/qnQ2jMAPbEB@nongnu.org
X-Gm-Message-State: AOJu0Ywy/zCNi8qzWvq2do3Gs4NHAzplkadrckf8WdAyCQSJTS/NDQOa
 n0NqTFO+Vt/kLr1DoZfRqI3fQHJkeAJMjRH6t3eCZMUSnaJoesScQMrA86NbgK5v1WE=
X-Gm-Gg: AeBDieuXNq+YIqLGceOKKMS1L/DBSFh/47rlIZBdsH2PV07TZl6D3CxQ9e+7r0dG7b+
 TW7PIqHD+TcsO2qGARe4ZlO6h7yBrsXiFoHB0rRlv3jpFj2rHl8WFSHgpt72JH7sAjhSDS662r2
 JSs+TTY6d8dKx7lz7UBLtMGzI+NG1JbI4hH7HECm/nbMPCh1AACsuSOZ0VWAUANNjh0n9HOzhad
 JaWqOmNSP0pyIM/ReJyHR9mxJDWYvU1aEPlqHFqtGrpWvDctCdSPOWSy/yNB+rkpWd1FVFh6W3Y
 aBjDT/Upr7ElmZfl8kGLryejQVQSPpX2x1JfPegFYjxNq5RaS8O9vByJXXW6C79YVfOLNtwO7pp
 3DVY75zaxF8X1zqwKJu+I+ma36deUjesRv6S5LYqUuqn8Vna/yaAxM1wfv1hBKrdZcGQWdwew/E
 ckc3L+6FDHTyvVyHDrJwc7dQ99YCnujitjlY/44ma78SK7qXMokcGAg6RaYxxNUj2I+zYmDbonX
 +1P4ztv9oIfsA==
X-Received: by 2002:a17:90b:4c8e:b0:35b:9ab6:1d4a with SMTP id
 98e67ed59e1d1-35e4280ebc7mr15683526a91.18.1776127543578; 
 Mon, 13 Apr 2026 17:45:43 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fc6f67d76sm203884a91.9.2026.04.13.17.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 17:45:43 -0700 (PDT)
Message-ID: <f7cc3f4c-788f-4e52-8de8-a0d2944283dd@linaro.org>
Date: Tue, 14 Apr 2026 10:45:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/27] monitor: Restrict monitor_set_cpu() method scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260414003001.97571-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/14/26 10:29, Philippe Mathieu-Daudé wrote:
> As mentioned in commit 755f196898e ("qapi: Convert the cpu
> command") 15 years ago, the monitor_set_cpu() method is a
> temporary bridge between QMP -> HMP and shouldn't be used
> elsewhere. Make its scope internal to monitor/.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/monitor/monitor.h  | 1 -
>   monitor/monitor-internal.h | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


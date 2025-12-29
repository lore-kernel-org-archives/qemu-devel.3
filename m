Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C2AD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3rL-0001Hm-Lq; Sun, 28 Dec 2025 22:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3rK-0001HO-5u
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:23:50 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3rI-0005rw-N6
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:23:49 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64472ea7d18so5563851d50.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978628; x=1767583428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=llH/i4hOyUEQaOaNKcIuSsPuy4YcM+ohmUHNZZeO26E=;
 b=XROtmGc3ykTfW/U6etpphpd9WK/euCTKFS0e4ExJcjtsgOkM0iyiUuVA4p865qEDn0
 xuIpJ2hMYlDsyT+3IadECcLG3Gnioh4IRX0wAWf5YfVIPbIRzh2KYSDIXNojO2QWoGGx
 I/4fZH8PjMUf4ouebWL+j9tBD5HlKeLnifkSIyFY8pZB9RpuVRnwd1OPSU/Z8jJSihLf
 Zu/8GwmpScJFs5HZYa6wZHHYjq9VGZ5sgWH9/vFnoEjTqcuFz1znivNn5ZlHhm9XProo
 QuuzsJpD1yiqwYuDVfiaYFLfvJSSPQOOtnbaMnZUC70yMrmhr/pTTqD2SZgynuZS9o2N
 0/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978628; x=1767583428;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llH/i4hOyUEQaOaNKcIuSsPuy4YcM+ohmUHNZZeO26E=;
 b=qiNcYIEPhYC80GQf8u+jaz+KQImPM+IA7AW7ANZBX3l0APEZiMw6Emq5YrYc7MLAFW
 3XQYI9L9hb93KvC4dd6PbO8kvxLamnYb97dvXOiJmLBPcP4gh57N2BUAc5Ll6UV7gp90
 IHuUsIBCJQHhhPxhitSMiiM+va1jJVW1gZQ8EpCS+iRaXUEHyiIrSBxdDu+zCDKru+jD
 Q7PgRKDquNU99RgfJHRs/iSBEH1FFjSaESGIOO2PAvrZjZtTF69EJOP8qiwe7+8zqtQX
 aF2IvSxKO9G0oaaTGfORJHh6pIHbSMTQf76rXo3Xc3edPAxzUrsOKi0nM2LfVkQArA3L
 I44g==
X-Gm-Message-State: AOJu0YymO2TpfdenOBFrIt3waILOQsTZDU52lgYlbISACIKZn3KryrzA
 8dJYI+rpXx4Z/EUP4ofunEEMnWVsTdGB5Sma1P+bgyhpbPs1m6HMalK9WPz0bjWlSbIaJecbb8X
 Zc6O/I7A=
X-Gm-Gg: AY/fxX7wEMBdqQtZHl7IzXUznky9FapuysaBo0Guxd44ExKEqStAxuGiWcOzwf0wlgk
 3Al+d8zG5M8ifCM3b8MUCxPLeBelB8H13JZ8Dl0T5amFT9/oKk/+nZ03CG5UnI6upYGR5UUd+bI
 RHgZU33/4tzLIC7OZXi01Nl5nAVY8bsVN5dhirNbmgde84hQtG84t1V8ffoheEwG3g1s1NIyWXI
 z9pUktWQHwTZGcdcpv9d7ewpFlCFFaow5k1IyV2sHsy+aBbDJ3MXPnOcY3QPEEq/ncbY11MIAsM
 niWghUPHx1gIOrKwk54LZVMAS5vesIH45SZFiZ7yaunb2XvFxXbowhtvkQvHva7PXbB0k9yYQSO
 RSrPJ0YRd5IQ0rsRsIBF0+ZFF6lWsxYhEWP14P5hbcTIQ8xo6BFAUZiZ1dTjuHROcQOv9olAJwi
 sUHXO8T2YRyC0nZn9e6OSFNR4Y46T/TOQJhqxxMyfFigSvCueI/X0oN4B2IJqowzaICgPyuw==
X-Google-Smtp-Source: AGHT+IHiQL8yqGU/5MiGxw9YtRZu1J1o8d9Zgk1XNpeJYjRU5fsiglnQPJwG5+efiWuGgkKo4NGzWg==
X-Received: by 2002:a05:690e:1a0d:b0:644:2e68:d1a0 with SMTP id
 956f58d0204a3-6466a84a223mr20990959d50.32.1766978627757; 
 Sun, 28 Dec 2025 19:23:47 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb4562df4sm110572327b3.55.2025.12.28.19.23.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:23:47 -0800 (PST)
Message-ID: <7cddc2db-7b00-4c32-94fe-7a714b625600@linaro.org>
Date: Mon, 29 Dec 2025 14:23:39 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] configs/targets: Mark targets not using legacy
 ldst_phys() API
To: qemu-devel@nongnu.org
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224151351.86733-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb12d.google.com
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

On 12/25/25 02:13, Philippe Mathieu-Daudé wrote:
> These targets were only using the legacy ldst_phys() API
> via the virtio load/store helpers, which got cleaned up.
> 
> Mark them not using the legacy ldst_phys() API to avoid
> further use, allowing to eventually remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/mips-softmmu.mak     | 1 +
>   configs/targets/mips64-softmmu.mak   | 1 +
>   configs/targets/mips64el-softmmu.mak | 1 +
>   configs/targets/mipsel-softmmu.mak   | 1 +
>   configs/targets/or1k-softmmu.mak     | 1 +
>   configs/targets/riscv32-softmmu.mak  | 1 +
>   configs/targets/riscv64-softmmu.mak  | 1 +
>   configs/targets/sh4-softmmu.mak      | 1 +
>   configs/targets/sh4eb-softmmu.mak    | 1 +
>   configs/targets/sparc64-softmmu.mak  | 1 +
>   configs/targets/xtensa-softmmu.mak   | 1 +
>   configs/targets/xtensaeb-softmmu.mak | 1 +
>   12 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


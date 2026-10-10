Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3D4CA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFVbs-00060N-Jm; Sat, 10 Oct 2026 07:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFVbp-000608-Bu
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 07:51:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFVbn-00024O-NY
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 07:51:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so3447775e9.3
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791633081; x=1792237881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7wAIcA5lNwzgNhb1RI98AiVDnxNrFm5x/TNXElweJy4=;
 b=pkTEyKPL2xbmTdW7/PFFbBSODc2LbrqfAza/On5lasA9N7Dt+NSvTsSOjbA4AX5c0Y
 hCmYXu+6daXQd/rulLRKk3f5hIbB+sqLZQiF8PDA5yr4JVAJVty13EgY+jp1ZCIP0p7b
 rUh9gjtC/4cFJlyt+QJvgWSor5pZKG+VwdH7iL+SiNSpyWvB/SugoVsl5BdWusSzo7Ci
 XzWdrgoou5s1rWG/gYE8wkx/33v1ODVzTz7GZZXvsxPeYP5eOJcBzKbghziZ0IJV5Dwl
 b7QyeljJPoVSavJCdukz1yqDfrUcUlbvLGGHsQ9oiaNBS11JrxlMdzceY1ADOBmi5NQO
 WsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633081; x=1792237881;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7wAIcA5lNwzgNhb1RI98AiVDnxNrFm5x/TNXElweJy4=;
 b=vuaR37H1jMWPtccjXGrhtWKYT1pZ/3/xA0nc/dgExhOfsarksInJWwfX15eGdjFD/g
 /CAD+uDVTNLvzvdzoXR02a0xXmvQgwzFYCH2nGQqzTCheJUEpe3Go061Pz7qVscbHaDl
 h+loU4hNSMqUl1pbC/YDf/cO7OQsk+40pej5E7w2BOqhfiLcaG6L9AEYUxLsjwaDpAwU
 Mkx5F2NA7dZQryePDvPPV0qRb/xhNnEJQnB90FLq2ohMSntiNu1kG8j3qL6A/D9sOcLL
 9lT/r9Klub/FgL55/HiQZ9d1elvOskuHSu6jT6gVR8ziiwI1zX/wQEG86amQiRx1DuYe
 SE+w==
X-Forwarded-Encrypted: i=1;
 AKwUvByErZc6E5zmpQ3EVVIXAdYGV++QxKQNwlBHBSYKKZ3DzzkS9aX9JoeCeM6g+ZYraO3ag9nPpXE2cdds@nongnu.org
X-Gm-Message-State: AFq9FYLnIoqudcpqIkCrfZWjHfSDkeU4GXEPp8SgXVfzAgKZa24txsj9
 jB3plTfx1Fmi8wtNo5D1mb3VBpuouOEdc0kCX9IJNdESWaWm2qd3exqJYcWVII6iao4=
X-Gm-Gg: AYBFou3aaRyUoQhHCOO5/9jvA5qGL6Rh0UQdMGXapfD2SQJWZ1rG8lKhshgGve4Dq3n
 7v8AjFmgVRzsnzU+3gIAy/s6vk4TEQV10gyK1HX8DcOOVDd+0AudSsfsd91kQrOpjonXVPwUTaK
 wNDj1ZfAQrPXZ8zzlGHNhub/IYwV2NeK5RjHN9ywag1zYnPpNgVoasQqYEKW7mZ8KpdPPi1EvZ1
 0/11EoPvfDManNd2aUUzykXKD37K8A4FSkr3IuV2wHxvG7fNsXxJmqUMdbuBJ9AL9BDLQFxql4Z
 JfAKw5N905sMQVYmG0VQDF3Yw39cUedizNNYL1PasbEoLMduW3jzvNWojfbCsInqFgxtDkBu3ZH
 g4mJkMaYlEdEZ4nvbkFTWgoHCfMlSYgcUG7KXzffsp5kNF/7ZNs5fgz8OeN/mSXcI/PV5JuZT+B
 cLRuF5RC7e4aLRb95hl7GbkLg8LD7mPIkG14jqMc1vsONohHLvsorsJojOdv+xbZ3GjISxN2PVS
 Gg+2ParJ/laHpgiRYS5X4aqzwt6Kjc/ueFFj+LZ1UlYeLUXhJUdR6M=
X-Received: by 2002:a05:600c:3e8f:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a18e44653cmr90628935e9.4.1791633081454; 
 Sat, 10 Oct 2026 04:51:21 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:5ea3:cc86:f483:9740?
 ([2a00:1e:e082:2901:5ea3:cc86:f483:9740])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm173620375e9.4.2026.10.10.04.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 04:51:21 -0700 (PDT)
Message-ID: <f89fc94b-ef64-4421-b369-4845780077ca@linaro.org>
Date: Sat, 10 Oct 2026 13:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv64: Remove vector min/max ops with immediates
To: Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20261008181611.3015838-1-aurelien@aurel32.net>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261008181611.3015838-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/8/26 20:16, Aurelien Jarno wrote:
> RVV 1.0 only defines vmin, vminu, vmax and vmaxu instructions for the
> vector-vector and vector-scalar case, not the for vector-immediate case.
> Remove the immediate variant from TCG code generation.
> 
> Fixes: 1631f19b04fe ("tcg/riscv: Implement vector min/max ops")
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   tcg/riscv64/tcg-target.c.inc | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, queued to tcg-next.


r~


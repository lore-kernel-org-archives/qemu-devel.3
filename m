Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E42CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2nQ-0004I4-LC; Wed, 13 May 2026 02:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2nO-0004HE-NN
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:10:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2nL-0003de-D8
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:10:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso55084235e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778652609; x=1779257409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ot0GCy4RuuJfFqLDLlZGf0hp74aibui9K7RoTR/5KSQ=;
 b=FSYeC54H+We1VbZL6XSlDyULnPJXp5KIw7JT8IZbX4N2v2dy0/B/rZWORlsmCJi7rE
 84WcJtkkepgXHyGbHS+Gh92y5k8Xg34OSsKbKz/eQS5qtyEDNA1FGCixLFimta/Pv39z
 MclJUAOXUL4IlQwRfaNa1dSVBn3mBVhkPVVpsAwHvcGLACu+Cdzamq5Wtx7C/EailM/+
 hhqo0z0e3Ox+I1JStmj0wDa5jmpG8unmpCBnx/9rL7FupfBWmOhiEpzQnhfCJ7XMbQyH
 HZeRXjCX/iatM3gWWXOSGhNj8WgFK9v7np85ibEr5gbo/8yHW4iMhAg6mDVxHl2nYIIm
 7cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778652609; x=1779257409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ot0GCy4RuuJfFqLDLlZGf0hp74aibui9K7RoTR/5KSQ=;
 b=VR1Vnu9SYxlNmfPdt/r3HFpzaqA1g001711+aAJ9CQ+hGmTk0rogU6zhCBORoECtsL
 Vg/hOquREJdGdhsdY/5tUOF6uEK+M2MRENgzeYocXFHImm/D7kN9ypLjHtk9x2iboCn9
 dwKaP37TNlZtP4MyIUYgbH4cmNGvPx3ITkr44GNJUZW/k2ym9LdOH6PTaWOQiE2tgR7D
 EZ1CfA2+QaAvkc9hJmDIF0urs7cDI8ysryqh4w740hJQpQNqzRe0xgqqyZfCC5zMwd2T
 dlCV03p+oiIwWgdIPGh91gq4gV1NjHcI4GHeFL+A6L/Gui2D1HIu5jFkXjZzLG8guxGd
 ltKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NV/HhvodFsuLto4+QFOf/xgzJY0LNZfr2ttXqTBUrf3C3ne9cSmhIXkPBdet4JWhkYv8NaNKTo5Zq@nongnu.org
X-Gm-Message-State: AOJu0YwHZcAUNMwV5d9Icd5NxJ3miSrN0mrAfDONZR6eG45bZIWWteaa
 1AZveDN+y0V3NKQPi6FLfn+j2tL5CzMqZq00veoEb6ghsWo2E/AntZ+fXxHmh+8RATo=
X-Gm-Gg: Acq92OGayx1Ph3p/2EJQJI7q5l9Vqp9xF3tp95wnlzHyZFEk31/cmm3l/7X4yZBD4A5
 eChBE53nELKjtmOUG5aRJS/nMHfl58z4ZpTn1kA2DAUACPCcpQLkSve2nprS1DtIRGtbzdOJ/iF
 VOHOSoF+5r/M7arzsDl3L7zm1DGyxVLMki/FHgXt4RBB94/RhYhBbJ2ysjbSzur/Z8AoAOKcB1M
 WrT/NB4CGXIDZIhLDDfGILJVatPyNCZcDv8/2wftvYIv3NeVlRcxFuN2cmNN0erWDwsPsyvOnlc
 qsTTyZPkgJL1Wt5AfHSC0Rcbq+zRgQackPDzJQ/PQEvfceiWvuIlM0FYvZeXoP2eXPjLa4fJ2gd
 +8d2pNdFG4THFEzeAlCFVVVe55mghV5PZQFjR+TJ9+U1r0pookyfe7J1iyd02Y57N9u1ayQqUJ7
 qQyokVrquh+B8Kl2iieooG65oO2F6HXOihOqDWjKcrLvdjCyxMk/F1qlWihYiS0dCCPw==
X-Received: by 2002:a05:600c:a087:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-48fc9a02812mr23482785e9.4.1778652609075; 
 Tue, 12 May 2026 23:10:09 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f542e56sm33500575e9.34.2026.05.12.23.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 23:10:08 -0700 (PDT)
Message-ID: <82b83672-24b9-40d1-9a19-89fd64c0606f@linaro.org>
Date: Wed, 13 May 2026 08:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Content-Language: en-US
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 conor@kernel.org, sebastian.huber@embedded-brains.de
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Guenter Roeck <linux@roeck-us.net>
References: <20260513023859.518484-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260513023859.518484-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/5/26 04:38, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
> Conor and Sebastian as people to help deal with the fixes.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> Conor let me know if it should be a different address
> 
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 952ed683bb..9626eb1ea9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
>   F: tests/tcg/riscv64/test-crc32.S
>   
>   Microchip PolarFire SoC Icicle Kit
> +M: Conor Dooley <conor@kernel.org>
> +M: Sebastian Huber <sebastian.huber@embedded-brains.de>

Maybe worth having a look at Guenter's following patch for this
machine:
https://github.com/groeck/qemu/commit/1a66d5b4e5fe9


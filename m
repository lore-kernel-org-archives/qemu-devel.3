Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAC0CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL3A4-0002zo-Md; Mon, 17 Nov 2025 12:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL3A2-0002uw-Jb
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:37:06 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL3A1-0003Xl-6P
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:37:06 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429c8632fcbso3248810f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763401023; x=1764005823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jLCAJ65AZBHvcqSXAcsnLrHpVTWmAXVSEPg76Aa9GBA=;
 b=r7i17c21u9zP6YPCPUpIHXkfYz7xjyXJctOvO73VFGkq3mzU+bQnrH3VyY4DucKYQT
 AExEasqG2vw4/0WWfa2wMEtOzfwv8r9TwKk3gb4gIDBIICJfhQfNYPFo9Rx9eeEBpvrL
 GHJR98Z0FUa6XUsn+xw6c7Ac8Aydhr6Fb0eZEJMGHt0LhLhp1OHLzAvz4xCMSafhDTwd
 irUv8TBsPy/sEa23oZSdK7xL6Jgk5BWg5w7SZ0QVGne8V+bsDfZrX7Z1vOdwUGGd2KUu
 JyVAUC9AuU76tigWtIIs1q9tKzWQ2R9XiWTMV6Gu/K8GC65MFy6VWbJGeUVZA+dLmCOU
 0p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763401023; x=1764005823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLCAJ65AZBHvcqSXAcsnLrHpVTWmAXVSEPg76Aa9GBA=;
 b=RakR9t1uwRoB4mtTlzxrOiZY2jorZKiXpw+nIkOEO68+7FWmZGg/hkv4ipKP9+Q9v6
 KjiPwh6Wl8rIbSBCWIrRdu2ZRrRMA0UxUc7MohDadvHWRHyuyaXnLUuMO1E2V9WCFxcp
 iWZ+1of+JIFTB6NgjVhPG6th84SqwoCMD73+xQ53N3pF92t5/OYeTla0ebJYfJNfVzcj
 0qZF8FSiGz+qlgYtiQA5p9MrbrT3ekzIZa/gbXzrmvOQBkryivvqyyo/3YEJKTDZXHjM
 jFtzeZAoqoXAqA83vYGffakOpR/fEYGGXzmQNp41/wvWFmK4iWO0RR3xRPaGhLrpSp8e
 vIuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5WfxoOsw7YBW84Fc17aNpyFgSWvvCemTJvjZcJW3P+xIOI1YbReIv9VZl0jIt8ClEuM3ITYrbglg0@nongnu.org
X-Gm-Message-State: AOJu0YxK639eThDP0uHY02PLOYkQQhXDVKBm5oau5CrkdSezvGUAcsTL
 I77cXjBZW34trPS2/8PHCDbJRnCaCSn07PcUVx59O8c6WlBEANLy6TFj1jLItOTE3RE=
X-Gm-Gg: ASbGnctz0Fcp5OCw6MNrT2G5cYE+m4L9kbkv1MU6nkxxOdgh5qJlb33mI0cpZ/4CgDU
 8R/IE/Ci3fRL4oLhPEM+COiFK5E8ReI2sIv/x4RiG6X05VYWiEZZzHH/wb/mlid5nVyzp4Kifjz
 Ql578U4smXnO+ETbGoRIpGHaMb2anGbcqxkxLeGe56BpUM7NeQmzsjO26AxXdfbCbW1qCXzIjMC
 GMMWfp7fX/UC6crP/EK48/r+k/h7S3AbaA/PbvMlLBXTGw532x4Ie7n5Xrs/SYZwNBErwmXmx7R
 8pMf4DLVTigKPEv5t4tbqFixPtV/TnYIJaYdMLlrEfmwwejjdJhNt4YVVePR0piQzn4QTzjFJFv
 +j75xHTCdNfw82ovsACRr39SB9zNsZNEtf/v3VJcDCZhEfNmPcDcvDFhbVmsrWA0GoFsOwiHLvx
 QeS5kmVudG31pWOuVRtl7kXw8tpRyzORnsemezfUBqsWpK5/INjYHpXA==
X-Google-Smtp-Source: AGHT+IGxDO3v3bCGIuzdSJGl98OAYRfABh19ARPZW3N03yl+c9r6EpayTYS87G1Ua3qj7xagj+rW8g==
X-Received: by 2002:a05:6000:3104:b0:42b:496e:517c with SMTP id
 ffacd0b85a97d-42b593236d5mr13542453f8f.13.1763401023370; 
 Mon, 17 Nov 2025 09:37:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17cbfsm27316235f8f.35.2025.11.17.09.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 09:37:02 -0800 (PST)
Message-ID: <e8938d60-23ec-4235-ab69-73cf1de2aede@linaro.org>
Date: Mon, 17 Nov 2025 18:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Hexagon (target/hexagon) s/log_write/gen_write
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <20251114230013.158098-5-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251114230013.158098-5-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 15/11/25 00:00, Taylor Simpson wrote:
> These functions don't "log" anything, they just generate the write
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/gen_tcg_funcs.py |  2 +-
>   target/hexagon/hex_common.py    | 30 +++++++++++++++---------------
>   2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



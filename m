Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75D9D10DDD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI3C7-0008VU-UD; Mon, 02 Dec 2024 04:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI3C6-0008Uy-De
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:58:18 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI3C4-0002Fa-Pv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:58:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so1742834f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733133495; x=1733738295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KV2rzXe+Ki5dZZm4ovX9z4Eqn7Ng28kZ2b5VKZJwohI=;
 b=Z/+7s/gd++vQwqLn3hWNufO6qb69OufOznbtoMgqXffJ15LuTWHuiklOpYLScfBAO0
 iUXqLG9Zy05hdmWx2Ka0Ka2U1vPE65qw84YoREbHdVLyq/vNwXu33/JVobY94gzj+x2c
 n7JoxbJLeE07h8ZEw4mSsAIz3oai/C8KDw98HgQqCLg/u3Bhe7CNP1SCTtK9ingWKlTT
 zdpH6dR/1IFzpTlaHXe5tzocselCEIQnQcR537b5Ts3FpAbp/+D6elqXkOBnTNi1QHgp
 6R28Ml7q7YDTNTBxhZ0GtCs/a3m2nnHs3NpA8M4PW28Pn7RhpeBi5X764nyZN0qsLu/L
 4cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733133495; x=1733738295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KV2rzXe+Ki5dZZm4ovX9z4Eqn7Ng28kZ2b5VKZJwohI=;
 b=B0pItj2Ttd5ZwRk5mO0qbH03wm+Bkn9LUt/os7YmPlzJX3E8L2arbsP6PSUzTIFpTx
 240oi6ICDhErYTLk30TacaO4nIZXXWugNNlOTKSiGktSn/M1CUPHxDxwLPpnql86qvxQ
 oZ5R97HsRToGdP2nEn8/UYFXiCJOxB98PSW7fOtnC3zD45OL467opMYxkhMLiGiADliY
 nLMNn7p7hPDs8b+sktHycFQcLHwsSP9Yf0KN3d6HphtFj/twTUi2EJF5yxfuVpowiJG/
 dVMcjaWzCJTfJaSntKxb0lfwwT9r/FMFZI23M5vWpn4UMKh7xWl4Fp7sKU27uHRLacCX
 04Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpuf6y9MdvXt+HuViDEeVE61aupghsPksYc6Kk+Tqhq8nJ7mboFhL1zbsXDRTu/zkBFAMwwXm1PUsq@nongnu.org
X-Gm-Message-State: AOJu0Yxmcac3ZE1NNNlr5YFu4xDqckPYldngSMdX2G1XiuPqVT8SfBGB
 w01ft7FQIryJzh6q1czFned7Rr+lDeXBhgORFuAk95UfrNaR+uNh8ifr4KaVfElpjXMo5LI/MWb
 hgWg=
X-Gm-Gg: ASbGnct5xk0RXwc0393GkVulH4yJxSdfq+k7Jw2DG5Bx+gnVl7N3FDM5SNnq1bamcTg
 Wcqcn3HARWRyageKrvLRIdhcn9O/OyNR8iwfak0L+6K2rQwi1+vVhrLw2dCcctkE8KvFXHQ5/Qn
 67kXEMJBcJG/Jbsm5fX58st9oy+nKGHGwDaiX8TgQAb99WnziCowrnKDz4BP/kqjZ1Qgd4o02FF
 lVKbUsqje8m8GvjuqCGAgYRhSi/jKoi8RSrk5uyqGUyJJNAeV5f3yAuJmtg1+oKZA4nBkBDivOq
 +VkxOdjjDQ==
X-Google-Smtp-Source: AGHT+IG5D+VRuNTIid8cll7/t1j9ZNHS/R1+2460YAzq+6CSNsQgwmwuk72FbvjfoAjn2Cflw/ww6w==
X-Received: by 2002:a05:6000:2a7:b0:385:efc7:9335 with SMTP id
 ffacd0b85a97d-385efc7985bmr4025178f8f.24.1733133495116; 
 Mon, 02 Dec 2024 01:58:15 -0800 (PST)
Received: from [192.168.77.213] (51.22.205.77.rev.sfr.net. [77.205.22.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd3a71bsm11980512f8f.55.2024.12.02.01.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 01:58:14 -0800 (PST)
Message-ID: <52558217-d329-47c8-be7d-5acc0b21228a@linaro.org>
Date: Mon, 2 Dec 2024 10:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/67] target/arm: Convert RMIF to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 32 +++++++++-----------------------
>   target/arm/tcg/a64.decode      |  3 +++
>   2 files changed, 12 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



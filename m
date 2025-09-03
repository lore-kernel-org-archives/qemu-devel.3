Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62820CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn2w-00025H-N6; Wed, 03 Sep 2025 08:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn2r-00020n-TJ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:57:02 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn2q-0004kc-DO
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:57:01 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-afebb6d4093so1096819266b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756904219; x=1757509019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AonN6yxr+iq56T4cyhf0kzoMyiZ3i2IR6C99ZXVbfqQ=;
 b=u+D/S95o+z/blQWkq/7G5+JnU+6wBhLoyPA3Wqbn1V2VVIYgbCfNfJtr5aX++jZFys
 v47rZ5eiGfm5rGlJ9o2TeVuIdpLHUEC7WRB/JoprCN8S1gr0QhfrGTDFcm4PhT1uJ+2A
 CDeDy4kRX87vf67rdW3sirbYQePropCMM66KZLwayLTKjxgNItqhNz5jz0MQeR/fBlXY
 s3gQJ1CdGwoTXbGxoayaOphqz8D7YJva+d5CuOpDbCE4i4ejLztJRE6I9tgMbP+L+088
 e9tVaMheSLWj5OP3yMUEflUEumYXJFOrwxMOB0cY0ZAL4n5Ytc9vNJnAdYt/pPIjoacn
 bIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904219; x=1757509019;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AonN6yxr+iq56T4cyhf0kzoMyiZ3i2IR6C99ZXVbfqQ=;
 b=Y8DunF+f8qvCzNz2L7eMAaHnEK+dJ6jn8Tx9TWzb8HuPFoVSBa+JQeO3/sfRdrq0Dx
 7Hrhsm+uX6NFe/2s7Lis7YvF9HNpdokz0HGI2cJ7ylkn8TH+8ynGJulQPQYioqTBl1oS
 t51IltEZWp/jbFJ1WsI4vZbecxVXQ6WR3ptOm7cIGJLxFs/0xkdPfaxZkecHuS1zbBQW
 Z1ADuwCtsv5vNFff2hN+PaA/oWNA13TRUs5BTsEfuyeAEpSCNvVaNya5NpgDZ0XuCDgx
 HvKRnbePLHkMCTpBovHO+pSoc1+bcBx+LZ8g+vH8WxpxbJkYLdIYOI+2Ll22LHDx9uha
 bt8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+4yf3U9+PncE89XH9IejCkG+BTXTH9sthhhY37O8KfVL1vTIv7tCLdOcxlYfFg0kWU+d0TqhV9nIQ@nongnu.org
X-Gm-Message-State: AOJu0YwdRyJPPEczmrsSRsL32ba2gEV4PvDBa+5Wrm3ZTxU3dLEkjWzb
 +YgvaOqXKfCPhVpXPDi1G162CIqwOSHTC1C1iorvvnaxag8px1W2GGGCSga+kHlCVe6gHcj0eUb
 YMtbz0Xg=
X-Gm-Gg: ASbGncttSDdVuMZM9mrolczTqTtuEVYAuqazJyMpUF1PohdGFeQeMwbfVBDtWVxyzBB
 1wf/hqeFmfCA14QChdF9zf/Eiux8u+jLv6nHfSJ50BgCBCu3EoxB5xh9mGMR31Rm2warjOTKznj
 ANk+RPGEL8XoVeMZL8nLvd6OW5JDPYn+ul8lMOxs7DhiNxA+ASl8pmLR/nC9rj5A46y026ohdjG
 fXXqT3raRhMZ/hDriNY85gps6G6bt4IJakRCUucmyj0dpNYRg34nZ9u1PUVRetvWiLuIANoYHy4
 xY3Ypp1uixPOT6Wor5BRwFNDeE0Nf1qVTTkYvCkaED8DAz5aFGpMauz3i1vQ0yGfRDRKu9HVV+w
 lx0151E/UrSoDveT3deFOvTOqFMkjDfB5a5qCfGsxfGfHlobAztmyRLPOQ2jWjQb9j/eksCk=
X-Google-Smtp-Source: AGHT+IHwpjxpurPm5r5fB2kXWWWQLIHGjkwij2D9oJTQbbx+CAv5CYpNhGsuZJiIs+AIallqrBUUeA==
X-Received: by 2002:a17:907:72c4:b0:b04:274a:fc87 with SMTP id
 a640c23a62f3a-b04274b17e4mr1160716866b.4.1756904218678; 
 Wed, 03 Sep 2025 05:56:58 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b046f2dda22sm97492166b.40.2025.09.03.05.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:56:58 -0700 (PDT)
Message-ID: <87dd7ff6-cb08-476e-aef4-ce0b83309e27@linaro.org>
Date: Wed, 3 Sep 2025 14:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] target/loongarch: Only flush one TLB entry in
 helper_invtlb_page_asid_or_g()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903085338.3086081-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903085338.3086081-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

On 9/3/25 10:53, Bibo Mao wrote:
> With function helper_invtlb_page_asid_or_g(), only one TLB entry in
> LoongArch emulated TLB is invalidated. so with QEMU TLB, it is not
> necessary to flush all QEMU TLB, only flush address range specified
> LoongArch emulated TLB is ok. Here invalidate_tlb_entry() is called
> so that only QEMU TLB entry with specified address range is flushed.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Double sign-off, both mis-formatted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



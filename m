Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4009EEDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDtK-0007Rx-OE; Tue, 10 Sep 2024 23:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDtI-0007Qk-Il
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:19:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDtH-0000H8-1P
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:19:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-717914d6c95so4096996b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024773; x=1726629573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lM2XCCQquha4F2bhDOTqmdvm4Iv9j0Y0xSgelOJiJSE=;
 b=CSm8adCPvmsPcNgvnEz+80bEfm1S7ZDCZyhXnbQCR64j6hQ8TbpOc+R8kpAzXGwdnv
 C4SG96VQdTkJGYIkeM45xu9i6G3pfEF8Y+kpDV5gyMPAIPPPSTJrz7oKme2K1cCFprxp
 uIDWotk7LtoGDPS01cQu+D1Krln5FMTD2RKz3JTrYwgagkk1yivE7VcslVeVVUtzXeVp
 ZFPQHI7UHzRYkoeJ2d6KKgP0lOz4TEDtCqtIObZf4kupWoNQ2PwB/hSukMnTdYrxIOmh
 hESYcuIWCm8NeQDEM3xBg/mEoiihOfry3wqdipCke19f84BhQ7ZM40cZ+NWWeFTnNzUB
 N25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024773; x=1726629573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lM2XCCQquha4F2bhDOTqmdvm4Iv9j0Y0xSgelOJiJSE=;
 b=Z/kNNm2IDg7e7MK2d/uCLznzge9dOcocd7dq8wO+nZFwOyK3IspdulqNp6IcIVOoep
 66XKxpempJfd6OimnB51eif+q+z0DEa3bYZcfTr1eR9HiEMVSAss/5wJVY6zcebSakqZ
 7/cBT9iaqe3GhfeMzjE2ZYEC4+UvVh78SLCqCpXKI+UR6z1vFg6xBcjex4secgxvfgiC
 eF3AI8sPICe9mHtDyWokSzMPnGj50F02EZBskcO6HhdV+J1FoAW/dHpXoTxCRv7rjljt
 m5MT3QeiCWd9fa3twQt2xGu0xU3wIoGT/wClbt82A9QZtNHqcYYTuz8iIBNd9QbbBOPt
 NGLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb46lb5bpyb6F/vHdcgbYeoV1w9YMpsvEZWJA2J/ak7fPfPr0VZaSCkOs9oANQsuPP+QoTqO1tQEpi@nongnu.org
X-Gm-Message-State: AOJu0YxPgpOkI0CXQfEnCUi8eJubLgw9oI1pIWEG58CXeMRYkCOoX5JO
 jj0Gn9C1pX1GVmvx0rBLVEDHqrjThay+y7mPmtTN1MpAXSdBTWLNYSSdyc3+GME=
X-Google-Smtp-Source: AGHT+IHVhqkWdPn6XXmSGeM9y6q6DlNzZOeFz8BlcMU1obZdLyiYEexdmZmoSqVhYawmd08iJrUO4w==
X-Received: by 2002:a05:6a00:4b4c:b0:717:88b6:6b1e with SMTP id
 d2e1a72fcca58-718d5ee3fcamr18393869b3a.18.1726024772965; 
 Tue, 10 Sep 2024 20:19:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090b0364sm2038815b3a.180.2024.09.10.20.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:19:32 -0700 (PDT)
Message-ID: <3d352cff-3773-4108-a596-7246e68008f3@linaro.org>
Date: Tue, 10 Sep 2024 20:19:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/39] tests/unit: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
>   tests/unit/test-xs-node.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/unit/test-xs-node.c b/tests/unit/test-xs-node.c
> index ac94e7ed6c2..2f447a73fb8 100644
> --- a/tests/unit/test-xs-node.c
> +++ b/tests/unit/test-xs-node.c
> @@ -212,7 +212,7 @@ static void compare_tx(gpointer key, gpointer val, gpointer opaque)
>           printf("Comparison failure in TX %u after serdes:\n", tx_id);
>           dump_ref("Original", t1->root, 0);
>           dump_ref("Deserialised", t2->root, 0);
> -        g_assert(0);
> +        g_assert_not_reached();
>       }
>       g_assert(t1->nr_nodes == t2->nr_nodes);
>   }
> @@ -257,7 +257,7 @@ static void check_serdes(XenstoreImplState *s)
>           printf("Comparison failure in main tree after serdes:\n");
>           dump_ref("Original", s->root, 0);
>           dump_ref("Deserialised", s2->root, 0);
> -        g_assert(0);
> +        g_assert_not_reached();
>       }
>   
>       nr_transactions1 = g_hash_table_size(s->transactions);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


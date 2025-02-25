Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AE6C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 15:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwiY-0004yx-UA; Tue, 25 Feb 2025 10:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwiU-0004yP-Ec
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:19:27 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmwiS-0005Ru-Qw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:19:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4399deda38cso35452715e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740496762; x=1741101562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i4kBj8MUTp3woo3owoo08iTb5r9ZHe5iMM3tSuTcdOk=;
 b=V5KuJfvU7g75ivcdAqoFY2RY//jSwEpZw/m4U6pB0PKqJ6G5/XbGHFYeXJrvBjAUPc
 LGp6jrnI9pB5s+kKT9dMIErMmp2rVIhvFnQrcketilL5hLVnITYiP7Koe5ykch0a3tU8
 557MSHLr2DsCVSJc7lV+YtnLZZrUmabF/CXIn873geZf2b5bh5RGycuWunVHDVtBnwgZ
 64dN879n0Y664jWUZUDL03uH45Vnsk26cV/XLKpgc73Pe9Uv62HaZ71sljEuehZeLw2I
 KpMvWX0rVtUTyaa5p9znxq4LTBOz+Ygx+wgNbuUzDWFdfD2jE2dpX8SH0IUmfRZfP0nu
 L47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740496762; x=1741101562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4kBj8MUTp3woo3owoo08iTb5r9ZHe5iMM3tSuTcdOk=;
 b=kXpcpej1nZYXhvgnS+tBVrHhoh5RjAhSt/7ERS11dtBxs0pvEWfsVFyNpHz8OAx0Vt
 yLmr3pC3olkRWxm/JHoU6m1LdrJ5gL82vnCHKJ4yH9FOCwuH0mQBWscZY7XLvFoZa2yE
 BFVrlhba8O1JYod2TB1IzvjXlZgvn4JLsAmZm4HhENc1Et0TK8XP1JTulikZNO795J8k
 SKdPvMTOC++3sa0cXADz6IFr4FN7Rm8hSsubXMtLCRXbMQvwWd6Ck63MB0urq/X08c6W
 5r8Jn6V57M79+tf1twFB214KCqTUcLzNgzRU9gmCdqYYj3mloDL6YIreEHi7XSNZzvOC
 legw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/5uRkUVuRChBtkmlqo5DPkFpV2U1uzoKj/6DErSJZsGxIPmPEcu9+o01g8pu+M6/I5RQeFORZt1fZ@nongnu.org
X-Gm-Message-State: AOJu0YzG2cU20rXfX5LTFpCJd1Fj+u+Wp4YjQXlMhFRE7oQ55orDIWSN
 bW4acuO45c7t7xVup7T7dTn3omfa4Tua1k3CH4I1nbuN1x4Zj8c87aaZK58/7RQ=
X-Gm-Gg: ASbGnctQTkJPOsOAl3ahtvDxKgYGCvc6+g2LpP5Uq2uo3tMA+bkkREXhtEX+4j8wa/x
 j0BO/NGDJsv0e+FEYIGjRSVT92LlgpqYLeTuahT1xn9Jek+WFCFxEApd2BK1y/Yf/yO6qy/3oPe
 eGV4SusilRBROC16swlhpG+UA251bKWR1RSvz8aRnvtZ2a/g+nSVglsGlMZKNqJAasAM2ourFBP
 tPUs4g67Jyq+WgXGkX+Z1Kt8XZCPiVGhRo2VYv1ZOzoGOllhcFFhWIEiGgU2E3lrKdAfVou4irr
 qU7c0PzzJZeV7qEYubLdwOGNps2oxd9EUESMGRp1VIv4nPIFqPnQT28FBQjYkPn/BJyMSg==
X-Google-Smtp-Source: AGHT+IHj63TB3ARoJqPUar5tH+/AflHZHsoiori/ng/J1RJqdFthtUGnOzJ764AFXJHafPUd31sGeg==
X-Received: by 2002:a05:600c:4446:b0:439:9bed:9cfd with SMTP id
 5b1f17b1804b1-43ab0f311f9mr39216685e9.11.1740496761863; 
 Tue, 25 Feb 2025 07:19:21 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd88300bsm2670424f8f.54.2025.02.25.07.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 07:19:21 -0800 (PST)
Message-ID: <1246fa36-2937-4524-997d-c0aebba4b7e5@linaro.org>
Date: Tue, 25 Feb 2025 16:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 001/162] tcg: Add all_outop[]
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Add infrastructure for more consolidated output of opcodes.
> The base structure allows for constraints to be either static
> or dynamic, and for the existence of those constraints to
> replace TCG_TARGET_HAS_* and the bulk of tcg_op_supported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 68 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837DDC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW468-0001ra-16; Mon, 22 Jul 2024 21:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW466-0001m7-M2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:13:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW464-0001cC-Sr
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:13:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d1c8d7d95so1132982b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721697223; x=1722302023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/9saZgItypPDjS++JM/jS4biXVHQ8w1Nms9b4HyS/3k=;
 b=rKbr9rTTYEsduUKiigoPBl/odtruHgOXYZ72EAiZvYYk7ZxCSVMgeBTQIaKXevg8sw
 u4c3+2+jVXFJ5sntWdgKyEXeMJkbDuC7o4b45wzVfnunQUklxL0u4s4fVGQbrNgb8n8n
 TsmpecG3io3SSdb+q9OJuTa1/4ecelNjt9OHcRdrW/m4VKdxteaGH+GM81z05jGBNOCH
 kgi1I2DB011KnchXxpK4nsRIOlKd/udPkFvkQ8YNLM8ijO2UiAmqGYbvg5JegGsSHNWu
 5Vnli6lnl/UGFFUdlLJfAI73TiUZFVqfBL79DC+g3SWXNSwgdHDzVFLXAwHgQCpNkEjl
 dNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721697223; x=1722302023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/9saZgItypPDjS++JM/jS4biXVHQ8w1Nms9b4HyS/3k=;
 b=F9krUjTWGXvDYLI+jDV8+Ocdp2BwOGqkdmVzO6PsbNTNVVeOXA76sSrvD7OPoBDIIa
 +duiICyzCKv3uEB62g3TTQNqOadW7h7SaKtp2SLDmzrmAL+ahV8GsW+chMjonZmRgltd
 rXoTB8Jar2gnro9kr3V14Uihe1/5OuJpbW0ri2o20cahS2L5cwQm4MsKvIFL+OetjvSK
 E7DRc96knKdPykFYukVXruqrOfwKSTEu+fFEAcFB1WpV150/U6OWZwmxEC8iw5pDOedM
 VSWsUz3ilA/+KZhKx8cHE64Z0erZ3O76ChBGWFgh6P0v9loRd1Zt3Mo2vb/+Tg+xwJim
 nvwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL0YqOG5XOj86/KZ5jLLXqmEd+9LAtN6vt5HAZIN+kRhat/IXeOy5JAkKo7eYuHy7mMenuhW+EvgeusEZdidaS+++R5rk=
X-Gm-Message-State: AOJu0Yw1vtKf+H8ckbWhfIE/7kEddHHoD9YTd+3mWo9x/AURE4CBrYos
 UHR5r7KFVzYX01Z/FjgJGaNt/bDAEVsVo4rgKpQd7OsFmknCwtr6Zhuu4N1Vmlg=
X-Google-Smtp-Source: AGHT+IFCH+YZgImpKPKNbr92M3GKidkRd2eAfIoV6WlLLRoA7m5a20X6P+7/ulDgEI/QM+zCcdH0aA==
X-Received: by 2002:a05:6a00:1744:b0:70d:3438:9689 with SMTP id
 d2e1a72fcca58-70d3a874509mr2109726b3a.5.1721697222884; 
 Mon, 22 Jul 2024 18:13:42 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff59e358sm5948733b3a.167.2024.07.22.18.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 18:13:42 -0700 (PDT)
Message-ID: <755440ab-5d66-485a-aa13-dd352c558be9@linaro.org>
Date: Tue, 23 Jul 2024 11:13:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] bsd-user: Sync fork_start/fork_end with linux-user
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-12-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722214313.89503-12-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/23/24 07:43, Warner Losh wrote:
> -        /*
> -         * Child processes created by fork() only have a single thread.  Discard
> -         * information about the parent threads.
> -         */
> +        /* Child processes created by fork() only have a single thread.
> +           Discard information about the parent threads.  */

This comment should stay formatted the way it is, per coding style.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7613C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVNV-0003yI-5G; Fri, 08 Mar 2024 03:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVNP-0003ot-Gh
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:14:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVNL-0006O4-RZ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:14:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412f1961101so15953225e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709885682; x=1710490482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uftyk4hTRz63xlOMnWh6LPWaUO0VSX6yK69yiD36wvE=;
 b=RmqdLhbdKZrmrAs8lNahNi8F+rqcrkIrN4+m4BLW9dtUIlQLG/Z3SYEso/BBvlr4/d
 +/oTBWSBPp3bGd7LcYi9S+KY3ExaDVyt3ToMrKX+NWtrnKa10F10qPHofMWSBhAQw8ic
 zZ05+7tzh/EONxQq9UUSNIZImYUYTGGyZD6zykfrj2YAqDKoop1qycdtJb05E0xcQaeM
 DVc6a3YHtw7Iv4UfREltY8BbvoZ5MFEVIPhFirKDzNEBMuQvgzaXdGGjoaRndMsjGcvN
 6quXFc8qE/HNDA3jsc/MtKVVSyk65/jCTi1jZn0PX8thhDIhaT/OZ5WmnsYStYXp+1jW
 xY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885682; x=1710490482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uftyk4hTRz63xlOMnWh6LPWaUO0VSX6yK69yiD36wvE=;
 b=XWwtryz9lpeq87AAU7GP0kpAaAIyxKy95fxWDQ3FVrrrvPU92gerALeSaPlJKEL8Y9
 DMoLwxc9ssngn+WZJxlH76IlGUbSJKDBFX0LtrjUjde1nzuhUIEVxrXk+EBXVXGi9fu2
 3+IyuccdDhHD1LqPm+AUYyaruY43gfZCVaHTwCnf6wEJaFrlV72xfHvOVDoLXgeJn3ro
 D3bxrFObY9tOpKOxqj9Qit9XNtZ4ERcDthcdUelx9D6lDQW6uGL3BIkxAgy/Y7NhoyKU
 TNICKrHzMrzeBcu5j3pA4di+hcMAYVKQYDnwtogwdysSxjc5U0HNSNUvOHLvqepxtNQN
 N9Ww==
X-Gm-Message-State: AOJu0YxIBzRAT163aTOldsBUlSBp78LW+aKozWfDJq2fWqpHbRTSQvHW
 kwQq309ECch9CRfaKq12b5Ai4a4DZvtEY0PxivvquUfYmExZZSsJq6MUe8f8EVE=
X-Google-Smtp-Source: AGHT+IGER1gN+KbAlQvATPKJZWG0/62jEfWfwyv9VOiebjgI8uCWtW3nFTubjmO2gmRaipmvXT6izg==
X-Received: by 2002:a05:600c:4fcf:b0:412:ebfe:68fe with SMTP id
 o15-20020a05600c4fcf00b00412ebfe68femr7293070wmq.35.1709885681970; 
 Fri, 08 Mar 2024 00:14:41 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 z11-20020a05600c0a0b00b00412f428aedasm5163173wmp.46.2024.03.08.00.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:14:41 -0800 (PST)
Message-ID: <b4ad4e19-6bb0-4eb2-93ca-4a746afa3816@linaro.org>
Date: Fri, 8 Mar 2024 09:14:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/scsi/lsi53c895a: add timer to scripts processing
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, BALATON Zoltan <balaton@eik.bme.hu>
References: <20240304163727.2320861-1-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240304163727.2320861-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 4/3/24 17:37, Sven Schnelle wrote:
> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
> under certain circumstances. As the SCSI controller and CPU are not
> running at the same time this loop will never finish. After some
> time, the check loop interrupts with a unexpected device disconnect.
> This works, but is slow because the kernel resets the scsi controller.
> Instead of signaling UDC, start a timer and exit the loop. Until the
> timer fires, the CPU can process instructions which might change the
> memory location.
> 
> The limit of instructions is also reduced because scripts running on
> the SCSI processor are usually very short. This keeps the time until
> the loop is exited short.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/scsi/lsi53c895a.c | 43 +++++++++++++++++++++++++++++++++----------
>   hw/scsi/trace-events |  2 ++
>   2 files changed, 35 insertions(+), 10 deletions(-)

I suppose Paolo is going to take this patch, otherwise I can
queue it via hw-misc tree.


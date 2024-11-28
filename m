Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2D3D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 21:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGldg-00025B-E4; Thu, 28 Nov 2024 16:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGldb-00024r-OX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:01:23 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGldZ-0000J5-1k
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:01:23 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ea462a98b9so661608b6e.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 13:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732827679; x=1733432479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9QMW7BS8TdlcnnKlTzua1cQcGaQeyJy5BhnsmpAbUgc=;
 b=lWgkqDrd1MmKFCKzeeILmiFopMdkuu9DDHJiRybbXDnmROkk/cghi1UTVMy2hmUT0V
 Zn5TN1Bf1OVeribg09Ffkg5huRiywj0yz30TASckQ/Tr9Czg1Y6t/6oYrMCXLMQGs1BL
 C4OTM7RivVxM4hfdMrxJHHFFu1B3ayfzeuw56JK7OQ8quG+lbLtNmEYMKcEM4VKaC1CT
 JhrVtGE4JnESRF3dtuWGGT/d5YU6Hw5nIWnGEd3VmwgzLUKdjC1dQuNIpHRrQz0vTYna
 p8rJgg9f9jyjf1EaAuf4M4cz+s1BJTGfhVK0dyCxdeM7cQxBEcHupVgIZSMz+HwAt5MG
 NrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732827679; x=1733432479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9QMW7BS8TdlcnnKlTzua1cQcGaQeyJy5BhnsmpAbUgc=;
 b=Thu+vUh9lXVU0y88QvdN6DPaF9O6P7q4y7B3afFwYu1zrj0WsdZZHLB2bhmH38ZSZk
 pc9mNavBpY52pHcjSBKp/1RG73agOdADjKYmyag4ktziZG3UHocQjnyjIUzBnJSpqmOU
 hXSIwkVUz+NMaEHYQ065fJE2eoI16xf9DtFAjnFAB5UpBOR7L43cvhMBKlZiawuW8FuQ
 Q6Q/t813H9ygh7xKVz3Giqi7PzhTc1EZ95aLo+w7C4xLnIGr0Gf/DV+MuO5AOVQCypLN
 lwxLL/DnZ1b0mHMIE5DOQDqthgcKSc7nMOxKZOQK7JMjfRgf8H4IbpNZ20yWNziAiQTp
 kh8g==
X-Gm-Message-State: AOJu0YxroMqycAWPK9hwdgsmJXdrOEFJdzHGA/cWZMKDO6Lq+jwaXlrn
 vJYjWSvjmFiLnP1KUMSeT6lHHWTsWgfjXS5U8QTCTJnk79zhfkQkD5UULeQ1QHKZhHQeSS/W/lG
 EIMM=
X-Gm-Gg: ASbGncunglrL9FMY5Vs7HzIuk2KJCCjoX7bCQnSXIfHnrBQdleSVwVCnPTZ9ABM13Ha
 Xq6tYao58+3H/zMyMNiGt8e8ftbCNGndldZApgVn9ANOc+Kv0yIKTPpj6Qv4o4Cou/KS3XJ+OPP
 yesccunh25GkNrnZXId1OPYBOWGDKSuflucJPmJqC6P+HnnyqxHdI0694H5eKp1WeBb+hHULjgz
 IKJHXwqWh5DM/Sxb4tca7WaWkqOm397D+M/cEfH0TtbtcKjxIcGjK7T3iL5kpdR1OY=
X-Google-Smtp-Source: AGHT+IGhw4L3Rh1cq443Dsle9SY6WyGhhW1X3q0fPdYdKe56blq6bTGmDffQQ6N2gv7SC5piPyW/sw==
X-Received: by 2002:a05:6808:180d:b0:3e5:e347:55c7 with SMTP id
 5614622812f47-3ea6dbcf293mr9477292b6e.11.1732827678935; 
 Thu, 28 Nov 2024 13:01:18 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea860e897csm415296b6e.23.2024.11.28.13.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 13:01:18 -0800 (PST)
Message-ID: <a42fa828-c9be-43f3-bb2d-9896fb795b77@linaro.org>
Date: Thu, 28 Nov 2024 15:01:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] win32: remove usage of attribute gcc_struct
To: qemu-devel@nongnu.org
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128201510.869974-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 14:15, Pierrick Bouvier wrote:
> This attribute is not recognized by clang.
> 
> An investigation has been performed to ensure this attribute has no
> effect on layout of structures we use in QEMU [1], so it's safe to
> remove now.
> 
> In the future, we'll forbid introducing new bitfields in packed struct,
> as they are the one potentially impacted by this change.
> 
> [1] https://lore.kernel.org/qemu-devel/66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org/
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build                               | 5 -----
>   include/qemu/compiler.h                   | 7 +------
>   scripts/cocci-macro-file.h                | 6 +-----
>   subprojects/libvhost-user/libvhost-user.h | 6 +-----
>   4 files changed, 3 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12E3CF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtQg-0007Cw-Fm; Fri, 04 Oct 2024 21:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtQW-000727-OE
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:17:45 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtQT-0005Dd-SI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:17:44 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e192a2fe6cso2071099a91.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728091059; x=1728695859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rRrFbvTZ/HGEBsE1ELoQlg8dK/ihzfdXXCXZYjwC2d0=;
 b=We5RJngpP/ce4y2K7hyjUhJ30Bb7lB/Dp/cz/bc83LsMxZ9pojZhz5LO7M0F0py2j8
 Lli+nWxB2boFsl2ZZwgKKCQcuphft1sA0odmSJG6TU8WspzuOSUFNkaB1zH2p25fpI/o
 vgsz/+jnAuJDVsycOK5rDGmFiRwsW35qmnJON48bOXi/KwKzwmjnWBvOb9nNT/4D7KLi
 SmEQwTuHK41UOJcuuFpOEoQT6AVvVdxGXX4oRCiM12u8yU6ARal3j+YLChr6RQ3pn3Bj
 c79lAbua5HhkDSiWb9SiKrspck8ybSldzPmTeeeRfo3K1rCEzD6TeTM7M+XOTrOtfUAZ
 82Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728091059; x=1728695859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rRrFbvTZ/HGEBsE1ELoQlg8dK/ihzfdXXCXZYjwC2d0=;
 b=kxCyKymHmltSetG1Mz9wk344GPqx8ItEeGD0iNqPq8+F2cYSsoR5KaJj+/OmgWYMxV
 OXBKxrMyNo7l9gY4qPLl+rTil2kdWE5xcnB48+TLtI4Hecazt6B5MWJ5k7MpqDiWAYoF
 wMImGLUFp/Dr2nfoX8dFTLp56Y8PzpfTSV30oi+UX/xChey2wwpzxYMog35YRt8VVwvq
 9W2bZ11WVmgWuRW2liHBLQCcZlWE1t8yZqbcR+KzTk4GY4w5a7bXV0z/zit37GCcViI9
 pL2ZVhPYlVd3PQa0nieQXcBCzRCExEcYW0sopwGkR0S1XgPNPk+JcP6H94VsbU0en47B
 f5CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+mpmvAm3ShHgBy4JLSKLDYrdLhcpwQALtAxH+jkTW3wn0CZvvB14DPTxb7jeEfKTNWMOX/COxlTL5@nongnu.org
X-Gm-Message-State: AOJu0Yyo1LFD+LoLoJiVdg3Ycz7eQ3iKf9OVCKnu8ZUYPfbi2xpSXYQK
 xshrUFJR4XwNBAnfDYUNaKkAM8Lbr9dRp2OGmklvFp6cLrRwC1tMLIHxr3bHjZw=
X-Google-Smtp-Source: AGHT+IHOEg+YflwqN+Fzoe0XYh2bmsHFo2Bplw5f13XN2yDzKVZpPovHcpCDtDvs4uZnHXUG3WQYIw==
X-Received: by 2002:a17:90a:b015:b0:2e0:6cd4:973a with SMTP id
 98e67ed59e1d1-2e1e6211a0emr6549726a91.5.1728091059187; 
 Fri, 04 Oct 2024 18:17:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b12adbcsm616688a91.53.2024.10.04.18.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:17:38 -0700 (PDT)
Message-ID: <85d9e3fe-67d3-4968-967f-0c7fb341f9f8@linaro.org>
Date: Fri, 4 Oct 2024 18:17:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/25] hw/i386: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The x86 architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=le; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/i386/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/multiboot.c  | 36 ++++++++++++++++++------------------
>   hw/i386/x86-common.c | 26 +++++++++++++-------------
>   2 files changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


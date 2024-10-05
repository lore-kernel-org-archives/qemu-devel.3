Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B27CF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtbi-0005Oi-RU; Fri, 04 Oct 2024 21:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtbh-0005Nv-Op
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:29:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtbf-0006cr-Ba
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:29:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e09d9f2021so1981296a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728091754; x=1728696554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MYdCuhRdFeP/4oLJSAnE6LdLiXFG0bMoi7kIm8NsyEg=;
 b=IqtHhmOkv098iTcnkQ9iWmEWrB1wPdEg2e+mVs1+lLYng6p5//K/cI/RESLIluFE+c
 LmudGQFv3b/QTCI1duwzBz6hQvi04UltWPu9q4uLtZbDsq/WX+9P6bj7zqyWDyniJkdd
 rjrIxTaCgj0gYeoCn2qe8B5vIrah7gy/iLB4eRTWuKqBYWMznhuZ21Ui1hDRq4wPC3t8
 jywqX5aE8fPtoc55jqBM4YZgqHnWXhHTii6CXMkfMrYsWvJEjBx4n5/vMtfG0B8Q2rzy
 eiIkNqeSdojGZZ+nK7/THL78mQ3Ty90KtCfXgI2/y/LdXxk0PgX+B9G+uhuymG2lBsqL
 PJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728091754; x=1728696554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MYdCuhRdFeP/4oLJSAnE6LdLiXFG0bMoi7kIm8NsyEg=;
 b=UggpP6RQoXe11jW8dKsKMM1av3mwZJXE00QxEFum8PQmJfIpBR8wMCUqIeUWfEldBv
 bsVjAjmw3Fi9VrGi282k+gY/dgpGgx3HoiHggiltdlHvU8qwavxqnzf7xy+/DLa1ziog
 kGfzOiTyyfuc9vzqZqqrJridbi46I3X6fq+zANYZ4lffbzqP9Kju9YSq3z4girYhpCZw
 ZrMf/vlXZht1KcwAFaF46hxe3RWURQMo+CsZnzj17qbF9XB1pQxBacbrxWkJXFcEWx/k
 05pPCKOTo4hvqioLnW/XQpUXbO3Tsq59j+SqFh+2Z21ZnFA6O5RU6mtq1X358dsBGGON
 S99A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7xMFWQuLJDIIvq7vpYlAdT6ROAUQ5a2F22PmHXVhq1JOo/pwHqq7OFN5FODkZ78T1YH7CdjjWKpx9@nongnu.org
X-Gm-Message-State: AOJu0YxyIn+IQUFSdRHxh1XPGRg/XTaJaeIh1gZIL/Sx6kUqA0Cqzqrg
 PXoGaCgPjo+IemeG/2Hzd+pnUZsymx8cRiAsrTmtM4qdyQo0XmHVkAklB5AK5Vc=
X-Google-Smtp-Source: AGHT+IG44kZRYTEMUkeTNvkbLPGjmMWO4bpZtvq35wKf0Gg2wsIxRhHIZTIv55PNAHqRGCH0Ax7wJw==
X-Received: by 2002:a17:90a:658c:b0:2d8:898c:3e9b with SMTP id
 98e67ed59e1d1-2e1e631ec64mr5459248a91.25.1728091753682; 
 Fri, 04 Oct 2024 18:29:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e8665833sm2353799a91.38.2024.10.04.18.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:29:13 -0700 (PDT)
Message-ID: <ffd96faa-9226-42f8-8bab-c8edb5b905a1@linaro.org>
Date: Fri, 4 Oct 2024 18:29:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/25] hw/m68k: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
> The M68K architecture uses big endianness. Directly use
> the big-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=be; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/m68k/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/m68k/bootinfo.h  | 28 ++++++++++++++--------------
>   hw/m68k/mcf5208.c   |  2 +-
>   hw/m68k/next-cube.c |  2 +-
>   hw/m68k/q800.c      |  4 ++--
>   4 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


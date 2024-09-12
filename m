Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F65EED63F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooQ6-0001gC-1V; Thu, 12 Sep 2024 14:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooQ0-0001fJ-9V
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:19:49 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooPy-0000TV-RF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:19:48 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-70b2421471aso23244a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726165185; x=1726769985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LS0Xxt/waXAb36tgh877xLU3SqctS38LHSsnmVCzQv4=;
 b=tOTVX/mRff+W7YYVfDEOuFY7wmuTVxGCXbMAqaYGyf0VyEQA17ssFC/8r3zO38P3H3
 +dEDVfUWByZYKRH5zVEMz+y9m+1w2OdRr+A1sAXUzqrZYR99gB6QuJvIM2iy0yeD2TG6
 e/JXFz7EauIyKgBdgFHAyPD334Kknufunt0+i5LvwRT0BpbOXPJXghrw//CiCN8/CJNN
 xEJfzuJV8UvMo3nojKF3Rp+5d+FvJJlyUlbWfiGI5MNqRkmir7s8a2EsgHbUWMMNpw1P
 rYPDodvyDarn3v37SqOMknAZaZWamOvD2kAucKH4kIL+FXj5a17egp78oWsF7Tyfz+iY
 HYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726165185; x=1726769985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LS0Xxt/waXAb36tgh877xLU3SqctS38LHSsnmVCzQv4=;
 b=IAPGmsOk2KJmhMZEI43CxwqnbJ3PTNx+5JDd8cJtSQFd2RvJpAxMmXdGldnx0YaBNm
 vRQUKG5pS1CBQHaOyVy5Od5UJ8yphgS/opahjMw08o3UBl6hg8SlY5rYTgycObZu9FqQ
 yPwWRgdA3w84SCBWOuFcbd8pVBbG6JX1CcYCOdPGkJA4L4PEcSSMgd9Lxx0d5QdU2JKi
 igym4vkuprGJsW1XVIFnYG8gEUcxFpNfUiy+/rS0X/tWhKKhPOOteqg76X9SMv0I4zIJ
 Gx20LjrH0goVlhPwMLBmt95qPruQ7JhIvkdH43puwd1pXbrOPs0YMRv/Q4xrXDCqPvgJ
 Q0+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJqeH9MqNRkm4TcsQo47czTx69hC3WMV1wTaSRH/bJxy19TpkTVq25b58Po9epyZKidYG9I08ELW6b@nongnu.org
X-Gm-Message-State: AOJu0YyctMBrAlaH+kWWv/kZSANm6RJPWKaaZe0+TKn6vqiNQ0UVTlKW
 5qlrxullwY9R4gYnnA2nj5ky0N+QXeyo8FFjd7GkP1uBHKjdHp7qHjN2ltOjKdY=
X-Google-Smtp-Source: AGHT+IHephLp8TfTY7u9swSWhaB6+yAFLNlq0/kp7rE91+ZwFa9kjy66SVp2QiuGDncm48lEL5DIAA==
X-Received: by 2002:a05:6a21:1698:b0:1cf:36dd:32e5 with SMTP id
 adf61e73a8af0-1d112b5fbafmr47163637.15.1726165184626; 
 Thu, 12 Sep 2024 11:19:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090b273asm4883972b3a.166.2024.09.12.11.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:19:44 -0700 (PDT)
Message-ID: <65a49d22-ff14-4d61-8244-2294991611f4@linaro.org>
Date: Thu, 12 Sep 2024 11:19:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 44/48] migration: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 9/12/24 09:11, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   migration/dirtyrate.c    | 1 -
>   migration/postcopy-ram.c | 7 -------
>   migration/ram.c          | 2 --
>   3 files changed, 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


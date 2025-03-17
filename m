Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B780C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGkt-00033H-Jb; Mon, 17 Mar 2025 16:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuGkr-00030o-5H
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:08:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuGko-0008KY-Md
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:08:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2243803b776so50268025ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742242079; x=1742846879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jbwfHzTVDuVrropP8jlEhigkqmcExvR4dc+yMYVewFE=;
 b=IdSU3XZa3wgbSATPz/uM6QmIHA7DqRvkG5i0rJcg1eyXCSd4itsE0pd9dBGKaEI/qQ
 1DLBM7v5RCJ/nHs9806TV2EBQw1P2M+9VGkxfxWgs3gfL5PvvVq1tm4abnVIpomM7h6P
 jBlAKZSoro+UyX+Mxx15uAdBqUfvf4amxDu+cMphOhVCyF7K2qIv2SKpr91Ksa+naYTv
 yQbWxTb0pUUm/zveMcgEaG0gaQE65tJJ/2PJ2iWqjIT1SMtxE7O30Ap0lm5C2qv6+ZBB
 K/7R+YRczRu9x6T/KRa77hMnY8ageCh3FtcepIZVknwGFFheOoF3//+y3PB96a8cfdAS
 yftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742242079; x=1742846879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbwfHzTVDuVrropP8jlEhigkqmcExvR4dc+yMYVewFE=;
 b=ZyISsxqBBRJzXw7iuLZG96YHIUjlfsO9Pdf93kwA/pN6xRcbpNdVa7+LVBwj6aSjYQ
 T8dQcHxzLU/YI608KVbupgiOBNZXmUVGRWjoPv2UaM2q5TNsL2IxNH6TdVSf/DwVGJz+
 fUALGH7FQwwmh3ycMJB9NXP01QhQBzNQjMnYKS3/dcB78xviZrzhZaTy/J1rhEeE+5xr
 z39XkpNIkgwNwzuXcJxCvl+wBm6iGdKJ0AEsMdgXOki6XUtQDbufe1BAPnwKWBlLHi/+
 ZoijoK9SLgNOqxsk9OikRMY53G5GRXcph1J56Tho6M92lPn4eoAQ7BemwJzMSYYYolfO
 UbWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnO/8rpMAmos9SFnRKD+aC+3+nWu36LZrBwxRn7ksDqHk6uCRVn1EHMKZCh1EL15PF48lanzKc6BPE@nongnu.org
X-Gm-Message-State: AOJu0YzCthgqQTMi3hMn4OVaR+FE7jYA5a2FCD0KdchZZ5EmiN0DRpoY
 8J2hZBde00eKzO/Olx/pCaI4ZzR4xQZp9DiVirH8WhbOdJ8OpmwRXGp6FDiViufaIf3z4fMc/LV
 9
X-Gm-Gg: ASbGncsgeXaecb6b8Y4+fnXIbC3XkMUUM/M8f4eWYjvtOd3K1dgXuSPHp41FrrVoFgV
 wXE6TCLP9VJECMfphWwC3fPDAI8JOxgcExYOZqfZ9OOduHa4latYHhbMwielHmXLcXGUHn6b9Fr
 dL3U0e/HlfYlyGYo9drLelEWBsLRJnuuo+8nQwYkqfnejC9wv6AlDL+YKorYswRxEsQ5QPXlmJr
 ZGEwBlgax+x2Z2IDaPruf8pEnfrkmLFF2WTpQX3H8HS3ZFpH4KIN7sab04AB/l6VbgZbj2s1PPc
 4kwIgB+HdG8Ddd9Yhtvhvj3K93ILA+QzOJr4Rpz0eE9Gg+q8HKRlcNdsf+xrVBGJX0B5Sf/62Bq
 w9Sn/xdZBAEwsEXqPMF0=
X-Google-Smtp-Source: AGHT+IHShnX3G8IGDH9ym40P3FyzomiKFk6bEJFBfwovsrvfia1Oyq1eso7ymUSTL2oJSAO+iiqrDw==
X-Received: by 2002:a05:6a00:a01:b0:736:3c2b:c38e with SMTP id
 d2e1a72fcca58-73757246dfbmr947268b3a.13.1742242078821; 
 Mon, 17 Mar 2025 13:07:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694e56sm8268448b3a.130.2025.03.17.13.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 13:07:58 -0700 (PDT)
Message-ID: <8bc32a11-8839-4dae-b1cf-ebeb07f1ae65@linaro.org>
Date: Mon, 17 Mar 2025 13:07:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/18] system/xen: remove inline stubs
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
 <20250317183417.285700-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/17/25 11:34, Pierrick Bouvier wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/system/xen-mapcache.h | 41 -----------------------------------
>   include/system/xen.h          | 21 +++---------------
>   2 files changed, 3 insertions(+), 59 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


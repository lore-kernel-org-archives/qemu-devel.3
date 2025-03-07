Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1ECC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdSE-0004Uk-VV; Fri, 07 Mar 2025 14:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdS5-00046W-6P
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:33:47 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdS3-00074a-2w
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:33:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22185cddbffso64224195ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376020; x=1741980820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQtKwscGA1Fc77I5lFPC6Ac6M98cGe5gyWtKXlb/MhM=;
 b=mX9r2kZepuJCng5JIBT9Lza3okXS8HpcMJNAalONXPi6H+OTGdSU7BiLDH+XxQVVYa
 4B3RnvoRWqjJlMwiQleJ9M7PjZM6cLRrDv+28hHMvopn8oxoZnitPYvWu/mh/uPBtTgq
 evdISkYqQvGYFWs7IqbJwTefBCsDpgkG7rqx04zlvexHB6qYD0MKu08ukWYIk3kt33KD
 lTbrLECUnwYFLitfIN/ehB8Jhr+v++Imv0wKjFT0U6FZ2dgeQ7XnXXsuS71BVk+xj2CM
 0VgZXqNO58B4sekkwzlhOhdczsF3WU/LybYX1+F593tq8ZLlBQGazJv597WjwPJE59vq
 eMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376020; x=1741980820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQtKwscGA1Fc77I5lFPC6Ac6M98cGe5gyWtKXlb/MhM=;
 b=GcBFk0A9jWU7V1QHIEs+ATjOTN7GeyQ/kAtfMzLCEbmzltma/5BBGTYJRKE5V2abtx
 b6cCFOFyWfeasPDhcjKPJus130240rR3J29Sd/VUN1uZCmxLE3A3VE3XLe/sRB38hy41
 xl4A3oOo02MD1GarXKzKk6zHwM3p+8VBN8hIklowqgVNptcKwYU9muu4ZRwbI0qLQ5AL
 07peCIweST2s+f+MnuvwU3kf0vY2SIwnAdGdLGH2Spe6zl6hyZxVrnLg0qeHbaEE/YTv
 x+eGluntcRg7ZvLR03iUaBVy0Oxe3fD5qqX8eheAXY7gVVVfmymjbQ9FNEGX0w+09ZFO
 lh2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiNjHPYNWcAsCfeVP60+d23E7fvH/XzV7blGdKOFZonrJE0+SVjjHswBqplrNKDBsJBxHtX82cSv5X@nongnu.org
X-Gm-Message-State: AOJu0YwbAS/SuRg7SWwSEJDZ3bY+cK0kuTJNAQCg+Y3cVWdJ6up4giCv
 m0ERjL4vJ3MizwfoDAzTjDB+KFdAD6wQKrAjSL2h0vO1Nw4B+DDWiSl9OjS0nI0=
X-Gm-Gg: ASbGnctMJD/uh41IP7bb5knDVNrDCX9hVzVjQETZD/TYm0ffAsS0XOkjgdNxYYEDxGH
 uXtkLhCuQwZEuigEg+0TU5svC+gj3awHuUNVDmkORlifMMISWCqrMeba3/ljRcgddOFi2jduVX2
 ORm6N6z25IC+D/awkJ2B5ge2GvseodcrdVPanEzhJLyT9m5gs7qr6ajs0N2B8FutHfdOB7NvaAt
 9E8nBGqXFqX5eXGjiEjThj632IcjLPw6n94uaZq4PQn7m8guMgVo+UdA5gCNNmapQKhRttKH0Co
 1UnE6fkLIwHQq1eD3QgYME6APZUD6O7kYo9hMhPpD8a/V1wMemL7Fi3MJak7s7aEAd+ueLUDUrj
 d1cuX+ti6
X-Google-Smtp-Source: AGHT+IFnRH/M1Fyd9n+8/LrvLU+Y5MRCT/ZlZtrgAy0yqYLSdoH1av40nIgKflPPMbD+gK08sTp4Tw==
X-Received: by 2002:a05:6a00:1302:b0:734:ded8:77aa with SMTP id
 d2e1a72fcca58-736bc09a3f5mr1117498b3a.9.1741376020123; 
 Fri, 07 Mar 2025 11:33:40 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ad0f7eaasm1847564b3a.76.2025.03.07.11.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:33:39 -0800 (PST)
Message-ID: <49257778-4133-451b-b6d4-d2e9db36c3ab@linaro.org>
Date: Fri, 7 Mar 2025 11:33:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] hw/hyperv/hyperv_testdev: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307191003.248950-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/7/25 11:10, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
> index 5acd709bdd5..ef5a596c8ab 100644
> --- a/hw/hyperv/meson.build
> +++ b/hw/hyperv/meson.build
> @@ -1,5 +1,5 @@
>   specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
> -specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
> +system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
>   system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
>   system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
>   system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


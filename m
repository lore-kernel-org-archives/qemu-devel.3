Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DC6C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspci-0000Kw-Cu; Thu, 13 Mar 2025 16:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspcg-0000KX-PQ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:57:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspcf-0005pe-1p
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:57:46 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso27649595ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899463; x=1742504263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gr1gTUaCpER2szKBCxxxG0fJ2fH+tD2l8v5/0/avcPs=;
 b=Fd2/6sUH5ogRIxK6PjNp+U08AFg8ckJYiptEcPW2MXHP0ys8/FU6sD1/5bB8sPSX4P
 qXavU2Cs1PZ6AtewCesDPYTPpUyRlxf7N0kw0FMGmSnxCNWh7QYH8o45WYcq8BhFCMf+
 7Ryym+phkfd/IddRB2Z9Do2TQlnRTZQEPdWEJYMz9bb/5w+YV2ETYvvsBzXNP/HCqF4f
 J6MfguR1NozYZ+1wjJ+qHl9MsmrI9lRf5sHz4iQe2f1odkVDxItajUDMXsCBj7dIDN+N
 nzhrXkG/YqX3/smJUuVjSBx4jDlUzCmCV42wcue5O6Gjxk1m6/vbIIXO1LP3OBojtKxm
 Y6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899463; x=1742504263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gr1gTUaCpER2szKBCxxxG0fJ2fH+tD2l8v5/0/avcPs=;
 b=vlbBEgH5cn/QI77FaLdZpDVaOnqIQ7yexgzCD5Kv+AMSXGl9H6UfFFXrkFR54yOxlA
 /tGoymw7SCr9nY5L+y1UQTt756DFhKSkaMRLLVWQVF453+cESxciGJOMAob8x91xoWlM
 L9gTspW3yB4S6C3c/JNzB+Veq9MNEf3838gGG3aVnWG+0MuNqFQpAUyv0oVPild0mxx7
 HuskmBQXfO79rtADMMkvZyGd48MEIfLc98XgeBA2Nyqlvwdep4ouQTfe9t2ahDTycmqR
 6ojoGJnl/YmYPjASuEVGlzsBn71J0jy93PuF9Lgn/esTe2oLL+Pw6H2u4JF22dZfeyaU
 1FLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC4ysXMcD/Bf6lgMoilPnw9xPAeSw2EUa1ftyFX+NsE4Qc9QwGu6wu0qQkiIJZ2LhDSQ+eX/4v1b0c@nongnu.org
X-Gm-Message-State: AOJu0YwMkmXPtv/oHebH7rh45f++wGfKt91hbaehmZksZXfYmGpuopkr
 DRTfl+PWNOYutrLJTKU7njeUye9dJEKDnU5rPoriRCjOrke3vMkUenn1Hi9GAqM=
X-Gm-Gg: ASbGncvWnK5QJlx+liKQ5fZiTo8RWGbHt3h1hEFQUbMc6TrnL7wpXBnIvwG8NlHbjOG
 abVujVtB4BP+xXKgASsb5iY/IiCC6gLAshPt3uBasTGc2wXwmlxF1a8i3FljiRto412X7yM+vVk
 f3v6r+d+NMxByKb4vTYXX1PFXfJixg9uF+7qlVs7MxZKFI46v4bW9rnGpKl5b8BCHuCiY2T17Ab
 JciMDRS6z3EjUiKALR7PfXFgplzPiAXx0gx7NDBcMGM+UofK9qsoU+26fguXKXfrd1bzwmAQ1Ol
 9xZAHYRMKzsKxZWGIraXwOBLrMGk5+29c/2wtMyqc5MqelPLCJJbNV28LjTGrjaob8xo
X-Google-Smtp-Source: AGHT+IH1uz+rjymwZLjbiyZteGh+WsF6iVmodVtx1vdOiiiXWDDvHLk9An8OiCgLdghB0uPIqROyhw==
X-Received: by 2002:a17:903:986:b0:221:751f:cfbe with SMTP id
 d9443c01a7336-225c669312fmr65296825ad.19.1741899463631; 
 Thu, 13 Mar 2025 13:57:43 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a80d6sm17989685ad.87.2025.03.13.13.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:57:43 -0700 (PDT)
Message-ID: <a3b18a9f-8640-40b3-b25f-e2429850dc84@linaro.org>
Date: Thu, 13 Mar 2025 13:57:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/37] system: Move watchpoint.c to libsystem_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-28-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Some of the headers used require CONFIG_USER_ONLY.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/system/meson.build b/system/meson.build
> index c83d80fa24..2aab3e97f4 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -23,9 +23,12 @@ system_ss.add(files(
>     'runstate.c',
>     'tpm-hmp-cmds.c',
>     'vl.c',
> -  'watchpoint.c',
>   ), sdl, libpmem, libdaxctl)
>   
> +libsystem_ss.add(files(
> +  'watchpoint.c',
> +))
> +
>   if have_tpm
>     system_ss.add(files('tpm.c'))
>   endif

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



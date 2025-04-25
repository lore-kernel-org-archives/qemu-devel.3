Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F420FC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8NDE-0008Kg-Mq; Fri, 25 Apr 2025 13:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8NDC-0008KQ-DG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:51:42 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8NDA-0007Io-DC
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:51:42 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so1789257a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745603498; x=1746208298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gHsqF05gDfDZJDjvInAkAzw6+W/TXwh11F4SS3tmYGA=;
 b=LppacOLE3tXOzyY8/WCkoOYgBIHhCoA2d1kjQ78MS4kzv0k4in3Bl/NrvxH/JmTsbo
 Ig6VvhybvtEXoTyaFAn8hliEbDo+1fk/4TUHCdkrw7iD9bvysm5XykmHc+qRnD20fx1w
 WNTxjiVQ69/W7whHiS3k8t+DLrzlWH4laxaxsV2YKunF8hxc0NwipoK2VIMhQSUCkT5W
 xQqIwvDYH4WCXHJPe1q6V0HbBOBEKhB2s5ODFfMoIxfeqtB8NCp8l0hcy6CWUDgv+qGL
 X+EofIJMJck73NkDD79vHjQ6NBGOHhPD7EAJcslnLU6cM+8GOd1AN2ZtkIiFnfe1mk93
 KAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745603498; x=1746208298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gHsqF05gDfDZJDjvInAkAzw6+W/TXwh11F4SS3tmYGA=;
 b=s2cmk29ugy60RPx1/UgZUoH+1SrB9jJKdZUjt7rbJYwZl8vEGOOOQV3qVdxRD15q+R
 93hBJhrk8Z/eCdY2O2cXMKJcypFe9w0MOTcis5MqTIt9hmqx3UjK+eRvweH9MZR+tGhD
 LJ+nsY2ZSMljcadkmf2XD0D9SC0SkmYTlgX+jJOMCclGbocPUZIqZtl3mZZmf17LptaS
 20M34Lffs0mDVGxtou+Z+H/RBs8GF1mD2s2aLsS1M89aEvOzGSRUvR/bZY5Q6gzNqB7T
 b8pp8VjzSPD2H6vIbML844TJZVfUZDHRl2ObZTQcoCM7veXtxkGr+uPGqyomNNwgdYLX
 2aAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHJKiFtLGkRgwErsJzssGv5siD/HGNRT9cZqisiiKEVvqzwfQd9YESdkKfjci1+HrijERIZJaS1aFF@nongnu.org
X-Gm-Message-State: AOJu0YwRk4zMP8DuVVoLLxprhvTqYhfvXa/RJDFCdzXBk9izaqIpeAHu
 5u94aYyX/pceeh3tLiNrQOuF/hGLp95AF8Vz4UUWU/xfhRwahFNABs1FTI7SNPU=
X-Gm-Gg: ASbGncu5EdicfTU0Muq0+pHvGbuYPkth45QDAHOeX8OZ/NTsIMANgdz13Dn18X0QhN6
 1xJkEkarUYY4rY+9kpGtQOc2W+38450To3J2I9SmgiAimI4D/W3n6p+bXk2ZlgNq/Ap3RuoSM9s
 BjssTVO9J2+/bkKf4HHQkEZeZaiVQR2Dwa8mLMe7Qq6X/xB6hw2xg9FP1rDErCaktZ986zb8ie5
 J6Q/Z5mgoNkOrEY9FlvR7ICEmeTiOmivCiSQJ6bVdDY11r3J+LFP04QSL5xGQCpt1MNbvnElpbD
 Tw3m1LFq22C5/Kayak5gX/qwV2O284gsDVkKuZiGToYH+tsLUkQEcnxfMJvMfz6E
X-Google-Smtp-Source: AGHT+IFFqDJly2PReIQnI9MexyTjMuZj1FVTobKJpRXXKAvNVtydr7sR7x6T1mbXIin1mhgeDzViBQ==
X-Received: by 2002:a05:6a21:9981:b0:1f5:7f45:7f95 with SMTP id
 adf61e73a8af0-2045b99afa6mr4061692637.27.1745603498463; 
 Fri, 25 Apr 2025 10:51:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25941d65sm3598325b3a.63.2025.04.25.10.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 10:51:38 -0700 (PDT)
Message-ID: <667613df-e7fe-40ac-ad4c-b57c70b524ea@linaro.org>
Date: Fri, 25 Apr 2025 10:51:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/hvf: Include missing 'exec/target_page.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250425174310.70890-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250425174310.70890-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 4/25/25 10:43, Philippe Mathieu-Daudé wrote:
> Include "exec/target_page.h" to be able to compile HVF on x86_64:
> 
>    ../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>                uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
>                                                  ^
>    ../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>                hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
> 
> Fixes: 9c2ff9cdc9b ("exec/cpu-all: remove exec/target_page include")
> Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/hvf/hvf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 23ebf2550ac..da1dc66da07 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -50,6 +50,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/memalign.h"
>   #include "qapi/error.h"
> +#include "exec/target_page.h"
>   #include "migration/blocker.h"
>   
>   #include "system/hvf.h"

Thanks for the patch Philippe,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


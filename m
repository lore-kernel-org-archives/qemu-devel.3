Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08212F4485A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 13:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBC7u-0004wX-7h; Fri, 10 Apr 2026 09:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBC7l-0004vY-Ot
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 09:42:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBC7f-0006R4-L2
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 09:42:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43cf5fbacc9so992796f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775828529; x=1776433329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KkWN+2gPUyvGUnwBBv30QI316NAd5f6gp6G0CJuwBE8=;
 b=v4ZsLDRmHzmFWmHLyaiOcuSunwPAILIh2XULONoTf9MFtYeA49c5Kwt1cudVUSKSIH
 oqKKMevsUqfIqmuKTN/q8z0MaiO+aXS2S6GXrLuCUnQT55HkPA03tKSN4mndeZnj8d2W
 POz27/INqnNMsKbUwtpgDviK3XZ6B9y45mhgnP7F3m2WelKV/6Iu/exzeVv5Km7xPAPA
 F/OB6IudsoTaPStM4YKa0YylOc4IfGaHcmLlf4r3vTQDhgvoeMK5+y74g7cRsWSAp58c
 4KlHjqTjIzBSDiac+3cYw8M45Pn5admc+WT5dc9SJE1AfEF+zVd5ZkyO5+EZfv5x9aF9
 hIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775828529; x=1776433329;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KkWN+2gPUyvGUnwBBv30QI316NAd5f6gp6G0CJuwBE8=;
 b=ppUiOUSU1RW+NSPXJiA5hzvpY/Cuh9gY/UfCHVWWyNecPG7Jln30INijzsAAEvwkx+
 3gFyyaJI2VHQ/MUCwCHstir8paw0kfR3dSStsoZem7AnVsGqmRun03thpEYeD5F5d05t
 W33i0klCAbDf7LvvttYH5xtQWbcKQFr24uaQ66pMTGHHvCe2s6zJl9mO1UC9qTd7uRLY
 rSfERwnzDEMr/9Qcxrchjq5iQaz7N19+3HtI/S5YIl/3+z1Crtd8CPrS1jGn1EzZCUSr
 H+CvEzh/qw7L0QYo8rL4MnNEfz9E32TPlfi+PiAErINt450hftS0qLOhhdhLyRP3WKg0
 9U2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCRsPA2dR1WaVKR+h3gUOv8+gROZdfoxV1BBf/zj6h7ccaZ2FldjzEjTiO1J1FgKjTN8LMMu8Ine1T@nongnu.org
X-Gm-Message-State: AOJu0YzJy+rJQdGBJheKqlQgbtv/LKClWWRtvV3jStQPEmvqPuDSFgFh
 hYd3R5KbYl0/rjev4gB6Ayz10xx/3he6oRzVmdgfAcB8Dh1XFSWQ76y4uhiUN4mntU4=
X-Gm-Gg: AeBDies6sUcKI/niBpeVF2QHYzWhx4gYki6WY0eOa4dY+OagSKpUnTtcu3hEX7qAy3h
 vjsTlP/DZCAmBrM3TRaMnDg/MyyentXZpsxeV/QXwkb5z4RMFnlJG7mAYm75fam5zmgud+EAOdV
 /0PFoayCMQpWrGP3uxQhj4SK/qfMNBhilk/FMXy151f+3IDQJxQB6HLAxkEu1XzNX7PzlpEmeFF
 5aepYtrSaJ8cfmo6/ye8Ua6JBVoOnxEqcipFaA5pPT/n0rE/rOaVAeUZdeMWUWJCHaC5OCXIcKc
 GsD+T7bPPf3EW2d3mzZ42MO7KoYagJOYY2uhyClr74POWdROlt1MIeBRtpylba+jsLyiEErD0TI
 Am+oUkxJjWyylM7vG8uKEFmSY5qqx0t98PggY340wi8Gi0u0NC3QwU6wCZPllCzfxlUZKvmNdsk
 pYKxp04DvbgNze41mVnGuaNvn34NJxNfpKVZa/QTgpS7hHw5iM/97PLpPWe2B9R5/GQ8DAHs2rh
 D8m
X-Received: by 2002:a05:6000:1ac8:b0:43d:1de8:80b1 with SMTP id
 ffacd0b85a97d-43d6497b664mr4640466f8f.21.1775828528735; 
 Fri, 10 Apr 2026 06:42:08 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5d88bsm6374224f8f.37.2026.04.10.06.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 06:42:07 -0700 (PDT)
Message-ID: <231416b9-034b-450a-b4e4-603f4cc3cdaa@linaro.org>
Date: Fri, 10 Apr 2026 15:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Remove unnecessary zlib include from
 qemu-file.h
To: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
References: <20251219014512.387773-1-chad@jablonski.xyz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20251219014512.387773-1-chad@jablonski.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc'ing maintainers:

$ ./scripts/get_maintainer.pl -f migration/qemu-file.h
Peter Xu <peterx@redhat.com> (maintainer:Migration)
Fabiano Rosas <farosas@suse.de> (maintainer:Migration)

On 19/12/25 02:45, Chad Jablonski wrote:
> Commit 70eb5fde05 removed zlib from the libmigration dependencies but
> missed removing the zlib include from the header file. zlib doesn't
> appear to be used anywhere in qemu-file.h. This is fine in most
> environments where zlib is nearly always in the default include path but
> breaks the build when it isn't (NixOS for example).
> 
> Fixes: 70eb5fde05 ("migration: remove unnecessary zlib dependency")
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
>   migration/qemu-file.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index c13c967167..c50a3fee53 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -25,7 +25,6 @@
>   #ifndef MIGRATION_QEMU_FILE_H
>   #define MIGRATION_QEMU_FILE_H
>   
> -#include <zlib.h>
>   #include "exec/cpu-common.h"
>   #include "io/channel.h"
>   



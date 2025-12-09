Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E71D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3Dj-00061n-Is; Tue, 09 Dec 2025 14:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3Dj-00061e-1N
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:17:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3Dh-0006SM-Bp
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:17:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so54235515e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765307876; x=1765912676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VgrKFWz1YUsFJMrpVH8v0pRtBaA9xTLSg/5dX1jP6Gw=;
 b=jMuO9azHnAaEbDkp4PlSk4rhqFJs0UPcITzSLCZhL6v31k0bTBpx+TNXhI+/MEdJ0a
 PrEYgbYvVbRb734LBsHJ05EYaiydSp/2pF0agZGisQn/1uquHY7l+f8dJq7wpLaPwsE4
 4si4sqyj0UhjbIgTmRWE1GppqY+A75YohlEN6SJYJNpiqNhrcwjV0kRdHqSuP0lDn5LI
 4afXLp1jFCqg6pBlgpwSeqr5/g8ynIerccRvSnfRliEXM2Pxlcpikiwb6raxF/l1FYOc
 qfNEdvctVtoB6T3ronH41Ioj+Qgj8kvJq62tT7gwMPp80onbPr9z/82DjVpcIMpj+Jaq
 D4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765307876; x=1765912676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VgrKFWz1YUsFJMrpVH8v0pRtBaA9xTLSg/5dX1jP6Gw=;
 b=GPcpBxzfeQd8BIUNzFddBPT8XV9yhvc8uV3Q65GgVxZeeUBgxrJqs5bmw/bKAlbGCT
 EOOcZaIjBcxsnV7gQq4egfrYRYWL6UE16geZwJjYFo9veMG0syh33qu5Zplw6EAFIpGU
 5M6w/Yg0Usqgu+hey/TDiVuEbgHxZ2AZRjlCM/pgzx0NwDF07kvE1wzj/yloyJd5vSC6
 rL6juNBGei8dWW9SchS4xr5eIe2L5GZjFvSOQbjprwL+Bz0R+zH9dPBRW2bsWU8SYVEQ
 M5K/a8YNXZl4UqTK20WoREHdzNE9bOhQP7Q7Mvj/SvOktkietODTCqPIKQ959jr2kAyb
 GcNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoJ/qph0SYJVLyQv3Dx9vzG3vIutGrNcSQbyj9yT1xzezbgtEjNsVmL9wPwAEzL6W9HaIEhz6R5wpc@nongnu.org
X-Gm-Message-State: AOJu0YwrvNDrCwtfCXN2r/R9cpMUep2QBCvdfPwB28ifpGl2kn5RppKM
 EslOLXUc8gW2ovb39CtFANU6w4fv3gsfXGyCBxV5SwZn67MdjWvvzK7J5IxFF656qT8=
X-Gm-Gg: AY/fxX4cNXSs5VthjWSqqMaXwth0G+ntYEdMKMz/wT8Hmleu3+mu+S0f5z5N3TSSrCM
 BWX34k8IHzJ4voJh0tfYbS7WALr9LUMdhIOHDHM/ZSgIrjNRAM9UMJOegjPGb6nW8mlrYOXq9uJ
 kNg1yaP23lyfkLj+GfyfvxrZghve5Jq8cdKQ6E9jSLOksyqT+iLoddsjXUpYByWYeRYxJVHYQef
 JFiMl6TLP3s3v7KUGg+y2tPhYDib0JMGW0jFRNjMSU6YwkDHDb7Q6cC5VoYvGpg+5P75gsPOQpt
 kbWBvPjP9WS+n7cdIuR630lDIum5qtyq4Jo6c4W1vi3wHscr6egv84rX+BDWLBNIh2KbEZmKJGB
 hr0LFbOWaIwrB/KoV9OIA7yIifNyFvPuwiDJ5skC4RLMm2sqAZ5fxlAKFRm6T4q1i7oOwOUibNV
 kikbjzkD7GGMhS+TwpJ/Lt2AOyH37dYjFMR9gDk2O4WGj/XirEVmhcyA==
X-Google-Smtp-Source: AGHT+IFml7a1EVkyM5WB6ALY+zbQBuma7O/yOeQfFRy3u2E/SZkrhT9h//lYMfrEsJeDRDpVggZ5XA==
X-Received: by 2002:a05:6000:178a:b0:42b:41dc:1b61 with SMTP id
 ffacd0b85a97d-42f89f47fc6mr13343891f8f.35.1765307875595; 
 Tue, 09 Dec 2025 11:17:55 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm34678577f8f.22.2025.12.09.11.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 11:17:54 -0800 (PST)
Message-ID: <788f9e4d-86c1-4830-8eda-dd70d8fec7c4@linaro.org>
Date: Tue, 9 Dec 2025 20:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fix const qualifier build errors with recent glibc
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20251209174328.698774-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251209174328.698774-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 9/12/25 18:43, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'.
> 
> This breaks the build in various files with errors such as :
> 
>    error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>      208 |         char *pidstr = strstr(filename, "%");
>          |                        ^~~~~~
> 
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Most changes are straight forward apart from vubr_parse_host_port.

Better keep the vubr_parse_host_port() change in a distinct patch (the
change isn't really what this commit describes).

For the others:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   Please check.
> 
>   Thanks,
> 
>   C.
> 
>   backends/tpm/tpm_passthrough.c | 2 +-
>   block/vmdk.c                   | 2 +-
>   block/vvfat.c                  | 2 +-
>   gdbstub/gdbstub.c              | 2 +-
>   qga/commands-linux.c           | 7 ++++---
>   tests/vhost-user-bridge.c      | 2 +-
>   ui/ui-hmp-cmds.c               | 2 +-
>   util/log.c                     | 2 +-
>   8 files changed, 11 insertions(+), 10 deletions(-)



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA3CCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 03:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1GNu-0007gC-JC; Tue, 23 Sep 2025 23:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1GNs-0007fX-Fg
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:41:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1GNf-0005OF-0T
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:41:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so3177666f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 20:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758685275; x=1759290075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=whBYJTLx0x8V1lhwStNMG6rXJfg7q2grwqz8HecnMw8=;
 b=bihlvZdQtb+iKCCvu9UMriLfCweZ8m/CJ0gi0/tDm14gCvYEBE0lqA2z7q6IDBY8i/
 lBjbNMT3cKFfbEzrjNl2BfqASmAJ6Ty/uor3mD3Yxp0sGHdhyK8taciEZc1F2LJAWvf7
 w4tpMC+Xkshyk/hpiXaQYVo58E9EQtDS+Px9gHI+Uu1j2qOtmHNufo/sm/lQ53Aco8QI
 diUw5MwnoDz+0AAQ1wR8QAokZzOvCaJtO/U/8oJlEpkSmMqNh7GG643IPRmrO+85zAOw
 JPaKO5TbOP5G9HjZjdUnYhWmZLOLhe2clWQO1yWXHso9FTmrsiTG0vVT1YSXpZmQnBR4
 zENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758685275; x=1759290075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=whBYJTLx0x8V1lhwStNMG6rXJfg7q2grwqz8HecnMw8=;
 b=aNQmaRCv0DnGU97idxoni6opb4DpBUmbXGkHAXKydNavMHKkqwWPHkwXQmi8cbMy1y
 LtfbRVwY7f7cElWHLFQTdrWSpW5FRjpP/r/WaACNF4kRJ52MpOhdDbjjyXxAJQ3/xgFt
 +CuHHImUDsRp6Zs3dE7IVAtQrD73veJHnei+D1WUfdqPw9p1/oABMkII6/CeG5SSMamP
 7/GJPQSBGx73TY6ZNKG3oW9MOrmEbvhyxRtjaWaXlc2SueRsltOIAPvCn0KlqfyS9BlO
 poQZS4zHmSAn0QrxKxTtycqd/77/HXtjyG34uU9Owu+2K+u39AFL4ybM7uH1c/wxKYtQ
 tECQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO7kIpDRCDwuCthVszY2NALoc6JdLllayCisjwNEYIBFnYhagv/DIUPYxeDREq7wDCObJfy18TZRQ6@nongnu.org
X-Gm-Message-State: AOJu0YwUy/ucoaxxRkfFk36TbXf0Tm1+nx1nDHOoKN9qgM0qMFlpK9E1
 3shGHlqLfFg2qGqWd4fIgy5mfI6o4x6Zk5KerSDHD36H0ggX7+J58qvManBBlnivkaE=
X-Gm-Gg: ASbGnctU9QpZw0FurM4Emm7AsY/dbInu4C0xWwDmGIs7AUMd9Izx/bfiChwqPsQFtCb
 WXBrrNT5m8u07e+JDx0D3lsPoMgnSNOPGv6CLTwOJA5yFWkBUj0sULxMZGPlZD78EQKSbz1vXvq
 jbswR0Ksw0I/6QQxUAuEx2ein0+RdPdba26+BKbw1Sbz9HbwTy6zBsq7vSqBc49nYNFsOZWe7mf
 semSR+XtXkJi0xgekDbya7078/KsFEevXaxwQUQ6wzn4olt863kfhj3NckA7dqDn2Bvxt2QOLCA
 vwOa8QWO/pSpqKIra3I6Xm7Pu5PMKcd1IZ7Rx7N1yXv8lTbDBZjIK5ZEB0WGHz3pBTHyNxZ2wvh
 paDQot2zyRmwlW0wmSn9a+sj7PLr9J/QApieg+FyZmaAhEKGjgWl6Bsutw/MG5X/2bA==
X-Google-Smtp-Source: AGHT+IGTOeZm6GLr7bCaBQc9ROOoWbGtlkadScmEC+l2nPXXAKm7Tyk4dpgP47+7rCrZZwjvkkjAng==
X-Received: by 2002:a05:6000:208a:b0:3d1:c2cf:da07 with SMTP id
 ffacd0b85a97d-405c47b8a80mr3042909f8f.4.1758685274974; 
 Tue, 23 Sep 2025 20:41:14 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9b1dd4sm12069375e9.8.2025.09.23.20.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 20:41:14 -0700 (PDT)
Message-ID: <1bf93222-c3be-4a11-9a5b-71029595d74b@linaro.org>
Date: Wed, 24 Sep 2025 05:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: Add clear_flags argument to page_set_flags
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250924020735.3909216-1-richard.henderson@linaro.org>
 <20250924020735.3909216-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924020735.3909216-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24/9/25 04:07, Richard Henderson wrote:
> Expand the interface of page_set_flags to separate the
> set of flags to be set and the set of flags to be cleared.
> 
> This allows us to replace PAGE_RESET with the PAGE_VALID
> bit within clear_flags.
> 
> Replace PAGE_TARGET_STICKY with TARGET_PAGE_NOTSTICKY;
> aarch64-linux-user is the only user.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/bsd-mem.h             |   7 +-
>   include/exec/page-protection.h |  13 ++--
>   include/user/page-protection.h |   9 ++-
>   target/arm/cpu.h               |   1 -
>   accel/tcg/user-exec.c          | 114 +++++++++------------------------
>   bsd-user/mmap.c                |   6 +-
>   linux-user/arm/elfload.c       |   2 +-
>   linux-user/hppa/elfload.c      |   2 +-
>   linux-user/mmap.c              |  32 +++++----
>   linux-user/x86_64/elfload.c    |   2 +-
>   10 files changed, 71 insertions(+), 117 deletions(-)

(a bit long to digest)

To the best of my knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



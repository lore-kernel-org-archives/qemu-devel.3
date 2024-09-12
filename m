Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6FEEEB59E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooAJ-0004CA-6H; Thu, 12 Sep 2024 14:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooAH-00047U-N8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:03:33 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooAF-0007U9-Ra
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:03:33 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so1095963a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726164209; x=1726769009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LgRnqSfoZB4AEoejLoY8nP4tAqlrqQuvRxzYLj6Fue8=;
 b=UqF5lCVnzyb2CmOxGv2QWqomOKTxer3dG6Ix1GP9BTATjbkT35wQpco1Yze6ZruL0S
 /iCNlxbMBwugEqzbul2u6GvfDS3xYM09+R/8rqOLTeA1TEzE+uU6uYA6N1Rsly537VRr
 aLDmNh0j0ETBjlyQuzKuJocm5u59AstNEl9G+FaURWDVVbzfSl6TtBKPVtRskC0PLxst
 CCkkAS/ttQGmMd+xPKJO9TU5A/NOS7kGt9UhllwfxLxn+kGFoYuMhMblKtqwov9/eGT1
 ltbHGHdQRuDgbUY7Q/2sJGslZTZOeIEjeCdhurzcYF0TD3/5taU06sJ6QsXUaZlRyW5T
 kP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726164209; x=1726769009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LgRnqSfoZB4AEoejLoY8nP4tAqlrqQuvRxzYLj6Fue8=;
 b=PLclVml6bCskXl05tj0x7qsFNSYQBnZUAevVeJ9pXNpwL0tuVqHsTmQgFt2guDxLyu
 W1ssCc4mbQ7BkYO/dDASBOv+Op0SzDvxZ7FANBuN0yQMvq+W5geUmR+Igrgkx6HwizkH
 BI9Q/ZTQEzjkZ/8I7uEy+L3mnWbA6WVGWOAaLlRKcgGqCsP5fXainfkBJ/6m3w+lJ8CG
 ft6nwxMa3pUUljtOqu4rxIl62X2V29P9sAAa/xKRoeDHcAVsvw2SmE9Zoh4zfrqASp1t
 gvvW0zXPWhZwU5dQAZFDXp0UoxoUPOjZKFAbfK8LtUQwY9kVO+xbIp83PPLzmcvtUiFP
 RLdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVoYVSQ6r9XhX3iVMhhrYMJk3ORLt2k8q8XGYRsD8yEsXSR5sNQBuJawFLdgfx54IOLKE/rNymLejg@nongnu.org
X-Gm-Message-State: AOJu0YxJcpLdRnM7hjg/2ggaZBZayAYjaHBWcbRKZtvxwwatvCAB2fOi
 +iIih56qwpqGt1iGT7UC7b3qTZGIjMpfn14wUxvqoSTWc6hUrtXWjkkEi86c7WU=
X-Google-Smtp-Source: AGHT+IFxdNcHd/ZoUteecDEYvsq3oDdx+1zPy7GYBKXXEgHpxci2hrwckLkdj0I+n/MdPa8HF4sTTA==
X-Received: by 2002:a05:6a20:e30b:b0:1cf:6c64:fb00 with SMTP id
 adf61e73a8af0-1cf75ee4e3dmr5764130637.19.1726164209419; 
 Thu, 12 Sep 2024 11:03:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fba421dsm2066528a12.5.2024.09.12.11.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:03:28 -0700 (PDT)
Message-ID: <1223a756-9aa7-426e-b3a2-19501c647cb4@linaro.org>
Date: Thu, 12 Sep 2024 11:03:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/48] include/qemu: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-40-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912073921.453203-40-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 9/12/24 00:39, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/pmem.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


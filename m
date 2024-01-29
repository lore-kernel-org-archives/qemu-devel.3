Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5423DC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURmw-0008GV-Pd; Mon, 29 Jan 2024 08:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rURmv-0008GJ-Ig
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:35:01 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rURmu-0008M1-2Y
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:35:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40ef207c654so13029535e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706535298; x=1707140098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmuJZqAf4k8ILQuzFjy3xI+NHvxoPt8fAKGrGGa1NgE=;
 b=yfYIaz0yKlZRS0htnhztpEKzgg4pnWkJCQ64gqcW0wLjnH6egdg6DxQJ9/roE2dCmT
 BGi/Th7mLiKl8EpMcvhVpb+WQlFD7J7CaDqqhHu9qK3AtTV/cQYa6EAy5AtGKAU6oH3X
 3x3gsYwhcc/5YHuAscmIaIIK86XWhMOern2Ykg997hsbg4kG3Suyh7FEvZeQK/CgHVVH
 mGCPYSkyvbNDFF19bRffb3qQ+9ktiTvn1lQY2Ox8rFYv3GQlon+g2p7/yPJFSqFCkjy4
 /4ZXvaDBVwiXZskMDMQlVFGFAZ2bnaqa/8kkr7+apBtAFH2IuX5mE1zulZGrND79VPNL
 E/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535298; x=1707140098;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmuJZqAf4k8ILQuzFjy3xI+NHvxoPt8fAKGrGGa1NgE=;
 b=lpC5qTvCr5B2yYVMOMSQHkvyM068qnxol5VRAZyN/+mAWfmRKS39WZOVxBGdRolaOr
 gmJFPKmARqJlKCekkKspoGkxWsMzQuNU5xOGqsvPKi2UUQowMM2kJpbYxwEpB4kguxDq
 Ymz/05OpcXWw4JM6nkFd90p6iECAy4qtQ7pe7rJWY7hk/fdP8SVBjrdwYOsbUwtADmkj
 Jqlagsv0g5oadq/nTbloUHcBhL3z1iJMzpRRZGj4uya2ft5j4ZoRuMKiiXIWZK+l9u2/
 lVxeWt23gtDzGKXjbFl+hEo7uylnvyyhF9yeAUcMjHujwnweeNTV3d+s+iA10Jdme7D7
 YRzg==
X-Gm-Message-State: AOJu0YxVPp7o4FS9QXqB4UEvQwqCUinbd8zh4ZVomCpaJJUXsLi7Rrb9
 oVdtR0/jqmLZTFvteRFGuBnJS/1f3tpvRkia8jCtra8eRo4LkhvLrKl/op9Y+2/XhujXo/mzxfu
 q
X-Google-Smtp-Source: AGHT+IHynhFAHPxeAgNKsXefbsv+FB6t23MZeM+sOi4er18eDQq9d3R9eIgHIKeJadbfb3sFzxMO6Q==
X-Received: by 2002:a05:600c:5123:b0:40e:5933:e2c2 with SMTP id
 o35-20020a05600c512300b0040e5933e2c2mr6696663wms.19.1706535297969; 
 Mon, 29 Jan 2024 05:34:57 -0800 (PST)
Received: from [192.168.69.100] ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 by11-20020a056000098b00b00337d941604bsm4860998wrb.98.2024.01.29.05.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 05:34:57 -0800 (PST)
Message-ID: <4d3bdc00-d622-486d-89be-0e43b32aaddb@linaro.org>
Date: Mon, 29 Jan 2024 14:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isa-superio: validate floppy.count value
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240129133249.1105704-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129133249.1105704-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/1/24 14:32, Paolo Bonzini wrote:
> Ensure that the value is valid; it can only be zero or one.
> And never create a floppy disk controller if it is zero.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/isa/isa-superio.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




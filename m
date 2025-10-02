Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A957CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PW2-00027d-5z; Thu, 02 Oct 2025 16:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PVy-00026z-HD
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:02:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PVn-0000j8-6g
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:02:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27eed7bdfeeso18788595ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435358; x=1760040158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dJck/6Ven9vxRR4sAntiMygi3sYhWLlR2NXYDX7b9T8=;
 b=FEazfJYclJ2emqWF8qyIJGPU2rkG1aeXMu3CbsBTzr78GGZr5T5OS9myWaoIeLCNDi
 +uYExU9Hj4NuKYKAUgwbvry4kLMQQMc7Lirtd9IX23Je7EpMQsQIvEk7BaE9OxVcuGfu
 +YbzD0en90bnhJtl5P9I6Im7R3cM6GrDoPP5qMPOI1inC3mgeRfnjIlLUQOi2xfOKTJy
 Aq/AlUnbSzZWvo7twv4Ycg7NtQ5OwGaV5j1sdtA80OsRt9kR9BA+uHxLXrEqjnveJYDF
 YjpoXNMsHnTewKi/9ABNvd1iBpT0GyChjlCed623ii+MlAiHNDPDxkhK+SZx2EJT/zvi
 YzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435358; x=1760040158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dJck/6Ven9vxRR4sAntiMygi3sYhWLlR2NXYDX7b9T8=;
 b=bzadWXzpo6cQBPybMEWGFurFYmElXAq1oTx9k51enIP4yKTTXMHG9HTG5nPoA+wcvK
 bnYvmadqsSk95yCX8iEqRjwNrPrV0iALkD3PHFHgExiBVsTCE0LXbQkiu9w70a04+810
 z67h9gtqgTSYo4NeoXjiELUVZqsQyX9TYczCkRoFFCfFvLOklu4yi61Y/564Sy3QOvSH
 AXSSPG2zNmCCSCqdaK/b2RU9tx//edG3760v2gekxdk+0bJ1J12asbRYqQSk2/JXu+8s
 i56vDMmsnXUy2ox5vrQ1KsvdjsgS005GshfHv5kSmm5OfwRtObgK2OrQK7mwVbVzYRpk
 k1Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcJcfJVZgyKEhUwGqm2EwKdGC8hxU4ZAnanRM+i06E25DThIh17f13ZiBFmYYRnIg2LQaWFjZyL69r@nongnu.org
X-Gm-Message-State: AOJu0YzH0cq1c560C2fPyc3DaykJNwZ7qJjDtD1Os/O5flmmtrATzCfE
 o/xtWQtQApzmm9AU8dnOJHbrL1T00zpKbkkE4p2tiMMLouC/7t655EJuur0x9Dqpc1w=
X-Gm-Gg: ASbGncuu8mzeYQcP85nmvyzsuaQ0WmB/T817vSt0YK+scvMHJ/d9NOdsZcxPJP1WMiR
 jqOqMqLGulepRrYh8jHZSmkEFKQ21EZK2K+4SdsO/Bowk1WD2EGaqxZdXBEd3fXVCL1UdQqACWN
 QcZjj/ySJeSAWSrTFFITgDa3tEf44qRYiMnfWzFlkl9ZQEoVw5J1amlgn8rcD+2mxR2IouuuZLZ
 NlXCNnqrgbalxGdXGzl3eBsPcMj73tlckC+E1r1qrOAgvSeO6PY4ECFljnrrD7JlUPMsLwedtGd
 wy1eJWoWYE/LE7r3fMEWkAeBDGQiM55I1uUmW6RwUtnl965IYUelcyqUjhXREM+gNShOk2SH2iD
 tXGX71wSSYiTBWHCeVDjdOhF9X+3/C6GsOCKu82z5/3zulDwImdV62iJ9fVv65dk=
X-Google-Smtp-Source: AGHT+IF//dVqXSRPG380YVNcsFOOmHyNWsfy9XN1uShp1P58/bIwpRlQWUr3VY+kd5dEcymlAQA6cA==
X-Received: by 2002:a17:903:2c03:b0:28e:873d:8a with SMTP id
 d9443c01a7336-28e99d87aa4mr6921935ad.15.1759435357688; 
 Thu, 02 Oct 2025 13:02:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d111910sm29032175ad.18.2025.10.02.13.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:02:37 -0700 (PDT)
Message-ID: <3e3151a7-4597-49fe-ad0c-a1087256daa3@linaro.org>
Date: Thu, 2 Oct 2025 13:02:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/33] target/riscv: Fix size of badaddr and bins
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-14-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-14-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> Fix these fields to 64 bits as they cannot be made smaller. Also make
> sure stores to these fields from TCG are 64 bits in size to avoid
> incorrect values on big endian hosts.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h                             | 4 ++--
>   target/riscv/machine.c                         | 2 +-
>   target/riscv/translate.c                       | 6 ++++--
>   target/riscv/insn_trans/trans_privileged.c.inc | 2 +-
>   4 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



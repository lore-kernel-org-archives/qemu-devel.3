Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4F3C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 21:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhxY5-0003eJ-Ls; Fri, 01 Aug 2025 17:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhxY4-0003b2-5U
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:44:20 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhxY2-0002Tb-DD
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 17:44:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2405c0c431cso27202725ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754084657; x=1754689457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=32d3LVf/XJEI8iRAfMmKRceFE502qeK77BOWQPCHFFI=;
 b=UvKovz3vKUYYWjSMXyaC1gBbrWD7Bx3z1c/QU/TIZoAHVlV9MYGpVoyQHU0bM3o7vT
 L/5tsz1gDfTZgJOyWKZ2ffqEIwiM2hW4xu/qoKAsbg18Ab7WLliJbY3EyL5ZIppoLrCk
 F/35SPCCvi3vjn/E7sK2jN7Gol8WKZ6ZFfCrWDFlPD9nGnd9fguVn2JhHEyKaCStbFmU
 QEm7OPpTTr80J1CHm0q0uzrO4aCWuX7QSMmYk+D21kaA527Bq1yL2SEfEMmq1KCqfGy7
 NqvRVwoZaeQNTHVIuF3ZU9UyJOKcoGDDIuB4JttAQLJ4VQGMx/KAGaq0RQLRvFf8nyBz
 jH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754084657; x=1754689457;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=32d3LVf/XJEI8iRAfMmKRceFE502qeK77BOWQPCHFFI=;
 b=OfH/m9L9Sm/PmwjJc5l/368866lUt+Fzw6hWII9nWZ4j369ZcnUB8c2Q3+MDe/SKO8
 z5cj4l38n64i4rqnwxbEl+hPaY3IMkmim5qzQBtEYSWdeFEOYn4x/s2S3FpN699xBWUH
 4mVgCyDqTF5jqN9up1+R+Ketnb2vuYj1tiXptHfukkQk+xKjHYa3wOxLqcsQOrhOV9ER
 2TqKkfqze5/1LBuxvB6rnxEgdwvMaf3IH7Gp4Qrz5hbDdOQOvL8BwNFBcH/KsS0N1TNm
 BEQVB5HzG3aYA+cuvyTAyhZAVH89SXCOYBf7GENyZfQYVsu7ZpMtdO/fNuvDS8+AmEJx
 mROA==
X-Gm-Message-State: AOJu0YwLLjxBBpQrK/5bvfKyrb+xB+1oy6mxs20ArHnOnTuE5SbQKbK6
 0tKb5xHOVOPhZdirjJq06CQVUyIXMvrV3KQoEZ2pc9bsrBvJN/Ka9fGCUoCf2FuVBqE=
X-Gm-Gg: ASbGncvL3xnjuYSvS9MOF2OPbxqNy8eSC7HgGt10JcjL/q2XudLkR9/HJOjsC4RaIjI
 vRtKz0UZ03/u6G63lHNyA7nYQN8pyWZbIFx93FvBXlm7zKsh/vJNHQ0yKez0Ql918GiLu2KZ3JJ
 OmKB/fEQgk/09Wc1o6dKswkmlX76rRHb2pBQqjZJsQgsRdPPG8uyXIELoUCz8CHtIvDZdNPvWxL
 XyPdvpthAGbXZAhH+fLarJhIJnml5GFEh/h6/vukFC3hraT1An/XXcOQsErNNJsoTsqqSZ2D7Yj
 HHbqOdH4zVE7n+SJRBZmNhssyHfQm4RfQsd2oUelwwClSYHA2IAZXV3DdfPfTu4EygNBvkFzxlp
 kXxBmtBSkqMGLR+X5m+UQoo/NtGCISAK8AVJz03gz/18BKjDhxiM=
X-Google-Smtp-Source: AGHT+IGWK52WNEog4Sn4HMkvSamZkCjyjkXeCED1DtjT2nprjX9Kv+5EdC0aT92Xyc7RPAZjpnE5Jw==
X-Received: by 2002:a17:902:dacf:b0:240:49d1:6347 with SMTP id
 d9443c01a7336-24246ffbf2cmr13379645ad.35.1754084656786; 
 Fri, 01 Aug 2025 14:44:16 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aab0ffsm52140785ad.166.2025.08.01.14.44.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 14:44:16 -0700 (PDT)
Message-ID: <7e3616d3-2811-4be6-b4f6-de22840d1cc0@linaro.org>
Date: Sat, 2 Aug 2025 07:44:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/89] linux-user/x86_64: Split out target_coredump.c.inc
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-42-richard.henderson@linaro.org>
 <CAFEAcA_FtS6_vXXWNb2DrwmHuTODMpK_awnYGCaTdn+wbFuoyQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_FtS6_vXXWNb2DrwmHuTODMpK_awnYGCaTdn+wbFuoyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/2/25 03:45, Peter Maydell wrote:
> On Wed, 30 Jul 2025 at 01:24, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c                    | 41 +-----------------------
>>   linux-user/x86_64/target_coredump.c.inc | 42 +++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+), 40 deletions(-)
>>   create mode 100644 linux-user/x86_64/target_coredump.c.inc
>>
> 
> Maybe we can come back to this at some point to convert the
> .c.inc into a proper .c / .h file.

Are you thinking of something like ELF_NREG + target_elf_gregset_t in the header and 
elf_core_copy_regs in the c file?

I suppose there's no reason not to do that now, putting the function in the new 
target/elfload.c, and the one or two declarations in target_elf.h.


r~


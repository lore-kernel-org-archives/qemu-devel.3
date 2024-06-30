Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B194C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 03:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNlCi-00083a-LC; Sat, 29 Jun 2024 23:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNlCg-000835-Ps
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 23:26:14 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNlCf-0005a6-AO
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 23:26:14 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b5052defa6so11536166d6.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 20:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719717972; x=1720322772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vRqlqdcquyBec7W5/3R+DztryFKJiOl6V4z1gWjcIJ0=;
 b=Y9TEqypE4VpS+kOIuvw4lzRgWwOusJxg84sOWvXanqb76E0QP5+jg34owvIg52O0i0
 jlsl/VGpI42YqUGRJV8i+9Uuq6Ez/tsop6fbjBKxg7Di7th9amV/i2gvPMcYXjHk3+cy
 N+w0i/0BF3xPRh0NymK520hy+QYpGjYpv19K0RHKHgJ6okkyCmY7i1YdVjxn8ENwCM6t
 bjGbog0gQcJQeZsuIfa+0Y1j33LSxfh7DpDmssGsnOK8oL/rmmRSfHa6lNyAEecX9gaj
 3ELJJXVdBtgyZRJb+BAyd0GEFJ0t9gLeMJOHGcMqU+c76pjwqKwmDUhwM3ilBBeGSk/E
 iQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719717972; x=1720322772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vRqlqdcquyBec7W5/3R+DztryFKJiOl6V4z1gWjcIJ0=;
 b=D4mBGDbe/jZWFm7XCIQB82zHK8AGVNb8zL8E0+I/TaBUzNUDokA2e6Oh3/2SzMyF85
 5I5RC0OhPPRqgEPZ3I3Z6xbUBI1lAhUqEfvpGBY2AiIyzXosplFWxiFFDGmxTD4E1aSq
 3b3F5UK/ulJsz1r8CvDSKvYKG9HHvQgO1Y8oeOALVQ41z51RUa7UFN4pHpSFpzDWFssH
 2AT7mI0DEZaW2ZIfKCocnS1nUq2Gh68IJPYmrDFaBywplPzYFhnySX9CL1ekqKvyxyog
 fl9xKgZKiKrcbQpBj8gAXqzi+C84r0Jnnjzi580NqVXQiCXTn8tYNiM5ljOvID2RIQdC
 NKuw==
X-Gm-Message-State: AOJu0YwbtQdF7lAfcm4o9WXPo/Hg6W0VRoWhLcAsdWNsenw8kDvEbuVu
 jDsLUDQIaKBA52U/D2OxYr0KpfwTmCvGxLqqFzfKiNQIxBuVnLgACljmrM1y1mc=
X-Google-Smtp-Source: AGHT+IEGE0tuHKNAodHG4wiXzip6HTSaJeAGqLCNif6iGqMDTNY00X+TRxmFiF6xXmAMcsOZhgldCg==
X-Received: by 2002:a05:6214:dc1:b0:6b0:75bd:7fb with SMTP id
 6a1803df08f44-6b5b7177fc8mr30962596d6.40.1719717971863; 
 Sat, 29 Jun 2024 20:26:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10d1f3esm39194765ad.19.2024.06.29.20.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 20:26:11 -0700 (PDT)
Message-ID: <97ebf3b6-a590-477d-8aea-279f83a4f23b@linaro.org>
Date: Sat, 29 Jun 2024 20:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] util/cpuinfo-ppc: Add FreeBSD support
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <Zn9cJ3puWr5lIgsg@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zn9cJ3puWr5lIgsg@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
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

On 6/28/24 17:58, Brad Smith wrote:
> util/cpuinfo-ppc: Add FreeBSD support
> 
> Signed-off-by: Brad Smith<brad@comstyle.com>
> ---
> v2: Use ifndef with PPC_FEATURE2_ARCH_3_1
> 
>   util/cpuinfo-ppc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Thanks, and queued.


r~


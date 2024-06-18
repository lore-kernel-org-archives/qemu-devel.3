Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9575C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWFX-0004xN-LO; Tue, 18 Jun 2024 06:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWFV-0004wt-I6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:39:37 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWFT-0007c5-Pg
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:39:37 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bd48cf36bso6066294e87.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718707173; x=1719311973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNuebGCoFAOOBmAonOwg7nwJacc1d/VxczxIcHaWvdk=;
 b=mAVBMOFDWTiZwfvW+Lwmh5xVfJuu4JlwXiMG+gE6rRreoTDIIVwXHhBk2MQtDNowIy
 uwZJQuMY+oA6MHBl5ZvYOA5pqa16u6OsiHuZYQlPisXI+QtOf/zvIUBn2P3Jl+4oxGEK
 c+Qfq+0b3R3O3fBc1KYWG98hSRNnyhZskAKNS8t37fwUL73ugULK4KSUM/sUCv5ewYzC
 8rqtb2ALeBHZWv4UEdoYykJkcjRDXyUsu6iAfEr6XONgnm3/Ibv7588b30J3J9jD9IZk
 5lZItaSStFT9lu7la0SN1vNkfGYsmiTRjNoxX6pwityfEM75wLg2wIRxGeVNSYUyI8JZ
 K5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718707173; x=1719311973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNuebGCoFAOOBmAonOwg7nwJacc1d/VxczxIcHaWvdk=;
 b=PYq56zn+fMIM676ny0v9inJP0g2jVvJu0zOSvux2GL4sKGH/jcCe3czjCIHCZKJiao
 lDP4CguyQFur8Jczpo7owKaI3/4Gz8wMSDgsmBib4dW8b7GxUF+lLU6rjad01Mm2ANmn
 FZppTriA0JJDp141tMtn0jxAab+JcAi4tzm+6qgRyGt4yJ4I8+9pNQ1ENm9zaHbykGBk
 Drkg6F0l0eJxvlxDGYpryV0USMYEwyuUnCtDUH1Nqz/5z91Mdl6AfjrV0mbxgvbkAKuw
 1kYfJ6X+ZPxFppVLtYvuDHpEEJlvekcsJBkVm95YWElcqNm9yZJXvnv9mVEMKSfciBA7
 4ikg==
X-Gm-Message-State: AOJu0YwYlmlC2BZonQFxp2vs4DL7OoQCW0ScIQIfB7laq0C0yCApT+sN
 Idpef4lzGUvCl8/H5I70G0GmrdUrl4i2MylptkmslOT6jwgJRF9RrQuhq8foPlkTW2zclw3mZ11
 Mk4Q=
X-Google-Smtp-Source: AGHT+IEw1RO3kzbz0PUmnuPqo9JyRwLiDBxpsG1t3IF919TxQ/ny3V5AczDQ5PhimNb+cAMpUWRTjg==
X-Received: by 2002:a05:6512:104c:b0:52c:7f12:61d1 with SMTP id
 2adb3069b0e04-52ca6e56066mr9655540e87.1.1718707172668; 
 Tue, 18 Jun 2024 03:39:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eefa07sm224814625e9.8.2024.06.18.03.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:39:32 -0700 (PDT)
Message-ID: <ae1e7692-943c-40bf-bbbd-85690bbf9ee3@linaro.org>
Date: Tue, 18 Jun 2024 12:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/s390x: Fix tracing header path in TCG
 mem_helper.c
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240613104415.9643-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613104415.9643-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

ping?

On 13/6/24 12:44, Philippe Mathieu-Daudé wrote:
> In order to keep trace event headers local to their
> directory, introduce s390_skeys_get/s390_skeys_set
> helpers, fixing:
> 
>    In file included from ../../target/s390x/tcg/mem_helper.c:33:
>    ../../target/s390x/tcg/trace.h:1:10: fatal error: 'trace/trace-target_s390x_tcg.h' file not found
>    #include "trace/trace-target_s390x_tcg.h"
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.
>    ninja: build stopped: subcommand failed.
> 
> Philippe Mathieu-Daudé (2):
>    hw/s390x: Introduce s390_skeys_get|set() helpers
>    target/s390x: Use s390_skeys_get|set() helper



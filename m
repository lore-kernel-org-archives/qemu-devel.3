Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F5AC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxC1D-0004i3-57; Thu, 20 Aug 2026 19:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxC1B-0004g7-Cd
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:17:53 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxC18-0007cn-IA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:17:53 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so304296a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787267869; x=1787872669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=db0qOKUGNWNq995avKSWbw8QyNBM0x4AgdBmEF3eY9Y=;
 b=LsgnwPJMntpzRT1siGnv6JLQU+UP3vezWgE1R9LRdCK5oKrT/cx2zL6xloq+eFV3n4
 nzDT9W/fyRryU+GUK0kphRX8+XANI461W9+y5Yr6q4Mvzh6xJydPmZnIgdvLpmBKdoSl
 bwdBxsqFotKAoOGRQU6ssHDq7as/48Bdd5euBNY/5EaUjCawpfdfmfrLB5QqXs7Bn4st
 BKL8zqrn7bs61TQbqzTAuxUHOUWTjD2Rgz5PmF8bs24tY7R3Emp9GboIFNpWGpvNWIik
 YREmwvtGiq/8hY+28cDAX44TKs9qL5iBg/hpsykFaQJqv3jNbshn5uDURepj+Ypc31lS
 aGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787267869; x=1787872669;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=db0qOKUGNWNq995avKSWbw8QyNBM0x4AgdBmEF3eY9Y=;
 b=gbX7TdmL5HSMIcnCNHpuiHgFdWvrnVmF7Vln5awfgMX208D27TcoGBLSnvBjGA27Re
 Uad1+Qd8Qy8lctwxe9Szcv11OlMVUSv/hTcmMPkoOjIl2VxpGK/tJMjfqfrvI14ACqnW
 Gj8U6zz/16qUhP9LZjcERm93AImt4Z9AgCFwxsPbUh64UNfJ0xTdUgc1Bk+NhBqN7Tv5
 92sCuxJJBDmBr5tJ5IjKGZtKL5FRKaUYjSyT1xo4AjFmQ8aH7BoqDI/en3nvELPZGyYe
 oaFXTD+chjEwOZYvEkp5jW0pjbJeaR6hUraBeKL9rKqZQqew+bWJctQHHXRe5Bb7P6pe
 YdcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLF3VFtFsBqQVgN7/9tdV5xWUFjjyRWBS+RlrfEkrVVDDM3kmEBUk07+IY4fYe8/nrzbXAyTQT3nQg@nongnu.org
X-Gm-Message-State: AFuF++nPEGxpXE8sQ/zNhFHCHJAIMv+Xn6T7hUVWoJRo6J5IjRn+aE0F
 HSk1+FdMQh2LwEhvWJm/EBJt482+pep5vFz6tRS2rNZ+dlusYcFqFFIMEyI5esGtqtg=
X-Gm-Gg: AR+sD13aexDR5UYVf7OlTypp9WttbRFNTHtcN4nYL7tgXbFbYiwbmDpVMj9H75fIZV2
 aTAFjMaDQ+UiLRPu15ysd8Iv5VADhMWW21/kWNKJJ3QWBoKJgCORffHMz0v3d2uWMzRtSV+HIMf
 bl4Y0NxljOhp6AJANG7+/L27HL+kUgZHOj6hBtk9LRmpX0NHt0iO06Sy4YeCAcpltHE9KZB1boc
 pp8UL8AK8p15KGxu7aNNuKnpTgtS5wCl3V+AP5j5OsUHZU7JWShNn/fyixbf3M+4uQH95j1lkHc
 H1WivytnWgOoRiKlwyy+QHiBxNwOgb5yRdvxD4xmiIBZjT4q7Ivlj7lpp0iIHa00Hg8Nq9OAqpt
 tRCCZ+tFdTqwvBSRsr3iiTTsCySlr9+/KpiuYmm/Qo3aqdL1GGM4DUj3YPsgwyUtHUG9p5Mtwkl
 DRHMP0krXxHk9lNq4t28B2Z8zoj8IcsJngbJ99CiEGGGmOICY4ac5M/d8iiaq1bl6VUHZUB355A
 5gG
X-Received: by 2002:a17:90a:d60d:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-395c3a49e08mr3542251a91.13.1787267869037; 
 Thu, 20 Aug 2026 16:17:49 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4b47b02sm636326a91.14.2026.08.20.16.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:17:48 -0700 (PDT)
Message-ID: <f9661bd5-b39b-4fd9-9a2c-8b6e7347f9d7@linaro.org>
Date: Thu, 20 Aug 2026 16:17:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] linux-user: Replace env_cpu_const() by generic
 env_cpu() equivalent
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
 <20260820201356.29775-15-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820201356.29775-15-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/20/26 13:13, Philippe Mathieu-Daudé wrote:
> Use the generic env_cpu() macro introduced in the previous
> commit and remove the few env_cpu_const() uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h   | 1 -
>   linux-user/elfload.c        | 2 +-
>   linux-user/i386/elfload.c   | 2 +-
>   linux-user/x86_64/elfload.c | 2 +-
>   4 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


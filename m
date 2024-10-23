Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89511CFA45E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3gdX-0007Ji-Hp; Wed, 23 Oct 2024 15:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3gdU-0007JY-HA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:03:13 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3gdT-0004af-44
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:03:12 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e59746062fso145221a91.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729710188; x=1730314988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kEpN/4zfdTQwHoXRqldW+t4Oh438O829Ujo2/9g336w=;
 b=Pv83ghsxifBRXueFvi+hqxAwy7DWgieXTOEbWDLxhwsWbkIXqVrDFSTIMAem5sNQnl
 U1opJsqyg5kD6aR7pUzQiNNATFPYBOSQ8S6nVPoNVoaVGQCJOeKy8Uz4DKGdXyWXwl5n
 8aq9/Ry/irkmTIeI4tFC5sZlGaZNU4ODe02yjznPxy5o2sR/2sH5/scmQeb4i8sy+p5+
 8HmPGzTRqt+zcnxG8ZcrNc4Pfvmlhpj+MtEsc7KQy2bmqTLJRcFKe3QG5VgFOg1IHPfC
 5gQG9CPZUD/69S4K+NeoQ5/0jM2ZBwKlWg7/NA69Zg522JwChPxiKf0yOrXpoYE+5uzO
 JM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729710188; x=1730314988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEpN/4zfdTQwHoXRqldW+t4Oh438O829Ujo2/9g336w=;
 b=RzSs5Jyp/LF31gsnx0xYVnY9ZZ5Al7FTHksD/2smjjI6FwyhESpLa4MDkSaugwX0KM
 HmuqcVJDFnV3M/fU+hh92S9Jao7n1LP2mL4N2zf0G7soFgUjtea9b7rWE2LaPqK6QWbd
 YvaiMGCd4lUd5zXfoW/233Y6ej/OrRfYkL4qbytRdPqHTo4ZdM4IHJd7TZMbp6xNSqul
 2XRPbtO4HeUmauyFongk7eNNMdo/ke775ieT2ek5Xosz2xf1IJANJZhE3wNxdJoMKkFm
 uXAFQMWueylSaNlTaBpBDqP6qCeg56v2SICpaVPtB7LtUgZE3lMaC5B5eT5r0G6yBjrG
 U4HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrehMkeDL8njsHecpdtIXshqb5LkjDdxIYTRDXBj+IXj7KveHErcCZaXP7xWRFzEHrQOWw9vay5tdz@nongnu.org
X-Gm-Message-State: AOJu0YyZBu6pnK4liXax/Hj80PVh8e6CDCEeAe2IbodJrn8xKoq7AE8N
 R0SgUE5VFkrzMarD1vZDay9cw/QRd23uHGlWXZjrMdxo04xiQtFLdf/LbIKk0wo=
X-Google-Smtp-Source: AGHT+IElSaKHt1UnaaUf8Jrk0gRP9i9km+Bq6lVL7JYk/yzdvW0IDKeWCRkIPtK57rUS4o3PeCWetA==
X-Received: by 2002:a17:90a:1bc6:b0:2e2:bb02:4668 with SMTP id
 98e67ed59e1d1-2e76b722988mr2985951a91.40.1729710188258; 
 Wed, 23 Oct 2024 12:03:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e76dfbc842sm1809030a91.31.2024.10.23.12.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 12:03:07 -0700 (PDT)
Message-ID: <d847f246-1772-4c9a-97f7-05118a311286@linaro.org>
Date: Wed, 23 Oct 2024 12:03:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix GDB complaining about system-supplied DSO
 string table index
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241023144744.50440-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023144744.50440-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 10/23/24 07:46, Ilya Leoshkevich wrote:
> When debugging qemu-user processes using gdbstub, the following warning
> appears every time:
> 
>      warning: BFD: warning: system-supplied DSO at 0x7f8253cc3000 has a corrupt string table index
> 
> The reason is that QEMU does not map the VDSO's section headers. The
> VDSO's ELF header's e_shoff points to zeros, which GDB fails to parse.

Interesting.  I had wondered where this came from, but never looked.


> - Fix up VDSO's PHDR size in gen-vdso. This is the simplest solution,
>    so do it. The only tricky part is byte-swaps: they need to be either
>    done on local copies or in-place, and then reverted in the end. To
>    preserve the existing code structure, do the former for Sym and Dyn,
>    and the latter for Ehdr, Phdr, and Shdr.

Or adjust the linker script, to mark those sections loaded.
This may or may not be easier, considering the rest of the changes.


> @@ -154,6 +161,16 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
>               fprintf(stderr, "LOAD segment not loaded at address 0\n");
>               errors++;
>           }
> +        /*
> +         * Extend the program header to cover the entire VDSO, so that
> +         * load_elf_vdso() loads everything, including section headers.
> +         */
> +        if (len > phdr[i].p_filesz) {
> +            phdr[i].p_filesz = len;
> +        }
> +        if (len > phdr[i].p_memsz) {
> +            phdr[i].p_memsz = len;
> +        }

There should be no .bss, so these two numbers had better be identical.  Certainly this 
adjustment *requires* that there be no .bss.  I think we should error out if the two 
numbers differ.


r~


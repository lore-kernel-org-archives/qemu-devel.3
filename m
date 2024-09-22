Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA47CF9C69
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 07:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssGyf-0003rZ-2A; Sun, 22 Sep 2024 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssGyd-0003qN-Kf
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 03:25:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssGyb-0007Kj-Rg
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 03:25:51 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso500233666b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726989948; x=1727594748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DpLGzJQHei6frqI6iPVCYXklQeyawOObuAZvyEzurHM=;
 b=ZMw5puWYB5l9KspI2VYFaCgi7VZow/L6Ktv1BouQv9aUdqMt1ksaJr5Y8vFnWmFjj1
 u5zZJJZHvQuWi4FErJcRka2WZc2m1pWMRZhqBmFRfdUbNgEBpXe/PkTuOVXBamL8qZdP
 mMas9XnngbYE8XQ84T54Er/j8F47fl9GhB/jLxrbqbmNdjN9Wag2FZfoaS+IHDWCy9tm
 BMnGlpEC5zN7dDSFsNeSCvaO+4J2YIbb/XnrX/I5QupFTL1I21WI4Xw3W6TDRBIiuDkZ
 pj/hN7xeDMM6heIRQMyz/LZ1UP3+xvkP89tPyMduRhtfe1yiCqxsZybcqvPxMsK/3v/U
 j/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726989948; x=1727594748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DpLGzJQHei6frqI6iPVCYXklQeyawOObuAZvyEzurHM=;
 b=xJusAsEU7NAysoOSQgJLnScYxYHR6YrNuWOSEWvzlEsvhHRXa303NdjWrZEUXmKPZb
 XrqutNcyC4AgCaO4o9j90+KxV1AJjW5Zv5PI22YWexvpDAL9taIiPdCFg6cvZ18MZiCx
 wieH1pJqGjOHpl7LLH7g3JfO91kgH2hRgHGl5gMgSVJU+i59/ypZNaAG7KrxODl0603v
 uf57orIVv4Kf4BsA8r6PoRWIYoKlB9hXdepROJPQhb0j1dDyD2cJTPk12XZe3PpTvz1n
 feCHEsYPnHqmNKteQRxMwdl5pgNM8naNlrQ+9aveAztP1fszi1BTUlU88YqRqbw3dZZo
 x6TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpsEM3EDiyhsZ0wC6WHVMH6zeNFzi6k2e8gM3nWnxNlyDs8K4vmMKm8GZMXAvyYY6M0wGqhUXB/ARz@nongnu.org
X-Gm-Message-State: AOJu0Yx4N5FZqabvCKsw2un+cGibRRNEoQXdRshwdf3NY3N4HnjU7Qxr
 uBbNMNyP4TkOVFrC/4bow6T5h/G4pUs/0/ndj1/YJRqYVl9Sq0oYFMCpRwP6P+s=
X-Google-Smtp-Source: AGHT+IFZqCWFDGBHZXL/lh+TJdhfcCuqC6XCDlgs6pRtUMc8clKvrFEwNAbFMPcnTpJu9qnFSi4NpA==
X-Received: by 2002:a17:907:e2c9:b0:a8a:906d:b485 with SMTP id
 a640c23a62f3a-a90d4ffaf55mr717383666b.26.1726989948249; 
 Sun, 22 Sep 2024 00:25:48 -0700 (PDT)
Received: from [10.5.50.249] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb949bdsm8933384a12.84.2024.09.22.00.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Sep 2024 00:25:47 -0700 (PDT)
Message-ID: <4c10bbdd-41fc-4d7a-98d3-9ba1556519a1@linaro.org>
Date: Sun, 22 Sep 2024 09:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] linux-user: add openat2 support in linux-user
To: Michael Vogt <mvogt@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>, Laurent Vivier <laurent@vivier.eu>
References: <cover.1726817664.git.mvogt@redhat.com>
 <65bb234d769980a3b10a655ed19f87966c714e06.1726817664.git.mvogt@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <65bb234d769980a3b10a655ed19f87966c714e06.1726817664.git.mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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

On 9/20/24 11:22, Michael Vogt wrote:
> +static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
> +                      abi_ptr guest_pathname, abi_ptr guest_open_how,
> +                      abi_long guest_size)

abi_ulong guest_size, as the "real" type is the unsigned size_t.

> +            qemu_log_mask(LOG_UNIMP,
> +                          "Unimplemented openat2 open_how size: %lu\n",
> +                          guest_size);

Use of %lu, and host "long" in general, is always wrong in qemu.

You did not build test everything: this errors out for 32-bit guests.
We must use TARGET_ABI_LONG_lu here.

> @@ -9197,6 +9296,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           fd_trans_unregister(ret);
>           unlock_user(p, arg2, 0);
>           return ret;
> +#if defined(TARGET_NR_openat2)
> +    case TARGET_NR_openat2:
> +        ret = do_openat2(cpu_env, arg1, arg2, arg3, arg4);
> +        return ret;
> +#endif

TARGET_NR_openat2 is universally defined.
This ifdef is not required.

An update to strace.list is missing.

Finally, this does not pass LTP.  In particular,

src/testcases/kernel/syscalls/openat2/openat202.c:62: TFAIL: resolve-no-magiclinks: 
openat2() passed unexpectedly

With RESOLVE_NO_MAGICLINKS, the open of /proc/self/exe handled by maybe_do_fake_open 
should fail with ELOOP.  I *think* that's the only magic link that we handle there, but 
please double check.


r~


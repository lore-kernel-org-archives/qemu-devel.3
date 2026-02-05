Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAC8ECD985
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2M4-0008EU-0Q; Thu, 05 Feb 2026 11:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vo2M1-0008DQ-CA
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:37:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vo2Lz-0007ZB-Os
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:37:17 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a09d981507so9616615ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770309434; x=1770914234; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KjNwT57kU5+q9EzzZq7vmMbpBhjz7AJnyXl00HFqF2w=;
 b=NKUFMvaKrNrv2RYlPTjsPD5aZKhtmJuKlsCCkICeF3u4bwbTPzWgTHJAdYIrZ2FDYX
 DZdndFTrrY+WCqCzC6lhcEGN1lLm8dPOn6b71WYFaY4DKP373Nc6+R8ivPJ8AyLWwWjQ
 f2SYZ4jx5Z0ExcBQP4iR0JVxgygSw0Ut8Gny7t/3orSHiYGW4qBraRSx7MLjW8x95kXc
 MiHGQHC7c3xPbRqbBdX89ygUdM+RFLPfJTGSTzfchRzL1EJ12SnmZWT612l9Jdll76P+
 ta4uKYHPunurXcw9zqyIJ+KVhvuV4q41YomeG3FHzl+PpmrUoBd+90qiiyxYHmSXW76W
 x38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770309434; x=1770914234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KjNwT57kU5+q9EzzZq7vmMbpBhjz7AJnyXl00HFqF2w=;
 b=kqccpsyMPG/ftRw2zacHFjm0fcRbox1ZTrBO9rTm4jpKtRpwEYb7h0LULVPctA8gF8
 XBE/A3yWq1nkadCNh866OWFd2WGCbXX4S0rfKV8dKSMpb1U0O6mdRPToV1hwExLJ28JX
 9Y5wliO+ZgvSP6LkfnjpZNN1JnGSWQPxX4d9pNmvK9qlBZ8muiiN2KNfL856xw3mX9Po
 ZRVx+etxjms739ojRRVnorvUADqmIWrX4yuBmh5PryWl8j2Gxk9F6s0IfMWJWRkzCGEU
 WpNbzE0CLgKHa8temU0bRymhi5lcFEg6Fz6BPYjLu49sMs025ho8ujhIJZatzkFM6Uok
 4YVQ==
X-Gm-Message-State: AOJu0YxX8QRwCH5a372HXnBuzadFmXAhsi4L7RvaTCKtC9x3x9tIoKdf
 vo4aYjNwrwwYXe/D8jt5U9c8E8ksppg55L+4wfP7457EF4lNnm2CEp/n403835rfQIc=
X-Gm-Gg: AZuq6aLXxHD3lAqmYgSPfJKdttPah2IrbMUG3sMwBBgWv1i7AVmQrinqv8RLZGP4BVC
 YMxXQQXBZHCkMQF1IM9Cm5XRg0W2ZaJiarlg0qjP61p+LNTApB36u24iXlDhHom6tKAqs2ptlHf
 IjeLMEDxFf1Ko0RFZEDKsjlwK9LVTcvo9e/FY5/xqAadrv5OKyIcJreFSfK8K8E/9zUPxtJDzcf
 XCew51LPU85liqyix8oazgSa/tfoZPTIdGnApLNp4Xbc4YwkUPVn22vyTBdZIYk61NaMkb1HsGE
 Jiu062DMCzhGXzDUhjihmCdvdmtQFOjwBoRCIJ4i4wMV+HJMPqy587DoasNATgrcEkToDxszcnl
 agOGaAghAAhF4maz1Hwes7Bl9rtXqQ4M55mjvvpbdslLrth7VFSvGzxVoGzuAeJd9VC/5AhEc1t
 XQKRHl+SUEEJEn7k/ehW2WUh2m4SSPWK/GOt811nVT2DU/tVLFnpdE
X-Received: by 2002:a17:903:1a4e:b0:2a7:5e7a:5e80 with SMTP id
 d9443c01a7336-2a9411e087bmr34381325ad.26.1770309434064; 
 Thu, 05 Feb 2026 08:37:14 -0800 (PST)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93389f209sm62238795ad.36.2026.02.05.08.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 08:37:13 -0800 (PST)
Date: Fri, 6 Feb 2026 00:37:09 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 05/19] fpu/softfloat: Support OCP(Open Compute
 Project) OFP8 data type
Message-ID: <aYTFLP1udcwS3F0H@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-6-max.chou@sifive.com>
 <797df006-5270-462d-a0a4-4e5951cbdb1d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <797df006-5270-462d-a0a4-4e5951cbdb1d@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
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

On 2026-02-05 14:36, Richard Henderson wrote:
> In particular, I think separating "no_infinity" and "limited_nan" leads to
> confusing checks, such as the one in parts_canonicalize where you test
> "limited_nan" in a context that is really testing for overflow to infinity.
> 
> Further, normal_frac_max is defined oddly, such that you have to test it
> twice, once vs frac_hi and once vs NORMAL_FRAC_MAX_ALL.  Since this is used
> for exactly one format, this is perhaps trying to be overly general.
> 
> I think better might be:
> 
>     typedef enum {
>         /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
>         float_maxexp_ieee,
>         /* exp==max is a normal number; no infinity or nan representation. */
>         float_maxexp_normal,
>         /* exp==max, frac==max ? nan : normal; no infinity. */
>         float_maxexp_e4m3,
>     } FloatFmtMaxExp;
> 
> We can stage in this behaviour without also including either FP8 format.
> Just changing Arm althp in a separate patch is large enough.
> 
> 
> r~

Hi Richard,

Thank you for the suggestions and v4 for softfloat part.
I agree that the original patch should be separated and the solution you
suggested is better.
I'll seperate the riscv isa part to another v4 patch based on the
softfloat v4.
And will also testing the softfloat v4 you provided and fix some
saturate issues on that.

Thanks a lot,
rnax


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA6ED3C92C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 19:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2FEO-0002zU-Po; Sat, 19 Oct 2024 15:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2FEL-0002yr-0F
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 15:35:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2FEI-00085n-Ah
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 15:35:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e5ae69880so2561962b3a.2
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729366512; x=1729971312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jMYMUPPeR8e7kVcIuMTmEWr4UdhcI/rIQip2UFKGRxE=;
 b=SLO8crD/MEoblw5ik8EgyV0PKdhH+9j3aUykSFV6S0Qs4v1/YuR9TofPQzJUbMlQWu
 J2r9qSfER8KNpWIShv/2bZdPc++SOZnvxU7TFY3Mn/diVFEY42nZNrBE0tD+/lsQbU+B
 btND7xb4BaKNmr2B+KLFufhs73QNtMZKNwn1GP+zKp+0bSBomaqGpb0/ayIR2jjS3zUm
 CGDHT3Sgh4GK7p97sCrQVyQQ8MkOqrdWUA6DMPlgPTEl1AyFaKjyvyi6C3uhz7REPMOh
 E1MFvFFWJ/CJiFBIfegq5ejNeljmRbZpoPAEcDmNdXJ9BjzHEtItum4hZgxC4R5pTjaQ
 XS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729366512; x=1729971312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMYMUPPeR8e7kVcIuMTmEWr4UdhcI/rIQip2UFKGRxE=;
 b=E2m0ho5pU3XoMjsSBIcwBZzTtFQNnuurrXgUohz0a1LdkiT6UyBwvY9pPDeDHIN0rp
 p2Fs+ONROXJjH587TPvN9fCjJmfytN2uRaYj9BOh7daxjXqHRBOXrY3CJW47ShGt9rGW
 3gB7IJgfO2pC8g17ZsfHTg6n8UpsPw9zTDQDpZWMi7G+FbO6PJAsTVIyBVEmjWY3pl8W
 nwAGxxtx72qR8ehbIJQfMFZdZSewnunGgvGPp40XbBHDTiknLIIQ6jvMUjFY9XJIhgpy
 fF/QHBb4ClEcqUfYwaQCP11T442Qd21Xuw6ViS2Xu2t82SjUR0xpnHOFAVzen25D4uvG
 sZLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgSOUN0jdtV2qYfEms6rCOWOwGhUNl4Ukx0qV8r1ef5Ky1nDv7/fZHad7bwBoejlD4HATi0PbjASjF@nongnu.org
X-Gm-Message-State: AOJu0Yyv4xiSFkz+VrBLBGZNyBWLY9AEApiZi0yCiCeHKZ/C+MdQ2rmj
 HylgF0k9do+IHA7lIO3g7a2xqwu1aWI51w4B/ZR1iaZvZANj9WJA0xzlsLy+TOo=
X-Google-Smtp-Source: AGHT+IFhc2BzJoHRB4t+Vt+Hc/frpGtJHVTItTmwuFZSAbDOOKtLux/D6vBO5DplX6x9arKeN0uHwQ==
X-Received: by 2002:a05:6a00:2353:b0:71e:744a:3fbc with SMTP id
 d2e1a72fcca58-71ea32cff62mr9593195b3a.21.1729366512581; 
 Sat, 19 Oct 2024 12:35:12 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13ea0ddsm95964b3a.143.2024.10.19.12.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Oct 2024 12:35:12 -0700 (PDT)
Message-ID: <5ae0d26e-d969-48e3-9bfd-8a07db727620@linaro.org>
Date: Sat, 19 Oct 2024 16:35:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] Revert use of clock_gettime for benchmarking
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <AM9PR09MB485113D76C5AE02516C08E8E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM9PR09MB485113D76C5AE02516C08E8E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42e.google.com
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

Hi,

On 18/10/24 10:20, Aleksandar Rakic wrote:
> This patch reverts the commit (with SHA
> 50290c002c045280f8defad911901e16bfb52884 from
> https://github.com/MIPS/gnutools-qemu) that breaks for mingw builds,
> where clock_gettime and CLOCK_MONOTONIC are not available.

Isn't get_clock() what we want here?

> Cherry-picked d57c735e1af1ca719dbd0c3a904ad70c9c31cbb7
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>   qemu-io-cmds.c | 77 +++++++++++++++++++++++++-------------------------
>   1 file changed, 39 insertions(+), 38 deletions(-)

Please Cc maintainers (done now):

$ ./scripts/get_maintainer.pl -f qemu-io-cmds.c
Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
Hanna Reitz <hreitz@redhat.com> (supporter:Block layer core)

> @@ -904,7 +905,7 @@ static const cmdinfo_t readv_cmd = {
>   
>   static int readv_f(BlockBackend *blk, int argc, char **argv)
>   {
> -    struct timespec t1, t2;
> +    struct timeval t1, t2;
>       bool Cflag = false, qflag = false, vflag = false;
>       int c, cnt, ret;
>       char *buf;
> @@ -964,9 +965,9 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
>           return -EINVAL;
>       }
>   
> -    clock_gettime(CLOCK_MONOTONIC, &t1);
> +    gettimeofday(&t1, NULL);
>       ret = do_aio_readv(blk, &qiov, offset, flags, &total);
> -    clock_gettime(CLOCK_MONOTONIC, &t2);
> +    gettimeofday(&t2, NULL);
>   
>       if (ret < 0) {
>           printf("readv failed: %s\n", strerror(-ret));



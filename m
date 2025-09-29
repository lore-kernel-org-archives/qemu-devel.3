Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D257ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F2e-0002ax-MJ; Mon, 29 Sep 2025 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3F2a-0002Z2-TK
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:39:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3F2R-0000gj-BJ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:39:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so2871602f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759156773; x=1759761573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ojY3RPIpKc+brp1NfCJujNzb4NUxsEjheEtU1uTV/c=;
 b=t0akCGmRQ65j0hMtiQT1yc2nvTxve5Bx6i3PWTwtiVnxhJZx7pZgkK6i73S4/io1SS
 B8pyCGOYYdKd3EMfANX/dQmC536C84SpAWH28qxTgTO59/eb6T1KMDG4XXWiiuQOgk1P
 bUTcGxWbLwUgfi3kgkUnqaeOdnESTs1BIUZsRVQRu9EVPwf/SvXdxfHHgo+zNWQt3jfS
 LeBd6XcS2CiO+j9ee6eo9EtVaDK/WOLiUGKn1/fVLKlyk7CqcqMmAJKCoc3G46vu6fGk
 SCiBMR6URQtvTQWMP8wDjt9C8kM12DMgVuQIyFv7/v7Z0CZKV0FkpnsGtXS9MBE8LjrJ
 PNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156773; x=1759761573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ojY3RPIpKc+brp1NfCJujNzb4NUxsEjheEtU1uTV/c=;
 b=qG3uUlPHKqUZKnlQ9zaEQWwOvaDcfbyVygsppb0hlFJ1pXyAwqpMj2+vGP46UgIORE
 n//KYOGuBBzmjTqg4MyjQochEbGeXIOl3/IW5LwiADhuJ38vL07eyKBWXV1spGttJGT0
 WrPITM2IvqUIfRqEy9y1QWgX3pbGxdeUcDGTtoBb+bY7IqQwIqRmzA3WRLSPUuz31oUh
 /M9BHX4V8VAhFgVbACrW2mRJMoR31TZAyEe37B4iHDfjOr8VLlnSNnswsY2r7uiiuePW
 ok4Eqx6/6RK51yYLB2yd8p4uLt76NLWdWCqs8XsB+WL4B9l665o/J+GzOcHzRDyvmkHq
 RsVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi6oxEm8FwgRukkAu1pzA1KqDD1KzLHfrBqvb25qEGMnmjl/FPBxSUKddcb1XFoVM9f9bJv56ExBrP@nongnu.org
X-Gm-Message-State: AOJu0YwiDQ8LlLqrdmvyEf6jDENZr4Fd5dT7mfpqz4ERCqcjOc12yryC
 BD1sdnp5K3k4vzl++QQ1uNZq8su56ok2E/yz+xdy6KV4YA0HoEsBt1t+KeevNsN/fSM=
X-Gm-Gg: ASbGncufHVtcIomtG7DjX+ZexbFKBEonG75Oi2OnO/cZ9f8dGOlZzWnJV7p9m/6Y4nD
 dr//gZt0newke78IyojczRxtcyuVfXF3tACmvXHyMU5qf5thtmOfrVRf939B0fYwevWEUPAxCDu
 6kLj/KhAtB3M4AW2zFGaqNkNm/+BA2eQGJEKreZyfQVg4SFnL1MKUaulJ8fxbca23Tx/WGzP2sx
 V7X2JjW3chDb3vdIysoBWTCzATd2UimLopbbRgp/G4PiKLLR2NsUqSgBSjqLQFfu6C/Ksroawe9
 d25Mb0ant04c0/tPpXTGTVBVRUwu+eyHOTIqFtyfPQbdv9CwE+8r93BnHbuDoK8Xo4FDJt9Dfe9
 lNGfvAq0AgS5+IpCJzzLZESP9fC3N4z3B92biTna9pS1QB/CNaSQbBlabB2M2MhN6sQ==
X-Google-Smtp-Source: AGHT+IGNFdnVUYfXaFSOqjAFP/McPaBQd/VqKvXhICaPTi1MQzoONPVWCs3hrqv2+xLXKabYKTmo1w==
X-Received: by 2002:a05:6000:1ac7:b0:3ec:dd2f:eeb8 with SMTP id
 ffacd0b85a97d-40e4c2d2da2mr14783878f8f.62.1759156773235; 
 Mon, 29 Sep 2025 07:39:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6cf3835sm18721492f8f.46.2025.09.29.07.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 07:39:32 -0700 (PDT)
Message-ID: <b726ecb9-b93c-43ce-9bef-7e18451885a4@linaro.org>
Date: Mon, 29 Sep 2025 16:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] .gitpublish: use origin/master as default base
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com
References: <20250929134348.1589790-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250929134348.1589790-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 29/9/25 15:43, Alex Bennée wrote:
> This is very much the result of my recent fat finger but I think it's
> safer to assume that origin/master points to a recent commit (or at
> least a commit a given branch is based on) than master.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitpublish | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/.gitpublish b/.gitpublish
> index a13f8c7c0ec..a3adb21ffa1 100644
> --- a/.gitpublish
> +++ b/.gitpublish
> @@ -4,48 +4,48 @@
>   # See https://github.com/stefanha/git-publish for more information
>   #
>   [gitpublishprofile "default"]
> -base = master
> +base = origin/master

Any key to specify the remote? (not everybody have mainstream tracked
as origin).

>   to = qemu-devel@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
>   
>   [gitpublishprofile "rfc"]
> -base = master
> +base = origin/master
>   prefix = RFC PATCH
>   to = qemu-devel@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
>   
>   [gitpublishprofile "stable"]
> -base = master
> +base = origin/master
>   to = qemu-devel@nongnu.org
>   cc = qemu-stable@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
>   
>   [gitpublishprofile "trivial"]
> -base = master
> +base = origin/master
>   to = qemu-devel@nongnu.org
>   cc = qemu-trivial@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
>   
>   [gitpublishprofile "block"]
> -base = master
> +base = origin/master
>   to = qemu-devel@nongnu.org
>   cc = qemu-block@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
>   
>   [gitpublishprofile "arm"]
> -base = master
> +base = origin/master
>   to = qemu-devel@nongnu.org
>   cc = qemu-arm@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
>   
>   [gitpublishprofile "s390"]
> -base = master
> +base = origin/master
>   to = qemu-devel@nongnu.org
>   cc = qemu-s390@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
>   
>   [gitpublishprofile "ppc"]
> -base = master
> +base = origin/master
>   to = qemu-devel@nongnu.org
>   cc = qemu-ppc@nongnu.org
>   cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null



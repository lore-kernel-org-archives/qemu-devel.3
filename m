Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE89D3E2BA
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 19:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5VeZ-0001Fb-Jq; Mon, 28 Oct 2024 15:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5VeW-0001FG-GU
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 15:43:49 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t5VeU-0003nw-Gd
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 15:43:48 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7db54269325so3515866a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730144624; x=1730749424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/QtThXhDvyeuynjwSwAMhTN9wIDH8ky5ZqxWdCED/Jw=;
 b=ZDW2zB3WkyHMvpUCRIHd1MqYc+/BS5QnaJdBtak46tPY7jPNJklnL2Vam2/PMheAHD
 ECXXHL2yHv85Dvzgv6TyZNYHLdIHnQBCiFMouZE2db55gVYtqE+8sNJ14xik0esz5S/m
 Mdgl66/+vuVI3AkpPHEuUxkG+FcPXwNFHtyRnFV4Zkm/V8v+4+fYKeyNEwp8rB4dvJCz
 TDqJAbyhhjvEdwypRIpuKilT97fvlarWk6UoiVpTHgAb2jo5Bq8HsMWTNx1KeLjmTdUZ
 jfNpyVmycWVS46pgjhnLh9dpLGGPZ0d9DkFna+3O/YFSWq6MUiU3KrS8xd93/RMmWZWi
 UdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144624; x=1730749424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/QtThXhDvyeuynjwSwAMhTN9wIDH8ky5ZqxWdCED/Jw=;
 b=LITkcEXzza8NrzGbc1chJufWj0ImUxiD2KYZxr0KYcrpXab66rWydKa0lJ4Yk1DMAM
 Bds+6+dp9+yQV1pHrnajq9nsBeRugsXqCIugUkdqMs22ZRTGbttpIr27JrTgcP7NL6fO
 GkPnYiGf+s7WoqzwS2f92gMuhsCRLGOn4hJIfHTsaigD0i4YDdxQYhugpvCwH6DssP2z
 7PESBZ1bjNgBu50NS2syTmCPrr2877CFqon2YUOIYjbwLSnzeU8KjhRzLi8CbRj3cp4y
 6UEK99VVCZrBc+wRhFdtohu5nM9rJcdRUTUWgWyNb7pQTo8JOUpokHP/KDL7ifsaOyyU
 iB9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUMHkGKKIyCTK5MKiA1XTJ0pidLt5yKNot9BqyDiRpfPjvma6XLSHIdvMnbVI0JigoHgDwPUwhBQVT@nongnu.org
X-Gm-Message-State: AOJu0Ywy0ZK7uixQUsT5q5FaMg+8XQE+41yQoSl30dTHjtMoAE9crQ7s
 57lAQose1LRcQGdaYeW4vxyWoQ8z0cp98LAAeb8YbNmjQco3qsCNyGwyHrvdJvU=
X-Google-Smtp-Source: AGHT+IH0rOeQDhBtFkjF9sduUdaSadKt5TGEYSu5IUke+0ELt6J0YAEfb8AFH++JeGoVHmzsJL54lQ==
X-Received: by 2002:a05:6a21:3a41:b0:1d9:237a:2d56 with SMTP id
 adf61e73a8af0-1d9a8512cedmr10965709637.48.1730144623950; 
 Mon, 28 Oct 2024 12:43:43 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8660d80sm6038700a12.13.2024.10.28.12.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 12:43:43 -0700 (PDT)
Message-ID: <153648b2-1978-45ca-9731-b922da98d81d@linaro.org>
Date: Mon, 28 Oct 2024 12:43:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scripts/symlink-install-tree.py: Fix MESONINTROSPECT
 parsing
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Christophe Lyon <christophe.lyon@linaro.org>
References: <20241018130852.931509-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241018130852.931509-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 10/18/24 06:08, Peter Maydell wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> must be parsed with shlex.split().  Otherwise the script will fail if
> the build directory has a character like "~" in it.
> 
> Note: this fix cannot be backported directly to any stable branch
> that doesn't require Meson version 1.4.0 or better; otherwise it will
> work OK on Linux but will break on Windows hosts.
> 
> (Unfortunately, Meson prior to version 1.4.0 was inconsistent between
> host OSes about how it quoted arguments, and used a different quoting
> process on Windows hosts.  Our current git trunk already requires
> 1.5.0 as of commit 07f0d32641e ("Require meson version 1.5.0"), but
> the stable branches are still on older Meson.)
> 
> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> [PMM: Updated commit message to give all the detail about the
> Meson version compability requirements.]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is essentially back to version 1 of Akihiko's patch, now we
> have a new enough Meson; I just updated the commit message.
>   https://patchew.org/QEMU/20230812061540.5398-1-akihiko.odaki@daynix.com/
> (I have dropped the various reviewed-by and tested-by headers because
> I figured the passage of time was enough to make them moot.)
> 
>   scripts/symlink-install-tree.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
> index 8ed97e3c943..b72563895c5 100644
> --- a/scripts/symlink-install-tree.py
> +++ b/scripts/symlink-install-tree.py
> @@ -4,6 +4,7 @@
>   import errno
>   import json
>   import os
> +import shlex
>   import subprocess
>   import sys
>   
> @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
>       return str(PurePath(d1, *PurePath(d2).parts[1:]))
>   
>   introspect = os.environ.get('MESONINTROSPECT')
> -out = subprocess.run([*introspect.split(' '), '--installed'],
> +out = subprocess.run([*shlex.split(introspect), '--installed'],
>                        stdout=subprocess.PIPE, check=True).stdout
>   for source, dest in json.loads(out).items():
>       bundle_dest = destdir_join('qemu-bundle', dest)

Hi,

would that be possible to pull this patch please?
It's currently blocking the devs who reported it initially.

Thanks,
Pierrick


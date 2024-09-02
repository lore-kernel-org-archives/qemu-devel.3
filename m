Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DFFCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 16:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl9bs-0007F4-Jq; Mon, 02 Sep 2024 12:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sl9bq-0007EZ-Nm
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 12:08:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sl9bo-0007OC-In
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 12:08:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7140ff4b1e9so3370951b3a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725293329; x=1725898129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XqfkndDPJFNXGMAYZZP0Rwz1SLwt/rvcz7+0iPCqGkU=;
 b=Ej2zB5A3P39T7LLR8ltJFJJYe3ahtz9D25tZeO2qS/sChy8EgrhKUfknrkz0Mkfd6i
 oxIv3wyHOcO2I4PIWJGcuLEKGm5hN2PGNA1NBx5nJflU7Xyparu5VYzi7mzLt33xg/Se
 FiiXpsuDuWf4BIlU0q31c/xEC62lwsYXvhRU+lbCKcUsWdHRF6M5QC9fH2yDntdbLxjz
 lNtKBfBxTkeGnsuAjZ4bR2pVL18ehuvIwRQsmjY0K7tmlyAvyttP763gLfg9mpVBwxSa
 Wy4kyM+Q90QoE30Oxb5kSX7gC9mEGLAgtDWuAADbVDDxg/15hfgnpXqrd0JXorD21QF4
 ZcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725293329; x=1725898129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XqfkndDPJFNXGMAYZZP0Rwz1SLwt/rvcz7+0iPCqGkU=;
 b=mYxdjKMagJE8g1RMrmgfbLbnNEMjCCeqdn4Ll83QHUBW9rYEEHDK4dzci6h6qsxPqE
 TpB+sjBGgJJDLqrQZXvVolo7ctGAYsG/BTFsv66Z67KBHPqR54XjhMlYB1orFlfejM5R
 9V9/ssCto2d3THyI2ZEoIK1xvHLKRwPUBmTI1aLOFtGHhv3MD36YdR7Hjm4D/nI1WnvT
 bRQZ+POd6MCbgUhqqwjeYY76KtBnC3FBkB6uLadfYYLfntybkVh8x8uvUF5GnX5Ll4XN
 5BTSwJlCbvyK3Qz6ZWGg8thBVSMlHqPUiTHpFj+PEtiHZymFO7eOo03dNXuHXGKi2/zp
 1/gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx9pc1z1cMxKYIiDEL2SPusbHiW17f0+GCL8bd5MG1LWfLmpXiQiZSyR780yOqauIITm71np4DHPtf@nongnu.org
X-Gm-Message-State: AOJu0YyS2BQdrmW52Zx8eT13f3IpGlpO8lXsKaQaiM3iIOBaWkiEDpuM
 WUHsW017L0dy4qN/jaJrAuMAUsWxUCXm5cd6zm9U2ZKJ8mJun/UM7oB0QDUjhRnoMr2GFmteRDl
 8Jk22PQ==
X-Google-Smtp-Source: AGHT+IENgx6sgp9ipfOg+O9hsqnewn/eXXVXbxnxgpV6deMMsmT7RU0oJ+3RURhYzBb9NM8I1VNhVg==
X-Received: by 2002:a05:6a20:6f89:b0:1ca:ccd1:281e with SMTP id
 adf61e73a8af0-1ced0439c67mr5914640637.7.1725293329442; 
 Mon, 02 Sep 2024 09:08:49 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e569f1d5sm7022541b3a.127.2024.09.02.09.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 09:08:49 -0700 (PDT)
Message-ID: <aa158937-536e-4bdb-b011-0c4fc152ebaa@linaro.org>
Date: Mon, 2 Sep 2024 09:08:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/Makefile: Add a 'distclean' target
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: qemu-stable@nongnu.org
References: <20240902154749.73876-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240902154749.73876-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 9/2/24 08:47, Thomas Huth wrote:
> Running "make distclean" in the build tree currently fails since this
> tries to run the "distclean" target in the contrib/plugins/ folder, too,
> but the Makefile there is missing this target. Thus add 'distclean' there
> to fix this issue.
> 
> And to avoid regressions with "make distclean", add this command to one
> of the build jobs, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 ++
>   contrib/plugins/Makefile   | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index aa32782405..0c624813cf 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -345,6 +345,8 @@ build-tcg-disabled:
>               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>               208 209 216 218 227 234 246 247 248 250 254 255 257 258
>               260 261 262 263 264 270 272 273 277 279 image-fleecing
> +    - cd ../..
> +    - make distclean
>   
>   build-user:
>     extends: .native_build_job_template
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index edf256cd9d..05a2a45c5c 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -77,7 +77,7 @@ lib%$(SO_SUFFIX): %.o
>   endif
>   
>   
> -clean:
> +clean distclean:
>   	rm -f *.o *$(SO_SUFFIX) *.d
>   	rm -Rf .libs
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


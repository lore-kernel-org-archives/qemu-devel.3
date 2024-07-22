Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD426C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1Jf-0004Aq-Mt; Mon, 22 Jul 2024 18:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW1Jd-00041Y-8A
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:15:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW1Ja-0001i2-Gh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:15:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42797bcfc77so35990175e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721686527; x=1722291327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+ad+tPZZMmnnaf17Sh0/8nRQ7Xf7VfvTZMjwt8n4Yc=;
 b=Leg0pjlNfM0VWozjT4Sa9sEi5kHK6sPUxwiGjylhojPW20V3mC1DWQvUYgN0d2k8UN
 SAiTE5ZmprgNphbgtXdN/38HkLy6P7kGKT9bHnUjPqBDk78xAitl9G+UGHZpLnoBRmJv
 e1QaMJVflwMIXn8/lYJBiHm3IfaoZeB/5lqNSk2WJi+bM7kudiUtpWkljRY+rO84C5aO
 4Qd/NVnfpT1f00GRhUn7X2u1mduxh5Eq0KvjCK/Jm/0z3+WmP2uYZFIGjLr6bdpeFScI
 kELCb1NkmHZwXqdYc5KtOW8kJrBVd4JmBHlZYXcazWTiJbSERDSp4v1uH6NwtPFUKpx2
 fmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721686527; x=1722291327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+ad+tPZZMmnnaf17Sh0/8nRQ7Xf7VfvTZMjwt8n4Yc=;
 b=T1xNHhzxub/vU6zA4ruOW/6GkNjHtzxXeNEEZBFaeOeBnKHd9L6RcQf7LZovrMl1wM
 AYt3ZrWOAdh27GH57X2HHTnwsE8Bpc4h5MV2EpJ2PEufEVo5htIb4npVVj5BfQpDgNiH
 XyEH4SWVdZlgshv0oReftn444J137xKibjRjXtGIR9Gv3EN5JK8bI/bYn8LDSDU31U9f
 G1FK63YS585XuP8P1z5Er0Ccz3pmVwP4JOldExFgnJhn9dMimhVaTUYQK1CTMetJW3ps
 1OUqFamq3P4L2NHDpenwS7zAGH1FK0/2HQ2u+rPsUt92786xoUAuTciorMZntkLwkn3C
 yxnQ==
X-Gm-Message-State: AOJu0YwJg103/Lq8og6cc29JM0DiIDey2JoDDxiEsq0omvEiS2VzbWix
 p+RxxLUABDEBL4Ip13xvFpqcJSUCB22MbfEaKG07IF1hVBSCiDVtVRYe3kZJFjI=
X-Google-Smtp-Source: AGHT+IGS+ERC2BxRW7iyXbh/t58Vo8DuDj95ZqEcZlOJTyuDF79/MpfPyMLuflj2SulR3Yu7IDZUYA==
X-Received: by 2002:a05:600c:19cb:b0:426:51ce:bb14 with SMTP id
 5b1f17b1804b1-427dc565926mr47174355e9.30.1721686527402; 
 Mon, 22 Jul 2024 15:15:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d922c696sm128505825e9.40.2024.07.22.15.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 15:15:26 -0700 (PDT)
Message-ID: <20247471-ba88-4757-b522-5d750e378fc4@linaro.org>
Date: Tue, 23 Jul 2024 00:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] docs: add test for firmware.json QAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
 <20240719-qapi-firmware-json-v6-4-c2e3de390b58@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719-qapi-firmware-json-v6-4-c2e3de390b58@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Thomas,

On 19/7/24 09:37, Thomas Weißschuh wrote:
> To make sure that the QAPI description stays valid, add a testcase.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   docs/meson.build | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/meson.build b/docs/meson.build
> index 9040f860ae1a..bcca45a342a3 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -99,3 +99,8 @@ if build_docs
>     alias_target('html', sphinxdocs)
>     alias_target('man', sphinxmans)
>   endif
> +
> +test('QAPI firmware.json regression tests', python,
> +     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qapi',
> +            meson.current_source_dir() / 'interop/firmware.json'],
> +     env: test_env, suite: ['qapi-schema', 'qapi-interop'])

Did you test this on GitLab CI? Many jobs are failing as:

Program /builds/qemu/build/pyvenv/bin/sphinx-build skipped: feature docs 
disabled
../docs/meson.build:106:10: ERROR: Unknown variable "test_env".

See https://gitlab.com/philmd/qemu/-/pipelines/1383618475/failures


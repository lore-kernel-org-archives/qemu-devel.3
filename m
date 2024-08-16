Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06031C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seziG-0003Q3-Or; Fri, 16 Aug 2024 12:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seziF-0003P2-Ab
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:22:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seziD-0000Fc-93
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:22:03 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52fc4388a64so2812896e87.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723825319; x=1724430119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dNadilu+AGqyc65LSoiaJXxQ+86pe0xJ8MJwwLez4Og=;
 b=SspJskmepaZ/66jq+GbapVAbKBgyR0pR1DBSMvVlXCS/VoOSMojpOcpvGUs6ecqB9W
 LyCAIVP/V2ebVsz21Fr9Y8W414RNMzmOdr/FZo+ISGI7Ph4Et1xDReK/Xr7DJd04gWj7
 VMOlFvsIc2LQFtfaqOqR12jzTKg4lzKW0Al51Q6E+OQlerW68EFpLJPeedKtvK6OkfUC
 LFOlyABAb3+LqFv4C1QAZVAaMuTPm6L3eXS1Er00q5BWID/qfHgG+DHxVo24tLwquyfT
 C1PV5ma8ijOyoop6Mp2NEOM+D/JJrIQ77t6pbKj/+IL9wQFEfca3poPEruleU24lus5M
 vpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723825319; x=1724430119;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNadilu+AGqyc65LSoiaJXxQ+86pe0xJ8MJwwLez4Og=;
 b=g/CGz3gugGF3VFaO18RFmml0hdNcDDtEKXtBRKEID5lXsHgV2kYtut/W+mMXEX1T8k
 ndKLrj4q27jwWcXSz75SxKfmrWHWAHqG6L8jXp6hlMVEst1V3U4BNRXVxz2+HPWNMxHZ
 fa/uMncZWEt86B6JcrD/6nMPEJ3IEar+faAfGXEcaA5xQvw9bue+muu3Ru+ygf/xnz1i
 RvlL+KRc+lxR6IkUawHgcO+IoWJWlzk3OAtfra7ZXeKVBcAKySS8tnfs5yjQ4t3rG696
 Ft1hN3/DI1MqxQYR6MFB/v31KfNSPs1lXjw0cq/wm0kz8jSbhgWpXt8+0ebW6ibGK7hr
 KOKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoTW+27Yi+HCZmZLH4WKKi5LuOnNdRzfdw1flyojYsYc9S+L7vbIjy8LnTBDBUnaybOVmbmBqnsb1P@nongnu.org
X-Gm-Message-State: AOJu0Yyv0/ZLoIcGtw7R4oC3BHVn/EDyuhyYeZ/WLzm0ucWyrna9OZdI
 jMqaOdGdtIe0cUmocXrFhuI+5Dv9Hlo553dHAk4zIEVnYsN3FJ+qZQjsrcMlmhc=
X-Google-Smtp-Source: AGHT+IF2NoBqFKQoM5tEVITg7WztxfEEEqxe45DVobh3PqjXXrtiQ8JKAlyUg+CngCOy9hIA7YZfGg==
X-Received: by 2002:a05:6512:1595:b0:52f:1ef:bafe with SMTP id
 2adb3069b0e04-5331c6ae0e4mr2164414e87.22.1723825318209; 
 Fri, 16 Aug 2024 09:21:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383935710sm275167766b.129.2024.08.16.09.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:21:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E9ED5F92F;
 Fri, 16 Aug 2024 17:21:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>,  qemu-devel@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Stefan Weil
 <sw@weilnetz.de>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Disable the qtests in the
 MSYS2 job
In-Reply-To: <20240816153747.319161-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 16 Aug 2024 17:37:47 +0200")
References: <20240816153747.319161-1-thuth@redhat.com>
Date: Fri, 16 Aug 2024 17:21:56 +0100
Message-ID: <87r0aowi8r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> The qtests are broken since a while in the MSYS2 job in the gitlab-CI,
> likely due to some changes in the MSYS2 environment. So far nobody has
> neither a clue what's going wrong here, nor an idea how to fix this
> (in fact most QEMU developers even don't have a Windows environment
> available for properly analyzing this problem), so let's disable the
> qtests here again to get at least the test coverage for the compilation
> and unit tests back to the CI.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.d/windows.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index a83f23a786..9f3112f010 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -23,6 +23,8 @@ msys2-64bit:
>      # for this job, because otherwise the build could not complete within
>      # the project timeout.
>      CONFIGURE_ARGS:  --target-list=3Dsparc-softmmu --without-default-dev=
ices -Ddebug=3Dfalse -Doptimization=3D0
> +    # The qtests are broken in the msys2 job on gitlab, so disable them:
> +    TEST_ARGS: --no-suite qtest

Should we create an issue in the tracker to make it more visible for
potential windows hackers?

>      # The Windows git is a bit older so override the default
>      GIT_FETCH_EXTRA_FLAGS: --no-tags --prune --quiet
>    artifacts:

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


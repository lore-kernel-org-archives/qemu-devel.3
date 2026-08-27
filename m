Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C5EC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRZx-0001kb-09; Thu, 27 Aug 2026 00:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRZt-0001jl-PN
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:19:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRZd-00073v-Vk
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:18:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso185351b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787804324; x=1788409124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OP1/9oi0yin+Q+cbPguJ073cz60lEi3NDmGSa9Mrbak=;
 b=OixslEvhGMi01r48bDQ2U5Se8aBgEu1+vE0nERb6n0cZ4PwcPzBzuJE/u/uSzMif+2
 tTx7GnILG7rT4oaPVINgs7uSNnd7jn+kVe3q7Pw/qz+8BLJ792fS7viHEJSHQNPMxZyU
 5289EZZDonmhEfsEb6wPUONh23m5jeukirGPG3P/aLhFSnPhsi2IZxuAgugs+2Ficj/8
 T1YZcIhdGkKw5bURrycAxbHLNzk4RUkuGlBQ6RZc0zoe2an+WhxtEaIl+CV3MnhTMe49
 6Qm0U9foV7itvInqyqTxVPCRSnESClWdytlCzZ1pErUn+E2EaCb1UhVOaRZSE9EfZjRr
 wu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787804324; x=1788409124;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OP1/9oi0yin+Q+cbPguJ073cz60lEi3NDmGSa9Mrbak=;
 b=lM3k0mIy6cH5m19JxAdm6bUn053vuucQ0aoSasWN4uQzbZ8FwWr3dZoeQF97dGHDGr
 q90UvpfPeosfD/pgic08/3mHLJ2mLix5GrOheP6F1yT3jhRqDf6Z1S3nuaQl8JJwXM2b
 XTgMvRV1uHDNYSqGcaNArDnTQFPT3PUa0aBmdEK+qAkhWvVymbLi34+xUlDfs6lmz7pS
 nQZKiJmVw57Q1JE1mXyxtIQJG1YUw5OdyObq2QFjQ3wpmAJ0SokdJmcUxp15K0y/qFOG
 Bzl+B+ul03RQ4nfuuoDSgbrMczufj8Qj/bg8NJ2l02ARx9cx8ey9HVSJjcmD24KDb7YK
 1MIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDBApjt1F6MvLPnr8HJQb7Kp+2kGIpSO+4wIUoHkfazVbUpkxW8kkI+VtOatkWGTo3eEGRkZ51Wggj@nongnu.org
X-Gm-Message-State: AFuF++ktEEh7UXvq5kdq6EfCNAxAEE9aY0wg4xN3JQdbcVIL2sWB8zFu
 qPbVXIiUYfCFdUjBWvrFPXmwYEJ9fa6MA/RaFL4PPnkJDYzXCk9X4SCgFswsPxbT5hA=
X-Gm-Gg: AR+sD11zBeJdbiXDukQv+Jxpv58anoKXdj6f2JAxOQ3O2mqNzs8Df76BFgV9riM1n3W
 UFManGk3uOnDNENs7pbOAk2vHDqU/erCe+mI4ydP6qgZml6dQm0XRqbj7H5KgxoKJpHe39+kQmT
 NFtATxU9grBABt83RAXc2T+mzaLUUf2cPUOizo2w6sCWjVW4ocTcE8jPC9/0Sv5BQ4NiWaKT4Vi
 NRVCqwkOJvofnLBxDQs81VVNWKsb5ywh76kKH49DV7cyAgHhf2cIJIvOGVz6GDz/O/vi1DUI6i1
 oBj9aeGBCQjl3/kzc08Vzq5S6Bpn/HEKkPyKWf4illwGMkYdvU+0TqOApgsBwRGbwabwsY3I3I6
 BjCMoANu1nYwWjlavZUxlUDaHB15l4tHdOrQfNeCuRJLJdyqPkjvngJ3u3MzSy18ZPoM4QNqNX0
 yHnJYPzExsz5tz8P1DQhD2qUylrgsDg+n7R8CVdezDwL+v9z6fVzG+tNZDqUWgrbHO7ROOZNPig
 UMeqi1W6uUIwQUmlcZnsb6mHh5n
X-Received: by 2002:a05:6a00:349a:b0:848:42d0:bc91 with SMTP id
 d2e1a72fcca58-853750ce0a3mr23194490b3a.12.1787804324141; 
 Wed, 26 Aug 2026 21:18:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf47fd1sm1567131b3a.52.2026.08.26.21.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 21:18:43 -0700 (PDT)
Message-ID: <df94581e-0291-4fb6-a08f-97129617492a@linaro.org>
Date: Wed, 26 Aug 2026 21:18:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/37] s390x queue
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/26/26 05:51, Eric Farman wrote:
> The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:
>
>    Merge tag 'fixes-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)
>
> are available in the Git repository at:
>
>    https://gitlab.com/efarman/qemu.git tags/s390x-20260826
>
> for you to fetch changes up to 5c3c500cddbdea58bb76515847d1d515621dcf0b:
>
>    pc-bios/s390-ccw.img: update s390x bios (2026-08-26 07:05:48 -0400)
>
> ----------------------------------------------------------------
> New s390x features for 11.2
>   - hardening fixes in css/sclp code
>   - enable secure IPL
>   - regenerate s390-ccw.img

Applied, thanks.

r~



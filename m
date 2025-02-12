Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA50C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 07:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti7Kd-0007bE-QF; Wed, 12 Feb 2025 02:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti7KU-0007aN-3b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:38:43 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti7KP-0006eG-51
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:38:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43956fcd608so6393675e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739345914; x=1739950714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjGq5iF46lcFDHS1AxT+2K4VukBprb3w6v585nZjGg0=;
 b=Iqu7mEa7yTaKDMjh6OQgiZrSaR14TF5A7taAWC/bxQHLdWx9DMfmfdgExgHP6gnl2U
 LituTAoeRWNrm03x6erhCIjEy8vlppXD5z4EvSjeG16ueO6oe7hrb9llvLh1EAtIh5TV
 S9CUQGd2h2yOMrrK3YPDSlIoECfIaVcToX3W2lYtN+E/bSa7FHQv3uC+OkZkDPEbrhqt
 JiH92tC6V1Q1XdIZrgepoyIE9Tv1RlxumstKVQjoYVyodDbkOW+iluRVfqQb1Aph8Y9L
 PBpWNDp/dadanTrcw4xkBlXFdbKyMtT4JyT5JzTfsysj1JGTFsEw9ULIZjY0jlNaUQN2
 tjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739345914; x=1739950714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjGq5iF46lcFDHS1AxT+2K4VukBprb3w6v585nZjGg0=;
 b=M4FcAbOKTurzLkQN/5qroK30khcCbWKaSNSAcz+Kkk8hwqyxbotoN4WmomynT2gcVw
 7ATm/9dZdZxz+aD8e+bHmjA3ZKpSAhhHYA+IURikEKSThZVRmODU481TGMarnY/qtJ/p
 Q2OsB56euSbnojII43FAuR2xKSHQMS2JS8FGIZwujuyCjnBd/jIdNjbH9gW77hjfXCol
 maDvI7D+XICiwu35mL7HdA++9w8I+kojOOiV8bMTS3t8AGvvA7fNoA4k4mRVh43Bk9T6
 zhsB5J4fPKq9uA2/QGJ6twzbCcCHgkt1CMRaiOXd9425OqbimwVns9wQc19O4ydwNUnL
 MAxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzQqL56sjmwXyJ+PTpvszRTr7qFaBptq8o4cFRiOkR9hSg7HN1J5rgdrOr0w3vDQ3kutOQ64nEk9jh@nongnu.org
X-Gm-Message-State: AOJu0Yzv+nFxX2gWuiIcvzhDTbCeYpS3GlyKiZtsXpjLGv6wneqj5Lhv
 w7GKcM8CLRXvOCipixgADP0Vir27V8jyPH1fV0ltVczR2LL0nTpL04fDrKQMTqs=
X-Gm-Gg: ASbGnctd1TuTImnFB+BjgLS8FuUbdDv7XrUpTOw0yc9aH94B2XglHxjkcfJ7PtyeIqJ
 YHKV3Uglo0trUg08tm2BtdH8PHRTAsSBo2VXdVYC5b1Y1B5ShlspMHLbQ63BqaqUf2OmEox5UY9
 ydJp1GCm9W8xC6ooIEJBc2PCTYYvNJsM5RZygZMYCyWqYfuFo4bGIRZiPV0AeS528JvJDlyoxU9
 oVMFuPV2RctB7dcdXsrsLYb6lZH39ufs1f4vW4EmNd9VH4zmoKYs8Ok2HlNlEdQrMHevg7C1A0/
 QsMBmvjBFh70jZxCRWl4+4q6x0Lgs2Y67IfBXLBFJwVcAIJwsT9LEZ0nPQU=
X-Google-Smtp-Source: AGHT+IF0z+gUiwV8FtBkeok0RrvEAheJ9T42IeiQhMatM+3TEtCVi+Y42LKXYz911/hAWUnLS4XewA==
X-Received: by 2002:a05:600c:19c6:b0:439:5506:717f with SMTP id
 5b1f17b1804b1-4395816a118mr17553295e9.9.1739345914283; 
 Tue, 11 Feb 2025 23:38:34 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06abfbsm11373295e9.19.2025.02.11.23.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 23:38:33 -0800 (PST)
Message-ID: <de118836-492c-43d4-9038-0045b87c3e37@linaro.org>
Date: Wed, 12 Feb 2025 08:38:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] meson: Add rust_block_ss and link tools with it
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-3-kwolf@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250211214328.640374-3-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/2/25 22:43, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   meson.build                | 36 ++++++++++++++++++++++++++++++++----
>   storage-daemon/meson.build |  2 +-
>   2 files changed, 33 insertions(+), 5 deletions(-)


>     if have_rust and target_type == 'system'
> -    target_rust = rust_devices_ss.apply(config_target, strict: false)
> +    target_rust_ss = ss.source_set()
> +    target_rust_ss.add_all(rust_block_ss)
> +    target_rust_ss.add_all(rust_devices_ss)
> +
> +    target_rust = target_rust_ss.apply(config_target, strict: false)
>       crates = []
>       foreach dep : target_rust.dependencies()
>         crates += dep.get_variable('crate')
> @@ -4349,15 +4354,38 @@ if xkbcommon.found()
>   endif
>   
>   if have_tools
> +  tools_deps = []

To simplify, we can likely start with:

      tools_deps = [qemuutil]

Maybe clearer to introduce tools_deps[] as a preliminary
patch although.



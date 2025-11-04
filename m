Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3871ECCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIoP-0000kl-Ln; Tue, 04 Nov 2025 10:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGIoM-0000kN-G8
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:19:06 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGIoK-0002Pa-K7
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:19:06 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-640d0ec9651so3004521a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762269543; x=1762874343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qCJDHP+7lFvjz6YQXlhcQfozrNHmGtHOZfOfewy0icc=;
 b=ouQI0bxjALVheshoqoyF8wq+QsknyCI2HzV8w6vsWSIhR+TmeU90Ml7WXld09OY69Z
 P1U+GlOX4s12Xa0P0JEnJC3y9ZLsk3Y5yGHnK4ejHRZeGTmikY4WcLQ/pRsZnU9YsUbw
 JryTijG22tRNwN5yLXzYC3x+OWeIIFOGkbWae7tjLJ4gCcNYbNV0I46ioGanQDLIuEGE
 yrIW2FDiRblIUqNGEU0OG0Oozk5z8+h2eud+MrBFaFn2NSC8hK1sLHh4Mi6bUcwi0l1g
 ICa89IEA/pI10fp+O0Q9pTYvxpzaPqBVSk1BXcjXoeVJ8rW9fFGhMDmPuKEO+lZ+mpKX
 mJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762269543; x=1762874343;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qCJDHP+7lFvjz6YQXlhcQfozrNHmGtHOZfOfewy0icc=;
 b=HZlUWCILr7l4VIzqNt+QYPq28GiX4BOrMdmAWc1o3D5EKWZlUNoLZMbBUrbJFP/K5A
 SJFoOYFoHjkuq0yC6/tsuE2QPUFjxaVlrLH/csOAkY5CE6/fncTm+aISkDgmQgsnWf7M
 joJ9T2gg15gDfOAMAdWeSTE17uucZu+g58q28yp6VgQHT9qiBUyVA6A2++XFxdTNo/a4
 q8HTgksm5STQLYKylZyOjISErLfpVjXCL9ECBfq9n/FnrNJa8/g7B03737LfuWOBGlfz
 hEMfu9b1/HcXccawqVNePlga1/PgClxY+2Ban//fR2S4PGJJX8zOBEY7Mb6DiKoBQ2Mv
 Ggqg==
X-Gm-Message-State: AOJu0YxL12FbtvPnxrbHaSGvyM2ngaUanPKI0ZHrJsNA+TzBSs2WehpS
 3Oq0TMNaITXa6cMTeKOy+FdFOFBmGdeWn0jVj0clTDP2qS+IR7kc8CpxS2+ATB82lBy3I9P0juw
 ic/RBhVc=
X-Gm-Gg: ASbGncsh1frpa4AtfO2BJoVPpuLyWuy5YnFwzO3AeCOgOh473gfe6XAgyfG75tGvLyv
 z/0GBeUnDOyptN9D1cBqK46cXZn6alwZuNrVJ8Hz9tPhKckSvHS8DDHaiG0CSJ2QZoNJlMX1nau
 97we06DFDzyz9q0jH3cO20R0P4J2OA6A8Yb+7/VOsY0KTl+Ck9h6E/LDLDjKdAIM8QBhW9epsrL
 YiArg6aP5QOzutut4tYyOnyPlTJPMVBavlF1SgF7DtSL3Dn9fCPgwUdUKrmFUfoXnQ+cgNx4Gxs
 uxwg/qaAsp2IpbeR/KAKfFwPs/uz8gJe6bT3uiy65w12kHxRvYZDQezW3gnjiwkiAVDs6qvAbVP
 McUHytOi65ZRQNol5od3PlZLAczRo2gfn/00SksdFkd+G43xSgxO1kj6NCiHuoNieAxb6QXuDTT
 UVmTrX4XcePfsNPna9Z1TvjJAAIQM=
X-Google-Smtp-Source: AGHT+IFrliQvdoeJQ9P03DSHTRrQbKX8dz23JP7gmWCo6dFVj+5BLgNP6zAdqk1g1ANzDDCZnFWWLA==
X-Received: by 2002:a17:906:478e:b0:b3f:33f6:fb57 with SMTP id
 a640c23a62f3a-b70700ad60dmr1808352966b.9.1762269542915; 
 Tue, 04 Nov 2025 07:19:02 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b724034ade7sm233438966b.69.2025.11.04.07.19.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:19:02 -0800 (PST)
Message-ID: <16053b1e-d774-46a2-b3b4-cb9e86c77e66@linaro.org>
Date: Tue, 4 Nov 2025 16:19:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Next pr patches
To: qemu-devel@nongnu.org
References: <20251103133727.423041-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

On 11/3/25 14:36, Daniel P. Berrangé wrote:
> The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:
> 
>    Merge tag 'pull-target-arm-20251031' ofhttps://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/next-pr-pull-request
> 
> for you to fetch changes up to 2aaca8c6d22b18786ceff51189704113d0639590:
> 
>    docs: creation of x509 certs compliant with post-quantum crypto (2025-11-03 10:45:55 +0000)
> 
> ----------------------------------------------------------------
> Merge crypto and other misc fixes / features
> 
>   * Increase minimum gnutls to 3.7.5
>   * Increase minimum libgcrypt to 1.9.4
>   * Increase minimum nettle to 3.7.3
>   * Drop obsolete in-tree XTS impl
>   * Fix memory leak when loading certificates
>   * Remove/reduce duplication when loading certifcates
>   * Fix possible crash when certificates are unloaded
>     while an active TLS connection is using when in a
>     TLS handshake operation
>   * Deprecate use of dh-params.pem file
>   * Document how to create certificates with Post-Quantum
>     Cryptography compliant algorithms.
>   * Support loading multiple certificate identities to
>     allow support for Post-Quantum crypto in parallel
>     with traditional RSA/ECC
>   * Add "-run-with exit-with-parent=on" parameter
>   * Flush pending errors when seeing ENOBUFS with
>     a zero-copy send attempt
>   * Fix data buffer parameters in hash & IO channel APIs
>     to use 'void *'


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


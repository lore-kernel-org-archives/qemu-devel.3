Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C66CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 22:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5tF0-0003yZ-45; Mon, 06 Oct 2025 17:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tEy-0003yA-Fz
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:32 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tEw-0001I9-L3
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:32 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so6247744a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759787969; x=1760392769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8DpVt+FEYh2wgWQ9mYFiPKSBhcSs2I4iONrWL3rpwE=;
 b=AxoPBWtAhVj1l/kB/+4oSPlzJAceNV1gCDAlGk8StxHU558lzbp/SOclJyy2YaKKnU
 SJNzssLHhBqWPZmer4P/5/MWhBqcXAfLkffUuxgD4O3jWpXp8/vEC7gJAiBj3jZPoWgj
 nOVIVuBiwmxLF2/mZ4trkKBmnX+Nm0j2g9V+1qsyYDWxQA2lUiFXtrPy4xgvVahwl0q4
 6/FFLgXNDgn5uioel+SRiZWDa4w81PbQXRXAIfjuzMnstD7fIHtSc2FIi+hmB3aoM1zv
 /fdCFcvU9LyWJ7/lQ3TJR+acVn2OdUdBr47Mwk57tqE0Uf188Yox+WEeK8AonRDkmu7c
 mhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759787969; x=1760392769;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8DpVt+FEYh2wgWQ9mYFiPKSBhcSs2I4iONrWL3rpwE=;
 b=Zs07QM7hBEu0Ebr0vdhfO231FJ94fsrddjRfgNTCvfX3IlnMk29oi48gxkZSWaOgAa
 2b2ksJyzu6P9NmZvxEQcFhdK/geomigu6VrWRoV1maDQeI+O0yiu7BoQTjPmv+HXQj1c
 dArtFNzMCvUp7eliJBAbVeSGrx12/HXIsxjHF5k1MPD5C8sbcyCv8TNsiYvXMHdaupiG
 WRmLrIYyk6I3byB56nATuM/3eolYtAQKmtZZ1HPl3jboLEQ278MgGf8kU0S6fpF4T1SH
 dfn6bYSWc6+U9cWUS6LRpZXtWTWwrVCHePAQqLi5s6BJc/lUE2WFjMdf9vjWVxXBN+PU
 frbg==
X-Gm-Message-State: AOJu0YxixBUaQyHNbk15Bet/8qBLXgnTe88+vO6jCwoFphUoesir19lm
 kLZ1a3CYGwXIXeOcQZDf3i7B9PA3w8wo+wSwvKFNk1ivDK3t8rmllC1F/s5ho1oD/deAA5gtvEg
 QMbFQu0w=
X-Gm-Gg: ASbGncsfbiZBo27ceabYx6H0L97237XOD5le6xog0LYVW+M2CfJHzhM3Zi0wKgK8kzA
 3KjWSe+fK6qsmvp77abgQZb73KJLHnUoZTznNiCnfO5aRc3NnQbjXuwH9Q52I8EBhjxmkc2c36V
 cXivft7NA4EuDIFtfxbKIDFD5ojVhK01TL8+QcSmGtdfDINxvZEaNzRPLbyWElIALo3o1POSkMT
 RLpJga7lS3m2abpjJ+1e6sjEDP07oFhmoAclyMQjIIZOLfz7NZjbiGwDZPh1lqi7VdkLc6WPJMX
 Hrcy48fG/AK9z4iDVkxp0S9XrNmPYkGyjQYTvgCp+l1OsKiD3eNqmJ2juM/G0zUyXNZIBsLDH1C
 lYcgsVtZVsBXkCAbYVqzWhW62YqZXz768W3IlQ0TDidr0C99TuTSyiDEwWo3i/fCGKvQ3u2chBL
 0=
X-Google-Smtp-Source: AGHT+IEWyIFbBr9Yzu2rkqyPyMGE1TGF8y86jJ3J/JS0GwzW7YllDgytHnpeVOtAcKFi3Y1a2znj6w==
X-Received: by 2002:a17:90b:1b41:b0:338:3dca:e0a3 with SMTP id
 98e67ed59e1d1-339c27348e9mr18939474a91.16.1759787968468; 
 Mon, 06 Oct 2025 14:59:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339c4a0d4f6sm11742223a91.3.2025.10.06.14.59.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 14:59:27 -0700 (PDT)
Message-ID: <1ba3fc6d-a8c8-4350-a903-54ce8b421d25@linaro.org>
Date: Mon, 6 Oct 2025 14:59:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] slirp branch
To: qemu-devel@nongnu.org
References: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 10/5/25 12:47, Samuel Thibault wrote:
> The following changes since commit 6d10e021318b16e3e90f98b7b2fa187826e26c0a:
> 
>    Add a feature for mapping a host unix socket to a guest tcp socket (2025-10-05 21:13:11 +0200)
> 
> are available in the Git repository at:
> 
>    https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> 
> for you to fetch changes up to 6d10e021318b16e3e90f98b7b2fa187826e26c0a:
> 
>    Add a feature for mapping a host unix socket to a guest tcp socket (2025-10-05 21:13:11 +0200)
> 
> ----------------------------------------------------------------
> Add a feature for mapping a host unix socket to a guest tcp socket
> 
> ----------------------------------------------------------------
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


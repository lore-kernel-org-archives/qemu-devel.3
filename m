Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190ADC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 16:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3bn-00030E-CV; Fri, 28 Feb 2025 11:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3bl-0002zw-RA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:53:05 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3bk-0006QF-27
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:53:05 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-222e8d07dc6so44776665ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740761582; x=1741366382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JX0K85PF7mfnzphIaFxF9IcHmq43uPN7l4xpfxMbqWE=;
 b=D7Id4gC3vwX9XpVxXh+lc99Wfs1XbokKAolT+Za48/MCnIZ1GlhjoCUyTI5dTNeuXZ
 v1fKBjE0nQRdrN5zvywNYnNtiGaCyODR1NU5/6VUCk/hv/MF7P0JDPaP+OAaZvayb23A
 TWd9AN6RGAOJu2Z0mCWoup19jBNivfXRMCCcQQ1snajHnrOJFFMbvmzoesCnwvrg17GH
 lvusAq40vJXpnCjVxTCHlg/GOv+S7JAAymzVWVIrCbDPKFSzVxOsljoGmzFOZ67meK4U
 CSySLodC2/ZZBpjIEOAM9Ls2XFOZMNLauSAV7+t2EmQqUgpcjDlWMKHevpd7zACFnfS6
 sU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740761582; x=1741366382;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JX0K85PF7mfnzphIaFxF9IcHmq43uPN7l4xpfxMbqWE=;
 b=dQFwu1afQaK7zu4Hbu6p1YFjz/3/Oog24FfxVGNaZIy+T47pSYwAMEVe6BlhS6/I79
 bh4NzBnwHzNLZt41Hhy1I41qEuBjHjldj6PAaahyPsKHH1Bx/6ij42ce7QInXtGR23gC
 +dqmg6C4rxBtOI8w10SggCLbrLCcIJ8kjrBnv31fE9IoDvkM+UGdZbGAqzxbXprLjIch
 AkAxM6o2oY8IB2wKcIK99XcDLPlIg+D3a7r0fNZqNL8nab/LRKbdUsaC9Gr+diPbB2/S
 NXIcdBaGzAztZSoUo9+O839ZpHrobW8HsQALEWrpBxSFKrAb26MNkw3U1cmVGYsGBR/v
 cmKg==
X-Gm-Message-State: AOJu0YzB55P1xoVw8JYIpJCRIBBk4RNTDuNmf7fgOVpNbWpQouQqKk12
 jw+ZxUySewtShCDiqWFgXeSe4MRpaYDzjOCXVZvzIJwNYi6C15HXEKTZtiLlbn6JKbI/KC8IQdQ
 C
X-Gm-Gg: ASbGncv5WEZPAHlRUA9l4McaZ843VtjWrCxEWa8HLoJt6POajoE8I4NXP3o+L7egH+X
 L4OBvXSLDZelhE7C/2tHI7X6WDEwd8sUND+idyRnmkKdumUzibeGA6ikkX+o4CcmOEQwjYPGcc0
 PSxgGANxWPsV5LNu8T8HkUxjEzam9WudZi7acvoeajuQ00s4ywcTPrIupEIooT7AHif8MII8Ds4
 8Xch6D+S8xiYfsczFD1pXTxZRZPCNjbeNxw8VkKFPoPHV+6AP5sbOHt6YOJAz/iE/29VH2ol2Yg
 DrPcdroLloM30ZEVU3OwgiaPUTnIvlaQoAYjWZL2RB/foZUVzViIMa91F+BFxXtJIgJQGhht9t8
 NNQQuESc=
X-Google-Smtp-Source: AGHT+IH08+NBAp4vXofEsbWvUkyN/3vNClOmU/Hjv1ONNgjvyEgVwC6TViIAAyOgNH/iWkSr5Qz7SA==
X-Received: by 2002:a17:903:2986:b0:21f:6546:9adc with SMTP id
 d9443c01a7336-2234a38cd53mr133316915ad.13.1740761582088; 
 Fri, 28 Feb 2025 08:53:02 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024ba3sm4059741b3a.99.2025.02.28.08.53.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 08:53:01 -0800 (PST)
Message-ID: <b07a78e9-f4e1-4763-a3c3-ed28da0a9758@linaro.org>
Date: Fri, 28 Feb 2025 08:52:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] tests/functional: remove unused 'bin_prefix'
 variable
To: qemu-devel@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-2-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228102738.3064045-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/28/25 02:27, Daniel P. Berrangé wrote:
> This was copied over from avocado but has not been used in the new
> functional tests.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


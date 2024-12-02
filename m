Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AB4D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIABW-0001OI-NV; Mon, 02 Dec 2024 12:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIABV-0001O8-TU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:26:09 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIABU-0000WZ-9i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:26:09 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d882619044so28166926d6.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160367; x=1733765167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4kcOPADl8uze1EDoh665MJ0uNhPcqjsXSwyTLExfoN0=;
 b=ZZCxpZvtK2Dr0V8jv85UAOkT7PJxq1FXjQeutbr2bbeYixeLbBMfuT/wv13t9uiKBM
 +NOklKC9iuNZhe7E03aKUwfyLCV0o6AF5kI9vMnN2v0wKXfd9z1g19xs48kYLl78p85j
 X/ofBSRR4Qf6I5tCvzpiiIOFnScefrEuEj1qgabRaPAJMMg7/MEVVsnF5KRlwB0toV6m
 uRXzbDjH0Kml/XWymH3C7325A4TMbMvI71tTNGFs9aSbw5nAImvs2sYL2DGL9qFsb73N
 sYNqQZx8hWubvCA+EbcezOxYZrzDD6bxh/E58ZLLNyJzDeRlIckDMCARhJ0J0pHgSkRa
 6dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160367; x=1733765167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kcOPADl8uze1EDoh665MJ0uNhPcqjsXSwyTLExfoN0=;
 b=JK9ObiwbVha2QkHY0vS0hJfXOcnwkR/W2rmfikGhWO1fgBa+X44XUf13zhj1l/w3qm
 R+TeL4kU8ScPV6oRRtRqLM3H/yTPMgZBAMJxYN+LlHnz7slZW52ieoDQkwj8Asn8MFnZ
 Io/rOkU0J8pmJ/EvVQs13jj1dBLtDP7UfEHKU3Mh44GL2KFSG4TS3hZGTSreMZCfRlKj
 fIt+7dEArnB+Pu4iVJ8fL0HXehfMgd5gtQ7ixFFVhxuLg4oHZWZpNYfTiSF/bN0AjoXi
 DvdD1nmiNcaNUvNN2vXEKAKLSIrOQ+oC5kQWZ3fkKmsEjok+iIW8twMaTscYieW0FAWl
 lS9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZOMLh8TH+nTq6yoNTwI4EgSXB31jFuyI++RBUev4rvyM9B9pGFmGdAPCxU39StauJhelt7bnO7p+a@nongnu.org
X-Gm-Message-State: AOJu0Yz9IRDKxnpSf0ls6A8FNS5OQVDsmP0okm+jAei75MpHzr6pNiLJ
 us546z7dDYh15nSk7Zn1OheHEk9uqyFMPd9bRF0FVksQLv6afNsFt+F0lBOFHlE6gsTBlgM1wx+
 zc2E=
X-Gm-Gg: ASbGncue7zTp1i7ac0ov03IZ+sk1kcfiWmTDPJRzoEpPshpNpkXE4nglRT6dLoHY9L7
 0ZZUNls6S8k3OV4NkMePx85asHFw30GDwfhLRUGOcmb/+e3qgMTHMVOeybQKF/4HU7DtP1vDIlp
 oR4p6TCn1potlVkVXHll9ODzEqMb7tNNAzx/uL2DZOgPVby/NsTC4xRudrprti4m4CYbdmZKyll
 uNtkrs9ZnXfvg5kkwRjl103xzdb+g7qbbcjpkQv0Jd6C96deBs/3w/yHYZ1Jbfu+V4eWhQ=
X-Google-Smtp-Source: AGHT+IF58KOMcCTBenhbemSdNrksHFoStNlkuSkbU8KuGwiWbRQORowPe3vv/eZRNNp1X8YJzQULKA==
X-Received: by 2002:ad4:5ca2:0:b0:6d8:8da9:e418 with SMTP id
 6a1803df08f44-6d88da9e58amr213100116d6.40.1733160367110; 
 Mon, 02 Dec 2024 09:26:07 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87516340csm50330206d6.9.2024.12.02.09.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:26:06 -0800 (PST)
Message-ID: <a760fe85-db9e-477a-b2ad-f40e75918b9a@linaro.org>
Date: Mon, 2 Dec 2024 11:26:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 34/54] fpu: Allow runtime choice of default
 NaN value
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-35-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-35-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Currently we hardcode the default NaN value in parts64_default_nan()
> using a compile-time ifdef ladder. This is awkward for two cases:
>   * for single-QEMU-binary we can't hard-code target-specifics like this
>   * for Arm FEAT_AFP the default NaN value depends on FPCR.AH
>     (specifically the sign bit is different)
> 
> Add a field to float_status to specify the default NaN value; fall
> back to the old ifdef behaviour if these are not set.
> 
> The default NaN value is specified by setting a uint8_t to a
> pattern corresponding to the sign and upper fraction parts of
> the NaN; the lower bits of the fraction are set from bit 0 of
> the pattern.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 11 +++++++
>   include/fpu/softfloat-types.h   | 10 ++++++
>   fpu/softfloat-specialize.c.inc  | 55 ++++++++++++++++++++-------------
>   3 files changed, 54 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


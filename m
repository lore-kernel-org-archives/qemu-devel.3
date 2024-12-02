Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB5D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9zV-0004WH-Fq; Mon, 02 Dec 2024 12:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9zT-0004W4-VM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:13:44 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9zS-00059J-9p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:13:43 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d8adbda583so4756696d6.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733159621; x=1733764421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L5YiWs8jxur0kYUMgy9gwjB23eVA0y2WWsEd6C/VWvU=;
 b=I2Nqrh9IWIoavaXNkDBD3FKIUXDP+MUHF0gBjqVxFfS7CG8gyR2qlXsjFY0hdVk86g
 WMnZHTtx2b9zTe5eoFIjFa1Z7UBiKSKezgSjUTsuWs2hgGwqYO43pqJtd9t9QYG/60yq
 IxBsf96koG5LoUsdQmB5uEAuJnHu5GKe30000ytte51+prciAUVjyv81EWMWKJyIPErW
 FPhVRnf+5ieJ1+/fcTsBJMdXNmAlsV29qOUcZTfUjlDLbQoHriteRLHy5sFfKx9S67Dk
 odhQ8Pyk3M6e8u8X9vlvwOdgaTp0BOhf2b8fYVMp1yodyCaU3okSoFaaI+aUb1r/h9vK
 bbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733159621; x=1733764421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L5YiWs8jxur0kYUMgy9gwjB23eVA0y2WWsEd6C/VWvU=;
 b=HKbYDlPpGdwFDP9w77kCqiqIs/J5tsCJPmqMZbUvZQn6iaK5wkXOUnRTsvL+M84U21
 HUhLjJ4fCseaSPNqoknlYej4/JVN1q0UhtXkTo0cTm5spfgVT01D5KT5EqzR2O/Gq6vN
 IzvdmbjRkXt87XUr+kRt4MeS9m45IbEnZXUEw0AkR5wlBrO1BZXHAspNrK3uw2mAqjty
 TVys5ExbzUuAS2RRHzQ8COuEydNrNfogAYxw1jeRzVWGRZdkh1rwNknYcc9Z33nGtURZ
 ubAJnR0F/fzgsx4QlmaAEYjbCexufx1qhEKGMiNVeml2taCAqIB0adio9dTuWv7u/HnK
 Zn9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzXw5SKhnHxvYgk7joscWpSU+snc1MOdkbLiUyVqyX4iQcbuK2WIcESoop6Q44o3iA65ssFhl8yuNK@nongnu.org
X-Gm-Message-State: AOJu0YzvQ9+b1YKAxFzNxIzwJ9TQZU+HkojI0MS7qIUl7BU2lpnKnywJ
 RqlDs3N0Tl+uUg7PTiNbsJ3ypoHx7ZgeqKlV0lCWWYTpBILe1mLniO3HywtxoqxFeQyLKA/buEI
 zPtw=
X-Gm-Gg: ASbGncvYjqa4fTmOy3pK2GA/bJ8gsDBKZFwe2YtVpMYgig4gGIuc+oIcAx7GeVNpTt0
 n1XQdG+j0hmzPl05ziu9YAim4WJZC4Du9bAlHE2YMVVBEQBGQ3jwfAbqbc1sUUrgAQZcXOJHfG3
 1zvugtNRxlORPCZ5Wfe5KAZBCVmJjq++Vsn7Oz2X/jqE2qqsrH7SkqwbhAD6+GnxYhF9PdkC7nx
 CzIrMxWVKI9vYxlakiPYmrk9+vhQ/5djeo4ewnkD2QiZcAYM88b8GVMLRjloQlABklmAO0=
X-Google-Smtp-Source: AGHT+IEpLUAfIw/svrZZX718C9evidtC47fD2y/dpOistVP6qK2KorTnzG2rMo/BfSY21gXdtrU11Q==
X-Received: by 2002:a05:6214:2308:b0:6d4:1662:348c with SMTP id
 6a1803df08f44-6d864d36f32mr389011706d6.17.1733159621020; 
 Mon, 02 Dec 2024 09:13:41 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d88f8c2129sm31810226d6.126.2024.12.02.09.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:13:40 -0800 (PST)
Message-ID: <5739bd44-5f4e-48a4-98a0-e2c4217b02fe@linaro.org>
Date: Mon, 2 Dec 2024 11:13:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 15/54] softfloat: Allow runtime choice of NaN
 propagation for muladd
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-16-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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
> IEEE 758 does not define a fixed rule for which NaN to pick as the
> result if both operands of a 3-operand fused multiply-add operation
> are NaNs.  As a result different architectures have ended up with
> different rules for propagating NaNs.
> 
> QEMU currently hardcodes the NaN propagation logic into the binary
> because pickNaNMulAdd() has an ifdef ladder for different targets.
> We want to make the propagation rule instead be selectable at
> runtime, because:
>   * this will let us have multiple targets in one QEMU binary
>   * the Arm FEAT_AFP architectural feature includes letting
>     the guest select a NaN propagation rule at runtime
> 
> In this commit we add an enum for the propagation rule, the field in
> float_status, and the corresponding getters and setters.  We change
> pickNaNMulAdd to honour this, but because all targets still leave
> this field at its default 0 value, the fallback logic will pick the
> rule type with the old ifdef ladder.
> 
> It's valid not to set a propagation rule if default_nan_mode is
> enabled, because in that case there's no need to pick a NaN; all the
> callers of pickNaNMulAdd() catch this case and skip calling it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h |  11 +++
>   include/fpu/softfloat-types.h   |  55 +++++++++++
>   fpu/softfloat-specialize.c.inc  | 167 ++++++++------------------------
>   3 files changed, 107 insertions(+), 126 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


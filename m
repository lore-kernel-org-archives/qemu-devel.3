Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4CAC282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4EN-0003gV-IF; Fri, 28 Feb 2025 12:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to4EK-0003b0-Ns
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:32:56 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to4EI-0003OK-V8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:32:56 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so2215174a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740763972; x=1741368772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=corMgdo8TYcitcM796E/79GJ9HoREQRLW3I4qbEugEY=;
 b=JBS50ztxX/sQZ2DrN3hwEG+iq84PjFdogTWJ3sxIRX3hG8DBaUQmRgzdgJuwIg4pBQ
 KrV7x/1n8ePCkXMbyTFVYaHACfHH7+DkRxB+A7QxD4J+HLVkBXGMgHl26qKOw6hdPBO3
 SQOfP1TblRLUDQHKdJbG0O8GkdmCRAxTfLHiaA1m3pEHEiKFMYVES5D0La5j9ya6TXtE
 RAaAXQ5FfKvnQ2XLqWan5u5u7CpMPpYLasqM5OBBj8IT6T5knZ3NbNhfeCrOptXKuiW+
 Juu1paKxjZs2T+nbLZeOmNH+bqo7Flbt3jYmP20lCmRtrVzm47ZFlQpS33TJ7Vv7shbi
 JfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740763972; x=1741368772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=corMgdo8TYcitcM796E/79GJ9HoREQRLW3I4qbEugEY=;
 b=OnM5VU2+4afNwmAnMoi0XheAUyUsM5abYzTU0J2egwSO7iaivBXwLDc/bamh6NFmLt
 24h5E5TQSekDnWZZ6UO90Zsglr2AaUIZKk2qYRjZsmQf1dn1ybTwput9Uftn7L1lZeYJ
 78oonovVF1RGO4oPMoErebvwCyndOTwtunrAUyHaGfvEfYkwvHdpln6NED/hm/EdVfFj
 RblLHMVLiTj/k0KWUGgWan2/k0kLEM10mjXFqZsBF36z21wQq5MyKzsIjMn42+BpfO9E
 SEjsAvtDAxyHZTHteg33jwPvTafYpHWoVZmC9/ZkbA7BxesPoSWZ5AiVkOOEzDvCoO5p
 U7+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu6p10SpwlC0KuTffazggYBex2EDM1rtlomz0mbNSquOpoOoq9Zd2uY5PagFdfNfDDJjUBC4d7fas8@nongnu.org
X-Gm-Message-State: AOJu0YyeGu6vqRJQyXjDGMJL3vb3wRRzhLPrWN1Fq2Qu7+uxjKYtljln
 shMZDunGzoH7465VpMbEvfeUAkph33C3R0W5wHY95PqQStx3yG/pLQ/9Y+gQBcY=
X-Gm-Gg: ASbGnctxPIiu3HqKiC7bSLvusFtZsgHftvDl4SaSOtHRhkOQG7m/d8IAEMYQo27OdLG
 fUm9JiZ+5I0oBoFQahOmwoDZR2TDY4RE72VIKEmOL2ocsKjMxhM5idj3Qfng874fYqpz63EWqIo
 R0dAO8dZogTSmI2t2OO/kO94WY1lUWS7WX3QSlWyuUzZc3UYrlt5uHFgyWvE5rRTIvA/Ztg/uuL
 UAa/SQKMTchUIV8SjdI2+7/Iw77g/MS7BcNfBAelvc3w00Gm0L6ukkJQIynwqJPobB8Ll1GL320
 GoEHrG0xDW38yrfDR69+jd/S46vkh9l61ONeAIxxMFUhSeny3LiptqsvMY8BxxSEBor1+tzA/Ci
 L6N6CZ5E=
X-Google-Smtp-Source: AGHT+IEiwINSsbjEsSVanUrqSROuFq4EYO6RFr3SjYLCtB9AVy0piwzvmxlO82h9cQbfZ87oWWBnWw==
X-Received: by 2002:a17:90b:1d10:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-2febab787cbmr7795792a91.18.1740763972214; 
 Fri, 28 Feb 2025 09:32:52 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235051ffc0sm35775555ad.226.2025.02.28.09.32.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 09:32:51 -0800 (PST)
Message-ID: <a95ff4d3-e362-403e-8d0b-63b888e098d2@linaro.org>
Date: Fri, 28 Feb 2025 09:32:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/exec/memop.h: Expand comment for MO_ATOM_SUBALIGN
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250228103222.1838913-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228103222.1838913-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 2/28/25 02:32, Peter Maydell wrote:
> Expand the example in the comment documenting MO_ATOM_SUBALIGN,
> to be clearer about the atomicity guarantees it represents.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/exec/memop.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


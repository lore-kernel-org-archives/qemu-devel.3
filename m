Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CA3C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRLC-00007I-MI; Mon, 10 Feb 2025 05:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRL8-00004q-H2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:48:36 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRL6-0006OQ-EM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:48:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dc5b8ed86so1690728f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739184510; x=1739789310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F7jOGhkvG2BPPB58iA5ZayUvM5t56BkGeZGTT+ayoHg=;
 b=dnnTx/jueyQszXo+mnvsA0YZT58w+Yx5j9V1c3M4ioXWEiuZzXp0+kOns2ClLjKxOq
 l34kZ8fbS1z5wH6hQUh4MQV/tIZGfkX6SJfjD12RMxYVDFhRatr8sZfYr65Qxp0sSlZJ
 fU1gwQW78tm4cwnc8h9WnJym+3/6aodZ03+pEfy7Rqjc7OGCi/TkPBxKgA/8a3TBtkxy
 Qhr1Gbp252yvPBlKGBKu9V73SW3Z+NC8Bm+r1KFfmDwjGTjeH5yzdS4i1tRvhvoqLtGr
 BElT1kEMJRQKg88nNFjhhewhao7NHGXEn4IMnzPyCDwYt1bJocaHwGa1/aIwuSwaVyLt
 H6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739184510; x=1739789310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7jOGhkvG2BPPB58iA5ZayUvM5t56BkGeZGTT+ayoHg=;
 b=g7a+C4URRw8a9B5xxIHTN0kykgc2IKmmfrEjQ4n+lyKe687MuFADrbIRf+BcKG2m2k
 v8siNimtzFNAlj+s2WkkVvgQvItdWvHg8YbrFc8+TPEqoKrYkax5L1leKrPQdTA7r6fb
 6pCt+1D7MJfTeM4wJ2xMODjxCPF/lpvGIJdAJ7ie6Mr20Z/JuMOkN2NUEdTjIU27rtOg
 xBioL/GiOj4KyI0gUpf1UaXQ5pcm1Yf3A8yE0wcB3hj9Z0OmdpTOhYQqwfm/rNaCXHvC
 XoSjqIwGBF/cie3Do9ul0+aIJnU0CKAnB9ICqXdUpBaJ2V/EbQqHD95ISAmtxvURWJ61
 C7HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEyrxqAsQMMhdPM+BjortSxfr2YDjYzCvwVkToi5V29r7L3odMTXtVu/Vrjvbuw8MhZGLo+XI588Yx@nongnu.org
X-Gm-Message-State: AOJu0YwZxjbWJ6i1kVFWD+tQC+utu3iIx6MnL8N6JrXKotburVtQ85kI
 tRY/KxvF9omXQd997FV/xsmRdX2I6d952haTL2ckafkj3WpJK0FuKIXleabdJtjX/KfX3csIhhZ
 /0SI=
X-Gm-Gg: ASbGnctfgicDHNXoCmykU6HoOaV0q0KOIjnl4DBQPqGCAMpGbk8ldiC06PWS5NFYwYf
 C1D/+J2Xo3vS+r0++bFbCXzI8+LbaE5j5ng9RogegrG3bXPRvNrzVJUh+uCqzesxo+DksTPm1GI
 d5eBH6LtqyymcaAr3YydJiXQmLfmnDDm1dLWxOoIaUJHC9YhdIY5TFiVSM5u5Y1V3AjEdXYIoQc
 hYcA8vNNlZ/+jmDp2GvlCB7GLnQ0Vkk2SD5vFNJZTpqhG+KTQMx1v0o76c95HdWzTRJHVA0GAp5
 cADVWQWBVW/Y5IxY4GJaWVArnDaBLW7DMWRb1pAfDtm9/5P3dHN1p2AeCofNj0Bu
X-Google-Smtp-Source: AGHT+IGujku1w1TTqWl9AjzxBgbvfM3/RFIVWRzcOSvkZRmnerULk/EeAlTFf4cJzGkBZa2ZA/VjQg==
X-Received: by 2002:a05:6000:1448:b0:385:fd24:3303 with SMTP id
 ffacd0b85a97d-38dc8920858mr10815624f8f.0.1739184510482; 
 Mon, 10 Feb 2025 02:48:30 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbf6e4a4bsm11713804f8f.92.2025.02.10.02.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:48:30 -0800 (PST)
Message-ID: <b7937e28-81cf-4dbf-b9d8-887d199636a0@linaro.org>
Date: Mon, 10 Feb 2025 11:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/mips/boston: Check for error return from
 boston_fdt_filter()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206151214.2947842-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 6/2/25 16:12, Peter Maydell wrote:
> The function boston_fdt_filter() can return NULL on errors (in which
> case it will print an error message).  When we call this from the
> non-FIT-image codepath, we aren't checking the return value, so we
> will plough on with a NULL pointer, and segfault in fdt_totalsize().
> Check for errors here.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/mips/boston.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



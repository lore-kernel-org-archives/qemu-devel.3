Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF3AE9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSsU-0004L6-V0; Tue, 17 Feb 2026 16:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSsT-0004Kh-FH
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:45:05 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSsR-0007Wc-SY
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:45:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so3556441f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771364702; x=1771969502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wm3A6IUna5QDapz1zD1RaS96Qt7rz/PkHgFmzLgEKW0=;
 b=p7p6Vw6yMAvGjqpaxVm60/ZqfZaqpMOorP1v+FoW6bZZFJcXWnaGj1xlR+AS6Ua5wv
 OnQs3NZhG9PNt8T2TFbsI1N02SdHAB9QVk9KMYdPM4gxId11GX2S72XlV5/Im9sR8NXj
 wf/ALjgwNwSi2C0iMo5LcsgautGhZM+XX0RsxyRmaiC+lOmwyPqwmZ3QuGa+2NL1g72J
 PITdb0RBoX7UqgnQvDJ+HS27d48BWOeLOQ+dxBEn66QMjb9GX/gdZhxhYFccIQcnrRmP
 SrKq3TOa3g6+bjEYo0HlP4haS+I4TGY86yj1EMdUrNoAk+qSnegNJ9cgBegFs5orsRel
 J2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771364702; x=1771969502;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wm3A6IUna5QDapz1zD1RaS96Qt7rz/PkHgFmzLgEKW0=;
 b=h9WT5+/p7NcgZiQ1mO/xAGB2isQlVivjGoYGuucxEfpAT/8iE+PZ5ZPWoziBSUTiwU
 yKrcXQxtg0G8/hsr0nr9o72ZjaUiCFRK3hRBOKgyrzELcCcVTaB906001V/LFQspvw2Y
 6BQsEtI1s6sWIn1L+J0NXSdNiqLC3z5PEJriVBh8E+5iDSXlKA1sGUNdmGr5a0oboj5G
 ItSY3DcaaZIbpb2IfNfzQokRrlpGlqrgajoimVdGI8Qj8+WYgOo0BLPHr8l5EuUG42Ml
 e19rQIDqMg0+zfOdqq3hQq/Lha3Q0S7AOmane05GPx8wuq0jfR9Mgn0yZmlrCWD/fL+3
 KIdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwu6spxfawL0ZURTLz0jqQqIP/kMddJnR4t7EtCdYkyzJ6Mq/nUS6EAME3cUPhdFhvpa07z47bGOW2@nongnu.org
X-Gm-Message-State: AOJu0YyWVZNhoRtJ8P96bdIQFZDODXXAd3AIz8bxP52AMncnc6amTdFP
 rgAbTpP37kr6C3GQqyrvExxCxW/y7a8wzGBeTNGJHTxs0Zu/cLPrMQu1F7CL0rF+e5/cyeBcxtY
 SSSJ7Ds0=
X-Gm-Gg: AZuq6aL7CS2jjTbVFMsZWa0UDkcvcXMSJr2oVf1IaIxrVpcwBmS5PVIrzBMpRqTrJ6x
 fsrZ0L+clksOqgcPTEMdWUavPgiWs30ROKsNrr1cPQcqaa5SWodj3SZ+lXa9guUF2iMkVOPcZeU
 a4lSu2ud3hz7dHENZ5DkQbKlDgX3onB1gCnL8c4QWnSMbbFO0H/M8a5rdQ+S3KvHADXENJ1iuxh
 HlkFLNvQlmyHaMj9oXPNTowhA0yo/yF1jraXxQX1XKnDnYoe6F1FGb94U0xeXCQVWUXF/eve4Hk
 QfKvCU7C20Zo1UQkxjmQ3ocaPkfu57n0a3E0hLjqsDiDOlRjeULNlV4EqjNNmJUqW0Lykhht8cC
 K5WM0j7KpDuLyIq/DULPWwXhyTc5spQESrfG0toUnxLc528Qg5m+X6eB/Dtd0IWaWlvUjfoHlHH
 YeqrXrKr8hUhcGtw+qXCmhxF8CKI3vOdEyKR8rMgq0JwXaukAsc6SD2ZXHwb9Tej29qA==
X-Received: by 2002:a05:600c:3e06:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-48379bac807mr187420785e9.2.1771364702247; 
 Tue, 17 Feb 2026 13:45:02 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d994670sm428486165e9.4.2026.02.17.13.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:45:01 -0800 (PST)
Message-ID: <cf5cbdfe-3fdf-4e87-ba2b-c4fe852ce67d@linaro.org>
Date: Tue, 17 Feb 2026 22:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] target-info: Add page_bits_{init,vary}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260217095106.598486-1-richard.henderson@linaro.org>
 <20260217095106.598486-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260217095106.598486-3-richard.henderson@linaro.org>
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

On 17/2/26 10:51, Richard Henderson wrote:
> Add two fields that will hold TARGET_PAGE_BITS,
> TARGET_PAGE_BITS_VARY, TARGET_PAGE_BITS_LEGACY.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/target-info-impl.h   | 7 +++++++
>   configs/targets/aarch64-softmmu.c | 3 +++
>   configs/targets/arm-softmmu.c     | 3 +++
>   target-info-stub.c                | 9 +++++++++
>   4 files changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


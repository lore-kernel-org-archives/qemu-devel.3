Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02249E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvNy-00023c-7u; Thu, 26 Dec 2024 16:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvNs-00023M-Qa
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:27:09 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvNq-0003oQ-I3
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:27:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21680814d42so70808105ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735248423; x=1735853223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxHyUeO0qhePZQ4HnutMfLk7TLe4RsBEaKbqngfV7ug=;
 b=Gv4YJFN/hhjPbGIRlZTpkD95851r/iE6dXrTGoycIUZHps9fuixbkWZjWnHWeRzlV7
 bvif3RT+7D/+2NA31EBxLmpciE/R/15ei1+EMRdtxHmvM8xR2DBGgEHgQzGV9LlFURWl
 wK2DS1WArrtw+yjKsttAqnImFbZQ5J+3jwC0/0MHawevvsCbkZ915+WDTwviIuE5WmQc
 NXVhU/tafJ1+3QzcAc0gD1N6UnRxaSwXRwPL2e/sNMvZ5ewUoB2m09EIol5BB+GefDdO
 rLYa2Wu82nXl+jlMe3iR8e1ixH9hXhD6+7B/CkraPk6CeNvyfWxWA/LQYM56jv+0+fN5
 DOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735248423; x=1735853223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxHyUeO0qhePZQ4HnutMfLk7TLe4RsBEaKbqngfV7ug=;
 b=Z4rFhcynSkQ0fIu6L92IKEKg0swgEVjt6clt0fPoAQUnUT5QDbxYCir7C3uqFDCVA8
 rzC0YjUUsCkuUoXDQN8nNW8rO5n59y/F50ACixLUqHBtCuX/sgvtkrwpEh9T/o8TkPxl
 TbohnQUzQsnEK+59LnaLMfVkSIGcGdOOjyRpDS+f3ujcrxcoXR2cFVtle3OgCt7lkCwa
 DwzaDw79cWytuCS63uWJ8AE+I9LjDgNNHH/6NRZG/WH/E2wbzjzrigHogFZjz38f1U6G
 RIHuDpOGJHcB+hEnddqt5fdpNziSpPAloqcc39w7qh9uyhk6nwiAgt60WlJJPjaErGj3
 z8VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViA2b7/zmqjcpKQT47OR+CbQgoReU+IRYYE9/YMJ9LIfO8IVEi/5HMB8D3D+EMSpw0WR9FqjudsDH6@nongnu.org
X-Gm-Message-State: AOJu0YznanorCjOYyBPRqxpiIXtco8tVbSARh5NQ0n2cMmLx+hzLDjzX
 V76sR+9VDMa7wFcY2Y0Pu+00HfcQD7X3QXdkSCG38Va4N3Iyh49ABisHU1mrWaA=
X-Gm-Gg: ASbGncsdOHzfv4mXU0j2Cgx7ALnvukl7lFzYQ2kNVJBAJZV/DaqLtGP/V6MT05KWSLf
 3Xe5l7b2sG1lxtws4bGk6t1xBSQyUZYVohM3zYo3xOruJt2WrhR2tmuoN7pGk9Vy/OqcfvTAHes
 1Zv+8hc7WRgzGu/EpY0Qp50NR9BKVtsYUqIMA0T/bQyPtLdO39/VtK3absfJa3YmbnhPRwCRaZV
 313oNLNsK172ra88QT7uADaBGoyBh3hB/V+IOTGBd+rA7bPJghrcm+cJypXj/bLbRx3dO9lkpvE
 ZF7rEVOMIcdnvg2STcF39dngDjZY4Q9DHm8cerY=
X-Google-Smtp-Source: AGHT+IHrL/gbrZ7qeCpjwX+L4jX6dseVhXk+ivtVxdw+byMoh55OK98kt5zJ4gWgKM1SiMNKruVHBg==
X-Received: by 2002:a05:6a21:2d09:b0:1e1:6ec8:fc63 with SMTP id
 adf61e73a8af0-1e5e046520fmr37480636637.11.1735248422833; 
 Thu, 26 Dec 2024 13:27:02 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b181b62asm12246388a12.18.2024.12.26.13.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 13:27:02 -0800 (PST)
Message-ID: <950a3db5-04cc-4904-87e2-ffc32bd144b6@linaro.org>
Date: Thu, 26 Dec 2024 13:27:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/23] target/loongarch: Use target_ulong for iocsrrd
 helper results
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-5-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-5-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> Those results are all targeting TCGv values, which means they should
> be in target_ulong type.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/helper.h           | 8 ++++----
>   target/loongarch/tcg/iocsr_helper.c | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


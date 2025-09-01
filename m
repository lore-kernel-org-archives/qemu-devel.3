Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300ADCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszTI-00031p-6I; Mon, 01 Sep 2025 04:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszT4-0002yj-Rd
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:00:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uszT2-0000X7-Hm
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:00:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ce47d1f1f8so2690645f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756713640; x=1757318440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OJnl9FKfwvtyKbyxYioMvx+hQ4+rrUXC1uZFIxOPbfY=;
 b=KX8Jgi7xY0gZZgyG+z1hVI5btaOOjbPwe/2fpdAladtRxhjDpd+gpIjyAhDc3voc0C
 4q1C0YQxz5vAZxuFcT1sxBLFkZBtnZNbyi+buxXoainf7p2F6ggLsVsqIlEhgHeWuKLE
 tfgtD51hT8w0jsySwqwSVOuRvNigVaOQ0xDivHQhOAuHTqbI8yTzRlxeD1KNlxXUTboF
 FlfMCiAhUL5z3CynB53LRfCuZEuaC1kqwJGbmhMsRVm96Uaq+Oy3jHyof/csECWguMeC
 rlUO7pFFWRx3Sd6Spq/BcUNktmag68yCVDUK70yY7lJ+BcEUx24wD3BqrC2VxfHC9sRn
 0Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756713640; x=1757318440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OJnl9FKfwvtyKbyxYioMvx+hQ4+rrUXC1uZFIxOPbfY=;
 b=Q6D1svbWPHUTX+FoFzEloym+ZhQ9BHj00WuHkB98/UKza97dt4hoS4XFP0UKSTwV7F
 yg+Gkr0hQJIcX5LZqkZu8vZJkVG/bX8TQlsDadR8+kgWOhuM9nkk8oRFoGXYm9Z4K4Jx
 29SR7Sm1KNpfmeglIecTD0fY7mCncTijrwiZlqlpG7v1wJPQJhLo54ez4CBgaXr9Zm8B
 E38gs7ciVE/9JQ7Y0td1o/JfK6jlYgt4IGm4eE2u+tK92xFPP3wdcyXj5/cbStEwELOj
 qRcEkqFERz1iO9d6XMJN5CCs/y5Rs/cSNvhfBJqJRRuYg/VC3ISkU/h0xzPpYMBhKiT+
 wtIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXttOKztRGsnY9apT2yJu3fMaFRoXhpWJty1093FGxLfakkRkFnI71Jqq9c5+1mPuCP56j9R81QDsRB@nongnu.org
X-Gm-Message-State: AOJu0YwZq89jkcD1wfxjEzpnHWW3gebDn+/cBlXMDxhgaJglMVM3Z9k9
 9WIvt8cGatFf+ZGWZ1HWL2fyVHd3o8LKewWblEaLorM+VhgZrCJ5sUGUiQy0W8accK4=
X-Gm-Gg: ASbGncv/rIaBhIlKauWpw3DryDoIqz6shfDUd5IZWYA7MtVJYyMIJdJnIYOEqBTKa+P
 i2qGKjBdy2FwW/RPWd9mbYw2ZOC3sC/1din6paJqYWhY20MzHQi7mJSEFMUQ2C3HY6xUhgWW8UQ
 QuvIq/Jm0WJiSLceRkTrnfSpHs7L3UwxAvwQL0AR926au5MAM2Owf1YZJJ80LpXtcAzrVuCdu7+
 R+fub482SICj76pl7CS0et5bpntxqFbjIc8QOq1BP7NJtax0uADLyUQBDRQ/6dbTK8X+K7TFCuk
 SzY3t7CXqYO+mndTPtWGfpOozxSgdBPyyz1MqIjGKLP8CLRPMd5omS6Eet3v/cZVEX2XzkIeKYF
 ++vZ5GYlIIeTYYueUSbFLJCWtrrkTfrmjQns3MnuWKdr/IGBh2fHc6bLd2yRQ8KiRKg==
X-Google-Smtp-Source: AGHT+IFazF8p4eqS6Yd6Lyz9XUnUdePML9k+9Mbrs8TI7jtoy5ylqe+OTFXJtFSAOuJukOvrACVfAQ==
X-Received: by 2002:a5d:64cd:0:b0:3d1:9979:dd48 with SMTP id
 ffacd0b85a97d-3d1de897d76mr6101286f8f.39.1756713640283; 
 Mon, 01 Sep 2025 01:00:40 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d85f80d8casm737246f8f.54.2025.09.01.01.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 01:00:39 -0700 (PDT)
Message-ID: <8197bbf5-7a50-44e7-bdb6-9bfc104ba0d4@linaro.org>
Date: Mon, 1 Sep 2025 10:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] cpu-common: use atomic access for interrupt_request
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829153115.1590048-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 29/8/25 17:31, Paolo Bonzini wrote:
> Writes to interrupt_request used non-atomic accesses, but there are a
> few cases where the access was not protected by the BQL.  Now that
> there is a full set of helpers, it's easier to guarantee that
> interrupt_request accesses are fully atomic, so just drop the
> requirement instead of fixing them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/core/cpu.h |  1 -
>   hw/core/cpu-common.c  | 12 +-----------
>   system/cpus.c         |  3 +--
>   3 files changed, 2 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



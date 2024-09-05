Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB991CD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAvo-0002MK-K8; Thu, 05 Sep 2024 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAvU-0002J4-6U
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:45:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAvR-0000YZ-R3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:45:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374bfc395a5so404616f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725536720; x=1726141520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CCOEC+mPWkmzrttYBwXr3os/UYAujQdylT9RM79BFE=;
 b=ZZPFGjG/wPbVPnU2j6iBfqKvI63iRBSrhfwxzMD99BBviQAIGt3qfL4XV4ttn4Pb3L
 1PXsariaCUqyJSftBeu7BI3nOYWP10rcwSELG/Mm39lFiPhyohIiwqu2A9I+batFx++i
 vth5xCEDpivXELh/IFEMbVvyORTI3xdE9JZ0ZW9KJR4I0Te3PKgYRq4IcTMTSjY4e8BF
 FGzEoegP0I0Bna/D9YSO4N1+GkKNEXJDAWrcL7BRIHnMp0lw8KyEP6znLrXVlLi7jvqz
 VSTT/IwYXjVpDFmipD63Rq3TN5QathbjLyziXAJm8X5dR1PhljAd4V2Dn9kMGgmhxhDI
 Z6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725536720; x=1726141520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3CCOEC+mPWkmzrttYBwXr3os/UYAujQdylT9RM79BFE=;
 b=qnqZkxo8Q3FSxxyn5ry8ZcmXySLefLFkanhA9ADT4vtCJ4gjBVMXIDbYVmghGP3NGV
 Lhw5qy7rKmRdYI5lsSiDNc3SshX4YjrbfdJ3UtbF4JQysdPaiyXEY/6Tebec21ZMYycd
 ad7cJ4mKAmU5ydvsp0QKmbJEWAJI9kFI6J8RahFFOaytFtBwb6rKQuMQz8obSYwEKuuZ
 TKhEI359SLhlMdbjW9g4/YaeOOFofbt3Vp3I4L/O+dBPLYiwQdI6dQ7pl6OTBcFANjSs
 OfvanvGS/OCIV02Ydza1ktzRtBF1X6Jwj2pFiYABrK2U2U/nkjV6CENA/jry7ZCq/FOI
 rp4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfbQBASuWuuJUtSrDJNUB4Sz5xaErmu+lnyqdHl8/z+0Kuel1G2Syzl2uwrdpUreua5bXWWvYGMsrx@nongnu.org
X-Gm-Message-State: AOJu0Yzfplh3A2ZjnpKYrkvVrDOSjJAvapJKYCjXimnb9+I6+hjEroi7
 pnbQi4p3Gn9dzWV09lLl2Y2EawYYlOpmiSAPGxmqTf0/3P7R+LrfkbyBe+DutuM=
X-Google-Smtp-Source: AGHT+IGxj1Pds931SdrA2qa+2/hhqdR+Vr6GFoy49lV3LIrBGB2MOz5jX7d9R9loEcvXbLdjhAU5/w==
X-Received: by 2002:a5d:4288:0:b0:374:cee6:c298 with SMTP id
 ffacd0b85a97d-3779b847ba0mr3312239f8f.21.1725536719594; 
 Thu, 05 Sep 2024 04:45:19 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c800554d6sm149337535e9.43.2024.09.05.04.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:45:19 -0700 (PDT)
Message-ID: <8e593b82-f0ba-4ab4-bff6-4c1503b49747@linaro.org>
Date: Thu, 5 Sep 2024 13:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] deprecation: don't enable TCG plugins by default on
 32 bit hosts
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>
References: <20240905111153.786500-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905111153.786500-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/9/24 13:11, Alex Bennée wrote:
> The existing plugins already liberally use host pointer stuffing for
> passing user data which will fail when doing 64 bit guests on 32 bit
> hosts. We should discourage this by officially deprecating support and
> adding another nail to the 32 bit host coffin.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/about/deprecated.rst | 11 +++++++++++
>   configure                 | 11 ++++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)


> @@ -480,11 +485,13 @@ case "$cpu" in
>   
>     riscv32 | riscv64)

We need to split the riscv64 case.

>       host_arch=riscv
> +    host_bits=32
>       linux_arch=riscv
>       ;;



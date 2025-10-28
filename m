Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A3DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDe5a-00038v-6e; Tue, 28 Oct 2025 03:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe5X-00033h-1B
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:25:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe5U-00047u-2W
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:25:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso69344845e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761636344; x=1762241144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JupiA+gDKZLA7RJRuS5xjA3ZsmuH63BVmHdFks/ehbk=;
 b=fuXzRuzRqi/+pzV6D/j4J+oNZwAOmKb3qowG2ZY5z/oZTpK7/Al6owtCbbY91CB8Gh
 /5J9/zxToxyhF2vMDWNkqEy+D7iohHQHVE04qQ6mpE1bmhGb2pTyo61cibaVtj+rdl5A
 KlLmAhFLiq2j1mRS5IkCzsvfBmtB4c4Dl8kARX/L/v0I5VcJmHJyhepeBKpJlKZSqC0V
 cZesrzcb7k8thDDmjW+al3wymUW3AYYNjC2bDHyFAePp3nc0Kpk9o4LboCllA0wi5pBI
 2z53bBOgaefAnUqeZx9BeQ79OIaqCYNz0RMcpSv+aHj8h7pE+8zPSdwzT4Uu9ewGhsXO
 d0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761636344; x=1762241144;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JupiA+gDKZLA7RJRuS5xjA3ZsmuH63BVmHdFks/ehbk=;
 b=CvDIz34scRvqVAcLA2RsILExBR493Tjm2CXCuCVy1jqEFAX42quiHVK6yMB+oAGGsX
 M8wFkSUh1yWlosNbKQJrDEBzjGMYgEF5ZCLBKj9vY5S3S3fkM7meoqSqTZ+VKlLbt5GZ
 YVDsO/akv7vSqntw2XUIjqfRgNKrIwiK+yQIqwpcGlUzFMq5DJovY5io3xEi3MwF9PAn
 BPUJvSJ9S54nJnTeqb4Ch0jKfhG4sViDjyFpAKnsxBx7U36eZ59uQG3hTEfEwi0l+N+q
 RXdF/9LsX8u65hgP6SP0QO6zFTC/KNmweywAKKg3dS7WjSJQX69pyDK1NzhCXAEunvt8
 c75Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMt2r+Suy0k4M4ZeNp4VlXBCxe7ffV/Jjr5J3DIvy7FL9sTPIWcPFc3lsiu9FrPQ8ERdSwylGuKBrn@nongnu.org
X-Gm-Message-State: AOJu0YyMLJGhgtH41R+FMTrF0eonviLiVOOM4uqQ8b3klcE/cfyIWJD/
 58LKZWd9eT58he/jvmhNcztc7M+Hxbu0GSUFyoI+NOCcSn1+iAxjuO79w1e6/kpP6LA=
X-Gm-Gg: ASbGncsw6xcZOH+kHbdvrJHHkvju4FIcaqZZA4OzRkC2MaXPvC5nFRvH9Xt21JWE9zT
 ofNpygleNNWoupzEpRrws76rwZ4B9Dek3vkZyNhFBfqhQKx0Lr7fQHO3PrK+ZhXi7tKnm1DrIh4
 ai/vyWJPu+kR7Gh+Fh/Yn442lsSPUsxhJLnEJ1MX6RWbcZDS7koKxvtquU3f4YFQkYoJVU9xsdr
 rJJcIlHpafHu68nPqBdTgR2urTjwYh/kIqd48mi40iw66bWIxMXz0/nbyzTQyiVylCSfADg+oJb
 5ITCHfy5OYB6yPeh84pQy4iCvS45H2Y6pAsLl9KUlTX5hFIF2nWWk+rMDQh3Ar3LngRkQFQpyNX
 BZMIJRv/k8vyayOYu8pId5kINgO7xSa+UvmVLZAdmz1ftBXZEU1zmyOnTT6rb13q+JVU3TDSaif
 P+Un3GxBAaXRLIhmnpCFCfR5j/GHcil1GT7MVRX8Zav4kqamvz
X-Google-Smtp-Source: AGHT+IE5fz4l6rThrsyI8MJw95C08bqTc2VmoMjHdubXWEex19N7EQkEyeyQeWr3yHMrTeTYx+N3yw==
X-Received: by 2002:a05:600c:45c7:b0:471:c04:a352 with SMTP id
 5b1f17b1804b1-47717df6bf2mr20216575e9.4.1761636344608; 
 Tue, 28 Oct 2025 00:25:44 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db964sm18751776f8f.33.2025.10.28.00.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 00:25:44 -0700 (PDT)
Message-ID: <494cb717-88eb-4243-a39c-62e94f89f285@linaro.org>
Date: Tue, 28 Oct 2025 08:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] single-binary: Prepare hw/riscv for single
 compilation
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 27/10/25 13:35, Anton Johansson wrote:

> Anton Johansson (3):
>        hw/riscv: Use generic hwaddr for firmware addressses

>        hw/riscv: Widen OpenSBI dynamic info struct

Queuing patches #1 (without kernel hwaddr change) and #3, thanks!


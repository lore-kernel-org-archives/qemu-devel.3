Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831ADC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWynk-00081j-IN; Wed, 02 Jul 2025 10:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyni-000805-MQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:51:06 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyng-0000tE-Pc
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:51:06 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2efc0ed41efso2119465fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467863; x=1752072663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JbLMWyii4WLuDBH4R6KEzz2DiGI8f0xjQnRABbj9Teg=;
 b=qn9XpnoKf4UUzeXQaVIt5x3bXs9sDWPibVSCvlHITu3PL1kT/Fnj/+HQ1Fv5ASZbAg
 ID6wmbuqWMAwben9DD8RQdn3VYvxuOuQJSdlXtd7wCqVm1bP3OCOUJcqK7k/bDeXqGBk
 CzCWPfbvoFygqD9rSAS/wZVLfOithwuXyy3j7M4OqMBIuioCbOOTiBzjRIXU+oaB7QGf
 U2eXXjl6jKWh9vdkUXnC+9LrH3aJTKkViOCQyloIWkyGTrj6V1dl34oCHcOmoyoNmZ5/
 OT1KMNUsy/wRAidoOohmnMBl9obOI0UOl8I7ilzHcJ5MigEw1J1s/aqLh0SZGb1NC172
 bjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467863; x=1752072663;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JbLMWyii4WLuDBH4R6KEzz2DiGI8f0xjQnRABbj9Teg=;
 b=pHegA4pVuku/Zs8EmGYaOFNhZj9kuy5mLWG4MRrdUxJ07m7dHbkDuv0uMXdItLInK3
 H18/WAGv9ofMZSJXTwwe5n2E1bMTsUyE8eeG15Nzdd1KFz9Bs/uZdarIhzqLy7tc9qQI
 buCFqj5auAzQxH8sZaMZymvXhkbRT3Zh2Z7KJrPEzeEcl1yiJAfmZgfflEvRNZfnS+Q9
 A9zfQnPNNDa/Dp4upNtGUiejhs8iPyRT564L4xSVjWvI9zNRbNXM8BC3FKnmP4wR73tG
 jkRtcYSWUqMOb5WqVz3im2xZ1QbKda2DaUGtR5/xPXd3dg0Pkit/6V1XAuQvz4a9oMyI
 128w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOaGgdvOB6KqiwzHiPDTT7Z+9NVGbDKNeydRGbOX1hYbJCWR7c6FgQ7khRNdPgIstx9SA4P3ztY1Xh@nongnu.org
X-Gm-Message-State: AOJu0Yzw5CeKb8LwdK4IFuW8f7NoBAtvsbjBn1CGtALYNv2ojfi5Ncz8
 RcI0NZGjfFQH8TgmbWpCzic5MQOz8xLkzIcCwYb/UKhgU2/lZebmMP4U8iC2IdwL8do=
X-Gm-Gg: ASbGnctU5L7IJCX8kQGBU9Osh/OPJmfImKkvWZTYQtsX9FRANAIrNogRMTLNlMMU0hH
 1pRLeREtaJytqrZmWtdSnFd9FR+Y+48CIcBOxRLv/ss266qm8/S2Fsz9wMQE6WQCncG9pjVksS0
 NUq9hBJACNpGYA1l7ldDdz0QDT7BqpvMHi3rqIiIbagxUwMEr/WDmmwpUgH84m2gYH8q8im2Gkd
 fvLLG5jSUBgH1qZVfyjziD/PbNjL6X91kDTU1aAk4lxM00Yon7M9FmDSClzw+weFX5mgkJeuFLr
 hz13d3D5/KJJXPo0X8oN+cm+oZGYrRSmT0fcZ59icrEHvHe/MY9I/PEBs8jgu3m2upLWoPJjMES
 n
X-Google-Smtp-Source: AGHT+IGa/mnqoJ4ZMOhAJvkFWhTEKC8CoegDS4OX+ND1nmRAcBHdVK0VaObLljYHtHsOvH40PNS3TQ==
X-Received: by 2002:a05:6870:558f:b0:2d9:3868:b310 with SMTP id
 586e51a60fabf-2f5a89fdb15mr2152833fac.11.1751467862780; 
 Wed, 02 Jul 2025 07:51:02 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd513db65sm3959401fac.50.2025.07.02.07.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:51:02 -0700 (PDT)
Message-ID: <ac66a368-f27f-4efe-94dc-ba59ebcef8ba@linaro.org>
Date: Wed, 2 Jul 2025 08:51:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] target/arm: Fix VST4 helper store alignment
 checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-11-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-11-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the store operations in the VST4
> instruction.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


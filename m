Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A02C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 17:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9TJ3-0003hm-SF; Tue, 21 May 2024 13:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9TJ1-0003hP-T3
 for qemu-devel@nongnu.org; Tue, 21 May 2024 13:29:44 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9TIv-00019h-Gd
 for qemu-devel@nongnu.org; Tue, 21 May 2024 13:29:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2bd6ca8742eso465553a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716312575; x=1716917375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SDVZR5XsRniUoANDHBoo+NxNkLjtTS9QGC3g3OV9OF8=;
 b=C573BvV1H/BoN1I2Cha5+RSEmMAGaNpXH0I9SphCHFJ1WHcptskt/+65l57QoJIeDY
 fc7BFsTjvOiEmzI3UpymOVxwf1LEljaw5DbdgGgcJ9Qi9Q50tE9tQCHF8JD8WdXlH8dI
 6nGAoyhgGk1DFy0z9qmsYE4YEX13gkViDz5A055fNvoIBcIh7Iodca2wu+usTqITjdMN
 m10SKGZgfSQ7MpcX1JVwpqUgidDESO1ZDn5WNNtThCBPJBPps3xrO3b3N9Kuwv1yaUj4
 2haNjsa/TBRROzdaYo++ai0fDwGpli8s2FGvZ3/suGAgiTCRu/seX1Xaesnk0gCcwioh
 hFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716312575; x=1716917375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SDVZR5XsRniUoANDHBoo+NxNkLjtTS9QGC3g3OV9OF8=;
 b=wqWWlBE7T0E/mq+s1ON8oF0q+QKddqk5zoFW3imUR25eFCTjWuLVSUpDVImxVDDFos
 9+wssPgmHZz/EgQZSQWOVZEia3YAK9qHkZ17qAt8wl2EQmc1YuS9cN7NLLy3sPgpnRIq
 juzvn3nmhV0iWkRXDUx0rw+ROcfeedAY3UfLpoqLhOagVwMHlCO+OX1pTdET5n6NvrEt
 5nfMQdxhAUECmSo7Q4OPZhkqQw7p9hOpE3ab28baooRQpLSIj44t7xhP5hDn5fgPlsj7
 pfK3a23Mq15LS362UsePmsRRKDqcpr3X/Ps0h94Hae7FYKNg3YxUsxV9ZEQIMKOdc8JU
 7AAA==
X-Gm-Message-State: AOJu0Yw29TeauOFbFwlMTP5gdmuDtzEelyUAfUNyXhZM0aoUvrMOkBTd
 2/p0WkxUmQy1NgL4F7FGoCa7ikwRWt8DfRJhsR4SjGCGFPHx++AqfeXsnWPdqtw=
X-Google-Smtp-Source: AGHT+IEO90ZAADq07tcAd27yDEl5ApSO40VaBxloo+dYGMKYwP6o0hiPiXEKXSkuLTrYJmTpXWAMLA==
X-Received: by 2002:a17:90b:3608:b0:2bd:839f:7f35 with SMTP id
 98e67ed59e1d1-2bd839f7f89mr5731963a91.14.1716312575412; 
 Tue, 21 May 2024 10:29:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b96f314fffsm14069920a91.48.2024.05.21.10.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 10:29:35 -0700 (PDT)
Message-ID: <f5a50f93-6944-4006-b9db-416c237119b0@linaro.org>
Date: Tue, 21 May 2024 10:29:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] target/ppc: improve checkstop logging
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-3-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240521013029.30082-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/20/24 18:30, Nicholas Piggin wrote:
> Change the logging not to print to stderr as well, because a
> checkstop is a guest error (or perhaps a simulated machine error)
> rather than a QEMU error, so send it to the log.
> 
> Update the checkstop message, and log CPU registers too.
> 
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   target/ppc/excp_helper.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


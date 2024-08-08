Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D520C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 01:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbsBV-00017D-A4; Wed, 07 Aug 2024 21:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbsBT-00016A-Jh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 21:43:19 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbsBR-00084U-Sx
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 21:43:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd9e70b592so4368265ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723081396; x=1723686196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChNPrVzDVRJaeBXvzPvNPEnAAUv7yMAcxPlL89u6Ll0=;
 b=YcnJTubiKmlc41eeDvcKrXeyZXeRqdAc1WVX0EdikT17McAsz9zqqowrRGUr9ephuH
 hE8ThJGLplU8AzKA9KbrLn9fdXet7kQFXC2FiXfpppLNNzVMCQKvKTOBcLTy/GpJCkiG
 awL6awYeGsIVrFIvUbXSooQ8Jg5YU9GmcuZhctJV1yKg1ZsZP69ZEg5SpdhRLVr0Loxm
 FFtaLx+wCfTvIEBjOk5x4iR6vuh6Z+LaAxL/86LdGTQ9bm37OOEsOArHUh3LLlhOoK/+
 RDycISwnDtWt0pw/8Oid2hm/K8GVLqkdPZJck3KrJnZriXSNT5bokG9NbmNBgS4UdYH5
 Kv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723081396; x=1723686196;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ChNPrVzDVRJaeBXvzPvNPEnAAUv7yMAcxPlL89u6Ll0=;
 b=OsJ4TUXXTTYQPrwbZo3zEQH2LzgWfR9BFgIwfwnIpnQvdzlGEhduVheR0AJwUs2oV5
 D4W6/H5YY1UHI3hQ8VGEDSGCAmHf5sqAw2Ed0fFcl4WLjSuu5U03qg0wnmg/5Ebs6G7N
 5sbPcKu+CiEDwnDwVjDlPJiXtSAWyQXN8slrBSNMIEswDrkEx3CW5Fb93O3ohvx6TXzO
 tMUcu2Q3775PBVX6MJIYCxShgha4Rg4VyHF8W6u3uoYqyxcBvgSZDRPyRebQi8aPN/4c
 cLUpD3RU/BaCrPwQZWfoXlqqw5zkHLIpTgK8BfU1HbPNitpPv9+UZqDs5aszVKHp2DiA
 JHtg==
X-Gm-Message-State: AOJu0YwpFSarbFCBhlaNT1UoNJyk29/6HTH4+ikcM43bdnKi9zWNR0mH
 lM7rOREtdsufZ0/Q7XJvR2RBdwv4snN11ipsRa+J0rtexPWTPV6bzzosWATzK1xPTOkBZSZ/m3t
 0xYI=
X-Google-Smtp-Source: AGHT+IG1zAPU8o63tWE0Bo+4nVoX/mIbAVMXMxchRD4tVIa73H2/QVpvpWbWs2hy89F/UaF1rTRVjA==
X-Received: by 2002:a17:902:d487:b0:1fc:5f3a:4db1 with SMTP id
 d9443c01a7336-200953c1eb8mr4547655ad.57.1723081396086; 
 Wed, 07 Aug 2024 18:43:16 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905c86esm112824795ad.168.2024.08.07.18.43.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 18:43:15 -0700 (PDT)
Message-ID: <ff7d39d7-ade3-4f98-8218-0637ad11127a@linaro.org>
Date: Thu, 8 Aug 2024 11:43:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240807230629.31520-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240807230629.31520-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/8/24 09:06, Richard Henderson wrote:
> The following changes since commit 6d00c6f982562222adbd0613966285792125abe5:
> 
>    Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2024-08-07 07:09:37 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240808
> 
> for you to fetch changes up to 682a05280504d2fab32e16096b58d7ea068435c2:
> 
>    tcg/ppc: Sync tcg_out_test and constraints (2024-08-08 09:03:35 +1000)
> 
> ----------------------------------------------------------------
> tcg/ppc: Sync tcg_out_test and constraints
> 
> ----------------------------------------------------------------
> Richard Henderson (1):
>        tcg/ppc: Sync tcg_out_test and constraints
> 
>   tcg/ppc/tcg-target.c.inc | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


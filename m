Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112A1C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 13:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9liu-0002gk-Qy; Wed, 22 May 2024 09:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9liq-0002fX-HL
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:09:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9lio-0005eF-Pi
 for qemu-devel@nongnu.org; Wed, 22 May 2024 09:09:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f082d92864so112932055ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716383373; x=1716988173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxE9SGPuBj+sHzWVvurngml3GL9m86+/lAAXaTncYZs=;
 b=WK63KCtmWUrB+pzKbpN7gwxXHzIUdkmQ3hVRT27vVIpTq/nv+Ryccx4KEUosjHT8Il
 kcVkxCyAvIEi6O/aLjKEmcrE9XBCvDkBG9jET/7pqKUuW962xSusk+2yQIlCirdlvsC0
 8NTNtoHmtMFsms9sScYC+bR9JHM4UgJM0fliDL7ae/IihtR9ZERxT2r6uCNkovQVa3Oo
 KY2qCBeIMSK3sRknl2+4X6ogDjvWiScpDPmfmgUqfVmJtrgYok9oIoDTCOzHADjoHYeU
 ap1hRApi2NQdlLhpOeLK6cLpx8HDMjLZPpvrfwcW5gxEjIhTPyWL8eVu9z0m6KYNO7eO
 cOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716383373; x=1716988173;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxE9SGPuBj+sHzWVvurngml3GL9m86+/lAAXaTncYZs=;
 b=nOAZfgF2vsTMntJhRRPXNzqF9qYsdU3QPhfet3l58zQQPCU7cP5a7txHbVShjnCSxO
 7l+qlrbss68AsB39P8ZVmLRDmkhDXg8rMXCdM6rqxe/SFgb+/e8ahteVCrTIcjrzOu1j
 cqsz/9NZBPYQHHjZ4dg4qtdfw14aoQeysx4XQ4kbDXneSkGc4F/zq8udBP5/ff7T1f5p
 p2YcvsuD8c/ANHlGtAhCAYRrxtKwJNtDhTxSzWcOyLYJirbyAz6Kst6Ex+DJ7X8hcMe7
 Jay9TE8OrVfnf90mc2aO7tesxgp325zk/V1n3YbxKtr7eusIcwV+qDFHhDSaaTAn5Ysr
 iaFw==
X-Gm-Message-State: AOJu0Ywe+vMrpwrLHjaCyOtqQULLXwYM/s61XFShc13G+2ky83Y4h1bd
 pCEy3qSMBPKRgPk3D0YGyz6egnI8otMyoz5ULv5DiIbiLWoyAf7MtNFV+C7ssPA=
X-Google-Smtp-Source: AGHT+IH7IKn70K5wEbaFzOnPiqy2fHITpQTgqxhT4iIWkkrEExtBGOe6dF7/j3ya+p6327U9Am13pA==
X-Received: by 2002:a17:903:124a:b0:1f3:aeb:3215 with SMTP id
 d9443c01a7336-1f31c94f3f8mr18603435ad.3.1716383372808; 
 Wed, 22 May 2024 06:09:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fa78017csm61578415ad.302.2024.05.22.06.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 06:09:32 -0700 (PDT)
Message-ID: <969a7812-b963-4457-98ba-05abe2f8f432@linaro.org>
Date: Wed, 22 May 2024 06:09:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/ppc: Add PPR32 SPR
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20240522034117.90603-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240522034117.90603-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/21/24 20:41, Nicholas Piggin wrote:
> PPR32 provides access to the upper half of PPR.
> 
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
> v3:
> - Don't clobber lower half of PPR.
> - Add spr_load_dump_spr (spr_store_dump_spr was already there).
> 
>   target/ppc/cpu.h        |  1 +
>   target/ppc/spr_common.h |  2 ++
>   target/ppc/cpu_init.c   | 12 ++++++++++++
>   target/ppc/translate.c  | 24 ++++++++++++++++++++++++
>   4 files changed, 39 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


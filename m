Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D150D0EE13
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 18:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNxgc-00065i-Ti; Tue, 25 Nov 2025 13:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNxgX-00061T-SI
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:22:42 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNxgW-000142-9U
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:22:41 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3436d6aa66dso40290a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764094958; x=1764699758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+57IBG1oBFB4aykD2pVzvombKTcbmyKJqoBQuGt+phc=;
 b=IF8Y1C6Bd0VaPoJXTN/ybfyXcWdPx2P78F3c5UttSnJyjcSKjqbcYVNwNqc6X0g/I6
 rNRaRCQ22tHlPXw/Kz4ADApZfJ8LvOM3DPiAu10a06Rho64jx17EXWHAHIEvTHSOFOnu
 A0/RuNVoDVEaY4Po/qiAuPCh7ujgle6mp//Mg+9ayIeqkHPiJCvFOlJVJG4SKreDNfRz
 bsA5Ny4lFkzqFJtbt4hRsyn70ffZEVJEuJfqXnXOE6WWJNWA+Jhaeu/tucogDYVlcE3W
 mht+5Fox6WFdJt3hwg4L3BbaSnHJgvhUE1yoqpcBJjIPIDFOIS0zOhOKpQmR8/cp/u84
 uqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764094958; x=1764699758;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+57IBG1oBFB4aykD2pVzvombKTcbmyKJqoBQuGt+phc=;
 b=ovCOWvOApeHM2Ercn3FT7un86RaJqQGY1yVLUk7ITEnQkPK76TjkoJ+k5WdF6QK/Gl
 QEgAUf5QFVvmZzPmTGCL5mAtZhPemL7vI35UKPqlkWGyE+UEogbDcEmOsm+mJHrLPh5v
 Qlcrq7610s7y8FOHwK9isH4kMomre9uTwMUG1mrUvHlEnHlEX8pMse2rA52lBJkC1Q1M
 UfixC71iDbIIYJuJhpc8PVXTc0JTa47Jn9NynqUntmX9X2A63+gBZuYTo8w8WZr/ubHJ
 R33ZSnTYbJ0fNUM7FEyqSjk2NNRxukyh78BjrDHT3BhgBmZu1YcIqIy8694dvmjZRjAI
 +Baw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+K0MBIKpG+G0LVdknEcfmEtF/8ZJMkI33+109RuG5vr/dV7Uk/wfyQahOO4fDhM9uYd+UaucJ+Q1A@nongnu.org
X-Gm-Message-State: AOJu0Yxqv23q5FlICL0L4b0axVWIQXnhJI4suBcqZFMsEngGHNdEZFmq
 5HZVNj7yrs2ErNtQHWsOXb+LN7K7OgfCXT+w8V4da7TeroQl4vHcuM4gATlfdGDStuA=
X-Gm-Gg: ASbGnctEpU5GhftMA5iuaujlt0MJBVRhqSlTe+dkmrGLUhvE5R5OGRuq5UsmUbst/DL
 JVMi3sE2dvRqIcvJHOjzXI1lkcv544c9L8663Wd6zAs5AUUGxqN7JfHDZ2DSGK5DEirnhqUD9UI
 +s5zXDPo+m4dJnqONaomopV9zsevCbfF0lgp8bqyyZKEm7lh3SvSPNzXoWKRPzUMrEgYrY4cdYx
 NMaj0I0hJYCRHg6LbBxuKEpYy5zVhVAMiuyta+lFCsqwkU8AoNstb286yUNHUc27F8JkALCy+k8
 +E3Bw8FII8mODOSbGoaIRc6YLbZNPZv8TsmXzuz2qz679Q6TbZSPXl8NBqtNPAuaFcwfZxVthOM
 w3zLEi14zrhs7NRgsO2XGZoEPbLqlaXJY9mjt2JvahCh4n6tMMHRAj+Ngm4+gfM35ade0422tro
 TnRNDVgcDVOyLph3ej5zVuMujagYl/yCrc5aoNrz8hc/EIm5uH9g==
X-Google-Smtp-Source: AGHT+IEwyYqMD52hXZiyXT+WBBZTs63X5fAsmjjNZvvQI3NR5m1X7H+McfSI1wBqeTWGKkJK8440Cg==
X-Received: by 2002:a17:90b:1dcb:b0:341:1a50:2ea9 with SMTP id
 98e67ed59e1d1-347298c120fmr18992837a91.16.1764094958435; 
 Tue, 25 Nov 2025 10:22:38 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3476a567fe9sm107714a91.5.2025.11.25.10.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 10:22:38 -0800 (PST)
Message-ID: <bdd11307-90ab-47d8-b4ba-3f221c036c2a@linaro.org>
Date: Tue, 25 Nov 2025 10:22:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] nvme fixes
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20251125084725.4632-1-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251125084725.4632-1-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 11/25/25 00:47, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit de074358e99b8eb5076d3efa267e44c292c90e3e:
> 
>    Merge tag 'pull-target-arm-20251124' of https://gitlab.com/pm215/qemu into staging (2025-11-24 09:03:12 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20251125
> 
> for you to fetch changes up to bd3ba0d342318a61ce22721322c56205d5f3853c:
> 
>    hw/nvme: Validate PMR memory size (2025-11-25 09:21:41 +0100)
> 
> ----------------------------------------------------------------
> nvme queue
> 
> ----------------------------------------------------------------
> Keith Busch (1):
>        hw/nvme: fix up extended protection information format
> 
> Klaus Jensen (1):
>        hw/nvme: fix namespace atomic parameter setup
> 
> Philippe Mathieu-Daudé (1):
>        hw/nvme: Validate PMR memory size
> 
>   hw/nvme/ctrl.c          | 128 +++++++++++++++---------------
>   hw/nvme/ns.c            | 206 +++++++++++++++++++++++++++++-------------------
>   hw/nvme/nvme.h          |  25 +++---
>   include/block/nvme.h    |   2 +-
>   tests/qtest/nvme-test.c |   2 +-
>   5 files changed, 209 insertions(+), 154 deletions(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


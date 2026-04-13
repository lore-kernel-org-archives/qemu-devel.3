Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CACDE93815
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC9VG-0004tm-Sj; Mon, 13 Apr 2026 01:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC9VF-0004rs-Bz
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 01:06:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC9VD-0007ZT-TS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 01:06:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82cebbdab08so3074651b3a.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776056786; x=1776661586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fSoNfsSvDYmTGidkH+WfEiZmjKBr48rGJ/dRvhy+ejA=;
 b=GTB+1uYfVm6yyxIJHlpSInjrE08//l3CdlzJdO+XxDYEzvaC2szriE1roAV0nCnsbO
 Coy0DclAxLUU+cc8+Ly9GcuJ7CrYDXpEoVJb2ymb99rd70yDat3KNSMT2BhPYqYd6Gdl
 qsMd6S7qFroQGNF5wWmtJxB2uubR1qsisINxiW7ITbU6E7KlRzWzRc4FbxEhtiuZvxir
 i0iHI9q5xQiniKOS/ISQohk6ePw3D5q+FeiB2xUPr5lmkKAhoetW/cKStKIuC9vroPzW
 uPVKunZMe4DtT6njvUPCMWtoUQM7ki+rzqyVHbZMfuguQ2RzZIDS2YqHQE6bxEcW9/jw
 C5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776056786; x=1776661586;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSoNfsSvDYmTGidkH+WfEiZmjKBr48rGJ/dRvhy+ejA=;
 b=GdSLE167OgogJ3iqZspZpM+IoFsgwuaLgv65GGRnyDK6FogfUzFRVQvxFsaxTdT+c+
 sBAQIbLPVz6wNABrsmTFhamMci0GOpQ8Rroqpzh7iadddSgco6+bEZ/07J2s/zI1Tlvi
 8NR6o5PzvmiSKEhgZ7W865Z2Po2m3709QSpb0q5e2hqpZPswWZokL8j4H3ktw2hv6YJE
 mE+DYvU0rmTdEzSmOyaQwc8F69s8HwCNhHx5Fg/7z+yJ3ZGJWkDsIfS+FoDzzs21GX0b
 ij7cBpmEKtXyuWOSPt0j41W95Vvy6BvE1BT3PW1NT+sIHXno888NOs0ESS3K9+Wcp8n3
 y99A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9surqe54gz8QwCmmfPvINNIj4CMLgyDNa+qoysjSrvGR8/IhXfxHCf/gq9S+feQtJwmffwheJU05r7@nongnu.org
X-Gm-Message-State: AOJu0Yx810SVdS7gSNkIM/9s+4NwhOXamLdpMc7aOttDl/HVqgxZaFVz
 Kcurr+JhEeGpSTP0iNfZ3m0KZeAJDP024PhRmLmJ32DykcJcYDsn3SEsPaJ7uC3YrZE=
X-Gm-Gg: AeBDievGL2NWDZapM82KAfXiQ9Tx8eTBxilwmobIRE9fbLy9pOKmWA426DIiiU6Kfps
 I0pPSnFf4WgEKvojx4klaEJbT0v2uuU8WcSjkoBDoretnmFcnpHq/T8MUlx1f7krPMjhpKNi6dx
 tm8vw7jmYQVIDnq7bWJxLmDGJF4rxESfCW33Tvv/aBp9YbWyc8GHDMQfZhtygw/JXp25e4QoeJV
 yBjuOOzXwjM5GEiYVaCBFJXBMABK83z3knzGj2pfEJL1VNnc5RBx2Y7WDsU9YNMuyCSzOTQ6S9Y
 f0J3UC5QD6uZiRWyDukTb7BTtVNu7fyTZsKujofTawS4UPflTUBZT6+hNpF1r+iQhCtKx+3/38d
 uI57zy+CUCrPCtNZFH6DQXz8J+FswcRTGsIzGCA1+wuQGwJwRaGOA0i/tDoZypvIRhNmN0eHCDt
 GvG/9CMzIaX4b0i0IdwFV900WlxtLCvKhvvC4kj9Yu3ZnLRxvBQnuuyiD3safcnhd6m8V/PsZrh
 iCzZdKSa52CCXC+Ohpx8FJl2uX0u/94z3+od0ZdY9VKaF2TlUtL5q0=
X-Received: by 2002:a05:6a00:2c94:b0:82f:4628:4198 with SMTP id
 d2e1a72fcca58-82f46284fc1mr874450b3a.31.1776056785798; 
 Sun, 12 Apr 2026 22:06:25 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c36130csm9828910b3a.24.2026.04.12.22.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 22:06:25 -0700 (PDT)
Message-ID: <59998758-bdb0-405d-a0ff-83bd54ad5a5d@linaro.org>
Date: Mon, 13 Apr 2026 15:06:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/27] hw/s390x: Reduce 'monitor/monitor.h' inclusions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> We want to make the HMP commands available for all targets,
> move the declarations to "monitor/hmp.h" where all other
> are, and only include the monitor headers in the source files.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/s390x/storage-attributes.h | 4 ----
>   include/hw/s390x/storage-keys.h       | 3 ---
>   include/monitor/hmp.h                 | 5 +++++
>   hw/s390x/s390-skeys.c                 | 2 ++
>   hw/s390x/s390-stattrib.c              | 2 ++
>   5 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B33CD637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfew-0007Nh-NS; Tue, 16 Dec 2025 19:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfev-0007N7-2I
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:44:53 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfet-0000xf-Ga
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:44:52 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so4317700b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932290; x=1766537090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZPuFL848hNwN1C4fWIUNQLlGbr+iiTHYWFhoElYNoHA=;
 b=uif39tCtzYUnB9MRQAI6VtNxBllxm+fcmd+VTdRckxrnJUOSaNwnbZuJLzh/F50wPF
 O531l9mNVDe7MTjXGBvg2lcvpvRYMvheTK1UVQi8VbVab53ZwCtgNxxRwZEHzG/VYne1
 QUZYfZZKPdjot+AmpZzKhWmrnFYFAnmIcv05zmMBVoP7vyJEGsKsVWSb3Ws0MEne73OC
 TPVLotjHoc4x5vgYt71Eg4PltI222oLp9Bjbf7R212i02Hbn8BEluOZosOu5QowoR5ks
 6XTpIu/n9LwDnlhCzzGs2bXkpbUR4+cMcNJM/slYwuNYiHV17A05dgFKpWVaXmDHiZoP
 dy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932290; x=1766537090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPuFL848hNwN1C4fWIUNQLlGbr+iiTHYWFhoElYNoHA=;
 b=PwGUDd2geK8V4k7iKqqaUvB84+qsCvgCaSH7fLzYkywH/YshPISsgCZVj8m1KiPfmN
 EyJzWs25BecuuUlzlwPwNIQDfiXLCUl9+VbkXKfKGQ6Ft3LDoK5Mr2f8ynr//Hy4Juf3
 7ADmT+FVhdTaTPG0w3k3CYRPu6QllYOZLJXyxL9a/QYi14bsN6/+4zJViGOkO5kMcwsL
 iKRrCROiY1zJb/6/zNE+iUgASlvWOxcbwNuwB+pMS7HdV9iVCwQR6A+pib+DktrNUtbr
 01JhKpfs76OCQ22v0RCQVpQ+uJNbIgJH/0ArZklRps+F+UArheC5qb91OLzPiAcnOG1w
 QMOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS83dRHIJJvvM2F9LbyyDsMJFkYUvu1S5b/c6X4uhtiXoFMAmYZRs+Y7gvR4dkcY2liXWZAliWuIxE@nongnu.org
X-Gm-Message-State: AOJu0YwWlBmcU4pCgUwd2Z4y39Ao+/vWMRZASiVcifbPPUEZNJYne0dg
 hzJmgtjkLo/tOri3sc/RcRTuSsvaaMUGCMXj2qEt8iBRqiGMoaxwxbexlSu1Lqzsp/A=
X-Gm-Gg: AY/fxX47bsZ01nDP6cR3cGl00h3j1rrHoyoO0QCpyAJW9UFHcHVyw7hTWlB54lyrAEL
 860mY20lWHRLJQBHbGU2k6ZOHj0dVC8Qsj4Dcb/xYcNskoMyYwqDj/FRpSWyAoV0aKiTQVWF2ru
 it1qegDy8k7pmebPABJvIQsyM6U/2W8xjXQyL6Q5Yd8ct7d+PiGNjcf6+Fz40FyAFvfgThj73g3
 NB3mspnP3932oYh1ZG1s0tRBDB2iJBWXwitDd0zz4t0rGHYSUHGRelfFEqawjfzI6G2x5qqaMQH
 K1otGcTZSv49/y01dQTiFQJA1H+v+y8VZq9ECavPy5IIwV29czlkDyto3dd7HcUN8F6Glr5unoe
 HJw3e20osKc6Q97NV5+ixoCXUaXGWrUWc23AojCSDfU7HFp70PjrwFWNY65wMX/1UaU18T96OEO
 vEZrNfBUnRimiXckXk5Z9wEV/2OBzmW/Z2QYLQVvnFG1Mnf3uD3n11FbOBwLZD5qJ9Kw==
X-Google-Smtp-Source: AGHT+IF4TcGYRc+2yn8q4cTIuGguZ95kdudx6NE0cmPLQjNfoP4pMAKfuxrtLztveJLDMFNuOrzPxA==
X-Received: by 2002:a05:6a00:9289:b0:7f7:532a:e44b with SMTP id
 d2e1a72fcca58-7f7532ae590mr12069996b3a.41.1765932289886; 
 Tue, 16 Dec 2025 16:44:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbc0c5de6sm729593b3a.62.2025.12.16.16.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:44:49 -0800 (PST)
Message-ID: <7f1813ac-667f-4111-9221-3bd61a14d5c6@linaro.org>
Date: Tue, 16 Dec 2025 16:44:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] target/riscv: Move riscv_pmu_read_ctr() to internal
 csr.h header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-10-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-10-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> The function depends on target_ulong and is via the pmu.h header exposed
> to hw/riscv, this function is only used internally in pmu.c and csr.c,
> so move it to the internal csr.h header.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/csr.h | 3 +++
>   target/riscv/pmu.h | 2 --
>   target/riscv/pmu.c | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-) 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



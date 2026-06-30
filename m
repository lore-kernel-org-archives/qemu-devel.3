Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A554C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 18:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wedCP-0003DU-Nn; Tue, 30 Jun 2026 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wedCO-0003DE-TH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 14:28:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wedCN-0001j4-Cg
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 14:28:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-845537740ddso2830385b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782844122; x=1783448922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Wc17ItNgaUDBvSNC3EzuTb8GqF3cZ/ioHshyrcjWxM=;
 b=ArTls1SFEipn4zyYaxBi0TW7I3+qKxT+D5aKmUFeF6+HU8+m9HdNvrpbOPpJaDB2Yz
 RUgu3jGO8z+SD+/kjs4t3OC6ta+IdnQPvfsTuuqQ/SYC0jcc/xOGo9MAOeXCBf592U/7
 5mZotKVC14wlU6MfifFou8Bj98J2NCZ9oFNQ+vyurts2yZymrKKMKh5j0ujQ2iVzTYXC
 QMXu6NK2OkloWY6i0wJgsRVA/Cjzb1IYiEy2xdUHwrPEAH91n+Wj1jolICxK9cHgrsHb
 kH3SpTTmxBuYxRA6yKZzO0Qd7HajuUNTGI9x28HFmGOGXWCV10tqFGLs6JWbmJyTMCXu
 Le+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782844122; x=1783448922;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Wc17ItNgaUDBvSNC3EzuTb8GqF3cZ/ioHshyrcjWxM=;
 b=b+NtcqGD7BQhVNsrPr63EIMJt7QCdydsq//DzjGCMhxdETHcxULrG/waM0U4TuCYbo
 de3krw3UYP0gO2DhaLo9F1FAvecedJGAAesI8Ei8xyiV/vSD5YKXqlZ5Ioi0nT/QgjcO
 +YjlV0n7+hLj88tryJMw1MHblfA3VqCLT0R5Ud6v0NdHjP445m6e6fkAYNuv4hSb5gHi
 od4onzuBf8qE5N3YMthHAB4bRFTPyJjRf/PWvBRRVH6y2znhRzApUYJVm8OIk1Wg8dyO
 V+p+gBfv8PBDo4fW0pIXFIrYlumryNeJyCSCwOg1KiCnwf+ESUKbm10ISraagYYs4BXu
 aoGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOJ0SlV2sm7LY11ekrFjJ6PS0TvG+hTHaql28k8mCVt7FkAyQd+t1djrOEw/ZZ8ad6l5jOB/XQ6Ekj@nongnu.org
X-Gm-Message-State: AOJu0YwNe6LYLk3N38trofNg27Div1/Q5dnYODiJeO+wm1D/J27+CO8L
 ec5PyKIwpykJ1ACXBbqPoLoRVEhUlA79naye2452zK96fX4NTeiF4t+q/3S9qeFlct8=
X-Gm-Gg: AfdE7cmaq15SC78vxZvaun3Gq0ewkTlJBk+1cv8TeviE3X92ixqPrDnIEIi/R3kTWQp
 v3HwgV1/lUQYl4UAYxc93u1VaBFutp0pftFsE4D+qxra+pOu9MImFHwTH4zGJ96RWg+RXr/AVPj
 oGIodHW6GIDFO1dE5gldBbIGycI0OixM3LmoSrPJlOfdBVoQGKejomdx+6ldQwzM77ryUdzqPtk
 nORZwJRDSCdu7K5VgwH+M1U1h3JsoXSTSJgRhuqXJza/1fFg9PjdqMWWcSKIFS9+Qk3sm5cxmcw
 j/ZLAchVKzf9c24eSKNRdv0H3TyhbN8+VEOvRaRz+PiHsAmklQh6w4bOuhtg3iYbXymqh56zXny
 bWGMAouzrdCMKC/afNn8mjfEI/VlKNZcLpO7jGfvx8LU8PCh+8nziwlTQGqiIL97B9KKJSJGpZd
 WcIx0ScUahlDbwsN/4b7/1mHdhI/1+2709MC4MteL8+kefQ7Y/kAzGA0mD9NXVgQCfEsRw
X-Received: by 2002:a05:6a00:c87:b0:847:8a64:29a5 with SMTP id
 d2e1a72fcca58-8479eeccb86mr4077968b3a.12.1782844121695; 
 Tue, 30 Jun 2026 11:28:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8479ff89f93sm2680657b3a.4.2026.06.30.11.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 11:28:41 -0700 (PDT)
Message-ID: <46a6f923-ed24-48ab-8bab-7a8fc9956f36@linaro.org>
Date: Tue, 30 Jun 2026 11:28:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] accel/tcg: use GTree for faster breakpoint lookups
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 pbarbuda@microsoft.com, mohamed@unpredictable.fr
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
References: <20260630171555.114844-1-shivangu@linux.ibm.com>
 <20260630171555.114844-2-shivangu@linux.ibm.com>
 <187d9a11-b1d0-44fa-bf91-43b723063a44@linaro.org>
 <470cc3fdd99cfb62b41ed0238550a2b4f4fc4929.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <470cc3fdd99cfb62b41ed0238550a2b4f4fc4929.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/30/26 11:17, Shivang Upadhyay wrote:
> On Tue, 2026-06-30 at 10:31 -0700, Richard Henderson wrote:
>>>     6 files changed, 118 insertions(+), 45 deletions(-)
>>
>> I think it would be better to use IntervalTree, so that we don't have
>> to keep that second
>> tree of pages.  Obviously, IntervalTree can query an interval, which
>> takes care of
>> querying for entries within a page.
>>
>>
>> r~
> 
> As per my initial understanding of Interval trees, The primary goal of
> them would be store intervals, and then query with point/intervals. But
> current usecase is storing points and querring with intervals? maybe i
> can be wrong with this idea.

A point is simply an interval of 1.  In this case, start = last = pc.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BF4CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCIU-0004am-Dn; Mon, 15 Jun 2026 14:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCIS-0004aQ-VM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:44:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCIR-0003n6-A7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:44:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-842cd900ee0so1675948b3a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781549069; x=1782153869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oQcgx7evKKLBmBw8ftHRuY8wnNoGl5o34dwiaQ1Q4bs=;
 b=LKbAd3K3s53bV5yG9eId+p2A8gpwp6q0gk94nvx+cvw7novSDPYuzbDYwS55Ch9Zce
 dO9KnJ7q39oBwv5NRWdH22NUftZoq47I8dQGuu1zjmYWHeHMVWK/MzI9QwHyY2p4mEYo
 yIJHz/0hpkqsIPREii3Vw0cZzUpPAJ4F3EV5HC0d/2o0r8Ttq8bss3T8HD27evgFeHFv
 eRpfHaSy9vzklPRQT7XFPGQ47hr1vm+EEFMAr1ihGJPFd+ULkjK2JmbjXMgVH0HRQN1O
 vbjBqvCMLHEuvsZdbXY5/nr1OhwQo0XQ0DdNrXMvFtdwPnW3Drm6AT/LRPqn1QCBUCtW
 OcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549069; x=1782153869;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQcgx7evKKLBmBw8ftHRuY8wnNoGl5o34dwiaQ1Q4bs=;
 b=RAchTDgztUPz+8vRuTZ417/9M7JoSz0GiUtBW6/nCgFswKkGS/6JZ3PikXFjct6ttM
 LplJ7T6IFs7a7T/VXt8W/l6Ccx54k4fU86VcoB15GkXHhiwmYDq395AsUJQRxZHMQZRg
 jHLLb6SL7hhyarqfMzenXBLnbjP/2rGSFug/9d0S24i/MaBrjq/N/YubE6EYOrdvFvXx
 +Os1G/T+XyyB/UD1ETR20h/Oz8CVGgY19q72JuuzarUjdpB8ohZlyMXtAMegW4R/1CMu
 Sq6TD+BhsikGhgO9YAZid2UF51nhsT/x85RlMTFqQ5/CmAqEOaET3URvkqanxdRm1Wzy
 CWsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o99wvlgozDXBd63r7tnZ0ANXNl4BI2IvlCfyXmImP/wdlL8PMQcHveESAIji9jf/K8hBEo5HGvtB3@nongnu.org
X-Gm-Message-State: AOJu0YxEy9vCyN1GWBKqnoFFJutytBIKYxLK2XhfMyFxGHzCm3MOxzwd
 q2yCZhR4BgxvZMF5cOpf+Gu249ExtouSxodEwdoD9kbQUVV9CmWjYCcrMzNLSx21ekz8wQ1V3ZX
 /q2aj
X-Gm-Gg: Acq92OHA/ZaqeLBbH8YRjZ0oPIV2gu/589xJjKGgoAfJwGP3y0lfedYABzIv/1IIsm6
 Iff7eJlKFbULJHEm8FvSZ1qriNf0htDgPMtgUfrgoY3rvibh3PdgsF/FQjATUK7lS+WgfnxNqBl
 7xvExYwS4xeZ4cs96VWroiKobsg0zPfm2WTIuZ3UQT1Nf4gZDUNtSanXN16odpWEkJWCkB8A2hA
 ID56NBfiPstzRD8DR6B5v/EJqeCfktKWjjjfg8gzd88MEpukcZV7N9R9t8DrdBLKaGMZ6rDyg5f
 UhRgBqhThYTZ2mTtEZsGimiEeJRZYpeLCiS5BBFeazxf0a1zK4bwrqtnvkSRd/SxrgTb3bB1cQJ
 m+cJarSceqmmih4yHvAOB+uxwCjDvhc4O0Sp5cLQ8b/QYCJSHZhzYcVEs/1gJdbgRp2Eb1ANUM2
 8pMQI+b/fiV09tQqSoS2Q5tOw7g8/HXcgo9fvUkM2QiaYGxcC4Ig7S+7SUtmmtS17zIMLN
X-Received: by 2002:a05:6a00:2999:b0:842:5a18:9af4 with SMTP id
 d2e1a72fcca58-84515388cb1mr134889b3a.18.1781549068956; 
 Mon, 15 Jun 2026 11:44:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b049120sm10863375b3a.55.2026.06.15.11.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:44:28 -0700 (PDT)
Message-ID: <db5e4f3d-5ca2-4a9d-a40f-9d6037e2ef48@linaro.org>
Date: Mon, 15 Jun 2026 11:44:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
 <20260611180320.30320-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260611180320.30320-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/11/26 11:03, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> cpu_physical_memory_read() and cpu_physical_memory_write() are
> legacy (see commit b7ecba0f6f6), replace by address_space_read()
> and address_space_write() respectively, accessing the per-vCPU
> address space instead of the global &address_space_memory one.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Cc: Cornelia Huck<cohuck@redhat.com>
> Cc: Eric Farman<farman@linux.ibm.com>
> Cc: Matthew Rosato<mjrosato@linux.ibm.com>
> Cc: Ilya Leoshkevich<iii@linux.ibm.com>
> Cc: David Hildenbrand<david@kernel.org>
> Cc:qemu-s390x@nongnu.org
> ---
>   target/s390x/diag.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


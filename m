Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3E1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLsl-0005Bs-3w; Thu, 02 Jul 2026 14:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLse-00056l-98
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:11:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLsb-0003Ew-DW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:11:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c9b19bbaefso20554235ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783015876; x=1783620676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pec1rEkVn/cNKnQoOsWCgTWnCb22nCMChkoDstB9hn8=;
 b=lhOIQr/WUS3VoWFfXq0ZRvMrB8+Oqt7E22bKW7rzPH27ibNEvtiiAiV6r7vb7NakK/
 sjMaJTb3Gjf8FckknhsTHYN3SZ0xT3NjEE6qJWX+xL+IyGBo7T1P2p8JZxoDQT0EP+2w
 ZGjHzwX1CaqjhaFDBKzJZb49I0EkwaIFLZz57qNgLaSqxmiDowxsOXNGXdsDOpgg2XbK
 jiVXdMnbI7A6boWp+Y0jelwWl2Crm9j5ecyle1UeKkHwWXqqpUn9zbvuyAHfyqa9vCgt
 pp1mgVqAiDsAFmrx0/OESb4CMRdJ45bygRc01toZqjaETeZWcxgBP3aVPI3rLtE1T8hu
 4p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783015876; x=1783620676;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pec1rEkVn/cNKnQoOsWCgTWnCb22nCMChkoDstB9hn8=;
 b=hZIFfbqJj02R1FByEz7FHG7HGQ+sZ7AF2IWSfaCJubGi5nThu4b48YJiKxsM6zuTpM
 HI8INdwNFTRoBbTuJDrVSH4h4pxgT4LeiqCmIXape/O+wthssOjRq191HhHO6Y7z/pXh
 e0v8dlRyp5HM1C/AxwzPWKw0o4g02r1RRZB6cjsYNQk40M8slOJarj8D5vP3njL3d4Fw
 QqSYrp+ZHDHoqINaVxELjMoTRQfAhuk7QUJIc6VtRm6OX/77YlpytGuUorH07T2mLfuo
 EB+Y29nNzRxhdU0lkDhxv97Fo/AcbVZBQO/q0rzMUdsh4QdPviFqmisESxVtXsltkDU2
 rerA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpr1quFLdS6Luh1mWZ9mGeCoV7A/SqvWjFtKDwC3spCWl7DCzwQ0T/zXjtss3ESGVBnhizzmqXDUy4A@nongnu.org
X-Gm-Message-State: AOJu0Yz3cr7GhSysbVmLDt2wI1VSyi9vl3kC1ElAZzA8P9o+cXQbB01m
 +id0u6VzV81uz4GxpimbawOzWtJ/LqIgD2CVJwtJSp+cwqdQScuvDC979ORd13wuWcM=
X-Gm-Gg: AfdE7cmy+J8gwgCu2YFIaIaMzbkNczZ9I2LRGiw+N0sUNyNgbo3lWK7XfjftdZz4ySN
 XBNLjTcHZIqp6Cbmv81V2RhUuIoU32cZSAU+inxvSomawuXZqQINnB/XWSMXPAUFl1BYs4R3L3N
 bTRHiq4wmJeilEY9INKlp0leW+2z3WCpr3UV22cbb17w0Sh2BPHD+Y30pukU5iUK+85YLz752/d
 5k5Qa7hksUx1/CqzVZGJOSB8cUCfabXRgsh4SrvL0ljJFzxSCcRUSsCZ3LBoqReZkchWaL3wLq8
 BrQIQIhyb33gUvXKhvt8oR/tydx6FgCn9KvJrd1iW+mGe0xVIdtYga1EQU0cz2TpJnPA16eWwmh
 Vc5cR7NhJAX155TclE4BIy8a0qKEDyNl9fp5BX29y+dJLxCdY6OIYGrr4S4JwtRdkBxrs8+OQDw
 I/YbN99i+Q2OxPkvqG/diX3c/MitDlrj9FP+HOLy3asAjjdyv/r1DwAjE2Bw==
X-Received: by 2002:a17:902:fc46:b0:2c9:d55d:2d3 with SMTP id
 d9443c01a7336-2ca7e73acccmr77321725ad.15.1783015875886; 
 Thu, 02 Jul 2026 11:11:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a8dade5sm17298295ad.13.2026.07.02.11.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:11:15 -0700 (PDT)
Message-ID: <c8df7a32-7bce-4bf9-afd7-d2eeaf6436be@linaro.org>
Date: Thu, 2 Jul 2026 11:11:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] cpu: Rename CPUState @singlestep_enabled ->
 @singlestep_flags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-33-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-33-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> CPUState::singlestep_enabled contains multiple flags since
> commit 60897d369f1 ("Debugger single step without interrupts").
> Rename to avoid mistakes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h        |  8 ++++----
>   accel/kvm/kvm-all.c          |  2 +-
>   accel/tcg/cpu-exec.c         |  2 +-
>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>   cpu-target.c                 |  8 ++++----
>   target/arm/hvf/hvf.c         |  2 +-
>   target/ppc/translate.c       | 16 ++++++++--------
>   7 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


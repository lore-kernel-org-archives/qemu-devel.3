Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E85CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtMO-0000jQ-GZ; Wed, 17 Jun 2026 12:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtMK-0000il-SQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:43:26 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtMJ-00055t-EE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:43:24 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36bcbd7821fso3047860a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781714602; x=1782319402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5I7VCxS33zZ3f7R/F9P1rcvHArCZ3sY38LzAUQZTUC0=;
 b=wVSyermffGAqsIBESS0J8aWn1n1kkd/15+2i/cWL/ONvqDUOc6IiXnRnnx0helftL4
 ItkU17QAMrQmVt8gIHeMchF+D6ZOhhHq6xPnocUrAO0QpssppXmXuwTbtNp6DrutkJ58
 JqAoo61upL54baEf5KG4xb+VHwr3QK92MQxEO4TZxd5vh16gjB4bRqvekiFZd725zFRT
 D9IrLOytET+5mACYDd7UonMB+tr/4abN/fBobhfcUB8gngbqum/fSCwTUxMJa5GWHPd9
 Z2rWjWZC7R00ly5eqfHEyolxW00APGLUETUE8jZFMwXkeIGV+Tum6LLgilOGh+1e8m19
 26yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714602; x=1782319402;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5I7VCxS33zZ3f7R/F9P1rcvHArCZ3sY38LzAUQZTUC0=;
 b=sNMiHVVeCmpTP15Zuxt6sy9N5cGEdMqouiit0Bcsleh1Nfqm6MQxUQqyzQAQu2Zkv3
 MAfsBgTn+FNLuDsxOmIj+8T7yYTSXMyYSlNoWrrOUa/UiERxetvdG07PKZvbq2mDhBNH
 MSE28SAnOFfIyC/Av6MtH3rnLCAsv5S1g44TBpw3nfFFfl7pDXNrx9t/oq1qlfvaI35z
 2EMB8elv2TJwYmYXMVvEvtaMaOTgbMWiJ7xtbfDHVTdvMJyftEQIZ4bTBMuPqJX4s8TZ
 YQTFYJhbmC9IN1zX/Z/UfNebqYjwy57agPaUTR0O9Zpj9YAvKEZg+sHvpnrzOeLsqp1f
 L5Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ac5eq3Ji+zOTIDLRXe/F7eVmYJARrOwGi2lkGxNZp1JQEjBCXzVC8eDyzzh1x5l5WxPldQqtSlEeT@nongnu.org
X-Gm-Message-State: AOJu0YxJTJMBcF78/fGwkdosoDL9zMkoXBIQwS/81TCHlSsnXFBQS80u
 EJ9phIh1PdmUFVJN44VB2irT+4qr1suDjghnP32H8NkylFD31UhyDsx/R/0QsYOnv2A=
X-Gm-Gg: AfdE7ckmPNtQfTPBuMpCqfs8FQy3gNzUe8VjPn3amtslxaCRemvYVD7h81oiVmZDvze
 LqAAx7MgIml0hCsRJhPlf3J5PAQgv2Whs/PanTjmZwnVntA/SGRduzQWqjP46cPC+m5DBKrblo8
 CLIsUTZSfJ3ptOPd+c6o21/9swBcvP/f7efJ3aCON99yANwxwWfxLFkBnnjZxw/b9YSlJfDmgCe
 mU64vG+5WwYs6iTlvI1QIwUD8gPrLlgCHDAKN4Hgom3Ym0AXArMlKqO9EEV3Kr/H3EzAfHxIbiV
 mJleTG19xUk92r2Fa2vXMj+OKu9yccwpJuZeMUMbnQGOFlUwgmyPHUE11dzbRruQbNxLxZ+8Eq8
 eZKgH0lwG1GPPUaqxk31en8hZ+iASsvtqvxBcdpp0D3hmpAl8PMwrLkX5scFUpAsGJn4wS35cBl
 qAA3fGZkbbrLh8oW/H3tuKl52hJoXkIYrjYKLE9Vaiflias/rJbQ0njjLQuA==
X-Received: by 2002:a17:90b:5847:b0:37c:18e0:90dc with SMTP id
 98e67ed59e1d1-37c9e8b6720mr4179448a91.16.1781714601744; 
 Wed, 17 Jun 2026 09:43:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8661b5b207sm15112633a12.5.2026.06.17.09.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 09:43:21 -0700 (PDT)
Message-ID: <0edd86eb-1619-46b2-a89c-a5c32013e30f@linaro.org>
Date: Wed, 17 Jun 2026 09:43:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260617164035.70788-1-philmd@oss.qualcomm.com>
 <20260617164035.70788-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617164035.70788-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 6/17/26 09:40, Philippe Mathieu-Daudé wrote:
> Rather than calling a TCG specific method in s390_ipl_reset_request(),
> have handle_diag_308() return whether a vCPU reset is pending, and use
> that in the TCG DIAG helper to return to the main loop.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/s390x/s390x-internal.h  |  3 ++-
>   hw/s390x/ipl.c                 |  5 -----
>   target/s390x/diag.c            | 32 ++++++++++++++++----------------
>   target/s390x/tcg/misc_helper.c |  5 ++++-
>   4 files changed, 22 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


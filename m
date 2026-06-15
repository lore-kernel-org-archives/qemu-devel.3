Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0509ACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCJd-0005Oi-HR; Mon, 15 Jun 2026 14:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCJc-0005OT-7r
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:45:44 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCJa-0004Bx-MO
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:45:43 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36d98c9b596so2405452a91.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781549141; x=1782153941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p5G/70ffuu9tHYT6tbWQS2rYJYVWMHNv0hUZRWRX52M=;
 b=mUhx+zZ+EFzWBFSNktTvkW8+N4RkJyNTJpURE9t2RvwAl0IFQPXZE3L5ED6yju/zVW
 5TU2ais/jKifNHuU1V3IFgZkFVFyEie1J0Xc6qh9T3p8ggvy/QUtfsix8AarlgKXWM1z
 I2sJaMVrpdT5fev2PzYToHPgVz5qU63pJC5af284L+aONmv/ID/pgERhCb0+38wm8Yti
 TUIU5NcDn4l4VHf6BNCEgk0O9wr52Vdwbb6u++ttPccotht5M/O55ELAq2T1Gx08f81F
 hnyvtYsEVxNHfEtDqtaB2hD/vTfGWfNXvNY2VuS3lTb6H6UcoXiPgrWtvtnG96WSQ2eK
 4YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549141; x=1782153941;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p5G/70ffuu9tHYT6tbWQS2rYJYVWMHNv0hUZRWRX52M=;
 b=cxZOWWy+UFK0VFq3BIcj1bdHFojTYpdZzKBQv4lVXhJWoLul+Tz+Bs59fbqlVbgHkl
 brL8XOyiOYxDfntyEwT2zJGoVaLS9O9LxMJWHN57vUk28RQTlOBRV+Qpk8NHryZ4ELQE
 cSIIc/Ba1LlGszE1/x/nDNVId9jVY8+qBrUZ2jYIprY3KK6KsdK4Pq4pCuIUiW8aeJgl
 1yGOC1Vs8bVoMZzqdbL2DRti3xzqyWZyeJcbC6A1y7VPfQFUmus1KWt6JagD8o4rYHgs
 geWjycHHhX0r9C1rNCo2jNHseMPWffiCjL+mkm6Mciij8HrBEkX1w3ix3mSb27j15gBF
 NMbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7AMvryDTh9mPx5Y6PCH4YvYHiMscbsvPLoeH168GVL+uPmgfXZMKdskZbnvUb0LEc72b/DgXPCmv7@nongnu.org
X-Gm-Message-State: AOJu0YwpjTGlJfU+pdS/7z57GLwO9mgKdALnCrBJEUBOoPbs5xJ0uuXD
 ZPY29FmSBieBPyImldILI1r1S3fARoOLZHubfZBY1kj/pFeNYGkpHECBAVOIZJO53Sg=
X-Gm-Gg: Acq92OEBsmIpPIhcKgjB87XwmHboLoftJo53p0NuldBoLKE+CbvTySSIy5vOcrPxrer
 5YvrEL4tTxqZp0ECr+plAWfXIKq2oMtIN/EQ9LEYidh0wzWHyJ/w4YcQXPrOgoIIosNREYj50j3
 S90b2rsyYWk69zth2nHgs7NYeW1bkuilmyOlOaA7l/s0dSR3BCNuR9hFQoDoafTBoXwflPyNC18
 CXhCy2np1gh5AoopvpgaPwGoVzx2bAqo+TZUm1sYzmBSOLSKeFJwq1oRbHTpcnYzlGCqkRgfCnp
 NxjryiLR5bSXgRCJYtBlmYz3J0WcUAY5xD50nG+WX6exiWJvlaDMX4HuWbWrvv3qmXKvU8PQUIu
 V0dTFnZl5PH2giGa7BS++h44bqcIBNaAC3oHf0BUcli8mSMnKzpUIYqY1gugZktUGkox7u1VYK5
 cbDCERNyvTuXj3XR9tq+9prfRXec5SlO6kIkYm0DmPLi5MTDYd5XqsdWzZvq2CdZ0joK9+Kl2e9
 qm0MRw=
X-Received: by 2002:a17:90b:3a85:b0:36b:944b:fd81 with SMTP id
 98e67ed59e1d1-37c5280307cmr550595a91.4.1781549140771; 
 Mon, 15 Jun 2026 11:45:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521cac5bsm344081a91.5.2026.06.15.11.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:45:40 -0700 (PDT)
Message-ID: <ae0b7825-43f3-4783-ac58-e5ff24394c9a@linaro.org>
Date: Mon, 15 Jun 2026 11:45:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] system: Move cpu_physical_memory_*() declarations to
 'system/physmem.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
 <20260611180320.30320-7-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260611180320.30320-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
> The following cpu_physical_memory_*() methods do not involve any
> vCPU but only access physical memory:
> 
>   - cpu_physical_memory_read()
>   - cpu_physical_memory_write()
>   - cpu_physical_memory_map()
>   - cpu_physical_memory_unmap()
> 
> Rename them removing the 'cpu_' prefix, and move then to the
> "system/physmem.h" header with the other methods involved in
> global physical address space.
> 
> Mechanical change using sed, then adding missing headers manually.
> 
> No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


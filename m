Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBBBCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0LG-00065h-7o; Mon, 18 May 2026 11:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0LD-00065X-LE
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:57:16 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0LA-0003JD-QI
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:57:15 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-366139223e4so1274404a91.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779119831; x=1779724631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3mTqjJxlZJwnnxfRL9axHm2FZ0cLlu/pr4os10a7sD0=;
 b=OM/ZuklySdJ/3Gqc0m2sGADNIMH4PEsA/sct2fM+gyadxgAOIqp57o2RYvEpiDGoRH
 XL1ai5aMmKIuPuegn3eGvBOum5tDSiq1ICgfil5zjxs07AK6uUv01xflvaZYDiTKWByW
 nPPdoXn2T03CzZkuRXT9vazZaU/F3wxFqRnl82i85ULi5lWzIs1sNyS2Q8MKfBMAQkcf
 vM2Dd/TSiDNT49Fbn6X3gnUTgj07lH6sGwPUln1nn/zRscEo4ToZRlCFiJCdRI+LzQap
 9MaBJWWyYPDRSRSdmImSQmdEbeKFoLsM3EoZnijYjUkrf3Ja19A2syc+tjZbf226h4QZ
 pMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119831; x=1779724631;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mTqjJxlZJwnnxfRL9axHm2FZ0cLlu/pr4os10a7sD0=;
 b=YfsTZoXsgXKc6ZdxJWjZw5wJrLZ+y+lWy4vtvsmzuysmA25d9p3SUrBWpfPu8ue27M
 6DnhaZ26RYlZPdFhnk+KURaaTi+c6kt0xKW8JLDWPgsCPBpCCk+eQ3hgvJDDteT8g5eh
 Jd0Pw1d7Ve3q9usKNYMlXVjc28DIu17viyIsFIRZP8m/4zf9cQxg1609sVMmjxfrGc/d
 rR5Fytm0XkxUh9vY6Ck694vsIJnPcUgF6W4GvrRGqvif8asr6clmDC+gcjZsqqy7koSC
 8Zhv0qE4ujm0/HuwF98ONdKPG+L9E3BC+WSbILiRb07pEss+6bvpF8HGF00EAowsmYQR
 EPdA==
X-Gm-Message-State: AOJu0Ywlf6/fDYw0uhiyox8xI6d3eIIueC7mUHtvJzm4Z/Tbgh1pYIay
 EEaDnZNxfrhiuU3G6Nwm/pvkdwZtnUpV7MSHx9OaCg3AiAbuu0AzorD5eOAPzqIy7jLPpHjjPyV
 s542On/A=
X-Gm-Gg: Acq92OFkQNpiuri49kw71UBm3pq4iZdNqNpxqFh+EIY+bkejNIN/pnNMqNNcSSSmHFd
 FqXdKX7YLxO4QSFN2gS3HHgKw3q2cW+VNPzwSbLO1ZcBdGPUPoYNhUALqi/VKbXnVI57f23JFUA
 VCn3wRtLGFlC3OO/gX+6ySQ8iM5vuT+2ALmokc9L87ae0mkkxuhzXPuQUxP2CmDlZ1KdNd8mXVi
 ARumvOaDPCABVIlsal+oBdcxDX7BCtX495fuXpXbQbhdfJB1Fj0HioViO4S0zbE31Q3rWISQppI
 dMh+o4H8ODaP5LSL5Axsz9+9r1E3lRlbXKYoCpFO/rqTFJCsLaNGlj0rEw76eCDJkJYw2oaPZ6v
 HRPOdgPCJ/Z3RgiM9vaNC23+o8DFmz2TB6mEB+knNTWkQFamQU467woDxliEhdnlQt9CS09lakd
 HbT7+7jCePhqH128ZWjTfPtE95yIH6z5o9aqUH
X-Received: by 2002:a17:90b:5284:b0:35f:b572:ece9 with SMTP id
 98e67ed59e1d1-369519e1c61mr15150673a91.5.1779119831038; 
 Mon, 18 May 2026 08:57:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517d8570sm12004962a91.14.2026.05.18.08.57.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:57:10 -0700 (PDT)
Message-ID: <6f66af6b-5733-4b3a-b129-6c0e29ad1dcc@linaro.org>
Date: Mon, 18 May 2026 08:57:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/14] target/arm/ptw: Flip sense of get_phys_addr_gpc
 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


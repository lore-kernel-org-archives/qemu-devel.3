Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDDEC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqtA-0001YZ-Ua; Tue, 28 Jan 2025 14:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqt8-0001YI-AZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:04:43 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqt5-0001GC-Qk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:04:41 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21636268e43so131890985ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738091078; x=1738695878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=30OaTN0zqpbntnWZ4GRDo0FRzUkUSiDN7VKoXqrL52E=;
 b=OjW8baYPSVKRq0XHIqw0IjPlzR/iHOCDc0ux+6ho2RJ/DdCFqBuxd9aT25gaMnGk78
 ROhyXXN89ECCcGTrJWs1yvRDBWlK5j9qqH0GnGbb64pTNXk+Kz2P3etq6+ito1OBZLKg
 UVhPswiKsdb0aKENUS7DvaPZLxE44AtxSDEw6e7ZvYSMf/7rAUTOoZGV4QXsZGemyCmO
 lig1v5LRAqLtkW8JSDnYCZPhei2/+8/A8jDaqnwwtTDfZPWcvzCkUrg65VQon6UPlP91
 D/0GRFKhBh2hfYGKo5pLGjGHEogcTiAAoAR0RBVZelLD/+eRSNnuDJjA309+RcjCY29P
 BAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738091078; x=1738695878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=30OaTN0zqpbntnWZ4GRDo0FRzUkUSiDN7VKoXqrL52E=;
 b=v4jcfJpTFX9JYWFYn1xNriy/u1XKbAjtiCH/46cICIUs1UtqTpKLajCz9wNtSeiTeR
 NXuuDRq8UTeayYhfz46QVo2J9a3RQij5VTisy2EIgRWnZSI5k1Z+CTALzabSTLMXSLu9
 bS36Emh134rTPgmC0sVACO+F5pefCurOT0jzXwzkyo/r40mwsUO1S+AC7jiruBnFyJI5
 yHMMKQ7WecmV9NoDUZad396x62TUQ8fehrw+edeVomPqcURTMNCe8b76T9zo/YJES2AJ
 RqbD6aw+1Iqg1xSBiTIMVIwIVANNW4c8SI2mQh6GwZYc8IKklHvYxsqKxs6IoE0z7FYO
 sCPQ==
X-Gm-Message-State: AOJu0YwbdbVSjy3fC8LKm8II2dUkH7w43t9nyK9C3W94UilNZ2vCmizq
 wpqR6dQoisT+//5ig/KADOID8zDFF8c1RCvt7MJRyyZrFqgyLzfaguAC/gljSmSbctGOAnQ4CFS
 i
X-Gm-Gg: ASbGnct2f95SQfg1x2RJRiJWGBW4IW6YNK1SSRFZvcaImVYo2w6rd+0t9bUMxjIpfkk
 xDSYNb+FNwpNGnssDDA6N1rSvtneB3ObNkJJ1O8GWAQvOQoV9cFGbyCxoUgCq87OAfDIVLWq68P
 ZKx40J6PB8gwxRanNTQP4EugQLeGc1soRDgQs6qF5vzbFSpluQDBObYyIMtHdt4PVTPvBiOxMR0
 JK0iXc2l+btNQBytxVMSIEXbvmvIQfE4dnd4NifoZvJtXPGFg1wPVvpy241pHb4cmpaFxjpFEjw
 kyvVY+eoOKBaEt3o/orN0pDVa1x33WSBmY03h47wKWzfpQ+Z00xQP/K1Qw==
X-Google-Smtp-Source: AGHT+IEZTHFBCMSBgFRB3cl0ieVWbCE7r0PnJe7uAX4muqbvNpxefHNkC4CAI6NaTgjB4cvix25DOA==
X-Received: by 2002:a17:902:7c93:b0:21b:bc95:e8d4 with SMTP id
 d9443c01a7336-21dd7dcb1e7mr2628215ad.35.1738091078515; 
 Tue, 28 Jan 2025 11:04:38 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3c9asm85559815ad.94.2025.01.28.11.04.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:04:38 -0800 (PST)
Message-ID: <3040b8ac-9424-4cb2-9c4d-09e319bc4b94@linaro.org>
Date: Tue, 28 Jan 2025 11:04:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] hw/sd/omap_mmc: Untabify
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 02:45, Peter Maydell wrote:
> This is a very old source file, and still has some lingering
> hard-coded tabs; untabify it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I don't propose to try to bring the whole file up to modern
> coding style, but hard-coded tabs are a particular wart.
> ---
>   hw/sd/omap_mmc.c | 124 +++++++++++++++++++++++------------------------
>   1 file changed, 62 insertions(+), 62 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


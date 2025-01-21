Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F051C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNGy-0002pK-Qg; Tue, 21 Jan 2025 18:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNGu-0002ok-G7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:03:01 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNGp-0002zM-7K
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:02:57 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-215770613dbso80778335ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737500573; x=1738105373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F2Ue3DJUp9YPdhwGiaPSVEZNnmnjDuLi8xspfMCsDcw=;
 b=OeCJlfx7Rm1SvW7Gk/C8GVIac8DVvtsRkdjYb+OeSLRITtutgxI8LBenM0x8VfWrXq
 NHiRu9H/Z6QtpTlLFVqWKdmWpmAGdYT2z/I70lo2jcExmAsB6tiWx9sR0iPuIac5RkAw
 1o0KoQ4RvNB2p6lJ7md2hlBl36m9LiBs7ecndLuB9DQGp/vUtmmMREUIB7mT5JuPjRM0
 EVTX4zo8Gank/42vDb4LwyHUXkaS3xYuFmqtCl8yXtNMBIV63Djwqr308zTdY50PDtZ0
 ZlVkCH/4ZiSrOsqK5kqV6GIbVZprfuyXpj6snM6LbvUHMnSCyxZmWKS+fJ8EEMMtb7u8
 gWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737500573; x=1738105373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F2Ue3DJUp9YPdhwGiaPSVEZNnmnjDuLi8xspfMCsDcw=;
 b=T7YgiW+tnmo9PeSdCbO8GcHtBh9hE/pEIVP3SEuTODmZxGH5pG7mmK4WxuJRf8lYP4
 CImIUNnwjjhgx3fHiDh1d8g/rwVaKz5QWNeEltQLc5XnDAuhHqnnOcArVUOrc34Ahx/7
 OmaOdJrIlFFo6U2sy3fRN30jXCMsuIE5avNbN7mF8HcJhj3cMzGOrWTZ2NcrPasdkUS6
 Q+Cd8AyhEewQ0OlSwKFhpPqpgdvL6IDfMC9Lje9Eo6rz18/1ssILcuLsqIv1I9gY/2k4
 dKZDKE1GnGF0vHwDuT/7JGrN+GCJPD+seHtpgv8SLKZEgTiyQ9dZyk4WNqDCRtTsmq8h
 6Vlg==
X-Gm-Message-State: AOJu0Yyg1IbAeHctz8Ga58qRZX7vC4PK6ZQPoWhp7pPdwBX6HodK0Kis
 Mf3ZJOLiL+2nI5hM/LxWpX8qA7MkzSqY99HCuc25aS8MDNNLr+4N66/QsXofRLN5eBawgQylaZW
 R
X-Gm-Gg: ASbGncuUA6Y2yeUdi0SuMbxFnmzutNc6yVM4LCHZCVw6b5me/GPjERj9ihynr4GWiq/
 +gKGUlU2NcVJy2zah3OBmKkmBwaqKbK7nFHPczrA9y74+koBo3Jma+QGQz3tO9VqLUmZinrGOxb
 CSN7iEidc3F0KxXU4YCh6s69yxjfrW4P4d7kKwsDGOPilqr0kWq7aKoh8yAl8WR7quUUYwOLNF7
 SvAyUfRNnvEdsdMmdHeaN58OTJr96Z74Bf1RO20ksyEt1alqbW+D5yaHSNYf4rxUieYEtjfoUMk
 lCKeuUDmnmmoYYuzWDu5Ae0T76ib/NV5MHzo
X-Google-Smtp-Source: AGHT+IFPF1H4nCZ+JAE6XDQeIEiBYxt9UcPYNzaqBwIJMzxoUspf9doCKu81WWfltdr8FE9e0YDUZA==
X-Received: by 2002:a05:6a00:2443:b0:71d:f2e3:a878 with SMTP id
 d2e1a72fcca58-72daf9bd003mr23591501b3a.5.1737500573020; 
 Tue, 21 Jan 2025 15:02:53 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c8f6dsm9455177b3a.114.2025.01.21.15.02.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:02:52 -0800 (PST)
Message-ID: <ae790da3-8b57-4571-abbd-c70260825fb3@linaro.org>
Date: Tue, 21 Jan 2025 15:02:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/irq: Introduce qemu_init_irqs() helper
To: qemu-devel@nongnu.org
References: <20250121155526.29982-1-philmd@linaro.org>
 <20250121155526.29982-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121155526.29982-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/21/25 07:55, Philippe Mathieu-Daudé wrote:
> While qemu_init_irq() initialize a single IRQ,
> qemu_init_irqs() initialize an array of them.
> 
> Suggested-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/irq.h | 11 +++++++++++
>   hw/core/irq.c    |  8 ++++++++
>   2 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


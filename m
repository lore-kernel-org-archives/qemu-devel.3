Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF77C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNGP-0002Bx-US; Fri, 24 Jan 2025 12:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNGO-00028J-3O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:14:36 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNGL-0006Ql-G5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:14:35 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166022c5caso38588145ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738872; x=1738343672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AFu8rllnxpiVVdMFYWTPnHZy3esr/1EOg1ioOr9VZcQ=;
 b=WIVd06L9zhYAomqz6yXH4r1ONin0kStcAo3Nk35mx1Wy9cMntBNfMl0uZfe/4KkImV
 ZQtkum63r1+RmkcBBtJcxw2F7p4O1RM2MaATQK4fYAfcpj/44tVLbHUqyo4LuIsDWLmG
 cbheedNF/NSQIKzwAy23sjNYHZ+/w1+nzmzRCqD5ptsWfT8NII4/4CseNCc2uOYs3pqQ
 HpPVS1jPcPYlfV8USG/FWj/rLODPsDFrqzL7V8sCIni7UM4T5i53MTdypj5eZTCCwzE7
 iPrlYw8GvxB1jiZJ49ox1Fes/TuDa9Z4wUmTkrJ+CpVSJz0gcg0D2FQ5cHOBkw+aPVq/
 4mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738872; x=1738343672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AFu8rllnxpiVVdMFYWTPnHZy3esr/1EOg1ioOr9VZcQ=;
 b=VNa7XIna4MMi1eb1VeloGjMUXuAX8eFzi+JcVR+oOO57+jCmYO0qpYWiREjpSNchuV
 EQV6kshqebKVqm1ixFtv/iH/KRXlZGkFSzIDDttkcJ0J+chkFdl//C3693ja/+65W7oN
 lEuExn0lUUxboC68aB5t/NQE1xXTJ8DUe5QlOBtyaRhIjTZi9TK5z8STUBlG7bgRVHPB
 VTu3NoVdiR5AMLikAxw/o0rYLSBJBrU2m3N1JVD1AxWQGw816gtmDE73Ffhs70kPp3Ts
 1QuEIgVrTgQ4MBu/aDzRPsvng8poaKXAZsywWb7RfLxs2fT8NEADKFymcGp2pL/PVjRm
 bQGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYLXT2EWmoWvV1hAp89ZFRMPC2manmFZsW/OtZwL2/g2k7zw9dz3nUMG+CHJ+qdOELAUcgREASzOHb@nongnu.org
X-Gm-Message-State: AOJu0YwDebvLJJQahyREA+7y6+AM0PVN5sDYWj6Y4Bz1K2TxldBQixS+
 p2c/zx9LLw8mgYOi3njZAOaTGbtKInYsD1wOqJRKz9MVwtYA2SSN9xzAESXKpdI=
X-Gm-Gg: ASbGncubv1itGVREibG7bN0vKeOx2CQbb8WAqXDSWNWVhiizwV0Zk7nHaIgBz0Uo3EA
 tBTwt5MsHnwpPDjAzGCZkNS4Uqur9X24oksnU/vmNP3oydfBFvZD2a7w43B1saJCYVpRAJnjFCv
 kQjgh906JmN0hmqzxWwPMRkFiSHTP9Qw1bm+ceNZu5i7T0lG0fYwhSidUhOxVlhbIriOH7EDg5S
 Tx8nbKw0XOv29eF495cIbj7IXd26mlAbhmJHPynzcTC/OQGG8NyN/mvcHqLzc7EtBQnQXwkoY99
 Qxq+yRmlFchdyg/qfR0v5T2+xykXcGmLWZAvYdNeA5akbxmt/ktYKYNZT3ied0qCGQ==
X-Google-Smtp-Source: AGHT+IHu9ACfQWNCnB3er2Asces8YuUjfs9QHD+2tmjLULpgnpZbIrCsl2s8lbREk4J0729DfiR0jA==
X-Received: by 2002:a17:902:d487:b0:215:e98c:c5b5 with SMTP id
 d9443c01a7336-21c352c9f30mr499254305ad.1.1737738872026; 
 Fri, 24 Jan 2025 09:14:32 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac490cb8bf7sm1624894a12.42.2025.01.24.09.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:14:31 -0800 (PST)
Message-ID: <bc11c46b-b711-440c-9cfc-38c542e45b18@linaro.org>
Date: Fri, 24 Jan 2025 09:14:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/28] target/ppc: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu_init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


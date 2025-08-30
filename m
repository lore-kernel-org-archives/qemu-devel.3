Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C119CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 22:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usTqC-0007Ac-42; Sat, 30 Aug 2025 18:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTqA-00071a-DH
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:14:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTq8-0001Pg-56
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:14:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-248ff68356aso14139565ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756592065; x=1757196865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QjvXCUNJkdbAcPhvpbQTP0iq8cnncj/mdoakrq8WpxA=;
 b=NrwO+e8E1PqxFwEuGzqBSgyDVcdKauUCPV96BxQpZstKBNmMzm30xZmYDKxFIb4LLr
 +gU4U2q0AEcKfC96Vl4+5Of8XOl/vewvZmHs0Yss+d0Fzj9r6qzz6FqMgXOwp2ORr7M4
 vzVeEVt3IsXn6qObLa3SlopAFS7l5hAHzeWahQpd71de7rBTs/xThpGhOZMi0F6CTlQN
 sWnoFaUzk45uQYc60kAsv6LGam5cLOyq0udMCcv6/PoQR3y6icVopCfevy2fWMvPNfU1
 vYxbuKUirVBCl/tgjTfv9DROvdCGt53AXKVB+1mrDyd45Yj9jHE2e35GZaZQatO8fX8E
 2jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756592065; x=1757196865;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjvXCUNJkdbAcPhvpbQTP0iq8cnncj/mdoakrq8WpxA=;
 b=aF6Mu/g6mma9bnuinuJF76bFtv65m6FNGZY49GvtTWgH+P0gMrOdLgUPRSngMNueUM
 QSsmnaqaRKflLPvx02mRx5G8eKdAtC/qSfJyZ+lU94qSx8JpJ+j6VBiI3NDA4h2Ll1an
 FslYWPT74MAzncOjBQyxbVmpMWTk0qk+cm1SX3khy3r09hrrhq8DN3xZ6DtuRQNaBWSu
 isD3M+yGn64DLrluTFivXcQfnoHGHK16hl/NgFAFlL81H5+1joKEwOfKXf571s+TPv2m
 yMqdBOiRqZtUNaGRubNRdLlr4h+sFDo8AwcBJPrwqw9hWTOCpgRBkyC7PkLQpVm52+nx
 F6Zg==
X-Gm-Message-State: AOJu0YxNsGHJfiX23SlCapWy+Gqu6+8cm4H6/w8RaUR0WT+YWib5PoYU
 PHuBl+lEb5V1uS6d+aClQD/jCT9fe7H9509Jtj3QBAi+TzKn98z5RmZplwIMItZdDF1Vew/aYkU
 pXmUknAw=
X-Gm-Gg: ASbGncvM7G1WdcobjPleM1AOufyxnZOsgJh2DFr4uKlnEHrJG70uRlFSymFt7X++yIz
 idJHZ7JrsPHclCy2l9BA0xHwurdBxNw3mhls8XgBUuIgPPqIlLwpi3lCby66IwapqGnLBSBkIlz
 sB+DDQoLAuC8lmxPeAn44SMRpDIKMlNo1mGdM3iHG8y7eB/nDfRIUgDOz7xOlpdvDXCr7lsajrZ
 RtacNt8piGUqiNMx4qDOu6B3BsKDEx4lPMJfrl8mzPqlTPZ3AJLvJYwVxpvKRbj+xxLR/AODmRq
 mfriyYzLGprAkVR/7lSWzJBHS96W//PtgX1omzgnW2ddE7bK9rzImpbUWt6nXfpCjg6sr0OgMPd
 KaiyBax7Xdr6FkcAIzDskr4O2VbwZbtAjs2YibQA/6838/719xvHVQnBq+zBMFLG0b2YmaPmyTR
 Rh/WcL
X-Google-Smtp-Source: AGHT+IHT9h79M6Jh1eUcAbAgIsVNNhHQAIUJEbiqQPRUo8/hu5bhoxm6996K4Kd8gBveWsw6RhP9tQ==
X-Received: by 2002:a17:903:11c7:b0:246:a152:2ad9 with SMTP id
 d9443c01a7336-2493ee542d1mr51450245ad.11.1756592065382; 
 Sat, 30 Aug 2025 15:14:25 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490359f808sm61957905ad.0.2025.08.30.15.14.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 15:14:25 -0700 (PDT)
Message-ID: <2fbc5525-cf8c-4d3a-ac2e-97d2764fc5f4@linaro.org>
Date: Sun, 31 Aug 2025 08:14:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] util: add API to fetch the current thread name
To: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-8-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/30/25 04:03, Daniel P. Berrangé wrote:
> +#ifndef PTHREAD_MAX_NAMELEN_NP
> +#define PTHREAD_MAX_NAMELEN_NP 16
> +#endif
> +
> +static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP];

If you're going to have this...

> +static __thread char namebuf[64];

... or this, why not just remember the name from when we set it?

You could even store a pointer instead of a larger number of characters.  I'll note that 
all of the names we actually pass to qemu_thread_create are string literals, and that we 
don't actually need to do any memory allocation at all with them.


> +    name = g_utf16_to_utf8(namew, -1, NULL, NULL, NULL);
> +    LocalFree(namew);
> +    if (!name) {
> +        goto error;
> +    }

That would certainly avoid this kind of hassle.




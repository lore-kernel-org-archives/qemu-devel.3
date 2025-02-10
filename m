Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76103C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaSk-0000Ps-IF; Mon, 10 Feb 2025 15:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaSh-0000PF-QQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:32:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaSe-0001x4-9h
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:32:59 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43944181e68so15631205e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739219574; x=1739824374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JO28UvwJr0bHz8S59EzQAGb7sFlG/PKWfO3E9TxYgy0=;
 b=QFuOvVEUILUvSeI01nk14rX2vPtFFe3geDTJjwzpLxWEhQ92IT12IFhbfUGGvg0pCB
 EOwdvNgnz7VGqoeZJrnytM/Uv1AUd8DrfnDDc1q5oBz/j8WvZemxq/qO7UAQAnAt1aJf
 KBSEKTRntwBQYazX9D/1EVp3j6D966gSjQEXIZxHQCmZcb/W7cK4iuwOdQkbL523cxi3
 vmiPD/qPCPBfzJ+aKzXwWXV+lds7D/eDMNrO29jaQXIbpiWuiWNe3E1cHs6ZyjCMF6mb
 PFttL/K7JvMcyiKtAKcLYFu6Uvnne3S0vc8tAmsjCLcUVoNDH/PVYQOb86PK45jfa7D2
 7REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219574; x=1739824374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JO28UvwJr0bHz8S59EzQAGb7sFlG/PKWfO3E9TxYgy0=;
 b=b6j/IvwFqWCovra9Bev3xa5rWu7Ha7eqST9Q/LU52Hh5z8k2BPnXtm1V/cOJaCZsp5
 XNctIJftJnReEvA1xpaNwSjQtoEDULnERqjiOJlIC8wrGA6j01g6yN3AU6Vq8dUXa1jb
 qZaxEnQ39DuR3210zAyLH5TLyKaD734Sxs+46zxAsSnx1w/PFni6X/xlo5r1ktzpqizV
 V4/uUF2GJcvNFPPnZyNNOQdESugi6vBFpFEeJAzLpekbPwb2xtbJUu63gVaQuPpzOguu
 oaD1Me6OgEeKTgZ/Bsci/6aI23mwUo/Q/jjoDH7pA4pD7Vh8jofJHqaBC5rvFcaIc7lB
 k75A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAMGgDrRrnzPDW+ax54Ygvp8Sw+GE/5G/AlN4BwuGDO8tjaRO/V+8JuaYQB/DHVuDo+NrvVQh8P/E1@nongnu.org
X-Gm-Message-State: AOJu0YxN95xdWWgl5y8P6mChfnJoz8rGP3+MU0H8d3PFGjTlZX9uC9GY
 1G1i+gWGSaZwSDDNdcn/QL/2+CgY1QDLNNtImsT4k4Fjo2KlRjhSJpwUleMGx4c=
X-Gm-Gg: ASbGncvBUzvHCEGDZW49JjRksq7vhv8tsEPFUltDdusPb2k2VsDofuYnOXDa2MrPlcK
 AfjkujJ+KZp354wu4Yg9f7jrRPXKokGON4vslPFnn2+Y6qxJJxiICp6b2+YH6HBWyuQ52MMTNkA
 Va8JjxitagI+MYHys0a8ECYnGHWABSdWol32KKbusmlXsU75bHnEQZUPt0tUicnMD3uq9wrbkFe
 ndcNQdgppqvXS7SVW8avBWwMLNK8PY/IJRlYOHfk5dUyMe75fHObLWMWus6Myo7LwG13DZySbtS
 XO9mjXECSLSbcFTTgYcgFxkUbZ0lxtTbAFo7OZVYToAKvM6hNWKA7qrIE3E=
X-Google-Smtp-Source: AGHT+IExS3NV9qQORHi+Vx0CKc7kfrgKd7b5yUx3AfwLFU1DJb4NlN+QGXnoJ3sbrJ0Npvwg3FUGaA==
X-Received: by 2002:a05:600c:384c:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-4392497d1d9mr138833155e9.4.1739219574105; 
 Mon, 10 Feb 2025 12:32:54 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dca004esm153571025e9.13.2025.02.10.12.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 12:32:53 -0800 (PST)
Message-ID: <ad2548d0-962e-4a32-8ea2-0af4be45f008@linaro.org>
Date: Mon, 10 Feb 2025 21:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250207151157.3151776-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250207151157.3151776-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/2/25 16:11, Peter Maydell wrote:
> The SMC91C111 includes an MMU Command register which permits
> the guest to remove entries from the RX FIFO. The datasheet
> does not specify what happens if the guest tries to do this
> when the FIFO is already empty; there are no status registers
> containing error bits which might be applicable.
> 
> Currently we don't guard at all against pop of an empty
> RX FIFO, with the result that we allow the guest to drive
> the rx_fifo_len index to negative values, which will cause
> smc91c111_receive() to write to the rx_fifo[] array out of
> bounds when we receive the next packet.
> 
> Instead ignore attempts to pop an empty RX FIFO.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 80337b66a8e7 ("NIC emulation for qemu arm-softmmu")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2780
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/smc91c111.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Patch queued, thanks.


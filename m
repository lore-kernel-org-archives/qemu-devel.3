Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12BFCD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzoN-0004Np-Mx; Mon, 18 May 2026 11:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzoJ-0004GH-8u
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:23:15 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzoG-00080X-Kx
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:23:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so2528350a91.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779117790; x=1779722590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TkE6E/y6DQOhXDaG2aqnXKmzXFeQGCHctZizLtNNkAc=;
 b=mZfIvaXZwwW7/zMcviTtLi6qtBxw3aMjAGMkQnsRdh1iNorxzDR+w4HBnwKJdh9n97
 HsDu3ynvXU0VJ2XysPSdpfdv9duPmNt5H3GiXcZOEGCUei3lHS57zmq6Vi+/oM0K1YWf
 NJVDAI9aLGM4mNKuN5Z1sPrvTb4MkI5hdhA1jfK9xJcXtNK1G9uRo+9vIp2rKyXM1+eo
 trJeYo0xWhRWHbeV4CTVgYWDjg1N8Hn/lO6J4B8IfJZQsjRKeCcau0VQEagKFNBdnXHb
 pfvFXXfxMTbUvPFwCYMuV+tXRDwnv6BNNGm8ZkXI7CCpnLblufo/vleXuvrH0Lq8+8dY
 Igwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779117790; x=1779722590;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TkE6E/y6DQOhXDaG2aqnXKmzXFeQGCHctZizLtNNkAc=;
 b=Ukc8MDsRtdPaBA6rHa9ssFY4tQlVjdjadZyyx/JuF09JkQkk1eVBS/OOuG5XPJzc/p
 CG41hylIcNLIk3GhDJCTy7fOiPies8vJP5t5EIYNJseVMbSyjGTZR7t99hdDMa2pufJR
 6ZvThHTWvc7fv8WwzKSFnJYiEoYfTK5BOOBUqSiF51vNeAO2nPdLi2aUkX+Waai1xxll
 3k7s6CeGH9vseUV2nyEuncyeLOpJzQ3b+qWGxqwkV069pED/750mMNU4hcVnGzdeFiJp
 xMU4mGX9Y4KNRy6GQCX7d9m0lqV004XlMqPvCWpJOcf4i9Gb2BAiZPTofqvPEGPJvLEe
 f3Lw==
X-Gm-Message-State: AOJu0YwOMRGvCEcSC8RtwGgY1sC3azYMVdTE6168pPab/FZ1C7QHyXSP
 eeR3QLGnMJm0b0BmCDiFOY3VUThX+eshgFNWFd2GG2v/SGqdz7sgs2V8JVILIgb7ZdvaMXot95l
 6AZfQ0VE=
X-Gm-Gg: Acq92OFHrq9lpjOhqHFOt510zR9EdfMlc0ZgfaT96tR8QxbMcs57Hz3kLYxNu9k0IO5
 d/34MSEQ4fVjRzDqa049EnfZiZPBu09HVl6ke4UyikFULvKOoWV7GX9P809y8jgxQ/OnuNtE3h6
 AXfm35C27P6m3/2nKLI3oKxhzoHjltqQqfGdHXvkkGuTxsXSAgLLJ4sEhQO1lYN+n36wcTOHxq0
 4KuvX+Vvu+VZrfAub0NPKDAagt/zkaz68mP03bcWBqSFzPM+7AJBqEz/vl3NP49hymSr9lT2S/3
 Ywlb8GjHlBXIUilyHlFA8JDM/RIMfP5vDrdMQ4pPli3Fk+90eB2TzYTJ8HIuIxf5ypQZ8NI90z3
 a/9l9IfYw1WJUgIziN0tjpd2M2ga+ohbxWjOOhlTAxA+gP8fjP7jWM6fd4QS7GKnuHjymcrwr5Z
 /hhktMlRF1oXBs0DSOZGBH4h+Rq7YOJ/4lSAPC
X-Received: by 2002:a17:90b:1c8d:b0:368:57db:784a with SMTP id
 98e67ed59e1d1-36951c97b01mr15286107a91.22.1779117790035; 
 Mon, 18 May 2026 08:23:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951437316sm11404311a91.11.2026.05.18.08.23.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:23:09 -0700 (PDT)
Message-ID: <47209793-4b65-4c7a-b023-71885a56931c@linaro.org>
Date: Mon, 18 May 2026 08:23:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/14] target/arm/ptw: Flip sense of
 get_phys_addr_lpae return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
>   target/arm/ptw.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


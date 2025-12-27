Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5489CE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQD2-00056t-5A; Sat, 27 Dec 2025 04:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZQD1-00056d-Ad
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:03:35 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vZQCz-0005qh-Rr
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:03:35 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b553412a19bso7395150a12.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1766826212; x=1767431012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbVQUs80GiGOCSQqQk+VysYiYqitbdlaNQWa1P/crgU=;
 b=icQ2Wl4EF1qlPXiRNNUTEM59qexZp2GrcHUCk4LKs3YGg5gfmIoM4plO12LKLJkVQ6
 Nd34i0//X3rLBgulIwATm7iRCTIudSJzndLyCzYcEepagUrkQmT9Gv/TPfUQRdXH10Zw
 A58lboKNvC5zYhIirpszmLQc7IKwq0s7O+093WXhbojr6OQqhgNN2HdRfhhVktyZ/6fH
 Jr7bB/NdGdI5hteyOp2u0dnkdk6y0qAaLk0nVQemAKcPFAbbHoEepvonvv8RqcWPyIp1
 OrAB2yVXM0PaXqOwl9jeJIOpQ+07t2CNZT7NUI5iOVOAQBrPgz5mf2qIbdpjje/K3bwD
 7oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766826212; x=1767431012;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbVQUs80GiGOCSQqQk+VysYiYqitbdlaNQWa1P/crgU=;
 b=pmfZ8OFgnvjQmhzoUgxKMdsIdJnD2oD6R7U8XsANyZwEQtfZFyjsjG9mL5v0bxZdo/
 ad2Mkc8zUS99QnqW4JR38rfJF9LfEM1tgwuJO8wiSFo41+K4T4844NneMFe8e3+LP8VV
 tMtndQn93tDhrnJiXASQm5T1F1Hm/cEJEnB0KbZU8fP1kAiHty2tgTaB4rgmXs8qqf4c
 iLmiPdQT51NHH5r0L2l+bGn6hFub+GJBpNxGJXB6qgPI6MAuPfxRQBuWanpvjSRna8JD
 0Sk8D2sMN3RPjmbkcedrQidR01YeXlPU4Gngua278RkIsdnr6G7WSr/8ICfCZquzilCA
 yNuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPwE1uLIwMNoSCvDtgrdJc0ctyLvLqxyoorE4NPpIPdBUoSzuySxXtq0t/nSNBSVpAFyzeaF2g1JYQ@nongnu.org
X-Gm-Message-State: AOJu0Yy4elgqoJOeublFReH6uPK38E1qudxQ4dWp+lQ3SUGv7G3p6ZJf
 AmfeKto5dEW44AT9F6Ru472bzGm9oxx938dUBM08dspd4o2+olMlLFb3yzZLai4VDFY=
X-Gm-Gg: AY/fxX4+djg8aHj+OVINMYqEucRGcvDqI+IhZ5gtgxTrQcC3s3yZqOp1XMdk/PuE7Gv
 SohoLXHdj2hfdrAWvfQ8w5P4+ewG7XwMj63hg4TPRjW9ocTbmgQf6lgfm2FoWar0z8tLpfw49PR
 lZCIBgTwALg88s/nquCoFhhR4H11mu38akfffuKWeZ8jjhU0UGfGrIqh0OQyOKM73Ij3vdsIc2u
 nrvL9/J35XEYsvRgcHM0S8P3Sgq2y+dH3nPrq+wvcJ0X7APr/TwpumMvkF6SXyvAUG2h835eyXA
 P+6jIl+SL63RXIkZPWYNzydiQzXcKpNHUHwQsJF/feOy8SIQzuA+7UYCkqeIhwZVyOKPGV5KCgT
 KFb2SSWyqz/5ZA0glNUIbiv6RFtyQa651gBn6nBFa5AdxasygnWCU1so12Ld8xFgm9lw7MUZVTF
 /KabaU63vIgikBq/ECmWnDpGp4taQ=
X-Google-Smtp-Source: AGHT+IE1nNZtLgh5hSGdmROCJypW3+SIGTbDKqLPHzKUtHhimw5jU01sklnkfxAhzPz84tqMR3e3gA==
X-Received: by 2002:a05:7301:430c:b0:2b0:59f3:7746 with SMTP id
 5a478bee46e88-2b05ecd7507mr16723475eec.40.1766826211845; 
 Sat, 27 Dec 2025 01:03:31 -0800 (PST)
Received: from [192.168.68.110] ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b06a046e99sm64113483eec.6.2025.12.27.01.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 01:03:31 -0800 (PST)
Message-ID: <f9cb3ad3-1279-40ac-8fff-7b09d4e411db@ventanamicro.com>
Date: Sat, 27 Dec 2025 06:03:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: fix comment declaring runtime in rv64
 interruptedmemory test
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20251227085349.23808-1-neither@nut.email>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251227085349.23808-1-neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
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



On 12/27/25 5:53 AM, Julian Ganz wrote:
> The test attempts to trigger a regression for arount 30s. However, a
> comment just before the computation of the target wall clock time falsly
> declares the run time to be around 60s.
> 
> This was the case already when we introduced the test in
> 
>      5241645c47a9987f4fcc65bab303a444966b7942
>      (tests: add test with interrupted memory accesses on rv64)
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   tests/tcg/riscv64/interruptedmemory.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
> index cd9073ee31..c154f93839 100644
> --- a/tests/tcg/riscv64/interruptedmemory.S
> +++ b/tests/tcg/riscv64/interruptedmemory.S
> @@ -25,7 +25,7 @@ _start:
>   	li	a0, 0x03	# 8N1, DLAB=0
>   	sb	a0, 3(t1)
>   
> -	# Run test for around 60s
> +	# Run test for around 30s
>   	call	rtc_get
>   	li	t0, 30
>   	slli	t0, t0, 30 # Approx. 10e9 ns



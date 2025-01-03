Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97EBE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTifq-0005PI-AU; Fri, 03 Jan 2025 09:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTifo-0005P4-7R
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:29:12 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTifm-0002pz-Ie
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:29:12 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166360285dso172587475ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914547; x=1736519347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jrJTOnWC4UqPNTzh6wuNE7sFgxXlnr3DP6aaKY7LwlA=;
 b=o79FvZZWI2/6e7tq+JTvGZ+6SBErvJNZ2JJTvzeVKQP8oFQ1C7rHv1EfHze21YtZ+H
 G+0beOSouF6tPyH1KbYqelr/5huAA521e9PEymJLXZQ4CZenw2gh3BIs6qsDtcyMeZYT
 Dr+5xSuyS8He9L4DOcEWw5sJATUC/fAAVhDnPdcSIWeO7BmwjqkJ9isYS03G1I/itmsZ
 RQJolQStbRRUjiNG2K/VJcF8cAhKko4Z+OC1coDA4rA/3NqCvEdzh7yNlaf80YyWdxWJ
 Og08btXwzgUHIg8DcqmMEgO7H/mDv00g8vasthyb5o+CGk93ZNOMR16RfT7Bkl4mTwHK
 NnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914547; x=1736519347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jrJTOnWC4UqPNTzh6wuNE7sFgxXlnr3DP6aaKY7LwlA=;
 b=MVMp5SifMDdPN+qVEigqH0Gb8IIVqWdVsMVDBoaUN+iMxmGZ5BGmdCE09db+XFrW1L
 ewMMl1441H83Txtwhlunu1JAYok6mXfYe4tvrMBu96rekUPFemcGUPXNWvFDzFHafU7k
 v1orh959xUSB63vK90YW979nJL3TCe9k/BrB/E3ceObZ+i7ozYXGtAY4HJV3MtqJH3z6
 UAg292whnV77Tsb6HIFsm89bN4vDkZqlGpVoItyl/94wbZ9UL2FoEE/henAcPyo0+EgB
 0zskwVxOwMFqkAmxY7eK/sa44BYaLbOs5DqGmzMZomPcr+e5JUkWpdXFS+li86D1bUFD
 rAWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1EuultaseBZ0q3qW5et2hTVhEBDBFrJt5td26565VC/2fBEhojOCEh4f3B3GfAFVycqKMVx4JwN1W@nongnu.org
X-Gm-Message-State: AOJu0YypDKm9JR6d+C09M24t8DN1bse7gh0OlYBF+disDvCR/ldSfhan
 to0uPR/yCeZzMXK2vwoYE3D47sEJEvCpg/sBMLuoGBI1i0WRd/9P5ZCLkCLXDwc=
X-Gm-Gg: ASbGncsyYR7qF7+qX5avZ0/uj77XmRYqJRni7/qFzueOPoBLbYwRjfgK2Hw4Z7RPt5x
 7gTL57n9a97+We/r+k2BQqaxws3Zxmrkmm1ovKFVBhzUDsyyWiOEUhXTZx7IHpBMlJ0kDhNXRcG
 jp5ZjdVvcLjTW6UNF6MQ3dPlMzeNPrNyKjWP4ia+Q/in5NfgvT2vc7edYfvdf2zxBtFS6VgbHOx
 eFZdivIa8B8Gl52o1atJwr4xaNF8PWNBd6jbclQH4KrcVbplefOD5NPTrhovK9HQprUgmA=
X-Google-Smtp-Source: AGHT+IGnSJTrWkd0+qhuergNjp7uk2wWId1IewxVg1Vtx6NuRdksjQ0jBA5RjR/qvDmgvB6wrUkyoA==
X-Received: by 2002:a17:902:d582:b0:216:282d:c68c with SMTP id
 d9443c01a7336-219e6e9dff9mr745470245ad.23.1735914546689; 
 Fri, 03 Jan 2025 06:29:06 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96e867sm246838295ad.71.2025.01.03.06.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:29:06 -0800 (PST)
Message-ID: <bc272903-3bd3-47e5-91fc-af97dd057ee3@linaro.org>
Date: Fri, 3 Jan 2025 06:29:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] qdev: Use machine_get_container()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
> From: Peter Xu<peterx@redhat.com>
> 
> Use machine_get_container() whenever applicable across the tree.
> 
> Signed-off-by: Peter Xu<peterx@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Message-ID:<20241121192202.4155849-11-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/gpio.c        | 3 +--
>   hw/core/qdev.c        | 3 +--
>   hw/core/sysbus.c      | 4 ++--
>   hw/i386/pc.c          | 4 ++--
>   system/ioport.c       | 2 +-
>   system/memory.c       | 2 +-
>   system/qdev-monitor.c | 6 +++---
>   system/vl.c           | 3 +--
>   8 files changed, 12 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


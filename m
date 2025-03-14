Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B62C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 21:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttCRs-0005SW-FN; Fri, 14 Mar 2025 17:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttCRk-0005NS-Qk
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:20:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttCRj-0001vL-8S
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:20:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-225a28a511eso45680655ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741987197; x=1742591997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yu2Q8aNlLujVd3Lo3C9nU6yR5fwPgpiI+ERbYc2waQ0=;
 b=jpEIPm9THAi0eQDhbhOdLK412yajRQ03z77qogbTc9zoWK22h6QtTksQXtXgFsoQSM
 H0fBTwSD+Tx3ptBGHP6Fi7dfhZoKFwiSVvTj7FraT/Y16t4lFSha/isaCm25wCZBN21x
 OUiA5IYLfwRxcy0IUJLFjU+MEH9or1IZ6cd5TS7k59YkV3yEPXEgY1sSg3XpCpDHRMvZ
 3sHLQ6/cqKd6UbiAT8KooQHhT5AMRRjFBqsrfYjZwWv46HXbo+FKm4/mXNeuKE+QpW5y
 wFYdteAsojcxLLAtQqbEB1hCsyWB97QL7+7qT7gicerz8Y6cA+B39rZ24njAhogkY/f2
 AFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741987197; x=1742591997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yu2Q8aNlLujVd3Lo3C9nU6yR5fwPgpiI+ERbYc2waQ0=;
 b=D3HpiaqiYrINhHOAS+WsiYcO+iJHjjv6zUSmVPgk+Mc16brcQFNLRyLV4KTUPE9ce1
 8HtXoC3+qB5tpOErL1NRHXCcKMNBORAK3SF3KZyBbgn1yhwVH4B+y7D5ZnfL+lGdSnR6
 m5/yDoiCzJLPLgNCdGvpFzGKll/8wZEmgP5a1FpOmGmK0Y2ShOeaBQwwWHN6nKSI+VUm
 zCUWjAupfJ0MXQrMGSW0AshamigZa0PBuRqMoDQISownNTn/6IfHiRYO9xNBiL3eR0yX
 JYW/7P7BhvYI8cqUaANpeT29t251gJIveKYHJUcavVdmqFvdd+IGEdImf1SlEvCj/XyD
 Dduw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHtcgnI64z/IwZcs+yi3mz7qbysrcWItUP+lhRnWaLhlJEqKGiydVkeWKO9V2dKRSHaALW22cuA6xk@nongnu.org
X-Gm-Message-State: AOJu0Yzhca9iby4dNOs3RRSLnT/rUQNLjUVF1q3JwEnpbyqrVM2KDqJ1
 +lurcbRudyJNDeIcpOr5EjHDgBsVyFoq992Anf6fLUT8kNwCMOGWS2nwCm/JO6c=
X-Gm-Gg: ASbGnctbFdBXOUNYLunF+2gMDvQMe9boBnNmxWeBQM67eSOxPSHGgpZh8hNeKgjNc4H
 BuxHnPXKefbt+mOd2SZhMvYfUINbW21AGdo+avrwgorl7P1tixZlasoe3lFn2pWSy9XjNsOAR60
 6oovz8kIIqaEMcyOByOnyn/TBJt3ZxRUwWzDsajNfMzgAx6iOrMmG9QSdspV4vEd3HJ9A/W2vRv
 fvMbwA/GNIcjXt2HwoVNo6ycf2gUB2PVr3PknnfppnnZtNRtF1o0R1nelFCyCqTyEYGqHwVsRNv
 uBQDgd/hwTzzd58IywWIrh2/UzPQMkwcoNxbEgSsR462NUE2JhN0r6eJhRPZUYOWTwihTm4vUAW
 4zQCK7uLsVl3PMoDOFZQ=
X-Google-Smtp-Source: AGHT+IF7ppecot5S6G/cFum9rHcJp/SLitOMOFniM2xLCIMuCGlKkQComlkDmFMtER1qvXD00/aSJA==
X-Received: by 2002:a05:6a21:99a1:b0:1f5:535c:82dc with SMTP id
 adf61e73a8af0-1f5c1327c96mr5322964637.42.1741987197267; 
 Fri, 14 Mar 2025 14:19:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea98dcbsm2662897a12.75.2025.03.14.14.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 14:19:56 -0700 (PDT)
Message-ID: <dfb1025c-830b-4c7e-8d77-b1948fa2c4a3@linaro.org>
Date: Fri, 14 Mar 2025 14:19:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gdbstub: Add phys_memory_rw_debug for physical memory
 access
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250314074107.992163-1-npiggin@gmail.com>
 <20250314074107.992163-2-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250314074107.992163-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/14/25 00:41, Nicholas Piggin wrote:
> Add an accessor for gdb physical memory access mode which sets the
> the .debug attribute for the MemTxAttribute, and also returns success
> to the caller.
> 
> GDB with PhyMemMode will now report failure from memory accesses outside
> valid system memory addresses, and it is also able to write to ROMs as
> GDB virtual memory access can.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   docs/devel/loads-stores.rst | 11 +++++++++++
>   include/exec/cpu-common.h   |  3 +++
>   gdbstub/system.c            |  7 +------
>   system/physmem.c            | 16 ++++++++++++++++
>   4 files changed, 31 insertions(+), 6 deletions(-)
> 

I think you might as well put this function in gdbstub/system.c
and not export (or document) it.


r~


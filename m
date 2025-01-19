Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95163C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 18:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZZiv-0004rd-Bj; Sun, 19 Jan 2025 13:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tZZiu-0004rO-8n
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 13:08:36 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tZZis-0007gf-Gz
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 13:08:36 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166f1e589cso91690675ad.3
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 10:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737310112; x=1737914912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TQpGR+TaNjjK6c3dT4bQhQ22jG+p9IsWqOSn/ko3HkU=;
 b=Cr2fxhbBBimuGdwszFgxOyohz6mZ82YBxMrG415oujcHNzDV3YLktDDxRsu50uuoD/
 QgNn4T6Sy1uPyk7hqnxnbCiP7i0oXhix96psMq+toHwlLqWJTelWKDyXftwutLjiop8B
 Tx+uJ8VcRvFsTsj6nmowI+LXpCn7dOYpEUoNX0UNWzdMFWQ700/20jUN5l4SEbXO+rPn
 VMdUoei+pW2V3S1SdBTF0KAGrphyBlC4Jd2huvAjf2BQjsqFZL9l/vBS1VOYLZYPbgLf
 Cf+k9cZUdHNEGwgqUdBGXo/gF6LGzBAceqjKOkq1CxcLHoAb5nCYFrmJeWC8H9FfBMO3
 ZomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737310112; x=1737914912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TQpGR+TaNjjK6c3dT4bQhQ22jG+p9IsWqOSn/ko3HkU=;
 b=Nx8moq4VvQaxC/fXBG0pxkAtvRQ54AeQnWAob+f6UpDgrFTehqzn3NFkiK/5xiftEJ
 99nkmXF/6jIynmRUA9sGXe0//d4nOtKoyFs/WM9GH8rezidbsb0R1Sc7ACG8nRDQbejP
 PaSx5fX5kKEDS302EbHxEMN5niQ8Fggyxt+TzLlQjgYEtazbsUcpeVLCq/LuSVQSIly/
 N0T4rbQptR7gRWrqyw6bENq+/XFpBFsEJuzePbRLwQ+JaR/Gj7K0kUdEPjfSKPO3k5DY
 g3lpANfTKPUWvIzNsMH0FFNRY6sk4Tw03XM5HyqDW4B8p8B+0efmGVypMRI3wsTZtxJZ
 tT/A==
X-Gm-Message-State: AOJu0YzYYLu/NnfBXXM5g6pzCLsYhP+ySfDbhoRSxz+mWQahxbkc/2Db
 YLCkgBwt9r4bAElDWaztwcgrAZFZ8FapXvkcJ/IyVsPGMWyu2v3Ed+JEhlvOc7c=
X-Gm-Gg: ASbGncsSxyHky6mPytrCvkicRsODXGWWRmvt/jFfGpytEA57ZkIgaADf5Cc7PrYKL4k
 VlOEuPcv+zloxybv2h6C2ilAQ9wvzQrT7WyyoAXZyPrvV5CvErjliTD3KKUSUYSfGq7ln43J8sr
 E9BP9/PRrPIqx539h+3zi+0DvpBM87Q8PDxJQEFZA15m8L84qclWFB8IrLViXIUmWF/9ogEjke7
 r5Nw5kaiNui8my5kx8fGY671BxJ6/xIc/S5neh5AbcNfLopWkFO3pVF+QK9XjRk1nmTtQN/2HSx
 ms2GrEcJKyTzjp1GqoYDA7U7RBtaagi8wb5k
X-Google-Smtp-Source: AGHT+IHKQvk0OsW30ESKfX92VXj7r+/1uAOQb6JwOPKqwXfTVDyqnDgCiTvuFq461i55lTAZM9POwA==
X-Received: by 2002:a05:6a20:2589:b0:1e0:d6ef:521a with SMTP id
 adf61e73a8af0-1eb2146127dmr16165880637.1.1737310112312; 
 Sun, 19 Jan 2025 10:08:32 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c9462sm5562502b3a.100.2025.01.19.10.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2025 10:08:31 -0800 (PST)
Message-ID: <15862b4c-4be2-4c71-a2ad-c34004230d01@linaro.org>
Date: Sun, 19 Jan 2025 10:08:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/68] tcg patch queue
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250118234930.GA448811@fedora>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250118234930.GA448811@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/18/25 15:49, Stefan Hajnoczi wrote:
> Hi Richard,
> 1. This pull request is not a signed tag. Please push a signed tag.
> 2. I can't find a key for richard.henderson@linaro.org on
>     keys.openpgp.org. Please check again and send the key fingerprint.

It is a signed tag:

$ git tag -v pull-tcg-20250117
object db1649823d4f27b924a5aa5f9e0111457accb798
type commit
tag pull-tcg-20250117
tagger Richard Henderson <richard.henderson@linaro.org> 1737137605 -0800

tcg:
   - Add TCGOP_TYPE, TCGOP_FLAGS.
   - Pass type and flags to tcg_op_supported, tcg_target_op_def.
   - Split out tcg-target-has.h and unexport from tcg.h.
   - Reorg constraint processing; constify TCGOpDef.
   - Make extract, sextract, deposit opcodes mandatory.
   - Merge ext{8,16,32}{s,u} opcodes into {s}extract.
tcg/mips: Expand bswap unconditionally
tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
tcg/riscv: Use BEXTI for single-bit extractions
tcg/sparc64: Use SRA, SRL for {s}extract_i64

disas/riscv: Guard dec->cfg dereference for host disassemble
util/cpuinfo-riscv: Detect Zbs
accel/tcg: Call tcg_tb_insert() for one-insn TBs
linux-user: Add missing /proc/cpuinfo fields for sparc
gpg: Signature made Fri 17 Jan 2025 10:19:33 AM PST
gpg:                using RSA key 7A481E78868B4DB6A85A05C064DF38E8AF7E215F
gpg:                issuer "richard.henderson@linaro.org"
gpg: Good signature from "Richard Henderson <richard.henderson@linaro.org>" [ultimate]


I don't know why one cannot search by email on keys.openpgp.org,
but you can search by the key above.


r~

